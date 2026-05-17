CREATE TABLE luna_3b_nervous_system_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_3a_nervous_system_types assumed)
  type_id    uuid        REFERENCES luna_3a_nervous_system_types(id),
  created_at timestamptz DEFAULT now()
);
