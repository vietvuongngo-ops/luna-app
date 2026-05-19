-- =============================================================================
-- LUNA FRAMEWORK – BLOCK 6 SEED (GROWTH ENGINE)
-- Tabellen: luna_growth_dimensions, luna_milestone_types, luna_user_scores
--
-- REGELN:
--   - Kein DROP, TRUNCATE, DELETE, ON CONFLICT DO UPDATE
--   - CREATE TABLE IF NOT EXISTS für neue Tabellen
--   - ALTER TABLE ... ADD COLUMN IF NOT EXISTS für bestehende Tabellen
--   - Alle Inserts: INSERT ... SELECT ... WHERE NOT EXISTS
--   - luna_growth_dimensions vor luna_milestone_types (FK-Abhängigkeit)
--
-- HINWEIS ZU FEHLENDEN INHALTEN:
--   dimension_ref, beschreibung, messkriterium, stufe_1–5_bezeichnung,
--   sowie name/beschreibung/kriterium/coaching_impuls/naechster_schritt
--   der Meilensteine wurden nicht geliefert → bleiben NULL.
--   Nur explizit gelieferte Inhalte werden eingetragen.
-- =============================================================================


-- =============================================================================
-- SCHRITT 1 – SCHEMA-ÜBERBLICK (informativ)
-- Führe diese Query manuell aus, um den Ist-Stand zu prüfen:
--
-- SELECT table_name, column_name, data_type, is_nullable
-- FROM information_schema.columns
-- WHERE table_name IN (
--   'luna_growth_dimensions', 'luna_milestone_types', 'luna_user_scores'
-- )
-- ORDER BY table_name, ordinal_position;
-- =============================================================================


-- =============================================================================
-- SCHRITT 2A – CREATE TABLE IF NOT EXISTS (neue Tabellen)
-- =============================================================================

-- ----------------------------------------------------------------------------
-- luna_growth_dimensions
-- Feste IDs 1–8 (integer PK, da User explizit IDs 1–8 vorgibt)
-- Textfelder ohne gelieferten Inhalt bleiben NULL
-- ----------------------------------------------------------------------------
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

-- ----------------------------------------------------------------------------
-- luna_milestone_types
-- Feste IDs 101–805 (integer PK, Schema: D*100 + Stufe)
-- FK auf luna_growth_dimensions(id)
-- Textfelder ohne gelieferten Inhalt bleiben NULL
-- ----------------------------------------------------------------------------
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
-- SCHRITT 2B – ALTER TABLE luna_user_scores (bestehende Tabelle erweitern)
-- =============================================================================

ALTER TABLE luna_user_scores
  ADD COLUMN IF NOT EXISTS growth_dimension_id  integer REFERENCES luna_growth_dimensions(id),
  ADD COLUMN IF NOT EXISTS aktuelle_stufe       integer,
  ADD COLUMN IF NOT EXISTS letzter_meilenstein  integer REFERENCES luna_milestone_types(id),
  ADD COLUMN IF NOT EXISTS fortschritt_pct      numeric,
  ADD COLUMN IF NOT EXISTS notiz                text;


-- =============================================================================
-- SCHRITT 4 – SEED-DATEN (idempotent: INSERT ... SELECT ... WHERE NOT EXISTS)
-- Reihenfolge: luna_growth_dimensions → luna_milestone_types → luna_user_scores
-- =============================================================================


-- ----------------------------------------------------------------------------
-- luna_growth_dimensions  (8 Zeilen)
-- Nur name geliefert; alle anderen Felder NULL bis Inhalte nachgeliefert werden
-- ----------------------------------------------------------------------------

INSERT INTO luna_growth_dimensions (id, name)
SELECT 1, 'Selbstkern-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 1);

INSERT INTO luna_growth_dimensions (id, name)
SELECT 2, 'Beziehungs-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 2);

INSERT INTO luna_growth_dimensions (id, name)
SELECT 3, 'Schöpfer-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 3);

INSERT INTO luna_growth_dimensions (id, name)
SELECT 4, 'Schatten-Integration'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 4);

INSERT INTO luna_growth_dimensions (id, name)
SELECT 5, 'Ausrichtungs-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 5);

INSERT INTO luna_growth_dimensions (id, name)
SELECT 6, 'Körper-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 6);

INSERT INTO luna_growth_dimensions (id, name)
SELECT 7, 'Regenerations-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 7);

INSERT INTO luna_growth_dimensions (id, name)
SELECT 8, 'Transformations-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_growth_dimensions WHERE id = 8);


-- ----------------------------------------------------------------------------
-- luna_milestone_types  (40 Zeilen: 8 Dimensionen × 5 Stufen)
-- IDs: D*100 + Stufe  (z.B. Dim 1 → 101–105, Dim 2 → 201–205, ...)
-- Textfelder ohne gelieferten Inhalt bleiben NULL
-- ----------------------------------------------------------------------------

-- Dimension 1: Selbstkern-Wachstum
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 101, 1, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 101);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 102, 1, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 102);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 103, 1, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 103);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 104, 1, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 104);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 105, 1, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 105);

-- Dimension 2: Beziehungs-Wachstum
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 201, 2, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 201);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 202, 2, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 202);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 203, 2, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 203);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 204, 2, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 204);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 205, 2, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 205);

-- Dimension 3: Schöpfer-Wachstum
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 301, 3, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 301);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 302, 3, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 302);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 303, 3, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 303);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 304, 3, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 304);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 305, 3, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 305);

-- Dimension 4: Schatten-Integration
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 401, 4, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 401);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 402, 4, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 402);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 403, 4, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 403);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 404, 4, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 404);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 405, 4, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 405);

-- Dimension 5: Ausrichtungs-Wachstum
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 501, 5, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 501);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 502, 5, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 502);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 503, 5, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 503);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 504, 5, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 504);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 505, 5, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 505);

-- Dimension 6: Körper-Wachstum
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 601, 6, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 601);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 602, 6, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 602);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 603, 6, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 603);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 604, 6, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 604);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 605, 6, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 605);

-- Dimension 7: Regenerations-Wachstum
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 701, 7, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 701);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 702, 7, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 702);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 703, 7, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 703);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 704, 7, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 704);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 705, 7, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 705);

-- Dimension 8: Transformations-Wachstum
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 801, 8, 1 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 801);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 802, 8, 2 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 802);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 803, 8, 3 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 803);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 804, 8, 4 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 804);
INSERT INTO luna_milestone_types (id, growth_dimension_id, stufe) SELECT 805, 8, 5 WHERE NOT EXISTS (SELECT 1 FROM luna_milestone_types WHERE id = 805);


-- ----------------------------------------------------------------------------
-- luna_user_scores – Demo-Seeds  (8 Zeilen, profile_id = 3 = demo_user)
-- aktuelle_stufe = 1, letzter_meilenstein = Stufe-1-ID der Dimension
-- fortschritt_pct = 0 (Startzustand, Stufe 1 noch nicht abgeschlossen)
-- Idempotenz-Schlüssel: growth_dimension_id (eindeutig pro Demo-Block)
-- ----------------------------------------------------------------------------

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 1, 1, 101, 0, 'Demo: Selbstkern-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 1);

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 2, 1, 201, 0, 'Demo: Beziehungs-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 2);

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 3, 1, 301, 0, 'Demo: Schöpfer-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 3);

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 4, 1, 401, 0, 'Demo: Schatten-Integration'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 4);

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 5, 1, 501, 0, 'Demo: Ausrichtungs-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 5);

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 6, 1, 601, 0, 'Demo: Körper-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 6);

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 7, 1, 701, 0, 'Demo: Regenerations-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 7);

INSERT INTO luna_user_scores
  (profile_id, growth_dimension_id, aktuelle_stufe, letzter_meilenstein, fortschritt_pct, notiz)
SELECT 3, 8, 1, 801, 0, 'Demo: Transformations-Wachstum'
WHERE NOT EXISTS (SELECT 1 FROM luna_user_scores WHERE growth_dimension_id = 8);


-- =============================================================================
-- SCHRITT 5 – BLOCK-PRÜFUNG
-- Erwartete Zeilenzahlen: growth_dimensions=8, milestone_types=40,
--   user_scores=11 (3 aus Block 3 + 8 neue Demo-Rows)
-- =============================================================================

SELECT 'luna_growth_dimensions' AS tabelle, COUNT(*) AS zeilen FROM luna_growth_dimensions
UNION ALL
SELECT 'luna_milestone_types',  COUNT(*) FROM luna_milestone_types
UNION ALL
SELECT 'luna_user_scores',      COUNT(*) FROM luna_user_scores
ORDER BY tabelle;
