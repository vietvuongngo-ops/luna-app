"use client";

interface LunaProfileAvatarProps {
  size?: number;
  firstName?: string;
}

export default function LunaProfileAvatar({ size = 40, firstName = "?" }: LunaProfileAvatarProps) {
  return (
    <div
      style={{ width: size, height: size }}
      className="rounded-full bg-gradient-to-br from-[#D9468F] to-[#6B1E75] flex items-center justify-center text-white font-semibold shadow-md overflow-hidden relative"
    >
      <img
        src="/Luna Logo.png"
        alt="Luna Logo"
        className="w-full h-full object-cover"
        onError={(e) => {
          (e.target as HTMLImageElement).style.display = "none";
        }}
      />
    </div>
  );
}