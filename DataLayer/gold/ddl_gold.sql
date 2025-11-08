CREATE SCHEMA IF NOT EXISTS warehouse;

CREATE TABLE IF NOT EXISTS warehouse.dim_genre (
    id_genre INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    genre TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse.dim_prod_comp (
    id_company INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    production_company TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse.dim_country (
    id_country INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    production_country TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse.dim_spoken_lan (
    id_language INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    spoken_language TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse.dim_date (
    id_date INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse.dim_status (
    id_status INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS warehouse.fact_movie (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_movie BIGINT NOT NULL UNIQUE,
    title TEXT NOT NULL,
    original_title TEXT,
    runtime INT,
    budget BIGINT,
    revenue BIGINT,
    popularity REAL,
    vote_average REAL,
    vote_count INT,
    overview TEXT,
    tagline TEXT,
    adult BOOLEAN,
    original_language TEXT,
    fk_dim_date_id_date INT REFERENCES warehouse.dim_date(id_date),
    fk_dim_status_id_status INT REFERENCES warehouse.dim_status(id_status)
);

CREATE TABLE IF NOT EXISTS warehouse.movie_genre (
    fk_fact_movie_id_movie INT REFERENCES warehouse.fact_movie(id_movie) ON DELETE CASCADE,
    fk_dim_genre_id_genre INT REFERENCES warehouse.dim_genre(id_genre) ON DELETE CASCADE,
    PRIMARY KEY (fk_fact_movie_id_movie, fk_dim_genre_id_genre)
);

CREATE TABLE IF NOT EXISTS warehouse.movie_prodcomp (
    fk_fact_movie_id_movie INT REFERENCES warehouse.fact_movie(id_movie) ON DELETE CASCADE,
    fk_dim_prod_comp_id_company INT REFERENCES warehouse.dim_prod_comp(id_company) ON DELETE CASCADE,
    PRIMARY KEY (fk_fact_movie_id_movie, fk_dim_prod_comp_id_company)
);

CREATE TABLE IF NOT EXISTS warehouse.movie_country (
    fk_fact_movie_id_movie INT REFERENCES warehouse.fact_movie(id_movie) ON DELETE CASCADE,
    fk_dim_country_id_country INT REFERENCES warehouse.dim_country(id_country) ON DELETE CASCADE,
    PRIMARY KEY (fk_fact_movie_id_movie, fk_dim_country_id_country)
);

CREATE TABLE IF NOT EXISTS warehouse.movie_spoklang (
    fk_fact_movie_id_movie INT REFERENCES warehouse.fact_movie(id_movie) ON DELETE CASCADE,
    fk_dim_spoken_lan_id_language INT REFERENCES warehouse.dim_spoken_lan(id_language) ON DELETE CASCADE,
    PRIMARY KEY (fk_fact_movie_id_movie, fk_dim_spoken_lan_id_language)
);
