export async function postToN8n(userMessage: string) {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 60000); // 60 Sekunden Timeout

  try {
    const response = await fetch(process.env.NEXT_PUBLIC_N8N_URL!, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ userMessage }),
      signal: controller.signal,
    });

    clearTimeout(timeout);

    if (!response.ok) {
      throw new Error(`n8n returned status ${response.status}`);
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error("Error sending message to n8n:", error);
    return {
      error: true,
      message: "Verbindung zu n8n fehlgeschlagen oder Timeout erreicht",
    };
  }
}
