BEGIN;

-- Optional: reproducible randomness
SELECT setseed(0.314159);

-- Drop in a single statement for idempotency
DROP TABLE IF EXISTS viewing_history CASCADE;
DROP TABLE IF EXISTS watchlist CASCADE;
DROP TABLE IF EXISTS content_genres CASCADE;
DROP TABLE IF EXISTS episodes CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;
DROP TABLE IF EXISTS content CASCADE;
DROP TABLE IF EXISTS genres CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS plans CASCADE;
DROP TYPE IF EXISTS content_type;

-- Core types
CREATE TYPE content_type AS ENUM ('movie', 'tv_show');

-- Plans
CREATE TABLE plans (
  plan_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  price_usd NUMERIC(6,2) NOT NULL CHECK (price_usd >= 0),
  max_profiles SMALLINT NOT NULL CHECK (max_profiles BETWEEN 1 AND 8),
  resolution TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Users (Accounts)
CREATE TABLE users (
  user_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  plan_id BIGINT NOT NULL REFERENCES plans(plan_id) ON DELETE RESTRICT,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  country_code CHAR(2) NOT NULL DEFAULT 'US',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  cancelled_at TIMESTAMPTZ NULL
);

-- Profiles
CREATE TABLE profiles (
  profile_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  avatar_url TEXT NOT NULL,
  is_kids BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT profiles_name_len CHECK (length(name) BETWEEN 1 AND 60)
);

-- Genres
CREATE TABLE genres (
  genre_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

-- Content (Movies + TV Shows)
CREATE TABLE content (
  content_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title TEXT NOT NULL,
  content_type content_type NOT NULL,
  release_year SMALLINT NOT NULL CHECK (release_year BETWEEN 1900 AND EXTRACT(YEAR FROM now())::INT + 1),
  -- For movies: runtime. For tv_show: typical episode runtime.
  duration_minutes SMALLINT NOT NULL CHECK (duration_minutes BETWEEN 1 AND 600),
  age_rating TEXT NOT NULL CHECK (age_rating IN ('G','PG','PG-13','R','TV-Y','TV-Y7','TV-G','TV-PG','TV-14','TV-MA')),
  description TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (title, release_year)
);

-- Content <-> Genres mapping
CREATE TABLE content_genres (
  content_id BIGINT NOT NULL REFERENCES content(content_id) ON DELETE CASCADE,
  genre_id BIGINT NOT NULL REFERENCES genres(genre_id) ON DELETE RESTRICT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (content_id, genre_id)
);

-- Episodes (only for tv_show content)
CREATE TABLE episodes (
  episode_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  content_id BIGINT NOT NULL REFERENCES content(content_id) ON DELETE CASCADE,
  season SMALLINT NOT NULL CHECK (season BETWEEN 1 AND 60),
  episode_number SMALLINT NOT NULL CHECK (episode_number BETWEEN 1 AND 500),
  title TEXT NOT NULL,
  duration_minutes SMALLINT NOT NULL CHECK (duration_minutes BETWEEN 5 AND 240),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (content_id, season, episode_number)
);

-- Viewing history
CREATE TABLE viewing_history (
  history_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  profile_id BIGINT NOT NULL REFERENCES profiles(profile_id) ON DELETE CASCADE,
  content_id BIGINT NOT NULL REFERENCES content(content_id) ON DELETE CASCADE,
  episode_id BIGINT NULL REFERENCES episodes(episode_id) ON DELETE SET NULL,
  watched_at TIMESTAMPTZ NOT NULL,
  progress_seconds INT NOT NULL CHECK (progress_seconds >= 0),
  completed BOOLEAN NOT NULL DEFAULT FALSE,
  device_type TEXT NOT NULL CHECK (device_type IN ('tv','mobile','tablet','web','console')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Watchlist / My List
CREATE TABLE watchlist (
  watchlist_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  profile_id BIGINT NOT NULL REFERENCES profiles(profile_id) ON DELETE CASCADE,
  content_id BIGINT NOT NULL REFERENCES content(content_id) ON DELETE CASCADE,
  added_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (profile_id, content_id)
);

-- Indexes for common access patterns
CREATE INDEX idx_users_plan_id ON users(plan_id);
CREATE INDEX idx_profiles_user_id ON profiles(user_id);
CREATE INDEX idx_content_type ON content(content_type);
CREATE INDEX idx_content_release_year ON content(release_year);
CREATE INDEX idx_content_genres_genre_id ON content_genres(genre_id);
CREATE INDEX idx_episodes_content_id ON episodes(content_id);
CREATE INDEX idx_viewing_profile_watched_at ON viewing_history(profile_id, watched_at DESC);
CREATE INDEX idx_viewing_content_id ON viewing_history(content_id);
CREATE INDEX idx_watchlist_profile_added_at ON watchlist(profile_id, added_at DESC);

-- Seed reference data: plans + genres
INSERT INTO plans (name, price_usd, max_profiles, resolution)
VALUES
  ('Basic', 9.99, 1, 'HD'),
  ('Standard', 15.49, 2, 'Full HD'),
  ('Premium', 22.99, 4, 'Ultra HD'),
  ('Premium Plus', 27.99, 6, 'Ultra HD');

INSERT INTO genres(name)
SELECT unnest(ARRAY[
  'Action','Adventure','Animation','Comedy','Crime','Documentary','Drama','Family',
  'Fantasy','History','Horror','Kids','Mystery','Romance','Sci-Fi','Sport','Thriller','War'
]);

-- Procedural seed: Users (~500), Profiles (~500), Content (~500)
DO $$
DECLARE
  first_names TEXT[] := ARRAY[
    'Alex','Jordan','Taylor','Morgan','Casey','Riley','Avery','Jamie','Cameron','Drew',
    'Quinn','Parker','Reese','Rowan','Skyler','Blake','Hayden','Emerson','Finley','Kendall',
    'Harper','Logan','Sage','Robin','Elliot','Dakota','Charlie','Sam','Noah','Mia'
  ];
  last_names TEXT[] := ARRAY[
    'Smith','Johnson','Williams','Brown','Jones','Garcia','Miller','Davis','Rodriguez','Martinez',
    'Hernandez','Lopez','Gonzalez','Wilson','Anderson','Thomas','Taylor','Moore','Jackson','Martin',
    'Lee','Perez','Thompson','White','Harris','Sanchez','Clark','Ramirez','Lewis','Robinson'
  ];
  countries CHAR(2)[] := ARRAY['US','CA','GB','DE','FR','ES','IT','BR','MX','JP','KR','AU','IN','NL','SE','NO'];
  plan_count INT;
  i INT;
  created_ts TIMESTAMPTZ;
BEGIN
  SELECT count(*)::INT INTO plan_count FROM plans;

  -- Users
  INSERT INTO users (plan_id, email, password_hash, is_active, country_code, created_at, updated_at, cancelled_at)
  SELECT
    (1 + floor(random() * plan_count))::INT,
    'user' || gs.i || '@example.com',
    '$2b$10$placeholder.hash.not.real.but.ok.for.mockdata',
    TRUE,
    countries[1 + floor(random() * array_length(countries, 1))::INT],
    (timestamp '2018-01-01' + (random() * (now() - timestamp '2018-01-01')))::timestamptz,
    now(),
    NULL::timestamptz
  FROM generate_series(1, 500) AS gs(i);

  -- Profiles (bias: most users have 1, some have 2+; cap per-plan max via later logic is out of scope, but realism kept)
  INSERT INTO profiles (user_id, name, avatar_url, is_kids, created_at, updated_at)
  SELECT
    -- spread profiles across users (ensures all profiles belong to active users)
    (1 + floor(random() * 500))::INT,
    (first_names[1 + floor(random() * array_length(first_names, 1))::INT] || ' ' ||
     last_names[1 + floor(random() * array_length(last_names, 1))::INT] || ' ' || gs.i),
    ('https://cdn.example.com/avatars/' || (1 + (gs.i % 40))::TEXT || '.png'),
    (random() < 0.15),
    (timestamp '2019-01-01' + (random() * (now() - timestamp '2019-01-01')))::timestamptz,
    now()
  FROM generate_series(1, 500) AS gs(i);

  -- Content
  PERFORM 1;
  DO $inner$
  DECLARE
    titles TEXT[] := ARRAY[
      'Ocean of Dreams','Neon City Nights','The Last Frontier','Hidden Signals','Crimson Horizon',
      'Midnight Harbor','Paper Satellites','Glass Kingdom','Silent Frequency','Echoes of Tomorrow',
      'Ironwood','Blue Meridian','Arctic Drift','Sunset Protocol','Violet Run',
      'The Long Weekend','Parallel Streets','Shadow Market','Brightwater','Lunar Divide',
      'Cobalt Hearts','Stormchaser','The Archivist','Golden Hour','Blackout Station',
      'Wilderness Code','The Ninth Door','After the Applause','Under Static','Gravity Lane',
      'Signal & Noise','Hometown Legends','The Trial Room','Wildfire Season','Northern Lights'
    ];
    ratings TEXT[] := ARRAY['G','PG','PG-13','R','TV-Y','TV-Y7','TV-G','TV-PG','TV-14','TV-MA'];
    ctype content_type;
    base_title TEXT;
    release_y INT;
    dur INT;
    ar TEXT;
    j INT;
    created_ts TIMESTAMPTZ;
  BEGIN
    FOR j IN 1..500 LOOP
      base_title := titles[1 + ((j - 1) % array_length(titles, 1))];
      -- add suffix for uniqueness while keeping realistic titles
      IF j > array_length(titles, 1) THEN
        base_title := base_title || ' ' || ((j - 1) / array_length(titles, 1) + 1)::TEXT;
      END IF;

      ctype := CASE WHEN random() < 0.6 THEN 'movie'::content_type ELSE 'tv_show'::content_type END;
      release_y := (1990 + floor(random() * 36))::INT;
      ar := ratings[1 + floor(random() * array_length(ratings, 1))::INT];

      IF ctype = 'movie' THEN
        dur := (75 + floor(random() * 110))::INT; -- 75-184
      ELSE
        dur := (22 + floor(random() * 45))::INT; -- 22-66 typical episode runtime
      END IF;

      created_ts := (timestamp '2019-01-01' + (random() * (now() - timestamp '2019-01-01')))::timestamptz;

      INSERT INTO content (title, content_type, release_year, duration_minutes, age_rating, description, created_at, updated_at)
      VALUES (
        base_title,
        ctype,
        release_y,
        dur,
        ar,
        'A streaming title in the Netflix-style catalog. Mock description generated for realistic testing.',
        created_ts,
        now()
      );
    END LOOP;
  END
  $inner$;
END $$;

-- Content_Genres (1-3 per content)
DO $$
DECLARE
  gcount INT;
  cid BIGINT;
  k INT;
  chosen_genre BIGINT;
BEGIN
  SELECT count(*)::INT INTO gcount FROM genres;
  FOR cid IN SELECT content_id FROM content LOOP
    FOR k IN 1..(1 + floor(random() * 3))::INT LOOP
      chosen_genre := (1 + floor(random() * gcount))::INT;
      INSERT INTO content_genres (content_id, genre_id)
      VALUES (cid, chosen_genre)
      ON CONFLICT DO NOTHING;
    END LOOP;
  END LOOP;
END $$;

-- Episodes for tv_shows
DO $$
DECLARE
  show_id BIGINT;
  seasons INT;
  eps_per_season INT;
  s INT;
  e INT;
  edur INT;
BEGIN
  FOR show_id IN
    SELECT content_id FROM content WHERE content_type = 'tv_show'
  LOOP
    seasons := 1 + floor(random() * 6)::INT;         -- 1..6 seasons
    eps_per_season := 6 + floor(random() * 7)::INT;  -- 6..12 eps per season
    FOR s IN 1..seasons LOOP
      FOR e IN 1..eps_per_season LOOP
        edur := 20 + floor(random() * 45)::INT; -- 20..64
        INSERT INTO episodes (content_id, season, episode_number, title, duration_minutes)
        VALUES (show_id, s, e, ('S' || lpad(s::TEXT, 2, '0') || 'E' || lpad(e::TEXT, 2, '0')), edur)
        ON CONFLICT DO NOTHING;
      END LOOP;
    END LOOP;
  END LOOP;
END $$;

-- Viewing_History (10,000 rows) with realistic timestamp distribution and progress rules
DO $$
DECLARE
  i INT;
  pid BIGINT;
  cid BIGINT;
  ctype content_type;
  base_dur_minutes INT;
  ep_id BIGINT;
  effective_seconds INT;
  prog_seconds INT;
  is_complete BOOLEAN;
  watched_ts TIMESTAMPTZ;
  device TEXT;
  devices TEXT[] := ARRAY['tv','mobile','tablet','web','console'];
  start_ts TIMESTAMPTZ := timestamp '2021-01-01';
BEGIN
  FOR i IN 1..10000 LOOP
    pid := (1 + floor(random() * 500))::INT;
    cid := (1 + floor(random() * 500))::INT;

    SELECT content_type, duration_minutes
    INTO ctype, base_dur_minutes
    FROM content
    WHERE content_id = cid;

    watched_ts := (start_ts + (random() * (now() - start_ts)))::timestamptz;
    device := devices[1 + floor(random() * array_length(devices, 1))::INT];

    ep_id := NULL;
    effective_seconds := base_dur_minutes * 60;

    IF ctype = 'tv_show' THEN
      SELECT e.episode_id, e.duration_minutes
      INTO ep_id, base_dur_minutes
      FROM episodes e
      WHERE e.content_id = cid
      ORDER BY random()
      LIMIT 1;

      IF ep_id IS NOT NULL THEN
        effective_seconds := base_dur_minutes * 60;
      END IF;
    END IF;

    is_complete := (random() < 0.35);
    IF is_complete THEN
      prog_seconds := effective_seconds;
    ELSE
      -- avoid too many near-zero plays; bias toward mid-watch
      prog_seconds := GREATEST(30, floor(random() * (effective_seconds * 0.98))::INT);
    END IF;

    INSERT INTO viewing_history
      (profile_id, content_id, episode_id, watched_at, progress_seconds, completed, device_type)
    VALUES
      (pid, cid, ep_id, watched_ts, prog_seconds, is_complete, device);
  END LOOP;
END $$;

-- Watchlist: aim for ~8,000 unique pairs (profile_id, content_id)
DO $$
DECLARE
  target INT := 8000;
  tries INT := 0;
  pid BIGINT;
  cid BIGINT;
  added_ts TIMESTAMPTZ;
  start_ts TIMESTAMPTZ := timestamp '2021-01-01';
BEGIN
  WHILE (SELECT count(*) FROM watchlist) < target AND tries < 200000 LOOP
    tries := tries + 1;
    pid := (1 + floor(random() * 500))::INT;
    cid := (1 + floor(random() * 500))::INT;
    added_ts := (start_ts + (random() * (now() - start_ts)))::timestamptz;

    INSERT INTO watchlist (profile_id, content_id, added_at)
    VALUES (pid, cid, added_ts)
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;

COMMIT;

