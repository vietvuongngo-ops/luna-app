-- Note: luna_8b is used by two event tables (coping_strategy and relationship_pattern).
-- Confirm whether relationship_pattern_events should be renamed to luna_8c or similar.
CREATE TABLE luna_8b_relationship_pattern_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_relationship_pattern_types assumed)
  type_id    uuid        REFERENCES luna_8a_relationship_pattern_types(id),
  created_at timestamptz DEFAULT now()
);
