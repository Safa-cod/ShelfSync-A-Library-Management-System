"""
Library Management System - Login Window
"""

import tkinter as tk
from tkinter import ttk, messagebox
import database as db


# ── Colour palette ──────────────────────────────────────────────────────────
BG_DARK   = "#0D1117"
BG_CARD   = "#161B22"
BG_INPUT  = "#21262D"
ACCENT    = "#58A6FF"
ACCENT2   = "#1F6FEB"
TEXT_PRI  = "#E6EDF3"
TEXT_SEC  = "#8B949E"
SUCCESS   = "#3FB950"
ERROR     = "#F85149"
BORDER    = "#30363D"


def _hex_to_rgb(hex_color):
    h = hex_color.lstrip("#")
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))


def _lerp_color(c1, c2, t):
    r = int(c1[0] + (c2[0] - c1[0]) * t)
    g = int(c1[1] + (c2[1] - c1[1]) * t)
    b = int(c1[2] + (c2[2] - c1[2]) * t)
    return f"#{r:02x}{g:02x}{b:02x}"


class LoginWindow:
    def __init__(self, root, on_success):
        self.root = root
        self.on_success = on_success  # callback(user_dict)
        self.attempts = 0
        self._build_ui()

    # ── UI construction ──────────────────────────────────────────────────────

    def _build_ui(self):
        self.root.title("LibraryOS — Sign In")
        self.root.geometry("960x600")
        self.root.resizable(False, False)
        self.root.configure(bg=BG_DARK)
        self.root.eval("tk::PlaceWindow . center")

        # Left hero panel
        hero = tk.Frame(self.root, bg="#0A1628", width=420)
        hero.pack(side="left", fill="both")
        hero.pack_propagate(False)
        self._draw_hero(hero)

        # Right form panel
        form_wrap = tk.Frame(self.root, bg=BG_DARK)
        form_wrap.pack(side="right", fill="both", expand=True)
        self._draw_form(form_wrap)

    def _draw_hero(self, parent):
        # Gradient strips for visual flair
        canvas = tk.Canvas(parent, width=420, height=600,
                           highlightthickness=0, bg="#0A1628")
        canvas.pack(fill="both", expand=True)

        c1 = _hex_to_rgb("#0A1628")
        c2 = _hex_to_rgb("#112240")
        for i in range(300):
            color = _lerp_color(c1, c2, i / 300)
            canvas.create_line(0, i*2, 420, i*2, fill=color)

        # Decorative circles
        canvas.create_oval(320, -60, 530, 150, fill="#1F6FEB", outline="")
        canvas.create_oval(-80, 440, 160, 680, fill="#1F6FEB", outline="")
        canvas.create_oval(280, 50, 480, 250, fill="#0A1628", outline="")
        canvas.create_oval(-40, 480, 120, 640, fill="#0A1628", outline="")

        # Book icon (simple SVG-style drawn)
        bx, by = 140, 200
        canvas.create_rectangle(bx, by, bx+130, by+160,
                                 fill="#1F6FEB", outline="")
        canvas.create_rectangle(bx+10, by+10, bx+120, by+150,
                                 fill="#0A1628", outline="")
        canvas.create_line(bx+65, by+10, bx+65, by+150,
                            fill="#1F6FEB", width=3)
        for line_y in [by+35, by+60, by+85, by+110]:
            canvas.create_line(bx+20, line_y, bx+58, line_y,
                                fill="#8B949E", width=2)
            canvas.create_line(bx+72, line_y, bx+110, line_y,
                                fill="#8B949E", width=2)

        canvas.create_text(210, 400, text="LibraryOS",
                           fill=TEXT_PRI, font=("Georgia", 28, "bold"))
        canvas.create_text(210, 435, text="Integrated Library Management",
                           fill=TEXT_SEC, font=("Helvetica", 11))
        canvas.create_text(210, 460, text="Version 1.0",
                           fill=TEXT_SEC, font=("Helvetica", 9))

    def _draw_form(self, parent):
        # Centre card
        card = tk.Frame(parent, bg=BG_CARD, padx=50, pady=50,
                        highlightbackground=BORDER, highlightthickness=1)
        card.place(relx=0.5, rely=0.5, anchor="center")

        tk.Label(card, text="Welcome back", bg=BG_CARD, fg=ACCENT,
                 font=("Georgia", 22, "bold")).pack(anchor="w")
        tk.Label(card, text="Sign in to your account",
                 bg=BG_CARD, fg=TEXT_SEC,
                 font=("Helvetica", 11)).pack(anchor="w", pady=(4, 24))

        # Username
        self._field_label(card, "Username")
        self.username_var = tk.StringVar()
        self.user_entry = self._entry(card, self.username_var, "Enter username")
        self.user_entry.pack(fill="x", pady=(4, 14))

        # Password
        self._field_label(card, "Password")
        self.password_var = tk.StringVar()
        self.pass_entry = self._entry(card, self.password_var, "Enter password",
                                      show="•")
        self.pass_entry.pack(fill="x", pady=(4, 6))

        # Show password toggle
        self.show_pass = tk.BooleanVar()
        chk = tk.Checkbutton(card, text="Show password",
                              variable=self.show_pass, bg=BG_CARD, fg=TEXT_SEC,
                              selectcolor=BG_INPUT, activebackground=BG_CARD,
                              activeforeground=TEXT_SEC,
                              command=self._toggle_pass,
                              font=("Helvetica", 9), cursor="hand2")
        chk.pack(anchor="w", pady=(0, 20))

        # Status label
        self.status_var = tk.StringVar()
        self.status_lbl = tk.Label(card, textvariable=self.status_var,
                                   bg=BG_CARD, fg=ERROR,
                                   font=("Helvetica", 10), wraplength=320)
        self.status_lbl.pack(pady=(0, 10))

        # Login button
        self.login_btn = tk.Button(
            card, text="Sign In →", bg=ACCENT2, fg="white",
            font=("Helvetica", 12, "bold"), relief="flat",
            padx=20, pady=10, cursor="hand2",
            activebackground=ACCENT, activeforeground="white",
            command=self._do_login
        )
        self.login_btn.pack(fill="x")

        # Hint
        tk.Label(card, text="Default: admin / admin123",
                 bg=BG_CARD, fg=TEXT_SEC,
                 font=("Helvetica", 8)).pack(pady=(16, 0))

        # Bind Enter key
        self.root.bind("<Return>", lambda e: self._do_login())

    def _field_label(self, parent, text):
        tk.Label(parent, text=text, bg=BG_CARD, fg=TEXT_SEC,
                 font=("Helvetica", 10, "bold")).pack(anchor="w")

    def _entry(self, parent, var, placeholder, show=None):
        frame = tk.Frame(parent, bg=BG_INPUT,
                         highlightbackground=BORDER, highlightthickness=1)
        kw = dict(textvariable=var, bg=BG_INPUT, fg=TEXT_PRI,
                  insertbackground=ACCENT, relief="flat",
                  font=("Helvetica", 12), width=30)
        if show:
            kw["show"] = show
        entry = tk.Entry(frame, **kw)
        entry.pack(padx=12, pady=10, fill="x")
        # Placeholder
        if placeholder:
            entry.insert(0, placeholder)
            entry.config(fg=TEXT_SEC)
            def on_focus_in(e):
                if entry.get() == placeholder:
                    entry.delete(0, tk.END)
                    entry.config(fg=TEXT_PRI)
            def on_focus_out(e):
                if not entry.get():
                    entry.insert(0, placeholder)
                    entry.config(fg=TEXT_SEC)
            entry.bind("<FocusIn>", on_focus_in)
            entry.bind("<FocusOut>", on_focus_out)
        # Hover effect
        entry.bind("<Enter>",
                   lambda e: frame.config(highlightbackground=ACCENT))
        entry.bind("<Leave>",
                   lambda e: frame.config(highlightbackground=BORDER))
        return frame

    # ── Callbacks ────────────────────────────────────────────────────────────

    def _toggle_pass(self):
        inner = self.pass_entry.winfo_children()[0]
        inner.config(show="" if self.show_pass.get() else "•")

    def _do_login(self):
        u = self.user_entry.winfo_children()[0].get().strip()
        p = self.pass_entry.winfo_children()[0].get().strip()

        if not u or u == "Enter username":
            self.status_var.set("⚠ Please enter your username.")
            return
        if not p or p == "Enter password":
            self.status_var.set("⚠ Please enter your password.")
            return

        self.login_btn.config(text="Signing in…", state="disabled")
        self.root.after(600, lambda: self._verify(u, p))

    def _verify(self, username, password):
        user = db.authenticate_user(username, password)
        if user:
            self.status_var.set("")
            self.on_success(user)
        else:
            self.attempts += 1
            remaining = 5 - self.attempts
            if remaining <= 0:
                self.status_var.set("Too many failed attempts. Restart the application.")
                self.login_btn.config(text="Locked", state="disabled")
            else:
                self.status_var.set(
                    f"✗ Invalid credentials. {remaining} attempt(s) remaining.")
                self.login_btn.config(text="Sign In →", state="normal")
