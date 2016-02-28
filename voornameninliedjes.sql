--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.songoftheday DROP CONSTRAINT songoftheday_song_id_fkey;
ALTER TABLE ONLY public.searchinstruction DROP CONSTRAINT searchinstruction_visit_id_fkey;
ALTER TABLE ONLY public.remark DROP CONSTRAINT remark_visit_id_fkey;
ALTER TABLE ONLY public.remark DROP CONSTRAINT remark_song_id_fkey;
ALTER TABLE ONLY public.visit DROP CONSTRAINT visit_pkey;
ALTER TABLE ONLY public.songoftheday DROP CONSTRAINT songoftheday_pkey;
ALTER TABLE ONLY public.song DROP CONSTRAINT song_pkey;
ALTER TABLE ONLY public.searchinstruction DROP CONSTRAINT searchinstruction_pkey;
ALTER TABLE ONLY public.remark DROP CONSTRAINT remark_pkey;
DROP TABLE public.visit;
DROP SEQUENCE public.visit_id_seq;
DROP TABLE public.songoftheday;
DROP SEQUENCE public.songoftheday_id_seq;
DROP TABLE public.song;
DROP SEQUENCE public.song_id_seq;
DROP TABLE public.searchinstruction;
DROP SEQUENCE public.search_id_seq;
DROP TABLE public.remark;
DROP SEQUENCE public.remark_id_seq;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: remark_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE remark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE remark_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: remark; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE remark (
    id integer DEFAULT nextval('remark_id_seq'::regclass) NOT NULL,
    background text,
    youtube character varying(255),
    commentary text,
    date timestamp without time zone NOT NULL,
    email character varying(255),
    observer character varying(255),
    status character varying(255),
    visit_id integer,
    song_id integer,
    response text,
    responsedate timestamp without time zone
);


ALTER TABLE remark OWNER TO postgres;

--
-- Name: search_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE search_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE search_id_seq OWNER TO postgres;

--
-- Name: searchinstruction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE searchinstruction (
    id integer DEFAULT nextval('search_id_seq'::regclass) NOT NULL,
    argument character varying(255) NOT NULL,
    ipaddress character varying(50),
    date_inserted timestamp without time zone NOT NULL,
    browser character varying(255),
    operatingsystem character varying(255),
    useragent text,
    visit_id integer
);


ALTER TABLE searchinstruction OWNER TO postgres;

--
-- Name: song_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE song_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE song_id_seq OWNER TO postgres;

--
-- Name: song; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE song (
    id integer DEFAULT nextval('song_id_seq'::regclass) NOT NULL,
    artist character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    firstname character varying(50) NOT NULL,
    name_index integer NOT NULL,
    name_length integer NOT NULL,
    date_inserted timestamp without time zone NOT NULL,
    date_modified timestamp without time zone,
    user_inserted character varying(255) NOT NULL,
    user_modified character varying(255),
    youtube character varying(255),
    background text,
    artist_spotify_id character varying(50)
);


ALTER TABLE song OWNER TO postgres;

--
-- Name: songoftheday_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE songoftheday_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE songoftheday_id_seq OWNER TO postgres;

--
-- Name: songoftheday; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE songoftheday (
    id integer DEFAULT nextval('songoftheday_id_seq'::regclass) NOT NULL,
    day date NOT NULL,
    song_id integer NOT NULL
);


ALTER TABLE songoftheday OWNER TO postgres;

--
-- Name: visit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE visit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visit_id_seq OWNER TO postgres;

--
-- Name: visit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE visit (
    id integer DEFAULT nextval('visit_id_seq'::regclass) NOT NULL,
    ipaddress character varying(50),
    country character varying(255),
    city character varying(255),
    browser character varying(255),
    operatingsystem character varying(255),
    date_inserted timestamp without time zone NOT NULL,
    useragent text,
    countrycode character varying(3),
    latitude numeric(10,4),
    longitude numeric(10,4)
);


ALTER TABLE visit OWNER TO postgres;

--
-- Name: remark_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY remark
    ADD CONSTRAINT remark_pkey PRIMARY KEY (id);


--
-- Name: searchinstruction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY searchinstruction
    ADD CONSTRAINT searchinstruction_pkey PRIMARY KEY (id);


--
-- Name: song_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY song
    ADD CONSTRAINT song_pkey PRIMARY KEY (id);


--
-- Name: songoftheday_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY songoftheday
    ADD CONSTRAINT songoftheday_pkey PRIMARY KEY (id);


--
-- Name: visit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visit
    ADD CONSTRAINT visit_pkey PRIMARY KEY (id);


--
-- Name: remark_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY remark
    ADD CONSTRAINT remark_song_id_fkey FOREIGN KEY (song_id) REFERENCES song(id);


--
-- Name: remark_visit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY remark
    ADD CONSTRAINT remark_visit_id_fkey FOREIGN KEY (visit_id) REFERENCES visit(id);


--
-- Name: searchinstruction_visit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY searchinstruction
    ADD CONSTRAINT searchinstruction_visit_id_fkey FOREIGN KEY (visit_id) REFERENCES visit(id);


--
-- Name: songoftheday_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY songoftheday
    ADD CONSTRAINT songoftheday_song_id_fkey FOREIGN KEY (song_id) REFERENCES song(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

