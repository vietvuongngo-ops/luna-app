"use client";

import { useState, useRef, KeyboardEvent } from "react";

interface LunaChatInputProps {
  onSend: (message: string) => void;
  disabled?: boolean;
}

export default function LunaChatInput({ onSend, disabled }: LunaChatInputProps) {
  const [value, setValue] = useState("");
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  function handleSend() {
    const trimmed = value.trim();
    if (!trimmed || disabled) return;
    onSend(trimmed);
    setValue("");
    if (textareaRef.current) {
      textareaRef.current.style.height = "auto";
    }
  }

  function handleKeyDown(e: KeyboardEvent<HTMLTextAreaElement>) {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  }

  function handleInput() {
    const el = textareaRef.current;
    if (!el) return;
    el.style.height = "auto";
    el.style.height = `${Math.min(el.scrollHeight, 160)}px`;
  }

  const hasValue = value.trim().length > 0;

  return (
    <div
      className="flex items-end gap-2 rounded-2xl px-4 py-3"
      style={{
        background: "rgba(255,255,255,0.9)",
        border: "1.5px solid rgba(192, 38, 211, 0.25)",
        boxShadow: "0 4px 24px rgba(168, 85, 247, 0.12), 0 1px 4px rgba(0,0,0,0.06)",
        backdropFilter: "blur(12px)",
        WebkitBackdropFilter: "blur(12px)",
      }}
    >
      {/* Textarea */}
      <textarea
        ref={textareaRef}
        rows={1}
        value={value}
        onChange={(e) => setValue(e.target.value)}
        onKeyDown={handleKeyDown}
        onInput={handleInput}
        disabled={disabled}
        placeholder="Message Luna…"
        className="flex-1 resize-none bg-transparent outline-none text-sm leading-relaxed placeholder-gray-400 disabled:opacity-50"
        style={{ maxHeight: "160px", color: "#1a1a2e" }}
      />

      {/* Mic button */}
      <button
        type="button"
        aria-label="Voice input"
        disabled={disabled}
        className="w-9 h-9 flex-shrink-0 rounded-full flex items-center justify-center transition-all hover:bg-purple-50 disabled:opacity-40"
      >
        <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#a855f7" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
          <rect x="9" y="2" width="6" height="12" rx="3" />
          <path d="M19 10a7 7 0 0 1-14 0" />
          <line x1="12" y1="19" x2="12" y2="22" />
          <line x1="8" y1="22" x2="16" y2="22" />
        </svg>
      </button>

      {/* Enter / Send button */}
      <button
        type="button"
        aria-label="Send message"
        onClick={handleSend}
        disabled={!hasValue || disabled}
        className="flex-shrink-0 rounded-xl flex items-center justify-center gap-1.5 px-3 h-9 text-xs font-semibold transition-all disabled:opacity-40"
        style={{
          background: hasValue
            ? "linear-gradient(135deg, #7c3aed 0%, #c026d3 100%)"
            : "rgba(168, 85, 247, 0.12)",
          color: hasValue ? "#ffffff" : "#a855f7",
          boxShadow: hasValue ? "0 2px 12px rgba(124, 58, 237, 0.35)" : "none",
          transition: "all 0.2s ease",
        }}
      >
        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
          <line x1="22" y1="2" x2="11" y2="13" />
          <polygon points="22 2 15 22 11 13 2 9 22 2" />
        </svg>
        <span>Enter</span>
      </button>
    </div>
  );
}
