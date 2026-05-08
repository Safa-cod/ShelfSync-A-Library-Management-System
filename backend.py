import mysql.connector
from datetime import date, datetime


def connect():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="shelfsync"
    )


def run(query, values=(), fetch=False):
    conn = connect()
    cur = conn.cursor()
    cur.execute(query, values)

    data = cur.fetchall() if fetch else None

    conn.commit()
    cur.close()
    conn.close()
    return data


# ---------------- ISSUE BOOK ----------------
def issue_book(member_id, book_id, due_date):

    book = run(
        "SELECT available_qty FROM books WHERE book_id=%s",
        (book_id,),
        True
    )

    if not book:
        return "Book not found"

    if book[0][0] <= 0:
        return "Not available"

    run("""
        INSERT INTO transactions
        (member_id, book_id, issue_date, due_date, status)
        VALUES (%s,%s,%s,%s,'Issued')
    """, (member_id, book_id, date.today(), due_date))

    run("""
        UPDATE books
        SET available_qty = available_qty - 1
        WHERE book_id=%s
    """, (book_id,))

    return "Book Issued Successfully"


# ---------------- RETURN BOOK ----------------
def return_book(transaction_id):

    data = run(
        "SELECT book_id FROM transactions WHERE transaction_id=%s",
        (transaction_id,),
        True
    )

    if not data:
        return "Transaction not found"

    book_id = data[0][0]

    run("""
        UPDATE transactions
        SET return_date=%s, status='Returned'
        WHERE transaction_id=%s
    """, (date.today(), transaction_id))

    run("""
        UPDATE books
        SET available_qty = available_qty + 1
        WHERE book_id=%s
    """, (book_id,))

    return "Returned Successfully"


# ---------------- HISTORY ----------------
def get_transactions():
    return run("SELECT * FROM transactions", fetch=True)