CREATE TABLE luna_8e_being_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_being_potential_types assumed)
  type_id    uuid        REFERENCES luna_8a_being_potential_types(id),
  created_at timestamptz DEFAULT now()
);
