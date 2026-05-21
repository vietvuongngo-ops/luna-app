import { NextResponse } from "next/server";

export async function GET() {
  const goals = [
    { id: 1, title: "Wachstum", description: "Persönliche Entwicklung fördern" },
    { id: 2, title: "Balance", description: "Arbeit und Leben ausgleichen" },
  ];
  return NextResponse.json(goals);
}
