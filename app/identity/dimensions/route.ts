import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

export async function GET(req: Request) {
  const userId = req.headers.get("x-user-id");

  const { data, error } = await supabase
    .from("dimensions")
    .select("*")
    .eq("user_id", userId);

  if (error) return NextResponse.json([], { status: 500 });
  return NextResponse.json(data ?? []);
}

export async function PUT(req: Request) {
  const body = await req.json();

  const { data, error } = await supabase
    .from("dimensions")
    .update(body)
    .eq("id", body.id)
    .select()
    .single();

  if (error) return NextResponse.json({ error }, { status: 500 });
  return NextResponse.json(data);
}