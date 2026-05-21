"use client";

import { useEffect, useState } from "react";
import LunaProfileAvatar from "@/components/luna/LunaProfileAvatar";
import LunaMenuButton from "@/components/luna/LunaMenuButton";

interface LunaHeaderProps {
  onMenuClick?: () => void;
}

export default function LunaHeader({ onMenuClick }: LunaHeaderProps) {
  const [firstName, setFirstName] = useState("?");

  useEffect(() => {
    const name = localStorage.getItem("luna_first_name");
    if (name) setFirstName(name);
  }, []);

  return (
    <header
      className="sticky top-0 z-10 flex items-center justify-between px-5 py-3 border-b"
      style={{
        background: "rgba(255, 255, 255, 0.72)",
        borderColor: "rgba(210, 100, 180, 0.15)",
        backdropFilter: "saturate(180%) blur(20px)",
        WebkitBackdropFilter: "saturate(180%) blur(20px)",
      }}
    >
      <div className="flex items-center gap-3">
        <div className="w-11 h-11 rounded-full overflow-hidden shadow-sm flex-shrink-0">
          <img src="/luna-profil.png" alt="Luna" className="w-full h-full object-cover" />
        </div>
        <div className="flex flex-col gap-0.1">
          <span
            className="font-semibold text-x1"
            style={{
              color: "#1a1a2e",
              fontFamily: "var(--font-display)",
              letterSpacing: "-0.01em",
            }}
          >
            Luna
          </span>
          <span
            className="text-[13px] uppercase hidden sm:block"
            style={{
              color: "var(--luna-pink)",
              letterSpacing: "0.12em",
              fontFamily: "var(--font-body)",
            }}
          >
            AI Identity Coach
          </span>
        </div>
      </div>

      <div className="flex items-center gap-1">
        <LunaMenuButton onClick={onMenuClick} />
        <LunaProfileAvatar firstName={firstName} />
      </div>
    </header>
  );
}