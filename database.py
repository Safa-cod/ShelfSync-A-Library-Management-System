"""
Library Management System - Database Module
MySQL version — connects to XAMPP / phpMyAdmin
"""

import hashlib
import mysql.connector
from mysql.connector import Error


# ── Connection settings ───────────────────────────────────────────────────────
# Change these to match your XAMPP setup (host/port are usually fine as-is)
DB_CONFIG = {
    "host":     "localhost",
    "port":     3306,
    "user":     "root",        
    "password": "",            
    "database": "library_db",
}


def get_connection():
    """Return a live MySQL connection."""
    return mysql.connector.connect(**DB_CONFIG)


def hash_password(password: str) -> str:
    """SHA-256 hash a password."""
    return hashlib.sha256(password.encode()).hexdigest()


# ── Schema init (run once at startup) ────────────────────────────────────────
def init_db():
    """
    Called by main.py at startup.
    With MySQL/XAMPP the tables already exist (imported via SQL file),
    so this function just verifies the connection and seeds admin if missing.
    """
    try:
        conn = get_connection()
        cur = conn.cursor()

        # Seed default admin if not present
        cur.execute("SELECT COUNT(*) FROM users")
        if cur.fetchone()[0] == 0:
            cur.execute(
                "INSERT INTO users (username, password, full_name, role) VALUES (%s,%s,%s,%s)",
                ("admin", hash_password("admin123"), "System Administrator", "admin")
            )
            conn.commit()

        cur.close()
        conn.close()
        print("✅ Connected to MySQL database successfully.")
    except Error as e:
        print(f"❌ MySQL connection error: {e}")
        raise


# ── AUTH ──────────────────────────────────────────────────────────────────────
def authenticate_user(username: str, password: str):
    """Return user dict if credentials match, else None."""
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    cur.execute(
        "SELECT * FROM users WHERE username = %s AND password = %s",
        (username, hash_password(password))
    )
    user = cur.fetchone()
    cur.close()
    conn.close()
    return user


def get_all_users():
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    cur.execute("SELECT id, username, full_name, role, created_at FROM users ORDER BY id")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows


def add_user(username, password, full_name, role="librarian"):
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute(
            "INSERT INTO users (username, password, full_name, role) VALUES (%s,%s,%s,%s)",
            (username, hash_password(password), full_name, role)
        )
        conn.commit()
        return True, "User created successfully."
    except Error as e:
        if e.errno == 1062:   # Duplicate entry
            return False, "Username already exists."
        return False, str(e)
    finally:
        cur.close()
        conn.close()


def change_password(user_id, new_password):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        "UPDATE users SET password=%s WHERE id=%s",
        (hash_password(new_password), user_id)
    )
    conn.commit()
    cur.close()
    conn.close()


# ── MEMBERS ───────────────────────────────────────────────────────────────────
def _next_member_id():
    """Generate a unique member ID like LIB-00042."""
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT COALESCE(MAX(id), 0) + 1 FROM members")
    n = cur.fetchone()[0]
    cur.close()
    conn.close()
    return f"LIB-{n:05d}"


def get_all_members(search: str = "", status_filter: str = "all"):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)

    query = "SELECT * FROM members WHERE 1=1"
    params = []

    if search:
        query += " AND (full_name LIKE %s OR member_id LIKE %s OR email LIKE %s OR phone LIKE %s)"
        like = f"%{search}%"
        params.extend([like, like, like, like])

    if status_filter != "all":
        query += " AND status = %s"
        params.append(status_filter)

    query += " ORDER BY id DESC"
    cur.execute(query, params)
    rows = cur.fetchall()

    # Convert date objects to strings so the rest of the app works unchanged
    for row in rows:
        for key in ("joined_date", "expiry_date", "created_at", "updated_at"):
            if row.get(key) and not isinstance(row[key], str):
                row[key] = str(row[key])

    cur.close()
    conn.close()
    return rows


def get_member_by_id(member_id: str):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    cur.execute("SELECT * FROM members WHERE member_id = %s", (member_id,))
    row = cur.fetchone()
    cur.close()
    conn.close()
    if row:
        for key in ("joined_date", "expiry_date", "created_at", "updated_at"):
            if row.get(key) and not isinstance(row[key], str):
                row[key] = str(row[key])
    return row


def add_member(full_name, email, phone, address, membership_type, expiry_date, notes):
    member_id = _next_member_id()
    conn = get_connection()
    cur = conn.cursor()
    try:
        cur.execute("""
            INSERT INTO members
                (member_id, full_name, email, phone, address, membership_type, expiry_date, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (member_id, full_name, email, phone, address,
              membership_type, expiry_date or None, notes))
        conn.commit()
        return True, f"Member added with ID: {member_id}"
    except Error as e:
        return False, str(e)
    finally:
        cur.close()
        conn.close()


def update_member(member_id, full_name, email, phone, address,
                  membership_type, status, expiry_date, notes):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""
        UPDATE members
        SET full_name=%s, email=%s, phone=%s, address=%s,
            membership_type=%s, status=%s, expiry_date=%s, notes=%s
        WHERE member_id=%s
    """, (full_name, email, phone, address,
          membership_type, status, expiry_date or None, notes, member_id))
    conn.commit()
    cur.close()
    conn.close()
    return True, "Member updated successfully."


def delete_member(member_id: str):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM members WHERE member_id=%s", (member_id,))
    conn.commit()
    cur.close()
    conn.close()
    return True, "Member deleted."


def get_member_stats():
    conn = get_connection()
    cur = conn.cursor()
    stats = {}
    for key, condition in [
        ("total",     "1=1"),
        ("active",    "status='active'"),
        ("inactive",  "status='inactive'"),
        ("suspended", "status='suspended'"),
    ]:
        cur.execute(f"SELECT COUNT(*) FROM members WHERE {condition}")
        stats[key] = cur.fetchone()[0]
    cur.close()
    conn.close()
    return stats
