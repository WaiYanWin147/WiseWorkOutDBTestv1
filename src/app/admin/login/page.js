"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { supabase } from "@/lib/supabase";

export default function AdminLoginPage() {
  const router = useRouter();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleLogin(event) {
    event.preventDefault();

    setError("");
    setLoading(true);

    const cleanEmail = email.trim().toLowerCase();

    const { data: loginData, error: loginError } =
      await supabase.auth.signInWithPassword({
        email: cleanEmail,
        password,
      });

    if (loginError) {
      setError("Invalid admin email or password");
      setLoading(false);
      return;
    }

    if (!loginData?.user) {
      setError("Login failed. Please try again.");
      setLoading(false);
      return;
    }

    const { data: adminRow, error: adminError } = await supabase
      .from("admin")
      .select("profile_id, role")
      .eq("profile_id", loginData.user.id)
      .single();

    if (adminError || !adminRow) {
      await supabase.auth.signOut();
      localStorage.removeItem("adminLoggedIn");

      setError("Only admin can access this page.");
      setLoading(false);
      return;
    }

    const { data: profile, error: profileError } = await supabase
      .from("profiles")
      .select("email, status")
      .eq("id", loginData.user.id)
      .single();

    if (profileError || profile?.status !== "active") {
      await supabase.auth.signOut();
      localStorage.removeItem("adminLoggedIn");

      setError("This admin account is not active.");
      setLoading(false);
      return;
    }

    localStorage.setItem("adminLoggedIn", "true");
    localStorage.setItem("adminEmail", profile.email || cleanEmail);
    router.replace("/admin/dashboard");
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
              onChange={(event) => {
                setEmail(event.target.value);
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
              onChange={(event) => {
                setPassword(event.target.value);
                setError("");
              }}
              style={styles.input}
              required
            />
          </div>

          {error && <p style={styles.error}>{error}</p>}

          <button
            type="submit"
            style={{
              ...styles.button,
              ...(loading ? styles.buttonDisabled : {}),
            }}
            disabled={loading}
          >
            {loading ? "Logging in..." : "Login"}
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
    color: "#111111",
    backgroundColor: "#ffffff",
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

  buttonDisabled: {
    opacity: 0.65,
    cursor: "not-allowed",
  },

  error: {
    color: "#e63946",
    fontSize: "13px",
    margin: "-8px 0 0 0",
  },
};