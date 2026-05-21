"use client";

import { Suspense, useEffect, useState } from "react";
import { useSearchParams, useRouter } from "next/navigation";
import { postToN8n } from "@/lib/api";
import { supabase } from "@/lib/supabase";

function VerifyContent() {
  const searchParams = useSearchParams();
  const router = useRouter();
  const [status, setStatus] = useState<"loading" | "error">("loading");

  useEffect(() => {
    const token = searchParams.get("token");

    if (!token) {
      setStatus("error");
      return;
    }

    postToN8n(process.env.NEXT_PUBLIC_N8N_MAGIC_LINK_VERIFY!, { token })
      .then(async (data: any) => {
        if (data?.id) {
          localStorage.setItem("luna_user_id", data.id);
          localStorage.setItem("luna_first_name", data.firstName ?? "");
        }

        // Supabase-Session setzen falls access_token vom n8n zurückkommt
        if (data?.access_token && data?.refresh_token) {
          await supabase.auth.setSession({
            access_token: data.access_token,
            refresh_token: data.refresh_token,
          });
        } else {
          // Fallback: OTP aus Token verifizieren
          await supabase.auth.verifyOtp({
            token_hash: token,
            type: "email",
          });
        }

        router.push("/chat");
      })
      .catch(() => setStatus("error"));
  }, []);

  if (status === "error") {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-[#F7E8EF]">
        <h1 className="text-2xl font-semibold text-[#6B1E75] mb-4">
          Link ungültig oder abgelaufen ❌
        </h1>
        <a href="/auth" className="text-[#D9468F] underline">
          Neuen Link anfordern
        </a>
      </div>
    );
  }

  return (
    <div className="flex flex-col items-center justify-center h-screen bg-[#F7E8EF]">
      <h1 className="text-2xl font-semibold text-[#6B1E75] mb-4">
        Verifiziere... ✨
      </h1>
      <p className="text-[#3A2A3F]">Einen Moment bitte.</p>
    </div>
  );
}

export default function VerifyPage() {
  return (
    <Suspense
      fallback={
        <div className="flex flex-col items-center justify-center h-screen bg-[#F7E8EF]">
          <h1 className="text-2xl font-semibold text-[#6B1E75] mb-4">
            Verifiziere... ✨
          </h1>
          <p className="text-[#3A2A3F]">Einen Moment bitte.</p>
        </div>
      }
    >
      <VerifyContent />
    </Suspense>
  );
}
