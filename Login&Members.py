import PyQt6.QtWidgets
from PyQt6.QtCore import Qt # type: ignore
import sys


class LoginUI(PyQt6.QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("ShelfSync Login")
        self.resize(300, 200)

        layout = PyQt6.QtWidgets.QVBoxLayout()

        title = PyQt6.QtWidgets.QLabel("Login")
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)

        self.username = PyQt6.QtWidgets.QLineEdit()
        self.username.setPlaceholderText("Username")

        self.password = PyQt6.QtWidgets.QLineEdit()
        self.password.setPlaceholderText("Password")
        self.password.setEchoMode(PyQt6.QtWidgets.QLineEdit.EchoMode.Password)

        self.login_btn = PyQt6.QtWidgets.QPushButton("Login")

        layout.addWidget(title)
        layout.addWidget(self.username)
        layout.addWidget(self.password)
        layout.addWidget(self.login_btn)

        self.setLayout(layout)


class MemberUI(PyQt6.QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Member Management - ShelfSync")
        self.resize(500, 400)

        layout = PyQt6.QtWidgets.QVBoxLayout()

        title = PyQt6.QtWidgets.QLabel("Member Management")
        title.setAlignment(Qt.AlignmentFlag.AlignCenter)

        self.name = PyQt6.QtWidgets.QLineEdit()
        self.name.setPlaceholderText("Member Name")

        self.email = PyQt6.QtWidgets.QLineEdit()
        self.email.setPlaceholderText("Email")

        self.phone = PyQt6.QtWidgets.QLineEdit()
        self.phone.setPlaceholderText("Phone")

        btn_layout = PyQt6.QtWidgets.QHBoxLayout()

        self.add_btn = PyQt6.QtWidgets.QPushButton("Add Member")
        self.update_btn = PyQt6.QtWidgets.QPushButton("Update")
        self.delete_btn = PyQt6.QtWidgets.QPushButton("Delete")

        btn_layout.addWidget(self.add_btn)
        btn_layout.addWidget(self.update_btn)
        btn_layout.addWidget(self.delete_btn)

        self.table = PyQt6.QtWidgets.QTableWidget()

        layout.addWidget(title)
        layout.addWidget(self.name)
        layout.addWidget(self.email)
        layout.addWidget(self.phone)
        layout.addLayout(btn_layout)
        layout.addWidget(self.table)

        self.setLayout(layout)


class MainApp(PyQt6.QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Tawhid Frontend - ShelfSync")
        self.resize(600, 500)

        layout = PyQt6.QtWidgets.QVBoxLayout()

        self.tabs = PyQt6.QtWidgets.QTabWidget()

        self.login_tab = LoginUI()
        self.member_tab = MemberUI()

        self.tabs.addTab(self.login_tab, "Login")
        self.tabs.addTab(self.member_tab, "Members")

        layout.addWidget(self.tabs)
        self.setLayout(layout)


if __name__ == "__main__":
    app = PyQt6.QtWidgets.QApplication(sys.argv)
    window = MainApp()
    window.show()
    sys.exit(app.exec())
