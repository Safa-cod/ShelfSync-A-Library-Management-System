from PyQt6.QtWidgets import (
    QApplication, QWidget, QVBoxLayout, QLabel,
    QPushButton, QTableWidget
)
from PyQt6.QtCore import Qt
import sys


class ReportsUI(QWidget):
    def_init_(self):
        super().init()
        self.setWindowTitle("Reports - ShelfSync")
        self.resize(600, 400)

        layout = QVBoxLayout()

        #  Title
        title = QLabel("Library Reports Dashboard")
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)

        #  Buttons
        self.issued_btn = QPushButton("View Issued Books")
        self.overdue_btn = QPushButton("View Overdue Books")
        self.fine_btn = QPushButton("View Fine Reports")

        #  Table
        self.table = QTableWidget()

        #  Add widgets
        layout.addWidget(title)
        layout.addWidget(self.issued_btn)
        layout.addWidget(self.overdue_btn)
        layout.addWidget(self.fine_btn)
        layout.addWidget(self.table)

        self.setLayout(layout)


#  Run App
if_name_ == "_main_":
    app = QApplication(sys.argv)
    window = ReportsUI()
    window.show()
    sys.exit(app.exec())
