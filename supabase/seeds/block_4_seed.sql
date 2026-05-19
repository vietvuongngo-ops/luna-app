-- =============================================================================
-- LUNA FRAMEWORK – BLOCK 4 SEED (POTENZIALE)
-- Tabellen: luna_8a_core_value_types, luna_8a_core_need_types,
--           luna_8b_coping_strategy, luna_8b_relationship_pattern,
--           luna_8d_deep_potential (CREATE ONLY – bereits befüllt),
--           luna_8e_being_potential (CREATE ONLY – bereits befüllt),
--           luna_9a_vision_archetypes
--
-- REGELN:
--   - Kein DROP, TRUNCATE, DELETE, ON CONFLICT DO UPDATE
--   - CREATE TABLE IF NOT EXISTS für alle Tabellen
--   - Alle Inserts: INSERT ... SELECT ... WHERE NOT EXISTS
--   - luna_8d_deep_potential + luna_8e_being_potential: CREATE ONLY, keine Inserts
-- =============================================================================


-- =============================================================================
-- SCHRITT 1 – SCHEMA-ÜBERBLICK (informativ)
-- Führe diese Query manuell aus, um den Ist-Stand zu prüfen:
--
-- SELECT table_name, column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name IN (
--   'luna_8a_core_value_types','luna_8a_core_need_types',
--   'luna_8b_coping_strategy','luna_8b_relationship_pattern',
--   'luna_8d_deep_potential','luna_8e_being_potential',
--   'luna_9a_vision_archetypes'
-- )
-- ORDER BY table_name, ordinal_position;
-- =============================================================================


-- =============================================================================
-- SCHRITT 2 – CREATE TABLE IF NOT EXISTS
-- =============================================================================

-- ----------------------------------------------------------------------------
-- luna_8a_core_value_types
-- Spalten: name | bereich | spannung
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_8a_core_value_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  bereich    text,
  spannung   text,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_8a_core_need_types
-- Spalten: name (identisch zu luna_1a_need_types)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_8a_core_need_types (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_8b_coping_strategy
-- Spalten: name | potenzial
-- (Hinweis: luna_8b_coping_strategy_events ist ein separater Event-Table)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_8b_coping_strategy (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  potenzial  text,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_8b_relationship_pattern
-- Spalten: name | bindungsstil | muster | integration
-- (Hinweis: luna_8b_relationship_pattern_events ist ein separater Event-Table)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_8b_relationship_pattern (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name          text        UNIQUE NOT NULL,
  bindungsstil  text,
  muster        text,
  integration   text,
  created_at    timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_8d_deep_potential
-- BEREITS BEFÜLLT – CREATE ONLY, keine Inserts
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_8d_deep_potential (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_8e_being_potential
-- BEREITS BEFÜLLT – CREATE ONLY, keine Inserts
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_8e_being_potential (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_9a_vision_archetypes
-- Spalten: name | aufgabe | leitsatz
-- (Hinweis: luna_9a_vision_types ist ein separater Minimal-Stub)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_9a_vision_archetypes (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  aufgabe    text,
  leitsatz   text,
  created_at timestamptz DEFAULT now()
);


-- =============================================================================
-- SCHRITT 4 – SEED-DATEN (idempotent: INSERT ... SELECT ... WHERE NOT EXISTS)
-- =============================================================================


-- ----------------------------------------------------------------------------
-- luna_8a_core_value_types  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Authentizität', 'Selbstkern', 'Sein vs. Performen'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Authentizität');

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Verbindung', 'Beziehungsfeld', 'Tiefe vs. Breite'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Verbindung');

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Schöpfung', 'Schöpferkraft', 'Erschaffen vs. Verwalten'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Schöpfung');

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Integrität', 'Schattenpotenzial', 'Ganzheit vs. Spaltung'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Integrität');

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Sinn', 'Lebensausrichtung', 'Bedeutung vs. Funktion'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Sinn');

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Vitalität', 'Körperintelligenz', 'Lebendigkeit vs. Funktionieren'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Vitalität');

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Freiheit', 'Kraftquellen', 'Autonomie vs. Abhängigkeit'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Freiheit');

INSERT INTO luna_8a_core_value_types (name, bereich, spannung)
SELECT 'Wachstum', 'Transformationsbereitschaft', 'Entfaltung vs. Stagnation'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_value_types WHERE name = 'Wachstum');


-- ----------------------------------------------------------------------------
-- luna_8a_core_need_types  (10 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Sicherheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Sicherheit');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Zugehörigkeit'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Zugehörigkeit');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Autonomie'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Autonomie');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Anerkennung'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Anerkennung');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Sinn'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Sinn');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Wachstum');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Intimität'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Intimität');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Ausdruck'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Ausdruck');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Ruhe'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Ruhe');

INSERT INTO luna_8a_core_need_types (name)
SELECT 'Integrität'
WHERE NOT EXISTS (SELECT 1 FROM luna_8a_core_need_types WHERE name = 'Integrität');


-- ----------------------------------------------------------------------------
-- luna_8b_coping_strategy  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Präsenz-Anker', 'Präsenzqualität'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Präsenz-Anker');

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Kohärenz-Reset', 'Energetische Kohärenz'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Kohärenz-Reset');

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Stille-Kontemplation', 'Stille-Kapazität'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Stille-Kontemplation');

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Flow-Aktivierung', 'Flow-Zugang'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Flow-Aktivierung');

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Verkörperungs-Sequenz', 'Verkörperte Gegenwart'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Verkörperungs-Sequenz');

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Verbundenheits-Ritual', 'Transpersonale Verbundenheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Verbundenheits-Ritual');

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Seins-Erlaubnis', 'Seinsmut'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Seins-Erlaubnis');

INSERT INTO luna_8b_coping_strategy (name, potenzial)
SELECT 'Perspektiven-Erweiterung', 'Bewusstseinsstufe'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_coping_strategy WHERE name = 'Perspektiven-Erweiterung');


-- ----------------------------------------------------------------------------
-- luna_8b_relationship_pattern  (5 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_8b_relationship_pattern (name, bindungsstil, muster, integration)
SELECT 'Sicher-autonom', 'Sicher', 'Vertrauen, Offenheit, Grenzen', 'Tiefe Intimität'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_relationship_pattern WHERE name = 'Sicher-autonom');

INSERT INTO luna_8b_relationship_pattern (name, bindungsstil, muster, integration)
SELECT 'Ängstlich-anklammernd', 'Ängstlich', 'Nähesuche, Verlassensangst', 'Innere Sicherheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_relationship_pattern WHERE name = 'Ängstlich-anklammernd');

INSERT INTO luna_8b_relationship_pattern (name, bindungsstil, muster, integration)
SELECT 'Vermeidend-distanziert', 'Vermeidend', 'Autonomieschutz, Näheangst', 'Verletzlichkeit'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_relationship_pattern WHERE name = 'Vermeidend-distanziert');

INSERT INTO luna_8b_relationship_pattern (name, bindungsstil, muster, integration)
SELECT 'Desorganisiert', 'Desorganisiert', 'Annäherung-Vermeidung-Konflikt', 'Integration'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_relationship_pattern WHERE name = 'Desorganisiert');

INSERT INTO luna_8b_relationship_pattern (name, bindungsstil, muster, integration)
SELECT 'Co-abhängig', 'Verschmolzen', 'Selbstverlust in Beziehung', 'Eigene Identität'
WHERE NOT EXISTS (SELECT 1 FROM luna_8b_relationship_pattern WHERE name = 'Co-abhängig');


-- ----------------------------------------------------------------------------
-- luna_8d_deep_potential  – KEINE INSERTS (bereits befüllt)
-- ----------------------------------------------------------------------------
-- Erwartet: 8 Zeilen (Selbstkern, Beziehungsfeld, Schöpferkraft,
--   Schattenpotenzial, Lebensausrichtung, Körperintelligenz,
--   Kraftquellen, Transformationsbereitschaft)


-- ----------------------------------------------------------------------------
-- luna_8e_being_potential  – KEINE INSERTS (bereits befüllt)
-- ----------------------------------------------------------------------------
-- Erwartet: 8 Zeilen (Präsenzqualität, Energetische Kohärenz, Stille-Kapazität,
--   Flow-Zugang, Verkörperte Gegenwart, Transpersonale Verbundenheit,
--   Seinsmut, Bewusstseinsstufe)


-- ----------------------------------------------------------------------------
-- luna_9a_vision_archetypes  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Leuchtturm', 'Licht führen', 'Ich leuchte indem ich ich selbst bin'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Leuchtturm');

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Brückenbauerin', 'Verbindung schaffen', 'Ich verbinde was getrennt scheint'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Brückenbauerin');

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Heilerin', 'Wunden in Weisheit wandeln', 'Mein Schmerz wird zum Geschenk'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Heilerin');

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Pionierin', 'Neues Land betreten', 'Ich gehe wo noch kein Weg ist'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Pionierin');

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Hüterin', 'Wissen bewahren', 'Ich halte was Bestand hat'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Hüterin');

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Katalysatorin', 'Transformation auslösen', 'Durch mich verändert sich die Welt'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Katalysatorin');

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Schöpferin', 'Neues erschaffen', 'Ich erschaffe was noch nicht war'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Schöpferin');

INSERT INTO luna_9a_vision_archetypes (name, aufgabe, leitsatz)
SELECT 'Die Integrierende', 'Gegensätze vereinen', 'In mir wird eins was gespalten war'
WHERE NOT EXISTS (SELECT 1 FROM luna_9a_vision_archetypes WHERE name = 'Die Integrierende');


-- =============================================================================
-- SCHRITT 5 – BLOCK-PRÜFUNG
-- Erwartete Zeilenzahlen:
--   core_value_types=8, core_need_types=10, coping_strategy=8,
--   relationship_pattern=5, deep_potential=bereits befüllt,
--   being_potential=bereits befüllt, vision_archetypes=8
-- =============================================================================

SELECT 'luna_8a_core_value_types'     AS tabelle, COUNT(*) AS zeilen FROM luna_8a_core_value_types
UNION ALL
SELECT 'luna_8a_core_need_types'      AS tabelle, COUNT(*) AS zeilen FROM luna_8a_core_need_types
UNION ALL
SELECT 'luna_8b_coping_strategy'      AS tabelle, COUNT(*) AS zeilen FROM luna_8b_coping_strategy
UNION ALL
SELECT 'luna_8b_relationship_pattern' AS tabelle, COUNT(*) AS zeilen FROM luna_8b_relationship_pattern
UNION ALL
SELECT 'luna_8d_deep_potential'       AS tabelle, COUNT(*) AS zeilen FROM luna_8d_deep_potential
UNION ALL
SELECT 'luna_8e_being_potential'      AS tabelle, COUNT(*) AS zeilen FROM luna_8e_being_potential
UNION ALL
SELECT 'luna_9a_vision_archetypes'    AS tabelle, COUNT(*) AS zeilen FROM luna_9a_vision_archetypes;
