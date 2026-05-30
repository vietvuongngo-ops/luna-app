"use client";

import { useGoals } from "@/hooks/useGoals";
import { useState } from "react";
import AddGoalModal from "./AddGoalModal";
import EditGoalModal from "./EditGoalModal";

export default function GoalsList() {
  const { goals, loading } = useGoals();
  const [selectedGoal, setSelectedGoal] = useState(null);
  const [showAdd, setShowAdd] = useState(false);

  if (loading) return <div>Lade Ziele...</div>;

  return (
    <div className="space-y-4">
      <div className="flex justify-between items-center">
        <h2 className="text-xl font-semibold">Ziele</h2>
        <button
          onClick={() => setShowAdd(true)}
          className="px-4 py-2 bg-purple-600 text-white rounded-lg"
        >
          + Ziel hinzufügen
        </button>
      </div>

      <div className="space-y-3">
        {goals.map((goal) => (
          <div
            key={goal.id}
            className="p-4 bg-white/10 rounded-lg border border-white/20 cursor-pointer"
            onClick={() => setSelectedGoal(goal)}
          >
            <div className="font-medium">{goal.goal_title}</div>
            <div className="text-sm opacity-70">{goal.goal_description}</div>
            <div className="text-xs opacity-50 mt-1">
              Status: {goal.status}
            </div>
          </div>
        ))}
      </div>

      {showAdd && <AddGoalModal onClose={() => setShowAdd(false)} />}
      {selectedGoal && (
        <EditGoalModal
          goal={selectedGoal}
          onClose={() => setSelectedGoal(null)}
        />
      )}
    </div>
  );
}
