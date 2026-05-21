import { NextResponse } from "next/server";

export async function GET() {
  const archetypes = [
    { id: 1, name: "Visionär", description: "Sieht Möglichkeiten und inspiriert andere" },
    { id: 2, name: "Analytiker", description: "Denkt strukturiert und präzise" },
  ];
  return NextResponse.json(archetypes);
}
