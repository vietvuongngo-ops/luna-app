-- =============================================================================
-- LUNA FRAMEWORK – BLOCK 3 SEED (EVENTS & USER)
-- Tabellen: luna_1b_emotion_events, luna_2c_core_identity_map,
--           luna_3b_nervous_system_events, luna_4b_user_life_phase,
--           luna_5d_user_body_signal, luna_5e_user_growth_path,
--           luna_5c_user_stress_response, luna_user_magic_moments,
--           luna_user_needs, luna_user_identity_phase,
--           luna_user_protection_patterns, luna_user_scores,
--           luna_user_journal, luna_user_progress
--
-- REGELN:
--   - Kein DROP, TRUNCATE, DELETE, ON CONFLICT DO UPDATE
--   - ALTER TABLE ... ADD COLUMN IF NOT EXISTS für bestehende Tabellen
--   - CREATE TABLE IF NOT EXISTS für neue Tabellen
--   - Alle Inserts: INSERT ... SELECT ... WHERE NOT EXISTS
--   - Parent-Tabellen vor Child-Tabellen
--
-- DESIGN-ENTSCHEIDUNGEN:
--   - Bestehende Event-Tabellen referenzieren profiles(id) (Supabase Auth UUID).
--     Seed-Profile liegen in luna_0_profiles (integer). Daher:
--       profile_id = NULL in bestehenden Tabellen
--       profile_username text = Tracking-Spalte für Seed-Referenz
--     type_id in luna_1b wird per Subquery auf luna_1a_emotion_types.name aufgelöst.
--   - Neue luna_user_* Tabellen: profile_id integer REFERENCES luna_0_profiles(id)
-- =============================================================================


-- =============================================================================
-- SCHRITT 1 – SCHEMA-ÜBERBLICK (informativ)
-- Führe diese Query manuell aus, um den Ist-Stand zu prüfen:
--
-- SELECT table_name, column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name IN (
--   'luna_1b_emotion_events','luna_2c_core_identity_map',
--   'luna_3b_nervous_system_events','luna_4b_user_life_phase',
--   'luna_5d_user_body_signal','luna_5e_user_growth_path',
--   'luna_5c_user_stress_response','luna_user_magic_moments',
--   'luna_user_needs','luna_user_identity_phase',
--   'luna_user_protection_patterns','luna_user_scores',
--   'luna_user_journal','luna_user_progress'
-- )
-- ORDER BY table_name, ordinal_position;
-- =============================================================================


-- =============================================================================
-- SCHRITT 2A – ALTER TABLE (bestehende Tabellen erweitern)
-- =============================================================================

-- luna_1b_emotion_events: +notiz, +profile_username
ALTER TABLE luna_1b_emotion_events
  ADD COLUMN IF NOT EXISTS notiz            text,
  ADD COLUMN IF NOT EXISTS profile_username text;

-- luna_2c_core_identity_map: +arche/identity/motivation als Text + gewicht
ALTER TABLE luna_2c_core_identity_map
  ADD COLUMN IF NOT EXISTS profile_username text,
  ADD COLUMN IF NOT EXISTS arche_name       text,
  ADD COLUMN IF NOT EXISTS identity_name    text,
  ADD COLUMN IF NOT EXISTS motivation_name  text,
  ADD COLUMN IF NOT EXISTS gewicht          numeric;

-- luna_3b_nervous_system_events: +notiz, +profile_username, +ns_name
ALTER TABLE luna_3b_nervous_system_events
  ADD COLUMN IF NOT EXISTS notiz            text,
  ADD COLUMN IF NOT EXISTS profile_username text,
  ADD COLUMN IF NOT EXISTS ns_name          text;


-- =============================================================================
-- SCHRITT 2B – CREATE TABLE IF NOT EXISTS (neue Tabellen)
-- Reihenfolge: luna_0_profiles muss bereits existieren (Block 1 Seed)
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
-- SCHRITT 4 – SEED-DATEN (idempotent: INSERT ... SELECT ... WHERE NOT EXISTS)
-- Typ-Indizes werden per Name aufgelöst (Subquery auf Block-1/2-Tabellen).
-- =============================================================================


-- ----------------------------------------------------------------------------
-- luna_1b_emotion_events  (4 Zeilen)
-- profile_id = NULL (Supabase Auth), type_id via Subquery auf name
-- Index-Mapping: 1=Freude, 2=Trauer, 3=Wut, 11=Dankbarkeit
-- ----------------------------------------------------------------------------

INSERT INTO luna_1b_emotion_events (profile_username, type_id, notiz, created_at)
SELECT
  'test_user_1',
  (SELECT id FROM luna_1a_emotion_types WHERE name = 'Freude'),
  'Freude über Fortschritt',
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_1b_emotion_events
  WHERE profile_username = 'test_user_1' AND notiz = 'Freude über Fortschritt'
);

INSERT INTO luna_1b_emotion_events (profile_username, type_id, notiz, created_at)
SELECT
  'test_user_1',
  (SELECT id FROM luna_1a_emotion_types WHERE name = 'Wut'),
  'Wut über Blockade',
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_1b_emotion_events
  WHERE profile_username = 'test_user_1' AND notiz = 'Wut über Blockade'
);

INSERT INTO luna_1b_emotion_events (profile_username, type_id, notiz, created_at)
SELECT
  'test_user_2',
  (SELECT id FROM luna_1a_emotion_types WHERE name = 'Trauer'),
  'Trauer über Verlust',
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_1b_emotion_events
  WHERE profile_username = 'test_user_2' AND notiz = 'Trauer über Verlust'
);

INSERT INTO luna_1b_emotion_events (profile_username, type_id, notiz, created_at)
SELECT
  'demo_user',
  (SELECT id FROM luna_1a_emotion_types WHERE name = 'Dankbarkeit'),
  'Dankbarkeit im Coaching',
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_1b_emotion_events
  WHERE profile_username = 'demo_user' AND notiz = 'Dankbarkeit im Coaching'
);


-- ----------------------------------------------------------------------------
-- luna_2c_core_identity_map  (4 Zeilen)
-- left_id/right_id = NULL (Stub-Spalten), Typen als Text gespeichert
-- Index-Mapping Archetypen: 1=Der Weise, 2=Die Liebende, 3=Die Schöpferin,
--   5=Die Navigatorin
-- Index-Mapping Identitäten: 2=Beziehungsidentität, 4=Wertidentität,
--   6=Kreatividentität, 7=Spirituelle Identität
-- Index-Mapping Motivationen: 1=Perfektion, 2=Verbindung, 4=Einzigartigkeit,
--   5=Erkenntnis
-- ----------------------------------------------------------------------------

INSERT INTO luna_2c_core_identity_map
  (profile_username, arche_name, identity_name, motivation_name, gewicht)
SELECT
  'test_user_1', 'Die Schöpferin', 'Kreatividentität', 'Einzigartigkeit', 0.8
WHERE NOT EXISTS (
  SELECT 1 FROM luna_2c_core_identity_map
  WHERE profile_username = 'test_user_1' AND arche_name = 'Die Schöpferin'
);

INSERT INTO luna_2c_core_identity_map
  (profile_username, arche_name, identity_name, motivation_name, gewicht)
SELECT
  'test_user_1', 'Die Navigatorin', 'Wertidentität', 'Perfektion', 0.6
WHERE NOT EXISTS (
  SELECT 1 FROM luna_2c_core_identity_map
  WHERE profile_username = 'test_user_1' AND arche_name = 'Die Navigatorin'
);

INSERT INTO luna_2c_core_identity_map
  (profile_username, arche_name, identity_name, motivation_name, gewicht)
SELECT
  'test_user_2', 'Die Liebende', 'Beziehungsidentität', 'Verbindung', 0.7
WHERE NOT EXISTS (
  SELECT 1 FROM luna_2c_core_identity_map
  WHERE profile_username = 'test_user_2' AND arche_name = 'Die Liebende'
);

INSERT INTO luna_2c_core_identity_map
  (profile_username, arche_name, identity_name, motivation_name, gewicht)
SELECT
  'demo_user', 'Der Weise', 'Spirituelle Identität', 'Erkenntnis', 0.9
WHERE NOT EXISTS (
  SELECT 1 FROM luna_2c_core_identity_map
  WHERE profile_username = 'demo_user' AND arche_name = 'Der Weise'
);


-- ----------------------------------------------------------------------------
-- luna_3b_nervous_system_events  (4 Zeilen)
-- profile_id = NULL, type_id = NULL (luna_3a_nervous_system_types ist leer),
-- ns_name als Referenz
-- Index-Mapping: 1=Sicherer Anker, 2=Kampf-Flucht, 3=Erstarrung, 5=Kohärenz
-- ----------------------------------------------------------------------------

INSERT INTO luna_3b_nervous_system_events
  (profile_username, ns_name, notiz, created_at)
SELECT 'test_user_1', 'Sicherer Anker', 'Ruhiger Zustand', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_3b_nervous_system_events
  WHERE profile_username = 'test_user_1' AND notiz = 'Ruhiger Zustand'
);

INSERT INTO luna_3b_nervous_system_events
  (profile_username, ns_name, notiz, created_at)
SELECT 'test_user_1', 'Kampf-Flucht', 'Stress im Alltag', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_3b_nervous_system_events
  WHERE profile_username = 'test_user_1' AND notiz = 'Stress im Alltag'
);

INSERT INTO luna_3b_nervous_system_events
  (profile_username, ns_name, notiz, created_at)
SELECT 'test_user_2', 'Erstarrung', 'Erschöpfung', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_3b_nervous_system_events
  WHERE profile_username = 'test_user_2' AND notiz = 'Erschöpfung'
);

INSERT INTO luna_3b_nervous_system_events
  (profile_username, ns_name, notiz, created_at)
SELECT 'demo_user', 'Kohärenz', 'Kohärenz erreicht', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_3b_nervous_system_events
  WHERE profile_username = 'demo_user' AND notiz = 'Kohärenz erreicht'
);


-- ----------------------------------------------------------------------------
-- luna_4b_user_life_phase  (3 Zeilen)
-- Index-Mapping: 4=Etablierung, 5=Sinnkrise, 6=Reife
-- ----------------------------------------------------------------------------

INSERT INTO luna_4b_user_life_phase (profile_id, phase_name, notiz)
SELECT 1, 'Etablierung', 'Karriereaufbau'
WHERE NOT EXISTS (
  SELECT 1 FROM luna_4b_user_life_phase WHERE profile_id = 1 AND phase_name = 'Etablierung'
);

INSERT INTO luna_4b_user_life_phase (profile_id, phase_name, notiz)
SELECT 2, 'Sinnkrise', 'Neuorientierung'
WHERE NOT EXISTS (
  SELECT 1 FROM luna_4b_user_life_phase WHERE profile_id = 2 AND phase_name = 'Sinnkrise'
);

INSERT INTO luna_4b_user_life_phase (profile_id, phase_name, notiz)
SELECT 3, 'Reife', 'Reifephase'
WHERE NOT EXISTS (
  SELECT 1 FROM luna_4b_user_life_phase WHERE profile_id = 3 AND phase_name = 'Reife'
);


-- ----------------------------------------------------------------------------
-- luna_5d_user_body_signal  (3 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_5d_user_body_signal (profile_id, signal, kontext, created_at)
SELECT 1, 'Enge Brust', 'Stress', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5d_user_body_signal WHERE profile_id = 1 AND signal = 'Enge Brust'
);

INSERT INTO luna_5d_user_body_signal (profile_id, signal, kontext, created_at)
SELECT 2, 'Schwere Glieder', 'Erschöpfung', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5d_user_body_signal WHERE profile_id = 2 AND signal = 'Schwere Glieder'
);

INSERT INTO luna_5d_user_body_signal (profile_id, signal, kontext, created_at)
SELECT 3, 'Weicher Bauch', 'Ruhe', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5d_user_body_signal WHERE profile_id = 3 AND signal = 'Weicher Bauch'
);


-- ----------------------------------------------------------------------------
-- luna_5e_user_growth_path  (4 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_5e_user_growth_path (profile_id, pfad, fortschritt)
SELECT 1, 'Selbstkenntnis', 0.4
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5e_user_growth_path WHERE profile_id = 1 AND pfad = 'Selbstkenntnis'
);

INSERT INTO luna_5e_user_growth_path (profile_id, pfad, fortschritt)
SELECT 1, 'Schattenarbeit', 0.2
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5e_user_growth_path WHERE profile_id = 1 AND pfad = 'Schattenarbeit'
);

INSERT INTO luna_5e_user_growth_path (profile_id, pfad, fortschritt)
SELECT 2, 'Beziehungsarbeit', 0.3
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5e_user_growth_path WHERE profile_id = 2 AND pfad = 'Beziehungsarbeit'
);

INSERT INTO luna_5e_user_growth_path (profile_id, pfad, fortschritt)
SELECT 3, 'Being & Präsenz', 0.5
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5e_user_growth_path WHERE profile_id = 3 AND pfad = 'Being & Präsenz'
);


-- ----------------------------------------------------------------------------
-- luna_5c_user_stress_response  (3 Zeilen)
-- Index-Mapping: 1=Kampf, 3=Erstarrung, 5=Kollaps
-- ----------------------------------------------------------------------------

INSERT INTO luna_5c_user_stress_response (profile_id, response_name, notiz, created_at)
SELECT 1, 'Kampf', 'Konflikt im Job', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5c_user_stress_response WHERE profile_id = 1 AND response_name = 'Kampf'
);

INSERT INTO luna_5c_user_stress_response (profile_id, response_name, notiz, created_at)
SELECT 2, 'Erstarrung', 'Überforderung', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5c_user_stress_response WHERE profile_id = 2 AND response_name = 'Erstarrung'
);

INSERT INTO luna_5c_user_stress_response (profile_id, response_name, notiz, created_at)
SELECT 3, 'Kollaps', 'Shutdown nach Stress', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_5c_user_stress_response WHERE profile_id = 3 AND response_name = 'Kollaps'
);


-- ----------------------------------------------------------------------------
-- luna_user_magic_moments  (3 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_magic_moments (profile_id, beschreibung, created_at)
SELECT 1, 'Aha-Moment im Coaching', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_magic_moments WHERE profile_id = 1 AND beschreibung = 'Aha-Moment im Coaching'
);

INSERT INTO luna_user_magic_moments (profile_id, beschreibung, created_at)
SELECT 2, 'Tiefe Erkenntnis', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_magic_moments WHERE profile_id = 2 AND beschreibung = 'Tiefe Erkenntnis'
);

INSERT INTO luna_user_magic_moments (profile_id, beschreibung, created_at)
SELECT 3, 'Durchbruch', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_magic_moments WHERE profile_id = 3 AND beschreibung = 'Durchbruch'
);


-- ----------------------------------------------------------------------------
-- luna_user_needs  (4 Zeilen)
-- Index-Mapping: 1=Sicherheit, 2=Zugehörigkeit, 3=Autonomie, 5=Sinn
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_needs (profile_id, need_name, intensitaet)
SELECT 1, 'Autonomie', 0.8
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_needs WHERE profile_id = 1 AND need_name = 'Autonomie'
);

INSERT INTO luna_user_needs (profile_id, need_name, intensitaet)
SELECT 1, 'Sinn', 0.6
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_needs WHERE profile_id = 1 AND need_name = 'Sinn'
);

INSERT INTO luna_user_needs (profile_id, need_name, intensitaet)
SELECT 2, 'Zugehörigkeit', 0.7
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_needs WHERE profile_id = 2 AND need_name = 'Zugehörigkeit'
);

INSERT INTO luna_user_needs (profile_id, need_name, intensitaet)
SELECT 3, 'Sicherheit', 0.9
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_needs WHERE profile_id = 3 AND need_name = 'Sicherheit'
);


-- ----------------------------------------------------------------------------
-- luna_user_identity_phase  (3 Zeilen)
-- Index-Mapping: 2=Beziehungsidentität, 4=Wertidentität, 7=Spirituelle Identität
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_identity_phase (profile_id, identity_name, created_at)
SELECT 1, 'Wertidentität', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_identity_phase WHERE profile_id = 1 AND identity_name = 'Wertidentität'
);

INSERT INTO luna_user_identity_phase (profile_id, identity_name, created_at)
SELECT 2, 'Beziehungsidentität', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_identity_phase WHERE profile_id = 2 AND identity_name = 'Beziehungsidentität'
);

INSERT INTO luna_user_identity_phase (profile_id, identity_name, created_at)
SELECT 3, 'Spirituelle Identität', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_identity_phase WHERE profile_id = 3 AND identity_name = 'Spirituelle Identität'
);


-- ----------------------------------------------------------------------------
-- luna_user_protection_patterns  (3 Zeilen)
-- Index-Mapping: 1=Perfektionismus, 3=Rückzug, 8=Rebellion
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_protection_patterns (profile_id, pattern_name, intensitaet)
SELECT 1, 'Perfektionismus', 0.7
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_protection_patterns WHERE profile_id = 1 AND pattern_name = 'Perfektionismus'
);

INSERT INTO luna_user_protection_patterns (profile_id, pattern_name, intensitaet)
SELECT 2, 'Rückzug', 0.6
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_protection_patterns WHERE profile_id = 2 AND pattern_name = 'Rückzug'
);

INSERT INTO luna_user_protection_patterns (profile_id, pattern_name, intensitaet)
SELECT 3, 'Rebellion', 0.8
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_protection_patterns WHERE profile_id = 3 AND pattern_name = 'Rebellion'
);


-- ----------------------------------------------------------------------------
-- luna_user_scores  (3 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_scores (profile_id, dimension, score)
SELECT 1, 'clarity', 0.72
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_scores WHERE profile_id = 1 AND dimension = 'clarity'
);

INSERT INTO luna_user_scores (profile_id, dimension, score)
SELECT 2, 'presence', 0.65
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_scores WHERE profile_id = 2 AND dimension = 'presence'
);

INSERT INTO luna_user_scores (profile_id, dimension, score)
SELECT 3, 'growth', 0.81
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_scores WHERE profile_id = 3 AND dimension = 'growth'
);


-- ----------------------------------------------------------------------------
-- luna_user_journal  (3 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_journal (profile_id, eintrag, created_at)
SELECT 1, 'Heute viel Klarheit gewonnen', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_journal WHERE profile_id = 1 AND eintrag = 'Heute viel Klarheit gewonnen'
);

INSERT INTO luna_user_journal (profile_id, eintrag, created_at)
SELECT 2, 'Tiefe Emotionen gespürt', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_journal WHERE profile_id = 2 AND eintrag = 'Tiefe Emotionen gespürt'
);

INSERT INTO luna_user_journal (profile_id, eintrag, created_at)
SELECT 3, 'Neue Perspektive entdeckt', now()
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_journal WHERE profile_id = 3 AND eintrag = 'Neue Perspektive entdeckt'
);


-- ----------------------------------------------------------------------------
-- luna_user_progress  (3 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_progress (profile_id, modul, fortschritt)
SELECT 1, 'Modul 1', 0.3
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_progress WHERE profile_id = 1 AND modul = 'Modul 1'
);

INSERT INTO luna_user_progress (profile_id, modul, fortschritt)
SELECT 2, 'Modul 2', 0.5
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_progress WHERE profile_id = 2 AND modul = 'Modul 2'
);

INSERT INTO luna_user_progress (profile_id, modul, fortschritt)
SELECT 3, 'Modul 3', 0.7
WHERE NOT EXISTS (
  SELECT 1 FROM luna_user_progress WHERE profile_id = 3 AND modul = 'Modul 3'
);


-- =============================================================================
-- SCHRITT 5 – BLOCK-PRÜFUNG
-- Erwartete Zeilenzahlen:
--   emotion_events=4, core_identity_map=4, nervous_system_events=4,
--   user_life_phase=3, body_signal=3, growth_path=4, stress_response=3,
--   magic_moments=3, needs=4, identity_phase=3, protection_patterns=3,
--   scores=3, journal=3, progress=3
-- =============================================================================

SELECT 'luna_1b_emotion_events'        AS tabelle, COUNT(*) AS zeilen FROM luna_1b_emotion_events
UNION ALL
SELECT 'luna_2c_core_identity_map'     AS tabelle, COUNT(*) AS zeilen FROM luna_2c_core_identity_map
UNION ALL
SELECT 'luna_3b_nervous_system_events' AS tabelle, COUNT(*) AS zeilen FROM luna_3b_nervous_system_events
UNION ALL
SELECT 'luna_4b_user_life_phase'       AS tabelle, COUNT(*) AS zeilen FROM luna_4b_user_life_phase
UNION ALL
SELECT 'luna_5d_user_body_signal'      AS tabelle, COUNT(*) AS zeilen FROM luna_5d_user_body_signal
UNION ALL
SELECT 'luna_5e_user_growth_path'      AS tabelle, COUNT(*) AS zeilen FROM luna_5e_user_growth_path
UNION ALL
SELECT 'luna_5c_user_stress_response'  AS tabelle, COUNT(*) AS zeilen FROM luna_5c_user_stress_response
UNION ALL
SELECT 'luna_user_magic_moments'       AS tabelle, COUNT(*) AS zeilen FROM luna_user_magic_moments
UNION ALL
SELECT 'luna_user_needs'               AS tabelle, COUNT(*) AS zeilen FROM luna_user_needs
UNION ALL
SELECT 'luna_user_identity_phase'      AS tabelle, COUNT(*) AS zeilen FROM luna_user_identity_phase
UNION ALL
SELECT 'luna_user_protection_patterns' AS tabelle, COUNT(*) AS zeilen FROM luna_user_protection_patterns
UNION ALL
SELECT 'luna_user_scores'              AS tabelle, COUNT(*) AS zeilen FROM luna_user_scores
UNION ALL
SELECT 'luna_user_journal'             AS tabelle, COUNT(*) AS zeilen FROM luna_user_journal
UNION ALL
SELECT 'luna_user_progress'            AS tabelle, COUNT(*) AS zeilen FROM luna_user_progress;
