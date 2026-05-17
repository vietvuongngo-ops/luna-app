CREATE TABLE luna_6d_effect_space_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_6a_effect_space_types assumed)
  type_id    uuid        REFERENCES luna_6a_effect_space_types(id),
  created_at timestamptz DEFAULT now()
);
