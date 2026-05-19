-- ============================================================
-- LUNA – Identity AI Layer  (Block 7)
-- 8 Typ-Tabellen + 8 User-State-Tabellen
-- ============================================================


-- ============================================================
-- 1. IDENTITY STATE – Wer der Kunde gerade wird
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_identity_state (
  id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 uuid,
  identity_staerkend      text,
  identity_loslassend     text,
  energie_lebend          text,
  energie_brauchend       text,
  updated_at              timestamp with time zone DEFAULT now(),
  created_at              timestamp with time zone DEFAULT now()
);

CREATE TABLE IF NOT EXISTS luna_identity_state_types (
  id          integer PRIMARY KEY,
  kategorie   text NOT NULL,
  name        text NOT NULL,
  beschreibung text
);

INSERT INTO luna_identity_state_types (id, kategorie, name, beschreibung)
SELECT * FROM (VALUES
  (1,  'staerkend',        'Die Authentische',    'Wächst in die eigene Wahrheit hinein'),
  (2,  'staerkend',        'Die Schöpferin',      'Erschafft aktiv ihr Leben'),
  (3,  'staerkend',        'Die Souveräne',       'Handelt aus innerer Autorität'),
  (4,  'staerkend',        'Die Verbundene',      'Öffnet sich für echte Nähe'),
  (5,  'staerkend',        'Die Wandlerin',       'Embraced Transformation mutig'),
  (6,  'loslassend',       'Die Perfektionistin', 'Lässt den Zwang zur Fehlerlosigkeit los'),
  (7,  'loslassend',       'Die Funktioniererin', 'Lässt Leistung als Identität los'),
  (8,  'loslassend',       'Die Angepasste',      'Lässt fremde Erwartungen los'),
  (9,  'loslassend',       'Die Erschöpfte',      'Lässt Selbstaufopferung los'),
  (10, 'loslassend',       'Die Kontrolleurin',   'Lässt Kontrollbedürfnis los'),
  (11, 'energie_lebend',   'Feuer',               'Aktiv, erschaffend, vorwärtsdrängend'),
  (12, 'energie_lebend',   'Wasser',              'Fließend, verbindend, heilend'),
  (13, 'energie_lebend',   'Erde',                'Geerdet, stabil, präsent'),
  (14, 'energie_lebend',   'Luft',                'Klar, leicht, visionär'),
  (15, 'energie_brauchend','Ruhe',                'Braucht Stille und Regeneration'),
  (16, 'energie_brauchend','Aktivierung',         'Braucht Impuls und Bewegung'),
  (17, 'energie_brauchend','Verbindung',          'Braucht menschliche Nähe'),
  (18, 'energie_brauchend','Struktur',            'Braucht Orientierung und Klarheit')
) AS v(id, kategorie, name, beschreibung)
WHERE NOT EXISTS (SELECT 1 FROM luna_identity_state_types WHERE id = v.id);


-- ============================================================
-- 2. EMOTIONAL STATE – Emotionale Intelligenz für Luna
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_emotional_state_types (
  id              integer PRIMARY KEY,
  name            text NOT NULL,
  name_de         text,
  valenz          text,
  energie         text,
  luna_reaktion   text,
  coaching_modus  text
);

INSERT INTO luna_emotional_state_types (id, name, name_de, valenz, energie, luna_reaktion, coaching_modus)
SELECT * FROM (VALUES
  (1,  'calm',        'Ruhig',         'positiv',  'niedrig', 'Vertiefe und reflektiere',            'Kontemplativ'),
  (2,  'overwhelmed', 'Überwältigt',   'negativ',  'hoch',    'Verlangsame, erdende, halte',         'Stabilisierend'),
  (3,  'excited',     'Begeistert',    'positiv',  'hoch',    'Kanalisiere und richte aus',          'Aktivierend'),
  (4,  'stuck',       'Feststeckend',  'negativ',  'niedrig', 'Erkunde sanft, öffne Perspektiven',   'Erkundend'),
  (5,  'reflective',  'Reflektierend', 'neutral',  'mittel',  'Begleite und vertiefe',               'Vertiefend'),
  (6,  'powerful',    'Kraftvoll',     'positiv',  'hoch',    'Feiere und verstärke',                'Bestärkend'),
  (7,  'anxious',     'Ängstlich',     'negativ',  'hoch',    'Beruhige, erdende, sicherheite',      'Sichergebend'),
  (8,  'grieving',    'Trauernd',      'negativ',  'niedrig', 'Halte Raum, urteile nicht',           'Haltend'),
  (9,  'grateful',    'Dankbar',       'positiv',  'mittel',  'Verankere und erweitere',             'Vertiefend'),
  (10, 'resistant',   'Widerstehend',  'negativ',  'mittel',  'Respektiere und erkunde sanft',       'Erkundend'),
  (11, 'open',        'Offen',         'positiv',  'mittel',  'Lade ein und vertiefe',               'Einladend'),
  (12, 'lost',        'Verloren',      'negativ',  'niedrig', 'Orientiere und begleite',             'Orientierend')
) AS v(id, name, name_de, valenz, energie, luna_reaktion, coaching_modus)
WHERE NOT EXISTS (SELECT 1 FROM luna_emotional_state_types WHERE id = v.id);

CREATE TABLE IF NOT EXISTS luna_user_emotional_state (
  id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 uuid,
  emotional_state_type_id integer REFERENCES luna_emotional_state_types(id),
  intensitaet             integer DEFAULT 3 CHECK (intensitaet BETWEEN 1 AND 5),
  kontext                 text,
  erfasst_am              timestamp with time zone DEFAULT now()
);


-- ============================================================
-- 3. INTENTIONS TRACKING – Intentionen, nicht Ziele
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_intention_types (
  id           integer PRIMARY KEY,
  name         text NOT NULL,
  beschreibung text,
  dimension    text,
  energie      text
);

INSERT INTO luna_intention_types (id, name, beschreibung, dimension, energie)
SELECT * FROM (VALUES
  (1,  'Mehr Ruhe',            'Bewusster Kontakt mit Stille und Regeneration',        'Kraftquellen',               'Wasser'),
  (2,  'Mehr Momentum',        'Aufbau von Schwung und Vorwärtsbewegung',              'Schöpferkraft',              'Feuer'),
  (3,  'Mehr Klarheit',        'Innere Ausrichtung und Entscheidungsklarheit',         'Lebensausrichtung',          'Luft'),
  (4,  'Mehr Selbstvertrauen', 'Stärkung des Vertrauens in die eigene Wahrheit',      'Selbstkern',                 'Erde'),
  (5,  'Mehr Präsenz',         'Vertiefung der Fähigkeit im Jetzt zu sein',           'Präsenzqualität',            'Erde'),
  (6,  'Mehr Verbindung',      'Öffnung für tiefere zwischenmenschliche Resonanz',    'Beziehungsfeld',             'Wasser'),
  (7,  'Mehr Ausdruck',        'Freierer Zugang zur eigenen kreativen Energie',       'Schöpferkraft',              'Feuer'),
  (8,  'Mehr Mut',             'Kapazität für Veränderung und Loslassen stärken',     'Transformationsbereitschaft','Feuer'),
  (9,  'Mehr Tiefe',           'Vertiefung der Selbsterkenntnis und Schattenarbeit',  'Schattenpotenzial',          'Erde'),
  (10, 'Mehr Leichtigkeit',    'Lösung von Schwere, Perfektionismus, Druck',          'Seinsmut',                   'Luft'),
  (11, 'Mehr Vitalität',       'Lebendigkeit im Körper und klare Energie',            'Körperintelligenz',          'Feuer'),
  (12, 'Mehr Sinn',            'Verbindung mit dem eigenen Warum und Beitrag',        'Lebensausrichtung',          'Luft')
) AS v(id, name, beschreibung, dimension, energie)
WHERE NOT EXISTS (SELECT 1 FROM luna_intention_types WHERE id = v.id);

CREATE TABLE IF NOT EXISTS luna_user_intentions (
  id                   uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id              uuid,
  intention_type_id    integer REFERENCES luna_intention_types(id),
  aktiv                boolean DEFAULT true,
  prioritaet           integer DEFAULT 1 CHECK (prioritaet BETWEEN 1 AND 3),
  notiz                text,
  gesetzt_am           timestamp with time zone DEFAULT now(),
  erreicht_am          timestamp with time zone
);


-- ============================================================
-- 4. PATTERN RECOGNITION – Muster die Luna erkennt
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_pattern_types (
  id              integer PRIMARY KEY,
  name            text NOT NULL,
  kategorie       text,
  beschreibung    text,
  luna_reaktion   text,
  schwellenwert   integer
);

INSERT INTO luna_pattern_types (id, name, kategorie, beschreibung, luna_reaktion, schwellenwert)
SELECT * FROM (VALUES
  (1,  '3 Tage aktiv',              'Aktivität', 'Drei aufeinanderfolgende aktive Tage',            'Feiere den Rhythmus, verstärke',          3),
  (2,  '2 Tage inaktiv',            'Aktivität', 'Zwei aufeinanderfolgende inaktive Tage',          'Sanfter Check-in ohne Druck',             2),
  (3,  '5 Tage Streak',             'Aktivität', 'Fünf Tage Kontinuität',                           'Momentum-Verstärkung, feiern',            5),
  (4,  'Wiederkehrende Zweifel',    'Muster',    'Gleiche Zweifelsmuster tauchen erneut auf',       'Muster benennen, Tiefenarbeit anbieten',  2),
  (5,  'Wiederkehrende Stärke',     'Muster',    'Gleiche Stärken zeigen sich wiederholt',          'Stärke bewusst machen und verankern',     2),
  (6,  'Neue Gewohnheit etabliert', 'Wachstum',  '7 Tage neue Verhaltensweise',                     'Integrationsmoment feiern',               7),
  (7,  'Emotionaler Tief-Punkt',    'Emotional', 'Mehrere negative emotionale States in Folge',     'Sanfter Raum, kein Push',                 3),
  (8,  'Durchbruch-Moment',         'Wachstum',  'Signifikanter Einsicht oder Verhaltenssprung',    'Verstärken, verankern, feiern',           1),
  (9,  'Plateauphase',              'Aktivität', 'Keine Progression über 14 Tage',                  'Neue Perspektive anbieten, reinspirieren',14),
  (10, 'Konsistenz-Hoch',           'Aktivität', '21 Tage aktiv – neue Identität formt sich',      'Identitäts-Shift benennen und feiern',   21)
) AS v(id, name, kategorie, beschreibung, luna_reaktion, schwellenwert)
WHERE NOT EXISTS (SELECT 1 FROM luna_pattern_types WHERE id = v.id);

CREATE TABLE IF NOT EXISTS luna_user_patterns (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          uuid,
  pattern_type_id  integer REFERENCES luna_pattern_types(id),
  erkannt_am       timestamp with time zone DEFAULT now(),
  aktiv            boolean DEFAULT true,
  kontext          text
);


-- ============================================================
-- 5. ENERGY PROFILE – Wie Luna je nach Modul spricht
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_energy_profile_types (
  id              integer PRIMARY KEY,
  name            text NOT NULL,
  beschreibung    text,
  sprache_stil    text,
  beispiel_satz   text,
  farbe           text,
  passend_fuer    text
);

INSERT INTO luna_energy_profile_types (id, name, beschreibung, sprache_stil, beispiel_satz, farbe, passend_fuer)
SELECT * FROM (VALUES
  (1, 'Warm',      'Herzlich, empathisch, nährend',
      'Weich, einladend, fürsorglich',
      'Ich bin so froh dass du hier bist. Was bewegt dich gerade?',
      '#E8A598', 'Emotionale Verarbeitung, Beziehungsarbeit, Trauer'),
  (2, 'Powerful',  'Kraftvoll, direkt, aktivierend',
      'Klar, mutig, vorwärtsdrängend',
      'Du hast die Kraft. Jetzt ist der Moment. Was wird dein nächster Schritt?',
      '#C0392B', 'Momentum-Aufbau, Entscheidungen, Durchbrüche'),
  (3, 'Calm',      'Ruhig, geerdet, stabilisierend',
      'Langsam, klar, sicher',
      'Atme. Du musst das nicht alleine tragen. Ich bin hier.',
      '#7FB3C8', 'Überwältigung, Angst, Regeneration'),
  (4, 'Sovereign', 'Souverän, weise, klar',
      'Präzise, tiefgründig, ohne Umwege',
      'Was würdest du tun, wenn du wüsstest dass du nicht scheitern kannst?',
      '#8E6B9E', 'Lebensausrichtung, Identitätsarbeit, Schattenarbeit'),
  (5, 'Deep',      'Tiefgründig, philosophisch, erkundend',
      'Fragend, nachdenklich, einladend zur Tiefe',
      'Was steckt unter dieser Reaktion? Was will wirklich gehört werden?',
      '#2C3E50', 'Schattenarbeit, Tiefenpsychologie, Being-Arbeit'),
  (6, 'Playful',   'Leicht, humorvoll, inspirierend',
      'Lebendig, überraschend, frisch',
      'Was wäre, wenn das hier gar kein Problem ist – sondern eine Einladung?',
      '#F4D03F', 'Kreativarbeit, Blockaden, Leichtigkeits-Training')
) AS v(id, name, beschreibung, sprache_stil, beispiel_satz, farbe, passend_fuer)
WHERE NOT EXISTS (SELECT 1 FROM luna_energy_profile_types WHERE id = v.id);

CREATE TABLE IF NOT EXISTS luna_user_energy_profile (
  id                       uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                  uuid,
  energy_profile_type_id   integer REFERENCES luna_energy_profile_types(id),
  aktiv                    boolean DEFAULT true,
  updated_at               timestamp with time zone DEFAULT now()
);


-- ============================================================
-- 6. RELATIONSHIP STATE – Luna ↔ User Beziehungsstatus
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_relationship_state_types (
  id              integer PRIMARY KEY,
  name            text NOT NULL,
  beschreibung    text,
  luna_haltung    text,
  coaching_tiefe  text
);

INSERT INTO luna_relationship_state_types (id, name, beschreibung, luna_haltung, coaching_tiefe)
SELECT * FROM (VALUES
  (1, 'Vertrauen hoch',      'Tiefes gegenseitiges Vertrauen etabliert',         'Kann direkt und tief arbeiten',         'Tief'),
  (2, 'Vertrauen aufbauend', 'Vertrauen entsteht – erste positive Erfahrungen',  'Behutsam, konsistent, verlässlich sein','Mittel'),
  (3, 'Vertrauen niedrig',   'Wenig Vertrauen – Skepsis oder Enttäuschung',      'Geduldig, nicht drängend, beweisend',   'Oberflächlich'),
  (4, 'Kunde offen',         'Offen für Tiefe, Reflexion und Veränderung',       'Einladen und vertiefen',                'Tief'),
  (5, 'Kunde zurückhaltend', 'Zögerlich, testet Luna noch',                      'Raum lassen, nicht pushen',             'Leicht'),
  (6, 'Kunde überfordert',   'Zu viel auf einmal – braucht Verlangsamung',       'Verlangsamen, vereinfachen, halten',    'Minimal'),
  (7, 'Kunde im Widerstand', 'Aktiver Widerstand gegen Veränderung oder Prozess','Widerstand anerkennen, nicht kämpfen',  'Erkundend'),
  (8, 'Durchbruch-Moment',   'Besondere Offenheit nach einem Insight',           'Maximale Präsenz, vertiefen, verankern','Tief')
) AS v(id, name, beschreibung, luna_haltung, coaching_tiefe)
WHERE NOT EXISTS (SELECT 1 FROM luna_relationship_state_types WHERE id = v.id);

CREATE TABLE IF NOT EXISTS luna_user_relationship_state (
  id                            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                       uuid,
  relationship_state_type_id    integer REFERENCES luna_relationship_state_types(id),
  vertrauens_score              integer DEFAULT 50 CHECK (vertrauens_score BETWEEN 0 AND 100),
  notiz                         text,
  updated_at                    timestamp with time zone DEFAULT now()
);


-- ============================================================
-- 7. LIFE CONTEXT – Kontext der heute wichtig ist
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_life_context_types (
  id              integer PRIMARY KEY,
  name            text NOT NULL,
  kategorie       text,
  beschreibung    text,
  luna_anpassung  text
);

INSERT INTO luna_life_context_types (id, name, kategorie, beschreibung, luna_anpassung)
SELECT * FROM (VALUES
  (1,  'Viel Stress',          'Belastung', 'Hohe externe Anforderungen',                 'Kürzer, erdender, praktischer'),
  (2,  'Wenig Schlaf',         'Belastung', 'Schlafmangel beeinflusst Kapazität',         'Sanfter, keine Tiefenarbeit'),
  (3,  'Wichtiger Tag',        'Ereignis',  'Bedeutsame Situation steht bevor',           'Aktivierend, bestärkend, fokussiert'),
  (4,  'Emotionale Woche',     'Emotional', 'Intensive emotionale Verarbeitung läuft',    'Haltend, nicht pushend'),
  (5,  'Körperlich erschöpft', 'Belastung', 'Körperliche Erschöpfung dominiert',          'Minimal, fürsorglich, regenerierend'),
  (6,  'Voller Energie',       'Ressource', 'Hohe Energie und Kapazität verfügbar',       'Kann tiefer und anspruchsvoller arbeiten'),
  (7,  'Verlust/Trauer',       'Emotional', 'Trauerprozess aktiv',                        'Nur halten, kein Coaching'),
  (8,  'Beziehungskonflikt',   'Sozial',    'Schwierigkeit in wichtiger Beziehung',       'Beziehungsarbeit priorisieren'),
  (9,  'Berufliche Krise',     'Beruf',     'Job, Karriere oder Finanzen unter Druck',    'Ausrichtungs- und Wertarbeit'),
  (10, 'Flow-Phase',           'Ressource', 'Alles läuft – Momentum ist hoch',            'Verstärken, vertiefen, verankern'),
  (11, 'Übergang/Neuanfang',   'Ereignis',  'Bedeutsamer Lebensübergang',                 'Transformationsarbeit, Identity-Shift'),
  (12, 'Stille/Rückzug',       'Ressource', 'Bewusste Rückzugsphase',                     'Being-Arbeit, Kontemplation, Tiefe')
) AS v(id, name, kategorie, beschreibung, luna_anpassung)
WHERE NOT EXISTS (SELECT 1 FROM luna_life_context_types WHERE id = v.id);

CREATE TABLE IF NOT EXISTS luna_user_life_context (
  id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 uuid,
  life_context_type_id    integer REFERENCES luna_life_context_types(id),
  aktiv                   boolean DEFAULT true,
  intensitaet             integer DEFAULT 3 CHECK (intensitaet BETWEEN 1 AND 5),
  erfasst_am              timestamp with time zone DEFAULT now()
);


-- ============================================================
-- 8. MOMENTUM SCORE – Energie-Score 0–100
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_momentum_score_types (
  id              integer PRIMARY KEY,
  name            text NOT NULL,
  bereich_von     integer,
  bereich_bis     integer,
  beschreibung    text,
  luna_modus      text,
  farbe           text
);

INSERT INTO luna_momentum_score_types (id, name, bereich_von, bereich_bis, beschreibung, luna_modus, farbe)
SELECT * FROM (VALUES
  (1, 'Erschöpft',  0,  20, 'Kaum Energie – Kollaps-Gefahr',       'Fürsorglich, minimal, haltend',           '#E74C3C'),
  (2, 'Gedämpft',  21,  40, 'Wenig Energie – Schonmodus',          'Sanft, geduldig, nicht drängend',         '#E67E22'),
  (3, 'Neutral',   41,  60, 'Normale Energie – Alltagsmodus',      'Ausgewogen, explorierend',                '#F1C40F'),
  (4, 'Aktiviert', 61,  80, 'Gute Energie – Wachstumsmodus',       'Motivierend, vertiefend, herausfordernd', '#2ECC71'),
  (5, 'Im Flow',   81, 100, 'Hohe Energie – Transformationsmodus', 'Voll aktivierend, Tiefenarbeit möglich',  '#1ABC9C')
) AS v(id, name, bereich_von, bereich_bis, beschreibung, luna_modus, farbe)
WHERE NOT EXISTS (SELECT 1 FROM luna_momentum_score_types WHERE id = v.id);

CREATE TABLE IF NOT EXISTS luna_user_momentum (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         uuid,
  score           integer DEFAULT 50 CHECK (score BETWEEN 0 AND 100),
  score_type_id   integer REFERENCES luna_momentum_score_types(id),
  berechnet_aus   text,
  updated_at      timestamp with time zone DEFAULT now(),
  created_at      timestamp with time zone DEFAULT now()
);


-- ============================================================
-- PRÜFUNG
-- Erwartete Zeilenzahlen:
--   identity_state_types=18, emotional_state_types=12,
--   intention_types=12, pattern_types=10,
--   energy_profile_types=6, relationship_state_types=8,
--   life_context_types=12, momentum_score_types=5
-- ============================================================

SELECT 'luna_identity_state_types'      AS tabelle, COUNT(*) AS zeilen FROM luna_identity_state_types
UNION ALL
SELECT 'luna_emotional_state_types',    COUNT(*) FROM luna_emotional_state_types
UNION ALL
SELECT 'luna_intention_types',          COUNT(*) FROM luna_intention_types
UNION ALL
SELECT 'luna_pattern_types',            COUNT(*) FROM luna_pattern_types
UNION ALL
SELECT 'luna_energy_profile_types',     COUNT(*) FROM luna_energy_profile_types
UNION ALL
SELECT 'luna_relationship_state_types', COUNT(*) FROM luna_relationship_state_types
UNION ALL
SELECT 'luna_life_context_types',       COUNT(*) FROM luna_life_context_types
UNION ALL
SELECT 'luna_momentum_score_types',     COUNT(*) FROM luna_momentum_score_types
ORDER BY tabelle;
