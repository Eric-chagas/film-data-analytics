-- Table: public.film_lakehouse

-- DROP TABLE IF EXISTS public.film_lakehouse;

CREATE TABLE IF NOT EXISTS public.film_lakehouse
(
    id integer,
    title text COLLATE pg_catalog."default",
    vote_average real,
    vote_count integer,
    status text COLLATE pg_catalog."default",
    release_date date,
    revenue integer,
    runtime integer,
    adult boolean,
    budget integer,
    original_language text COLLATE pg_catalog."default",
    original_title text COLLATE pg_catalog."default",
    overview text COLLATE pg_catalog."default",
    popularity real,
    tagline text COLLATE pg_catalog."default",
    genre text COLLATE pg_catalog."default",
    production_company text COLLATE pg_catalog."default",
    production_country text COLLATE pg_catalog."default",
    spoken_language text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film_lakehouse
    OWNER to lakehouse;