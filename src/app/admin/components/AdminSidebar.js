"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";

export default function AdminSidebar() {
  const pathname = usePathname();
  const router = useRouter();

  function handleLogout() {
    localStorage.removeItem("adminLoggedIn");
    router.replace("/admin/login");
  }

  function isActive(path) {
    return pathname === path;
  }

  return (
    <aside style={styles.sidebar}>
      <div style={styles.menuArea}>
        <h1 style={styles.logo}>ShapeRush</h1>

        <div style={styles.sectionTitle}>MANAGE</div>

        <nav style={styles.nav}>
          <Link href="/admin/dashboard" style={styles.linkReset}>
            <div
              style={{
                ...styles.navItem,
                ...(isActive("/admin/dashboard") ? styles.activeNavItem : {}),
              }}
            >
              Dashboard
            </div>
          </Link>

          <Link href="/admin/users" style={styles.linkReset}>
            <div
              style={{
                ...styles.navItem,
                ...(isActive("/admin/users") ? styles.activeNavItem : {}),
              }}
            >
              Users
            </div>
          </Link>

          <Link href="/admin/professionals" style={styles.linkReset}>
            <div
              style={{
                ...styles.navItem,
                ...(isActive("/admin/professionals")
                  ? styles.activeNavItem
                  : {}),
              }}
            >
              Professionals
            </div>
          </Link>

          <Link href="/admin/plans" style={styles.linkReset}>
            <div
              style={{
                ...styles.navItem,
                ...(isActive("/admin/plans") ? styles.activeNavItem : {}),
              }}
            >
              Plans
            </div>
          </Link>
          
          <div style={styles.navItem}>Reviews</div>
          <div style={styles.navItem}>Reports</div>
        </nav>

        <div style={styles.divider}></div>

        <div style={styles.sectionTitle}>CONTENT</div>

        <nav style={styles.nav}>
          <div style={styles.navItem}>Website</div>
        </nav>

        <div style={styles.divider}></div>

        <div style={styles.sectionTitle}>SYSTEM</div>

        <nav style={styles.nav}>
          <div style={styles.navItem}>Audit Logs</div>
        </nav>
      </div>

      <button onClick={handleLogout} style={styles.logoutButton}>
        Logout
      </button>
    </aside>
  );
}

const styles = {
  sidebar: {
    width: "280px",
    height: "100vh",
    minHeight: "100vh",
    backgroundColor: "#ffffff",
    padding: "36px 30px 26px",
    boxSizing: "border-box",
    position: "sticky",
    top: 0,
    flexShrink: 0,
    overflow: "hidden",
  },

  menuArea: {
    paddingBottom: "110px",
  },

  logo: {
    fontSize: "26px",
    fontWeight: "700",
    margin: "0 0 42px",
  },

  sectionTitle: {
    fontSize: "14px",
    color: "#a5a5a5",
    marginBottom: "18px",
    letterSpacing: "0.5px",
  },

  nav: {
    display: "flex",
    flexDirection: "column",
    gap: "20px",
  },

  navItem: {
    fontSize: "16px",
    fontWeight: "600",
    cursor: "pointer",
    color: "#111111",
  },

  activeNavItem: {
    color: "#6658ff",
  },

  linkReset: {
    textDecoration: "none",
  },

  divider: {
    height: "1px",
    backgroundColor: "#e5e5e5",
    margin: "22px 0",
  },

  logoutButton: {
    position: "absolute",
    left: "30px",
    bottom: "26px",
    width: "190px",
    height: "60px",
    borderRadius: "18px",
    border: "2px solid #6658ff",
    backgroundColor: "#ffffff",
    color: "#6658ff",
    fontSize: "16px",
    fontWeight: "700",
    cursor: "pointer",
  },
};