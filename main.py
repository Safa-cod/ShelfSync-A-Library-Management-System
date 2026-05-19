"""
Library Management System — Main Application Entry Point
Run: python main.py
"""

import tkinter as tk
from tkinter import ttk, messagebox
import database as db
from login_window import LoginWindow
from member_management import MemberManagementPanel


#  Colour palette
BG_DARK   = "#0D1117"
BG_CARD   = "#161B22"
BG_SIDEBAR= "#010409"
ACCENT    = "#58A6FF"
ACCENT2   = "#1F6FEB"
TEXT_PRI  = "#E6EDF3"
TEXT_SEC  = "#8B949E"
SUCCESS   = "#3FB950"
ERROR     = "#F85149"
BORDER    = "#30363D"


#  Dashboard / Home panel

class DashboardPanel(tk.Frame):
    def __init__(self, parent, user):
        super().__init__(parent, bg=BG_DARK)
        self._user = user
        self._build()

    def _build(self):
        # Welcome header
        tk.Label(self, text=f"Good day, {self._user['full_name'].split()[0]} 👋",
                 bg=BG_DARK, fg=TEXT_PRI, font=("Georgia", 22, "bold"),
                 anchor="w").pack(fill="x", padx=28, pady=(28, 4))
        tk.Label(self, text="Here's what's happening in your library today.",
                 bg=BG_DARK, fg=TEXT_SEC, font=("Helvetica", 12),
                 anchor="w").pack(fill="x", padx=28, pady=(0, 24))

        # Quick stats
        stats = db.get_member_stats()
        cards = [
            ("👥 Total Members",  stats["total"],     ACCENT),
            ("✅ Active",          stats["active"],    SUCCESS),
            ("⏸ Inactive",        stats["inactive"],  TEXT_SEC),
            ("🚫 Suspended",      stats["suspended"], ERROR),
        ]
        row = tk.Frame(self, bg=BG_DARK, padx=24)
        row.pack(fill="x")
        for title, val, color in cards:
            c = tk.Frame(row, bg=BG_CARD,
                         highlightbackground=BORDER, highlightthickness=1,
                         padx=24, pady=18)
            c.pack(side="left", padx=(0, 16))
            tk.Label(c, text=str(val), bg=BG_CARD, fg=color,
                     font=("Georgia", 30, "bold")).pack()
            tk.Label(c, text=title, bg=BG_CARD, fg=TEXT_SEC,
                     font=("Helvetica", 10)).pack()

        # Quick tips
        tip_frame = tk.Frame(self, bg=BG_CARD,
                             highlightbackground=BORDER, highlightthickness=1,
                             padx=24, pady=20)
        tip_frame.pack(fill="x", padx=28, pady=(28, 0))
        tk.Label(tip_frame, text="🚀 Quick Start", bg=BG_CARD, fg=ACCENT,
                 font=("Georgia", 14, "bold")).pack(anchor="w")
        tips = [
            "• Click Members in the sidebar to add and manage library members.",
            "• Use the search bar in Members to find members instantly.",
            "• Double-click any member row to quickly edit their details.",
            "• Members are assigned unique IDs automatically (e.g. LIB-00001).",
        ]
        for t in tips:
            tk.Label(tip_frame, text=t, bg=BG_CARD, fg=TEXT_SEC,
                     font=("Helvetica", 11), anchor="w").pack(fill="x", pady=2)


#  Main Application Window (post-login)

class MainApp:
    def __init__(self, root, user):
        self.root = root
        self.user = user
        self.active_nav = None
        self._build()

    def _build(self):
        self.root.title(f"LibraryOS — {self.user['full_name']} ({self.user['role']})")
        self.root.geometry("1200x720")
        self.root.minsize(900, 600)
        self.root.configure(bg=BG_DARK)
        self.root.eval("tk::PlaceWindow . center")

        # Sidebar
        self.sidebar = tk.Frame(self.root, bg=BG_SIDEBAR, width=220)
        self.sidebar.pack(side="left", fill="y")
        self.sidebar.pack_propagate(False)

        # Logo
        logo_frame = tk.Frame(self.sidebar, bg=BG_SIDEBAR, pady=24)
        logo_frame.pack(fill="x")
        tk.Label(logo_frame, text="📚", bg=BG_SIDEBAR,
                 font=("Helvetica", 26)).pack()
        tk.Label(logo_frame, text="LibraryOS", bg=BG_SIDEBAR, fg=TEXT_PRI,
                 font=("Georgia", 14, "bold")).pack()
        tk.Label(logo_frame, text="Management System", bg=BG_SIDEBAR,
                 fg=TEXT_SEC, font=("Helvetica", 8)).pack()

        ttk.Separator(self.sidebar, orient="horizontal").pack(fill="x",
                                                               padx=12, pady=8)

        # Nav items
        nav_items = [
            ("🏠", "Dashboard",  self._show_dashboard),
            ("👥", "Members",    self._show_members),
        ]
        self.nav_buttons = {}
        for icon, label, cmd in nav_items:
            btn = tk.Button(self.sidebar, text=f"  {icon}  {label}",
                            bg=BG_SIDEBAR, fg=TEXT_SEC,
                            font=("Helvetica", 12), anchor="w",
                            relief="flat", padx=16, pady=12,
                            cursor="hand2", activebackground=BG_CARD,
                            command=cmd)
            btn.pack(fill="x")
            self.nav_buttons[label] = btn

        # Spacer + user info at bottom
        tk.Frame(self.sidebar, bg=BG_SIDEBAR).pack(fill="both", expand=True)
        ttk.Separator(self.sidebar, orient="horizontal").pack(fill="x",
                                                               padx=12, pady=8)
        user_frame = tk.Frame(self.sidebar, bg=BG_SIDEBAR, padx=14, pady=12)
        user_frame.pack(fill="x")
        tk.Label(user_frame, text=self.user["full_name"][:22],
                 bg=BG_SIDEBAR, fg=TEXT_PRI,
                 font=("Helvetica", 10, "bold")).pack(anchor="w")
        tk.Label(user_frame, text=self.user["role"].capitalize(),
                 bg=BG_SIDEBAR, fg=TEXT_SEC,
                 font=("Helvetica", 9)).pack(anchor="w")
        tk.Button(user_frame, text="⏻ Sign Out", bg=BG_SIDEBAR, fg=ERROR,
                  font=("Helvetica", 9), relief="flat", cursor="hand2",
                  command=self._sign_out).pack(anchor="w", pady=(6, 0))

        # Content area
        self.content = tk.Frame(self.root, bg=BG_DARK)
        self.content.pack(side="right", fill="both", expand=True)

        # Start on dashboard
        self._show_dashboard()

    def _clear_content(self):
        for w in self.content.winfo_children():
            w.destroy()

    def _set_active_nav(self, label):
        for name, btn in self.nav_buttons.items():
            if name == label:
                btn.config(bg=BG_CARD, fg=ACCENT)
            else:
                btn.config(bg=BG_SIDEBAR, fg=TEXT_SEC)

    def _show_dashboard(self):
        self._clear_content()
        self._set_active_nav("Dashboard")
        DashboardPanel(self.content, self.user).pack(fill="both", expand=True)

    def _show_members(self):
        self._clear_content()
        self._set_active_nav("Members")
        MemberManagementPanel(self.content, self.user).pack(fill="both", expand=True)

    def _sign_out(self):
        if messagebox.askyesno("Sign Out", "Sign out of LibraryOS?",
                               parent=self.root):
            self.root.destroy()
            _launch()


#  Boot

def _launch():
    root = tk.Tk()

    def on_login_success(user):
        # Destroy login widgets, rebuild for main app
        for w in root.winfo_children():
            w.destroy()
        MainApp(root, user)

    LoginWindow(root, on_success=on_login_success)
    root.mainloop()


if __name__ == "__main__":
    db.init_db()
    _launch()
