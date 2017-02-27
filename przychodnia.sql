-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.8.2
-- PostgreSQL version: 9.5
-- Project Site: pgmodeler.com.br
-- Model Author: ---


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database
-- ;
-- -- ddl-end --
-- 

-- object: public."Pacjent" | type: TABLE --
-- DROP TABLE IF EXISTS public."Pacjent" CASCADE;
CREATE TABLE public."Pacjent"(
	nr_ubezpieczenia bigint NOT NULL,
	"Imie" varchar(50) NOT NULL,
	"Nazwisko" varchar(50) NOT NULL,
	"Adres_zamieszkania" varchar(100) NOT NULL,
	CONSTRAINT nr_ubezpieczenia PRIMARY KEY (nr_ubezpieczenia)

);
-- ddl-end --
ALTER TABLE public."Pacjent" OWNER TO postgres;
-- ddl-end --

-- object: public."Lekarz" | type: TABLE --
-- DROP TABLE IF EXISTS public."Lekarz" CASCADE;
CREATE TABLE public."Lekarz"(
	nr_identyfikacyjny bigint NOT NULL,
	"Imie" varchar(50) NOT NULL,
	"Nazwisko" varchar(50) NOT NULL,
	nr_telefonu bigint NOT NULL,
	CONSTRAINT nr_identyfikacyjny PRIMARY KEY (nr_identyfikacyjny)

);
-- ddl-end --
ALTER TABLE public."Lekarz" OWNER TO postgres;
-- ddl-end --

-- object: public."Choroby" | type: TABLE --
-- DROP TABLE IF EXISTS public."Choroby" CASCADE;
CREATE TABLE public."Choroby"(
	"Nazwa_choroby" varchar(50) NOT NULL,
	krotki_opis varchar(300) NOT NULL,
	objawy varchar(200) NOT NULL,
	leczenie varchar(200) NOT NULL,
	CONSTRAINT nazwa_choroby PRIMARY KEY ("Nazwa_choroby")

);
-- ddl-end --
ALTER TABLE public."Choroby" OWNER TO postgres;
-- ddl-end --

-- object: public."Leki" | type: TABLE --
-- DROP TABLE IF EXISTS public."Leki" CASCADE;
CREATE TABLE public."Leki"(
	kod_leku bigint NOT NULL,
	nazwa_leku varchar(50) NOT NULL,
	przyjmowalny_z_lekami varchar(300) NOT NULL,
	dawkowanie_producenta varchar(50) NOT NULL,
	przeciwwskazania varchar NOT NULL,
	CONSTRAINT kod_leku PRIMARY KEY (kod_leku)

);
-- ddl-end --
ALTER TABLE public."Leki" OWNER TO postgres;
-- ddl-end --

-- object: public.wizyty | type: TABLE --
-- DROP TABLE IF EXISTS public.wizyty CASCADE;
CREATE TABLE public.wizyty(
	nr_wizyty bigint NOT NULL,
	data_wizyty date NOT NULL,
	"nr_ubezpieczenia_Pacjent" bigint NOT NULL,
	"nr_identyfikacyjny_Lekarz" bigint NOT NULL,
	CONSTRAINT nr_wizyty PRIMARY KEY (nr_wizyty)

);
-- ddl-end --
ALTER TABLE public.wizyty OWNER TO postgres;
-- ddl-end --

-- object: public.recepta | type: TABLE --
-- DROP TABLE IF EXISTS public.recepta CASCADE;
CREATE TABLE public.recepta(
	id_recepty bigint NOT NULL,
	data_wystawienia date NOT NULL,
	"nr_ubezpieczenia_Pacjent" bigint NOT NULL,
	"nr_identyfikacyjny_Lekarz" bigint NOT NULL,
	"Nazwa_choroby_Choroby" varchar(50) NOT NULL,
	"kod_leku_Leki" bigint NOT NULL,
	CONSTRAINT id_recepty PRIMARY KEY (id_recepty)

);
-- ddl-end --
ALTER TABLE public.recepta OWNER TO postgres;
-- ddl-end --

-- object: "Pacjent_fk" | type: CONSTRAINT --
-- ALTER TABLE public.wizyty DROP CONSTRAINT IF EXISTS "Pacjent_fk" CASCADE;
ALTER TABLE public.wizyty ADD CONSTRAINT "Pacjent_fk" FOREIGN KEY ("nr_ubezpieczenia_Pacjent")
REFERENCES public."Pacjent" (nr_ubezpieczenia) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: wizyty_uq | type: CONSTRAINT --
-- ALTER TABLE public.wizyty DROP CONSTRAINT IF EXISTS wizyty_uq CASCADE;
ALTER TABLE public.wizyty ADD CONSTRAINT wizyty_uq UNIQUE ("nr_ubezpieczenia_Pacjent");
-- ddl-end --

-- object: "Lekarz_fk" | type: CONSTRAINT --
-- ALTER TABLE public.wizyty DROP CONSTRAINT IF EXISTS "Lekarz_fk" CASCADE;
ALTER TABLE public.wizyty ADD CONSTRAINT "Lekarz_fk" FOREIGN KEY ("nr_identyfikacyjny_Lekarz")
REFERENCES public."Lekarz" (nr_identyfikacyjny) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: wizyty_uq1 | type: CONSTRAINT --
-- ALTER TABLE public.wizyty DROP CONSTRAINT IF EXISTS wizyty_uq1 CASCADE;
ALTER TABLE public.wizyty ADD CONSTRAINT wizyty_uq1 UNIQUE ("nr_identyfikacyjny_Lekarz");
-- ddl-end --

-- object: "Pacjent_fk" | type: CONSTRAINT --
-- ALTER TABLE public.recepta DROP CONSTRAINT IF EXISTS "Pacjent_fk" CASCADE;
ALTER TABLE public.recepta ADD CONSTRAINT "Pacjent_fk" FOREIGN KEY ("nr_ubezpieczenia_Pacjent")
REFERENCES public."Pacjent" (nr_ubezpieczenia) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: recepta_uq | type: CONSTRAINT --
-- ALTER TABLE public.recepta DROP CONSTRAINT IF EXISTS recepta_uq CASCADE;
ALTER TABLE public.recepta ADD CONSTRAINT recepta_uq UNIQUE ("nr_ubezpieczenia_Pacjent");
-- ddl-end --

-- object: "Lekarz_fk" | type: CONSTRAINT --
-- ALTER TABLE public.recepta DROP CONSTRAINT IF EXISTS "Lekarz_fk" CASCADE;
ALTER TABLE public.recepta ADD CONSTRAINT "Lekarz_fk" FOREIGN KEY ("nr_identyfikacyjny_Lekarz")
REFERENCES public."Lekarz" (nr_identyfikacyjny) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: recepta_uq1 | type: CONSTRAINT --
-- ALTER TABLE public.recepta DROP CONSTRAINT IF EXISTS recepta_uq1 CASCADE;
ALTER TABLE public.recepta ADD CONSTRAINT recepta_uq1 UNIQUE ("nr_identyfikacyjny_Lekarz");
-- ddl-end --

-- object: "Choroby_fk" | type: CONSTRAINT --
-- ALTER TABLE public.recepta DROP CONSTRAINT IF EXISTS "Choroby_fk" CASCADE;
ALTER TABLE public.recepta ADD CONSTRAINT "Choroby_fk" FOREIGN KEY ("Nazwa_choroby_Choroby")
REFERENCES public."Choroby" ("Nazwa_choroby") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Leki_fk" | type: CONSTRAINT --
-- ALTER TABLE public.recepta DROP CONSTRAINT IF EXISTS "Leki_fk" CASCADE;
ALTER TABLE public.recepta ADD CONSTRAINT "Leki_fk" FOREIGN KEY ("kod_leku_Leki")
REFERENCES public."Leki" (kod_leku) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


