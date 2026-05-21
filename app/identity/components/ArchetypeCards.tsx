"use client";

import { useArchetypes } from "@/hooks/useArchetypes";

export default function ArchetypeCards() {
  const { archetypes, loading } = useArchetypes();

  if (loading) return <div>Lade Archetypen...</div>;

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      {archetypes.map((a) => (
        <div
          key={a.id}
          className="p-4 bg-white/10 border border-white/20 rounded-xl"
        >
          <div className="text-lg font-semibold mb-2">
            {a.archetype_name}
          </div>

          <div className="w-full bg-white/10 h-3 rounded-full overflow-hidden">
            <div
              className="bg-purple-500 h-full"
              style={{ width: `${a.score}%` }}
            />
          </div>

          <div className="text-sm opacity-70 mt-2">
            Score: {a.score}%
          </div>
        </div>
      ))}
    </div>
  );
}
