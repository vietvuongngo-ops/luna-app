export async function sendMessageToN8N(userMessage: string) {
  const response = await fetch(process.env.NEXT_PUBLIC_N8N_URL!, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ userMessage }),
  });

  return response.json();
}
