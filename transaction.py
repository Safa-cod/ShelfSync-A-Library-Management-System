from PyQt6.QtWidgets import QApplication, QWidget, QVBoxLayout, QLabel, QLineEdit, QPushButton, QTableWidget
from PyQt6.QtCore import Qt
import sys

class TransactionUI(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Transaction UI")
        self.resize(500, 400)

        layout = QVBoxLayout()

        title = QLabel("Issue / Return Book")
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)

        self.member = QLineEdit()
        self.member.setPlaceholderText("Member ID")

        self.book = QLineEdit()
        self.book.setPlaceholderText("Book ID")

        self.issue_btn = QPushButton("Issue")
        self.return_btn = QPushButton("Return")
        self.clear_btn = QPushButton("Clear")

        self.table = QTableWidget()

        layout.addWidget(title)
        layout.addWidget(self.member)
        layout.addWidget(self.book)
        layout.addWidget(self.issue_btn)
        layout.addWidget(self.return_btn)
        layout.addWidget(self.clear_btn)
        layout.addWidget(self.table)

        self.setLayout(layout)

        self.clear_btn.clicked.connect(self.clear_data)

    def clear_data(self):
        self.member.clear()
        self.book.clear()

app = QApplication(sys.argv)
window = TransactionUI()
window.show()
sys.exit(app.exec())