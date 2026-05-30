import { useEffect, useState } from "react";

export function useArchetypes() {
  const [archetypes, setArchetypes] = useState([]);
  const [loading, setLoading] = useState(true);

  async function loadArchetypes() {
    setLoading(true);
    const res = await fetch("/api/identity/archetypes");
    const data = await res.json();
    setArchetypes(data);
    setLoading(false);
  }

  async function updateArchetype(archetype) {
    const res = await fetch("/api/identity/archetypes", {
      method: "PUT",
      body: JSON.stringify(archetype),
    });

    const data = await res.json();

    setArchetypes((prev) =>
      prev.map((a) => (a.id === data.id ? data : a))
    );
  }

  useEffect(() => {
    loadArchetypes();
  }, []);

  return {
    archetypes,
    loading,
    updateArchetype,
  };
}
