-- Table: lakehouse.film_lakehouse

CREATE SCHEMA IF NOT EXISTS lakehouse;

CREATE TABLE IF NOT EXISTS lakehouse.film_lakehouse
(
    id                  BIGINT,
    title               VARCHAR(255) NOT NULL,
    vote_average        NUMERIC(3,1),
    vote_count          INTEGER,
    status              VARCHAR(30),
    release_date        DATE,
    revenue             BIGINT,
    runtime             SMALLINT,
    adult               BOOLEAN DEFAULT FALSE,
    budget              BIGINT,
    original_language   CHAR(2),
    original_title      VARCHAR(255),
    overview            TEXT,
    popularity          NUMERIC(10,3),
    tagline             VARCHAR(255),
    genre               VARCHAR(100),
    production_company  VARCHAR(255),
    production_country  VARCHAR(50),
    spoken_language     VARCHAR(50)
);

ALTER TABLE IF EXISTS lakehouse.film_lakehouse
    OWNER to lakehouse;

-- DROP TABLE IF EXISTS lakehouse.film_lakehouse;