"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function AdminLoginPage() {
  const router = useRouter();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  function handleLogin(e) {
    e.preventDefault();

    const adminEmail = "admin@shaperush.com";
    const adminPassword = "admin123";

    if (email === adminEmail && password === adminPassword) {
      localStorage.setItem("adminLoggedIn", "true");
      router.replace("/admin/dashboard");
    } else {
      setError("Invalid admin email or password");
    }
  }

  return (
    <main style={styles.page}>
      <div style={styles.card}>
        <h1 style={styles.title}>Login to ShapeRush</h1>

        <form onSubmit={handleLogin} style={styles.form}>
          <div style={styles.formGroup}>
            <label style={styles.label}>Email</label>
            <input
              type="email"
              placeholder="Enter your email"
              value={email}
              onChange={(e) => {
                setEmail(e.target.value);
                setError("");
              }}
              style={styles.input}
              required
            />
          </div>

          <div style={styles.formGroup}>
            <label style={styles.label}>Password</label>
            <input
              type="password"
              placeholder="Enter your password"
              value={password}
              onChange={(e) => {
                setPassword(e.target.value);
                setError("");
              }}
              style={styles.input}
              required
            />
          </div>

          {error && <p style={styles.error}>{error}</p>}

          <button type="submit" style={styles.button}>
            Login
          </button>
        </form>
      </div>
    </main>
  );
}

const styles = {
  page: {
    minHeight: "100vh",
    backgroundColor: "#f7f7ff",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    fontFamily: "Arial, sans-serif",
  },

  card: {
    width: "360px",
    backgroundColor: "#ffffff",
    padding: "34px 30px",
    borderRadius: "18px",
    boxShadow: "0 18px 40px rgba(0, 0, 0, 0.06)",
  },

  title: {
    textAlign: "center",
    fontSize: "24px",
    fontWeight: "700",
    marginBottom: "30px",
    color: "#111111",
  },

  form: {
    display: "flex",
    flexDirection: "column",
    gap: "22px",
  },

  formGroup: {
    display: "flex",
    flexDirection: "column",
    gap: "10px",
  },

  label: {
    fontSize: "14px",
    fontWeight: "700",
    color: "#111111",
  },

  input: {
    width: "100%",
    height: "46px",
    border: "1px solid #d3d3d3",
    borderRadius: "10px",
    padding: "0 14px",
    fontSize: "14px",
    outline: "none",
    boxSizing: "border-box",
  },

  button: {
    width: "100%",
    height: "50px",
    border: "none",
    borderRadius: "12px",
    backgroundColor: "#6658ff",
    color: "#ffffff",
    fontSize: "14px",
    fontWeight: "700",
    cursor: "pointer",
    marginTop: "2px",
  },

  error: {
    color: "#e63946",
    fontSize: "13px",
    margin: "-8px 0 0 0",
  },
};