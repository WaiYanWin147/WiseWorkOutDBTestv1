"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import AdminSidebar from "../components/AdminSidebar";

export default function AdminDashboardPage() {
  const router = useRouter();
  const [allowed, setAllowed] = useState(false);

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
        <div style={styles.topBar}>
          <select style={styles.select}>
            <option>Last 7 days</option>
            <option>Last 30 days</option>
            <option>Last 90 days</option>
          </select>
        </div>

        <div style={styles.statsGrid}>
          <StatCard title="Total Users" value="1,234" />
          <StatCard title="Approved Pros" value="86" />

          <div style={styles.statCard}>
            <div style={styles.cardHeader}>
              <h3 style={styles.statTitle}>Pending Pro Apps</h3>
              <span style={styles.redDot}></span>
            </div>

            <p style={styles.statValue}>7</p>

            <button style={styles.reviewButton}>Review</button>
          </div>

          <StatCard title="Priority Users" value="234" />
        </div>

        <div style={styles.chartGrid}>
          <div style={styles.chartCard}>
            <h3 style={styles.chartTitle}>User Tier Breakdown</h3>

            <div style={styles.pieArea}>
              <div style={styles.pieChart}>
                <span style={styles.pieLabelFree}>64%</span>
                <span style={styles.pieLabelPriority}>24%</span>
                <span style={styles.pieLabelPro}>12%</span>
              </div>

              <div style={styles.legend}>
                <Legend color="#2d7fb8" label="Free" />
                <Legend color="#ff9800" label="Priority" />
                <Legend color="#2ca02c" label="Pro" />
              </div>
            </div>
          </div>

          <div style={styles.chartCard}>
            <h3 style={styles.chartTitle}>New Signups</h3>

            <svg viewBox="0 0 460 260" style={styles.lineChart}>
              {[20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220].map(
                (y) => (
                  <line
                    key={`h-${y}`}
                    x1="30"
                    y1={y}
                    x2="440"
                    y2={y}
                    stroke="#d7d7d7"
                    strokeWidth="1"
                  />
                )
              )}

              {[50, 110, 170, 230, 290, 350, 410].map((x) => (
                <line
                  key={`v-${x}`}
                  x1={x}
                  y1="20"
                  x2={x}
                  y2="220"
                  stroke="#d7d7d7"
                  strokeWidth="1"
                />
              ))}

              <line
                x1="30"
                y1="140"
                x2="440"
                y2="140"
                stroke="#22c58a"
                strokeWidth="2"
                strokeDasharray="6 5"
              />

              <polyline
                points="50,140 110,110 170,170 230,140 290,60 350,110 410,90"
                fill="none"
                stroke="#1683d8"
                strokeWidth="3"
              />

              {[
                [50, 140],
                [110, 110],
                [170, 170],
                [230, 140],
                [290, 60],
                [350, 110],
                [410, 90],
              ].map(([x, y], index) => (
                <circle
                  key={index}
                  cx={x}
                  cy={y}
                  r="6"
                  fill="#5dade2"
                  stroke="#1683d8"
                  strokeWidth="2"
                />
              ))}
            </svg>
          </div>
        </div>
      </section>
    </main>
  );
}

function StatCard({ title, value }) {
  return (
    <div style={styles.statCard}>
      <h3 style={styles.statTitle}>{title}</h3>
      <p style={styles.statValue}>{value}</p>
    </div>
  );
}

function Legend({ color, label }) {
  return (
    <div style={styles.legendItem}>
      <span style={{ ...styles.legendColor, backgroundColor: color }}></span>
      <span>{label}</span>
    </div>
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
    padding: "70px 100px",
    boxSizing: "border-box",
  },

  topBar: {
    display: "flex",
    justifyContent: "flex-end",
    marginBottom: "18px",
  },

  select: {
    width: "140px",
    height: "42px",
    borderRadius: "8px",
    border: "1px solid #cfcfcf",
    backgroundColor: "#ffffff",
    padding: "0 12px",
    fontSize: "15px",
    fontWeight: "700",
    cursor: "pointer",
  },

  statsGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(4, 1fr)",
    gap: "30px",
    marginBottom: "48px",
  },

  statCard: {
    height: "170px",
    backgroundColor: "#ffffff",
    borderRadius: "10px",
    padding: "30px 20px",
    boxSizing: "border-box",
    boxShadow: "0 12px 24px rgba(0, 0, 0, 0.06)",
  },

  cardHeader: {
    display: "flex",
    alignItems: "center",
    gap: "8px",
  },

  statTitle: {
    fontSize: "16px",
    fontWeight: "700",
    margin: "0 0 14px",
  },

  statValue: {
    fontSize: "28px",
    fontWeight: "700",
    margin: "0",
  },

  redDot: {
    width: "12px",
    height: "12px",
    borderRadius: "50%",
    backgroundColor: "#e5484d",
    display: "inline-block",
    marginBottom: "12px",
  },

  reviewButton: {
    marginTop: "14px",
    width: "90px",
    height: "34px",
    border: "none",
    borderRadius: "18px",
    backgroundColor: "#6658ff",
    color: "#ffffff",
    fontSize: "14px",
    fontWeight: "700",
    cursor: "pointer",
  },

  chartGrid: {
    display: "grid",
    gridTemplateColumns: "1fr 1.2fr",
    gap: "28px",
  },

  chartCard: {
    height: "350px",
    backgroundColor: "#ffffff",
    borderRadius: "18px",
    padding: "34px 30px",
    boxSizing: "border-box",
    boxShadow: "0 12px 24px rgba(0, 0, 0, 0.05)",
  },

  chartTitle: {
    fontSize: "17px",
    fontWeight: "700",
    margin: "0 0 26px",
  },

  pieArea: {
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    gap: "30px",
  },

  pieChart: {
    width: "230px",
    height: "230px",
    borderRadius: "50%",
    background:
      "conic-gradient(#2d7fb8 0% 64%, #ff9800 64% 88%, #2ca02c 88% 100%)",
    position: "relative",
  },

  pieLabelFree: {
    position: "absolute",
    right: "50px",
    bottom: "78px",
    color: "#ffffff",
    fontSize: "12px",
    fontWeight: "700",
  },

  pieLabelPriority: {
    position: "absolute",
    left: "38px",
    top: "105px",
    color: "#ffffff",
    fontSize: "12px",
    fontWeight: "700",
  },

  pieLabelPro: {
    position: "absolute",
    top: "34px",
    left: "96px",
    color: "#ffffff",
    fontSize: "12px",
    fontWeight: "700",
  },

  legend: {
    display: "flex",
    flexDirection: "column",
    gap: "8px",
    fontSize: "12px",
  },

  legendItem: {
    display: "flex",
    alignItems: "center",
    gap: "8px",
  },

  legendColor: {
    width: "9px",
    height: "9px",
    display: "inline-block",
  },

  lineChart: {
    width: "100%",
    height: "250px",
  },
};