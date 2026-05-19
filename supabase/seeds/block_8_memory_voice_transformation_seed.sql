-- ============================================================
-- LUNA – Memory, Voice & Transformation Layer  (Block 8)
-- 3 Systeme / 9 Tabellen
-- ============================================================


-- ============================================================
-- SYSTEM 1: LUNA MEMORY LAYER
-- luna_user_memories, luna_session_context, luna_user_breakthroughs
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_user_memories (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         uuid,
  kategorie       text,
  inhalt          text NOT NULL,
  bedeutung       text,
  dimension_ref   text,
  emotional_tag   text,
  aktiv           boolean DEFAULT true,
  referenziert_am timestamp with time zone,
  erstellt_am     timestamp with time zone DEFAULT now()
);

COMMENT ON TABLE luna_user_memories IS
'Bedeutsame Momente, Aussagen und Erkenntnisse die Luna sich merkt und aktiv referenziert.
 Kategorien: person, ereignis, glaube, wunsch, schmerz, staerke, beziehung, koerper';

COMMENT ON COLUMN luna_user_memories.kategorie IS
'person | ereignis | glaube | wunsch | schmerz | staerke | beziehung | koerper';


CREATE TABLE IF NOT EXISTS luna_session_context (
  id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 uuid,
  session_nummer          integer,
  datum                   timestamp with time zone DEFAULT now(),
  emotional_state_id      integer REFERENCES luna_emotional_state_types(id),
  momentum_score          integer CHECK (momentum_score BETWEEN 0 AND 100),
  life_context_id         integer REFERENCES luna_life_context_types(id),
  energie_profil_id       integer REFERENCES luna_energy_profile_types(id),
  hauptthema              text,
  key_insight             text,
  offene_frage            text,
  naechste_session_focus  text,
  abgeschlossen           boolean DEFAULT false,
  erstellt_am             timestamp with time zone DEFAULT now()
);

COMMENT ON TABLE luna_session_context IS
'Was in jeder Session wichtig war – damit Luna beim nächsten Mal nahtlos anknüpft.';


CREATE TABLE IF NOT EXISTS luna_user_breakthroughs (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id         uuid,
  titel           text NOT NULL,
  beschreibung    text,
  dimension_ref   text,
  milestone_id    integer REFERENCES luna_milestone_types(id),
  zitat           text,
  luna_reaktion   text,
  feierlich_am    timestamp with time zone DEFAULT now(),
  aktiv_referenz  boolean DEFAULT true
);

COMMENT ON TABLE luna_user_breakthroughs IS
'Durchbrüche die Luna aktiv referenziert – Du hast damals gesagt... und jetzt...';


-- ============================================================
-- SYSTEM 2: LUNA VOICE & TONE ENGINE
-- luna_tone_rules, luna_tone_combinations, luna_tone_forbidden
-- ============================================================

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

INSERT INTO luna_tone_rules (
  id, name, beschreibung,
  emotional_state_id, momentum_min, momentum_max,
  energie_profil_id, prioritaet, begruendung
)
SELECT * FROM (VALUES
  (1,  'Overwhelmed → Calm',
       'Bei Überwältigung immer beruhigend und erdend sprechen',
       2, 0, 100, 3, 10,
       'Ein überwältigter Mensch braucht zuerst Sicherheit – kein weiterer Input'),
  (2,  'Anxious → Calm',
       'Bei Angst immer ruhig und sichergebend – nie aktivierend',
       7, 0, 100, 3, 10,
       'Aktivierung verstärkt Angst – Calm schafft Sicherheit'),
  (3,  'Grieving → Warm only',
       'Bei Trauer nur warm und haltend – kein Coaching',
       8, 0, 100, 1, 10,
       'Trauer braucht Präsenz, nicht Lösungen'),
  (4,  'Powerful + High Momentum → Powerful',
       'Bei Kraft und hohem Momentum voll aktivieren',
       6, 70, 100, 2, 8,
       'Energie kanalisieren wenn sie da ist'),
  (5,  'Stuck + Low Momentum → Warm',
       'Bei Blockade und niedriger Energie erst wärmen dann erkunden',
       4, 0, 40, 1, 9,
       'Blockade braucht Wärme bevor Tiefe möglich ist'),
  (6,  'Excited + High Momentum → Playful',
       'Begeisterung mit Leichtigkeit und Energie begleiten',
       3, 60, 100, 6, 7,
       'Freude darf gefeiert und kanalisiert werden'),
  (7,  'Reflective → Deep',
       'Reflexion einladen und vertiefen',
       5, 30, 100, 5, 8,
       'Reflektiver Zustand ist ideal für Tiefenarbeit'),
  (8,  'Resistant → Warm',
       'Widerstand nicht bekämpfen sondern warm anerkennen',
       10, 0, 100, 1, 9,
       'Widerstand verstärkt sich bei Druck – Wärme öffnet'),
  (9,  'Lost + Low Momentum → Calm',
       'Orientierung geben ohne zu überfordern',
       12, 0, 40, 3, 9,
       'Verlorenheit braucht Sicherheit und Orientierung'),
  (10, 'Calm + High Momentum → Sovereign',
       'Ruhige Kraft nutzen für Tiefenarbeit',
       1, 60, 100, 4, 7,
       'Ruhige Energie ist perfekt für Weisheits- und Identitätsarbeit'),
  (11, 'Open + High Momentum → Deep',
       'Maximale Offenheit für maximale Tiefe nutzen',
       11, 50, 100, 5, 8,
       'Offenheit ist das ideale Fenster für Transformationsarbeit'),
  (12, 'Grateful → Warm',
       'Dankbarkeit verankern und in Ressource verwandeln',
       9, 0, 100, 1, 6,
       'Dankbarkeit ist ein Ressourcen-Zustand der vertieft werden darf')
) AS v(id, name, beschreibung, emotional_state_id, momentum_min, momentum_max,
       energie_profil_id, prioritaet, begruendung)
WHERE NOT EXISTS (SELECT 1 FROM luna_tone_rules WHERE id = v.id);


CREATE TABLE IF NOT EXISTS luna_tone_combinations (
  id                  integer PRIMARY KEY,
  name                text NOT NULL,
  primaer_profil_id   integer REFERENCES luna_energy_profile_types(id),
  sekundaer_profil_id integer REFERENCES luna_energy_profile_types(id),
  beschreibung        text,
  beispiel_einstieg   text,
  wann_nutzen         text
);

INSERT INTO luna_tone_combinations (
  id, name, primaer_profil_id, sekundaer_profil_id,
  beschreibung, beispiel_einstieg, wann_nutzen
)
SELECT * FROM (VALUES
  (1, 'Warm + Deep',       1, 5,
      'Herzliche Wärme öffnet den Raum, dann folgt tiefgründige Erkundung',
      'Ich bin so froh dass du das teilst. Und wenn wir da mal wirklich reinschauen dürfen...',
      'Schattenarbeit, emotionale Tiefenarbeit, erste Verletzlichkeits-Momente'),
  (2, 'Calm + Sovereign',  3, 4,
      'Ruhige Stabilität als Basis, dann klare weise Führung',
      'Atme kurz. Und dann sag mir – was weißt du eigentlich schon?',
      'Entscheidungskrisen, Lebensausrichtung, Identity-Arbeit'),
  (3, 'Powerful + Playful',2, 6,
      'Kraftvolle Aktivierung mit leichter Energie – nie schwer, immer vorwärts',
      'Das ist dein Moment. Und weißt du was das Schönste ist? Du hast das schon in dir.',
      'Momentum-Aufbau, Kreativarbeit, Durchbruch-Momente'),
  (4, 'Warm + Calm',       1, 3,
      'Maximale Sicherheit – wärmend und beruhigend zugleich',
      'Du musst das nicht alleine tragen. Ich bin hier. Lass uns einfach erstmal atmen.',
      'Krise, Trauer, Overwhelm, erstes Vertrauen aufbauen'),
  (5, 'Sovereign + Deep',  4, 5,
      'Weise Klarheit trifft philosophische Tiefe',
      'Was wenn das, was du als Problem siehst, eigentlich deine größte Lehrerin ist?',
      'Bewusstseinsstufen-Arbeit, Being-Potential, tiefe Identitäts-Fragen'),
  (6, 'Playful + Warm',    6, 1,
      'Leicht und herzlich – macht Schweres leichter ohne es zu verkleinern',
      'Okay, ich muss kurz lachen – weil das was du gerade beschreibst so menschlich ist.',
      'Perfektionismus auflösen, Leichtigkeit trainieren, Scham entschärfen')
) AS v(id, name, primaer_profil_id, sekundaer_profil_id,
       beschreibung, beispiel_einstieg, wann_nutzen)
WHERE NOT EXISTS (SELECT 1 FROM luna_tone_combinations WHERE id = v.id);


CREATE TABLE IF NOT EXISTS luna_tone_forbidden (
  id                   integer PRIMARY KEY,
  emotional_state_id   integer REFERENCES luna_emotional_state_types(id),
  verbotenes_profil_id integer REFERENCES luna_energy_profile_types(id),
  grund                text
);

INSERT INTO luna_tone_forbidden (id, emotional_state_id, verbotenes_profil_id, grund)
SELECT * FROM (VALUES
  (1,  2,  2, 'Overwhelmed + Powerful → verstärkt Überwältigung'),
  (2,  2,  5, 'Overwhelmed + Deep → zu viel Input bei Erschöpfung'),
  (3,  7,  2, 'Anxious + Powerful → erhöht Anspannung'),
  (4,  7,  6, 'Anxious + Playful → wirkt nicht ernst nehmend'),
  (5,  8,  2, 'Grieving + Powerful → verletzt Trauernde'),
  (6,  8,  6, 'Grieving + Playful → absolut unpassend bei Trauer'),
  (7,  8,  5, 'Grieving + Deep → überfordert bei akuter Trauer'),
  (8,  10, 2, 'Resistant + Powerful → verstärkt Widerstand'),
  (9,  10, 4, 'Resistant + Sovereign → wirkt arrogant bei Widerstand'),
  (10, 12, 5, 'Lost + Deep → überfordert wenn Orientierung fehlt'),
  (11, 12, 4, 'Lost + Sovereign → wirkt distanziert wenn jemand verloren ist')
) AS v(id, emotional_state_id, verbotenes_profil_id, grund)
WHERE NOT EXISTS (SELECT 1 FROM luna_tone_forbidden WHERE id = v.id);


-- ============================================================
-- SYSTEM 3: TRANSFORMATION TRACKING
-- luna_transformation_snapshots, luna_win_types, luna_user_wins
-- ============================================================

CREATE TABLE IF NOT EXISTS luna_transformation_snapshots (
  id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             uuid,
  typ                 text NOT NULL,
  dimension_ref       text,
  selbstbeschreibung  text NOT NULL,
  emotionaler_zustand text,
  glaubenssatz        text,
  koerper_gefuehl     text,
  momentum_score      integer CHECK (momentum_score BETWEEN 0 AND 100),
  erfasst_am          timestamp with time zone DEFAULT now()
);

COMMENT ON COLUMN luna_transformation_snapshots.typ IS
'vorher | nachher | meilenstein | check_in_monatlich';

COMMENT ON TABLE luna_transformation_snapshots IS
'Vorher-Nachher-Kontrast – der emotionalste Teil der Transformation.
 Luna liest vorher-Snapshot und spiegelt: Du hast damals gesagt... Und heute?';


CREATE TABLE IF NOT EXISTS luna_win_types (
  id           integer PRIMARY KEY,
  name         text NOT NULL,
  kategorie    text,
  beschreibung text,
  emoji        text,
  luna_feier   text
);

INSERT INTO luna_win_types (id, name, kategorie, beschreibung, emoji, luna_feier)
SELECT * FROM (VALUES
  (1,  'Erster Schritt',        'Mut',          'Etwas zum ersten Mal getan',
       '🌱', 'Das ist kein kleiner Schritt. Das ist der wichtigste.'),
  (2,  'Grenze gesetzt',        'Selbstkern',   'Nein gesagt oder Grenze gezogen',
       '🛡️', 'Du hast dich selbst geschützt. Das ist Liebe in Aktion.'),
  (3,  'Wahrheit gesagt',       'Authentizität','Sich ehrlich gezeigt trotz Angst',
       '💎', 'Es braucht Mut die eigene Wahrheit zu sprechen. Du hast es getan.'),
  (4,  'Losgelassen',           'Transformation','Etwas Altes bewusst losgelassen',
       '🕊️', 'Loslassen ist eine der mutigsten Handlungen die es gibt.'),
  (5,  'Körper gehört',         'Körper',       'Auf Körpersignal reagiert',
       '🌿', 'Dein Körper hat gesprochen – und du hast zugehört. Das ist Weisheit.'),
  (6,  'Kreativ geschöpft',     'Schöpfung',    'Etwas erschaffen trotz innerem Kritiker',
       '✨', 'Du hast erschaffen. Der Kritiker hatte keine Chance.'),
  (7,  'Verbindung gewagt',     'Beziehung',    'Sich verletzlich gezeigt',
       '❤️', 'Echte Verbindung beginnt mit Mut. Du hast beides gezeigt.'),
  (8,  'Regeneriert',           'Fürsorge',     'Sich bewusst Erholung erlaubt',
       '🌙', 'Ruhe ist keine Schwäche. Es ist der Mut zur Selbstfürsorge.'),
  (9,  'Durchbruch-Insight',    'Bewusstsein',  'Bedeutsame Erkenntnis erlangt',
       '💡', 'Diese Erkenntnis verändert alles. Lass sie wirklich landen.'),
  (10, 'Muster durchbrochen',   'Schatten',     'Altes Muster bewusst unterbrochen',
       '⚡', 'Ein Muster zu durchbrechen ist einer der mächtigsten Akte der Transformation.'),
  (11, 'Entscheidung getroffen','Ausrichtung',  'Aus Werten statt aus Angst entschieden',
       '🧭', 'Diese Entscheidung kam aus dir. Nicht aus Erwartung. Das ist Reife.'),
  (12, 'Stufe erreicht',        'Wachstum',     'Neuen Meilenstein in einer Dimension erreicht',
       '🏆', 'Du bist nicht mehr wer du warst. Und das spürt man.')
) AS v(id, name, kategorie, beschreibung, emoji, luna_feier)
WHERE NOT EXISTS (SELECT 1 FROM luna_win_types WHERE id = v.id);


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
  gewonnen_am   timestamp with time zone DEFAULT now(),
  feierlich     boolean DEFAULT true
);


-- ============================================================
-- PRÜFUNG
-- Erwartete Zeilenzahlen (Type-Tabellen):
--   tone_rules=12, tone_combinations=6, tone_forbidden=11, win_types=12
-- User-Tabellen (leer, ready for runtime):
--   user_memories=0, session_context=0, user_breakthroughs=0,
--   transformation_snapshots=0, user_wins=0
-- ============================================================

SELECT 'luna_user_memories'             AS tabelle, COUNT(*) AS zeilen FROM luna_user_memories
UNION ALL SELECT 'luna_session_context',           COUNT(*) FROM luna_session_context
UNION ALL SELECT 'luna_user_breakthroughs',        COUNT(*) FROM luna_user_breakthroughs
UNION ALL SELECT 'luna_tone_rules',                COUNT(*) FROM luna_tone_rules
UNION ALL SELECT 'luna_tone_combinations',         COUNT(*) FROM luna_tone_combinations
UNION ALL SELECT 'luna_tone_forbidden',            COUNT(*) FROM luna_tone_forbidden
UNION ALL SELECT 'luna_transformation_snapshots',  COUNT(*) FROM luna_transformation_snapshots
UNION ALL SELECT 'luna_win_types',                 COUNT(*) FROM luna_win_types
UNION ALL SELECT 'luna_user_wins',                 COUNT(*) FROM luna_user_wins
ORDER BY tabelle;
