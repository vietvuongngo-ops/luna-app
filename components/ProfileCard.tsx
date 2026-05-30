"use client";

import { useProfile } from "@/hooks/useProfile";

export default function ProfileCard() {
  const { profile, loading } = useProfile();

  if (loading) return <div>Lade Profil...</div>;
  if (!profile) return <div>Kein Profil gefunden.</div>;

  return (
    <div className="p-6 bg-white/10 border border-white/20 rounded-xl flex items-center gap-6">
      <img
        src={profile.avatar_url || "/default-avatar.png"}
        alt="Avatar"
        className="w-20 h-20 rounded-full border border-white/20 object-cover"
      />

      <div className="flex-1">
        <div className="text-2xl font-semibold">
          {profile.first_name} {profile.last_name}
        </div>

        <div className="text-sm opacity-70">
          Start: {profile.start_date}
        </div>

        <div className="flex gap-6 mt-3">
          <div>
            <div className="text-lg font-bold">{profile.transformation_level}</div>
            <div className="text-xs opacity-60">Level</div>
          </div>

          <div>
            <div className="text-lg font-bold">{profile.points}</div>
            <div className="text-xs opacity-60">Punkte</div>
          </div>
        </div>
      </div>
    </div>
  );
}
