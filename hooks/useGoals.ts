import { useEffect, useState } from "react";

export function useGoals() {
  const [goals, setGoals] = useState([]);
  const [loading, setLoading] = useState(true);

  async function loadGoals() {
    setLoading(true);
    const res = await fetch("/api/identity/goals");
    const data = await res.json();
    setGoals(data);
    setLoading(false);
  }

  async function addGoal(goal) {
    const res = await fetch("/api/identity/goals", {
      method: "POST",
      body: JSON.stringify(goal),
    });

    const data = await res.json();
    setGoals((prev) => [...prev, data]);
  }

  async function updateGoal(goal) {
    const res = await fetch("/api/identity/goals", {
      method: "PUT",
      body: JSON.stringify(goal),
    });

    const data = await res.json();

    setGoals((prev) =>
      prev.map((g) => (g.id === data.id ? data : g))
    );
  }

  useEffect(() => {
    loadGoals();
  }, []);

  return {
    goals,
    loading,
    addGoal,
    updateGoal,
  };
}
