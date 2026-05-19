-- =============================================================================
-- LUNA FRAMEWORK – BLOCK 2 SEED (TYPEN & MAPS)
-- Tabellen: luna_3a_nervous_system, luna_4a_life_phase,
--           luna_5a_protective_pattern, luna_5b_shadow_pattern,
--           luna_5c_stress_response
--
-- REGELN:
--   - Kein DROP, TRUNCATE, DELETE, ON CONFLICT DO UPDATE
--   - CREATE TABLE IF NOT EXISTS für alle Tabellen
--   - Alle Inserts: INSERT ... SELECT ... WHERE NOT EXISTS
--   - Parent-Tabellen vor Child-Tabellen
-- =============================================================================


-- =============================================================================
-- SCHRITT 1 – SCHEMA-ÜBERBLICK (informativ)
-- Führe diese Query manuell aus, um den Ist-Stand zu prüfen:
--
-- SELECT table_name, column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name IN (
--   'luna_3a_nervous_system', 'luna_4a_life_phase',
--   'luna_5a_protective_pattern', 'luna_5b_shadow_pattern',
--   'luna_5c_stress_response'
-- )
-- ORDER BY table_name, ordinal_position;
-- =============================================================================


-- =============================================================================
-- SCHRITT 2 – CREATE TABLE IF NOT EXISTS
-- Reihenfolge: keine FK-Abhängigkeiten zwischen diesen Tabellen
-- =============================================================================

-- ----------------------------------------------------------------------------
-- luna_3a_nervous_system
-- Spalten: name | system | empfindung | koerper_signal
-- (Hinweis: luna_3a_nervous_system_types existiert separat als Minimal-Stub)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_3a_nervous_system (
  id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name           text        UNIQUE NOT NULL,
  system         text,
  empfindung     text,
  koerper_signal text,
  created_at     timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_4a_life_phase
-- Spalten: name | alter_von | alter_bis | thema
-- (Hinweis: luna_4a_life_phase_types existiert separat als Minimal-Stub)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_4a_life_phase (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  alter_von  integer,
  alter_bis  integer,
  thema      text,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_5a_protective_pattern
-- Spalten: name | funktion | ausloser | kosten
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_5a_protective_pattern (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       text        UNIQUE NOT NULL,
  funktion   text,
  ausloser   text,
  kosten     text,
  created_at timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_5b_shadow_pattern
-- Spalten: name | integration | trigger | ressource
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_5b_shadow_pattern (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        text        UNIQUE NOT NULL,
  integration text,
  trigger     text,
  ressource   text,
  created_at  timestamptz DEFAULT now()
);

-- ----------------------------------------------------------------------------
-- luna_5c_stress_response
-- Spalten: name | modus | koerper_signal | gedanke | verhalten
-- (Hinweis: luna_5c_stress_response_map ist ein separater MAP-Table)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS luna_5c_stress_response (
  id             uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  name           text        UNIQUE NOT NULL,
  modus          text,
  koerper_signal text,
  gedanke        text,
  verhalten      text,
  created_at     timestamptz DEFAULT now()
);


-- =============================================================================
-- SCHRITT 4 – SEED-DATEN (idempotent: INSERT ... SELECT ... WHERE NOT EXISTS)
-- =============================================================================


-- ----------------------------------------------------------------------------
-- luna_3a_nervous_system  (5 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_3a_nervous_system (name, system, empfindung, koerper_signal)
SELECT 'Sicherer Anker', 'Ventral vagal', 'Verbunden, präsent', 'Weicher Bauch'
WHERE NOT EXISTS (SELECT 1 FROM luna_3a_nervous_system WHERE name = 'Sicherer Anker');

INSERT INTO luna_3a_nervous_system (name, system, empfindung, koerper_signal)
SELECT 'Kampf-Flucht', 'Sympathikus', 'Alarmiert', 'Herzrasen'
WHERE NOT EXISTS (SELECT 1 FROM luna_3a_nervous_system WHERE name = 'Kampf-Flucht');

INSERT INTO luna_3a_nervous_system (name, system, empfindung, koerper_signal)
SELECT 'Erstarrung', 'Dorsal vagal', 'Taubheit', 'Schwere Glieder'
WHERE NOT EXISTS (SELECT 1 FROM luna_3a_nervous_system WHERE name = 'Erstarrung');

INSERT INTO luna_3a_nervous_system (name, system, empfindung, koerper_signal)
SELECT 'Fawn-Modus', 'Mix', 'Anpassung', 'Enge Brust'
WHERE NOT EXISTS (SELECT 1 FROM luna_3a_nervous_system WHERE name = 'Fawn-Modus');

INSERT INTO luna_3a_nervous_system (name, system, empfindung, koerper_signal)
SELECT 'Kohärenz', 'Herzkoheränz', 'Zentriert', 'Wärme Herz'
WHERE NOT EXISTS (SELECT 1 FROM luna_3a_nervous_system WHERE name = 'Kohärenz');


-- ----------------------------------------------------------------------------
-- luna_4a_life_phase  (7 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_4a_life_phase (name, alter_von, alter_bis, thema)
SELECT 'Verwurzelung', 0, 7, 'Sicherheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_4a_life_phase WHERE name = 'Verwurzelung');

INSERT INTO luna_4a_life_phase (name, alter_von, alter_bis, thema)
SELECT 'Identität', 8, 14, 'Selbstbild'
WHERE NOT EXISTS (SELECT 1 FROM luna_4a_life_phase WHERE name = 'Identität');

INSERT INTO luna_4a_life_phase (name, alter_von, alter_bis, thema)
SELECT 'Ablösung', 15, 21, 'Autonomie'
WHERE NOT EXISTS (SELECT 1 FROM luna_4a_life_phase WHERE name = 'Ablösung');

INSERT INTO luna_4a_life_phase (name, alter_von, alter_bis, thema)
SELECT 'Etablierung', 22, 35, 'Leistung'
WHERE NOT EXISTS (SELECT 1 FROM luna_4a_life_phase WHERE name = 'Etablierung');

INSERT INTO luna_4a_life_phase (name, alter_von, alter_bis, thema)
SELECT 'Sinnkrise', 36, 45, 'Tiefe'
WHERE NOT EXISTS (SELECT 1 FROM luna_4a_life_phase WHERE name = 'Sinnkrise');

INSERT INTO luna_4a_life_phase (name, alter_von, alter_bis, thema)
SELECT 'Reife', 46, 60, 'Weisheit'
WHERE NOT EXISTS (SELECT 1 FROM luna_4a_life_phase WHERE name = 'Reife');

INSERT INTO luna_4a_life_phase (name, alter_von, alter_bis, thema)
SELECT 'Vollendung', 61, 99, 'Sein'
WHERE NOT EXISTS (SELECT 1 FROM luna_4a_life_phase WHERE name = 'Vollendung');


-- ----------------------------------------------------------------------------
-- luna_5a_protective_pattern  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'Perfektionismus', 'Kontrolle', 'Kritik', 'Erschöpfung'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'Perfektionismus');

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'People-Pleasing', 'Anpassung', 'Ablehnung', 'Selbstverlust'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'People-Pleasing');

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'Rückzug', 'Distanz', 'Überwältigung', 'Isolation'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'Rückzug');

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'Kontrolle', 'Dominanz', 'Chaos', 'Beziehungsschaden'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'Kontrolle');

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'Überleistung', 'Leistung', 'Bedingte Liebe', 'Burnout'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'Überleistung');

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'Intellectualisierung', 'Konzepte', 'Überwältigung', 'Kontaktverlust'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'Intellectualisierung');

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'Humor', 'Leichtigkeit', 'Spannung', 'Unernstgenommenwerden'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'Humor');

INSERT INTO luna_5a_protective_pattern (name, funktion, ausloser, kosten)
SELECT 'Rebellion', 'Widerstand', 'Unterdrückung', 'Isolation'
WHERE NOT EXISTS (SELECT 1 FROM luna_5a_protective_pattern WHERE name = 'Rebellion');


-- ----------------------------------------------------------------------------
-- luna_5b_shadow_pattern  (8 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Innerer Kritiker', 'Selbstmitgefühl', 'Kritik', 'Standard'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Innerer Kritiker');

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Verlorenes Kind', 'Verspieltheit', 'Bedürftigkeit', 'Kreativität'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Verlorenes Kind');

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Kontrolleur', 'Vertrauen', 'Chaos', 'Flexibilität'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Kontrolleur');

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Rebell', 'Anpassung', 'Konformismus', 'Grenzen'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Rebell');

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Retter', 'Bedürftigkeit', 'Schwäche', 'Fürsorge'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Retter');

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Narzisst', 'Verletzlichkeit', 'Schwäche', 'Stärke'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Narzisst');

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Opfer', 'Verantwortung', 'Täter', 'Empowerment'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Opfer');

INSERT INTO luna_5b_shadow_pattern (name, integration, trigger, ressource)
SELECT 'Perfektionist', 'Menschlichkeit', 'Schlampigkeit', 'Exzellenz'
WHERE NOT EXISTS (SELECT 1 FROM luna_5b_shadow_pattern WHERE name = 'Perfektionist');


-- ----------------------------------------------------------------------------
-- luna_5c_stress_response  (5 Zeilen)
-- ----------------------------------------------------------------------------

INSERT INTO luna_5c_stress_response (name, modus, koerper_signal, gedanke, verhalten)
SELECT 'Kampf', 'Fight', 'Anspannung', 'Ich muss mich wehren', 'Aggression'
WHERE NOT EXISTS (SELECT 1 FROM luna_5c_stress_response WHERE name = 'Kampf');

INSERT INTO luna_5c_stress_response (name, modus, koerper_signal, gedanke, verhalten)
SELECT 'Flucht', 'Flight', 'Unruhe', 'Ich muss weg', 'Vermeidung'
WHERE NOT EXISTS (SELECT 1 FROM luna_5c_stress_response WHERE name = 'Flucht');

INSERT INTO luna_5c_stress_response (name, modus, koerper_signal, gedanke, verhalten)
SELECT 'Erstarrung', 'Freeze', 'Taubheit', 'Ich kann nicht', 'Blockade'
WHERE NOT EXISTS (SELECT 1 FROM luna_5c_stress_response WHERE name = 'Erstarrung');

INSERT INTO luna_5c_stress_response (name, modus, koerper_signal, gedanke, verhalten)
SELECT 'Unterwerfung', 'Fawn', 'Enge', 'Ich muss gefallen', 'Anpassung'
WHERE NOT EXISTS (SELECT 1 FROM luna_5c_stress_response WHERE name = 'Unterwerfung');

INSERT INTO luna_5c_stress_response (name, modus, koerper_signal, gedanke, verhalten)
SELECT 'Kollaps', 'Shutdown', 'Schwere', 'Es hat keinen Sinn', 'Isolation'
WHERE NOT EXISTS (SELECT 1 FROM luna_5c_stress_response WHERE name = 'Kollaps');


-- =============================================================================
-- SCHRITT 5 – BLOCK-PRÜFUNG
-- Erwartete Zeilenzahlen: nervous_system=5, life_phase=7,
--   protective_pattern=8, shadow_pattern=8, stress_response=5
-- =============================================================================

SELECT 'luna_3a_nervous_system'      AS tabelle, COUNT(*) AS zeilen FROM luna_3a_nervous_system
UNION ALL
SELECT 'luna_4a_life_phase'          AS tabelle, COUNT(*) AS zeilen FROM luna_4a_life_phase
UNION ALL
SELECT 'luna_5a_protective_pattern'  AS tabelle, COUNT(*) AS zeilen FROM luna_5a_protective_pattern
UNION ALL
SELECT 'luna_5b_shadow_pattern'      AS tabelle, COUNT(*) AS zeilen FROM luna_5b_shadow_pattern
UNION ALL
SELECT 'luna_5c_stress_response'     AS tabelle, COUNT(*) AS zeilen FROM luna_5c_stress_response;
