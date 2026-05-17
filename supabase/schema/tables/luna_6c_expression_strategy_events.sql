CREATE TABLE luna_6c_expression_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_6a_expression_strategy_types assumed)
  type_id    uuid        REFERENCES luna_6a_expression_strategy_types(id),
  created_at timestamptz DEFAULT now()
);
