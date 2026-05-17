-- =============================================================================
-- schema_diff.sql
-- Incremental changes only: rename + all newly created tables.
-- Apply this against an existing database that already has the base schema.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. RENAME
-- -----------------------------------------------------------------------------

-- luna_2c_core_identity was incorrectly used as an EVENT table.
-- It holds type/classification data and is renamed accordingly.
ALTER TABLE luna_2c_core_identity RENAME TO luna_2c_core_identity_types;


-- -----------------------------------------------------------------------------
-- 2. NEW EVENT TABLES
-- -----------------------------------------------------------------------------

CREATE TABLE luna_2c_core_identity_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_2c_core_identity_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_3b_nervous_system_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_3a_nervous_system_types assumed)
  type_id    uuid        REFERENCES luna_3a_nervous_system_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6b_core_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_6a_core_strategy_types assumed)
  type_id    uuid        REFERENCES luna_6a_core_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6c_expression_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_6a_expression_strategy_types assumed)
  type_id    uuid        REFERENCES luna_6a_expression_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6d_effect_space_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_6a_effect_space_types assumed)
  type_id    uuid        REFERENCES luna_6a_effect_space_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7b_coping_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_7a_coping_strategy_types assumed)
  type_id    uuid        REFERENCES luna_7a_coping_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7c_core_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_7a_core_potential_types assumed)
  type_id    uuid        REFERENCES luna_7a_core_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7d_deep_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_7a_deep_potential_types assumed)
  type_id    uuid        REFERENCES luna_7a_deep_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7e_being_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_7a_being_potential_types assumed)
  type_id    uuid        REFERENCES luna_7a_being_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8b_coping_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_coping_strategy_types assumed)
  type_id    uuid        REFERENCES luna_8a_coping_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

-- Note: luna_8b used by two event tables — confirm whether this should be renamed.
CREATE TABLE luna_8b_relationship_pattern_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_relationship_pattern_types assumed)
  type_id    uuid        REFERENCES luna_8a_relationship_pattern_types(id),
  created_at timestamptz DEFAULT now()
);

-- Note: luna_8c used by two event tables — confirm whether this should be renamed.
CREATE TABLE luna_8c_core_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_core_potential_types assumed)
  type_id    uuid        REFERENCES luna_8a_core_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8c_resources_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_resources_types assumed)
  type_id    uuid        REFERENCES luna_8a_resources_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8d_deep_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_deep_potential_types assumed)
  type_id    uuid        REFERENCES luna_8a_deep_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8e_being_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  -- TODO: confirm type table name (luna_8a_being_potential_types assumed)
  type_id    uuid        REFERENCES luna_8a_being_potential_types(id),
  created_at timestamptz DEFAULT now()
);


-- -----------------------------------------------------------------------------
-- 3. NEW MAP TABLES
-- -----------------------------------------------------------------------------

CREATE TABLE luna_2c_core_identity_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_2c_core_identity_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_3c_nervous_system_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_3a_nervous_system_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_4c_life_phase_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_4a_life_phase_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_5c_stress_response_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_5a_stress_response_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_5d_body_signal_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_5a_body_signal_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_5e_growth_path_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_5a_growth_path_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_6c_strategy_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_6a_core_strategy_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid REFERENCES luna_6a_expression_strategy_types(id)
);

CREATE TABLE luna_7c_potential_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_7a_core_potential_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid REFERENCES luna_7a_deep_potential_types(id)
);

CREATE TABLE luna_8c_values_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_8a_values_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid REFERENCES luna_8a_coping_strategy_types(id)
);

CREATE TABLE luna_9c_vision_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id target type table
  left_id  uuid REFERENCES luna_9a_vision_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);
