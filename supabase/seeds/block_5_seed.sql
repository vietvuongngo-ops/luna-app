-- =============================================================================
-- LUNA FRAMEWORK – BLOCK 5 SEED (MODULE & PROGRAMME)
-- Tabellen: luna_module_definitions, luna_programs
--
-- REGELN:
--   - Kein DROP, TRUNCATE, DELETE, ON CONFLICT DO UPDATE
--   - CREATE TABLE IF NOT EXISTS für alle Tabellen
--   - Alle Inserts: INSERT ... SELECT ... WHERE NOT EXISTS
--   - Parent-Tabellen vor Child-Tabellen (luna_module_definitions hat keine FKs)
-- =============================================================================


-- =============================================================================
-- SCHRITT 1 – SCHEMA-ÜBERBLICK (informativ)
-- Führe diese Query manuell aus, um den Ist-Stand zu prüfen:
--
-- SELECT table_name, column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name IN ('luna_module_definitions', 'luna_programs')
-- ORDER BY table_name, ordinal_position;
-- =============================================================================


-- =============================================================================
-- SCHRITT 2 – CREATE TABLE IF NOT EXISTS
-- =============================================================================

-- ----------------------------------------------------------------------------
-- luna_module_definitions
-- Spalten: name | stufe | kernfrage
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_module_definitions (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text        UNIQUE NOT NULL,
  stufe       text,
  kernfrage   text,
  created_at  timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_programs
-- Spalten: name | dauer | zielgruppe | beschreibung
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_programs (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text        UNIQUE NOT NULL,
  dauer        text,
  zielgruppe   text,
  beschreibung text,
  created_at   timestamptz DEFAULT now()
);


-- =============================================================================
-- SCHRITT 4 – SEED-DATEN (idempotent: INSERT ... SELECT ... WHERE NOT EXISTS)
-- =============================================================================


-- ----------------------------------------------------------------------------
-- luna_module_definitions  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Selbstkenntnis', 'Fundament', 'Wer bin ich wirklich?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Selbstkenntnis');

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Emotionsnavigation', 'Fundament', 'Was fühle ich – und was brauche ich?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Emotionsnavigation');

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Schattenintegration', 'Vertiefung', 'Was habe ich verdrängt?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Schattenintegration');

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Beziehungsarbeit', 'Vertiefung', 'Wie liebe und verbinde ich?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Beziehungsarbeit');

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Körperweisheit', 'Vertiefung', 'Was sagt mein Körper?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Körperweisheit');

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Lebensausrichtung', 'Transformation', 'Wohin geht mein Weg?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Lebensausrichtung');

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Schöpferkraft', 'Transformation', 'Was will durch mich entstehen?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Schöpferkraft');

INSERT INTO luna_module_definitions (name, stufe, kernfrage)
SELECT 'Being & Präsenz', 'Transzendenz', 'Wer bin ich jenseits aller Rollen?'
WHERE NOT EXISTS (SELECT 1 FROM luna_module_definitions WHERE name = 'Being & Präsenz');


-- ----------------------------------------------------------------------------
-- luna_programs  (4 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_programs (name, dauer, zielgruppe, beschreibung)
SELECT 'LUNA Basis', '4 Wochen', 'Einstieg', 'Selbstkenntnis und erste Klarheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_programs WHERE name = 'LUNA Basis');

INSERT INTO luna_programs (name, dauer, zielgruppe, beschreibung)
SELECT 'LUNA Deep Dive', '8 Wochen', 'Fortgeschrittene', 'Tiefe Integration und Transformation'
WHERE NOT EXISTS (SELECT 1 FROM luna_programs WHERE name = 'LUNA Deep Dive');

INSERT INTO luna_programs (name, dauer, zielgruppe, beschreibung)
SELECT 'LUNA Being', '12 Wochen', 'Erfahrene', 'Bewusstsein, Präsenz, Transzendenz'
WHERE NOT EXISTS (SELECT 1 FROM luna_programs WHERE name = 'LUNA Being');

INSERT INTO luna_programs (name, dauer, zielgruppe, beschreibung)
SELECT 'LUNA Full Journey', '6 Monate', 'Alle', 'Vollständige Transformation auf allen Ebenen'
WHERE NOT EXISTS (SELECT 1 FROM luna_programs WHERE name = 'LUNA Full Journey');


-- =============================================================================
-- SCHRITT 5 – BLOCK-PRÜFUNG
-- Erwartete Zeilenzahlen: module_definitions=8, programs=4
-- =============================================================================

SELECT 'luna_module_definitions' AS tabelle, COUNT(*) AS zeilen FROM luna_module_definitions
UNION ALL
SELECT 'luna_programs'           AS tabelle, COUNT(*) AS zeilen FROM luna_programs;
