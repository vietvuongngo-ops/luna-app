CREATE TABLE luna_2c_core_identity_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_2c_core_identity_types(id),
  created_at timestamptz DEFAULT now()
);
