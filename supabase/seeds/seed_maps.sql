-- =============================================================================
-- seed_maps.sql
-- Initial cross-reference data for MAP tables (modules 3, 4, 6, 8).
-- Modules 5 and 7 MAP tables require their source TYPE tables to be populated
-- first — use seed_maps_generator.ts once those tables have data.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- luna_3c_nervous_system_map
-- Polyvagal transitions: which state follows which under stress / recovery
-- left  = current state,  right = adjacent / transition state
-- -----------------------------------------------------------------------------
INSERT INTO luna_3c_nervous_system_map (left_type_id, right_type_id, weight) VALUES
-- Ventral-Vagal (safety) can drop to Sympathetic or Dorsal
(1, 2, 0.7),   -- Ventral → Sympathetic Fight
(1, 3, 0.7),   -- Ventral → Sympathetic Flight
(1, 4, 0.4),   -- Ventral → Dorsal Shutdown (less common direct path)
-- Sympathetic Fight/Flight can escalate or drop
(2, 3, 0.8),   -- Fight ↔ Flight (closely related)
(3, 2, 0.8),
(2, 4, 0.5),   -- Fight → Shutdown
(3, 4, 0.6),   -- Flight → Shutdown (exhaustion)
-- Recovery paths (back to safety)
(2, 1, 0.5),   -- Fight → Ventral (co-regulation)
(3, 1, 0.5),   -- Flight → Ventral
(4, 1, 0.3),   -- Shutdown → Ventral (slow recovery)
-- Mixed state
(2, 5, 0.6),   -- Fight → Mixed
(3, 5, 0.6),   -- Flight → Mixed
(5, 1, 0.4),   -- Mixed → Ventral
(5, 4, 0.4);   -- Mixed → Shutdown


-- -----------------------------------------------------------------------------
-- luna_4c_life_phase_map
-- Sequential life phase progressions (Erikson / Levinson inspired)
-- left = earlier phase,  right = next phase
-- -----------------------------------------------------------------------------
INSERT INTO luna_4c_life_phase_map (left_type_id, right_type_id, weight) VALUES
(1, 2, 1.0),   -- Frühe Bindung → Autonomie & Wille
(2, 3, 1.0),   -- Autonomie → Initiative & Ausdruck
(3, 4, 1.0),   -- Initiative → Kompetenz & Leistung
(4, 5, 1.0),   -- Kompetenz → Identität & Zugehörigkeit
(5, 6, 0.8),   -- Identität → Frühe Verantwortung
-- Regressions under stress
(2, 1, 0.4),
(3, 2, 0.4),
(4, 3, 0.4),
(5, 4, 0.4);


-- -----------------------------------------------------------------------------
-- luna_6c_strategy_map
-- Core strategy → Expression strategy (how a strategy shows up in behaviour)
-- Core strategies: 1=Fokussieren, 2=Gestalten, 3=Verbinden, 4=Ausrichten, 5=Vertiefen, 6=Erkunden
-- Expression styles: 1=Klarheit, 2=Stilles Wirken, 3=Energie & Tempo, 4=Bildhafte Sprache, 5=Wärme, 6=Struktur
-- -----------------------------------------------------------------------------
INSERT INTO luna_6c_strategy_map (core_strategy_type_id, expression_strategy_type_id, weight) VALUES
-- Fokussieren expresses as Klarheit and Struktur
(1, 1, 0.9),
(1, 6, 0.7),
-- Gestalten expresses as Energie and Bildhafte Sprache
(2, 3, 0.8),
(2, 4, 0.7),
-- Verbinden expresses as Wärme and Stilles Wirken
(3, 5, 0.9),
(3, 2, 0.6),
-- Ausrichten expresses as Klarheit and Struktur
(4, 1, 0.8),
(4, 6, 0.8),
-- Vertiefen expresses as Stilles Wirken and Bildhafte Sprache
(5, 2, 0.8),
(5, 4, 0.7),
-- Erkunden expresses as Energie and Bildhafte Sprache
(6, 3, 0.8),
(6, 4, 0.6);


-- -----------------------------------------------------------------------------
-- luna_8c_values_map
-- Core values → Coping strategies (activated when value is violated)
-- Values: 1=Freiheit, 2=Verbindung, 3=Integrität, 4=Wirkung, 5=Wachstum, 6=Sicherheit
-- Coping:  1=Kontrolle, 2=Rückzug, 3=Anpassung, 4=Überkompensation, 5=Maskierung
-- -----------------------------------------------------------------------------
INSERT INTO luna_8c_values_map (core_values_type_id, coping_strategy_type_id, weight) VALUES
-- Freiheit verletzt → Rückzug, Kontrolle
(1, 2, 0.8),
(1, 1, 0.6),
-- Verbindung verletzt → Anpassung, Maskierung
(2, 3, 0.8),
(2, 5, 0.7),
-- Integrität verletzt → Rückzug, Maskierung
(3, 2, 0.7),
(3, 5, 0.6),
-- Wirkung verletzt → Überkompensation, Kontrolle
(4, 4, 0.9),
(4, 1, 0.7),
-- Wachstum verletzt → Rückzug, Anpassung
(5, 2, 0.7),
(5, 3, 0.6),
-- Sicherheit verletzt → Kontrolle, Rückzug
(6, 1, 0.9),
(6, 2, 0.7);
