from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QLabel,
    QLineEdit, QPushButton, QTableWidget, QHBoxLayout
)
from PyQt6.QtCore import Qt
import sys


class FineUI(QWidget):
    def _init_(self):
        super()._init_()

        self.setWindowTitle("Fine Management - ShelfSync")
        self.resize(500, 400)

        layout = QVBoxLayout()

        # Title
        title = QLabel("Fine Management System")
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)

        # Input Fields
        self.transaction_id = QLineEdit()
        self.transaction_id.setPlaceholderText("Transaction ID")

        self.amount = QLineEdit()
        self.amount.setPlaceholderText("Fine Amount")

        # Buttons
        btn_layout = QHBoxLayout()
        self.calculate_btn = QPushButton("Calculate Fine")
        self.pay_btn = QPushButton("Mark as Paid")
        btn_layout.addWidget(self.calculate_btn)
        btn_layout.addWidget(self.pay_btn)

        # Table
        self.table = QTableWidget()

        # Add widgets to layout
        layout.addWidget(title)
        layout.addWidget(self.transaction_id)
        layout.addWidget(self.amount)
        layout.addLayout(btn_layout)
        layout.addWidget(self.table)

        self.setLayout(layout)



if _name_ == "_main_":
    app = QApplication(sys.argv)
    window = FineUI()
    window.show()
    sys.exit(app.exec())