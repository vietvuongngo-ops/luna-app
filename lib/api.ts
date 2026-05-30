export async function postToN8n<T>(url: string, data: unknown): Promise<T> {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 60000);

  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
      signal: controller.signal,
    });

    clearTimeout(timeout);

    if (!res.ok) {
      throw new Error(`n8n returned status ${res.status}`);
    }

    const text = await res.text();

    if (!text) {
      throw new Error("Empty response from n8n");
    }

    // Versuche JSON zu parsen, sonst wrappen als {reply: text}
    try {
      return JSON.parse(text) as T;
    } catch {
      return { reply: text } as T;
    }
  } catch (error) {
    clearTimeout(timeout);
    console.error("Error sending message to n8n:", error);
    throw error;
  }
}