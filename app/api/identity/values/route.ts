import { NextResponse } from "next/server";

export async function GET() {
  try {
    const data = [
      { id: 1, title: "Klarheit", description: "Fokus auf das Wesentliche" },
      { id: 2, title: "Vertrauen", description: "Selbst und andere stärken" },
      { id: 3, title: "Mut", description: "Entscheidungen treffen und handeln" },
    ];
    return NextResponse.json(data);
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: "Failed to load values" }, { status: 500 });
  }
}
