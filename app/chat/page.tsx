"use client";

import { useState, useEffect, useRef, Suspense } from "react";
import { useRouter } from "next/navigation";
import { postToN8n } from "@/lib/api";
import LunaHeader from "@/components/luna/LunaHeader";
import LunaChatMessage from "@/components/luna/LunaChatMessage";
import LunaChatInput from "@/components/luna/LunaChatInput";

interface Message {
  id: string;
  role: "user" | "assistant";
  content: string;
  createdAt: string;
  isTyping?: boolean;
}

interface ChatResponse {
  reply: string;
}

function ChatContent() {
  const router = useRouter();
  const [messages, setMessages] = useState<Message[]>([]);
  const [userId, setUserId] = useState<string | null>(null);
  const [firstName, setFirstName] = useState<string>("?");
  const [loading, setLoading] = useState(true);
  const [sending, setSending] = useState(false);
  const bottomRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const stored = localStorage.getItem("luna_user_id");
    const storedName = localStorage.getItem("luna_first_name") ?? "?";

    if (!stored) {
      router.replace("/auth");
      return;
    }

    setUserId(stored);
    setFirstName(storedName);

    const welcome: Message = {
      id: crypto.randomUUID(),
      role: "assistant",
      content: "Hallo! Ich bin Luna, dein AI Identity Coach. Wie kann ich dir heute helfen?",
      createdAt: new Date().toISOString(),
      isTyping: true,
    };

    setMessages([welcome]);
    setLoading(false);
  }, [router]);

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  async function handleSend(text: string) {
    if (!userId || sending) return;

    const userMsg: Message = {
      id: crypto.randomUUID(),
      role: "user",
      content: text,
      createdAt: new Date().toISOString(),
    };

    setMessages((prev) => [...prev, userMsg]);
    setSending(true);

    try {
      const history = messages.map(({ role, content }) => ({ role, content }));

      const data = await postToN8n<ChatResponse>(
        process.env.NEXT_PUBLIC_N8N_CHAT!,
        { userId, message: text, history }
      );

      const assistantMsg: Message = {
        id: crypto.randomUUID(),
        role: "assistant",
        content: data.reply,
        createdAt: new Date().toISOString(),
        isTyping: true,
      };

      setMessages((prev) => [...prev, assistantMsg]);
    } catch {
      const errMsg: Message = {
        id: crypto.randomUUID(),
        role: "assistant",
        content: "I'm having trouble connecting right now. Please try again in a moment.",
        createdAt: new Date().toISOString(),
        isTyping: true,
      };

      setMessages((prev) => [...prev, errMsg]);
    } finally {
      setSending(false);
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center"
        style={{ background: "linear-gradient(145deg, #fdf0f7 0%, #f9f5ff 50%, #ffffff 100%)" }}>
        <div className="flex flex-col items-center gap-3">
          <div className="w-10 h-10 rounded-full animate-pulse"
            style={{ background: "linear-gradient(135deg, var(--luna-pink) 0%, var(--luna-purple) 100%)" }} />
          <p className="text-sm text-gray-400">Connecting to Luna…</p>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col min-h-screen"
      style={{ background: "linear-gradient(145deg, #fdf0f7 0%, #f9f5ff 40%, #ffffff 100%)" }}>
      <LunaHeader />

      <div className="flex-1 overflow-y-auto">
        <div className="mx-auto w-full max-w-2xl px-4 py-6">
          {messages.map((msg) => (
            <LunaChatMessage
              key={msg.id}
              role={msg.role}
              content={msg.content}
              firstName={firstName}
              isTyping={msg.isTyping}
            />
          ))}

          {sending && (
            <div className="flex justify-start mb-4">
              <div className="px-4 py-3 rounded-2xl rounded-tl-sm shadow-md border"
                style={{
                  background: "var(--luna-bubble-bg)",
                  borderColor: "var(--luna-bubble-border)",
                  boxShadow: "0 2px 12px var(--luna-bubble-shadow)",
                }}>
                <span className="flex gap-1 items-center h-4">
                  {[0, 150, 300].map((delay) => (
                    <span key={delay} className="w-1.5 h-1.5 rounded-full animate-bounce"
                      style={{ background: "var(--luna-pink-dark)", animationDelay: `${delay}ms` }} />
                  ))}
                </span>
              </div>
            </div>
          )}

          <div ref={bottomRef} />
        </div>
      </div>

      <div className="sticky bottom-0 pb-safe"
        style={{ background: "rgba(255,255,255,0.8)", backdropFilter: "blur(12px)", WebkitBackdropFilter: "blur(12px)" }}>
        <div className="mx-auto w-full max-w-2xl px-4 py-3">
          <LunaChatInput onSend={handleSend} disabled={sending} />
        </div>
      </div>
    </div>
  );
}

export default function ChatPage() {
  return (
    <Suspense fallback={
      <div className="min-h-screen flex items-center justify-center"
        style={{ background: "linear-gradient(145deg, #fdf0f7 0%, #ffffff 100%)" }}>
        <div className="w-10 h-10 rounded-full animate-pulse" style={{ background: "var(--luna-pink)" }} />
      </div>
    }>
      <ChatContent />
    </Suspense>
  );
}