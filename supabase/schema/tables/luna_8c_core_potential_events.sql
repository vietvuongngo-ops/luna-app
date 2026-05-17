-- Note: luna_8c is used by two event tables (core_potential and resources).
-- Confirm whether one should be renamed to luna_8d or similar.
CREATE TABLE luna_8c_core_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_core_potential_types assumed)
  type_id    uuid        REFERENCES luna_8a_core_potential_types(id),
  created_at timestamptz DEFAULT now()
);
