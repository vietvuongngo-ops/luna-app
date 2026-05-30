import { useEffect, useState } from "react";

export function useDimensions() {
  const [dimensions, setDimensions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  async function loadDimensions() {
    setLoading(true);
    try {
      const res = await fetch("/api/identity/dimensions");
      if (!res.ok) throw new Error(`Fehler: ${res.status}`);
      const data = await res.json();
      setDimensions(Array.isArray(data) ? data : []);
    } catch (err: any) {
      setError(err.message ?? "Dimensionen konnten nicht geladen werden.");
    } finally {
      setLoading(false);
    }
  }

  async function updateDimension(dimension) {
    try {
      const res = await fetch("/api/identity/dimensions", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(dimension),
      });
      if (!res.ok) throw new Error(`Fehler: ${res.status}`);
      const data = await res.json();
      setDimensions((prev) =>
        prev.map((d) => (d.id === data.id ? data : d))
      );
    } catch (err: any) {
      setError(err.message ?? "Dimension konnte nicht aktualisiert werden.");
    }
  }

  useEffect(() => {
    loadDimensions();
  }, []);

  return {
    dimensions,
    loading,
    error,
    updateDimension,
  };
}