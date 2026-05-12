"""
Library Management System - Database Module
Handles all SQLite database operations
"""

import sqlite3
import hashlib
import os
from datetime import datetime


DB_PATH = "library.db"


def get_connection():
    """Return a connection to the SQLite database."""
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row  # Access columns by name
    conn.execute("PRAGMA foreign_keys = ON")
    return conn


def hash_password(password: str) -> str:
    """SHA-256 hash a password."""
    return hashlib.sha256(password.encode()).hexdigest()


# ─────────────────────────────────────────────
#  SCHEMA INITIALISATION
# ─────────────────────────────────────────────

def init_db():
    """Create all tables and seed default admin user."""
    conn = get_connection()
    cur = conn.cursor()

    # Users / staff table
    cur.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            username    TEXT    NOT NULL UNIQUE,
            password    TEXT    NOT NULL,
            full_name   TEXT    NOT NULL,
            role        TEXT    NOT NULL DEFAULT 'librarian',  -- admin | librarian
            created_at  TEXT    NOT NULL DEFAULT (datetime('now'))
        )
    """)

    # Library members table
    cur.execute("""
        CREATE TABLE IF NOT EXISTS members (
            id              INTEGER PRIMARY KEY AUTOINCREMENT,
            member_id       TEXT    NOT NULL UNIQUE,
            full_name       TEXT    NOT NULL,
            email           TEXT,
            phone           TEXT,
            address         TEXT,
            membership_type TEXT    NOT NULL DEFAULT 'standard',  -- standard | premium | student
            status          TEXT    NOT NULL DEFAULT 'active',    -- active | inactive | suspended
            joined_date     TEXT    NOT NULL DEFAULT (date('now')),
            expiry_date     TEXT,
            notes           TEXT,
            created_at      TEXT    NOT NULL DEFAULT (datetime('now')),
            updated_at      TEXT    NOT NULL DEFAULT (datetime('now'))
        )
    """)

    # Books table (for future extension)
    cur.execute("""
        CREATE TABLE IF NOT EXISTS books (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            isbn        TEXT    UNIQUE,
            title       TEXT    NOT NULL,
            author      TEXT,
            category    TEXT,
            copies      INTEGER NOT NULL DEFAULT 1,
            available   INTEGER NOT NULL DEFAULT 1
        )
    """)

    # Seed default admin if no users exist
    cur.execute("SELECT COUNT(*) FROM users")
    if cur.fetchone()[0] == 0:
        cur.execute("""
            INSERT INTO users (username, password, full_name, role)
            VALUES (?, ?, ?, ?)
        """, ("admin", hash_password("admin123"), "System Administrator", "admin"))

    conn.commit()
    conn.close()


# ─────────────────────────────────────────────
#  AUTH FUNCTIONS
# ─────────────────────────────────────────────

def authenticate_user(username: str, password: str):
    """Return user row if credentials match, else None."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        "SELECT * FROM users WHERE username = ? AND password = ?",
        (username, hash_password(password))
    )
    user = cur.fetchone()
    conn.close()
    return dict(user) if user else None


def get_all_users():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id, username, full_name, role, created_at FROM users ORDER BY id")
    rows = [dict(r) for r in cur.fetchall()]
    conn.close()
    return rows


def add_user(username, password, full_name, role="librarian"):
    conn = get_connection()
    try:
        conn.execute(
            "INSERT INTO users (username, password, full_name, role) VALUES (?,?,?,?)",
            (username, hash_password(password), full_name, role)
        )
        conn.commit()
        return True, "User created successfully."
    except sqlite3.IntegrityError:
        return False, "Username already exists."
    finally:
        conn.close()


def change_password(user_id, new_password):
    conn = get_connection()
    conn.execute(
        "UPDATE users SET password=? WHERE id=?",
        (hash_password(new_password), user_id)
    )
    conn.commit()
    conn.close()


# ─────────────────────────────────────────────
#  MEMBER FUNCTIONS
# ─────────────────────────────────────────────

def _next_member_id():
    """Auto-generate member ID like LIB-00042."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM members")
    n = cur.fetchone()[0] + 1
    conn.close()
    return f"LIB-{n:05d}"


def get_all_members(search: str = "", status_filter: str = "all"):
    conn = get_connection()
    cur = conn.cursor()
    query = "SELECT * FROM members WHERE 1=1"
    params = []
    if search:
        query += " AND (full_name LIKE ? OR member_id LIKE ? OR email LIKE ? OR phone LIKE ?)"
        like = f"%{search}%"
        params.extend([like, like, like, like])
    if status_filter != "all":
        query += " AND status = ?"
        params.append(status_filter)
    query += " ORDER BY id DESC"
    cur.execute(query, params)
    rows = [dict(r) for r in cur.fetchall()]
    conn.close()
    return rows


def get_member_by_id(member_id: str):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM members WHERE member_id = ?", (member_id,))
    row = cur.fetchone()
    conn.close()
    return dict(row) if row else None


def add_member(full_name, email, phone, address, membership_type, expiry_date, notes):
    member_id = _next_member_id()
    conn = get_connection()
    try:
        conn.execute("""
            INSERT INTO members
                (member_id, full_name, email, phone, address, membership_type, expiry_date, notes)
            VALUES (?,?,?,?,?,?,?,?)
        """, (member_id, full_name, email, phone, address, membership_type, expiry_date, notes))
        conn.commit()
        return True, f"Member added with ID: {member_id}"
    except sqlite3.IntegrityError as e:
        return False, str(e)
    finally:
        conn.close()


def update_member(member_id, full_name, email, phone, address,
                  membership_type, status, expiry_date, notes):
    conn = get_connection()
    conn.execute("""
        UPDATE members
        SET full_name=?, email=?, phone=?, address=?,
            membership_type=?, status=?, expiry_date=?, notes=?,
            updated_at=datetime('now')
        WHERE member_id=?
    """, (full_name, email, phone, address,
          membership_type, status, expiry_date, notes, member_id))
    conn.commit()
    conn.close()
    return True, "Member updated successfully."


def delete_member(member_id: str):
    conn = get_connection()
    conn.execute("DELETE FROM members WHERE member_id=?", (member_id,))
    conn.commit()
    conn.close()
    return True, "Member deleted."


def get_member_stats():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT COUNT(*) FROM members")
    total = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM members WHERE status='active'")
    active = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM members WHERE status='inactive'")
    inactive = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM members WHERE status='suspended'")
    suspended = cur.fetchone()[0]
    conn.close()
    return {"total": total, "active": active, "inactive": inactive, "suspended": suspended}
