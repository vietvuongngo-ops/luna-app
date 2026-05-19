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

-- Seed/test profile table (NOT the Supabase Auth profiles table)
CREATE TABLE IF NOT EXISTS luna_0_profiles (
  id           integer     PRIMARY KEY,
  username     text        UNIQUE NOT NULL,
  display_name text        NOT NULL,
  created_at   timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_0a_message (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id uuid        REFERENCES profiles(id),
  content    text        NOT NULL,
  created_at timestamptz DEFAULT now()
);


-- =============================================================================
-- MODULE 1 — Emotion
-- =============================================================================

CREATE TABLE IF NOT EXISTS luna_1a_emotion_types (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text        UNIQUE NOT NULL,
  valenz       text,
  intensitaet  text,
  kategorie    text,
  created_at   timestamptz DEFAULT now()
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

CREATE TABLE IF NOT EXISTS luna_1a_need_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- luna_2a and luna_2b type tables
CREATE TABLE IF NOT EXISTS luna_2a_arche_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  ziel       text,
  staerke    text,
  schatten   text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_2b_identity_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_2b_core_motivation (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  wunsch     text,
  angst      text,
  antrieb    text,
  created_at timestamptz DEFAULT now()
);

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

-- Minimal stub (kept for FK references in luna_3b/3c)
CREATE TABLE IF NOT EXISTS luna_3a_nervous_system_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Full type table with nervous system details (Block 2 Stammdaten)
CREATE TABLE IF NOT EXISTS luna_3a_nervous_system (
  id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name           text        UNIQUE NOT NULL,
  system         text,
  empfindung     text,
  koerper_signal text,
  created_at     timestamptz DEFAULT now()
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

-- Minimal stub (kept for FK references in luna_4c)
CREATE TABLE IF NOT EXISTS luna_4a_life_phase_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Full type table with life phase details (Block 2 Stammdaten)
CREATE TABLE IF NOT EXISTS luna_4a_life_phase (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  alter_von  integer,
  alter_bis  integer,
  thema      text,
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

-- Block 2 type tables for Module 5
CREATE TABLE IF NOT EXISTS luna_5a_protective_pattern (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  funktion   text,
  ausloser   text,
  kosten     text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_5b_shadow_pattern (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text        UNIQUE NOT NULL,
  integration text,
  trigger     text,
  ressource   text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_5c_stress_response (
  id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name           text        UNIQUE NOT NULL,
  modus          text,
  koerper_signal text,
  gedanke        text,
  verhalten      text,
  created_at     timestamptz DEFAULT now()
);

-- Minimal stubs (kept for FK references in map tables)
-- TODO: confirm exact names of module 5 type tables
CREATE TABLE IF NOT EXISTS luna_5a_stress_response_types (
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
-- BLOCK 9 — Modul-Energie-Verknüpfung + Luna-Stimme
-- =============================================================================

CREATE TABLE IF NOT EXISTS luna_module_energy_map (
  id                  integer PRIMARY KEY,
  modul_id            integer,
  modul_name          text NOT NULL,
  primaer_profil_id   integer REFERENCES luna_energy_profile_types(id),
  sekundaer_profil_id integer REFERENCES luna_energy_profile_types(id),
  kombination_id      integer REFERENCES luna_tone_combinations(id),
  einstieg_satz       text,
  uebergangs_satz     text,
  abschluss_satz      text,
  warum               text
);

CREATE TABLE IF NOT EXISTS luna_voice_dna (
  id            integer PRIMARY KEY,
  kategorie     text NOT NULL,
  name          text NOT NULL,
  beschreibung  text,
  beispiel_mit  text,
  beispiel_ohne text,
  regel         text
);

CREATE TABLE IF NOT EXISTS luna_voice_patterns (
  id             integer PRIMARY KEY,
  moment         text NOT NULL,
  beschreibung   text,
  pattern_1      text,
  pattern_2      text,
  pattern_3      text,
  nie_sagen      text,
  energie_profil text
);


-- =============================================================================
-- BLOCK 8 — Memory, Voice & Transformation Layer
-- =============================================================================

-- System 1: Memory Layer
CREATE TABLE IF NOT EXISTS luna_user_memories (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         uuid,
  kategorie       text,
  inhalt          text NOT NULL,
  bedeutung       text,
  dimension_ref   text,
  emotional_tag   text,
  aktiv           boolean DEFAULT true,
  referenziert_am timestamptz,
  erstellt_am     timestamptz DEFAULT now()
);
CREATE TABLE IF NOT EXISTS luna_session_context (
  id                     uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                uuid,
  session_nummer         integer,
  datum                  timestamptz DEFAULT now(),
  emotional_state_id     integer REFERENCES luna_emotional_state_types(id),
  momentum_score         integer CHECK (momentum_score BETWEEN 0 AND 100),
  life_context_id        integer REFERENCES luna_life_context_types(id),
  energie_profil_id      integer REFERENCES luna_energy_profile_types(id),
  hauptthema             text,
  key_insight            text,
  offene_frage           text,
  naechste_session_focus text,
  abgeschlossen          boolean DEFAULT false,
  erstellt_am            timestamptz DEFAULT now()
);
CREATE TABLE IF NOT EXISTS luna_user_breakthroughs (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        uuid,
  titel          text NOT NULL,
  beschreibung   text,
  dimension_ref  text,
  milestone_id   integer REFERENCES luna_milestone_types(id),
  zitat          text,
  luna_reaktion  text,
  feierlich_am   timestamptz DEFAULT now(),
  aktiv_referenz boolean DEFAULT true
);

-- System 2: Voice & Tone Engine
CREATE TABLE IF NOT EXISTS luna_tone_rules (
  id                 integer PRIMARY KEY,
  name               text NOT NULL,
  beschreibung       text,
  emotional_state_id integer REFERENCES luna_emotional_state_types(id),
  momentum_min       integer DEFAULT 0,
  momentum_max       integer DEFAULT 100,
  energie_profil_id  integer REFERENCES luna_energy_profile_types(id),
  prioritaet         integer DEFAULT 5,
  begruendung        text
);
CREATE TABLE IF NOT EXISTS luna_tone_combinations (
  id                  integer PRIMARY KEY,
  name                text NOT NULL,
  primaer_profil_id   integer REFERENCES luna_energy_profile_types(id),
  sekundaer_profil_id integer REFERENCES luna_energy_profile_types(id),
  beschreibung        text,
  beispiel_einstieg   text,
  wann_nutzen         text
);
CREATE TABLE IF NOT EXISTS luna_tone_forbidden (
  id                   integer PRIMARY KEY,
  emotional_state_id   integer REFERENCES luna_emotional_state_types(id),
  verbotenes_profil_id integer REFERENCES luna_energy_profile_types(id),
  grund                text
);

-- System 3: Transformation Tracking
CREATE TABLE IF NOT EXISTS luna_transformation_snapshots (
  id                 uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id            uuid,
  typ                text NOT NULL,
  dimension_ref      text,
  selbstbeschreibung text NOT NULL,
  emotionaler_zustand text,
  glaubenssatz       text,
  koerper_gefuehl    text,
  momentum_score     integer CHECK (momentum_score BETWEEN 0 AND 100),
  erfasst_am         timestamptz DEFAULT now()
);
CREATE TABLE IF NOT EXISTS luna_win_types (
  id           integer PRIMARY KEY,
  name         text NOT NULL,
  kategorie    text,
  beschreibung text,
  emoji        text,
  luna_feier   text
);
CREATE TABLE IF NOT EXISTS luna_user_wins (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       uuid,
  win_type_id   integer REFERENCES luna_win_types(id),
  titel         text NOT NULL,
  beschreibung  text,
  dimension_ref text,
  milestone_id  integer REFERENCES luna_milestone_types(id),
  luna_reaktion text,
  user_zitat    text,
  gewonnen_am   timestamptz DEFAULT now(),
  feierlich     boolean DEFAULT true
);


-- =============================================================================
-- BLOCK 7 — Identity AI Layer
-- =============================================================================

-- 1. Identity State
CREATE TABLE IF NOT EXISTS luna_identity_state (
  id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             uuid,
  identity_staerkend  text,
  identity_loslassend text,
  energie_lebend      text,
  energie_brauchend   text,
  updated_at          timestamptz DEFAULT now(),
  created_at          timestamptz DEFAULT now()
);
CREATE TABLE IF NOT EXISTS luna_identity_state_types (
  id           integer PRIMARY KEY,
  kategorie    text NOT NULL,
  name         text NOT NULL,
  beschreibung text
);

-- 2. Emotional State
CREATE TABLE IF NOT EXISTS luna_emotional_state_types (
  id             integer PRIMARY KEY,
  name           text NOT NULL,
  name_de        text,
  valenz         text,
  energie        text,
  luna_reaktion  text,
  coaching_modus text
);
CREATE TABLE IF NOT EXISTS luna_user_emotional_state (
  id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 uuid,
  emotional_state_type_id integer REFERENCES luna_emotional_state_types(id),
  intensitaet             integer DEFAULT 3 CHECK (intensitaet BETWEEN 1 AND 5),
  kontext                 text,
  erfasst_am              timestamptz DEFAULT now()
);

-- 3. Intentions Tracking
CREATE TABLE IF NOT EXISTS luna_intention_types (
  id           integer PRIMARY KEY,
  name         text NOT NULL,
  beschreibung text,
  dimension    text,
  energie      text
);
CREATE TABLE IF NOT EXISTS luna_user_intentions (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           uuid,
  intention_type_id integer REFERENCES luna_intention_types(id),
  aktiv             boolean DEFAULT true,
  prioritaet        integer DEFAULT 1 CHECK (prioritaet BETWEEN 1 AND 3),
  notiz             text,
  gesetzt_am        timestamptz DEFAULT now(),
  erreicht_am       timestamptz
);

-- 4. Pattern Recognition
CREATE TABLE IF NOT EXISTS luna_pattern_types (
  id            integer PRIMARY KEY,
  name          text NOT NULL,
  kategorie     text,
  beschreibung  text,
  luna_reaktion text,
  schwellenwert integer
);
CREATE TABLE IF NOT EXISTS luna_user_patterns (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         uuid,
  pattern_type_id integer REFERENCES luna_pattern_types(id),
  erkannt_am      timestamptz DEFAULT now(),
  aktiv           boolean DEFAULT true,
  kontext         text
);

-- 5. Energy Profile
CREATE TABLE IF NOT EXISTS luna_energy_profile_types (
  id            integer PRIMARY KEY,
  name          text NOT NULL,
  beschreibung  text,
  sprache_stil  text,
  beispiel_satz text,
  farbe         text,
  passend_fuer  text
);
CREATE TABLE IF NOT EXISTS luna_user_energy_profile (
  id                     uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                uuid,
  energy_profile_type_id integer REFERENCES luna_energy_profile_types(id),
  aktiv                  boolean DEFAULT true,
  updated_at             timestamptz DEFAULT now()
);

-- 6. Relationship State
CREATE TABLE IF NOT EXISTS luna_relationship_state_types (
  id             integer PRIMARY KEY,
  name           text NOT NULL,
  beschreibung   text,
  luna_haltung   text,
  coaching_tiefe text
);
CREATE TABLE IF NOT EXISTS luna_user_relationship_state (
  id                         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                    uuid,
  relationship_state_type_id integer REFERENCES luna_relationship_state_types(id),
  vertrauens_score           integer DEFAULT 50 CHECK (vertrauens_score BETWEEN 0 AND 100),
  notiz                      text,
  updated_at                 timestamptz DEFAULT now()
);

-- 7. Life Context
CREATE TABLE IF NOT EXISTS luna_life_context_types (
  id             integer PRIMARY KEY,
  name           text NOT NULL,
  kategorie      text,
  beschreibung   text,
  luna_anpassung text
);
CREATE TABLE IF NOT EXISTS luna_user_life_context (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id              uuid,
  life_context_type_id integer REFERENCES luna_life_context_types(id),
  aktiv                boolean DEFAULT true,
  intensitaet          integer DEFAULT 3 CHECK (intensitaet BETWEEN 1 AND 5),
  erfasst_am           timestamptz DEFAULT now()
);

-- 8. Momentum Score
CREATE TABLE IF NOT EXISTS luna_momentum_score_types (
  id          integer PRIMARY KEY,
  name        text NOT NULL,
  bereich_von integer,
  bereich_bis integer,
  beschreibung text,
  luna_modus  text,
  farbe       text
);
CREATE TABLE IF NOT EXISTS luna_user_momentum (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       uuid,
  score         integer DEFAULT 50 CHECK (score BETWEEN 0 AND 100),
  score_type_id integer REFERENCES luna_momentum_score_types(id),
  berechnet_aus text,
  updated_at    timestamptz DEFAULT now(),
  created_at    timestamptz DEFAULT now()
);


-- =============================================================================
-- BLOCK 6 — Growth Engine
-- =============================================================================

CREATE TABLE IF NOT EXISTS luna_growth_dimensions (
  id                   integer     PRIMARY KEY,
  name                 text        UNIQUE NOT NULL,
  dimension_ref        text,
  beschreibung         text,
  messkriterium        text,
  stufe_1_bezeichnung  text,
  stufe_2_bezeichnung  text,
  stufe_3_bezeichnung  text,
  stufe_4_bezeichnung  text,
  stufe_5_bezeichnung  text,
  created_at           timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_milestone_types (
  id                  integer     PRIMARY KEY,
  growth_dimension_id integer     NOT NULL REFERENCES luna_growth_dimensions(id),
  stufe               integer     NOT NULL CHECK (stufe BETWEEN 1 AND 5),
  name                text,
  beschreibung        text,
  kriterium           text,
  coaching_impuls     text,
  naechster_schritt   text,
  created_at          timestamptz DEFAULT now()
);


-- =============================================================================
-- BLOCK 5 — Module & Programme
-- =============================================================================

CREATE TABLE IF NOT EXISTS luna_module_definitions (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  stufe      text,
  kernfrage  text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_programs (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text        UNIQUE NOT NULL,
  dauer        text,
  zielgruppe   text,
  beschreibung text,
  created_at   timestamptz DEFAULT now()
);


-- =============================================================================
-- BLOCK 3 — User Event & State Tables
-- =============================================================================

-- luna_4b_user_life_phase
CREATE TABLE IF NOT EXISTS luna_4b_user_life_phase (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id integer     REFERENCES luna_0_profiles(id),
  phase_name text        NOT NULL,
  notiz      text,
  created_at timestamptz DEFAULT now()
);

-- luna_5d_user_body_signal
CREATE TABLE IF NOT EXISTS luna_5d_user_body_signal (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id integer     REFERENCES luna_0_profiles(id),
  signal     text        NOT NULL,
  kontext    text,
  created_at timestamptz DEFAULT now()
);

-- luna_5e_user_growth_path
CREATE TABLE IF NOT EXISTS luna_5e_user_growth_path (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id  integer     REFERENCES luna_0_profiles(id),
  pfad        text        NOT NULL,
  fortschritt numeric,
  created_at  timestamptz DEFAULT now()
);

-- luna_5c_user_stress_response
CREATE TABLE IF NOT EXISTS luna_5c_user_stress_response (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id    integer     REFERENCES luna_0_profiles(id),
  response_name text        NOT NULL,
  notiz         text,
  created_at    timestamptz DEFAULT now()
);

-- luna_user_magic_moments
CREATE TABLE IF NOT EXISTS luna_user_magic_moments (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id   integer     REFERENCES luna_0_profiles(id),
  beschreibung text        NOT NULL,
  created_at   timestamptz DEFAULT now()
);

-- luna_user_needs
CREATE TABLE IF NOT EXISTS luna_user_needs (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id  integer     REFERENCES luna_0_profiles(id),
  need_name   text        NOT NULL,
  intensitaet numeric,
  created_at  timestamptz DEFAULT now()
);

-- luna_user_identity_phase
CREATE TABLE IF NOT EXISTS luna_user_identity_phase (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id    integer     REFERENCES luna_0_profiles(id),
  identity_name text        NOT NULL,
  created_at    timestamptz DEFAULT now()
);

-- luna_user_protection_patterns
CREATE TABLE IF NOT EXISTS luna_user_protection_patterns (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id   integer     REFERENCES luna_0_profiles(id),
  pattern_name text        NOT NULL,
  intensitaet  numeric,
  created_at   timestamptz DEFAULT now()
);

-- luna_user_scores
CREATE TABLE IF NOT EXISTS luna_user_scores (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id integer     REFERENCES luna_0_profiles(id),
  dimension  text        NOT NULL,
  score      numeric,
  created_at timestamptz DEFAULT now()
);

-- luna_user_journal
CREATE TABLE IF NOT EXISTS luna_user_journal (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id integer     REFERENCES luna_0_profiles(id),
  eintrag    text        NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- luna_user_progress
CREATE TABLE IF NOT EXISTS luna_user_progress (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id  integer     REFERENCES luna_0_profiles(id),
  modul       text        NOT NULL,
  fortschritt numeric,
  created_at  timestamptz DEFAULT now()
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

-- Block 4 type tables for Module 8
CREATE TABLE IF NOT EXISTS luna_8a_core_value_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  bereich    text,
  spannung   text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_8a_core_need_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_8b_coping_strategy (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  potenzial  text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_8b_relationship_pattern (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text        UNIQUE NOT NULL,
  bindungsstil text,
  muster       text,
  integration  text,
  created_at   timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_8d_deep_potential (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_8e_being_potential (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Minimal stubs (kept for FK references in event tables)
-- TODO: confirm exact names of module 8 type tables
CREATE TABLE IF NOT EXISTS luna_8a_coping_strategy_types (
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

-- Block 4 type table for Module 9
CREATE TABLE IF NOT EXISTS luna_9a_vision_archetypes (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  aufgabe    text,
  leitsatz   text,
  created_at timestamptz DEFAULT now()
);

-- Minimal stub (kept for FK references in luna_9c_vision_map)
-- TODO: confirm exact name of module 9 type table
CREATE TABLE IF NOT EXISTS luna_9a_vision_types (
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
