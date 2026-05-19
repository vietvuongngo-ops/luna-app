-- =============================================================================
-- LUNA FRAMEWORK – BLOCK 1 SEED (STAMMDATEN)
-- Tabellen: luna_0_profiles, luna_1a_emotion_types, luna_1a_need_types,
--           luna_2a_arche_types, luna_2b_identity_types, luna_2b_core_motivation
--
-- REGELN:
--   - Kein DROP, TRUNCATE, DELETE, ON CONFLICT DO UPDATE
--   - CREATE TABLE IF NOT EXISTS für fehlende Tabellen
--   - ALTER TABLE ... ADD COLUMN IF NOT EXISTS für fehlende Spalten
--   - Alle Inserts: INSERT ... SELECT ... WHERE NOT EXISTS
--   - Parent-Tabellen vor Child-Tabellen
-- =============================================================================


-- =============================================================================
-- SCHRITT 1 – SCHEMA-ÜBERBLICK (informativ)
-- Führe diese Queries manuell aus, um den Ist-Stand zu prüfen:
--
-- SELECT column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name IN (
--   'luna_0_profiles','luna_1a_emotion_types','luna_1a_need_types',
--   'luna_2a_arche_types','luna_2b_identity_types','luna_2b_core_motivation'
-- )
-- ORDER BY table_name, ordinal_position;
-- =============================================================================


-- =============================================================================
-- SCHRITT 2 – CREATE TABLE IF NOT EXISTS / ALTER TABLE
-- Reihenfolge: Parent vor Child (FK-sicher)
-- =============================================================================

-- ----------------------------------------------------------------------------
-- luna_0_profiles  (Seed-/Test-Profiltabelle; von Supabase Auth getrennt)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_0_profiles (
  id           integer     PRIMARY KEY,
  username     text        UNIQUE NOT NULL,
  display_name text        NOT NULL,
  created_at   timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_1a_emotion_types  (existiert bereits – fehlende Spalten ergänzen)
-- ----------------------------------------------------------------------------
ALTER TABLE luna_1a_emotion_types
  ADD COLUMN IF NOT EXISTS valenz      text,
  ADD COLUMN IF NOT EXISTS intensitaet text,
  ADD COLUMN IF NOT EXISTS kategorie   text;

-- ----------------------------------------------------------------------------
-- luna_1a_need_types
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_1a_need_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_2a_arche_types
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_2a_arche_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  ziel       text,
  staerke    text,
  schatten   text,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_2b_identity_types
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_2b_identity_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_2b_core_motivation
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_2b_core_motivation (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  wunsch     text,
  angst      text,
  antrieb    text,
  created_at timestamptz DEFAULT now()
);


-- =============================================================================
-- SCHRITT 4 – SEED-DATEN (idempotent: INSERT ... WHERE NOT EXISTS)
-- =============================================================================


-- ----------------------------------------------------------------------------
-- luna_0_profiles  (3 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_0_profiles (id, username, display_name)
SELECT 1, 'test_user_1', 'Test User 1'
WHERE NOT EXISTS (SELECT 1 FROM luna_0_profiles WHERE id = 1);

INSERT INTO luna_0_profiles (id, username, display_name)
SELECT 2, 'test_user_2', 'Test User 2'
WHERE NOT EXISTS (SELECT 1 FROM luna_0_profiles WHERE id = 2);

INSERT INTO luna_0_profiles (id, username, display_name)
SELECT 3, 'demo_user', 'Demo User'
WHERE NOT EXISTS (SELECT 1 FROM luna_0_profiles WHERE id = 3);


-- ----------------------------------------------------------------------------
-- luna_1a_emotion_types  (12 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Freude', 'positiv', 'hoch', 'Grundemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Freude');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Trauer', 'negativ', 'mittel', 'Grundemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Trauer');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Wut', 'negativ', 'hoch', 'Grundemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Wut');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Angst', 'negativ', 'hoch', 'Grundemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Angst');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Scham', 'negativ', 'hoch', 'Sozialemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Scham');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Schuld', 'negativ', 'mittel', 'Sozialemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Schuld');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Ekel', 'negativ', 'mittel', 'Grundemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Ekel');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Überraschung', 'neutral', 'hoch', 'Grundemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Überraschung');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Sehnsucht', 'gemischt', 'mittel', 'Komplexemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Sehnsucht');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Einsamkeit', 'negativ', 'hoch', 'Komplexemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Einsamkeit');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Dankbarkeit', 'positiv', 'mittel', 'Komplexemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Dankbarkeit');

INSERT INTO luna_1a_emotion_types (name, valenz, intensitaet, kategorie)
SELECT 'Stolz', 'positiv', 'mittel', 'Sozialemotion'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_emotion_types WHERE name = 'Stolz');


-- ----------------------------------------------------------------------------
-- luna_1a_need_types  (10 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_1a_need_types (name)
SELECT 'Sicherheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Sicherheit');

INSERT INTO luna_1a_need_types (name)
SELECT 'Zugehörigkeit'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Zugehörigkeit');

INSERT INTO luna_1a_need_types (name)
SELECT 'Autonomie'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Autonomie');

INSERT INTO luna_1a_need_types (name)
SELECT 'Anerkennung'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Anerkennung');

INSERT INTO luna_1a_need_types (name)
SELECT 'Sinn'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Sinn');

INSERT INTO luna_1a_need_types (name)
SELECT 'Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Wachstum');

INSERT INTO luna_1a_need_types (name)
SELECT 'Intimität'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Intimität');

INSERT INTO luna_1a_need_types (name)
SELECT 'Ausdruck'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Ausdruck');

INSERT INTO luna_1a_need_types (name)
SELECT 'Ruhe'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Ruhe');

INSERT INTO luna_1a_need_types (name)
SELECT 'Integrität'
WHERE NOT EXISTS (SELECT 1 FROM luna_1a_need_types WHERE name = 'Integrität');


-- ----------------------------------------------------------------------------
-- luna_2a_arche_types  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Der Weise', 'Erkenntnis', 'Klarheit', 'Arroganz'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Der Weise');

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Die Liebende', 'Verbindung', 'Empathie', 'Aufopferung'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Die Liebende');

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Die Schöpferin', 'Ausdruck', 'Kreativität', 'Perfektionismus'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Die Schöpferin');

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Die Integrierte', 'Ganzheit', 'Authentizität', 'Selbstversunkenheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Die Integrierte');

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Die Navigatorin', 'Richtung', 'Entschlossenheit', 'Rigidität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Die Navigatorin');

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Die Verkörperte', 'Präsenz', 'Vitalität', 'Impulsivität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Die Verkörperte');

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Die Regenerierende', 'Fürsorge', 'Rhythmus', 'Rückzug'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Die Regenerierende');

INSERT INTO luna_2a_arche_types (name, ziel, staerke, schatten)
SELECT 'Die Wandlerin', 'Transformation', 'Anpassung', 'Instabilität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2a_arche_types WHERE name = 'Die Wandlerin');


-- ----------------------------------------------------------------------------
-- luna_2b_identity_types  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_2b_identity_types (name)
SELECT 'Leistungsidentität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Leistungsidentität');

INSERT INTO luna_2b_identity_types (name)
SELECT 'Beziehungsidentität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Beziehungsidentität');

INSERT INTO luna_2b_identity_types (name)
SELECT 'Rollenidentität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Rollenidentität');

INSERT INTO luna_2b_identity_types (name)
SELECT 'Wertidentität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Wertidentität');

INSERT INTO luna_2b_identity_types (name)
SELECT 'Körperidentität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Körperidentität');

INSERT INTO luna_2b_identity_types (name)
SELECT 'Kreatividentität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Kreatividentität');

INSERT INTO luna_2b_identity_types (name)
SELECT 'Spirituelle Identität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Spirituelle Identität');

INSERT INTO luna_2b_identity_types (name)
SELECT 'Transformationsidentität'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_identity_types WHERE name = 'Transformationsidentität');


-- ----------------------------------------------------------------------------
-- luna_2b_core_motivation  (9 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Perfektion', 'Richtig sein', 'Fehler machen', 'Gut sein'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Perfektion');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Verbindung', 'Geliebt sein', 'Ungeliebt sein', 'Geliebt werden'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Verbindung');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Erfolg', 'Erreichen', 'Versagen', 'Wertvoll sein'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Erfolg');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Einzigartigkeit', 'Bedeutsam sein', 'Identitätsverlust', 'Sich finden'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Einzigartigkeit');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Erkenntnis', 'Verstehen', 'Unfähigkeit', 'Kompetenz'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Erkenntnis');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Sicherheit', 'Geborgenheit', 'Haltlosigkeit', 'Sicherheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Sicherheit');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Freiheit', 'Erleben', 'Einschränkung', 'Zufriedenheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Freiheit');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Stärke', 'Kontrolle', 'Ohnmacht', 'Schutz'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Stärke');

INSERT INTO luna_2b_core_motivation (name, wunsch, angst, antrieb)
SELECT 'Frieden', 'Harmonie', 'Trennung', 'Innerer Frieden'
WHERE NOT EXISTS (SELECT 1 FROM luna_2b_core_motivation WHERE name = 'Frieden');


-- =============================================================================
-- SCHRITT 5 – BLOCK-PRÜFUNG
-- Erwartete Zeilenzahlen: profiles=3, emotion=12, need=10, arche=8, identity=8, motivation=9
-- =============================================================================

SELECT 'luna_0_profiles'          AS tabelle, COUNT(*) AS zeilen FROM luna_0_profiles
UNION ALL
SELECT 'luna_1a_emotion_types'    AS tabelle, COUNT(*) AS zeilen FROM luna_1a_emotion_types
UNION ALL
SELECT 'luna_1a_need_types'       AS tabelle, COUNT(*) AS zeilen FROM luna_1a_need_types
UNION ALL
SELECT 'luna_2a_arche_types'      AS tabelle, COUNT(*) AS zeilen FROM luna_2a_arche_types
UNION ALL
SELECT 'luna_2b_identity_types'   AS tabelle, COUNT(*) AS zeilen FROM luna_2b_identity_types
UNION ALL
SELECT 'luna_2b_core_motivation'  AS tabelle, COUNT(*) AS zeilen FROM luna_2b_core_motivation;
