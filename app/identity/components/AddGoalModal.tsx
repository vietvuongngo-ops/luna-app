"use client";

import { useGoals } from "@/hooks/useGoals";
import { useState } from "react";

export default function AddGoalModal({ onClose }) {
  const { addGoal } = useGoals();
  const [title, setTitle] = useState("");
  const [desc, setDesc] = useState("");

  async function save() {
    await addGoal({
      goal_title: title,
      goal_description: desc,
      status: "open",
      priority: 2,
    });
    onClose();
  }

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center">
      <div className="bg-white/10 p-6 rounded-xl w-96 border border-white/20">
        <h3 className="text-lg font-semibold mb-4">Neues Ziel</h3>

        <input
          className="w-full p-2 mb-3 bg-white/5 border border-white/20 rounded"
          placeholder="Titel"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
        />

        <textarea
          className="w-full p-2 mb-3 bg-white/5 border border-white/20 rounded"
          placeholder="Beschreibung"
          value={desc}
          onChange={(e) => setDesc(e.target.value)}
        />

        <div className="flex justify-end space-x-2">
          <button onClick={onClose} className="px-3 py-2">
            Abbrechen
          </button>
          <button
            onClick={save}
            className="px-4 py-2 bg-purple-600 text-white rounded-lg"
          >
            Speichern
          </button>
        </div>
      </div>
    </div>
  );
}
