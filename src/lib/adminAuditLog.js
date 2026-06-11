import { supabase } from "@/lib/supabase";

export async function createAuditLog({ action, target, targetType }) {
  const {
    data: { user },
  } = await supabase.auth.getUser();

  const adminEmail =
    localStorage.getItem("adminEmail") || user?.email || "admin";

  const { error } = await supabase.from("audit_logs").insert({
    admin_id: user?.id || null,
    admin_email: adminEmail,
    action: action,
    target: target,
    target_type: targetType,
  });

  if (error) {
    console.error("Create audit log error:", error.message);
  }
}