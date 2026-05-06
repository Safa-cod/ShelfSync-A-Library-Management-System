import sys
from PyQt6.QtWidgets import *
from PyQt6.QtGui import QFont
from PyQt6.QtCore import Qt
from Book_management_and_search_backend import Database

db = Database()

# ---------------- FRONT PAGE ----------------
class FrontPage(QWidget):
    def __init__(self, go_book, go_search):
        super().__init__()

        layout = QVBoxLayout()
        layout.setAlignment(Qt.AlignmentFlag.AlignCenter)

        self.setStyleSheet("""
        QWidget {
            background-color: #020617;
            color: white;
            font-family: Segoe UI;
        }

        QLabel#title {
            font-size: 42px;
            font-weight: bold;
            color: #38bdf8;
        }

        QLabel#sub {
            font-size: 14px;
            color: #94a3b8;
        }

        QPushButton {
            background-color: #0ea5e9;
            border-radius: 12px;
            padding: 14px;
            font-size: 15px;
            font-weight: bold;
        }

        QPushButton:hover {
            background-color: #38bdf8;
        }
        """)

        title = QLabel("📚 ShelfSync")
        title.setObjectName("title")
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)

        sub = QLabel("Smart Library Management System")
        sub.setObjectName("sub")
        sub.setAlignment(Qt.AlignmentFlag.AlignCenter)

        btn1 = QPushButton("📘 Book Management")
        btn2 = QPushButton("🔍 Search Availability")

        btn1.clicked.connect(go_book)
        btn2.clicked.connect(go_search)

        layout.addWidget(title)
        layout.addWidget(sub)
        layout.addSpacing(30)
        layout.addWidget(btn1)
        layout.addWidget(btn2)

        self.setLayout(layout)


# ---------------- BOOK PAGE ----------------
class BookPage(QWidget):
    def __init__(self, go_back):
        super().__init__()

        layout = QVBoxLayout()

        self.setStyleSheet("""
        QWidget {
            background-color: #020617;
            color: white;
        }

        QLineEdit {
            background-color: #1e293b;
            padding: 10px;
            border-radius: 10px;
            color: white;
        }

        QPushButton {
            padding: 10px;
            border-radius: 10px;
        }

        #addBtn {
            background-color: #0ea5e9;
        }

        #addBtn:hover {
            background-color: #38bdf8;
        }

        QTableWidget {
            background-color: #1e293b;
            color: white;
        }

        QHeaderView::section {
            background-color: #0ea5e9;
            color: black;
        }
        """)

        back = QPushButton("⬅ Back")
        back.clicked.connect(go_back)

        title = QLabel("📘 Book Management")
        title.setFont(QFont("Segoe UI", 18))

        self.title_input = QLineEdit()
        self.title_input.setPlaceholderText("Book Title")

        self.author_input = QLineEdit()
        self.author_input.setPlaceholderText("Author")

        self.genre_input = QLineEdit()
        self.genre_input.setPlaceholderText("Genre")

        self.qty_input = QLineEdit()
        self.qty_input.setPlaceholderText("Quantity")

        add = QPushButton("➕ Add Book")
        add.setObjectName("addBtn")
        add.clicked.connect(self.add_book)

        self.table = QTableWidget()
        self.table.setColumnCount(6)
        self.table.setHorizontalHeaderLabels(
            ["ID", "Title", "Author", "Genre", "Total", "Available"]
        )

        layout.addWidget(back)
        layout.addWidget(title)
        layout.addWidget(self.title_input)
        layout.addWidget(self.author_input)
        layout.addWidget(self.genre_input)
        layout.addWidget(self.qty_input)
        layout.addWidget(add)
        layout.addWidget(self.table)

        self.setLayout(layout)
        self.load_data()

    def load_data(self):
        data = db.get_books()
        self.table.setRowCount(0)
        for r, row in enumerate(data):
            self.table.insertRow(r)
            for c, val in enumerate(row):
                self.table.setItem(r, c, QTableWidgetItem(str(val)))

    def add_book(self):
        db.add_book(
            self.title_input.text(),
            self.author_input.text(),
            "123",
            self.genre_input.text(),
            int(self.qty_input.text())
        )
        self.load_data()


# ---------------- SEARCH PAGE ----------------
class SearchPage(QWidget):
    def __init__(self, go_back):
        super().__init__()

        layout = QVBoxLayout()

        self.setStyleSheet("""
        QWidget {
            background-color: #020617;
            color: white;
        }

        QLineEdit {
            background-color: #1e293b;
            padding: 10px;
            border-radius: 10px;
            color: white;
        }

        QTableWidget {
            background-color: #1e293b;
            color: white;
        }
        """)

        back = QPushButton("⬅ Back")
        back.clicked.connect(go_back)

        title = QLabel("🔍 Search Books")
        title.setFont(QFont("Segoe UI", 18))

        self.search = QLineEdit()
        self.search.setPlaceholderText("Search books...")
        self.search.textChanged.connect(self.search_book)

        self.table = QTableWidget()
        self.table.setColumnCount(6)
        self.table.setHorizontalHeaderLabels(
            ["ID", "Title", "Author", "Genre", "Total", "Available"]
        )

        layout.addWidget(back)
        layout.addWidget(title)
        layout.addWidget(self.search)
        layout.addWidget(self.table)

        self.setLayout(layout)

    def search_book(self):
        data = db.search_books(self.search.text())
        self.table.setRowCount(0)
        for r, row in enumerate(data):
            self.table.insertRow(r)
            for c, val in enumerate(row):
                self.table.setItem(r, c, QTableWidgetItem(str(val)))


# ---------------- MAIN WINDOW ----------------
class MainWindow(QStackedWidget):
    def __init__(self):
        super().__init__()

        # 🔥 IMPORTANT: Full app dark
        self.setStyleSheet("background-color: #020617;")

        self.front = FrontPage(self.open_book, self.open_search)
        self.book = BookPage(self.go_back)
        self.search = SearchPage(self.go_back)

        self.addWidget(self.front)
        self.addWidget(self.book)
        self.addWidget(self.search)

        self.setWindowTitle("ShelfSync Pro")
        self.resize(1100, 650)

    def open_book(self):
        self.setCurrentIndex(1)

    def open_search(self):
        self.setCurrentIndex(2)

    def go_back(self):
        self.setCurrentIndex(0)


# ---------------- RUN ----------------
app = QApplication(sys.argv)
window = MainWindow()
window.show()
sys.exit(app.exec())