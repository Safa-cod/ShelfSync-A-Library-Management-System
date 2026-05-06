import mysql.connector

class Database:
    def __init__(self):
        try:
            self.conn = mysql.connector.connect(
                host="localhost",
                user="root",
                password="",        # XAMPP default empty
                database="shelfsync",
                port=3306
            )
            self.cursor = self.conn.cursor()
            print("✅ Connected to MySQL successfully!")

        except mysql.connector.Error as err:
            print("❌ Database connection error:", err)

    # ---------------- ADD BOOK ----------------
    def add_book(self, title, author, isbn, genre, total_qty):
        query = """
        INSERT INTO books (title, author, isbn, genre, total_qty, available_qty)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        values = (title, author, isbn, genre, total_qty, total_qty)

        self.cursor.execute(query, values)
        self.conn.commit()

    # ---------------- GET ALL BOOKS ----------------
    def get_books(self):
        self.cursor.execute("SELECT * FROM books")
        return self.cursor.fetchall()

    # ---------------- SEARCH BOOK ----------------
    def search_books(self, keyword):
        query = """
        SELECT * FROM books
        WHERE title LIKE %s OR author LIKE %s OR genre LIKE %s
        """
        values = (f"%{keyword}%", f"%{keyword}%", f"%{keyword}%")

        self.cursor.execute(query, values)
        return self.cursor.fetchall()

    # ---------------- DELETE BOOK ----------------
    def delete_book(self, book_id):
        query = "DELETE FROM books WHERE book_id=%s"
        self.cursor.execute(query, (book_id,))
        self.conn.commit()

    # ---------------- UPDATE BOOK ----------------
    def update_book(self, book_id, title, author, genre):
        query = """
        UPDATE books
        SET title=%s, author=%s, genre=%s
        WHERE book_id=%s
        """
        values = (title, author, genre, book_id)

        self.cursor.execute(query, values)
        self.conn.commit()