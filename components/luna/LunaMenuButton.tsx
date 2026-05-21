"use client";

interface LunaMenuButtonProps {
  onClick?: () => void;
}

export default function LunaMenuButton({ onClick }: LunaMenuButtonProps) {
  return (
    <button
      onClick={onClick}
      aria-label="Menu"
      className="w-9 h-9 rounded-full flex items-center justify-center transition-colors hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-offset-1"
      style={{ "--tw-ring-color": "var(--luna-pink)" } as React.CSSProperties}
    >
      <svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true">
        <circle cx="4" cy="10" r="1.5" fill="#6B7280" />
        <circle cx="10" cy="10" r="1.5" fill="#6B7280" />
        <circle cx="16" cy="10" r="1.5" fill="#6B7280" />
      </svg>
    </button>
  );
}