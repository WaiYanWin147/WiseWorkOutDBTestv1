"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import AdminSidebar from "../components/AdminSidebar";

export default function AdminUsersPage() {
  const router = useRouter();
  const [allowed, setAllowed] = useState(false);

  const [tierFilter, setTierFilter] = useState("All Tier");
  const [statusFilter, setStatusFilter] = useState("All Status");
  const [searchKeyword, setSearchKeyword] = useState("");

  const users = [
    {
      id: "1044",
      name: "Wade Warren",
      email: "example123@gmail.com",
      tier: "Free",
      status: "Active",
    },
    {
      id: "1045",
      name: "Anna Tan",
      email: "anna@gmail.com",
      tier: "Free",
      status: "Active",
    },
    {
      id: "1046",
      name: "Becky Winsons",
      email: "becky@gmail.com",
      tier: "Free",
      status: "Suspended",
    },
    {
      id: "1047",
      name: "Alissa Mackie",
      email: "alissa@gmail.com",
      tier: "Free",
      status: "Active",
    },
    {
      id: "1048",
      name: "Daniel Lee",
      email: "daniel@gmail.com",
      tier: "Priority",
      status: "Active",
    },
    {
      id: "1049",
      name: "Sophia Lim",
      email: "sophia@gmail.com",
      tier: "Priority",
      status: "Active",
    },
    {
      id: "1050",
      name: "Jason Wong",
      email: "jason@gmail.com",
      tier: "Priority",
      status: "Active",
    },
    {
      id: "1051",
      name: "Anna Tan",
      email: "anna2@gmail.com",
      tier: "Free",
      status: "Active",
    },
    {
      id: "1052",
      name: "Becky Tan",
      email: "beckytan@gmail.com",
      tier: "Priority",
      status: "Suspended",
    },
  ];

  const filteredUsers = users.filter((user) => {
    const matchTier = tierFilter === "All Tier" || user.tier === tierFilter;
    const matchStatus =
      statusFilter === "All Status" || user.status === statusFilter;

    const keyword = searchKeyword.toLowerCase();

    const matchSearch =
      user.id.toLowerCase().includes(keyword) ||
      user.name.toLowerCase().includes(keyword) ||
      user.email.toLowerCase().includes(keyword);

    return matchTier && matchStatus && matchSearch;
  });

  useEffect(() => {
    const isAdminLoggedIn = localStorage.getItem("adminLoggedIn");

    if (isAdminLoggedIn !== "true") {
      router.replace("/admin/login");
    } else {
      setAllowed(true);
    }
  }, [router]);

  if (!allowed) {
    return null;
  }

  return (
    <main style={styles.page}>
      <AdminSidebar />

      <section style={styles.content}>
        <div style={styles.tableCard}>
          <div style={styles.topRow}>
            <h2 style={styles.title}>
              Users <span style={styles.count}>(1,135)</span>
            </h2>

            <div style={styles.filters}>
              <select
                style={styles.select}
                value={tierFilter}
                onChange={(e) => setTierFilter(e.target.value)}
              >
                <option>All Tier</option>
                <option>Free</option>
                <option>Priority</option>
              </select>

              <select
                style={styles.select}
                value={statusFilter}
                onChange={(e) => setStatusFilter(e.target.value)}
              >
                <option>All Status</option>
                <option>Active</option>
                <option>Suspended</option>
              </select>

              <div style={styles.searchBox}>
                <span style={styles.searchIcon}>⌕</span>
                <input
                  type="text"
                  placeholder="Search"
                  value={searchKeyword}
                  onChange={(e) => setSearchKeyword(e.target.value)}
                  style={styles.searchInput}
                />
              </div>
            </div>
          </div>

          <div style={styles.tableHeader}>
            <div style={{ ...styles.cell, flex: 0.9 }}>ID</div>
            <div style={{ ...styles.cell, flex: 1.7 }}>Name</div>
            <div style={{ ...styles.cell, flex: 2.6 }}>Email</div>
            <div style={{ ...styles.cell, flex: 1.1 }}>Tier</div>
            <div style={{ ...styles.cell, flex: 1.2 }}>Status</div>
            <div style={{ ...styles.cell, flex: 1.2 }}></div>
          </div>

          {filteredUsers.length > 0 ? (
            filteredUsers.map((user, index) => (
              <div key={index} style={styles.tableRow}>
                <div style={{ ...styles.rowCell, flex: 0.9 }}>{user.id}</div>

                <div style={{ ...styles.rowCell, flex: 1.7 }}>
                  {user.name}
                </div>

                <div style={{ ...styles.rowCell, flex: 2.6 }}>
                  {user.email}
                </div>

                <div style={{ ...styles.rowCell, flex: 1.1 }}>
                  {user.tier}
                </div>

                <div
                  style={{
                    ...styles.rowCell,
                    flex: 1.2,
                    color:
                      user.status === "Suspended" ? "#ef4444" : "#4caf50",
                  }}
                >
                  {user.status}
                </div>

                <div
                  style={{
                    ...styles.rowCell,
                    flex: 1.2,
                    justifyContent: "flex-end",
                    display: "flex",
                  }}
                >
                  <button
                    style={
                      user.status === "Suspended"
                        ? styles.unsuspendButton
                        : styles.restrictButton
                    }
                  >
                    {user.status === "Suspended" ? "Unsuspend" : "Restrict"}
                  </button>
                </div>
              </div>
            ))
          ) : (
            <div style={styles.emptyMessage}>No users found</div>
          )}
        </div>
      </section>
    </main>
  );
}

const styles = {
  page: {
    minHeight: "100vh",
    display: "flex",
    backgroundColor: "#f8f8ff",
    fontFamily: "Arial, sans-serif",
    color: "#000000",
  },

  content: {
    flex: 1,
    padding: "82px 58px",
    boxSizing: "border-box",
  },

  tableCard: {
    backgroundColor: "#ffffff",
    borderRadius: "26px",
    padding: "44px 30px 10px",
    boxShadow: "0 10px 28px rgba(0, 0, 0, 0.04)",
    minHeight: "calc(100vh - 164px)",
    boxSizing: "border-box",
  },

  topRow: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: "34px",
    gap: "20px",
  },

  title: {
    fontSize: "24px",
    fontWeight: "700",
    margin: 0,
  },

  count: {
    color: "#9b9b9b",
    fontWeight: "500",
  },

  filters: {
    display: "flex",
    alignItems: "center",
    gap: "18px",
    flexWrap: "wrap",
  },

  select: {
    height: "42px",
    borderRadius: "10px",
    border: "1px solid #cfcfcf",
    padding: "0 14px",
    fontSize: "15px",
    backgroundColor: "#ffffff",
    cursor: "pointer",
  },

  searchBox: {
    height: "42px",
    width: "266px",
    borderRadius: "10px",
    border: "1px solid #cfcfcf",
    display: "flex",
    alignItems: "center",
    padding: "0 12px",
    boxSizing: "border-box",
    backgroundColor: "#ffffff",
  },

  searchIcon: {
    fontSize: "20px",
    color: "#8f8f8f",
    marginRight: "8px",
    lineHeight: 1,
  },

  searchInput: {
    border: "none",
    outline: "none",
    width: "100%",
    fontSize: "15px",
    backgroundColor: "transparent",
  },

  tableHeader: {
    display: "flex",
    alignItems: "center",
    borderBottom: "1px solid #dddddd",
    padding: "18px 10px",
    color: "#8e8e8e",
    fontSize: "15px",
  },

  tableRow: {
    display: "flex",
    alignItems: "center",
    borderBottom: "1px solid #e5e5e5",
    padding: "18px 10px",
    minHeight: "78px",
    boxSizing: "border-box",
  },

  cell: {
    fontWeight: "500",
  },

  rowCell: {
    fontSize: "15px",
    display: "flex",
    alignItems: "center",
  },

  restrictButton: {
    minWidth: "102px",
    height: "40px",
    border: "none",
    borderRadius: "20px",
    backgroundColor: "#efefef",
    color: "#222222",
    fontSize: "15px",
    fontWeight: "700",
    cursor: "pointer",
    padding: "0 18px",
  },

  unsuspendButton: {
    minWidth: "102px",
    height: "40px",
    border: "none",
    borderRadius: "20px",
    backgroundColor: "#f5bcbc",
    color: "#222222",
    fontSize: "15px",
    fontWeight: "700",
    cursor: "pointer",
    padding: "0 18px",
  },

  emptyMessage: {
    padding: "36px 10px",
    textAlign: "center",
    color: "#888888",
    fontSize: "16px",
  },
};