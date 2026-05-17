CREATE TABLE luna_7b_coping_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_7a_coping_strategy_types assumed)
  type_id    uuid        REFERENCES luna_7a_coping_strategy_types(id),
  created_at timestamptz DEFAULT now()
);
