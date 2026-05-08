import sys
from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout,
    QLabel, QLineEdit, QPushButton,
    QMessageBox, QTabWidget, QTableWidget,
    QTableWidgetItem
)

from backend import issue_book, return_book, get_transactions


class ShelfSyncUI(QWidget):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("ShelfSync Library System")
        self.setGeometry(250, 120, 800, 500)

        # 🔵 Blue gradient background feel
        self.setStyleSheet("""
            QWidget {
                background-color: #1e3799;
                color: white;
                font-family: Arial;
            }
        """)

        self.ui()

    def ui(self):
        layout = QVBoxLayout()

        # ===== TITLE =====
        title = QLabel("📚 ShelfSync Library Management")
        title.setStyleSheet("""
            font-size: 22px;
            font-weight: bold;
            padding: 10px;
            color: white;
        """)
        layout.addWidget(title)

        # ===== TABS =====
        tabs = QTabWidget()
        tabs.setStyleSheet("""
            QTabWidget::pane {
                border: 1px solid #74b9ff;
                background: white;
                border-radius: 10px;
            }

            QTabBar::tab {
                background: #74b9ff;
                color: white;
                padding: 10px;
                border-radius: 8px;
                margin: 3px;
            }

            QTabBar::tab:selected {
                background: #00a8ff;
                font-weight: bold;
            }
        """)

        tabs.addTab(self.issue_tab(), "Issue Book")
        tabs.addTab(self.return_tab(), "Return Book")
        tabs.addTab(self.history_tab(), "History")

        layout.addWidget(tabs)
        self.setLayout(layout)

    # ================= ISSUE TAB =================
    def issue_tab(self):
        w = QWidget()
        l = QVBoxLayout()

        self.member_id = QLineEdit()
        self.book_id = QLineEdit()
        self.due_date = QLineEdit()

        self.member_id.setPlaceholderText("Member ID")
        self.book_id.setPlaceholderText("Book ID")
        self.due_date.setPlaceholderText("YYYY-MM-DD")

        style = """
            QLineEdit {
                padding: 8px;
                border-radius: 8px;
                border: 1px solid #74b9ff;
                background-color: white;
                color: black;
            }
        """

        self.member_id.setStyleSheet(style)
        self.book_id.setStyleSheet(style)
        self.due_date.setStyleSheet(style)

        btn = QPushButton("Issue Book")
        btn.setStyleSheet("""
            QPushButton {
                background-color: #00cec9;
                color: white;
                padding: 10px;
                border-radius: 8px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #00b894;
            }
        """)
        btn.clicked.connect(self.issue)

        l.addWidget(self.member_id)
        l.addWidget(self.book_id)
        l.addWidget(self.due_date)
        l.addWidget(btn)

        w.setLayout(l)
        return w

    def issue(self):
        msg = issue_book(
            self.member_id.text(),
            self.book_id.text(),
            self.due_date.text()
        )
        QMessageBox.information(self, "Result", msg)
        self.load()

    # ================= RETURN TAB =================
    def return_tab(self):
        w = QWidget()
        l = QVBoxLayout()

        self.txn_id = QLineEdit()
        self.txn_id.setPlaceholderText("Transaction ID")

        self.txn_id.setStyleSheet("""
            QLineEdit {
                padding: 8px;
                border-radius: 8px;
                border: 1px solid #ff7675;
                background-color: white;
                color: black;
            }
        """)

        btn = QPushButton("Return Book")
        btn.setStyleSheet("""
            QPushButton {
                background-color: #e55039;
                color: white;
                padding: 10px;
                border-radius: 8px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #c0392b;
            }
        """)
        btn.clicked.connect(self.return_book_ui)

        l.addWidget(self.txn_id)
        l.addWidget(btn)

        w.setLayout(l)
        return w

    def return_book_ui(self):
        msg = return_book(self.txn_id.text())
        QMessageBox.information(self, "Result", msg)
        self.load()

    # ================= HISTORY TAB =================
    def history_tab(self):
        w = QWidget()
        l = QVBoxLayout()

        self.table = QTableWidget()
        self.table.setColumnCount(7)

        self.table.setStyleSheet("""
            QTableWidget {
                background-color: white;
                color: black;
                border-radius: 8px;
            }
        """)

        btn = QPushButton("Load History")
        btn.setStyleSheet("""
            QPushButton {
                background-color: #0984e3;
                color: white;
                padding: 8px;
                border-radius: 8px;
                font-weight: bold;
            }
        """)
        btn.clicked.connect(self.load)

        l.addWidget(self.table)
        l.addWidget(btn)

        w.setLayout(l)
        return w

    def load(self):
        data = get_transactions()
        self.table.setRowCount(len(data))

        for i, row in enumerate(data):
            for j, val in enumerate(row):
                self.table.setItem(i, j, QTableWidgetItem(str(val)))


app = QApplication(sys.argv)
window = ShelfSyncUI()
window.show()
sys.exit(app.exec())