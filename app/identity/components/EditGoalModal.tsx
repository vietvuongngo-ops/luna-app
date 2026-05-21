"use client";

import { useState } from "react";

interface Goal {
  id: string;
  value: string;
}

interface Props {
  goal: Goal;
  onClose: () => void;
  onSave: (value: string) => void;
}

export default function EditGoalModal({ goal, onClose, onSave }: Props) {
  const [value, setValue] = useState(goal.value);

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center">
      <div className="bg-white/10 p-6 rounded-xl w-96 border border-white/20">
        <h3 className="text-lg font-semibold mb-4">Ziel bearbeiten</h3>

        <input
          type="text"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          className="w-full bg-white/10 border border-white/20 rounded-lg px-3 py-2 mb-4 text-white"
        />

        <div className="flex gap-2 justify-end">
          <button
            onClick={onClose}
            className="px-4 py-2 rounded-lg bg-white/10 hover:bg-white/20"
          >
            Abbrechen
          </button>
          <button
            onClick={() => onSave(value)}
            className="px-4 py-2 rounded-lg bg-blue-500 hover:bg-blue-600"
          >
            Speichern
          </button>
        </div>
      </div>
    </div>
  );
}