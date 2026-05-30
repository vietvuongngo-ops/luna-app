"use client";

import { useDimensions } from "@/hooks/useDimensions";

export default function DimensionsBars() {
  const { dimensions, loading } = useDimensions();

  if (loading) return <div>Lade Dimensionen...</div>;

  return (
    <div className="space-y-4">
      <h2 className="text-xl font-semibold">Deine 5 Dimensionen</h2>

      {dimensions.map((dim) => (
        <div
          key={dim.id}
          className="p-4 bg-white/10 border border-white/20 rounded-xl"
        >
          <div className="font-medium mb-2">{dim.dimension_name}</div>

          <div className="w-full bg-white/10 h-3 rounded-full overflow-hidden">
            <div
              className="bg-purple-500 h-full"
              style={{ width: `${dim.score}%` }}
            />
          </div>

          <div className="text-sm opacity-70 mt-2">
            Score: {dim.score}%
          </div>

          {dim.description && (
            <div className="text-xs opacity-60 mt-1">
              {dim.description}
            </div>
          )}
        </div>
      ))}
    </div>
  );
}
