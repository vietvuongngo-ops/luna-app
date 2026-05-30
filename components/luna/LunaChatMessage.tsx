"use client";

import { useState, useEffect, useRef } from "react";

interface LunaChatMessageProps {
  role: "user" | "assistant";
  content: string;
  firstName?: string;
  isTyping?: boolean;
}

export default function LunaChatMessage({
  role,
  content,
  firstName = "?",
  isTyping = false,
}: LunaChatMessageProps) {
  const isAssistant = role === "assistant";
  const [displayed, setDisplayed] = useState(isTyping && isAssistant ? "" : content);
  const cancelledRef = useRef(false);

    useEffect(() => {
    cancelledRef.current = false;

    if (!isTyping || !isAssistant) {
      setDisplayed(content);
      return;
    }

    setDisplayed("");
    let i = 0;

    function tick() {
      if (cancelledRef.current) return;
      i++;
      setDisplayed(content.slice(0, i));
      if (i < content.length) {
        setTimeout(tick, 18);
      }
    }

    const timer = setTimeout(tick, 18);
    return () => {
      cancelledRef.current = true;
      clearTimeout(timer);
    };
  }, [content, isTyping, isAssistant]);

  return (
    <div className={`flex w-full mb-3 ${isAssistant ? "justify-start" : "justify-end"}`}>
      {isAssistant && (
        <div className="w-7 h-7 rounded-full overflow-hidden flex-shrink-0 mr-2 mt-5 shadow-sm">
          <img src="/luna-profil.png" alt="Luna" className="w-full h-full object-cover" />
        </div>
      )}
      <div className={`flex flex-col ${isAssistant ? "items-start" : "items-end"} max-w-[72%]`}>
        <span
          className="text-xs font-medium mb-1 px-1"
          style={{ color: isAssistant ? "#c2357a" : "#7c3aed" }}
        >
          {isAssistant ? "Luna" : firstName}
        </span>
        <div
          className={`px-4 py-3 text-sm leading-relaxed whitespace-pre-wrap w-full ${
            isAssistant ? "rounded-2xl rounded-tl-sm" : "rounded-2xl rounded-tr-sm"
          }`}
          style={
            isAssistant
              ? {
                  background: "linear-gradient(135deg, #f472b6 0%, #ec4899 60%, #c2357a 100%)",
                  boxShadow: "0 2px 16px rgba(196, 53, 122, 0.25)",
                  color: "#ffffff",
                }
              : {
                  background: "linear-gradient(135deg, #a78bfa 0%, #7c3aed 50%, #6025c0 100%)",
                  boxShadow: "0 2px 16px rgba(124, 58, 237, 0.30)",
                  color: "#ffffff",
                }
          }
        >
          {displayed}
          {isTyping && isAssistant && displayed.length < content.length && (
            <span
              className="inline-block w-0.5 h-3.5 ml-0.5 align-middle animate-pulse"
              style={{ background: "rgba(255,255,255,0.8)" }}
            />
          )}
        </div>
      </div>
    </div>
  );
}