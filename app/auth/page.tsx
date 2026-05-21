"use client";

import { useState } from "react";
import { postToN8n } from "@/lib/api";
import { getDeviceInfo } from "@/lib/device";

export default function AuthPage() {
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");
  const [email, setEmail] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = async (e: any) => {
    e.preventDefault();

    const device = getDeviceInfo();

    await postToN8n(
      process.env.NEXT_PUBLIC_N8N_MAGIC_LINK_INIT!, 
      {
        firstName,
        lastName,
        email,
        device,
      }
    );

    setSubmitted(true);
  };

  if (submitted) {
    return (
      <div className="flex flex-col items-center justify-center h-screen bg-[#F7E8EF] px-6 text-center">
        <h1 className="text-3xl font-semibold text-[#6B1E75] mb-4">
          Prüfe deine E‑Mails ✨
        </h1>
        <p className="text-[#3A2A3F]">
          Wir haben dir einen Magic‑Link geschickt.  
          Öffne ihn auf diesem Gerät, um fortzufahren.
        </p>
      </div>
    );
  }

  return (
    <div className="flex flex-col items-center justify-center h-screen bg-[#F7E8EF] px-6">
      <div className="w-full max-w-md bg-white p-8 rounded-2xl shadow-xl">
        <h1 className="text-3xl font-semibold text-[#6B1E75] mb-6 text-center">
          Zugang anfragen ✨
        </h1>

        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            placeholder="Vorname"
            value={firstName}
            onChange={(e) => setFirstName(e.target.value)}
            required
            className="w-full p-3 rounded-xl border border-gray-300 focus:outline-none focus:ring-2 focus:ring-[#D9468F]"
          />

          <input
            type="text"
            placeholder="Nachname"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            required
            className="w-full p-3 rounded-xl border border-gray-300 focus:outline-none focus:ring-2 focus:ring-[#D9468F]"
          />

          <input
            type="email"
            placeholder="E‑Mail"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            className="w-full p-3 rounded-xl border border-gray-300 focus:outline-none focus:ring-2 focus:ring-[#D9468F]"
          />

          <button
            type="submit"
            className="w-full py-3 bg-[#D9468F] text-white rounded-xl shadow-lg hover:bg-[#C23E80] transition-all"
          >
            Magic‑Link senden
          </button>
        </form>
      </div>
    </div>
  );
}
