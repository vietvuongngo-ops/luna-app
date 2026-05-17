-- =============================================================================
-- schema_full.sql
-- Complete Luna schema — all modules 1-9 in FK-safe dependency order.
-- Run this against a blank database to create the full structure from scratch.
--
-- Dependency order:
--   1. Base tables (profiles, luna_0a_message)
--   2. TYPE tables (Xa) per module
--   3. EVENT tables (Xb) per module  — depend on profiles, message, and types
--   4. MAP tables (Xc/Xd/Xe) per module — depend on type tables
-- =============================================================================


-- =============================================================================
-- BASE TABLES (module 0)
-- =============================================================================

-- Profiles table (managed by Supabase Auth — included here as a stub reference)
-- CREATE TABLE profiles (
--   id         uuid PRIMARY KEY REFERENCES auth.users(id),
--   created_at timestamptz DEFAULT now()
-- );

CREATE TABLE IF NOT EXISTS luna_0a_message (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  content    text        NOT NULL,
  created_at timestamptz DEFAULT now()
);


-- =============================================================================
-- MODULE 1 — Emotion
-- =============================================================================

CREATE TABLE luna_1a_emotion_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_1b_emotion_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_1a_emotion_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_1c_emotion_need_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  -- TODO: confirm left_id and right_id target tables
  left_id  uuid REFERENCES luna_1a_emotion_types(id),
  right_id uuid
);


-- =============================================================================
-- MODULE 2 — Core Identity
-- Note: luna_2c_core_identity was renamed → luna_2c_core_identity_types
-- =============================================================================

-- luna_2a and luna_2b type/event tables — add here when names are confirmed
-- CREATE TABLE luna_2a_... (...);
-- CREATE TABLE luna_2b_... (...);

CREATE TABLE luna_2c_core_identity_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_2c_core_identity_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_2c_core_identity_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_2c_core_identity_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_2c_core_identity_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);


-- =============================================================================
-- MODULE 3 — Nervous System
-- =============================================================================

-- TODO: confirm exact name of module 3 type table
CREATE TABLE luna_3a_nervous_system_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_3b_nervous_system_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_3a_nervous_system_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_3c_nervous_system_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_3a_nervous_system_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);


-- =============================================================================
-- MODULE 4 — Life Phase
-- =============================================================================

-- TODO: confirm exact name of module 4 type table
CREATE TABLE luna_4a_life_phase_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- luna_4b event table — add here when name is confirmed
-- CREATE TABLE luna_4b_life_phase_events (...);

CREATE TABLE luna_4c_life_phase_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_4a_life_phase_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);


-- =============================================================================
-- MODULE 5 — Stress Response / Body Signal / Growth Path
-- =============================================================================

-- TODO: confirm exact names of module 5 type tables
CREATE TABLE luna_5a_stress_response_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_5a_body_signal_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_5a_growth_path_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- luna_5b event table — add here when name is confirmed
-- CREATE TABLE luna_5b_... (...);

CREATE TABLE luna_5c_stress_response_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_5a_stress_response_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_5d_body_signal_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_5a_body_signal_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);

CREATE TABLE luna_5e_growth_path_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_5a_growth_path_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);


-- =============================================================================
-- MODULE 6 — Strategy / Expression / Effect Space
-- =============================================================================

-- TODO: confirm exact names of module 6 type tables
CREATE TABLE luna_6a_core_strategy_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6a_expression_strategy_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6a_effect_space_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6b_core_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_6a_core_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6c_expression_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_6a_expression_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6d_effect_space_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_6a_effect_space_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_6c_strategy_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_6a_core_strategy_types(id),
  right_id uuid REFERENCES luna_6a_expression_strategy_types(id)
);


-- =============================================================================
-- MODULE 7 — Coping Strategy / Core Potential / Deep Potential / Being Potential
-- =============================================================================

-- TODO: confirm exact names of module 7 type tables
CREATE TABLE luna_7a_coping_strategy_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7a_core_potential_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7a_deep_potential_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7a_being_potential_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7b_coping_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_7a_coping_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7c_core_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_7a_core_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7d_deep_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_7a_deep_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7e_being_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_7a_being_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_7c_potential_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_7a_core_potential_types(id),
  right_id uuid REFERENCES luna_7a_deep_potential_types(id)
);


-- =============================================================================
-- MODULE 8 — Relationship / Values / Resources / Potential / Being
-- Note: luna_8b and luna_8c each have two event tables — confirm numbering.
-- =============================================================================

-- TODO: confirm exact names of module 8 type tables
CREATE TABLE luna_8a_coping_strategy_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8a_relationship_pattern_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8a_core_potential_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8a_resources_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8a_values_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8a_deep_potential_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8a_being_potential_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8b_coping_strategy_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_8a_coping_strategy_types(id),
  created_at timestamptz DEFAULT now()
);

-- Note: luna_8b used by two event tables — confirm whether this should be renamed.
CREATE TABLE luna_8b_relationship_pattern_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_8a_relationship_pattern_types(id),
  created_at timestamptz DEFAULT now()
);

-- Note: luna_8c used by two event tables — confirm whether this should be renamed.
CREATE TABLE luna_8c_core_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_8a_core_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8c_resources_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_8a_resources_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8d_deep_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_8a_deep_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8e_being_potential_events (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  message_id uuid        REFERENCES luna_0a_message(id),
  type_id    uuid        REFERENCES luna_8a_being_potential_types(id),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE luna_8c_values_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_8a_values_types(id),
  right_id uuid REFERENCES luna_8a_coping_strategy_types(id)
);


-- =============================================================================
-- MODULE 9 — Vision
-- =============================================================================

-- TODO: confirm exact name of module 9 type table
CREATE TABLE luna_9a_vision_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- luna_9b event table — add here when name is confirmed
-- CREATE TABLE luna_9b_vision_events (...);

CREATE TABLE luna_9c_vision_map (
  id       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  left_id  uuid REFERENCES luna_9a_vision_types(id),
  -- TODO: confirm right_id target type table
  right_id uuid
);
