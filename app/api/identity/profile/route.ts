import { NextResponse } from "next/server";

export async function GET() {
  const profile = {
    id: "123",
    email: "vu@example.com",
    firstName: "Vu",
    lastName: "Tran",
  };
  return NextResponse.json(profile);
}
