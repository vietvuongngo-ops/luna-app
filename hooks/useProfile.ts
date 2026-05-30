import { useState, useEffect } from "react";
import { supabase } from "@/lib/supabase";

export function useProfile() {
  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  async function fetchProfile(userId: string) {
    try {
      const { data, error } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", userId)
        .single();

      if (error) throw error;

      setProfile(data);
    } catch (err: any) {
      setError(err.message ?? "Profil konnte nicht geladen werden.");
      setProfile(null);
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    // Initialer Load
    supabase.auth.getUser().then(({ data: { user } }) => {
      if (!user) {
        setLoading(false);
        return;
      }
      fetchProfile(user.id);
    });

    // Auth-State-Listener: reagiert auf Login/Logout
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (_event, session) => {
        if (session?.user) {
          setLoading(true);
          fetchProfile(session.user.id);
        } else {
          setProfile(null);
          setLoading(false);
        }
      }
    );

    return () => subscription.unsubscribe();
  }, []);

  return { profile, loading, error };
}
