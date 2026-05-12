"""
Library Management System - Member Management Module
"""

import tkinter as tk
from tkinter import ttk, messagebox
import database as db


# ── Colour palette ───────────────────────────────────────────────────────────
BG_DARK  = "#0D1117"
BG_CARD  = "#161B22"
BG_INPUT = "#21262D"
ACCENT   = "#58A6FF"
ACCENT2  = "#1F6FEB"
TEXT_PRI = "#E6EDF3"
TEXT_SEC = "#8B949E"
SUCCESS  = "#3FB950"
ERROR    = "#F85149"
WARN     = "#E3B341"
BORDER   = "#30363D"

STATUS_COLORS = {
    "active":    SUCCESS,
    "inactive":  TEXT_SEC,
    "suspended": ERROR,
}
MEMBERSHIP_TYPES = ["standard", "premium", "student"]
STATUS_TYPES     = ["active", "inactive", "suspended"]


# ─────────────────────────────────────────────────────────────────────────────
#  Member Form Dialog  (Add / Edit)
# ─────────────────────────────────────────────────────────────────────────────

class MemberFormDialog(tk.Toplevel):
    """Modal dialog for adding or editing a member."""

    def __init__(self, parent, member=None, on_save=None):
        super().__init__(parent)
        self.member  = member   # dict if editing, None if adding
        self.on_save = on_save
        self.title("Edit Member" if member else "Add New Member")
        self.geometry("580x660")
        self.resizable(False, False)
        self.configure(bg=BG_DARK)
        self.grab_set()
        self._build()
        if member:
            self._populate(member)
        self.eval("tk::PlaceWindow . center")

    # ── Build ────────────────────────────────────────────────────────────────

    def _build(self):
        # Header
        hdr = tk.Frame(self, bg=ACCENT2, padx=24, pady=16)
        hdr.pack(fill="x")
        lbl = "✏ Edit Member" if self.member else "➕ Add New Member"
        tk.Label(hdr, text=lbl, bg=ACCENT2, fg="white",
                 font=("Georgia", 16, "bold")).pack(anchor="w")

        # Scrollable body
        body = tk.Frame(self, bg=BG_DARK, padx=28, pady=20)
        body.pack(fill="both", expand=True)

        # Grid of fields
        fields = [
            ("Full Name *",       "full_name",       "entry",    None),
            ("Email Address",     "email",            "entry",    None),
            ("Phone Number",      "phone",            "entry",    None),
            ("Address",           "address",          "text",     None),
            ("Membership Type",   "membership_type",  "combo",    MEMBERSHIP_TYPES),
            ("Expiry Date",       "expiry_date",      "entry",    None),  # YYYY-MM-DD
            ("Notes",             "notes",            "text",     None),
        ]
        if self.member:
            fields.insert(5, ("Status", "status", "combo", STATUS_TYPES))

        self.vars = {}
        for i, (label, key, widget_type, options) in enumerate(fields):
            tk.Label(body, text=label, bg=BG_DARK, fg=TEXT_SEC,
                     font=("Helvetica", 10, "bold")).grid(
                         row=i*2, column=0, sticky="w", pady=(10, 2))
            w = self._make_widget(body, key, widget_type, options)
            w.grid(row=i*2+1, column=0, sticky="ew", ipady=4)

        body.columnconfigure(0, weight=1)

        # Status message
        self.status_var = tk.StringVar()
        tk.Label(body, textvariable=self.status_var, bg=BG_DARK, fg=ERROR,
                 font=("Helvetica", 10)).grid(row=len(fields)*2+1, column=0,
                                               sticky="w", pady=(8, 0))

        # Buttons
        btn_row = tk.Frame(self, bg=BG_DARK, padx=28, pady=16)
        btn_row.pack(fill="x", side="bottom")

        tk.Button(btn_row, text="Cancel", bg=BG_CARD, fg=TEXT_SEC,
                  font=("Helvetica", 11), relief="flat", padx=20, pady=8,
                  cursor="hand2", command=self.destroy).pack(side="right", padx=(8, 0))
        tk.Button(btn_row, text="Save Member", bg=ACCENT2, fg="white",
                  font=("Helvetica", 11, "bold"), relief="flat", padx=20, pady=8,
                  cursor="hand2", activebackground=ACCENT,
                  command=self._save).pack(side="right")

    def _make_widget(self, parent, key, wtype, options):
        if wtype == "entry":
            var = tk.StringVar()
            self.vars[key] = var
            f = tk.Frame(parent, bg=BG_INPUT,
                         highlightbackground=BORDER, highlightthickness=1)
            tk.Entry(f, textvariable=var, bg=BG_INPUT, fg=TEXT_PRI,
                     insertbackground=ACCENT, relief="flat",
                     font=("Helvetica", 11)).pack(padx=10, pady=6, fill="x")
            return f

        elif wtype == "combo":
            var = tk.StringVar(value=options[0])
            self.vars[key] = var
            cb = ttk.Combobox(parent, textvariable=var, values=options,
                               state="readonly", font=("Helvetica", 11))
            self._style_combobox(cb)
            return cb

        elif wtype == "text":
            f = tk.Frame(parent, bg=BG_INPUT,
                         highlightbackground=BORDER, highlightthickness=1)
            t = tk.Text(f, bg=BG_INPUT, fg=TEXT_PRI, insertbackground=ACCENT,
                        relief="flat", font=("Helvetica", 11), height=3, wrap="word")
            t.pack(padx=10, pady=6, fill="both")
            self.vars[key] = t
            return f

    def _style_combobox(self, cb):
        style = ttk.Style()
        style.theme_use("default")
        style.configure("TCombobox",
                        fieldbackground=BG_INPUT, background=BG_INPUT,
                        foreground=TEXT_PRI, selectbackground=ACCENT2,
                        selectforeground="white")

    def _populate(self, m):
        for key, val in m.items():
            if key not in self.vars:
                continue
            w = self.vars[key]
            if isinstance(w, tk.StringVar):
                w.set(val or "")
            elif isinstance(w, tk.Text):
                w.delete("1.0", tk.END)
                w.insert("1.0", val or "")

    def _get(self, key):
        w = self.vars.get(key)
        if isinstance(w, tk.StringVar):
            return w.get().strip()
        elif isinstance(w, tk.Text):
            return w.get("1.0", tk.END).strip()
        return ""

    def _save(self):
        full_name = self._get("full_name")
        if not full_name:
            self.status_var.set("Full name is required.")
            return

        email         = self._get("email")
        phone         = self._get("phone")
        address       = self._get("address")
        m_type        = self._get("membership_type") or "standard"
        expiry        = self._get("expiry_date")
        notes         = self._get("notes")

        if self.member:
            status = self._get("status") or "active"
            ok, msg = db.update_member(
                self.member["member_id"], full_name, email, phone, address,
                m_type, status, expiry, notes
            )
        else:
            ok, msg = db.add_member(full_name, email, phone, address,
                                    m_type, expiry, notes)

        if ok:
            if self.on_save:
                self.on_save()
            self.destroy()
        else:
            self.status_var.set(f"Error: {msg}")


# ─────────────────────────────────────────────────────────────────────────────
#  Member Management Panel (embedded in main window)
# ─────────────────────────────────────────────────────────────────────────────

class MemberManagementPanel(tk.Frame):

    def __init__(self, parent, current_user):
        super().__init__(parent, bg=BG_DARK)
        self.current_user = current_user
        self._build()
        self.load_members()

    # ── Build ────────────────────────────────────────────────────────────────

    def _build(self):
        # Top bar
        top = tk.Frame(self, bg=BG_DARK, padx=24, pady=16)
        top.pack(fill="x")

        tk.Label(top, text="Member Management", bg=BG_DARK, fg=TEXT_PRI,
                 font=("Georgia", 20, "bold")).pack(side="left")

        tk.Button(top, text="+ Add Member", bg=ACCENT2, fg="white",
                  font=("Helvetica", 11, "bold"), relief="flat",
                  padx=16, pady=8, cursor="hand2",
                  activebackground=ACCENT,
                  command=self._open_add).pack(side="right")

        # Stats row
        self.stats_frame = tk.Frame(self, bg=BG_DARK, padx=24)
        self.stats_frame.pack(fill="x", pady=(0, 12))
        self.stat_labels = {}
        for key in ["total", "active", "inactive", "suspended"]:
            card = tk.Frame(self.stats_frame, bg=BG_CARD,
                            highlightbackground=BORDER, highlightthickness=1,
                            padx=20, pady=12)
            card.pack(side="left", padx=(0, 12))
            val_lbl = tk.Label(card, text="0", bg=BG_CARD, fg=ACCENT,
                               font=("Georgia", 24, "bold"))
            val_lbl.pack()
            tk.Label(card, text=key.capitalize(), bg=BG_CARD, fg=TEXT_SEC,
                     font=("Helvetica", 10)).pack()
            self.stat_labels[key] = val_lbl

        # Search / filter bar
        search_bar = tk.Frame(self, bg=BG_DARK, padx=24, pady=8)
        search_bar.pack(fill="x")

        sf = tk.Frame(search_bar, bg=BG_INPUT,
                      highlightbackground=BORDER, highlightthickness=1)
        sf.pack(side="left")
        tk.Label(sf, text="🔍", bg=BG_INPUT, fg=TEXT_SEC,
                 font=("Helvetica", 13)).pack(side="left", padx=(10, 0))
        self.search_var = tk.StringVar()
        self.search_var.trace_add("write", lambda *_: self.load_members())
        tk.Entry(sf, textvariable=self.search_var, bg=BG_INPUT, fg=TEXT_PRI,
                 insertbackground=ACCENT, relief="flat",
                 font=("Helvetica", 11), width=32).pack(
                     side="left", padx=10, pady=8)

        tk.Label(search_bar, text="Status:", bg=BG_DARK, fg=TEXT_SEC,
                 font=("Helvetica", 11)).pack(side="left", padx=(16, 6))
        self.filter_var = tk.StringVar(value="all")
        filter_cb = ttk.Combobox(search_bar, textvariable=self.filter_var,
                                 values=["all"] + STATUS_TYPES,
                                 state="readonly", width=12,
                                 font=("Helvetica", 11))
        filter_cb.pack(side="left")
        filter_cb.bind("<<ComboboxSelected>>", lambda e: self.load_members())

        # Table
        table_frame = tk.Frame(self, bg=BG_DARK, padx=24)
        table_frame.pack(fill="both", expand=True)

        cols = ("member_id", "full_name", "email", "phone",
                "membership_type", "status", "joined_date", "expiry_date")
        col_heads = ("Member ID", "Full Name", "Email", "Phone",
                     "Type", "Status", "Joined", "Expiry")
        col_widths = (100, 160, 180, 120, 80, 90, 100, 100)

        style = ttk.Style()
        style.theme_use("default")
        style.configure("Library.Treeview",
                        background=BG_CARD,
                        fieldbackground=BG_CARD,
                        foreground=TEXT_PRI,
                        font=("Helvetica", 11),
                        rowheight=34)
        style.configure("Library.Treeview.Heading",
                        background=BG_INPUT,
                        foreground=TEXT_SEC,
                        font=("Helvetica", 10, "bold"),
                        relief="flat")
        style.map("Library.Treeview",
                  background=[("selected", ACCENT2)],
                  foreground=[("selected", "white")])

        self.tree = ttk.Treeview(table_frame, columns=cols, show="headings",
                                  style="Library.Treeview")
        for col, head, w in zip(cols, col_heads, col_widths):
            self.tree.heading(col, text=head,
                              command=lambda c=col: self._sort_by(c))
            self.tree.column(col, width=w, minwidth=60)

        scroll_y = ttk.Scrollbar(table_frame, orient="vertical",
                                  command=self.tree.yview)
        scroll_x = ttk.Scrollbar(table_frame, orient="horizontal",
                                  command=self.tree.xview)
        self.tree.configure(yscrollcommand=scroll_y.set,
                            xscrollcommand=scroll_x.set)

        self.tree.pack(side="left", fill="both", expand=True)
        scroll_y.pack(side="right", fill="y")
        scroll_x.pack(side="bottom", fill="x")

        # Context / action buttons
        btn_row = tk.Frame(self, bg=BG_DARK, padx=24, pady=14)
        btn_row.pack(fill="x")

        for text, color, cmd in [
            ("✏ Edit",   ACCENT2, self._edit_selected),
            ("🗑 Delete", ERROR,   self._delete_selected),
            ("🔄 Refresh", BG_CARD, self.load_members),
        ]:
            tk.Button(btn_row, text=text, bg=color, fg="white",
                      font=("Helvetica", 11), relief="flat",
                      padx=14, pady=7, cursor="hand2",
                      activebackground=ACCENT,
                      command=cmd).pack(side="left", padx=(0, 8))

        # Row count label
        self.count_var = tk.StringVar()
        tk.Label(btn_row, textvariable=self.count_var, bg=BG_DARK, fg=TEXT_SEC,
                 font=("Helvetica", 10)).pack(side="right")

        self.tree.bind("<Double-1>", lambda e: self._edit_selected())

    # ── Data loading ─────────────────────────────────────────────────────────

    def load_members(self, *_):
        search = self.search_var.get().strip()
        status = self.filter_var.get()

        # Clear
        for row in self.tree.get_children():
            self.tree.delete(row)

        members = db.get_all_members(search, status)
        for m in members:
            tag = m["status"]
            self.tree.insert("", "end", iid=m["member_id"],
                              values=(
                                  m["member_id"], m["full_name"],
                                  m.get("email", ""), m.get("phone", ""),
                                  m["membership_type"], m["status"],
                                  m["joined_date"], m.get("expiry_date", "")
                              ), tags=(tag,))

        # Colour rows by status
        self.tree.tag_configure("active",    foreground=SUCCESS)
        self.tree.tag_configure("inactive",  foreground=TEXT_SEC)
        self.tree.tag_configure("suspended", foreground=ERROR)

        self.count_var.set(f"{len(members)} member(s) found")
        self._refresh_stats()

    def _refresh_stats(self):
        stats = db.get_member_stats()
        for key, lbl in self.stat_labels.items():
            lbl.config(text=str(stats.get(key, 0)))

    # ── CRUD actions ─────────────────────────────────────────────────────────

    def _open_add(self):
        MemberFormDialog(self, on_save=self.load_members)

    def _edit_selected(self):
        sel = self.tree.selection()
        if not sel:
            messagebox.showinfo("Select Member", "Please select a member to edit.",
                                parent=self)
            return
        member_id = sel[0]
        member = db.get_member_by_id(member_id)
        if member:
            MemberFormDialog(self, member=member, on_save=self.load_members)

    def _delete_selected(self):
        sel = self.tree.selection()
        if not sel:
            messagebox.showinfo("Select Member", "Please select a member to delete.",
                                parent=self)
            return
        member_id = sel[0]
        name = self.tree.item(member_id, "values")[1]
        if messagebox.askyesno("Confirm Delete",
                               f"Permanently delete member:\n\n{name} ({member_id})?\n\n"
                               "This cannot be undone.",
                               icon="warning", parent=self):
            db.delete_member(member_id)
            self.load_members()
            messagebox.showinfo("Deleted", f"Member {member_id} has been removed.",
                                parent=self)

    # ── Sorting ──────────────────────────────────────────────────────────────

    def _sort_by(self, col):
        data = [(self.tree.set(child, col), child)
                for child in self.tree.get_children("")]
        data.sort()
        for idx, (_, child) in enumerate(data):
            self.tree.move(child, "", idx)
