--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

-- Started on 2018-04-10 15:01:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 8 (class 2615 OID 43316)
-- Name: brut; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA brut;


ALTER SCHEMA brut OWNER TO postgres;

SET search_path = brut, pg_catalog;

--
-- TOC entry 1395 (class 1255 OID 44790)
-- Name: func_maree_periode(); Type: FUNCTION; Schema: brut; Owner: postgres
--

CREATE FUNCTION func_maree_periode() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
    if new.mar_date_time_p1 = new.mar_date_time_p2 then
        update brut.maree set mar_date_time_p1 = new.mar_date_time_p1 - interval '2 hours',
                mar_date_time_p2 = new.mar_date_time_p2 + interval '2 hours'
        Where mar_id = new.mar_id;
    else
    update brut.maree set mar_date_time_p1 = new.mar_date_time_p1 + interval '2 hours',
                mar_date_time_p2 = new.mar_date_time_p2 - interval '2 hours'
        Where mar_id = new.mar_id;
    END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION brut.func_maree_periode() OWNER TO postgres;

--
-- TOC entry 1396 (class 1255 OID 44791)
-- Name: func_obs_gmt(); Type: FUNCTION; Schema: brut; Owner: postgres
--

CREATE FUNCTION func_obs_gmt() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE brut.observation set obs_date_time = (obs_date + obs_heure) AT TIME ZONE 'GMT'
    Where obs_id = new.obs_id;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION brut.func_obs_gmt() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 44792)
-- Name: age; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE age (
    age_id integer NOT NULL,
    age_libelle character varying(20) NOT NULL
);


ALTER TABLE age OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 44795)
-- Name: age_age_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE age_age_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE age_age_id_seq OWNER TO postgres;

--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 199
-- Name: age_age_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE age_age_id_seq OWNED BY age.age_id;


--
-- TOC entry 200 (class 1259 OID 44797)
-- Name: ancien_logger; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE ancien_logger (
    anc_log character(5) NOT NULL,
    anc_ind_id integer
);


ALTER TABLE ancien_logger OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 44800)
-- Name: cycle_biologique; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE cycle_biologique (
    cycle_id integer NOT NULL,
    cycle_libelle character varying(25) NOT NULL
);


ALTER TABLE cycle_biologique OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 44803)
-- Name: cycle_biologique_cycle_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE cycle_biologique_cycle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cycle_biologique_cycle_id_seq OWNER TO postgres;

--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 202
-- Name: cycle_biologique_cycle_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE cycle_biologique_cycle_id_seq OWNED BY cycle_biologique.cycle_id;


--
-- TOC entry 203 (class 1259 OID 44805)
-- Name: district_capture; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE district_capture (
    distr_id integer NOT NULL,
    distr_nom character varying(50)
);


ALTER TABLE district_capture OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 44808)
-- Name: district_capture_distr_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE district_capture_distr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE district_capture_distr_id_seq OWNER TO postgres;

--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 204
-- Name: district_capture_distr_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE district_capture_distr_id_seq OWNED BY district_capture.distr_id;


--
-- TOC entry 205 (class 1259 OID 44810)
-- Name: espece; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE espece (
    esp_id integer NOT NULL,
    esp_nomfr character varying(50),
    esp_nom_latin character varying(50) NOT NULL
);


ALTER TABLE espece OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 44813)
-- Name: espece_esp_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE espece_esp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE espece_esp_id_seq OWNER TO postgres;

--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 206
-- Name: espece_esp_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE espece_esp_id_seq OWNED BY espece.esp_id;


--
-- TOC entry 207 (class 1259 OID 44815)
-- Name: fichier; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE fichier (
    fich_id integer NOT NULL,
    fich_date_insert date DEFAULT date(now()) NOT NULL,
    fich_chemin character varying(2000) NOT NULL,
    fich_goel_id integer,
    fich_goel boolean,
    fich_goel_chemin character varying(2000)
);


ALTER TABLE fichier OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 44822)
-- Name: fichier_fich_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE fichier_fich_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fichier_fich_id_seq OWNER TO postgres;

--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 208
-- Name: fichier_fich_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE fichier_fich_id_seq OWNED BY fichier.fich_id;


--
-- TOC entry 209 (class 1259 OID 44824)
-- Name: individu; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE individu (
    ind_id integer NOT NULL,
    ind_sexe_m boolean DEFAULT false,
    ind_aile double precision DEFAULT 0,
    ind_bec double precision DEFAULT 0,
    ind_tarse double precision DEFAULT 0,
    ind_masse double precision DEFAULT 0,
    ind_date_capt date,
    ind_no_bague character varying(10),
    ind_log character varying(6) NOT NULL,
    ind_code_droit character varying(15),
    ind_code_gauche character varying(15),
    ind_esp_id integer,
    ind_distr_id integer NOT NULL,
    ind_age_id integer DEFAULT 0,
    ind_actif boolean DEFAULT true,
    ind_sexe_verif boolean DEFAULT false
);


ALTER TABLE individu OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 44835)
-- Name: individu_ind_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE individu_ind_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE individu_ind_id_seq OWNER TO postgres;

--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 210
-- Name: individu_ind_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE individu_ind_id_seq OWNED BY individu.ind_id;


--
-- TOC entry 211 (class 1259 OID 44837)
-- Name: lune; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE lune (
    lune_id integer NOT NULL,
    lune_date timestamp with time zone NOT NULL,
    lune_phase character varying(20)
);


ALTER TABLE lune OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 44840)
-- Name: lune_lune_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE lune_lune_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lune_lune_id_seq OWNER TO postgres;

--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 212
-- Name: lune_lune_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE lune_lune_id_seq OWNED BY lune.lune_id;


--
-- TOC entry 213 (class 1259 OID 44842)
-- Name: maree; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE maree (
    mar_id integer NOT NULL,
    mar_date_time_p1 timestamp with time zone NOT NULL,
    mar_date_time_p2 timestamp with time zone NOT NULL,
    mar_coef integer,
    mar_marnage double precision,
    mar_tymar_id integer
);


ALTER TABLE maree OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 44845)
-- Name: maree_mar_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE maree_mar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE maree_mar_id_seq OWNER TO postgres;

--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 214
-- Name: maree_mar_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE maree_mar_id_seq OWNED BY maree.mar_id;


--
-- TOC entry 215 (class 1259 OID 44847)
-- Name: meteo; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE meteo (
    met_id integer NOT NULL,
    met_nebulosite integer,
    met_vent double precision NOT NULL,
    met_directionv integer NOT NULL,
    met_temperature double precision NOT NULL,
    met_date_time timestamp with time zone NOT NULL
);


ALTER TABLE meteo OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 44850)
-- Name: meteo_met_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE meteo_met_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE meteo_met_id_seq OWNER TO postgres;

--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 216
-- Name: meteo_met_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE meteo_met_id_seq OWNED BY meteo.met_id;


--
-- TOC entry 217 (class 1259 OID 44852)
-- Name: observation; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE observation (
    obs_id integer NOT NULL,
    obs_date date NOT NULL,
    obs_heure time without time zone NOT NULL,
    obs_geom public.geometry(Point,4326),
    obs_searching_time integer,
    obs_gps_voltage double precision,
    obs_gps_temperature integer,
    obs_verifiee boolean DEFAULT false,
    obs_distance_points double precision,
    obs_speed double precision,
    obs_fich_id integer,
    obs_cycle_id integer DEFAULT 0,
    obs_ind_id integer,
    obs_tyact_id integer DEFAULT 0 NOT NULL,
    obs_date_time timestamp with time zone
);


ALTER TABLE observation OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 44861)
-- Name: observation_obs_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE observation_obs_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE observation_obs_id_seq OWNER TO postgres;

--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 218
-- Name: observation_obs_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE observation_obs_id_seq OWNED BY observation.obs_id;


--
-- TOC entry 219 (class 1259 OID 44863)
-- Name: soleil; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE soleil (
    sol_id integer NOT NULL,
    sol_civil boolean NOT NULL,
    sol_date_time timestamp with time zone NOT NULL,
    sol_tysol_id integer
);


ALTER TABLE soleil OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 44866)
-- Name: soleil_sol_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE soleil_sol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE soleil_sol_id_seq OWNER TO postgres;

--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 220
-- Name: soleil_sol_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE soleil_sol_id_seq OWNED BY soleil.sol_id;


--
-- TOC entry 221 (class 1259 OID 44868)
-- Name: type_activite; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE type_activite (
    tyact_id integer NOT NULL,
    tyact_nom character varying(25) NOT NULL
);


ALTER TABLE type_activite OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 44871)
-- Name: type_activite_tyact_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE type_activite_tyact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE type_activite_tyact_id_seq OWNER TO postgres;

--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 222
-- Name: type_activite_tyact_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE type_activite_tyact_id_seq OWNED BY type_activite.tyact_id;


--
-- TOC entry 223 (class 1259 OID 44873)
-- Name: type_maree; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE type_maree (
    tymar_id integer NOT NULL,
    tymar_libelle character varying(25) NOT NULL
);


ALTER TABLE type_maree OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 44876)
-- Name: type_maree_tymar_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE type_maree_tymar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE type_maree_tymar_id_seq OWNER TO postgres;

--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 224
-- Name: type_maree_tymar_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE type_maree_tymar_id_seq OWNED BY type_maree.tymar_id;


--
-- TOC entry 225 (class 1259 OID 44878)
-- Name: type_soleil; Type: TABLE; Schema: brut; Owner: postgres
--

CREATE TABLE type_soleil (
    tysol_id integer NOT NULL,
    tysol_libelle character varying(25) NOT NULL
);


ALTER TABLE type_soleil OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 44881)
-- Name: type_soleil_tysol_id_seq; Type: SEQUENCE; Schema: brut; Owner: postgres
--

CREATE SEQUENCE type_soleil_tysol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE type_soleil_tysol_id_seq OWNER TO postgres;

--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 226
-- Name: type_soleil_tysol_id_seq; Type: SEQUENCE OWNED BY; Schema: brut; Owner: postgres
--

ALTER SEQUENCE type_soleil_tysol_id_seq OWNED BY type_soleil.tysol_id;


--
-- TOC entry 3422 (class 2604 OID 44883)
-- Name: age_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY age ALTER COLUMN age_id SET DEFAULT nextval('age_age_id_seq'::regclass);


--
-- TOC entry 3423 (class 2604 OID 44884)
-- Name: cycle_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY cycle_biologique ALTER COLUMN cycle_id SET DEFAULT nextval('cycle_biologique_cycle_id_seq'::regclass);


--
-- TOC entry 3424 (class 2604 OID 44885)
-- Name: distr_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY district_capture ALTER COLUMN distr_id SET DEFAULT nextval('district_capture_distr_id_seq'::regclass);


--
-- TOC entry 3425 (class 2604 OID 44886)
-- Name: esp_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY espece ALTER COLUMN esp_id SET DEFAULT nextval('espece_esp_id_seq'::regclass);


--
-- TOC entry 3427 (class 2604 OID 44887)
-- Name: fich_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY fichier ALTER COLUMN fich_id SET DEFAULT nextval('fichier_fich_id_seq'::regclass);


--
-- TOC entry 3436 (class 2604 OID 44888)
-- Name: ind_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY individu ALTER COLUMN ind_id SET DEFAULT nextval('individu_ind_id_seq'::regclass);


--
-- TOC entry 3437 (class 2604 OID 44889)
-- Name: lune_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY lune ALTER COLUMN lune_id SET DEFAULT nextval('lune_lune_id_seq'::regclass);


--
-- TOC entry 3438 (class 2604 OID 44890)
-- Name: mar_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY maree ALTER COLUMN mar_id SET DEFAULT nextval('maree_mar_id_seq'::regclass);


--
-- TOC entry 3439 (class 2604 OID 44891)
-- Name: met_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY meteo ALTER COLUMN met_id SET DEFAULT nextval('meteo_met_id_seq'::regclass);


--
-- TOC entry 3443 (class 2604 OID 44892)
-- Name: obs_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY observation ALTER COLUMN obs_id SET DEFAULT nextval('observation_obs_id_seq'::regclass);


--
-- TOC entry 3444 (class 2604 OID 44893)
-- Name: sol_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY soleil ALTER COLUMN sol_id SET DEFAULT nextval('soleil_sol_id_seq'::regclass);


--
-- TOC entry 3445 (class 2604 OID 44894)
-- Name: tyact_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY type_activite ALTER COLUMN tyact_id SET DEFAULT nextval('type_activite_tyact_id_seq'::regclass);


--
-- TOC entry 3446 (class 2604 OID 44895)
-- Name: tymar_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY type_maree ALTER COLUMN tymar_id SET DEFAULT nextval('type_maree_tymar_id_seq'::regclass);


--
-- TOC entry 3447 (class 2604 OID 44896)
-- Name: tysol_id; Type: DEFAULT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY type_soleil ALTER COLUMN tysol_id SET DEFAULT nextval('type_soleil_tysol_id_seq'::regclass);


--
-- TOC entry 3619 (class 0 OID 44792)
-- Dependencies: 198
-- Data for Name: age; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY age (age_id, age_libelle) FROM stdin;
0	Non défini
1	Juvénile
2	Adulte
3	Indéterminé
\.


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 199
-- Name: age_age_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('age_age_id_seq', 3, true);


--
-- TOC entry 3621 (class 0 OID 44797)
-- Dependencies: 200
-- Data for Name: ancien_logger; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY ancien_logger (anc_log, anc_ind_id) FROM stdin;
URI10	49
URI05	23
\.


--
-- TOC entry 3622 (class 0 OID 44800)
-- Dependencies: 201
-- Data for Name: cycle_biologique; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY cycle_biologique (cycle_id, cycle_libelle) FROM stdin;
0	Non défini
1	hivernage
2	migration
3	reproduction
4	Migration pré-nuptiale
5	Halte pré-nuptiale
6	Migration post-nuptiale
7	Halte post-nuptiale
\.


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 202
-- Name: cycle_biologique_cycle_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('cycle_biologique_cycle_id_seq', 8, true);


--
-- TOC entry 3624 (class 0 OID 44805)
-- Dependencies: 203
-- Data for Name: district_capture; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY district_capture (distr_id, distr_nom) FROM stdin;
1	Moëze-Oléron
2	ile de Ré
0	All
\.


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 204
-- Name: district_capture_distr_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('district_capture_distr_id_seq', 2, true);


--
-- TOC entry 3626 (class 0 OID 44810)
-- Dependencies: 205
-- Data for Name: espece; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY espece (esp_id, esp_nomfr, esp_nom_latin) FROM stdin;
1	Barge rousse	Limosa lapponica
2	Barge à queue noire	Limosa limosa
3	Courlis cendré	Numenius arquata
4	Huitrier pie	Haematopus ostralegus
5	Pluvier argenté	Pluvialis squatarola
\.


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 206
-- Name: espece_esp_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('espece_esp_id_seq', 5, true);


--
-- TOC entry 3628 (class 0 OID 44815)
-- Dependencies: 207
-- Data for Name: fichier; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY fichier (fich_id, fich_date_insert, fich_chemin, fich_goel_id, fich_goel, fich_goel_chemin) FROM stdin;
13	2018-04-02	D:/01_LP_SIG_2018/05_PTUT/Données/Test_Import_27_03_18.csv	\N	t	C:/Users/Panda/Downloads/goel1.csv
\.


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 208
-- Name: fichier_fich_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('fichier_fich_id_seq', 13, true);


--
-- TOC entry 3630 (class 0 OID 44824)
-- Dependencies: 209
-- Data for Name: individu; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY individu (ind_id, ind_sexe_m, ind_aile, ind_bec, ind_tarse, ind_masse, ind_date_capt, ind_no_bague, ind_log, ind_code_droit, ind_code_gauche, ind_esp_id, ind_distr_id, ind_age_id, ind_actif, ind_sexe_verif) FROM stdin;
2	f	0	0	0	220	2017-11-20	FS100516	PAF24	Yof	YO	5	1	2	t	f
3	f	229	102.5	89	364	2018-02-20	FS100550	BQN03	BdW	Y/Y/Y	2	1	2	t	t
4	f	214	93.5	76.5	283	2018-02-20	FS100548	BQN09	BdW	Y/Y/W	2	1	2	t	f
5	t	208	85.5	79.5	306	2018-02-20	FS100549	BQN01	BdW	Y/Y/G	2	1	3	t	t
6	f	215.5	97	81.5	334	2018-02-20	FS100543	PIF12	BdW	Y/W/O	2	1	2	t	f
7	t	207	73	73	323	2017-12-19	FS100534	PIF10	BdW	Y/W/N	2	1	3	t	t
8	f	212	97.5	84	289	2018-02-20	FS100546	BQN11	BdW	Y/W/N	2	1	2	t	f
9	t	217	78	74	301	2018-02-20	FS100556	BQN14	BdW	Y/O/O	2	1	2	t	t
10	f	226	106	89	326	2018-02-20	FS100560	BQN04	BdW	Y/N/Y	2	1	1	t	t
11	t	209	85.5	74	271	2018-02-20	FS100561	BQN07	BdW	Y/N/O	2	1	2	t	t
12	t	216	79.5	72	297	2018-02-20	FS100562	BQN08	BdW	Y/N/N	2	1	2	t	t
13	t	207	79	79	279	2018-02-20	FS100559	BQN13	BdW	Y/N/G	2	1	2	t	t
14	t	200	90.5	70.5	242	2018-02-20	FS100544	PAF21	BdW	Y/G/Y	2	1	2	t	t
15	t	215	86	79	329	2017-12-19	FS100538	PIF13	BdW	Y/G/W	2	1	3	t	t
16	f	226.5	95	87.5	385	2018-02-20	FS100545	BQN02	BdW	Y/G/O	2	1	2	f	t
17	t	296	121	91	694	2016-08-31	EA580425	MOZ04	OFR	WV	3	1	3	t	t
18	t	292.5	108.5	90	683	2016-08-02	EA542002	MOZ01	BOf	WR	3	1	2	t	t
19	f	224	105	66	319	2015-12-11	FS100142	LIM26	OfR	WO	1	2	3	t	t
20	t	212	81	72.5	292	2017-09-22	FS100443	MOZ23	OWY	WNd	2	1	1	t	t
21	f	210	98.5	85.5	365	2017-09-22	FS100441	MOZ27	OWN	WNd	2	1	3	t	f
22	t	200	75	71	292	2017-09-22	FS100445	MOZ17	OWG	WNd	2	1	3	t	t
23	f	317	157	101	891	2015-10-13	EA581481	LIM29	WOf	WJ	3	2	3	t	t
24	f	320	143	93	830	2016-08-31	EA580426	MOZ10	OFR	WJ	3	1	3	t	t
25	t	209	85	79	305	2017-10-19	FS100314	PIF06	O/N/Y	WdN	2	1	1	t	t
26	t	201	80	76	298	2017-10-19	FS100328	PIF05	O/G/G	WdN	2	1	3	t	t
27	f	304	139	96	887	2015-10-13	EA581476	URA24	WOf	VW	3	2	3	f	t
28	t	308	124	90	687	2016-08-31	EA580421	MOZ05	OFR	VW	3	1	3	f	t
29	f	218	94	62	307	2015-11-11	FS100102	URI19	JOf	VW	1	2	1	f	t
30	f	269	144	90	777	2015-10-13	EA581479	IRU04	WOf	VR	3	2	3	t	f
31	f	318	147	100	774	2016-08-31	EA580424	MOZ07	OFR	VR	3	1	3	t	t
32	f	324	137.5	102.5	861	2015-11-11	EA581492	URI13	WOf	VP	3	2	3	t	t
33	f	304	142.5	90	760	2015-10-13	EA581477	URI01	WOf	VJ	3	2	3	t	t
34	f	225	95	62	326	2015-11-11	FS100090	URI17	OfR	VJ	1	2	3	t	t
35	f	309	138	95	810	2016-08-02	EA580422	MOZ03	OFR	VJ	3	1	3	f	f
36	f	224	93.5	88	345	2017-09-22	FS100448	MOZ30	OYY	RWd	2	1	3	t	t
37	f	208	100	63	296	2016-11-01	DD84945	MOZ19	OfR	RV	1	2	3	f	t
38	f	307	127	96	783	2016-08-02	4025065	MOZ02	GRR	RRY	3	1	2	t	t
39	t	310	121	99	753	2015-12-11	EA542078	IRU12	WV	ROf	3	2	3	t	t
40	f	318	154	100	930	2015-12-11	EA542077	IRU07	WP	ROf	3	2	3	t	t
41	f	229	105	66	335	2015-10-13	FS100057	IRU06	WJ	ROf	1	2	3	t	t
42	f	327	158	95	970	2015-12-11	EA542069	LIM24	VR	ROf	3	2	3	t	t
43	f	232	101	62	316	2016-11-01	FS100398	MOZ15	VO	ROf	1	2	3	t	t
44	f	223	86	59	297	2016-11-01	FS100663	MOZ18	RJ	ROf	1	2	3	f	f
45	f	306	128	96	798	2015-12-11	EA542071	FAB01	PB	ROf	3	2	3	t	t
46	f	228	96	61	308	2016-11-01	FS100659	MOZ17	OJ	ROf	1	2	3	f	t
47	t	211	83	73.5	267	2016-11-30	FS100470	MOZ12	JV	ROF	2	1	3	t	t
48	t	288	124	92	744	2015-12-11	EA542082	LI24	JP	ROf	3	2	3	f	t
50	f	226	97	89	381	2016-11-30	FS100471	MOZ29	JB	ROF	2	1	3	t	t
51	f	327	140	99	979	2015-12-11	EA542073	LIM22	BW	ROf	3	2	3	t	t
52	f	216	99	64.5	325	2015-10-13	FS100061	IRU09	BW	ROf	1	2	3	t	t
53	t	304	112	94	808	2015-12-11	EA542076	LIM21	BR	ROf	3	2	3	t	t
54	f	330	154	101	1036	2015-12-11	EA542070	LIM25	BP	ROf	3	2	3	t	t
55	f	315	157	96	902	2015-12-11	EA542075	IRU29	BO	ROf	3	2	1	t	t
56	f	232	97	77	338	2016-11-30	FS100452	MOZ26	OFR	R/O	2	1	3	t	t
57	t	311	114	91	724	2015-11-11	EA581486	URA08	WOf	PW	3	2	3	f	t
58	t	275	113	90	742	2015-10-13	EA581474	URI02	OfW	PO	3	2	3	t	t
59	t	292	120	95	778	2016-10-30	EA581639	MOZ13	OfB	PO	3	1	2	t	t
60	f	279	145	100	856	2016-10-30	EA580435	MOZ25	OFR	OW	3	1	3	f	t
61	f	320	136	95	930	2015-11-11	EA581490	URA21	WOf	OP	3	2	3	f	t
62	t	292	123	94	746	2016-10-30	EA580436	MOZ24	OFR	OJ	3	1	3	f	t
63	f	207	29	56	236	2017-10-19	FS100503	PAF20	WY	OfW	5	1	3	t	f
64	t	207	81	68	282	2016-11-01	FS100652	MOZ16	V+A22:L62	OfR	2	2	3	t	t
65	f	225	100	62	322	2015-10-13	FS85656	IRU08	RW	OfR	1	2	2	f	t
66	t	206	84	77.5	302	2016-11-01	FS100392	MOZ11	RV	OFR	2	2	3	t	t
67	f	222	94	83	364	2017-11-20	FS100508	PIF11	O/W/O	OdN	2	1	3	t	t
68	f	220	96	84	345	2017-10-19	FS100347	PIF08	O/W/N	OdN	2	1	3	t	t
69	t	215	84	73	376	2017-10-19	FS100329	PIF02	RdW	O/W/W	2	1	3	t	t
70	t	204	77	77	281	2017-10-19	FS100343	PIF09	RdW	O/O/W	2	1	3	t	t
71	t	210	93	76	301	2017-10-19	FS100344	PIF03	RdW	O/O/N	2	1	3	t	t
72	t	216	75	79	309	2017-10-19	FS100335	PIF07	RdW	O/N/Y	2	1	3	t	t
73	t	206	75	75	290	2017-10-19	FS100336	PIF04	RdW	O/N/O	2	1	3	t	t
74	f	327	145	105	893	2016-08-31	EA580430	MOZ08	OFR	JV	3	1	3	t	t
75	f	230	101	65.5	332	2015-11-11	FS100112	URI14	JOf	JV	1	2	2	t	t
76	f	228.5	106.5	64	327	2015-11-11	FS100096	URA27	OfR	JR	1	2	3	f	t
77	t	305	114	92	712	2016-08-31	EA580433	MOZ06	OFR	JR	3	1	3	t	t
78	f	225.5	101	64	311	2015-11-11	FS100114	URA30	JOf	JR	1	2	1	f	t
79	t	301	117	0	722	2015-11-11	EA581487	IRU11	WOf	JP	3	2	3	t	t
80	t	291	125	88	650	2015-11-11	EA581489	URA22	WOf	JO	3	2	3	t	t
81	t	295	119	93	638	2016-08-31	EA580432	MOZ09	OFR	JO	3	1	3	f	t
82	f	214	102	61	307	2015-11-11	FS100095	URI16	OfR	JB	1	2	3	f	t
84	f	225	96.5	65	321	2015-11-11	FS100091	URI18	OfR	BW	1	2	3	f	t
85	f	221	96	60	301	2015-11-11	FS100105	URI20	JOf	BW	1	2	3	f	t
86	f	311	138	105	994	2016-10-30	EA542017	MOZ14	OfW	BO	3	1	2	t	t
87	f	223	87	85	379	2017-12-19	FS100521	PIF14	Y/W/Y	BdW	2	1	3	t	f
88	f	213	94	78	317	2018-02-20	FS100563	BQN06	Y/W/O	BdW	2	1	1	t	f
89	f	228	97	86.5	383	2017-12-19	FS100520	PIF12	Y/W/G	BdW	2	1	3	f	t
90	t	215	83	72	325	2017-12-19	FS100524	PIF01	Y/G/Y	BdW	2	1	3	t	t
91	f	227	103	85	315	2017-12-19	FS100523	PIF15	Y/G/W	BdW	2	1	1	t	t
83	f	261	82	67	534	2017-09-22	EC103753	MOZ28	\N	Flag blanc	4	1	2	t	f
92	f	0	0	0	0	2018-02-20	FS100566	PAF25	\N	\N	2	1	0	f	f
93	f	0	0	0	0	2018-02-20	FS100555	BQN12	\N	\N	2	1	0	f	t
94	f	0	0	0	0	2018-02-20	FS100547	BQN10	\N	\N	2	1	0	f	t
95	f	0	0	0	0	2018-02-20	FS100564	BQN05	\N	\N	2	1	0	f	f
49	f	201	91.5	57	301	2015-10-13	FS100067	MOZ20	JB	ROf	1	2	3	t	t
\.


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 210
-- Name: individu_ind_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('individu_ind_id_seq', 95, true);


--
-- TOC entry 3632 (class 0 OID 44837)
-- Dependencies: 211
-- Data for Name: lune; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY lune (lune_id, lune_date, lune_phase) FROM stdin;
1	2015-01-05 00:00:00+01	0.5
2	2015-01-13 00:00:00+01	0.75
3	2015-01-20 00:00:00+01	0
4	2015-01-27 00:00:00+01	0.25
5	2015-02-03 00:00:00+01	0.5
6	2015-02-11 00:00:00+01	0.75
7	2015-02-18 00:00:00+01	0
8	2015-02-25 00:00:00+01	0.25
9	2015-03-05 00:00:00+01	0.5
10	2015-03-13 00:00:00+01	0.75
11	2015-03-20 00:00:00+01	0
12	2015-03-27 00:00:00+01	0.25
13	2015-04-04 00:00:00+02	0.5
14	2015-04-11 00:00:00+02	0.75
15	2015-04-18 00:00:00+02	0
16	2015-04-26 00:00:00+02	0.25
17	2015-05-04 00:00:00+02	0.5
18	2015-05-11 00:00:00+02	0.75
19	2015-05-18 00:00:00+02	0
20	2015-05-25 00:00:00+02	0.25
21	2015-06-02 00:00:00+02	0.5
22	2015-06-09 00:00:00+02	0.75
23	2015-06-16 00:00:00+02	0
24	2015-06-24 00:00:00+02	0.25
25	2015-07-02 00:00:00+02	0.5
26	2015-07-08 00:00:00+02	0.75
27	2015-07-16 00:00:00+02	0
28	2015-07-24 00:00:00+02	0.25
29	2015-07-31 00:00:00+02	0.5
30	2015-08-07 00:00:00+02	0.75
31	2015-08-14 00:00:00+02	0
32	2015-08-22 00:00:00+02	0.25
33	2015-08-29 00:00:00+02	0.5
34	2015-09-05 00:00:00+02	0.75
35	2015-09-13 00:00:00+02	0
36	2015-09-21 00:00:00+02	0.25
37	2015-09-28 00:00:00+02	0.5
38	2015-10-05 00:00:00+02	0.75
39	2015-10-13 00:00:00+02	0
40	2015-10-20 00:00:00+02	0.25
41	2015-10-27 00:00:00+01	0.5
42	2015-11-03 00:00:00+01	0.75
43	2015-11-11 00:00:00+01	0
44	2015-11-19 00:00:00+01	0.25
45	2015-11-25 00:00:00+01	0.5
46	2015-12-03 00:00:00+01	0.75
47	2015-12-11 00:00:00+01	0
48	2015-12-18 00:00:00+01	0.25
49	2015-12-25 00:00:00+01	0.5
50	2016-01-02 00:00:00+01	0.75
51	2016-01-10 00:00:00+01	0
52	2016-01-17 00:00:00+01	0.25
53	2016-01-24 00:00:00+01	0.5
54	2016-02-01 00:00:00+01	0.75
55	2016-02-08 00:00:00+01	0
56	2016-02-15 00:00:00+01	0.25
57	2016-02-22 00:00:00+01	0.5
58	2016-03-01 00:00:00+01	0.75
59	2016-03-09 00:00:00+01	0
60	2016-03-15 00:00:00+01	0.25
61	2016-03-23 00:00:00+01	0.5
62	2016-03-31 00:00:00+02	0.75
63	2016-04-07 00:00:00+02	0
64	2016-04-14 00:00:00+02	0.25
65	2016-04-22 00:00:00+02	0.5
66	2016-04-29 00:00:00+02	0.75
67	2016-05-06 00:00:00+02	0
68	2016-05-13 00:00:00+02	0.25
69	2016-05-21 00:00:00+02	0.5
70	2016-05-29 00:00:00+02	0.75
71	2016-06-05 00:00:00+02	0
72	2016-06-12 00:00:00+02	0.25
73	2016-06-20 00:00:00+02	0.5
74	2016-06-27 00:00:00+02	0.75
75	2016-07-04 00:00:00+02	0
76	2016-07-12 00:00:00+02	0.25
77	2016-07-19 00:00:00+02	0.5
78	2016-07-26 00:00:00+02	0.75
79	2016-08-02 00:00:00+02	0
80	2016-08-10 00:00:00+02	0.25
81	2016-08-18 00:00:00+02	0.5
82	2016-08-25 00:00:00+02	0.75
83	2016-09-01 00:00:00+02	0
84	2016-09-09 00:00:00+02	0.25
85	2016-09-16 00:00:00+02	0.5
86	2016-09-23 00:00:00+02	0.75
87	2016-10-01 00:00:00+02	0
88	2016-10-08 00:00:00+02	0.25
89	2016-10-16 00:00:00+02	0.5
90	2016-10-23 00:00:00+02	0.75
91	2016-10-30 00:00:00+02	0
92	2016-11-07 00:00:00+01	0.25
93	2016-11-14 00:00:00+01	0.5
94	2016-11-21 00:00:00+01	0.75
95	2016-11-29 00:00:00+01	0
96	2016-12-07 00:00:00+01	0.25
97	2016-12-14 00:00:00+01	0.5
98	2016-12-21 00:00:00+01	0.75
99	2016-12-29 00:00:00+01	0
100	2017-01-05 00:00:00+01	0.25
101	2017-01-12 00:00:00+01	0.5
102	2017-01-20 00:00:00+01	0.75
103	2017-01-28 00:00:00+01	0
104	2017-02-04 00:00:00+01	0.25
105	2017-02-11 00:00:00+01	0.5
106	2017-02-18 00:00:00+01	0.75
107	2017-02-26 00:00:00+01	0
108	2017-03-05 00:00:00+01	0.25
109	2017-03-12 00:00:00+01	0.5
110	2017-03-20 00:00:00+01	0.75
111	2017-03-28 00:00:00+02	0
112	2017-04-03 00:00:00+02	0.25
113	2017-04-11 00:00:00+02	0.5
114	2017-04-19 00:00:00+02	0.75
115	2017-04-26 00:00:00+02	0
116	2017-05-03 00:00:00+02	0.25
117	2017-05-10 00:00:00+02	0.5
118	2017-05-18 00:00:00+02	0.75
119	2017-05-25 00:00:00+02	0
120	2017-06-01 00:00:00+02	0.25
121	2017-06-09 00:00:00+02	0.5
122	2017-06-17 00:00:00+02	0.75
123	2017-06-24 00:00:00+02	0
124	2017-07-01 00:00:00+02	0.25
125	2017-07-09 00:00:00+02	0.5
126	2017-07-16 00:00:00+02	0.75
127	2017-07-23 00:00:00+02	0
128	2017-07-30 00:00:00+02	0.25
129	2017-08-07 00:00:00+02	0.5
130	2017-08-14 00:00:00+02	0.75
131	2017-08-21 00:00:00+02	0
132	2017-08-29 00:00:00+02	0.25
133	2017-09-06 00:00:00+02	0.5
134	2017-09-13 00:00:00+02	0.75
135	2017-09-20 00:00:00+02	0
136	2017-09-28 00:00:00+02	0.25
137	2017-10-05 00:00:00+02	0.5
138	2017-10-12 00:00:00+02	0.75
139	2017-10-19 00:00:00+02	0
140	2017-10-27 00:00:00+02	0.25
141	2017-11-04 00:00:00+01	0.5
142	2017-11-11 00:00:00+01	0.75
143	2017-11-18 00:00:00+01	0
144	2017-11-26 00:00:00+01	0.25
145	2017-12-03 00:00:00+01	0.5
146	2017-12-10 00:00:00+01	0.75
147	2017-12-18 00:00:00+01	0
148	2017-12-26 00:00:00+01	0.25
149	2018-01-02 00:00:00+01	0.5
150	2018-01-09 00:00:00+01	0.75
151	2018-01-17 00:00:00+01	0
152	2018-01-24 00:00:00+01	0.25
\.


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 212
-- Name: lune_lune_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('lune_lune_id_seq', 152, true);


--
-- TOC entry 3634 (class 0 OID 44842)
-- Dependencies: 213
-- Data for Name: maree; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY maree (mar_id, mar_date_time_p1, mar_date_time_p2, mar_coef, mar_marnage, mar_tymar_id) FROM stdin;
5026	2015-08-31 22:56:00+02	2015-09-01 02:56:00+02	113	0.52000000000000002	2
3	2015-09-01 05:07:00+02	2015-09-01 09:07:00+02	113	6.3099999999999996	1
5027	2015-09-01 02:56:00+02	2015-09-01 05:07:00+02	113	0	3
4	2015-09-01 09:07:00+02	2015-09-01 11:16:00+02	113	0	4
5	2015-09-01 11:16:00+02	2015-09-01 15:16:00+02	111	0.59999999999999998	2
6	2015-09-01 17:25:00+02	2015-09-01 21:25:00+02	111	6.4199999999999999	1
7	2015-09-01 15:16:00+02	2015-09-01 17:25:00+02	111	0	3
8	2015-09-01 23:41:00+02	2015-09-02 03:41:00+02	107	0.66000000000000003	2
9	2015-09-02 03:41:00+02	2015-09-02 05:45:00+02	107	0	3
10	2015-09-02 05:45:00+02	2015-09-02 09:45:00+02	107	6.1100000000000003	1
11	2015-09-02 09:45:00+02	2015-09-02 12:03:00+02	107	0	4
12	2015-09-02 12:03:00+02	2015-09-02 16:03:00+02	102	0.79000000000000004	2
13	2015-09-02 18:06:00+02	2015-09-02 22:06:00+02	102	6.1299999999999999	1
14	2015-09-02 16:03:00+02	2015-09-02 18:06:00+02	102	0	3
15	2015-09-01 21:25:00+02	2015-09-01 23:41:00+02	102	0	4
16	2015-09-03 00:28:00+02	2015-09-03 04:28:00+02	95	0.96999999999999997	2
17	2015-09-03 04:28:00+02	2015-09-03 06:24:00+02	95	0	3
18	2015-09-03 06:24:00+02	2015-09-03 10:24:00+02	95	5.8200000000000003	1
19	2015-09-03 10:24:00+02	2015-09-03 12:51:00+02	95	0	4
20	2015-09-03 12:51:00+02	2015-09-03 16:51:00+02	88	1.1200000000000001	2
21	2015-09-03 18:52:00+02	2015-09-03 22:52:00+02	88	5.7400000000000002	1
22	2015-09-03 16:51:00+02	2015-09-03 18:52:00+02	88	0	3
23	2015-09-02 22:06:00+02	2015-09-03 00:28:00+02	88	0	4
24	2015-09-04 01:17:00+02	2015-09-04 05:17:00+02	81	1.3899999999999999	2
25	2015-09-04 05:17:00+02	2015-09-04 07:12:00+02	81	0	3
26	2015-09-04 07:12:00+02	2015-09-04 11:12:00+02	81	5.4699999999999998	1
27	2015-09-04 11:12:00+02	2015-09-04 13:41:00+02	81	0	4
28	2015-09-04 13:41:00+02	2015-09-04 17:41:00+02	73	1.55	2
29	2015-09-04 20:19:00+02	2015-09-05 00:19:00+02	73	5.3300000000000001	1
30	2015-09-04 17:41:00+02	2015-09-04 20:19:00+02	73	0	3
31	2015-09-03 22:52:00+02	2015-09-04 01:17:00+02	73	0	4
32	2015-09-05 02:09:00+02	2015-09-05 06:09:00+02	65	1.8600000000000001	2
33	2015-09-05 06:09:00+02	2015-09-05 09:08:00+02	65	0	3
34	2015-09-05 09:08:00+02	2015-09-05 13:08:00+02	58	5.1500000000000004	1
35	2015-09-05 13:08:00+02	2015-09-05 14:38:00+02	58	0	4
36	2015-09-05 14:38:00+02	2015-09-05 18:38:00+02	58	1.99	2
37	2015-09-05 00:19:00+02	2015-09-05 02:09:00+02	58	0	3
38	2015-09-05 22:05:00+02	2015-09-06 02:05:00+02	53	5.0599999999999996	1
39	2015-09-06 02:05:00+02	2015-09-06 03:08:00+02	53	0	4
40	2015-09-06 03:08:00+02	2015-09-06 07:08:00+02	53	2.2799999999999998	2
41	2015-09-06 07:08:00+02	2015-09-06 10:41:00+02	53	0	3
42	2015-09-06 10:41:00+02	2015-09-06 14:41:00+02	49	5.0199999999999996	1
43	2015-09-06 14:41:00+02	2015-09-06 15:44:00+02	49	0	4
44	2015-09-06 15:44:00+02	2015-09-06 19:44:00+02	49	2.3399999999999999	2
45	2015-09-05 18:38:00+02	2015-09-05 22:05:00+02	49	0	3
46	2015-09-07 04:18:00+02	2015-09-07 08:18:00+02	47	2.5499999999999998	2
47	2015-09-07 08:18:00+02	2015-09-06 23:26:00+02	47	0	3
48	2015-09-06 23:26:00+02	2015-09-07 03:26:00+02	47	4.9900000000000002	1
49	2015-09-07 03:26:00+02	2015-09-07 16:59:00+02	47	0	4
50	2015-09-07 16:59:00+02	2015-09-07 20:59:00+02	47	2.48	2
51	2015-09-07 11:55:00+02	2015-09-07 15:55:00+02	47	5.0800000000000001	1
52	2015-09-07 20:59:00+02	2015-09-07 11:55:00+02	47	0	3
53	2015-09-06 19:44:00+02	2015-09-07 04:18:00+02	47	0	4
54	2015-09-08 05:34:00+02	2015-09-08 09:34:00+02	47	2.5699999999999998	2
55	2015-09-08 09:34:00+02	2015-09-08 00:35:00+02	47	0	3
56	2015-09-08 00:35:00+02	2015-09-08 04:35:00+02	47	5.0700000000000003	1
57	2015-09-08 04:35:00+02	2015-09-08 18:15:00+02	47	0	4
58	2015-09-08 18:15:00+02	2015-09-08 22:15:00+02	49	2.3799999999999999	2
59	2015-09-08 12:58:00+02	2015-09-08 16:58:00+02	49	5.2400000000000002	1
60	2015-09-08 22:15:00+02	2015-09-08 12:58:00+02	49	0	3
61	2015-09-07 15:55:00+02	2015-09-08 05:34:00+02	49	0	4
62	2015-09-09 06:43:00+02	2015-09-09 10:43:00+02	53	2.3799999999999999	2
63	2015-09-09 10:43:00+02	2015-09-09 01:31:00+02	53	0	3
64	2015-09-09 01:31:00+02	2015-09-09 05:31:00+02	53	5.2199999999999998	1
65	2015-09-09 05:31:00+02	2015-09-09 19:17:00+02	53	0	4
66	2015-09-09 19:17:00+02	2015-09-09 23:17:00+02	57	2.1200000000000001	2
67	2015-09-09 13:49:00+02	2015-09-09 17:49:00+02	57	5.4299999999999997	1
68	2015-09-09 23:17:00+02	2015-09-09 13:49:00+02	57	0	3
69	2015-09-08 16:58:00+02	2015-09-09 06:43:00+02	57	0	4
70	2015-09-10 07:38:00+02	2015-09-10 11:38:00+02	62	2.0899999999999999	2
71	2015-09-10 11:38:00+02	2015-09-10 02:16:00+02	62	0	3
72	2015-09-10 02:16:00+02	2015-09-10 06:16:00+02	62	5.3799999999999999	1
73	2015-09-10 06:16:00+02	2015-09-10 20:07:00+02	62	0	4
74	2015-09-10 20:07:00+02	2015-09-11 00:07:00+02	67	1.8400000000000001	2
75	2015-09-10 14:28:00+02	2015-09-10 18:28:00+02	67	5.6200000000000001	1
76	2015-09-11 00:07:00+02	2015-09-10 14:28:00+02	67	0	3
77	2015-09-09 17:49:00+02	2015-09-10 07:38:00+02	67	0	4
78	2015-09-11 08:24:00+02	2015-09-11 12:24:00+02	72	1.8	2
79	2015-09-11 12:24:00+02	2015-09-11 02:50:00+02	72	0	3
80	2015-09-11 02:50:00+02	2015-09-11 06:50:00+02	72	5.5300000000000002	1
81	2015-09-11 06:50:00+02	2015-09-11 20:49:00+02	72	0	4
82	2015-09-11 20:49:00+02	2015-09-12 00:49:00+02	76	1.6000000000000001	2
83	2015-09-11 14:58:00+02	2015-09-11 18:58:00+02	76	5.7699999999999996	1
84	2015-09-12 00:49:00+02	2015-09-11 14:58:00+02	76	0	3
85	2015-09-10 18:28:00+02	2015-09-11 08:24:00+02	76	0	4
86	2015-09-12 09:06:00+02	2015-09-12 13:06:00+02	80	1.5600000000000001	2
87	2015-09-12 13:06:00+02	2015-09-12 03:13:00+02	80	0	3
88	2015-09-12 03:13:00+02	2015-09-12 07:13:00+02	80	5.6699999999999999	1
89	2015-09-12 07:13:00+02	2015-09-12 21:27:00+02	80	0	4
90	2015-09-12 21:27:00+02	2015-09-13 01:27:00+02	83	1.4299999999999999	2
91	2015-09-12 15:20:00+02	2015-09-12 19:20:00+02	83	5.8899999999999997	1
92	2015-09-13 01:27:00+02	2015-09-12 15:20:00+02	83	0	3
93	2015-09-11 18:58:00+02	2015-09-12 09:06:00+02	83	0	4
94	2015-09-13 09:43:00+02	2015-09-13 13:43:00+02	88	1.4199999999999999	2
95	2015-09-13 13:43:00+02	2015-09-13 03:32:00+02	88	0	3
96	2015-09-13 03:32:00+02	2015-09-13 07:32:00+02	86	5.79	1
97	2015-09-13 07:32:00+02	2015-09-12 22:00:00+02	86	0	4
98	2015-09-12 22:00:00+02	2015-09-13 02:00:00+02	86	0	2
99	2015-09-13 15:40:00+02	2015-09-13 19:40:00+02	88	5.9699999999999998	1
100	2015-09-13 02:00:00+02	2015-09-13 15:40:00+02	86	0	3
101	2015-09-12 19:20:00+02	2015-09-13 09:43:00+02	88	0	4
102	2015-09-13 22:03:00+02	2015-09-14 02:03:00+02	89	1.3600000000000001	2
103	2015-09-14 02:03:00+02	2015-09-14 03:52:00+02	89	0	3
104	2015-09-14 03:52:00+02	2015-09-14 07:52:00+02	89	5.8799999999999999	1
105	2015-09-14 07:52:00+02	2015-09-14 10:18:00+02	89	0	4
106	2015-09-14 10:18:00+02	2015-09-14 14:18:00+02	89	1.3799999999999999	2
107	2015-09-14 16:04:00+02	2015-09-14 20:04:00+02	89	6.0099999999999998	1
108	2015-09-14 14:18:00+02	2015-09-14 16:04:00+02	89	0	3
109	2015-09-13 19:40:00+02	2015-09-13 22:03:00+02	89	0	4
110	2015-09-14 22:37:00+02	2015-09-15 02:37:00+02	89	1.3799999999999999	2
111	2015-09-15 02:37:00+02	2015-09-15 04:17:00+02	89	0	3
112	2015-09-15 04:17:00+02	2015-09-15 08:17:00+02	89	5.9100000000000001	1
113	2015-09-15 08:17:00+02	2015-09-15 10:51:00+02	89	0	4
114	2015-09-15 10:51:00+02	2015-09-15 14:51:00+02	88	1.4399999999999999	2
115	2015-09-15 16:29:00+02	2015-09-15 20:29:00+02	88	5.9699999999999998	1
116	2015-09-15 14:51:00+02	2015-09-15 16:29:00+02	88	0	3
117	2015-09-14 20:04:00+02	2015-09-14 22:37:00+02	88	0	4
118	2015-09-15 23:08:00+02	2015-09-16 03:08:00+02	86	1.49	2
119	2015-09-16 03:08:00+02	2015-09-16 04:43:00+02	86	0	3
120	2015-09-16 04:43:00+02	2015-09-16 08:43:00+02	86	5.8600000000000003	1
121	2015-09-16 08:43:00+02	2015-09-16 11:23:00+02	86	0	4
122	2015-09-16 11:23:00+02	2015-09-16 15:23:00+02	84	1.5700000000000001	2
123	2015-09-16 16:56:00+02	2015-09-16 20:56:00+02	84	5.8600000000000003	1
124	2015-09-16 15:23:00+02	2015-09-16 16:56:00+02	84	0	3
125	2015-09-15 20:29:00+02	2015-09-15 23:08:00+02	84	0	4
126	2015-09-16 23:39:00+02	2015-09-17 03:39:00+02	81	1.6499999999999999	2
127	2015-09-17 03:39:00+02	2015-09-17 05:10:00+02	81	0	3
128	2015-09-17 05:10:00+02	2015-09-17 09:10:00+02	81	5.75	1
129	2015-09-17 09:10:00+02	2015-09-17 11:55:00+02	81	0	4
130	2015-09-17 11:55:00+02	2015-09-17 15:55:00+02	78	1.75	2
131	2015-09-17 17:24:00+02	2015-09-17 21:24:00+02	78	5.6900000000000004	1
132	2015-09-17 15:55:00+02	2015-09-17 17:24:00+02	78	0	3
133	2015-09-16 20:56:00+02	2015-09-16 23:39:00+02	78	0	4
134	2015-09-18 00:11:00+02	2015-09-18 04:11:00+02	74	1.8600000000000001	2
135	2015-09-18 04:11:00+02	2015-09-18 05:38:00+02	74	0	3
136	2015-09-18 05:38:00+02	2015-09-18 09:38:00+02	74	5.5800000000000001	1
137	2015-09-18 09:38:00+02	2015-09-18 12:28:00+02	74	0	4
138	2015-09-18 12:28:00+02	2015-09-18 16:28:00+02	70	1.97	2
139	2015-09-18 17:52:00+02	2015-09-18 21:52:00+02	70	5.4699999999999998	1
140	2015-09-18 16:28:00+02	2015-09-18 17:52:00+02	70	0	3
141	2015-09-17 21:24:00+02	2015-09-18 00:11:00+02	70	0	4
142	2015-09-19 00:46:00+02	2015-09-19 04:46:00+02	66	2.0899999999999999	2
143	2015-09-19 04:46:00+02	2015-09-19 06:07:00+02	66	0	3
144	2015-09-19 06:07:00+02	2015-09-19 10:07:00+02	66	5.3700000000000001	1
145	2015-09-19 10:07:00+02	2015-09-19 13:06:00+02	66	0	4
146	2015-09-19 13:06:00+02	2015-09-19 17:06:00+02	61	2.1899999999999999	2
147	2015-09-19 18:25:00+02	2015-09-19 22:25:00+02	61	5.2300000000000004	1
148	2015-09-19 17:06:00+02	2015-09-19 18:25:00+02	61	0	3
149	2015-09-18 21:52:00+02	2015-09-19 00:46:00+02	61	0	4
150	2015-09-20 01:26:00+02	2015-09-20 05:26:00+02	57	2.3300000000000001	2
151	2015-09-20 05:26:00+02	2015-09-20 06:43:00+02	57	0	3
152	2015-09-20 06:43:00+02	2015-09-20 10:43:00+02	57	5.1399999999999997	1
153	2015-09-20 10:43:00+02	2015-09-20 13:51:00+02	57	0	4
154	2015-09-20 13:51:00+02	2015-09-20 17:51:00+02	52	2.4100000000000001	2
155	2015-09-20 19:08:00+02	2015-09-20 23:08:00+02	52	4.96	1
156	2015-09-20 17:51:00+02	2015-09-20 19:08:00+02	52	0	3
157	2015-09-19 22:25:00+02	2015-09-20 01:26:00+02	52	0	4
158	2015-09-21 02:15:00+02	2015-09-21 06:15:00+02	48	2.5499999999999998	2
159	2015-09-21 06:15:00+02	2015-09-21 07:37:00+02	48	0	3
160	2015-09-21 07:37:00+02	2015-09-21 11:37:00+02	48	4.9100000000000001	1
161	2015-09-21 11:37:00+02	2015-09-21 14:47:00+02	48	0	4
162	2015-09-21 14:47:00+02	2015-09-21 18:47:00+02	45	2.5800000000000001	2
163	2015-09-21 20:46:00+02	2015-09-22 00:46:00+02	45	4.7300000000000004	1
164	2015-09-21 18:47:00+02	2015-09-21 20:46:00+02	45	0	3
165	2015-09-20 23:08:00+02	2015-09-21 02:15:00+02	45	0	4
166	2015-09-22 03:17:00+02	2015-09-22 07:17:00+02	44	2.71	2
167	2015-09-22 07:17:00+02	2015-09-22 10:16:00+02	44	0	3
168	2015-09-22 10:16:00+02	2015-09-22 14:16:00+02	44	4.8099999999999996	1
169	2015-09-22 14:16:00+02	2015-09-22 15:55:00+02	44	0	4
170	2015-09-22 15:55:00+02	2015-09-22 19:55:00+02	44	2.6400000000000001	2
171	2015-09-22 00:46:00+02	2015-09-22 03:17:00+02	44	0	3
172	2015-09-22 23:17:00+02	2015-09-23 03:17:00+02	47	4.8399999999999999	1
173	2015-09-23 03:17:00+02	2015-09-23 04:30:00+02	47	0	4
174	2015-09-23 04:30:00+02	2015-09-23 08:30:00+02	47	2.6899999999999999	2
175	2015-09-23 08:30:00+02	2015-09-23 11:45:00+02	47	0	3
176	2015-09-23 11:45:00+02	2015-09-23 15:45:00+02	47	5.0599999999999996	1
177	2015-09-23 15:45:00+02	2015-09-23 17:13:00+02	47	0	4
178	2015-09-23 17:13:00+02	2015-09-23 21:13:00+02	47	2.48	2
179	2015-09-22 19:55:00+02	2015-09-22 23:17:00+02	47	0	3
180	2015-09-24 05:47:00+02	2015-09-24 09:47:00+02	52	2.4300000000000002	2
181	2015-09-24 09:47:00+02	2015-09-24 00:24:00+02	52	0	3
182	2015-09-24 00:24:00+02	2015-09-24 04:24:00+02	52	5.1500000000000004	1
183	2015-09-24 04:24:00+02	2015-09-24 18:25:00+02	52	0	4
184	2015-09-24 18:25:00+02	2015-09-24 22:25:00+02	59	2.0899999999999999	2
185	2015-09-24 12:46:00+02	2015-09-24 16:46:00+02	59	5.4500000000000002	1
186	2015-09-24 22:25:00+02	2015-09-24 12:46:00+02	59	0	3
187	2015-09-23 21:13:00+02	2015-09-24 05:47:00+02	59	0	4
188	2015-09-25 06:53:00+02	2015-09-25 10:53:00+02	67	1.99	2
189	2015-09-25 10:53:00+02	2015-09-25 01:19:00+02	67	0	3
190	2015-09-25 01:19:00+02	2015-09-25 05:19:00+02	67	5.54	1
191	2015-09-25 05:19:00+02	2015-09-25 19:25:00+02	67	0	4
192	2015-09-25 19:25:00+02	2015-09-25 23:25:00+02	76	1.5900000000000001	2
193	2015-09-25 13:37:00+02	2015-09-25 17:37:00+02	76	5.8600000000000003	1
194	2015-09-25 23:25:00+02	2015-09-25 13:37:00+02	76	0	3
195	2015-09-24 16:46:00+02	2015-09-25 06:53:00+02	76	0	4
196	2015-09-26 07:49:00+02	2015-09-26 11:49:00+02	84	1.48	2
197	2015-09-26 11:49:00+02	2015-09-26 02:07:00+02	84	0	3
198	2015-09-26 02:07:00+02	2015-09-26 06:07:00+02	84	5.9199999999999999	1
199	2015-09-26 06:07:00+02	2015-09-26 20:17:00+02	84	0	4
200	2015-09-26 20:17:00+02	2015-09-27 00:17:00+02	92	1.1100000000000001	2
201	2015-09-26 14:23:00+02	2015-09-26 18:23:00+02	92	6.2400000000000002	1
202	2015-09-27 00:17:00+02	2015-09-26 14:23:00+02	92	0	3
203	2015-09-25 17:37:00+02	2015-09-26 07:49:00+02	92	0	4
204	2015-09-27 08:38:00+02	2015-09-27 12:38:00+02	99	1.01	2
205	2015-09-27 12:38:00+02	2015-09-27 02:50:00+02	99	0	3
206	2015-09-27 02:50:00+02	2015-09-27 06:50:00+02	99	6.2400000000000002	1
207	2015-09-27 06:50:00+02	2015-09-27 21:05:00+02	99	0	4
208	2015-09-27 21:05:00+02	2015-09-28 01:05:00+02	106	0.73999999999999999	2
209	2015-09-27 15:07:00+02	2015-09-27 19:07:00+02	106	6.5199999999999996	1
210	2015-09-28 01:05:00+02	2015-09-27 15:07:00+02	106	0	3
211	2015-09-26 18:23:00+02	2015-09-27 08:38:00+02	106	0	4
212	2015-09-28 09:25:00+02	2015-09-28 13:25:00+02	111	0.67000000000000004	2
213	2015-09-28 13:25:00+02	2015-09-28 03:30:00+02	111	0	3
214	2015-09-28 03:30:00+02	2015-09-28 07:30:00+02	111	6.4400000000000004	1
215	2015-09-28 07:30:00+02	2015-09-28 21:51:00+02	111	0	4
216	2015-09-28 21:51:00+02	2015-09-29 01:51:00+02	114	0.52000000000000002	2
217	2015-09-28 15:47:00+02	2015-09-28 19:47:00+02	114	6.6500000000000004	1
218	2015-09-29 01:51:00+02	2015-09-28 15:47:00+02	114	0	3
219	2015-09-27 19:07:00+02	2015-09-28 09:25:00+02	114	0	4
220	2015-09-29 10:11:00+02	2015-09-29 14:11:00+02	117	0.5	2
221	2015-09-29 14:11:00+02	2015-09-29 04:08:00+02	117	0	3
222	2015-09-29 04:08:00+02	2015-09-29 08:08:00+02	116	6.5099999999999998	1
223	2015-09-29 08:08:00+02	2015-09-28 22:00:00+02	116	0	4
224	2015-09-28 22:00:00+02	2015-09-29 02:00:00+02	116	0	2
225	2015-09-29 16:26:00+02	2015-09-29 20:26:00+02	117	6.6200000000000001	1
226	2015-09-29 02:00:00+02	2015-09-29 16:26:00+02	116	0	3
227	2015-09-28 19:47:00+02	2015-09-29 10:11:00+02	117	0	4
228	2015-09-29 22:36:00+02	2015-09-30 02:36:00+02	115	0.5	2
229	2015-09-30 02:36:00+02	2015-09-30 04:44:00+02	115	0	3
230	2015-09-30 04:44:00+02	2015-09-30 08:44:00+02	115	6.4299999999999997	1
231	2015-09-30 08:44:00+02	2015-09-30 10:56:00+02	115	0	4
232	2015-09-30 10:56:00+02	2015-09-30 14:56:00+02	113	0.52000000000000002	2
233	2015-09-30 17:04:00+02	2015-09-30 21:04:00+02	113	6.4299999999999997	1
234	2015-09-30 14:56:00+02	2015-09-30 17:04:00+02	113	0	3
235	2015-09-29 20:26:00+02	2015-09-29 22:36:00+02	113	0	4
236	2015-09-30 23:21:00+02	2015-10-01 03:21:00+02	108	0.67000000000000004	2
237	2015-10-01 03:21:00+02	2015-10-01 05:19:00+02	108	0	3
238	2015-10-01 05:19:00+02	2015-10-01 09:19:00+02	108	6.2199999999999998	1
239	2015-10-01 09:19:00+02	2015-10-01 11:42:00+02	108	0	4
240	2015-10-01 11:42:00+02	2015-10-01 15:42:00+02	103	0.72999999999999998	2
241	2015-10-01 17:40:00+02	2015-10-01 21:40:00+02	103	6.1200000000000001	1
242	2015-10-01 15:42:00+02	2015-10-01 17:40:00+02	103	0	3
243	2015-09-30 21:04:00+02	2015-09-30 23:21:00+02	103	0	4
244	2015-10-02 00:07:00+02	2015-10-02 04:07:00+02	96	1	2
245	2015-10-02 04:07:00+02	2015-10-02 05:52:00+02	96	0	3
246	2015-10-02 05:52:00+02	2015-10-02 09:52:00+02	96	5.9199999999999999	1
247	2015-10-02 09:52:00+02	2015-10-02 12:30:00+02	96	0	4
248	2015-10-02 12:30:00+02	2015-10-02 16:30:00+02	89	1.1000000000000001	2
249	2015-10-02 18:18:00+02	2015-10-02 22:18:00+02	89	5.71	1
250	2015-10-02 16:30:00+02	2015-10-02 18:18:00+02	89	0	3
251	2015-10-01 21:40:00+02	2015-10-02 00:07:00+02	89	0	4
252	2015-10-03 00:53:00+02	2015-10-03 04:53:00+02	81	1.4399999999999999	2
253	2015-10-03 04:53:00+02	2015-10-03 06:28:00+02	81	0	3
254	2015-10-03 06:28:00+02	2015-10-03 10:28:00+02	81	5.5599999999999996	1
255	2015-10-03 10:28:00+02	2015-10-03 13:20:00+02	81	0	4
256	2015-10-03 13:20:00+02	2015-10-03 17:20:00+02	73	1.55	2
257	2015-10-03 19:09:00+02	2015-10-03 23:09:00+02	73	5.2699999999999996	1
258	2015-10-03 17:20:00+02	2015-10-03 19:09:00+02	73	0	3
259	2015-10-02 22:18:00+02	2015-10-03 00:53:00+02	73	0	4
260	2015-10-04 01:45:00+02	2015-10-04 05:45:00+02	65	1.9199999999999999	2
261	2015-10-04 05:45:00+02	2015-10-04 07:25:00+02	65	0	3
262	2015-10-04 07:25:00+02	2015-10-04 11:25:00+02	65	5.1799999999999997	1
263	2015-10-04 11:25:00+02	2015-10-04 14:15:00+02	65	0	4
264	2015-10-04 14:15:00+02	2015-10-04 18:15:00+02	57	2.02	2
265	2015-10-04 21:38:00+02	2015-10-05 01:38:00+02	57	4.9500000000000002	1
266	2015-10-04 18:15:00+02	2015-10-04 21:38:00+02	57	0	3
267	2015-10-03 23:09:00+02	2015-10-04 01:45:00+02	57	0	4
268	2015-10-05 02:42:00+02	2015-10-05 06:42:00+02	51	2.3599999999999999	2
269	2015-10-05 06:42:00+02	2015-10-05 10:11:00+02	51	0	3
270	2015-10-05 10:11:00+02	2015-10-05 14:11:00+02	46	4.9900000000000002	1
271	2015-10-05 14:11:00+02	2015-10-05 15:18:00+02	46	0	4
272	2015-10-05 15:18:00+02	2015-10-05 19:18:00+02	46	2.3999999999999999	2
273	2015-10-05 01:38:00+02	2015-10-05 02:42:00+02	46	0	3
274	2015-10-05 23:02:00+02	2015-10-06 03:02:00+02	44	4.8700000000000001	1
275	2015-10-06 03:02:00+02	2015-10-06 03:49:00+02	44	0	4
276	2015-10-06 03:49:00+02	2015-10-06 07:49:00+02	44	2.6600000000000001	2
277	2015-10-06 07:49:00+02	2015-10-06 11:28:00+02	44	0	3
278	2015-10-06 11:28:00+02	2015-10-06 15:28:00+02	44	5.0099999999999998	1
279	2015-10-06 15:28:00+02	2015-10-06 16:32:00+02	44	0	4
280	2015-10-06 16:32:00+02	2015-10-06 20:32:00+02	44	2.5899999999999999	2
281	2015-10-05 19:18:00+02	2015-10-05 23:02:00+02	44	0	3
282	2015-10-07 05:05:00+02	2015-10-07 09:05:00+02	43	2.7200000000000002	2
283	2015-10-07 09:05:00+02	2015-10-07 00:09:00+02	43	0	3
284	2015-10-07 00:09:00+02	2015-10-07 04:09:00+02	43	4.9500000000000002	1
285	2015-10-07 04:09:00+02	2015-10-07 17:48:00+02	43	0	4
286	2015-10-07 17:48:00+02	2015-10-07 21:48:00+02	45	2.52	2
287	2015-10-07 12:30:00+02	2015-10-07 16:30:00+02	45	5.1500000000000004	1
288	2015-10-07 21:48:00+02	2015-10-07 12:30:00+02	45	0	3
289	2015-10-06 20:32:00+02	2015-10-07 05:05:00+02	45	0	4
290	2015-10-08 06:17:00+02	2015-10-08 10:17:00+02	49	2.5499999999999998	2
291	2015-10-08 10:17:00+02	2015-10-08 01:03:00+02	49	0	3
292	2015-10-08 01:03:00+02	2015-10-08 05:03:00+02	49	5.1100000000000003	1
293	2015-10-08 05:03:00+02	2015-10-08 18:52:00+02	49	0	4
294	2015-10-08 18:52:00+02	2015-10-08 22:52:00+02	53	2.29	2
295	2015-10-08 13:19:00+02	2015-10-08 17:19:00+02	53	5.3300000000000001	1
1183	2016-01-29 09:13:00+01	2016-01-29 12:07:00+01	75	0	4
1184	2016-01-29 12:07:00+01	2016-01-29 16:07:00+01	70	1.8899999999999999	2
1185	2016-01-29 17:33:00+01	2016-01-29 21:33:00+01	70	5.3600000000000003	1
1186	2016-01-29 16:07:00+01	2016-01-29 17:33:00+01	70	0	3
1187	2016-01-28 20:57:00+01	2016-01-28 23:44:00+01	70	0	4
1188	2016-01-30 00:22:00+01	2016-01-30 04:22:00+01	65	2.0800000000000001	2
1189	2016-01-30 04:22:00+01	2016-01-30 05:52:00+01	65	0	3
1190	2016-01-30 05:52:00+01	2016-01-30 09:52:00+01	65	5.3799999999999999	1
1191	2016-01-30 09:52:00+01	2016-01-30 12:44:00+01	65	0	4
1192	2016-01-30 12:44:00+01	2016-01-30 16:44:00+01	60	2.21	2
1193	2016-01-30 18:15:00+01	2016-01-30 22:15:00+01	60	5.1399999999999997	1
1194	2016-01-30 16:44:00+01	2016-01-30 18:15:00+01	60	0	3
1195	2016-01-29 21:33:00+01	2016-01-30 00:22:00+01	60	0	4
1196	2016-01-31 01:02:00+01	2016-01-31 05:02:00+01	55	2.3999999999999999	2
1197	2016-01-31 05:02:00+01	2016-01-31 06:38:00+01	55	0	3
2359	2016-06-25 22:33:00+02	2016-06-26 01:24:00+02	69	0	4
2360	2016-06-27 02:16:00+02	2016-06-27 06:16:00+02	66	1.8	2
2361	2016-06-27 06:16:00+02	2016-06-27 08:52:00+02	66	0	3
2362	2016-06-27 08:52:00+02	2016-06-27 12:52:00+02	66	5.0599999999999996	1
2363	2016-06-27 12:52:00+02	2016-06-27 14:39:00+02	66	0	4
2364	2016-06-27 14:39:00+02	2016-06-27 18:39:00+02	64	1.99	2
2365	2016-06-27 21:24:00+02	2016-06-28 01:24:00+02	64	5.2400000000000002	1
2366	2016-06-27 18:39:00+02	2016-06-27 21:24:00+02	64	0	3
2367	2016-06-26 23:34:00+02	2016-06-27 02:16:00+02	64	0	4
2368	2016-06-28 03:14:00+02	2016-06-28 07:14:00+02	62	1.9399999999999999	2
2369	2016-06-28 07:14:00+02	2016-06-28 10:22:00+02	62	0	3
2370	2016-06-28 10:22:00+02	2016-06-28 14:22:00+02	62	5.0800000000000001	1
2371	2016-06-28 14:22:00+02	2016-06-28 15:42:00+02	62	0	4
2372	2016-06-28 15:42:00+02	2016-06-28 19:42:00+02	62	2.0800000000000001	2
2373	2016-06-28 01:24:00+02	2016-06-28 03:14:00+02	62	0	3
2374	2016-06-28 22:51:00+02	2016-06-29 02:51:00+02	62	5.2800000000000002	1
2375	2016-06-29 02:51:00+02	2016-06-29 04:19:00+02	62	0	4
2376	2016-06-29 04:19:00+02	2016-06-29 08:19:00+02	62	2.0099999999999998	2
2377	2016-06-29 08:19:00+02	2016-06-29 11:32:00+02	62	0	3
2378	2016-06-29 11:32:00+02	2016-06-29 15:32:00+02	62	5.21	1
3245	2016-10-17 16:19:00+02	2016-10-17 20:19:00+02	115	6.5800000000000001	1
3246	2016-10-17 02:00:00+02	2016-10-17 16:19:00+02	114	0	3
3247	2016-10-16 19:40:00+02	2016-10-17 10:09:00+02	115	0	4
3248	2016-10-17 22:32:00+02	2016-10-18 02:32:00+02	114	0.58999999999999997	2
3249	2016-10-18 02:32:00+02	2016-10-18 04:37:00+02	114	0	3
3250	2016-10-18 04:37:00+02	2016-10-18 08:37:00+02	114	6.4500000000000002	1
3251	2016-10-18 08:37:00+02	2016-10-18 10:54:00+02	114	0	4
3252	2016-10-18 10:54:00+02	2016-10-18 14:54:00+02	112	0.56999999999999995	2
3253	2016-10-18 16:57:00+02	2016-10-18 20:57:00+02	112	6.4000000000000004	1
3254	2016-10-18 14:54:00+02	2016-10-18 16:57:00+02	112	0	3
3255	2016-10-17 20:19:00+02	2016-10-17 22:32:00+02	112	0	4
3256	2016-10-18 23:18:00+02	2016-10-19 03:18:00+02	108	0.72999999999999998	2
3257	2016-10-19 03:18:00+02	2016-10-19 05:12:00+02	108	0	3
3258	2016-10-19 05:12:00+02	2016-10-19 09:12:00+02	108	6.2599999999999998	1
3259	2016-10-19 09:12:00+02	2016-10-19 11:41:00+02	108	0	4
3260	2016-10-19 11:41:00+02	2016-10-19 15:41:00+02	102	0.76000000000000001	2
3261	2016-10-19 17:37:00+02	2016-10-19 21:37:00+02	102	6.0800000000000001	1
3262	2016-10-19 15:41:00+02	2016-10-19 17:37:00+02	102	0	3
3263	2016-10-18 20:57:00+02	2016-10-18 23:18:00+02	102	0	4
3264	2016-10-20 00:05:00+02	2016-10-20 04:05:00+02	96	1.03	2
3265	2016-10-20 04:05:00+02	2016-10-20 05:50:00+02	96	0	3
3266	2016-10-20 05:50:00+02	2016-10-20 09:50:00+02	96	5.96	1
3267	2016-10-20 09:50:00+02	2016-10-20 12:30:00+02	96	0	4
3268	2016-10-20 12:30:00+02	2016-10-20 16:30:00+02	89	1.0900000000000001	2
3269	2016-10-20 18:22:00+02	2016-10-20 22:22:00+02	89	5.6799999999999997	1
3270	2016-10-20 16:30:00+02	2016-10-20 18:22:00+02	89	0	3
3271	2016-10-19 21:37:00+02	2016-10-20 00:05:00+02	89	0	4
3272	2016-10-21 00:53:00+02	2016-10-21 04:53:00+02	81	1.45	2
3273	2016-10-21 04:53:00+02	2016-10-21 06:35:00+02	81	0	3
3274	2016-10-21 06:35:00+02	2016-10-21 10:35:00+02	81	5.5899999999999999	1
3275	2016-10-21 10:35:00+02	2016-10-21 13:22:00+02	81	0	4
3276	2016-10-21 13:22:00+02	2016-10-21 17:22:00+02	73	1.52	2
3277	2016-10-21 20:11:00+02	2016-10-22 00:11:00+02	73	5.2599999999999998	1
3278	2016-10-21 17:22:00+02	2016-10-21 20:11:00+02	73	0	3
3279	2016-10-20 22:22:00+02	2016-10-21 00:53:00+02	73	0	4
3280	2016-10-22 01:47:00+02	2016-10-22 05:47:00+02	65	1.8999999999999999	2
3281	2016-10-22 05:47:00+02	2016-10-22 08:51:00+02	65	0	3
3282	2016-10-22 08:51:00+02	2016-10-22 12:51:00+02	65	5.25	1
3283	2016-10-22 12:51:00+02	2016-10-22 14:19:00+02	65	0	4
3284	2016-10-22 14:19:00+02	2016-10-22 18:19:00+02	59	1.95	2
3285	2016-10-22 21:55:00+02	2016-10-23 01:55:00+02	59	5.0499999999999998	1
3286	2016-10-22 18:19:00+02	2016-10-22 21:55:00+02	59	0	3
3287	2016-10-22 00:11:00+02	2016-10-22 01:47:00+02	59	0	4
3288	2016-10-23 02:46:00+02	2016-10-23 06:46:00+02	53	2.3100000000000001	2
3289	2016-10-23 06:46:00+02	2016-10-23 10:25:00+02	53	0	3
3290	2016-10-23 10:25:00+02	2016-10-23 14:25:00+02	50	5.1500000000000004	1
3291	2016-10-23 14:25:00+02	2016-10-23 15:24:00+02	50	0	4
3292	2016-10-23 15:24:00+02	2016-10-23 19:24:00+02	50	2.29	2
3293	2016-10-23 01:55:00+02	2016-10-23 02:46:00+02	50	0	3
3294	2016-10-23 23:12:00+02	2016-10-24 03:12:00+02	48	5.04	1
3295	2016-10-24 03:12:00+02	2016-10-24 03:55:00+02	48	0	4
3296	2016-10-24 03:55:00+02	2016-10-24 07:55:00+02	48	2.5600000000000001	2
3297	2016-10-24 07:55:00+02	2016-10-24 11:37:00+02	48	0	3
3298	2016-10-24 11:37:00+02	2016-10-24 15:37:00+02	48	5.21	1
3299	2016-10-24 15:37:00+02	2016-10-24 16:38:00+02	48	0	4
3300	2016-10-24 16:38:00+02	2016-10-24 20:38:00+02	48	2.4300000000000002	2
3301	2016-10-23 19:24:00+02	2016-10-23 23:12:00+02	48	0	3
3302	2016-10-25 05:11:00+02	2016-10-25 09:11:00+02	49	2.5699999999999998	2
3303	2016-10-25 09:11:00+02	2016-10-25 00:17:00+02	49	0	3
3304	2016-10-25 00:17:00+02	2016-10-25 04:17:00+02	49	5.1600000000000001	1
3305	2016-10-25 04:17:00+02	2016-10-25 17:52:00+02	49	0	4
3306	2016-10-25 17:52:00+02	2016-10-25 21:52:00+02	51	2.3399999999999999	2
3307	2016-10-25 12:37:00+02	2016-10-25 16:37:00+02	51	5.3700000000000001	1
3308	2016-10-25 21:52:00+02	2016-10-25 12:37:00+02	51	0	
4527	2017-03-29 16:39:00+02	2017-03-29 20:39:00+02	110	6.29	1
4528	2017-03-29 14:33:00+02	2017-03-29 16:39:00+02	110	0	3
4529	2017-03-28 20:06:00+02	2017-03-28 22:09:00+02	110	0	4
4530	2017-03-29 22:52:00+02	2017-03-30 02:52:00+02	109	0.68000000000000005	2
4531	2017-03-30 02:52:00+02	2017-03-30 04:56:00+02	109	0	3
4532	2017-03-30 04:56:00+02	2017-03-30 08:56:00+02	109	6.3700000000000001	1
4533	2017-03-30 08:56:00+02	2017-03-30 11:15:00+02	109	0	4
4534	2017-03-30 11:15:00+02	2017-03-30 15:15:00+02	108	0.69999999999999996	2
4535	2017-03-30 17:12:00+02	2017-03-30 21:12:00+02	108	6.1900000000000004	1
4536	2017-03-30 15:15:00+02	2017-03-30 17:12:00+02	108	0	3
4537	2017-03-29 20:39:00+02	2017-03-29 22:52:00+02	108	0	4
5025	2017-05-30 23:52:00+02	2017-05-31 01:34:00+02	67	0	4
\.


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 214
-- Name: maree_mar_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('maree_mar_id_seq', 10050, true);


--
-- TOC entry 3636 (class 0 OID 44847)
-- Dependencies: 215
-- Data for Name: meteo; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY meteo (met_id, met_nebulosite, met_vent, met_directionv, met_temperature, met_date_time) FROM stdin;
1	\N	4.2999999999999998	50	9.4000000000000004	2015-10-01 00:00:00+02
2	\N	4.4000000000000004	60	9.3000000000000007	2015-10-01 01:00:00+02
3	\N	4.5999999999999996	70	9.1999999999999993	2015-10-01 02:00:00+02
4	\N	5	70	8.8000000000000007	2015-10-01 03:00:00+02
5	\N	4.9000000000000004	70	8.6999999999999993	2015-10-01 04:00:00+02
6	\N	4.5	70	8.3000000000000007	2015-10-01 05:00:00+02
7	\N	5.9000000000000004	80	8	2015-10-01 06:00:00+02
8	\N	4.5999999999999996	80	8.5999999999999996	2015-10-01 07:00:00+02
9	\N	5.4000000000000004	80	10.300000000000001	2015-10-01 08:00:00+02
10	\N	4.7000000000000002	80	13	2015-10-01 09:00:00+02
11	\N	3.5	90	15	2015-10-01 10:00:00+02
12	\N	4.2999999999999998	80	16.5	2015-10-01 11:00:00+02
13	\N	3.8999999999999999	70	17.699999999999999	2015-10-01 12:00:00+02
14	\N	4.4000000000000004	70	18.199999999999999	2015-10-01 13:00:00+02
15	\N	4.9000000000000004	70	19.100000000000001	2015-10-01 14:00:00+02
16	\N	5.2000000000000002	80	18.899999999999999	2015-10-01 15:00:00+02
17	6	4.7999999999999998	70	18.800000000000001	2015-10-01 16:00:00+02
18	7	5.5	60	17.899999999999999	2015-10-01 17:00:00+02
19	8	5.4000000000000004	60	16.600000000000001	2015-10-01 18:00:00+02
20	8	5.5	60	15.4	2015-10-01 19:00:00+02
21	8	5.4000000000000004	60	14.5	2015-10-01 20:00:00+02
22	8	6.0999999999999996	70	14	2015-10-01 21:00:00+02
23	8	5.5	60	13.300000000000001	2015-10-01 22:00:00+02
24	8	6.9000000000000004	70	12.199999999999999	2015-10-01 23:00:00+02
26	\N	5.5	70	10.6	2015-10-02 01:00:00+02
27	7	5.5	60	10.300000000000001	2015-10-02 02:00:00+02
28	\N	6.2000000000000002	70	10.300000000000001	2015-10-02 03:00:00+02
29	\N	4.7999999999999998	60	9.6999999999999993	2015-10-02 04:00:00+02
30	8	4.0999999999999996	50	9.3000000000000007	2015-10-02 05:00:00+02
31	\N	4.7000000000000002	50	8.8000000000000007	2015-10-02 06:00:00+02
32	7	4.7000000000000002	60	9.1999999999999993	2015-10-02 07:00:00+02
33	\N	4.7999999999999998	60	11.199999999999999	2015-10-02 08:00:00+02
34	\N	6	70	13.199999999999999	2015-10-02 09:00:00+02
35	\N	7.7000000000000002	70	14.9	2015-10-02 10:00:00+02
36	\N	7.9000000000000004	70	16	2015-10-02 11:00:00+02
37	\N	7.2999999999999998	70	17.600000000000001	2015-10-02 12:00:00+02
38	\N	5.7999999999999998	60	17.699999999999999	2015-10-02 13:00:00+02
39	\N	6.7000000000000002	60	18.199999999999999	2015-10-02 14:00:00+02
40	\N	5.5	60	18.699999999999999	2015-10-02 15:00:00+02
41	\N	5	70	17.800000000000001	2015-10-02 16:00:00+02
42	\N	6.2000000000000002	50	15.5	2015-10-02 17:00:00+02
43	\N	5.7000000000000002	50	13.9	2015-10-02 18:00:00+02
44	\N	4.7000000000000002	60	13.1	2015-10-02 19:00:00+02
45	\N	3.5	40	11.6	2015-10-02 20:00:00+02
46	\N	4.0999999999999996	40	11.5	2015-10-02 21:00:00+02
47	\N	3.3999999999999999	30	11	2015-10-02 22:00:00+02
48	\N	4.2000000000000002	20	10.4	2015-10-02 23:00:00+02
49	7	4.5	20	9.9000000000000004	2015-10-02 00:00:00+02
50	8	4.7999999999999998	30	9.5999999999999996	2015-10-03 01:00:00+02
51	6	4.2000000000000002	30	9.5	2015-10-03 02:00:00+02
52	\N	4.7000000000000002	30	9.3000000000000007	2015-10-03 03:00:00+02
53	7	4	20	9.1999999999999993	2015-10-03 04:00:00+02
54	\N	4	20	9.3000000000000007	2015-10-03 05:00:00+02
55	8	4.5999999999999996	20	9.5	2015-10-03 06:00:00+02
56	\N	4.2000000000000002	20	9.8000000000000007	2015-10-03 07:00:00+02
57	6	5.4000000000000004	30	11.4	2015-10-03 08:00:00+02
58	8	6.5	20	12.699999999999999	2015-10-03 09:00:00+02
59	8	7.0999999999999996	20	13.300000000000001	2015-10-03 10:00:00+02
60	8	6.5999999999999996	30	13.9	2015-10-03 11:00:00+02
61	7	6.5999999999999996	30	15.9	2015-10-03 12:00:00+02
62	\N	7.2999999999999998	40	16.699999999999999	2015-10-03 13:00:00+02
63	\N	7.0999999999999996	40	17.5	2015-10-03 14:00:00+02
64	\N	6.7000000000000002	30	17.300000000000001	2015-10-03 15:00:00+02
65	\N	7	20	16.300000000000001	2015-10-03 16:00:00+02
66	\N	6.2000000000000002	30	15.1	2015-10-03 17:00:00+02
67	\N	4.5999999999999996	30	13.800000000000001	2015-10-03 18:00:00+02
68	\N	4.2999999999999998	20	13.300000000000001	2015-10-03 19:00:00+02
69	\N	3.6000000000000001	10	11.9	2015-10-03 20:00:00+02
70	\N	3.5	10	11.4	2015-10-03 21:00:00+02
71	\N	3.8999999999999999	10	11.1	2015-10-03 22:00:00+02
72	\N	4.7999999999999998	10	10.9	2015-10-03 23:00:00+02
73	\N	4.4000000000000004	10	10.300000000000001	2015-10-03 00:00:00+02
74	\N	5	20	10.300000000000001	2015-10-04 01:00:00+02
75	\N	5.2999999999999998	20	10.199999999999999	2015-10-04 02:00:00+02
76	\N	5.2000000000000002	360	9.8000000000000007	2015-10-04 03:00:00+02
77	\N	4.2000000000000002	10	9.3000000000000007	2015-10-04 04:00:00+02
78	\N	3.8999999999999999	360	9.0999999999999996	2015-10-04 05:00:00+02
79	\N	4.7000000000000002	360	8.9000000000000004	2015-10-04 06:00:00+02
80	\N	3.8999999999999999	10	8.6999999999999993	2015-10-04 07:00:00+02
81	\N	4.0999999999999996	10	9.9000000000000004	2015-10-04 08:00:00+02
82	\N	4.4000000000000004	20	11.300000000000001	2015-10-04 09:00:00+02
83	\N	5.9000000000000004	20	12.699999999999999	2015-10-04 10:00:00+02
84	\N	5.5	30	13.699999999999999	2015-10-04 11:00:00+02
85	7	6.7999999999999998	40	14.699999999999999	2015-10-04 12:00:00+02
86	6	5.5999999999999996	20	15.199999999999999	2015-10-04 13:00:00+02
87	6	6.7000000000000002	20	14.199999999999999	2015-10-04 14:00:00+02
88	\N	5.7000000000000002	20	15.199999999999999	2015-10-04 15:00:00+02
89	6	8.0999999999999996	20	14	2015-10-04 16:00:00+02
90	\N	5	10	12.6	2015-10-04 17:00:00+02
91	\N	3.5	20	11.1	2015-10-04 18:00:00+02
92	\N	3.3999999999999999	10	10.6	2015-10-04 19:00:00+02
93	\N	3.2000000000000002	10	10.1	2015-10-04 20:00:00+02
94	\N	2.7999999999999998	10	8.9000000000000004	2015-10-04 21:00:00+02
95	\N	3.3999999999999999	10	8.5	2015-10-04 22:00:00+02
96	\N	3.7000000000000002	20	7.7999999999999998	2015-10-04 23:00:00+02
97	\N	4.0999999999999996	10	7.7000000000000002	2015-10-04 00:00:00+02
98	\N	3.6000000000000001	20	7.0999999999999996	2015-10-05 01:00:00+02
99	\N	3.6000000000000001	360	6.7999999999999998	2015-10-05 02:00:00+02
100	\N	4.7999999999999998	10	7.0999999999999996	2015-10-05 03:00:00+02
101	\N	3.8999999999999999	360	6.5	2015-10-05 04:00:00+02
102	\N	4	10	6.5	2015-10-05 05:00:00+02
103	\N	4.4000000000000004	360	6.2000000000000002	2015-10-05 06:00:00+02
104	\N	6.0999999999999996	20	7.0999999999999996	2015-10-05 07:00:00+02
105	\N	5.2999999999999998	20	7.2999999999999998	2015-10-05 08:00:00+02
106	\N	6.2000000000000002	20	8.8000000000000007	2015-10-05 09:00:00+02
107	\N	6.9000000000000004	40	10.6	2015-10-05 10:00:00+02
108	\N	7.7000000000000002	30	11.699999999999999	2015-10-05 11:00:00+02
109	\N	6.2000000000000002	20	12.5	2015-10-05 12:00:00+02
110	\N	6.5	20	13.199999999999999	2015-10-05 13:00:00+02
111	\N	7	20	13.5	2015-10-05 14:00:00+02
112	\N	5.2999999999999998	10	13	2015-10-05 15:00:00+02
113	\N	5.0999999999999996	10	13.1	2015-10-05 16:00:00+02
114	6	4.2999999999999998	10	12.4	2015-10-05 17:00:00+02
115	7	2.7999999999999998	360	11.300000000000001	2015-10-05 18:00:00+02
116	\N	2.8999999999999999	350	10.1	2015-10-05 19:00:00+02
117	\N	3.5	330	10.4	2015-10-05 20:00:00+02
118	\N	3.5	340	10.6	2015-10-05 21:00:00+02
119	\N	4.2999999999999998	350	10.1	2015-10-05 22:00:00+02
120	\N	3.2999999999999998	360	9.0999999999999996	2015-10-05 23:00:00+02
121	\N	3.7000000000000002	10	8.5	2015-10-06 00:00:00+02
122	\N	3	360	8.0999999999999996	2015-10-06 01:00:00+02
123	\N	3	360	8.0999999999999996	2015-10-06 02:00:00+02
124	\N	2.1000000000000001	350	8.4000000000000004	2015-10-06 03:00:00+02
125	8	4.5	330	10.4	2015-10-06 04:00:00+02
126	6	5.2000000000000002	330	10	2015-10-06 05:00:00+02
127	8	5.2999999999999998	340	10	2015-10-06 06:00:00+02
128	8	3.2000000000000002	360	10	2015-10-06 07:00:00+02
129	8	3.7000000000000002	350	10.199999999999999	2015-10-06 08:00:00+02
130	8	4	10	10	2015-10-06 09:00:00+02
131	\N	4.5	340	12.199999999999999	2015-10-06 10:00:00+02
132	\N	4.7000000000000002	360	13.6	2015-10-06 11:00:00+02
133	8	7.2000000000000002	10	12.699999999999999	2015-10-06 12:00:00+02
134	7	4.5999999999999996	360	13.4	2015-10-06 13:00:00+02
135	\N	5.2999999999999998	360	13.9	2015-10-06 14:00:00+02
136	\N	4.7000000000000002	10	13	2015-10-06 15:00:00+02
137	6	6	30	12.5	2015-10-06 16:00:00+02
138	\N	4.7000000000000002	40	10.699999999999999	2015-10-06 17:00:00+02
139	\N	3.1000000000000001	50	8.0999999999999996	2015-10-06 18:00:00+02
140	\N	3.5	60	7.7999999999999998	2015-10-06 19:00:00+02
141	\N	4.0999999999999996	90	6.2000000000000002	2015-10-06 20:00:00+02
142	\N	2.7000000000000002	110	4.4000000000000004	2015-10-06 21:00:00+02
143	\N	2.7000000000000002	110	3.7000000000000002	2015-10-06 22:00:00+02
144	\N	2.8999999999999999	80	3.3999999999999999	2015-10-06 23:00:00+02
145	\N	3	80	3.3999999999999999	2015-10-07 00:00:00+02
146	\N	1.5	70	2.8999999999999999	2015-10-07 01:00:00+02
147	\N	2.1000000000000001	80	1.7	2015-10-07 02:00:00+02
148	\N	2.2999999999999998	100	1.6000000000000001	2015-10-07 03:00:00+02
149	\N	1.3999999999999999	60	1.7	2015-10-07 04:00:00+02
150	\N	2.2999999999999998	50	1.3999999999999999	2015-10-07 05:00:00+02
151	\N	2.7999999999999998	50	1.3	2015-10-07 06:00:00+02
152	\N	2.2999999999999998	70	1.8999999999999999	2015-10-07 07:00:00+02
153	\N	0.90000000000000002	80	5.4000000000000004	2015-10-07 08:00:00+02
154	\N	0	0	8.3000000000000007	2015-10-07 09:00:00+02
155	\N	1.6000000000000001	300	8.6999999999999993	2015-10-07 10:00:00+02
156	\N	2.2000000000000002	300	9.3000000000000007	2015-10-07 11:00:00+02
157	7	1.8	310	10	2015-10-07 12:00:00+02
158	7	3	260	12	2015-10-07 13:00:00+02
159	\N	2.6000000000000001	280	11.9	2015-10-07 14:00:00+02
160	\N	3.6000000000000001	300	11.9	2015-10-07 15:00:00+02
161	\N	3.7000000000000002	300	11.9	2015-10-07 16:00:00+02
162	\N	3.8999999999999999	300	11.300000000000001	2015-10-07 17:00:00+02
163	8	3	310	12.1	2015-10-07 18:00:00+02
164	8	3.2000000000000002	330	12.199999999999999	2015-10-07 19:00:00+02
165	8	1.7	350	12.300000000000001	2015-10-07 20:00:00+02
166	8	2.2999999999999998	360	12.300000000000001	2015-10-07 21:00:00+02
167	\N	1.7	20	10.800000000000001	2015-10-07 22:00:00+02
168	\N	1.8999999999999999	20	10.1	2015-10-07 23:00:00+02
169	8	1.7	360	10.4	2015-10-08 00:00:00+02
170	8	1.2	20	10.6	2015-10-08 01:00:00+02
171	8	2	30	10.699999999999999	2015-10-08 02:00:00+02
172	8	3.5	40	10.5	2015-10-08 03:00:00+02
173	\N	4.5999999999999996	60	9.5	2015-10-08 04:00:00+02
174	\N	4	70	8.3000000000000007	2015-10-08 05:00:00+02
175	\N	4.4000000000000004	60	7.2000000000000002	2015-10-08 06:00:00+02
176	\N	5.0999999999999996	60	7.5999999999999996	2015-10-08 07:00:00+02
177	\N	4.5	70	8.5999999999999996	2015-10-08 08:00:00+02
178	\N	6.2000000000000002	60	9.5999999999999996	2015-10-08 09:00:00+02
179	\N	5.2000000000000002	70	11.300000000000001	2015-10-08 10:00:00+02
180	7	5	70	12.300000000000001	2015-10-08 11:00:00+02
181	8	4.9000000000000004	70	13.9	2015-10-08 12:00:00+02
182	\N	4.9000000000000004	90	14.1	2015-10-08 13:00:00+02
183	\N	5.2999999999999998	70	14.199999999999999	2015-10-08 14:00:00+02
184	\N	5.2999999999999998	70	13.699999999999999	2015-10-08 15:00:00+02
185	\N	4.5	70	12.800000000000001	2015-10-08 16:00:00+02
186	\N	5.4000000000000004	60	11.800000000000001	2015-10-08 17:00:00+02
187	\N	4.2999999999999998	70	10.699999999999999	2015-10-08 18:00:00+02
188	\N	5.0999999999999996	70	10.199999999999999	2015-10-08 19:00:00+02
189	\N	4.9000000000000004	70	9.5	2015-10-08 20:00:00+02
190	8	4.2000000000000002	70	8.9000000000000004	2015-10-08 21:00:00+02
191	8	5.0999999999999996	60	8.5999999999999996	2015-10-08 22:00:00+02
192	8	4.5999999999999996	60	8.4000000000000004	2015-10-08 23:00:00+02
193	8	3.7999999999999998	50	8.0999999999999996	2015-10-09 00:00:00+02
194	8	5.2999999999999998	70	8.0999999999999996	2015-10-09 01:00:00+02
195	8	5.7999999999999998	60	8	2015-10-09 02:00:00+02
196	8	5.2999999999999998	60	7.7999999999999998	2015-10-09 03:00:00+02
197	8	5.4000000000000004	70	7.9000000000000004	2015-10-09 04:00:00+02
198	8	5.2000000000000002	60	7.7999999999999998	2015-10-09 05:00:00+02
199	8	5.0999999999999996	60	7.5	2015-10-09 06:00:00+02
200	8	5.5	50	7.4000000000000004	2015-10-09 07:00:00+02
201	\N	6	60	8.4000000000000004	2015-10-09 08:00:00+02
202	8	5.5	60	10.300000000000001	2015-10-09 09:00:00+02
203	8	6.7999999999999998	60	12.300000000000001	2015-10-09 10:00:00+02
204	8	7.2000000000000002	70	13.699999999999999	2015-10-09 11:00:00+02
205	\N	7.5	70	15.1	2015-10-09 12:00:00+02
206	6	7.4000000000000004	80	16.100000000000001	2015-10-09 13:00:00+02
207	7	8.1999999999999993	70	16.100000000000001	2015-10-09 14:00:00+02
208	\N	6.7999999999999998	60	15.699999999999999	2015-10-09 15:00:00+02
209	\N	7.2999999999999998	60	15.699999999999999	2015-10-09 16:00:00+02
210	\N	5.7000000000000002	60	14	2015-10-09 17:00:00+02
211	\N	6.4000000000000004	60	12.5	2015-10-09 18:00:00+02
212	\N	5.4000000000000004	60	11.300000000000001	2015-10-09 19:00:00+02
213	\N	5.2999999999999998	60	10.199999999999999	2015-10-09 20:00:00+02
214	\N	5.2999999999999998	50	9.1999999999999993	2015-10-09 21:00:00+02
215	\N	5.7000000000000002	60	9.0999999999999996	2015-10-09 22:00:00+02
216	\N	5.2000000000000002	50	8.4000000000000004	2015-10-09 23:00:00+02
217	\N	5.7000000000000002	50	8.1999999999999993	2015-10-10 00:00:00+02
218	\N	7	50	7.9000000000000004	2015-10-10 01:00:00+02
219	\N	5.5	50	7.5	2015-10-10 02:00:00+02
220	\N	6.7000000000000002	50	7	2015-10-10 03:00:00+02
221	7	7.2000000000000002	40	7.0999999999999996	2015-10-10 04:00:00+02
222	\N	5.9000000000000004	60	6.7999999999999998	2015-10-10 05:00:00+02
223	\N	5	60	6.2999999999999998	2015-10-10 06:00:00+02
224	\N	6.0999999999999996	50	6.4000000000000004	2015-10-10 07:00:00+02
225	\N	6.5999999999999996	60	8.0999999999999996	2015-10-10 08:00:00+02
226	\N	7.5999999999999996	60	9.9000000000000004	2015-10-10 09:00:00+02
227	\N	9.3000000000000007	60	12.5	2015-10-10 10:00:00+02
228	\N	9.9000000000000004	60	14.5	2015-10-10 11:00:00+02
229	\N	10.4	60	15.300000000000001	2015-10-10 12:00:00+02
230	\N	11	60	16	2015-10-10 13:00:00+02
231	\N	10.699999999999999	50	16.399999999999999	2015-10-10 14:00:00+02
232	\N	8.9000000000000004	50	15.6	2015-10-10 15:00:00+02
233	\N	8.0999999999999996	50	14.6	2015-10-10 16:00:00+02
234	\N	7.5	40	13.5	2015-10-10 17:00:00+02
235	\N	5.2999999999999998	30	12.199999999999999	2015-10-10 18:00:00+02
236	\N	5.5999999999999996	30	11.6	2015-10-10 19:00:00+02
237	\N	5.2999999999999998	30	10.800000000000001	2015-10-10 20:00:00+02
238	\N	5.2999999999999998	30	10.6	2015-10-10 21:00:00+02
239	\N	5.2999999999999998	30	10.4	2015-10-10 22:00:00+02
240	\N	5.4000000000000004	20	9.8000000000000007	2015-10-10 23:00:00+02
241	\N	4.2000000000000002	30	9.5999999999999996	2015-10-11 00:00:00+02
242	7	7	30	10.1	2015-10-11 01:00:00+02
243	\N	5.7000000000000002	30	9.8000000000000007	2015-10-11 02:00:00+02
244	\N	4.7999999999999998	20	8.8000000000000007	2015-10-11 03:00:00+02
245	6	5.2000000000000002	10	8.8000000000000007	2015-10-11 04:00:00+02
246	\N	3.7000000000000002	30	8.1999999999999993	2015-10-11 05:00:00+02
247	\N	5.7999999999999998	360	8.8000000000000007	2015-10-11 06:00:00+02
248	\N	5.2000000000000002	20	8.8000000000000007	2015-10-11 07:00:00+02
249	\N	3.8999999999999999	20	9.5999999999999996	2015-10-11 08:00:00+02
250	\N	4.4000000000000004	30	11.6	2015-10-11 09:00:00+02
251	\N	5.7000000000000002	40	13.699999999999999	2015-10-11 10:00:00+02
252	7	5.9000000000000004	10	14.9	2015-10-11 11:00:00+02
253	8	5.9000000000000004	10	15.4	2015-10-11 12:00:00+02
254	8	6.2000000000000002	360	15.1	2015-10-11 13:00:00+02
255	8	6.7999999999999998	20	14.6	2015-10-11 14:00:00+02
256	8	5.0999999999999996	30	14.5	2015-10-11 15:00:00+02
257	8	7.2000000000000002	30	13.1	2015-10-11 16:00:00+02
258	8	3.8999999999999999	20	12.800000000000001	2015-10-11 17:00:00+02
259	8	3.7000000000000002	360	12.800000000000001	2015-10-11 18:00:00+02
260	8	4.0999999999999996	360	12.5	2015-10-11 19:00:00+02
261	8	3.8999999999999999	350	12.300000000000001	2015-10-11 20:00:00+02
262	8	5	360	12	2015-10-11 21:00:00+02
263	8	5.4000000000000004	360	12	2015-10-11 22:00:00+02
264	8	4.0999999999999996	20	11.800000000000001	2015-10-11 23:00:00+02
265	8	4.0999999999999996	10	11.5	2015-10-12 00:00:00+02
266	8	4.2999999999999998	20	11.199999999999999	2015-10-12 01:00:00+02
267	7	3.5	30	10.199999999999999	2015-10-12 02:00:00+02
268	\N	4.0999999999999996	20	9.3000000000000007	2015-10-12 03:00:00+02
269	\N	4	20	8.5999999999999996	2015-10-12 04:00:00+02
270	\N	3.1000000000000001	30	7.7999999999999998	2015-10-12 05:00:00+02
271	\N	2.7999999999999998	30	7.4000000000000004	2015-10-12 06:00:00+02
272	\N	1.6000000000000001	30	6.7999999999999998	2015-10-12 07:00:00+02
273	\N	0.5	60	8.3000000000000007	2015-10-12 08:00:00+02
274	\N	0.5	320	10	2015-10-12 09:00:00+02
275	\N	0.59999999999999998	250	12.4	2015-10-12 10:00:00+02
276	\N	1.8999999999999999	310	12.1	2015-10-12 11:00:00+02
277	\N	2.5	310	12.800000000000001	2015-10-12 12:00:00+02
278	\N	2.2999999999999998	310	13.9	2015-10-12 13:00:00+02
279	8	4	300	13.6	2015-10-12 14:00:00+02
280	8	4	280	13.800000000000001	2015-10-12 15:00:00+02
281	8	5	300	14.1	2015-10-12 16:00:00+02
282	8	5.0999999999999996	300	13.300000000000001	2015-10-12 17:00:00+02
283	8	5	320	13.199999999999999	2015-10-12 18:00:00+02
284	8	5.2999999999999998	330	13	2015-10-12 19:00:00+02
285	8	5.7000000000000002	330	12.5	2015-10-12 20:00:00+02
286	8	1.8999999999999999	320	12.300000000000001	2015-10-12 21:00:00+02
287	8	1.3999999999999999	310	12.4	2015-10-12 22:00:00+02
288	8	0.80000000000000004	270	12.4	2015-10-12 23:00:00+02
289	8	1.3	250	12.5	2015-10-13 00:00:00+02
290	8	2	220	12.300000000000001	2015-10-13 01:00:00+02
291	8	2.2999999999999998	190	12.5	2015-10-13 02:00:00+02
292	8	3.2000000000000002	210	12.699999999999999	2015-10-13 03:00:00+02
293	8	4.2999999999999998	240	13.300000000000001	2015-10-13 04:00:00+02
294	8	2.7999999999999998	320	13.1	2015-10-13 05:00:00+02
295	8	5.5999999999999996	320	13.5	2015-10-13 06:00:00+02
296	8	3.7000000000000002	310	13.4	2015-10-13 07:00:00+02
297	8	6.7999999999999998	340	12.699999999999999	2015-10-13 08:00:00+02
298	8	3.6000000000000001	310	13.9	2015-10-13 09:00:00+02
299	8	2.7000000000000002	330	14.199999999999999	2015-10-13 10:00:00+02
300	8	2.5	310	14.199999999999999	2015-10-13 11:00:00+02
301	8	3.8999999999999999	330	14.5	2015-10-13 12:00:00+02
302	8	3.2999999999999998	320	14.4	2015-10-13 13:00:00+02
303	8	2.1000000000000001	300	14.300000000000001	2015-10-13 14:00:00+02
304	8	2.2999999999999998	270	14.1	2015-10-13 15:00:00+02
305	8	1.8999999999999999	280	14.199999999999999	2015-10-13 16:00:00+02
306	8	1.3	340	13.9	2015-10-13 17:00:00+02
307	8	1.6000000000000001	290	13.9	2015-10-13 18:00:00+02
308	8	1	10	13.699999999999999	2015-10-13 19:00:00+02
309	8	1.1000000000000001	30	13.6	2015-10-13 20:00:00+02
310	8	0.5	180	13.699999999999999	2015-10-13 21:00:00+02
311	8	1	190	13.6	2015-10-13 22:00:00+02
312	8	0.59999999999999998	200	13.6	2015-10-13 23:00:00+02
313	8	0.5	190	13.199999999999999	2015-10-14 00:00:00+02
314	8	1	180	13.199999999999999	2015-10-14 01:00:00+02
315	8	1.3999999999999999	190	13.6	2015-10-14 02:00:00+02
316	8	1.5	160	13.199999999999999	2015-10-14 03:00:00+02
317	8	2.3999999999999999	160	13.1	2015-10-14 04:00:00+02
318	8	1.5	170	12.699999999999999	2015-10-14 05:00:00+02
319	8	2.2000000000000002	150	12.4	2015-10-14 06:00:00+02
320	8	2.2999999999999998	150	12.4	2015-10-14 07:00:00+02
321	8	3.2999999999999998	150	13.4	2015-10-14 08:00:00+02
322	8	3.6000000000000001	160	14.6	2015-10-14 09:00:00+02
323	\N	3.8999999999999999	160	15.1	2015-10-14 10:00:00+02
324	7	4.2000000000000002	180	15.199999999999999	2015-10-14 11:00:00+02
325	6	4.2999999999999998	90	15.800000000000001	2015-10-14 12:00:00+02
326	8	3.1000000000000001	110	16.100000000000001	2015-10-14 13:00:00+02
327	8	1.1000000000000001	110	16.199999999999999	2015-10-14 14:00:00+02
3024	8	3.1000000000000001	250	10.1	2016-02-03 23:00:00+01
3025	8	2	210	10	2016-02-04 00:00:00+01
3026	8	3.5	200	10.300000000000001	2016-02-04 01:00:00+01
3027	8	5	190	10	2016-02-04 02:00:00+01
3028	8	6	180	9.9000000000000004	2016-02-04 03:00:00+01
3029	8	8.8000000000000007	190	10.199999999999999	2016-02-04 04:00:00+01
3030	8	9.5999999999999996	240	12.300000000000001	2016-02-04 05:00:00+01
3031	8	9.0999999999999996	260	12.300000000000001	2016-02-04 06:00:00+01
3032	8	10.699999999999999	260	12.199999999999999	2016-02-04 07:00:00+01
3033	8	11.300000000000001	250	12.4	2016-02-04 08:00:00+01
3034	8	12.699999999999999	250	12.5	2016-02-04 09:00:00+01
3035	8	15.300000000000001	250	12.699999999999999	2016-02-04 10:00:00+01
3036	8	14.699999999999999	260	11.6	2016-02-04 11:00:00+01
3037	8	15.5	260	12.9	2016-02-04 12:00:00+01
3038	8	15.300000000000001	260	12.800000000000001	2016-02-04 13:00:00+01
3039	8	14	260	12.5	2016-02-04 14:00:00+01
3040	8	14	260	12.4	2016-02-04 15:00:00+01
3041	8	11.199999999999999	270	12	2016-02-04 16:00:00+01
3042	8	11.800000000000001	270	11.4	2016-02-04 17:00:00+01
3043	8	7.7999999999999998	270	10.9	2016-02-04 18:00:00+01
3044	8	5.2000000000000002	260	10.9	2016-02-04 19:00:00+01
3045	8	3.6000000000000001	270	10.5	2016-02-04 20:00:00+01
3046	8	5.2999999999999998	250	9.1999999999999993	2016-02-04 21:00:00+01
3047	8	4.5	240	9	2016-02-04 22:00:00+01
3048	8	4.2000000000000002	250	8.4000000000000004	2016-02-04 23:00:00+01
3049	8	3.2000000000000002	270	8	2016-02-05 00:00:00+01
3050	8	5.2000000000000002	290	8.0999999999999996	2016-02-05 01:00:00+01
3051	8	3.5	260	8	2016-02-05 02:00:00+01
3052	8	5.7999999999999998	300	7.7999999999999998	2016-02-05 03:00:00+01
3053	8	7.0999999999999996	330	7.4000000000000004	2016-02-05 04:00:00+01
3054	8	5.5999999999999996	320	7	2016-02-05 05:00:00+01
3055	7	5.4000000000000004	320	7.0999999999999996	2016-02-05 06:00:00+01
3056	7	5.2999999999999998	320	7.5	2016-02-05 07:00:00+01
3057	7	3.3999999999999999	340	7.0999999999999996	2016-02-05 08:00:00+01
3058	6	0.80000000000000004	180	7.5	2016-02-05 09:00:00+01
4270	8	4	240	10.800000000000001	2016-03-25 23:00:00+01
4271	8	3.6000000000000001	200	10.699999999999999	2016-03-26 00:00:00+01
4272	8	2.7000000000000002	240	10.5	2016-03-26 01:00:00+01
4273	8	4	160	10.4	2016-03-26 02:00:00+01
4274	8	3.7000000000000002	170	10.6	2016-03-26 03:00:00+01
4275	8	6.0999999999999996	160	10.800000000000001	2016-03-26 04:00:00+01
4276	8	5.5	180	11.199999999999999	2016-03-26 05:00:00+01
4277	8	4.5	180	11.1	2016-03-26 06:00:00+01
4278	8	5.5	180	11.199999999999999	2016-03-26 07:00:00+01
4279	8	5.2999999999999998	160	11.199999999999999	2016-03-26 08:00:00+01
4280	8	6.5999999999999996	160	11.1	2016-03-26 09:00:00+01
4281	8	5.9000000000000004	170	11.199999999999999	2016-03-26 10:00:00+01
4282	8	6.5	160	12	2016-03-26 11:00:00+01
4283	8	6	160	13.4	2016-03-26 12:00:00+01
4284	8	6.2000000000000002	170	14.5	2016-03-26 13:00:00+01
4285	7	5.5	160	15.699999999999999	2016-03-26 14:00:00+01
4286	7	6.9000000000000004	180	15.800000000000001	2016-03-26 15:00:00+01
4287	\N	6	180	16.199999999999999	2016-03-26 16:00:00+01
5296	8	2.7000000000000002	200	18.899999999999999	2016-05-07 17:00:00+02
5297	8	2.2999999999999998	210	18	2016-05-07 18:00:00+02
5298	8	0	0	17.199999999999999	2016-05-07 19:00:00+02
5299	\N	3.2000000000000002	70	15.4	2016-05-07 20:00:00+02
5300	\N	3.7000000000000002	70	15.199999999999999	2016-05-07 21:00:00+02
5301	\N	3.7999999999999998	90	14.5	2016-05-07 22:00:00+02
5302	8	5.2000000000000002	120	17	2016-05-07 23:00:00+02
5303	7	6	120	16.399999999999999	2016-05-08 00:00:00+02
5304	\N	5.2000000000000002	120	15.5	2016-05-08 01:00:00+02
5305	8	5.7000000000000002	120	15.4	2016-05-08 02:00:00+02
5306	8	5.5999999999999996	130	14.9	2016-05-08 03:00:00+02
5307	8	6.2999999999999998	130	14.6	2016-05-08 04:00:00+02
5308	8	6.2999999999999998	130	14.9	2016-05-08 05:00:00+02
5309	6	7	130	15	2016-05-08 06:00:00+02
5310	\N	7.0999999999999996	140	15.6	2016-05-08 07:00:00+02
5311	7	7.2999999999999998	140	16.600000000000001	2016-05-08 08:00:00+02
7168	\N	6.2000000000000002	300	21.899999999999999	2016-07-24 17:00:00+02
7169	\N	6.7999999999999998	290	21.199999999999999	2016-07-24 18:00:00+02
7170	\N	6.9000000000000004	290	20.399999999999999	2016-07-24 19:00:00+02
7171	\N	6.2000000000000002	290	19.5	2016-07-24 20:00:00+02
7172	\N	4.9000000000000004	290	19.199999999999999	2016-07-24 21:00:00+02
7173	\N	5.0999999999999996	300	19	2016-07-24 22:00:00+02
7174	\N	4.2999999999999998	310	18.899999999999999	2016-07-24 23:00:00+02
7175	\N	3.7000000000000002	310	18.600000000000001	2016-07-25 00:00:00+02
7176	\N	4.0999999999999996	320	18.5	2016-07-25 01:00:00+02
7177	7	3.7000000000000002	320	18.5	2016-07-25 02:00:00+02
7178	\N	3.2000000000000002	300	18.199999999999999	2016-07-25 03:00:00+02
9632	8	1.5	110	6.7999999999999998	2016-11-04 09:00:00+01
9633	\N	1.5	160	9.5999999999999996	2016-11-04 10:00:00+01
9634	\N	3.6000000000000001	160	9	2016-11-04 11:00:00+01
9635	8	2	160	10.4	2016-11-04 12:00:00+01
9636	7	2.1000000000000001	170	11.199999999999999	2016-11-04 13:00:00+01
9637	8	2.2000000000000002	160	11.9	2016-11-04 14:00:00+01
9638	8	2.5	150	11.800000000000001	2016-11-04 15:00:00+01
9639	8	3.2999999999999998	160	12.300000000000001	2016-11-04 16:00:00+01
9640	8	3.7000000000000002	160	12.199999999999999	2016-11-04 17:00:00+01
9641	8	4.2000000000000002	160	12.4	2016-11-04 18:00:00+01
9642	8	4.7000000000000002	160	12.4	2016-11-04 19:00:00+01
9643	8	3.6000000000000001	170	12.199999999999999	2016-11-04 20:00:00+01
11775	8	3.5	210	12.300000000000001	2017-02-01 16:00:00+01
11776	7	2.5	190	11.699999999999999	2017-02-01 17:00:00+01
11777	\N	2.2999999999999998	180	10.1	2017-02-01 18:00:00+01
11778	\N	2.5	170	9.5999999999999996	2017-02-01 19:00:00+01
11779	\N	3.7000000000000002	160	9.5999999999999996	2017-02-01 20:00:00+01
11780	8	4.2000000000000002	150	9.8000000000000007	2017-02-01 21:00:00+01
11781	8	4.5999999999999996	140	9.8000000000000007	2017-02-01 22:00:00+01
11782	8	4.5999999999999996	140	9.9000000000000004	2017-02-01 23:00:00+01
11783	8	7	150	10.800000000000001	2017-02-02 00:00:00+01
11784	8	8	160	11	2017-02-02 01:00:00+01
11785	8	6.7999999999999998	150	10.6	2017-02-02 02:00:00+01
11786	\N	7.4000000000000004	150	10.4	2017-02-02 03:00:00+01
11787	7	8.5999999999999996	150	10.4	2017-02-02 04:00:00+01
11788	8	8	160	10.199999999999999	2017-02-02 05:00:00+01
11789	8	11	150	9.9000000000000004	2017-02-02 06:00:00+01
11790	8	10.300000000000001	160	9.5	2017-02-02 07:00:00+01
13312	\N	6.7000000000000002	50	15.6	2017-04-06 17:00:00+02
13313	\N	5.7999999999999998	50	14	2017-04-06 18:00:00+02
13314	\N	4	50	11.4	2017-04-06 19:00:00+02
13315	\N	3.5	40	9.5999999999999996	2017-04-06 20:00:00+02
13316	\N	3.7000000000000002	50	9.5	2017-04-06 21:00:00+02
13317	\N	3.2000000000000002	40	8.1999999999999993	2017-04-06 22:00:00+02
13318	\N	3	40	7.4000000000000004	2017-04-06 23:00:00+02
\.


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 216
-- Name: meteo_met_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('meteo_met_id_seq', 13318, true);


--
-- TOC entry 3638 (class 0 OID 44852)
-- Dependencies: 217
-- Data for Name: observation; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY observation (obs_id, obs_date, obs_heure, obs_geom, obs_searching_time, obs_gps_voltage, obs_gps_temperature, obs_verifiee, obs_distance_points, obs_speed, obs_fich_id, obs_cycle_id, obs_ind_id, obs_tyact_id, obs_date_time) FROM stdin;
145638	2015-12-27	12:13:00	0101000020E6100000C51D6FF25BB4F7BF0D71AC8BDB1C4740	\N	\N	\N	t	0.092850506999999999	0.40000000000000002	\N	1	45	2	2015-12-27 13:13:00+01
12386	2017-07-13	03:41:00	0101000020E6100000DAA9B9DC6068F1BF49BBD1C77CF24640	\N	\N	\N	t	0.46783714100000001	0.10000000000000001	\N	0	18	0	2017-07-13 05:41:00+02
147092	2016-04-09	14:37:00	0101000020E61000008410902FA1C2F7BF52499D80261A4740	\N	\N	\N	t	0.38960502499999999	0.20000000000000001	\N	1	45	2	2016-04-09 16:37:00+02
151141	2016-12-13	16:54:00	0101000020E61000005858703FE0C1F7BF8AB0E1E9951A4740	\N	\N	\N	t	0.0067343860000000002	0.20000000000000001	\N	1	43	0	2016-12-13 17:54:00+01
214838	2016-11-09	14:04:00	0101000020E610000056EF703B34ECF7BFCD1DFD2FD71C4740	\N	\N	\N	t	0.068566029000000001	0	\N	0	40	3	2016-11-09 15:04:00+01
215239	2017-03-15	03:11:00	0101000020E6100000A01A2FDD2406F8BF99D9E731CA1D4740	\N	\N	\N	t	0.002210179	0	\N	0	40	3	2017-03-15 04:11:00+01
215345	2017-03-29	21:34:00	0101000020E61000006A4DF38E53F4F7BFAF21382EE31C4740	\N	\N	\N	t	0.033309303999999998	0.40000000000000002	\N	0	40	3	2017-03-29 23:34:00+02
1	2018-02-20	04:48:00	0101000020E6100000A54E40136143F1BF44183F8D7BF14640	65	3.8300000000000001	0	t	0.0038714520000000001	0	\N	0	5	0	2018-02-20 05:48:00+01
2	2018-02-20	04:49:00	0101000020E61000006C787AA52C43F1BF44183F8D7BF14640	9	3.8399999999999999	0	t	0.0038714520000000001	0.10000000000000001	\N	0	5	0	2018-02-20 05:49:00+01
3	2018-02-20	04:50:00	0101000020E6100000A54E40136143F1BF44183F8D7BF14640	9	3.8399999999999999	0	t	0.0031785609999999999	0.10000000000000001	\N	0	5	0	2018-02-20 05:50:00+01
4	2018-02-20	04:51:00	0101000020E61000002D93E1783E43F1BF1A51DA1B7CF14640	9	3.8399999999999999	0	t	0.0038702879999999999	0	\N	0	5	0	2018-02-20 05:51:00+01
5	2018-02-20	05:21:00	0101000020E61000006669A7E67243F1BF1A51DA1B7CF14640	9	3.8100000000000001	0	t	0.0022605770000000002	0.10000000000000001	\N	0	5	0	2018-02-20 06:21:00+01
6	2018-02-20	05:51:00	0101000020E61000001C0A9FAD8343F1BFF08975AA7CF14640	10	3.7999999999999998	0	t	0.013901782999999999	0.10000000000000001	\N	0	5	0	2018-02-20 06:51:00+01
135035	2017-12-31	17:54:00	0101000020E61000004B7842AF3F49F0BFE54350357AEB4640	6	3.96	0	t	0.042127639000000001	0.10000000000000001	\N	0	91	0	2017-12-31 18:54:00+01
135036	2017-12-31	18:25:00	0101000020E61000009E7DE5417A4AF0BF15191D9084EB4640	7	3.9500000000000002	0	t	0.020348954999999998	0.10000000000000001	\N	0	91	0	2017-12-31 19:25:00+01
135037	2017-12-31	18:55:00	0101000020E61000009E7DE5417A4AF0BF2497FF907EEB4640	7	3.96	0	t	0.050872920000000002	0.40000000000000002	\N	0	91	0	2017-12-31 19:55:00+01
135038	2017-12-31	19:25:00	0101000020E6100000B37E33315D48F0BFD0B7054B75EB4640	6	3.96	0	t	0.030090746000000002	0.29999999999999999	\N	0	91	0	2017-12-31 20:25:00+01
135039	2017-12-31	19:55:00	0101000020E61000004EF04DD36747F0BF9D2FF65E7CEB4640	6	3.96	0	t	0.0090358260000000003	0.69999999999999996	\N	0	91	0	2017-12-31 20:55:00+01
135040	2017-12-31	20:25:00	0101000020E61000005F79909E2247F0BF2497FF907EEB4640	16	3.9500000000000002	0	t	0.16429084799999999	0.10000000000000001	\N	0	91	0	2017-12-31 21:25:00+01
135041	2017-12-31	20:55:00	0101000020E6100000371AC05B2041F0BFB9895A9A5BEB4640	9	3.9500000000000002	0	t	0.073106589999999999	4	\N	0	91	0	2017-12-31 21:55:00+01
135042	2017-12-31	21:26:00	0101000020E6100000522AE109BD3EF0BF8195438B6CEB4640	7	3.9500000000000002	0	t	0.183673478	1	\N	0	91	0	2017-12-31 22:26:00+01
135043	2017-12-31	21:56:00	0101000020E6100000A2B77878CF41F0BFDE7536E49FEB4640	9	3.9399999999999999	0	t	0.14010320800000001	0.40000000000000002	\N	0	91	0	2017-12-31 22:56:00+01
135044	2017-12-31	22:26:00	0101000020E6100000581AF8510D3BF0BFD505BCCCB0EB4640	9	3.9399999999999999	0	t	0.124676615	0.59999999999999998	\N	0	91	0	2017-12-31 23:26:00+01
135045	2017-12-31	22:56:00	0101000020E61000003D29931ADA40F0BF083D9B559FEB4640	14	3.8999999999999999	0	t	0.19110732499999999	0.5	\N	0	91	0	2017-12-31 23:56:00+01
135046	2017-12-31	23:26:00	0101000020E610000008CBD8D0CD3EF0BF4242942F68EB4640	10	3.9300000000000002	0	t	0.149516856	0.40000000000000002	\N	0	91	0	2018-01-01 00:26:00+01
135047	2017-12-31	23:56:00	0101000020E6100000B96E4A79AD44F0BFC28A53AD85EB4640	7	3.9300000000000002	0	t	5098.1514090000001	0.5	\N	0	91	0	2018-01-01 00:56:00+01
135048	2016-04-22	20:22:00	0101000020E61000000D71AC8BDB983B4040A4DFBE0ED84E40	36	3.4900000000000002	\N	t	29.461413539999999	5.7999999999999998	\N	3	42	0	2016-04-22 22:22:00+02
135049	2016-03-18	14:11:00	0101000020E61000001AC05B2041D113408351499D80964A40	29	3.4900000000000002	\N	t	0.28607455300000001	0.10000000000000001	\N	3	49	0	2016-03-18 15:11:00+01
135050	2016-03-18	14:41:00	0101000020E61000001FF46C567DCE1340BC0512143F964A40	8	3.46	\N	t	0.85553005900000001	0.20000000000000001	\N	3	49	0	2016-03-18 15:41:00+01
135051	2016-03-18	15:12:00	0101000020E610000030D63730B9C11340978C63247B964A40	12	3.4500000000000002	\N	t	5.4908833509999999	0.10000000000000001	\N	3	49	0	2016-03-18 16:12:00+01
135052	2016-03-18	15:42:00	0101000020E61000008995D1C8E7A5134063D009A183904A40	7	3.5899999999999999	\N	t	0.014952234	0.29999999999999999	\N	3	49	0	2016-03-18 16:42:00+01
135053	2016-03-18	16:13:00	0101000020E61000006744696FF0A51340A323B9FC87904A40	23	3.5	\N	t	1.990436769	0.20000000000000001	\N	3	49	0	2016-03-18 17:13:00+01
135054	2016-03-18	16:43:00	0101000020E6100000A0DD21C5009913407575C7629B924A40	14	3.48	\N	t	0.14525265000000001	0.40000000000000002	\N	3	49	0	2016-03-18 17:43:00+01
135055	2016-03-18	17:13:00	0101000020E610000099BB96900F9A13407C43E1B375924A40	11	3.48	\N	t	1.1290809260000001	0.29999999999999999	\N	3	49	0	2016-03-18 18:13:00+01
135056	2016-03-18	17:44:00	0101000020E61000002506819543AB134020B41EBE4C924A40	39	3.4500000000000002	\N	t	0.71462999400000005	0.5	\N	3	49	0	2016-03-18 18:44:00+01
135057	2016-03-18	18:15:00	0101000020E61000006E19709692B5134092AD2EA704924A40	21	3.4700000000000002	\N	t	1.4472478870000001	1.3	\N	3	49	0	2016-03-18 19:15:00+01
135058	2016-03-18	18:46:00	0101000020E6100000315C1D0071C71340F624B03907914A40	27	3.4199999999999999	\N	t	0.81889402899999997	98	\N	3	49	0	2016-03-18 19:46:00+01
135059	2016-03-18	19:16:00	0101000020E610000011E2CAD93BD313406072A3C85A914A40	9	3.4900000000000002	\N	t	1.6513311850000001	1.3999999999999999	\N	3	49	0	2016-03-18 20:16:00+01
135060	2016-03-18	19:46:00	0101000020E6100000B72572C119EC1340A1496249B9914A40	17	3.4399999999999999	\N	t	0.70116817799999998	0.69999999999999996	\N	3	49	0	2016-03-18 20:46:00+01
135061	2016-03-18	20:17:00	0101000020E610000028999CDA19F613406EA301BC05924A40	12	3.48	\N	t	0.50994721300000001	0.69999999999999996	\N	3	49	0	2016-03-18 21:17:00+01
135062	2016-03-18	20:47:00	0101000020E6100000EDF2AD0FEBFD1340E78C28ED0D924A40	13	3.46	\N	t	16.456161049999999	1.1000000000000001	\N	3	49	0	2016-03-18 21:47:00+01
7	2018-02-20	06:22:00	0101000020E610000016FBCBEEC943F1BF59A4897780F14640	11	3.7999999999999998	0	t	0.0022122169999999998	0.10000000000000001	\N	0	5	0	2018-02-20 07:22:00+01
8	2018-02-20	06:52:00	0101000020E610000054E0641BB843F1BF53E751F17FF14640	12	3.79	0	t	0.33724396000000001	0.29999999999999999	\N	0	5	0	2018-02-20 07:52:00+01
9	2018-02-20	07:23:00	0101000020E610000063601DC70F55F1BF1232906797F14640	12	3.79	0	t	0.269820263	0.10000000000000001	\N	0	5	0	2018-02-20 08:23:00+01
10	2018-02-20	07:54:00	0101000020E61000004241295AB957F1BF61360186E5F14640	27	3.77	0	t	0.16591526200000001	0.29999999999999999	\N	0	5	0	2018-02-20 08:54:00+01
11	2018-02-20	08:24:00	0101000020E6100000A226FA7C9451F1BFFCC7427408F24640	11	3.79	0	t	0.021087607000000001	0	\N	0	5	0	2018-02-20 09:24:00+01
12	2018-02-20	08:55:00	0101000020E6100000919DB7B1D951F1BFBDC5C37B0EF24640	9	3.7799999999999998	0	t	0.0084955159999999998	0	\N	0	5	0	2018-02-20 09:55:00+01
13	2018-02-20	09:25:00	0101000020E6100000E10B93A98251F1BF0B9755D80CF24640	9	3.8199999999999998	0	t	0.0097529560000000001	0.10000000000000001	\N	0	5	0	2018-02-20 10:25:00+01
14	2018-02-20	09:55:00	0101000020E6100000317A6EA12B51F1BFC382FB010FF24640	12	3.8300000000000001	0	t	0.028942657	0.40000000000000002	\N	0	5	0	2018-02-20 10:55:00+01
15	2018-02-20	10:26:00	0101000020E6100000E4839ECDAA4FF1BF11548D5E0DF24640	31	3.8300000000000001	0	t	0.031045729000000001	0.10000000000000001	\N	0	5	0	2018-02-20 11:26:00+01
16	2018-02-20	10:57:00	0101000020E6100000E71A66683C51F1BF832F4CA60AF24640	11	3.8300000000000001	0	t	0.0067744169999999996	0.10000000000000001	\N	0	5	0	2018-02-20 11:57:00+01
17	2018-02-20	11:28:00	0101000020E6100000AF44A0FA0751F1BFD200DE0209F24640	11	3.8700000000000001	0	t	0.032304237	0.10000000000000001	\N	0	5	0	2018-02-20 12:28:00+01
18	2018-02-20	11:58:00	0101000020E6100000EA92718C644FF1BF5F251FBB0BF24640	10	3.8799999999999999	0	t	0.048778269999999999	0.5	\N	0	5	0	2018-02-20 12:58:00+01
19	2018-02-20	12:29:00	0101000020E6100000083A5AD5924EF1BFCBF27519FEF14640	12	3.8900000000000001	0	t	0.49401835199999999	0.10000000000000001	\N	0	5	0	2018-02-20 13:29:00+01
20	2018-02-20	13:00:00	0101000020E61000005DDF87838468F1BF6FF4311F10F24640	11	3.8799999999999999	0	t	0.34852426199999997	0.29999999999999999	\N	0	5	0	2018-02-20 14:00:00+01
21	2018-02-20	13:30:00	0101000020E6100000249A40118B58F1BF12143FC6DCF14640	27	3.8700000000000001	0	t	0.24213053700000001	0	\N	0	5	0	2018-02-20 14:30:00+01
22	2018-02-20	14:31:00	0101000020E610000079E6E5B0FB4EF1BF355EBA490CF24640	9	3.9100000000000001	0	t	0.031659036000000002	0	\N	0	5	0	2018-02-20 15:31:00+01
23	2018-02-20	15:01:00	0101000020E6100000764F1E166A4DF1BFD200DE0209F24640	9	3.96	0	t	0.0053333019999999998	0.10000000000000001	\N	0	5	0	2018-02-20 16:01:00+01
24	2018-02-20	15:32:00	0101000020E6100000AF25E4839E4DF1BFF60A0BEE07F24640	10	3.9500000000000002	0	t	0.0031771429999999999	0	\N	0	5	0	2018-02-20 16:32:00+01
25	2018-02-20	16:02:00	0101000020E6100000386A85E97B4DF1BF20D26F5F07F24640	12	3.9500000000000002	0	t	0.051752277999999999	0.10000000000000001	\N	0	5	0	2018-02-20 17:02:00+01
26	2018-02-20	16:32:00	0101000020E610000055302AA91350F1BF355EBA490CF24640	11	3.9399999999999999	0	t	0.022207962000000001	0.29999999999999999	\N	0	5	0	2018-02-20 17:32:00+01
27	2018-02-20	17:03:00	0101000020E6100000C345EEE9EA4EF1BF11548D5E0DF24640	39	3.9100000000000001	0	t	0.062599734000000004	0	\N	0	5	0	2018-02-20 18:03:00+01
28	2018-02-20	17:33:00	0101000020E61000004CA94BC63152F1BF832F4CA60AF24640	9	3.9199999999999999	0	t	0.0038702879999999999	0.10000000000000001	\N	0	5	0	2018-02-20 18:33:00+01
29	2018-02-20	18:04:00	0101000020E6100000847F11346652F1BF832F4CA60AF24640	9	3.9199999999999999	0	t	0.0067744169999999996	0.69999999999999996	\N	0	5	0	2018-02-20 19:04:00+01
30	2018-02-20	18:34:00	0101000020E61000004CA94BC63152F1BF355EBA490CF24640	9	3.9100000000000001	0	t	0.083916950000000004	0	\N	0	5	0	2018-02-20 19:34:00+01
31	2018-02-20	19:05:00	0101000020E610000026E1421EC14DF1BF5F251FBB0BF24640	10	3.8999999999999999	0	t	0.0067744169999999996	0.10000000000000001	\N	0	5	0	2018-02-20 20:05:00+01
32	2018-02-20	19:35:00	0101000020E61000005FB7088CF54DF1BF11548D5E0DF24640	11	3.8900000000000001	0	t	0.0042604690000000002	0.10000000000000001	\N	0	5	0	2018-02-20 20:35:00+01
33	2018-02-20	20:05:00	0101000020E610000026E1421EC14DF1BF0B9755D80CF24640	14	3.8900000000000001	0	t	0.017190629999999998	0.10000000000000001	\N	0	5	0	2018-02-20 21:05:00+01
34	2018-02-20	20:35:00	0101000020E6100000CA54C1A8A44EF1BFE78C28ED0DF24640	11	3.8799999999999999	0	t	0.059391646999999999	0.20000000000000001	\N	0	5	0	2018-02-20 21:35:00+01
35	2018-02-20	21:06:00	0101000020E6100000DBFCBFEAC851F1BF11548D5E0DF24640	17	3.8900000000000001	0	t	0.006151045	0.29999999999999999	\N	0	5	0	2018-02-20 22:06:00+01
36	2018-02-20	21:36:00	0101000020E610000058C7F143A551F1BFC382FB010FF24640	16	3.8599999999999999	0	t	0.0074649579999999998	3.6000000000000001	\N	0	5	0	2018-02-20 22:36:00+01
37	2018-02-20	22:06:00	0101000020E610000013D38558FD51F1BFE78C28ED0DF24640	12	3.8799999999999999	0	t	0.011000621	0.10000000000000001	\N	0	5	0	2018-02-20 23:06:00+01
38	2018-02-20	22:37:00	0101000020E610000020F12BD67051F1BF0B9755D80CF24640	37	3.8300000000000001	0	t	0	0	\N	0	5	0	2018-02-20 23:37:00+01
39	2018-02-20	23:07:00	0101000020E610000020F12BD67051F1BF0B9755D80CF24640	10	3.8599999999999999	0	t	0.0026309240000000002	0.20000000000000001	\N	0	5	0	2018-02-21 00:07:00+01
40	2018-02-20	23:38:00	0101000020E6100000A226FA7C9451F1BF0B9755D80CF24640	11	3.8599999999999999	0	t	0.0013154620000000001	0	\N	0	5	0	2018-02-21 00:38:00+01
41	2018-02-21	00:08:00	0101000020E6100000E10B93A98251F1BF0B9755D80CF24640	12	3.8500000000000001	0	t	0.0040030739999999997	0.20000000000000001	\N	0	5	0	2018-02-21 01:08:00+01
42	2018-02-21	00:38:00	0101000020E610000020F12BD67051F1BF5F251FBB0BF24640	11	3.8700000000000001	0	t	0.020131432000000001	0.10000000000000001	\N	0	5	0	2018-02-21 01:38:00+01
43	2018-02-21	01:08:00	0101000020E610000005C24EB16A50F1BFADF6B0170AF24640	10	3.8700000000000001	0	t	0.0051080129999999998	0.10000000000000001	\N	0	5	0	2018-02-21 02:08:00+01
44	2018-02-21	01:39:00	0101000020E6100000164B917C2550F1BFADF6B0170AF24640	11	3.8300000000000001	0	t	0.014659436	0.10000000000000001	\N	0	5	0	2018-02-21 02:39:00+01
45	2018-02-21	02:09:00	0101000020E610000037894160E550F1BF5A68E7340BF24640	10	3.8300000000000001	0	t	0.019163296	0.20000000000000001	\N	0	5	0	2018-02-21 03:09:00+01
46	2018-02-21	02:39:00	0101000020E6100000DBFCBFEAC851F1BFE78C28ED0DF24640	11	3.8500000000000001	0	t	0.022838994000000001	0.20000000000000001	\N	0	5	0	2018-02-21 03:39:00+01
47	2018-02-21	03:09:00	0101000020E6100000E71A66683C51F1BFD80E46EC13F24640	12	3.8500000000000001	0	t	0.044555715000000003	0.10000000000000001	\N	0	5	0	2018-02-21 04:09:00+01
48	2018-02-21	03:41:00	0101000020E61000006A50340F6051F1BF4A99D4D006F24640	10	3.8500000000000001	0	t	0.068860230999999994	0	\N	0	5	0	2018-02-21 04:41:00+01
49	2018-02-21	04:12:00	0101000020E6100000D06394675E4EF1BF26E0D74812F24640	13	3.8199999999999998	0	t	0.057885470000000001	0.59999999999999998	\N	0	5	0	2018-02-21 05:12:00+01
50	2018-02-21	04:42:00	0101000020E61000006A50340F6051F1BFC382FB010FF24640	10	3.8399999999999999	0	t	0.015021392	0	\N	0	5	0	2018-02-21 05:42:00+01
51	2018-02-21	05:12:00	0101000020E6100000E71A66683C51F1BF832F4CA60AF24640	10	3.8300000000000001	0	t	0.010560032	0.10000000000000001	\N	0	5	0	2018-02-21 06:12:00+01
52	2018-02-21	05:43:00	0101000020E6100000C0CDE2C5C250F1BF355EBA490CF24640	12	3.8100000000000001	0	t	0.0065015089999999999	0.10000000000000001	\N	0	5	0	2018-02-21 06:43:00+01
53	2018-02-21	06:13:00	0101000020E610000005C24EB16A50F1BF355EBA490CF24640	12	3.8300000000000001	0	t	0.21535142700000001	0.20000000000000001	\N	0	5	0	2018-02-21 07:13:00+01
54	2018-02-21	06:43:00	0101000020E610000006F357C85C59F1BF8BFD65F7E4F14640	12	3.7999999999999998	0	t	0.109202089	0	\N	0	5	0	2018-02-21 07:43:00+01
55	2018-02-21	07:14:00	0101000020E6100000696FF085C954F1BF36CD3B4ED1F14640	12	3.7799999999999998	0	t	0.061771662999999997	0.40000000000000002	\N	0	5	0	2018-02-21 08:14:00+01
56	2018-02-21	07:44:00	0101000020E61000009FCDAACFD556F1BFA038807EDFF14640	12	3.8100000000000001	0	t	0.020502067999999998	0.10000000000000001	\N	0	5	0	2018-02-21 08:44:00+01
57	2018-02-21	08:15:00	0101000020E610000060E811A3E756F1BF61360186E5F14640	13	3.8199999999999998	0	t	0.018302579999999999	9.5	\N	0	5	0	2018-02-21 09:15:00+01
58	2018-02-21	08:45:00	0101000020E6100000F8E12021CA57F1BFD9CEF753E3F14640	13	3.8599999999999999	0	t	0.69776297099999995	0	\N	0	5	0	2018-02-21 09:45:00+01
59	2018-02-21	09:15:00	0101000020E6100000B6813B50A77CF1BF274F594DD7F14640	11	3.9199999999999999	0	t	0.012236713999999999	0.10000000000000001	\N	0	5	0	2018-02-21 10:15:00+01
60	2018-02-21	09:46:00	0101000020E6100000C80A7E1B627CF1BFC3F17C06D4F14640	12	3.9300000000000002	0	t	0.019214022000000001	0	\N	0	5	0	2018-02-21 10:46:00+01
61	2018-02-21	10:16:00	0101000020E61000009C525E2BA17BF1BF5AD76839D0F14640	12	3.9700000000000002	0	t	0.102721879	0.10000000000000001	\N	0	5	0	2018-02-21 11:16:00+01
62	2018-02-21	10:46:00	0101000020E61000008104C58F3177F1BFBC92E4B9BEF14640	12	4.0099999999999998	0	t	0.139452876	0.10000000000000001	\N	0	5	0	2018-02-21 11:46:00+01
63	2018-02-21	11:18:00	0101000020E610000039B709F7CA7CF1BFAEB6627FD9F14640	8	4.0099999999999998	0	t	0.0067704239999999997	0.10000000000000001	\N	0	5	0	2018-02-21 12:18:00+01
64	2018-02-21	11:51:00	0101000020E61000007EAB75E2727CF1BFD87DC7F0D8F14640	8	4.0199999999999996	0	t	0.004001948	0	\N	0	5	0	2018-02-21 12:51:00+01
65	2018-02-21	12:22:00	0101000020E61000003FC6DCB5847CF1BF85EFFD0DDAF14640	8	4.04	0	t	0.002302059	0.10000000000000001	\N	0	5	0	2018-02-21 13:22:00+01
66	2018-02-21	12:55:00	0101000020E61000007EAB75E2727CF1BFAEB6627FD9F14640	8	4.0099999999999998	0	t	0.0083962740000000004	0	\N	0	5	0	2018-02-21 13:55:00+01
67	2018-02-21	13:26:00	0101000020E6100000B6813B50A77CF1BF361E6CB1DBF14640	8	4.0700000000000003	0	t	0.0053333019999999998	0.10000000000000001	\N	0	5	0	2018-02-21 14:26:00+01
68	2018-02-21	14:00:00	0101000020E6100000EF5701BEDB7CF1BF12143FC6DCF14640	9	4.0599999999999996	0	t	0.0085652479999999993	0	\N	0	5	0	2018-02-21 15:00:00+01
69	2018-02-21	14:33:00	0101000020E610000060048D99447DF1BFEE0912DBDDF14640	8	4.0199999999999996	0	t	0.0039782309999999996	0	\N	0	5	0	2018-02-21 15:33:00+01
70	2018-02-21	15:03:00	0101000020E6100000AA6395D2337DF1BF9A7B48F8DEF14640	9	4.0700000000000003	0	t	0.91577021400000003	0.10000000000000001	\N	0	5	0	2018-02-21 16:03:00+01
71	2018-02-21	15:35:00	0101000020E6100000B534B742584DF1BFA839799109F24640	9	4.04	0	t	0.030763723999999999	0	\N	0	5	0	2018-02-21 16:35:00+01
72	2018-02-21	16:12:00	0101000020E61000008B6F287CB64EF1BFBDC5C37B0EF24640	9	4.0099999999999998	0	t	0.058168849000000002	0.59999999999999998	\N	0	5	0	2018-02-21 17:12:00+01
73	2018-02-21	16:42:00	0101000020E61000003BE2900DA44BF1BF11548D5E0DF24640	10	4.0300000000000002	0	t	0.19268675800000001	0.10000000000000001	\N	0	5	0	2018-02-21 17:42:00+01
74	2018-02-21	17:12:00	0101000020E6100000BD55D7A19A52F1BFAF0793E2E3F14640	10	4.0199999999999996	0	t	0.017443828000000001	0	\N	0	5	0	2018-02-21 18:12:00+01
75	2018-02-21	17:42:00	0101000020E6100000ABCC94D6DF52F1BFC493DDCCE8F14640	10	3.9900000000000002	0	t	0.013076282	0	\N	0	5	0	2018-02-21 18:42:00+01
76	2018-02-21	18:13:00	0101000020E61000006DE7FBA9F152F1BF8BFD65F7E4F14640	11	3.98	0	t	0.0095762380000000008	0.20000000000000001	\N	0	5	0	2018-02-21 19:13:00+01
77	2018-02-21	18:43:00	0101000020E6100000F52B9D0FCF52F1BFFDD8243FE2F14640	12	3.9700000000000002	0	t	0.0053333019999999998	0.10000000000000001	\N	0	5	0	2018-02-21 19:43:00+01
78	2018-02-21	19:14:00	0101000020E61000002E02637D0353F1BFD9CEF753E3F14640	15	3.96	0	t	0.020988217	0.40000000000000002	\N	0	5	0	2018-02-21 20:14:00+01
79	2018-02-21	19:44:00	0101000020E610000052B81E85EB51F1BFB5C4CA68E4F14640	10	3.98	0	t	0.0042583530000000003	0.20000000000000001	\N	0	5	0	2018-02-21 20:44:00+01
80	2018-02-21	20:15:00	0101000020E61000008A8EE4F21F52F1BFAF0793E2E3F14640	11	3.96	0	t	0.011197537	0.10000000000000001	\N	0	5	0	2018-02-21 21:15:00+01
81	2018-02-21	20:45:00	0101000020E6100000C9737D1F0E52F1BF4CAAB69BE0F14640	11	3.9500000000000002	0	t	0.099169995999999996	0	\N	0	5	0	2018-02-21 21:45:00+01
82	2018-02-21	21:16:00	0101000020E6100000107A36AB3E57F1BF8BFD65F7E4F14640	11	3.9399999999999999	0	t	0.019649084000000001	0.10000000000000001	\N	0	5	0	2018-02-21 22:16:00+01
83	2018-02-21	21:46:00	0101000020E6100000BF0B5BB39557F1BF76C24B70EAF14640	12	3.9300000000000002	0	t	0.024621026000000001	0	\N	0	5	0	2018-02-21 22:46:00+01
84	2018-02-21	22:16:00	0101000020E6100000249A40118B58F1BF8B4E965AEFF14640	13	3.9300000000000002	0	t	0.72209836500000002	0.10000000000000001	\N	0	5	0	2018-02-21 23:16:00+01
85	2018-02-21	22:47:00	0101000020E61000005D4E09884978F1BF902DCBD765F24640	13	3.9100000000000001	0	t	0.010559605	0.29999999999999999	\N	0	5	0	2018-02-21 23:47:00+01
86	2018-02-21	23:17:00	0101000020E6100000849B8C2AC378F1BF425C397B67F24640	12	3.9300000000000002	0	t	0.0085647210000000008	0.20000000000000001	\N	0	5	0	2018-02-22 00:17:00+01
87	2018-02-21	23:47:00	0101000020E610000013EF004F5A78F1BF6666666666F24640	13	3.9300000000000002	0	t	0.023169658999999999	0.10000000000000001	\N	0	5	0	2018-02-22 00:47:00+01
88	2018-02-22	00:17:00	0101000020E6100000CEFA9463B278F1BF2D211FF46CF24640	13	3.9100000000000001	0	t	0.083693690000000001	0.10000000000000001	\N	0	5	0	2018-02-22 01:17:00+01
89	2018-02-22	00:48:00	0101000020E61000006DE4BA29E575F1BFAE2990D959F24640	12	3.9100000000000001	0	t	0.035979852	0.10000000000000001	\N	0	5	0	2018-02-22 01:48:00+01
90	2018-02-22	01:18:00	0101000020E6100000FC372F4E7C75F1BFDFFE5C3464F24640	14	3.8999999999999999	0	t	0.036019158000000003	0	\N	0	5	0	2018-02-22 02:18:00+01
91	2018-02-22	01:48:00	0101000020E6100000431F2C634377F1BF1895D40968F24640	13	3.9100000000000001	0	t	0.020713307	0	\N	0	5	0	2018-02-22 02:48:00+01
92	2018-02-22	02:18:00	0101000020E61000007BF5F1D07777F1BF2713B70A62F24640	12	3.8999999999999999	0	t	0.016725055999999999	0	\N	0	5	0	2018-02-22 03:18:00+01
93	2018-02-22	02:49:00	0101000020E61000003196E9978877F1BF3C9F01F566F24640	13	3.8799999999999999	0	t	0.019539843000000001	0.29999999999999999	\N	0	5	0	2018-02-22 03:49:00+01
94	2018-02-22	03:19:00	0101000020E61000009624CFF57D78F1BFF48AA71E69F24640	12	3.8799999999999999	0	t	0.0042583530000000003	0.10000000000000001	\N	0	5	0	2018-02-22 04:19:00+01
95	2018-02-22	03:49:00	0101000020E6100000CEFA9463B278F1BFEECD6F9868F24640	11	3.8799999999999999	0	t	0.020559575	0	\N	0	5	0	2018-02-22 04:49:00+01
96	2018-02-22	04:19:00	0101000020E61000009C33A2B43778F1BF0917F2086EF24640	12	3.8799999999999999	0	t	0.020147990000000001	0.10000000000000001	\N	0	5	0	2018-02-22 05:19:00+01
97	2018-02-22	04:50:00	0101000020E61000007E8CB96B0979F1BFA0FCDD3B6AF24640	11	3.8599999999999999	0	t	0.82058545000000005	0	\N	0	5	0	2018-02-22 05:50:00+01
98	2018-02-22	05:20:00	0101000020E610000063601DC70F55F1BF03965CC5E2F14640	13	3.8599999999999999	0	t	0.039744002	0	\N	0	5	0	2018-02-22 06:20:00+01
99	2018-02-22	05:50:00	0101000020E6100000166A4DF38E53F1BF8AAC3594DAF14640	13	3.8799999999999999	0	t	0.033384440000000001	0.20000000000000001	\N	0	5	0	2018-02-22 06:50:00+01
100	2018-02-22	06:21:00	0101000020E6100000554FE61F7D53F1BFB5C4CA68E4F14640	12	3.8599999999999999	0	t	0.051444420999999997	0.10000000000000001	\N	0	5	0	2018-02-22 07:21:00+01
101	2018-02-22	06:51:00	0101000020E61000002B8A5759DB54F1BF433A3C84F1F14640	13	3.8500000000000001	0	t	0.078067934000000005	0	\N	0	5	0	2018-02-22 07:51:00+01
102	2018-02-22	07:21:00	0101000020E6100000C9737D1F0E52F1BF4CAAB69BE0F14640	12	3.8399999999999999	0	t	0.12483446600000001	0.10000000000000001	\N	0	5	0	2018-02-22 08:21:00+01
103	2018-02-22	07:52:00	0101000020E6100000637FD93D7958F1BFCA501553E9F14640	13	3.8799999999999999	0	t	0.037303652999999999	0.10000000000000001	\N	0	5	0	2018-02-22 08:52:00+01
104	2018-02-22	08:22:00	0101000020E6100000A5DC7D8E8F56F1BF3D2CD49AE6F14640	13	3.9399999999999999	0	t	0.024272266000000001	0.20000000000000001	\N	0	5	0	2018-02-22 09:22:00+01
105	2018-02-22	08:53:00	0101000020E610000027124C35B356F1BFA038807EDFF14640	14	4	0	t	0.027351417999999999	0	\N	0	5	0	2018-02-22 09:53:00+01
106	2018-02-22	09:23:00	0101000020E61000009C36E3344455F1BF4CAAB69BE0F14640	11	4.0300000000000002	0	t	0.64742845500000001	0.10000000000000001	\N	0	5	0	2018-02-22 10:23:00+01
107	2018-02-22	09:53:00	0101000020E61000007BF5F1D07777F1BF28F1B913ECF14640	12	4.0499999999999998	0	t	0.10297574499999999	0.20000000000000001	\N	0	5	0	2018-02-22 10:53:00+01
108	2018-02-22	10:23:00	0101000020E6100000C80A7E1B627CF1BFB6662B2FF9F14640	11	4.0599999999999996	0	t	0.015908108000000001	0.10000000000000001	\N	0	5	0	2018-02-22 11:23:00+01
109	2018-02-22	10:56:00	0101000020E6100000AA6395D2337DF1BF925CFE43FAF14640	9	4.0499999999999998	0	t	0.009312374	0.20000000000000001	\N	0	5	0	2018-02-22 11:56:00+01
110	2018-02-22	11:28:00	0101000020E610000060048D99447DF1BF1F813FFCFCF14640	8	4.0199999999999996	0	t	0.0012450650000000001	0	\N	0	5	0	2018-02-22 12:28:00+01
111	2018-02-22	11:59:00	0101000020E6100000AA6395D2337DF1BF1F813FFCFCF14640	9	4.0899999999999999	0	t	0.014900306	0.10000000000000001	\N	0	5	0	2018-02-22 12:59:00+01
112	2018-02-22	12:32:00	0101000020E610000054E6E61BD17DF1BF7D21E4BCFFF14640	9	4.0499999999999998	0	t	0.019156474999999999	0.10000000000000001	\N	0	5	0	2018-02-22 13:32:00+01
113	2018-02-22	13:04:00	0101000020E6100000742497FF907EF1BFE63BF88903F24640	8	4.0300000000000002	0	t	0.013899513	0.10000000000000001	\N	0	5	0	2018-02-22 14:04:00+01
114	2018-02-22	13:34:00	0101000020E61000005D8C81751C7FF1BF44DC9C4A06F24640	9	4.0899999999999999	0	t	0.014069655	0	\N	0	5	0	2018-02-22 14:34:00+01
115	2018-02-22	14:08:00	0101000020E6100000C7293A92CB7FF1BFF60A0BEE07F24640	9	4.0499999999999998	0	t	0.016075211999999998	0	\N	0	5	0	2018-02-22 15:08:00+01
116	2018-02-22	14:38:00	0101000020E610000071AC8BDB6880F1BF5A68E7340BF24640	11	4.0700000000000003	0	t	0.026555763	0	\N	0	5	0	2018-02-22 15:38:00+01
117	2018-02-22	15:11:00	0101000020E61000004DF6CFD38081F1BF6FF4311F10F24640	9	4.0300000000000002	0	t	0.93200992000000005	0	\N	0	5	0	2018-02-22 16:11:00+01
118	2018-02-22	15:41:00	0101000020E610000020F12BD67051F1BF11C30E63D2F14640	11	4.0899999999999999	0	t	0.20803553799999999	0	\N	0	5	0	2018-02-22 16:41:00+01
119	2018-02-22	16:14:00	0101000020E6100000917EFB3A704EF1BF11548D5E0DF24640	10	4.0300000000000002	0	t	0.010465298	0	\N	0	5	0	2018-02-22 17:14:00+01
120	2018-02-22	16:44:00	0101000020E6100000A91611C5E44DF1BFE78C28ED0DF24640	11	4.04	0	t	0.027592058999999999	0	\N	0	5	0	2018-02-22 17:44:00+01
121	2018-02-22	17:14:00	0101000020E61000000CB265F9BA4CF1BFD200DE0209F24640	11	4.0099999999999998	0	t	0.036219527000000001	0	\N	0	5	0	2018-02-22 18:14:00+01
122	2018-02-22	17:45:00	0101000020E61000005FB7088CF54DF1BF4BEA043411F24640	10	4.0099999999999998	0	t	0.031452967999999998	0.20000000000000001	\N	0	5	0	2018-02-22 18:45:00+01
123	2018-02-22	18:15:00	0101000020E6100000236937FA984FF1BFFC1873D712F24640	11	3.98	0	t	0	0	\N	0	5	0	2018-02-22 19:15:00+01
124	2018-02-22	18:45:00	0101000020E6100000236937FA984FF1BFFC1873D712F24640	18	3.98	0	t	0.023506408999999999	0	\N	0	5	0	2018-02-22 19:45:00+01
125	2018-02-22	19:16:00	0101000020E6100000D06394675E4EF1BF2123A0C211F24640	11	3.98	0	t	0.012875551000000001	0.20000000000000001	\N	0	5	0	2018-02-22 20:16:00+01
126	2018-02-22	19:46:00	0101000020E6100000A91611C5E44DF1BFAE47E17A14F24640	10	3.9700000000000002	0	t	0.013273299000000001	0.10000000000000001	\N	0	5	0	2018-02-22 20:46:00+01
127	2018-02-22	20:17:00	0101000020E610000026E1421EC14DF1BF75B169A510F24640	12	3.96	0	t	0.01066576	0	\N	0	5	0	2018-02-22 21:17:00+01
128	2018-02-22	20:47:00	0101000020E6100000B534B742584DF1BFBDC5C37B0EF24640	11	3.96	0	t	0.028066669999999998	0.10000000000000001	\N	0	5	0	2018-02-22 21:47:00+01
129	2018-02-22	21:17:00	0101000020E61000007D5EF1D4234DF1BF44DC9C4A06F24640	12	3.9399999999999999	0	t	0.65197241500000003	0	\N	0	5	0	2018-02-22 22:17:00+01
130	2018-02-22	21:48:00	0101000020E61000003E0796236460F1BFA54A94BDA5F24640	12	3.9399999999999999	0	t	0.072514226000000001	0.20000000000000001	\N	0	5	0	2018-02-22 22:48:00+01
131	2018-02-22	22:18:00	0101000020E6100000C3D32B651962F1BFF5BD86E0B8F24640	12	3.9300000000000002	0	t	0.078761518000000003	0.29999999999999999	\N	0	5	0	2018-02-22 23:18:00+01
132	2018-02-22	22:48:00	0101000020E6100000349F73B7EB65F1BF499D8026C2F24640	13	3.9199999999999999	0	t	0.076426923999999993	0.10000000000000001	\N	0	5	0	2018-02-22 23:48:00+01
133	2018-02-22	23:18:00	0101000020E61000002DAF5C6F9B69F1BF9E7C7A6CCBF24640	12	3.9300000000000002	0	t	0.054589365000000001	0.20000000000000001	\N	0	5	0	2018-02-23 00:18:00+01
134	2018-02-22	23:49:00	0101000020E610000024287E8CB96BF1BF7506465ED6F24640	12	3.9300000000000002	0	t	0.038538820000000001	0	\N	0	5	0	2018-02-23 00:49:00+01
135	2018-02-23	00:19:00	0101000020E61000000C906802456CF1BF9E7C7A6CCBF24640	12	3.9199999999999999	0	t	0.039741281000000003	0	\N	0	5	0	2018-02-23 01:19:00+01
136	2018-02-23	00:49:00	0101000020E6100000598638D6C56DF1BF1766A19DD3F24640	12	3.9199999999999999	0	t	0.031656615999999999	0.20000000000000001	\N	0	5	0	2018-02-23 01:49:00+01
137	2018-02-23	01:19:00	0101000020E61000000072C284D16CF1BF8A929048DBF24640	13	3.9100000000000001	0	t	0.043798212000000003	0.10000000000000001	\N	0	5	0	2018-02-23 02:19:00+01
138	2018-02-23	01:50:00	0101000020E6100000537765170C6EF1BFB308C556D0F24640	12	3.9100000000000001	0	t	0.020661899000000001	0	\N	0	5	0	2018-02-23 02:50:00+01
139	2018-02-23	02:20:00	0101000020E6100000772D211FF46CF1BFB308C556D0F24640	12	3.9199999999999999	0	t	0.037936601	0	\N	0	5	0	2018-02-23 03:20:00+01
140	2018-02-23	02:50:00	0101000020E6100000E8D9ACFA5C6DF1BF8A929048DBF24640	12	3.9100000000000001	0	t	0.022376351999999999	0	\N	0	5	0	2018-02-23 03:50:00+01
141	2018-02-23	03:20:00	0101000020E61000008C4D2B85406EF1BFC9E53FA4DFF24640	12	3.8900000000000001	0	t	0.0093114059999999995	0.29999999999999999	\N	0	5	0	2018-02-23 04:20:00+01
142	2018-02-23	03:51:00	0101000020E610000042EE224C516EF1BF3CC1FEEBDCF24640	11	3.8999999999999999	0	t	0.030179273	0.10000000000000001	\N	0	5	0	2018-02-23 04:51:00+01
143	2018-02-23	04:21:00	0101000020E610000024473A03236FF1BFDE718A8EE4F24640	14	3.8900000000000001	0	t	0.026776129999999999	0.20000000000000001	\N	0	5	0	2018-02-23 05:21:00+01
144	2018-02-23	04:51:00	0101000020E61000007AC4E8B9856EF1BF417E3672DDF24640	12	3.8799999999999999	0	t	0.017122075	0	\N	0	5	0	2018-02-23 05:51:00+01
145	2018-02-23	05:21:00	0101000020E6100000B39AAE27BA6EF1BF570A815CE2F24640	13	3.8900000000000001	0	t	0.88810679000000003	0.29999999999999999	\N	0	5	0	2018-02-23 06:21:00+01
146	2018-02-23	05:52:00	0101000020E6100000A226FA7C9451F1BF84807C0915F24640	13	3.8799999999999999	0	t	0.013573424000000001	0	\N	0	5	0	2018-02-23 06:52:00+01
147	2018-02-23	06:22:00	0101000020E6100000DBFCBFEAC851F1BF4BEA043411F24640	11	3.8999999999999999	0	t	0.023295157	0.20000000000000001	\N	0	5	0	2018-02-23 07:22:00+01
148	2018-02-23	06:53:00	0101000020E610000088F71C588E50F1BF2123A0C211F24640	13	3.8799999999999999	0	t	0.016020172999999999	0.20000000000000001	\N	0	5	0	2018-02-23 07:53:00+01
149	2018-02-23	07:23:00	0101000020E61000005B3FFD67CD4FF1BFD80E46EC13F24640	13	3.8599999999999999	0	t	0.003175724	0.20000000000000001	\N	0	5	0	2018-02-23 08:23:00+01
150	2018-02-23	07:54:00	0101000020E6100000DE74CB0EF14FF1BFD2510E6613F24640	13	3.8599999999999999	0	t	0.010521984	0.10000000000000001	\N	0	5	0	2018-02-23 08:54:00+01
151	2018-02-23	08:24:00	0101000020E6100000EA92718C644FF1BFD80E46EC13F24640	13	3.9100000000000001	0	t	0.022171203	0	\N	0	5	0	2018-02-23 09:24:00+01
152	2018-02-23	08:54:00	0101000020E6100000917EFB3A704EF1BF6FF4311F10F24640	11	3.9399999999999999	0	t	0.019649313000000002	0	\N	0	5	0	2018-02-23 09:54:00+01
153	2018-02-23	09:25:00	0101000020E6100000E1ECD632194EF1BF832F4CA60AF24640	11	3.9700000000000002	0	t	0.30591697400000001	0.10000000000000001	\N	0	5	0	2018-02-23 10:25:00+01
154	2018-02-23	09:55:00	0101000020E610000059F8FA5A975AF1BFD1915CFE43F24640	13	4.0199999999999996	0	t	0.55406548200000005	0	\N	0	5	0	2018-02-23 10:55:00+01
155	2018-02-23	10:26:00	0101000020E61000009C36E3344455F1BFDE718A8EE4F24640	12	4.0700000000000003	0	t	0.064528493000000006	0.10000000000000001	\N	0	5	0	2018-02-23 11:26:00+01
156	2018-02-23	10:57:00	0101000020E61000006C06B8205B56F1BF82734694F6F24640	9	4.0700000000000003	0	t	0.091014683999999998	0	\N	0	5	0	2018-02-23 11:57:00+01
157	2018-02-23	11:30:00	0101000020E6100000F56915FDA159F1BFD7A3703D0AF34640	10	4.0499999999999998	0	t	0.29970236099999997	0.10000000000000001	\N	0	5	0	2018-02-23 12:30:00+01
158	2018-02-23	12:02:00	0101000020E610000063EE5A423E68F1BF6C787AA52CF34640	9	4.0700000000000003	0	t	0.48163811099999998	0.10000000000000001	\N	0	5	0	2018-02-23 13:02:00+01
159	2018-02-23	12:35:00	0101000020E6100000DC4944F81781F1BF65C8B1F50CF34640	9	4.0300000000000002	0	t	0.0044710389999999996	0	\N	0	5	0	2018-02-23 13:35:00+01
160	2018-02-23	13:05:00	0101000020E61000005305A3923A81F1BF89D2DEE00BF34640	11	4.0899999999999999	0	t	0.015850499000000001	0.10000000000000001	\N	0	5	0	2018-02-23 14:05:00+01
161	2018-02-23	13:38:00	0101000020E6100000213EB0E3BF80F1BF4F3C670B08F34640	9	4.0599999999999996	0	t	0.026130325999999999	0.10000000000000001	\N	0	5	0	2018-02-23 14:38:00+01
162	2018-02-23	14:08:00	0101000020E610000039D6C56D3480F1BF82C476F700F34640	9	4.0499999999999998	0	t	0.0055176929999999997	0.10000000000000001	\N	0	5	0	2018-02-23 15:08:00+01
163	2018-02-23	14:42:00	0101000020E61000003FE5982CEE7FF1BFAC8BDB6800F34640	10	3.9900000000000002	0	t	0.0038702879999999999	0.10000000000000001	\N	0	5	0	2018-02-23 15:42:00+01
164	2018-02-23	15:12:00	0101000020E61000008944A165DD7FF1BFD1950854FFF24640	9	4.0300000000000002	0	t	0.032834439999999999	0	\N	0	5	0	2018-02-23 16:12:00+01
165	2018-02-23	15:43:00	0101000020E61000005305A3923A81F1BFC217265305F34640	11	4.0199999999999996	0	t	0.017048487000000001	0	\N	0	5	0	2018-02-23 16:43:00+01
166	2018-02-23	16:13:00	0101000020E6100000BEA25BAFE981F1BF2575029A08F34640	11	4.0099999999999998	0	t	0.020517888000000001	0	\N	0	5	0	2018-02-23 17:13:00+01
167	2018-02-23	16:43:00	0101000020E61000003B6D8D08C681F1BF34F3E49A02F34640	11	4.0099999999999998	0	t	0.0076019410000000001	0.29999999999999999	\N	0	5	0	2018-02-23 17:43:00+01
168	2018-02-23	17:13:00	0101000020E6100000355EBA490C82F1BFE621533E04F34640	11	4.0099999999999998	0	t	0.015137342999999999	0.10000000000000001	\N	0	5	0	2018-02-23 18:13:00+01
169	2018-02-23	17:44:00	0101000020E6100000C4B12E6EA381F1BFAC8BDB6800F34640	10	4	0	t	0.28513664599999999	0.10000000000000001	\N	0	5	0	2018-02-23 18:44:00+01
170	2018-02-23	18:14:00	0101000020E6100000492EFF21FD76F1BFD7C1C1DEC4F24640	11	3.98	0	t	0.22591204100000001	0.10000000000000001	\N	0	5	0	2018-02-23 19:14:00+01
171	2018-02-23	18:44:00	0101000020E61000002A37514B736BF1BF09F9A067B3F24640	11	3.98	0	t	0.088919665999999994	0.20000000000000001	\N	0	5	0	2018-02-23 19:44:00+01
172	2018-02-23	19:14:00	0101000020E610000042B0AA5E7E67F1BFA08D5C37A5F24640	10	3.9700000000000002	0	t	0.026900047	0.10000000000000001	\N	0	5	0	2018-02-23 20:14:00+01
173	2018-02-23	19:44:00	0101000020E61000006D7539252066F1BF18265305A3F24640	11	3.98	0	t	0.074780817999999999	0	\N	0	5	0	2018-02-23 20:44:00+01
174	2018-02-23	20:15:00	0101000020E610000085EE92382B62F1BFEE5EEE93A3F24640	13	3.9700000000000002	0	t	0.073238752000000004	0.20000000000000001	\N	0	5	0	2018-02-23 21:15:00+01
175	2018-02-23	20:45:00	0101000020E61000000531D0B52F60F1BF971DE21FB6F24640	12	3.9700000000000002	0	t	0.076566480000000006	0.20000000000000001	\N	0	5	0	2018-02-23 21:45:00+01
176	2018-02-23	21:15:00	0101000020E61000008F56B5A4A35CF1BF910F7A36ABF24640	12	3.98	0	t	0.041361949000000002	0.10000000000000001	\N	0	5	0	2018-02-23 22:15:00+01
177	2018-02-23	21:45:00	0101000020E610000098FC4FFEEE5DF1BFBB270F0BB5F24640	12	3.9700000000000002	0	t	0.057239765999999997	0.20000000000000001	\N	0	5	0	2018-02-23 22:45:00+01
178	2018-02-23	22:16:00	0101000020E61000005CAE7E6C925FF1BF51BCCADAA6F24640	12	3.98	0	t	0.078117963999999998	0.20000000000000001	\N	0	5	0	2018-02-23 23:16:00+01
179	2018-02-23	22:46:00	0101000020E61000005917B7D1005EF1BF581B6327BCF24640	14	3.98	0	t	0.012269079	0.10000000000000001	\N	0	5	0	2018-02-23 23:46:00+01
180	2018-02-23	23:16:00	0101000020E61000005F268A90BA5DF1BFBC783F6EBFF24640	12	3.9700000000000002	0	t	0.0057134960000000002	0.10000000000000001	\N	0	5	0	2018-02-24 00:16:00+01
181	2018-02-23	23:46:00	0101000020E61000002041F163CC5DF1BF0A4AD1CABDF24640	11	3.96	0	t	0.26892450400000001	0.20000000000000001	\N	0	5	0	2018-02-24 00:46:00+01
182	2018-02-24	00:17:00	0101000020E6100000100874266D6AF1BF570A815CE2F24640	14	3.9399999999999999	0	t	0.022669865000000001	0.29999999999999999	\N	0	5	0	2018-02-24 01:17:00+01
183	2018-02-24	00:47:00	0101000020E6100000AD6C1FF2966BF1BFA5DB12B9E0F24640	18	3.9399999999999999	0	t	0.037251672	0.10000000000000001	\N	0	5	0	2018-02-24 01:47:00+01
184	2018-02-24	01:17:00	0101000020E61000005F950B957F6DF1BF037CB779E3F24640	12	3.9500000000000002	0	t	0.019057181999999999	0	\N	0	5	0	2018-02-24 02:17:00+01
185	2018-02-24	01:48:00	0101000020E610000042EE224C516EF1BF9F1EDB32E0F24640	14	3.9399999999999999	0	t	0.042005839000000003	0.20000000000000001	\N	0	5	0	2018-02-24 02:48:00+01
186	2018-02-24	02:18:00	0101000020E610000050FF59F3E36FF1BF50FC1873D7F24640	12	3.9300000000000002	0	t	0.047515093000000001	0.29999999999999999	\N	0	5	0	2018-02-24 03:18:00+01
187	2018-02-24	02:48:00	0101000020E6100000E8F86871C670F1BFDE718A8EE4F24640	13	3.9199999999999999	0	t	0.0067690930000000003	0	\N	0	5	0	2018-02-24 03:48:00+01
188	2018-02-24	03:18:00	0101000020E6100000A304FD851E71F1BF0839EFFFE3F24640	12	3.9199999999999999	0	t	0.046935208999999999	0.10000000000000001	\N	0	5	0	2018-02-24 04:18:00+01
189	2018-02-24	03:49:00	0101000020E6100000A67C08AA466FF1BFB459F5B9DAF24640	13	3.9100000000000001	0	t	0.077392824999999998	0.10000000000000001	\N	0	5	0	2018-02-24 04:49:00+01
190	2018-02-24	04:19:00	0101000020E61000006DC5FEB27B72F1BF1EC539EAE8F24640	27	3.8799999999999999	0	t	0.015776406999999999	0	\N	0	5	0	2018-02-24 05:19:00+01
191	2018-02-24	04:49:00	0101000020E610000074D4D1713572F1BF2D944C4EEDF24640	15	3.8999999999999999	0	t	0.084504148000000001	0	\N	0	5	0	2018-02-24 05:49:00+01
192	2018-02-24	05:20:00	0101000020E6100000E2E995B20C71F1BFC8940F41D5F24640	33	3.8900000000000001	0	t	0.92981161899999998	0	\N	0	5	0	2018-02-24 06:20:00+01
193	2018-02-24	05:50:00	0101000020E6100000236937FA984FF1BF355EBA490CF24640	10	3.8300000000000001	0	t	0	0.10000000000000001	\N	0	5	0	2018-02-24 06:50:00+01
194	2018-02-24	06:21:00	0101000020E6100000236937FA984FF1BF355EBA490CF24640	11	3.8599999999999999	0	t	0.046386944999999999	0.10000000000000001	\N	0	5	0	2018-02-24 07:21:00+01
195	2018-02-24	06:52:00	0101000020E6100000E4839ECDAA4FF1BF990CC7F319F24640	11	3.8700000000000001	0	t	0.017466546999999999	0.10000000000000001	\N	0	5	0	2018-02-24 07:52:00+01
196	2018-02-24	07:22:00	0101000020E6100000DE74CB0EF14FF1BF84807C0915F24640	10	3.8700000000000001	0	t	0.028639636999999999	0.29999999999999999	\N	0	5	0	2018-02-24 08:22:00+01
197	2018-02-24	07:52:00	0101000020E6100000917EFB3A704EF1BF60764F1E16F24640	11	3.8900000000000001	0	t	0.017690601	0.29999999999999999	\N	0	5	0	2018-02-24 08:52:00+01
198	2018-02-24	08:23:00	0101000020E6100000EE0A7DB08C4DF1BF12A5BDC117F24640	11	3.9100000000000001	0	t	0.019163296	0.20000000000000001	\N	0	5	0	2018-02-24 09:23:00+01
199	2018-02-24	08:53:00	0101000020E6100000917EFB3A704EF1BF84807C0915F24640	11	3.9100000000000001	0	t	0.051856576000000001	0.10000000000000001	\N	0	5	0	2018-02-24 09:53:00+01
200	2018-02-24	09:23:00	0101000020E61000003E7958A8354DF1BF20D26F5F07F24640	12	3.9399999999999999	0	t	0.0043067569999999996	0.29999999999999999	\N	0	5	0	2018-02-24 10:23:00+01
201	2018-02-24	09:54:00	0101000020E6100000764F1E166A4DF1BFF60A0BEE07F24640	12	4.0199999999999996	0	t	0.030158958	0.10000000000000001	\N	0	5	0	2018-02-24 10:54:00+01
202	2018-02-24	10:24:00	0101000020E610000073B8567BD84BF1BF44DC9C4A06F24640	12	4.04	0	t	0.20517439800000001	0.10000000000000001	\N	0	5	0	2018-02-24 11:24:00+01
203	2018-02-24	10:54:00	0101000020E6100000105B7A34D553F1BFE84CDA54DDF14640	10	4.0499999999999998	0	t	2.1924934029999998	0.10000000000000001	\N	0	5	0	2018-02-24 11:54:00+01
204	2018-02-24	11:27:00	0101000020E6100000D9EDB3CA4CA9F1BF8656276728F04640	9	3.9900000000000002	0	t	0.31319386500000002	0	\N	0	5	0	2018-02-24 12:27:00+01
205	2018-02-24	12:00:00	0101000020E610000036CAFACDC4B4F1BFE4141DC9E5EF4640	9	4.0499999999999998	0	t	0.211332136	0.10000000000000001	\N	0	5	0	2018-02-24 13:00:00+01
206	2018-02-24	12:33:00	0101000020E610000048533D997FB4F1BF4703780B24F04640	9	4.0300000000000002	0	t	0.42861075999999998	0	\N	0	5	0	2018-02-24 13:33:00+01
207	2018-02-24	13:03:00	0101000020E6100000C05E61C1FDC0F1BF8EE89E758DF04640	11	4.0899999999999999	0	t	0.46111779600000002	0	\N	0	5	0	2018-02-24 14:03:00+01
208	2018-02-24	13:36:00	0101000020E6100000164B917C25D0F1BFB1C398F4F7F04640	9	4.04	0	t	0.42881914700000001	0.20000000000000001	\N	0	5	0	2018-02-24 14:36:00+01
209	2018-02-24	14:06:00	0101000020E6100000C66AF3FFAAE3F1BFCB9D996038F14640	11	4.0800000000000001	0	t	1.2267210079999999	0.29999999999999999	\N	0	5	0	2018-02-24 15:06:00+01
210	2018-02-24	14:40:00	0101000020E6100000AEB6627FD9BDF1BFEE7C3F355EF24640	9	4.04	0	t	0.010625546	0.10000000000000001	\N	0	5	0	2018-02-24 15:40:00+01
211	2018-02-24	15:10:00	0101000020E61000007CEF6FD05EBDF1BF9FABADD85FF24640	11	4.0899999999999999	0	t	0.0044700310000000002	0	\N	0	5	0	2018-02-24 16:10:00+01
212	2018-02-24	15:44:00	0101000020E6100000053411363CBDF1BF7BA180ED60F24640	11	4.0499999999999998	0	t	0.048103163999999997	0.10000000000000001	\N	0	5	0	2018-02-24 16:44:00+01
213	2018-02-24	16:14:00	0101000020E6100000204432E4D8BAF1BF902DCBD765F24640	11	4.0300000000000002	0	t	0.057536587	0.20000000000000001	\N	0	5	0	2018-02-24 17:14:00+01
214	2018-02-24	16:44:00	0101000020E6100000D34D621058B9F1BFD0D1AA9674F24640	10	4.0499999999999998	0	t	0.079114431999999998	0.10000000000000001	\N	0	5	0	2018-02-24 17:44:00+01
215	2018-02-24	17:14:00	0101000020E6100000B20FB22C98B8F1BF895FB1868BF24640	11	4.0300000000000002	0	t	0.011000212000000001	0.20000000000000001	\N	0	5	0	2018-02-24 18:14:00+01
216	2018-02-24	17:45:00	0101000020E6100000BE2D58AA0BB8F1BFAD69DE718AF24640	12	4.0099999999999998	0	t	0.029476760000000001	0.40000000000000002	\N	0	5	0	2018-02-24 18:45:00+01
217	2018-02-24	18:15:00	0101000020E6100000A4FE7A8505B7F1BFE6AE25E483F24640	11	4	0	t	0.421920085	0.29999999999999999	\N	0	5	0	2018-02-24 19:15:00+01
218	2018-02-24	18:45:00	0101000020E6100000DC4603780BA4F1BF2063EE5A42F24640	12	3.9900000000000002	0	t	0.30927291600000001	0.10000000000000001	\N	0	5	0	2018-02-24 19:45:00+01
219	2018-02-24	19:15:00	0101000020E6100000A320787C7B97F1BFF60A0BEE07F24640	11	3.98	0	t	0.19625355799999999	0.20000000000000001	\N	0	5	0	2018-02-24 20:15:00+01
220	2018-02-24	19:46:00	0101000020E61000008FC2F5285C8FF1BFAF0793E2E3F14640	13	3.98	0	t	0.098570822000000002	0.5	\N	0	5	0	2018-02-24 20:46:00+01
221	2018-02-24	20:16:00	0101000020E61000002B155454FD8AF1BFC3F17C06D4F14640	12	3.98	0	t	0.019590284999999999	0	\N	0	5	0	2018-02-24 21:16:00+01
222	2018-02-24	20:46:00	0101000020E6100000CCF10A444F8AF1BF849ECDAACFF14640	12	3.98	0	t	0.098183846000000005	0.20000000000000001	\N	0	5	0	2018-02-24 21:46:00+01
223	2018-02-24	21:16:00	0101000020E6100000357D76C07585F1BF834D9D47C5F14640	11	3.98	0	t	0.030969284999999999	0.29999999999999999	\N	0	5	0	2018-02-24 22:16:00+01
224	2018-02-24	21:46:00	0101000020E6100000D8F0F44A5986F1BFF6798CF2CCF14640	12	3.9500000000000002	0	t	0.040053920999999999	0	\N	0	5	0	2018-02-24 22:46:00+01
225	2018-02-24	22:17:00	0101000020E6100000E277D32D3B84F1BFFC36C478CDF14640	12	3.98	0	t	0.096253811999999994	0.20000000000000001	\N	0	5	0	2018-02-24 23:17:00+01
226	2018-02-24	22:47:00	0101000020E6100000567DAEB6627FF1BF4B598638D6F14640	13	3.9700000000000002	0	t	1.0290203330000001	0.10000000000000001	\N	0	5	0	2018-02-24 23:47:00+01
227	2018-02-24	23:17:00	0101000020E6100000037B4CA4345BF1BFF5BD86E0B8F24640	12	3.96	0	t	0.214339222	0	\N	0	5	0	2018-02-25 00:17:00+01
228	2018-02-24	23:48:00	0101000020E610000045D8F0F44A59F1BF92CF2B9E7AF24640	13	3.96	0	t	0.007966084	0.10000000000000001	\N	0	5	0	2018-02-25 00:48:00+01
229	2018-02-25	00:18:00	0101000020E6100000D42B6519E258F1BFBC96900F7AF24640	12	3.96	0	t	0.015007886	0.29999999999999999	\N	0	5	0	2018-02-25 01:18:00+01
230	2018-02-25	00:48:00	0101000020E61000005D70067FBF58F1BF7C43E1B375F24640	13	3.9500000000000002	0	t	0.021899414999999998	0.10000000000000001	\N	0	5	0	2018-02-25 01:48:00+01
231	2018-02-25	01:19:00	0101000020E610000006F357C85C59F1BF917EFB3A70F24640	11	3.9500000000000002	0	t	0.59725738900000003	0.10000000000000001	\N	0	5	0	2018-02-25 02:19:00+01
232	2018-02-25	01:49:00	0101000020E61000009FABADD85F76F1BF971DE21FB6F24640	12	3.9399999999999999	0	t	0.36280959699999998	4.9000000000000004	\N	0	5	0	2018-02-25 02:49:00+01
233	2018-02-25	02:19:00	0101000020E6100000D862B7CF2A73F1BFDE02098A1FF34640	12	3.9399999999999999	0	t	0.15951395900000001	0.10000000000000001	\N	0	5	0	2018-02-25 03:19:00+01
234	2018-02-25	02:49:00	0101000020E6100000A2427573F177F1BFB22AC24D46F34640	13	3.9300000000000002	0	t	0.053832583000000003	0	\N	0	5	0	2018-02-25 03:49:00+01
235	2018-02-25	03:20:00	0101000020E6100000ECA17DACE077F1BF9E40D82956F34640	12	3.9300000000000002	0	t	0.030178824999999999	0.10000000000000001	\N	0	5	0	2018-02-25 04:20:00+01
236	2018-02-25	03:50:00	0101000020E6100000CEFA9463B278F1BF41F163CC5DF34640	13	3.9199999999999999	0	t	0.027186990000000001	0.29999999999999999	\N	0	5	0	2018-02-25 04:50:00+01
237	2018-02-25	04:20:00	0101000020E6100000280F0BB5A679F1BF327381CB63F34640	12	3.9300000000000002	0	t	0.026822875999999999	0.20000000000000001	\N	0	5	0	2018-02-25 05:20:00+01
238	2018-02-25	04:50:00	0101000020E61000005D4E09884978F1BFBADA8AFD65F34640	11	3.9199999999999999	0	t	0.010539956	0	\N	0	5	0	2018-02-25 05:50:00+01
239	2018-02-25	05:21:00	0101000020E61000006A6CAF05BD77F1BFE4A1EF6E65F34640	11	3.9100000000000001	0	t	0.023169269999999999	0.10000000000000001	\N	0	5	0	2018-02-25 06:21:00+01
240	2018-02-25	05:51:00	0101000020E61000002578431A1578F1BFAB5CA8FC6BF34640	12	3.8999999999999999	0	t	0.037102823	0.10000000000000001	\N	0	5	0	2018-02-25 06:51:00+01
241	2018-02-25	06:21:00	0101000020E6100000E9297288B879F1BF6C5A290472F34640	12	3.8999999999999999	0	t	0.0066941170000000003	0.20000000000000001	\N	0	5	0	2018-02-25 07:21:00+01
242	2018-02-25	06:51:00	0101000020E610000099BB96900F7AF1BF96218E7571F34640	13	3.9100000000000001	0	t	0.012869599000000001	0	\N	0	5	0	2018-02-25 07:51:00+01
243	2018-02-25	07:22:00	0101000020E6100000423EE8D9AC7AF1BF4850FC1873F34640	12	3.8900000000000001	0	t	0.062149493	0.20000000000000001	\N	0	5	0	2018-02-25 08:22:00+01
244	2018-02-25	07:52:00	0101000020E6100000F2B0506B9A77F1BF0F0BB5A679F34640	12	3.9100000000000001	0	t	0.26926174400000003	0	\N	0	5	0	2018-02-25 08:52:00+01
245	2018-02-25	08:22:00	0101000020E610000042CF66D5E76AF1BFC8073D9B55F34640	12	3.9199999999999999	0	t	0.174953468	0.10000000000000001	\N	0	5	0	2018-02-25 09:22:00+01
246	2018-02-25	08:52:00	0101000020E6100000FCA9F1D24D62F1BF4910AE8042F34640	13	3.96	0	t	0.10350451200000001	0.40000000000000002	\N	0	5	0	2018-02-25 09:52:00+01
247	2018-02-25	09:23:00	0101000020E61000008BDEA9807B5EF1BF6C787AA52CF34640	11	3.9700000000000002	0	t	0.019437639999999999	0.10000000000000001	\N	0	5	0	2018-02-25 10:23:00+01
248	2018-02-25	09:53:00	0101000020E610000071AFCC5B755DF1BF42B115342DF34640	11	3.9900000000000002	0	t	0.039802692000000001	0.20000000000000001	\N	0	5	0	2018-02-25 10:53:00+01
249	2018-02-25	10:23:00	0101000020E61000003B511212695BF1BFE41071732AF34640	11	4.0499999999999998	0	t	0.623992671	0.20000000000000001	\N	0	5	0	2018-02-25 11:23:00+01
250	2018-02-25	10:54:00	0101000020E6100000F8C264AA6054F1BF5839B4C876F24640	10	4.0300000000000002	0	t	0.015906975	0.29999999999999999	\N	0	5	0	2018-02-25 11:54:00+01
251	2018-02-25	11:25:00	0101000020E6100000DA1B7C613255F1BF7C43E1B375F24640	8	4.0300000000000002	0	t	0.60759906500000005	0	\N	0	5	0	2018-02-25 12:25:00+01
252	2018-02-25	11:58:00	0101000020E6100000ABCC94D6DF52F1BFCC61F71DC3F14640	9	4.0300000000000002	0	t	0.004562824	0	\N	0	5	0	2018-02-25 12:58:00+01
253	2018-02-25	12:28:00	0101000020E61000003411363CBD52F1BF20F0C000C2F14640	10	4.0700000000000003	0	t	0.12789951699999999	0	\N	0	5	0	2018-02-25 13:28:00+01
254	2018-02-25	13:00:00	0101000020E6100000A85489B2B754F1BF67F3380CE6F14640	8	4.0499999999999998	0	t	0.62953699900000004	0	\N	0	5	0	2018-02-25 14:00:00+01
255	2018-02-25	13:31:00	0101000020E6100000DE21C5008966F1BF0AB952CF82F24640	8	4.0700000000000003	0	t	0.23135457500000001	0.10000000000000001	\N	0	5	0	2018-02-25 14:31:00+01
256	2018-02-25	14:04:00	0101000020E6100000B003E78C286DF1BF581B6327BCF24640	11	4.04	0	t	0.092675427000000005	0	\N	0	5	0	2018-02-25 15:04:00+01
257	2018-02-25	14:34:00	0101000020E61000008FE4F21FD26FF1BF11A96917D3F24640	11	4.0700000000000003	0	t	0.042969734000000002	0	\N	0	5	0	2018-02-25 15:34:00+01
258	2018-02-25	15:07:00	0101000020E61000001AC05B204171F1BF3CC1FEEBDCF24640	12	4.04	0	t	0.022532687999999999	0	\N	0	5	0	2018-02-25 16:07:00+01
259	2018-02-25	15:37:00	0101000020E6100000855D143DF071F1BF570A815CE2F24640	11	4.0499999999999998	0	t	0.026816155000000001	0.29999999999999999	\N	0	5	0	2018-02-25 16:37:00+01
260	2018-02-25	16:07:00	0101000020E6100000A08CF161F672F1BF42CF66D5E7F24640	13	4.0499999999999998	0	t	0.33107849099999997	0.10000000000000001	\N	0	5	0	2018-02-25 17:07:00+01
261	2018-02-25	16:38:00	0101000020E6100000567DAEB6627FF1BF6C787AA52CF34640	9	4.0099999999999998	0	t	0.051878470000000003	0.69999999999999996	\N	0	5	0	2018-02-25 17:38:00+01
262	2018-02-25	17:08:00	0101000020E61000000397C79A9181F1BFC15774EB35F34640	9	3.98	0	t	0.021483294	0.20000000000000001	\N	0	5	0	2018-02-25 18:08:00+01
263	2018-02-25	17:39:00	0101000020E6100000E5EFDE516382F1BFD026874F3AF34640	9	3.96	0	t	0.054511960999999998	0.10000000000000001	\N	0	5	0	2018-02-25 18:39:00+01
264	2018-02-25	18:09:00	0101000020E6100000DC68006F8184F1BFD734EF3845F34640	9	3.9500000000000002	0	t	0.022375546999999999	0	\N	0	5	0	2018-02-25 19:09:00+01
265	2018-02-25	18:39:00	0101000020E61000007FDC7EF96485F1BF16889E9449F34640	10	3.9700000000000002	0	t	0.0343532	0.10000000000000001	\N	0	5	0	2018-02-25 19:39:00+01
266	2018-02-25	19:09:00	0101000020E610000088821953B086F1BFB37BF2B050F34640	12	3.9500000000000002	0	t	0.25733847700000001	0.69999999999999996	\N	0	5	0	2018-02-25 20:09:00+01
267	2018-02-25	19:39:00	0101000020E6100000ECC039234A7BF1BFE54350357AF34640	11	3.9500000000000002	0	t	0.099432839999999995	0.29999999999999999	\N	0	5	0	2018-02-25 20:39:00+01
268	2018-02-25	20:10:00	0101000020E6100000F01989D00876F1BF3315E29178F34640	10	3.96	0	t	0.0042583530000000003	0.29999999999999999	\N	0	5	0	2018-02-25 21:10:00+01
269	2018-02-25	20:40:00	0101000020E6100000B743C362D475F1BF39D2191879F34640	15	3.9500000000000002	0	t	0.45551293500000001	0.20000000000000001	\N	0	5	0	2018-02-25 21:40:00+01
270	2018-02-25	21:10:00	0101000020E6100000C4B46FEEAF5EF1BF40A0336953F34640	15	3.9500000000000002	0	t	0.022391451999999999	0.10000000000000001	\N	0	5	0	2018-02-25 22:10:00+01
271	2018-02-25	21:40:00	0101000020E61000005CAE7E6C925FF1BF506F46CD57F34640	11	3.9500000000000002	0	t	0.084833918999999994	0.29999999999999999	\N	0	5	0	2018-02-25 22:40:00+01
272	2018-02-25	22:11:00	0101000020E6100000956588635D5CF1BFB22AC24D46F34640	13	3.9500000000000002	0	t	0.053246093000000001	0.10000000000000001	\N	0	5	0	2018-02-25 23:11:00+01
273	2018-02-25	22:41:00	0101000020E61000009EEC66463F5AF1BF8255F5F23BF34640	13	3.9399999999999999	0	t	0.52655449499999996	0	\N	0	5	0	2018-02-25 23:41:00+01
274	2018-02-25	23:11:00	0101000020E61000003430F2B22656F1BF42EDB776A2F24640	12	3.9300000000000002	0	t	0.41812777400000001	35	\N	0	5	0	2018-02-26 00:11:00+01
275	2018-02-25	23:42:00	0101000020E6100000083A5AD5924EF1BFCA32C4B12EF24640	13	3.9300000000000002	0	t	0.033108881	0	\N	0	5	0	2018-02-26 00:42:00+01
276	2018-02-26	00:12:00	0101000020E610000020D26F5F074EF1BF7653CA6B25F24640	12	3.8999999999999999	0	t	0.014339945	0	\N	0	5	0	2018-02-26 01:12:00+01
277	2018-02-26	00:43:00	0101000020E6100000EE0A7DB08C4DF1BF12F6ED2422F24640	14	3.8900000000000001	0	t	0.018968301	0	\N	0	5	0	2018-02-26 01:43:00+01
278	2018-02-26	01:13:00	0101000020E610000026E1421EC14DF1BF273108AC1CF24640	12	3.8999999999999999	0	t	0.055074993000000003	0.10000000000000001	\N	0	5	0	2018-02-26 02:13:00+01
279	2018-02-26	01:44:00	0101000020E610000034F279C5534FF1BFC382FB010FF24640	13	3.9100000000000001	0	t	0.54605439099999997	0.10000000000000001	\N	0	5	0	2018-02-26 02:44:00+01
280	2018-02-20	05:26:00	0101000020E6100000E333D93F4F43F1BFF08975AA7CF14640	11	3.7999999999999998	0	t	0.0039782309999999996	0	\N	0	16	0	2018-02-20 06:26:00+01
281	2018-02-20	05:56:00	0101000020E61000002D93E1783E43F1BF44183F8D7BF14640	11	3.7999999999999998	0	t	0.0063557040000000002	0	\N	0	16	0	2018-02-20 06:56:00+01
282	2018-02-20	06:27:00	0101000020E61000001C0A9FAD8343F1BFF08975AA7CF14640	17	3.7599999999999998	0	t	0.0093403979999999998	0.40000000000000002	\N	0	16	0	2018-02-20 07:27:00+01
283	2018-02-20	06:57:00	0101000020E61000001C0A9FAD8343F1BF92E9D0E979F14640	22	3.7599999999999998	0	t	0.011408837	1.6000000000000001	\N	0	16	0	2018-02-20 07:57:00+01
284	2018-02-20	07:28:00	0101000020E6100000A54E40136143F1BFF646AD307DF14640	39	3.7599999999999998	0	t	0.0042583530000000003	0	\N	0	16	0	2018-02-20 08:28:00+01
285	2018-02-20	07:58:00	0101000020E61000006C787AA52C43F1BFF08975AA7CF14640	10	3.77	0	t	0.0090562500000000001	0	\N	0	16	0	2018-02-20 08:58:00+01
286	2018-02-20	08:28:00	0101000020E61000009E3F6D54A743F1BFF08975AA7CF14640	10	3.7799999999999998	0	t	1.266979294	0.10000000000000001	\N	0	16	0	2018-02-20 09:28:00+01
287	2018-02-20	08:59:00	0101000020E61000000B96EA025E26F1BF4AEEB089CCF24640	13	3.7999999999999998	0	t	1.1137744599999999	4.2999999999999998	\N	0	16	0	2018-02-20 09:59:00+01
288	2018-02-20	09:29:00	0101000020E610000058CA32C4B12EF1BFCDC8207711F44640	10	3.79	0	t	0.016788791000000001	0.10000000000000001	\N	0	16	0	2018-02-20 10:29:00+01
289	2018-02-20	09:59:00	0101000020E6100000C976BE9F1A2FF1BFDD9733DB15F44640	11	3.7799999999999998	0	t	0.0043046639999999997	0.10000000000000001	\N	0	16	0	2018-02-20 10:59:00+01
290	2018-02-20	10:30:00	0101000020E6100000014D840D4F2FF1BF075F984C15F44640	22	3.77	0	t	0.018397618000000001	0.29999999999999999	\N	0	16	0	2018-02-20 11:30:00+01
291	2018-02-20	11:00:00	0101000020E61000005B61FA5E4330F1BFE3546B6116F44640	25	3.77	0	t	0.043399450999999999	0.10000000000000001	\N	0	16	0	2018-02-20 12:00:00+01
292	2018-02-20	12:02:00	0101000020E61000005ED905836B2EF1BF40A4DFBE0EF44640	46	3.77	0	t	0.0044710389999999996	0.10000000000000001	\N	0	16	0	2018-02-20 13:02:00+01
293	2018-02-20	12:32:00	0101000020E6100000E71DA7E8482EF1BF64AE0CAA0DF44640	16	3.77	0	t	0.0067737520000000001	0.29999999999999999	\N	0	16	0	2018-02-20 13:32:00+01
294	2018-02-20	13:03:00	0101000020E61000001FF46C567D2EF1BF16DD7A4D0FF44640	11	3.7599999999999998	0	t	0.013258013000000001	0.5	\N	0	16	0	2018-02-20 14:03:00+01
295	2018-02-20	13:33:00	0101000020E610000096AFCBF09F2EF1BFDC4603780BF44640	15	3.7599999999999998	0	t	0.01357276	0.5	\N	0	16	0	2018-02-20 14:33:00+01
296	2018-02-20	14:04:00	0101000020E61000005ED905836B2EF1BF16DD7A4D0FF44640	30	3.75	0	t	0.0074522700000000004	0	\N	0	16	0	2018-02-20 15:04:00+01
297	2018-02-20	14:35:00	0101000020E6100000AE47E17A142EF1BF6A6B44300EF44640	26	3.77	0	t	0.0051841969999999998	0.10000000000000001	\N	0	16	0	2018-02-20 15:35:00+01
298	2018-02-20	15:05:00	0101000020E6100000B456B439CE2DF1BF6A6B44300EF44640	12	3.77	0	t	1.8326837300000001	1	\N	0	16	0	2018-02-20 16:05:00+01
299	2018-02-20	15:35:00	0101000020E61000005FB7088CF54DF1BF75B169A510F24640	10	3.7599999999999998	0	t	0.021399225000000001	0	\N	0	16	0	2018-02-20 16:35:00+01
300	2018-02-20	16:06:00	0101000020E61000003B014D840D4FF1BFC382FB010FF24640	11	3.8100000000000001	0	t	0.018120460000000001	0.10000000000000001	\N	0	16	0	2018-02-20 17:06:00+01
301	2018-02-20	16:36:00	0101000020E6100000E1ECD632194EF1BFBDC5C37B0EF24640	10	3.7999999999999998	0	t	0.0018891890000000001	0.10000000000000001	\N	0	16	0	2018-02-20 17:36:00+01
302	2018-02-20	17:06:00	0101000020E6100000E1ECD632194EF1BFE78C28ED0DF24640	11	3.77	0	t	0.021983826000000001	0.10000000000000001	\N	0	16	0	2018-02-20 18:06:00+01
303	2018-02-20	17:37:00	0101000020E610000073D712F2414FF1BFBDC5C37B0EF24640	13	3.7799999999999998	0	t	0.0018891890000000001	0.20000000000000001	\N	0	16	0	2018-02-20 18:37:00+01
304	2018-02-20	18:07:00	0101000020E610000073D712F2414FF1BFE78C28ED0DF24640	16	3.7599999999999998	0	t	0.0051841969999999998	0.20000000000000001	\N	0	16	0	2018-02-20 19:07:00+01
305	2018-02-20	18:38:00	0101000020E61000006DC83F33884FF1BFE78C28ED0DF24640	35	3.75	0	t	0.0038726149999999998	0	\N	0	16	0	2018-02-20 19:38:00+01
306	2018-02-20	19:09:00	0101000020E6100000236937FA984FF1BF0B9755D80CF24640	10	3.75	0	t	0.004562824	0	\N	0	16	0	2018-02-20 20:09:00+01
307	2018-02-20	19:39:00	0101000020E6100000ACADD85F764FF1BF5F251FBB0BF24640	11	3.73	0	t	0.013547503000000001	0.29999999999999999	\N	0	16	0	2018-02-20 20:39:00+01
308	2018-02-20	20:10:00	0101000020E61000001D5A643BDF4FF1BFC382FB010FF24640	10	3.7200000000000002	0	t	0.0031112140000000002	0	\N	0	16	0	2018-02-20 21:10:00+01
309	2018-02-20	20:40:00	0101000020E6100000A59E05A1BC4FF1BFBDC5C37B0EF24640	11	3.75	0	t	0.002210179	0	\N	0	16	0	2018-02-20 21:40:00+01
310	2018-02-20	21:10:00	0101000020E6100000E4839ECDAA4FF1BFC382FB010FF24640	17	3.7200000000000002	0	t	0.003669467	0	\N	0	16	0	2018-02-20 22:10:00+01
311	2018-02-20	21:41:00	0101000020E6100000E4839ECDAA4FF1BFE78C28ED0DF24640	27	3.71	0	t	0.0076019410000000001	0	\N	0	16	0	2018-02-20 22:41:00+01
312	2018-02-20	22:12:00	0101000020E6100000EA92718C644FF1BF99BB96900FF24640	9	3.71	0	t	0.0063521580000000001	0.20000000000000001	\N	0	16	0	2018-02-20 23:12:00+01
313	2018-02-20	22:42:00	0101000020E6100000E4839ECDAA4FF1BFBDC5C37B0EF24640	9	3.71	0	t	0.0013154620000000001	0	\N	0	16	0	2018-02-20 23:42:00+01
314	2018-02-20	23:12:00	0101000020E6100000A59E05A1BC4FF1BFBDC5C37B0EF24640	12	3.71	0	t	0.0046060739999999999	0.10000000000000001	\N	0	16	0	2018-02-21 00:12:00+01
315	2018-02-20	23:43:00	0101000020E6100000236937FA984FF1BF11548D5E0DF24640	10	3.7200000000000002	0	t	0.0075208890000000002	0.10000000000000001	\N	0	16	0	2018-02-21 00:43:00+01
316	2018-02-21	00:13:00	0101000020E6100000DE74CB0EF14FF1BFBDC5C37B0EF24640	11	3.6699999999999999	0	t	0.021251303999999999	0.20000000000000001	\N	0	16	0	2018-02-21 01:13:00+01
317	2018-02-21	00:44:00	0101000020E610000079E6E5B0FB4EF1BF2123A0C211F24640	10	3.6699999999999999	0	t	0.010445472000000001	0.20000000000000001	\N	0	16	0	2018-02-21 01:44:00+01
318	2018-02-21	01:14:00	0101000020E6100000917EFB3A704EF1BF26E0D74812F24640	11	3.6699999999999999	0	t	0.0097529560000000001	0	\N	0	16	0	2018-02-21 02:14:00+01
319	2018-02-21	01:45:00	0101000020E610000041102043C74EF1BF6FF4311F10F24640	12	3.6800000000000002	0	t	0.0054096459999999997	0.29999999999999999	\N	0	16	0	2018-02-21 02:45:00+01
320	2018-02-21	02:15:00	0101000020E610000079E6E5B0FB4EF1BFC382FB010FF24640	12	3.6899999999999999	0	t	0.0040030739999999997	0	\N	0	16	0	2018-02-21 03:15:00+01
321	2018-02-21	02:46:00	0101000020E61000003B014D840D4FF1BF6FF4311F10F24640	13	3.6699999999999999	0	t	0.0094325759999999998	0.10000000000000001	\N	0	16	0	2018-02-21 03:46:00+01
322	2018-02-21	03:16:00	0101000020E6100000FC1BB4571F4FF1BF11548D5E0DF24640	13	3.6899999999999999	0	t	0.0083952009999999997	0	\N	0	16	0	2018-02-21 04:16:00+01
323	2018-02-21	03:46:00	0101000020E6100000C345EEE9EA4EF1BF99BB96900FF24640	10	3.6699999999999999	0	t	0.016075211999999998	0	\N	0	16	0	2018-02-21 04:46:00+01
324	2018-02-21	04:17:00	0101000020E61000001AC39CA04D4EF1BF355EBA490CF24640	11	3.6699999999999999	0	t	0.017617596999999999	0.10000000000000001	\N	0	16	0	2018-02-21 05:17:00+01
325	2018-02-21	04:47:00	0101000020E6100000B2BCAB1E304FF1BF832F4CA60AF24640	11	3.6699999999999999	0	t	0.013999014000000001	0.10000000000000001	\N	0	16	0	2018-02-21 05:47:00+01
326	2018-02-21	05:17:00	0101000020E61000005299620E824EF1BFD200DE0209F24640	12	3.6600000000000001	0	t	0.013794069000000001	0.10000000000000001	\N	0	16	0	2018-02-21 06:17:00+01
327	2018-02-21	05:48:00	0101000020E6100000FC1BB4571F4FF1BF5A68E7340BF24640	12	3.6600000000000001	0	t	0.009228277	0	\N	0	16	0	2018-02-21 06:48:00+01
328	2018-02-21	06:18:00	0101000020E6100000CA54C1A8A44EF1BF5F251FBB0BF24640	12	3.6400000000000001	0	t	0.23312960599999999	0.10000000000000001	\N	0	16	0	2018-02-21 07:18:00+01
329	2018-02-21	07:52:00	0101000020E6100000637FD93D7958F1BF91ED7C3F35F24640	29	3.5899999999999999	0	t	0.0031771429999999999	0	\N	0	16	0	2018-02-21 08:52:00+01
330	2018-02-21	08:23:00	0101000020E6100000DA3A38D89B58F1BF672618CE35F24640	9	3.6000000000000001	0	t	0.0045151690000000003	0.10000000000000001	\N	0	16	0	2018-02-21 09:23:00+01
331	2018-02-21	08:53:00	0101000020E61000005D70067FBF58F1BF431CEBE236F24640	10	3.6099999999999999	0	t	0.0053324569999999996	0.20000000000000001	\N	0	16	0	2018-02-21 09:53:00+01
332	2018-02-21	09:23:00	0101000020E6100000249A40118B58F1BF672618CE35F24640	11	3.6299999999999999	0	t	0.001308593	0.10000000000000001	\N	0	16	0	2018-02-21 10:23:00+01
333	2018-02-21	09:54:00	0101000020E6100000637FD93D7958F1BF672618CE35F24640	13	3.6400000000000001	0	t	0.0040008220000000002	0	\N	0	16	0	2018-02-21 10:54:00+01
334	2018-02-21	10:25:00	0101000020E6100000249A40118B58F1BFBBB4E1B034F24640	24	3.6400000000000001	0	t	0	0	\N	0	16	0	2018-02-21 11:25:00+01
335	2018-02-21	10:55:00	0101000020E6100000249A40118B58F1BFBBB4E1B034F24640	9	3.6600000000000001	0	t	0.0026309240000000002	0	\N	0	16	0	2018-02-21 11:55:00+01
336	2018-02-21	11:25:00	0101000020E6100000A164726A6758F1BFBBB4E1B034F24640	9	3.6600000000000001	0	t	0.0075495950000000001	0	\N	0	16	0	2018-02-21 12:25:00+01
337	2018-02-21	11:55:00	0101000020E6100000B3EDB4352258F1BF0A86730D33F24640	10	3.7000000000000002	0	t	0.0075495950000000001	0	\N	0	16	0	2018-02-21 12:55:00+01
338	2018-02-21	12:26:00	0101000020E6100000A164726A6758F1BFBBB4E1B034F24640	10	3.6800000000000002	0	t	0.0039759649999999997	0.10000000000000001	\N	0	16	0	2018-02-21 13:26:00+01
339	2018-02-21	12:56:00	0101000020E6100000EBC37AA35658F1BF672618CE35F24640	12	3.6800000000000002	0	t	0.010585605	0.20000000000000001	\N	0	16	0	2018-02-21 13:56:00+01
340	2018-02-21	13:26:00	0101000020E6100000F2D24D621058F1BFF54A598638F24640	10	3.6699999999999999	0	t	0.001891572	0.40000000000000002	\N	0	16	0	2018-02-21 14:26:00+01
341	2018-02-21	13:57:00	0101000020E6100000F2D24D621058F1BF1F12BEF737F24640	10	3.6699999999999999	0	t	0.0082963889999999995	0.10000000000000001	\N	0	16	0	2018-02-21 14:57:00+01
342	2018-02-21	14:27:00	0101000020E61000002AA913D04458F1BF672618CE35F24640	15	3.6600000000000001	0	t	0.0038679579999999999	0.20000000000000001	\N	0	16	0	2018-02-21 15:27:00+01
343	2018-02-21	14:57:00	0101000020E6100000637FD93D7958F1BF672618CE35F24640	12	3.6499999999999999	0	t	0.0073976470000000003	0.20000000000000001	\N	0	16	0	2018-02-21 15:57:00+01
344	2018-02-21	15:28:00	0101000020E61000001211FE45D058F1BF431CEBE236F24640	14	3.6400000000000001	0	t	0.030698323999999999	0.10000000000000001	\N	0	16	0	2018-02-21 16:28:00+01
345	2018-02-21	15:58:00	0101000020E61000004850FC187357F1BF2E90A0F831F24640	16	3.6400000000000001	0	t	0.020257066000000001	0	\N	0	16	0	2018-02-21 16:58:00+01
346	2018-02-21	16:28:00	0101000020E6100000A164726A6758F1BFA06B5F402FF24640	11	3.6400000000000001	0	t	0.0066961360000000001	0	\N	0	16	0	2018-02-21 17:28:00+01
347	2018-02-21	16:59:00	0101000020E6100000F2D24D621058F1BFCA32C4B12EF24640	12	3.6200000000000001	0	t	0.0055193259999999997	0	\N	0	16	0	2018-02-21 17:59:00+01
348	2018-02-21	17:29:00	0101000020E6100000F8E12021CA57F1BFF4F928232EF24640	11	3.6099999999999999	0	t	0.026407376	0.10000000000000001	\N	0	16	0	2018-02-21 18:29:00+01
349	2018-02-21	18:00:00	0101000020E6100000249A40118B58F1BFBBB4E1B034F24640	26	3.6099999999999999	0	t	0.002302059	0	\N	0	16	0	2018-02-21 19:00:00+01
350	2018-02-21	18:30:00	0101000020E6100000637FD93D7958F1BF91ED7C3F35F24640	9	3.6299999999999999	0	t	0.0093225300000000007	0.10000000000000001	\N	0	16	0	2018-02-21 19:30:00+01
351	2018-02-21	19:00:00	0101000020E6100000249A40118B58F1BF04C93B8732F24640	11	3.5800000000000001	0	t	0.013873227	0	\N	0	16	0	2018-02-21 20:00:00+01
352	2018-02-21	19:30:00	0101000020E61000001211FE45D058F1BF6DE34F5436F24640	11	3.5699999999999998	0	t	0.015951107999999999	0.10000000000000001	\N	0	16	0	2018-02-21 20:30:00+01
353	2018-02-21	20:01:00	0101000020E6100000F2D24D621058F1BFB6F7A92A34F24640	11	3.5499999999999998	0	t	0.0018891890000000001	0.10000000000000001	\N	0	16	0	2018-02-21 21:01:00+01
354	2018-02-21	20:31:00	0101000020E6100000F2D24D621058F1BFE0BE0E9C33F24640	11	3.5499999999999998	0	t	0.016075211999999998	0	\N	0	16	0	2018-02-21 21:31:00+01
355	2018-02-21	21:01:00	0101000020E61000004850FC187357F1BF7C61325530F24640	11	3.5499999999999998	0	t	0.0083952009999999997	0.20000000000000001	\N	0	16	0	2018-02-21 22:01:00+01
356	2018-02-21	21:32:00	0101000020E6100000107A36AB3E57F1BFF4F928232EF24640	11	3.5499999999999998	0	t	0.018744373000000002	0.29999999999999999	\N	0	16	0	2018-02-21 22:32:00+01
357	2018-02-21	22:02:00	0101000020E610000098BED7101C57F1BFE0BE0E9C33F24640	11	3.5499999999999998	0	t	0.002554448	0.20000000000000001	\N	0	16	0	2018-02-21 23:02:00+01
358	2018-02-21	22:32:00	0101000020E6100000107A36AB3E57F1BFE0BE0E9C33F24640	11	3.5499999999999998	0	t	0.0066968089999999997	0	\N	0	16	0	2018-02-21 23:32:00+01
359	2018-02-21	23:03:00	0101000020E6100000BF0B5BB39557F1BF0A86730D33F24640	11	3.54	0	t	0.015287235999999999	0	\N	0	16	0	2018-02-22 00:03:00+01
360	2018-02-21	23:33:00	0101000020E6100000EBC37AA35658F1BF5857056A31F24640	11	3.52	0	t	0.026491882000000001	0	\N	0	16	0	2018-02-22 00:33:00+01
361	2018-02-22	00:03:00	0101000020E61000004E5FCFD72C57F1BF1904560E2DF24640	11	3.5099999999999998	0	t	0.027039733	0	\N	0	16	0	2018-02-22 01:03:00+01
362	2018-02-22	00:34:00	0101000020E6100000BF0B5BB39557F1BF7653CA6B25F24640	12	3.5099999999999998	0	t	0.062988120999999994	0	\N	0	16	0	2018-02-22 01:34:00+01
363	2018-02-22	01:04:00	0101000020E61000004850FC187357F1BF1F12BEF737F24640	12	3.5299999999999998	0	t	0.061978282000000003	0.10000000000000001	\N	0	16	0	2018-02-22 02:04:00+01
364	2018-02-22	01:34:00	0101000020E6100000F56915FDA159F1BF8BDF14562AF24640	12	3.4900000000000002	0	t	0.028946082000000001	0	\N	0	16	0	2018-02-22 02:34:00+01
365	2018-02-22	02:05:00	0101000020E6100000249A40118B58F1BF7C61325530F24640	11	3.48	0	t	0.002302059	0.10000000000000001	\N	0	16	0	2018-02-22 03:05:00+01
366	2018-02-22	02:35:00	0101000020E6100000637FD93D7958F1BFA62897C62FF24640	12	3.5	0	t	0.0090761320000000006	0.10000000000000001	\N	0	16	0	2018-02-22 03:35:00+01
367	2018-02-22	03:05:00	0101000020E61000005D70067FBF58F1BF2E90A0F831F24640	12	3.4900000000000002	0	t	0.010007009000000001	0.10000000000000001	\N	0	16	0	2018-02-22 04:05:00+01
368	2018-02-22	03:36:00	0101000020E6100000249A40118B58F1BFBBB4E1B034F24640	12	3.4900000000000002	0	t	0.011773508	0	\N	0	16	0	2018-02-22 04:36:00+01
369	2018-02-22	04:06:00	0101000020E6100000EBC37AA35658F1BF1F12BEF737F24640	12	3.5299999999999998	0	t	0.027274863	0.10000000000000001	\N	0	16	0	2018-02-22 05:06:00+01
370	2018-02-22	04:36:00	0101000020E61000008126C286A757F1BF529ACDE330F24640	12	3.52	0	t	0.031841135	0.10000000000000001	\N	0	16	0	2018-02-22 05:36:00+01
371	2018-02-22	05:07:00	0101000020E6100000BC7493180456F1BFCA32C4B12EF24640	12	3.5299999999999998	0	t	0.013547836000000001	0	\N	0	16	0	2018-02-22 06:07:00+01
372	2018-02-22	05:37:00	0101000020E61000004BC8073D9B55F1BF67D5E76A2BF24640	12	3.5099999999999998	0	t	0.055161900999999999	0.10000000000000001	\N	0	16	0	2018-02-22 06:37:00+01
373	2018-02-22	06:07:00	0101000020E61000009FCDAACFD556F1BFA779C7293AF24640	12	3.5	0	t	0.033541192999999997	0.20000000000000001	\N	0	16	0	2018-02-22 07:07:00+01
374	2018-02-22	06:37:00	0101000020E6100000F54A59863856F1BFFB58C16F43F24640	11	3.4700000000000002	0	t	0.078195341000000002	0.10000000000000001	\N	0	16	0	2018-02-22 07:37:00+01
375	2018-02-22	07:08:00	0101000020E610000066D828EB3753F1BFE76ED74B53F24640	12	3.4900000000000002	0	t	0.109223298	0	\N	0	16	0	2018-02-22 08:08:00+01
376	2018-02-22	07:38:00	0101000020E6100000B3EDB4352258F1BF2063EE5A42F24640	12	3.4900000000000002	0	t	0.009322047	0	\N	0	16	0	2018-02-22 08:38:00+01
377	2018-02-22	08:09:00	0101000020E6100000F2D24D621058F1BFAD872F1345F24640	11	3.4900000000000002	0	t	0.035979852	0.10000000000000001	\N	0	16	0	2018-02-22 09:09:00+01
378	2018-02-22	08:39:00	0101000020E6100000637FD93D7958F1BF7DB262B83AF24640	11	3.5	0	t	0.054459440999999997	0.10000000000000001	\N	0	16	0	2018-02-22 09:39:00+01
379	2018-02-22	09:09:00	0101000020E61000007A36AB3E575BF1BFCB83F41439F24640	11	3.52	0	t	0.071063873999999999	0	\N	0	16	0	2018-02-22 10:09:00+01
380	2018-02-22	09:40:00	0101000020E6100000BF0B5BB39557F1BFA779C7293AF24640	16	3.54	0	t	0.069452227000000005	0.10000000000000001	\N	0	16	0	2018-02-22 10:40:00+01
381	2018-02-22	10:10:00	0101000020E610000037A8FDD64E54F1BF529ACDE330F24640	14	3.6200000000000001	0	t	0.034933352000000001	0.10000000000000001	\N	0	16	0	2018-02-22 11:10:00+01
382	2018-02-22	10:41:00	0101000020E61000002B8A5759DB54F1BF7DB262B83AF24640	12	3.6400000000000001	0	t	0.041606578999999998	0	\N	0	16	0	2018-02-22 11:41:00+01
383	2018-02-22	11:11:00	0101000020E6100000EF3B86C77E56F1BF04C93B8732F24640	12	3.6600000000000001	0	t	0.070685944000000001	0.20000000000000001	\N	0	16	0	2018-02-22 12:11:00+01
384	2018-02-22	11:42:00	0101000020E61000003430F2B22656F1BF35EF384547F24640	24	3.6699999999999999	0	t	0.061171344000000002	0	\N	0	16	0	2018-02-22 12:42:00+01
385	2018-02-22	12:12:00	0101000020E6100000F54A59863856F1BF91ED7C3F35F24640	14	3.6899999999999999	0	t	0.14043167400000001	0.10000000000000001	\N	0	16	0	2018-02-22 13:12:00+01
386	2018-02-22	12:42:00	0101000020E6100000A5BDC1172653F1BF99BB96900FF24640	16	3.7000000000000002	0	t	0.164839392	0	\N	0	16	0	2018-02-22 13:42:00+01
387	2018-02-22	13:13:00	0101000020E6100000096B63EC8457F1BFD1402C9B39F24640	12	3.71	0	t	0.017300639	0	\N	0	16	0	2018-02-22 14:13:00+01
388	2018-02-22	13:43:00	0101000020E610000030B8E68EFE57F1BF91ED7C3F35F24640	12	3.71	0	t	0.006151045	0.10000000000000001	\N	0	16	0	2018-02-22 14:43:00+01
389	2018-02-22	14:13:00	0101000020E6100000B3EDB4352258F1BFE0BE0E9C33F24640	12	3.71	0	t	0.015646190000000001	0	\N	0	16	0	2018-02-22 15:13:00+01
390	2018-02-22	14:44:00	0101000020E6100000A164726A6758F1BF1F12BEF737F24640	11	3.6899999999999999	0	t	0.015951389999999999	0.10000000000000001	\N	0	16	0	2018-02-22 15:44:00+01
391	2018-02-22	15:14:00	0101000020E61000008126C286A757F1BF672618CE35F24640	12	3.6800000000000002	0	t	0.0067730860000000002	0	\N	0	16	0	2018-02-22 16:14:00+01
392	2018-02-22	15:44:00	0101000020E61000004850FC187357F1BFB6F7A92A34F24640	12	3.6800000000000002	0	t	0	0	\N	0	16	0	2018-02-22 16:44:00+01
393	2018-02-22	16:15:00	0101000020E61000004850FC187357F1BFB6F7A92A34F24640	11	3.6699999999999999	0	t	0.0038981319999999999	0	\N	0	16	0	2018-02-22 17:15:00+01
394	2018-02-22	16:45:00	0101000020E6100000096B63EC8457F1BF91ED7C3F35F24640	12	3.6000000000000001	0	t	0.0085652479999999993	0	\N	0	16	0	2018-02-22 17:45:00+01
395	2018-02-22	17:15:00	0101000020E61000007A17EFC7ED57F1BFB6F7A92A34F24640	12	3.5600000000000001	0	t	0.0054470029999999997	0	\N	0	16	0	2018-02-22 18:15:00+01
396	2018-02-22	17:46:00	0101000020E6100000698EACFC3258F1BFE0BE0E9C33F24640	12	3.5600000000000001	0	t	0.016885678000000001	0.10000000000000001	\N	0	16	0	2018-02-22 18:46:00+01
397	2018-02-22	18:16:00	0101000020E6100000EBC37AA35658F1BFF54A598638F24640	11	3.54	0	t	0.039743094999999999	0.10000000000000001	\N	0	16	0	2018-02-22 19:16:00+01
398	2018-02-22	18:46:00	0101000020E61000009FCDAACFD556F1BF7C61325530F24640	11	3.5699999999999998	0	t	0.010293368000000001	0.10000000000000001	\N	0	16	0	2018-02-22 19:46:00+01
399	2018-02-22	19:17:00	0101000020E6100000873595456157F1BF7C61325530F24640	11	3.5	0	t	0.028587979999999999	0.10000000000000001	\N	0	16	0	2018-02-22 20:17:00+01
400	2018-02-22	19:47:00	0101000020E61000003430F2B22656F1BF91ED7C3F35F24640	11	3.5299999999999998	0	t	0.010007459	0.10000000000000001	\N	0	16	0	2018-02-22 20:47:00+01
401	2018-02-22	20:17:00	0101000020E61000006C06B8205B56F1BF04C93B8732F24640	20	3.5099999999999998	0	t	0.005696118	0.10000000000000001	\N	0	16	0	2018-02-22 21:17:00+01
402	2018-02-22	20:48:00	0101000020E6100000B665C0594A56F1BF529ACDE330F24640	12	3.5600000000000001	0	t	0.032002208999999997	0.10000000000000001	\N	0	16	0	2018-02-22 21:48:00+01
403	2018-02-22	21:18:00	0101000020E6100000BC7493180456F1BF2D3F709527F24640	12	3.5099999999999998	0	t	0.011244524000000001	0.10000000000000001	\N	0	16	0	2018-02-22 22:18:00+01
404	2018-02-22	21:49:00	0101000020E61000006C06B8205B56F1BFA01A2FDD24F24640	13	3.54	0	t	0.02426391	0.20000000000000001	\N	0	16	0	2018-02-22 22:49:00+01
405	2018-02-22	22:19:00	0101000020E6100000F54A59863856F1BF3D0E83F92BF24640	11	3.4900000000000002	0	t	0.014862757000000001	0.10000000000000001	\N	0	16	0	2018-02-22 23:19:00+01
406	2018-02-22	22:49:00	0101000020E610000060E811A3E756F1BFF4F928232EF24640	11	3.4900000000000002	0	t	0.013998692	0	\N	0	16	0	2018-02-22 23:49:00+01
407	2018-02-22	23:20:00	0101000020E6100000BF0B5BB39557F1BF43CBBA7F2CF24640	11	3.48	0	t	0.054512538999999999	0	\N	0	16	0	2018-02-23 00:20:00+01
408	2018-02-22	23:50:00	0101000020E61000007DAEB6627F59F1BFF54A598638F24640	12	3.4700000000000002	0	t	0.057502899000000003	0.10000000000000001	\N	0	16	0	2018-02-23 00:50:00+01
409	2018-02-23	00:20:00	0101000020E61000003FC91D369159F1BF2D3F709527F24640	12	3.46	0	t	0.014162869999999999	0	\N	0	16	0	2018-02-23 01:20:00+01
410	2018-02-23	00:51:00	0101000020E61000005F07CE19515AF1BF2D3F709527F24640	11	3.5	0	t	0.109253948	0.10000000000000001	\N	0	16	0	2018-02-23 01:51:00+01
411	2018-02-23	01:21:00	0101000020E6100000A245B6F3FD54F1BF75029A081BF24640	12	3.4700000000000002	0	t	0.100239492	0.10000000000000001	\N	0	16	0	2018-02-23 02:21:00+01
412	2018-02-23	01:51:00	0101000020E61000002D40DB6AD659F1BF2882380F27F24640	12	3.46	0	t	0.01581834	0.20000000000000001	\N	0	16	0	2018-02-23 02:51:00+01
413	2018-02-23	02:22:00	0101000020E6100000CE1C925A2859F1BFB5A679C729F24640	12	3.5	0	t	0.016071006999999998	0.10000000000000001	\N	0	16	0	2018-02-23 03:22:00+01
414	2018-02-23	02:52:00	0101000020E6100000A164726A6758F1BF3D0E83F92BF24640	12	3.4399999999999999	0	t	0.010548504	0	\N	0	16	0	2018-02-23 03:52:00+01
415	2018-02-23	03:22:00	0101000020E6100000B3EDB4352258F1BFCA32C4B12EF24640	12	3.4300000000000002	0	t	0.020141727000000002	0.10000000000000001	\N	0	16	0	2018-02-23 04:22:00+01
416	2018-02-23	03:53:00	0101000020E6100000107A36AB3E57F1BF2E90A0F831F24640	12	3.4399999999999999	0	t	0.030656310999999999	0.10000000000000001	\N	0	16	0	2018-02-23 04:53:00+01
417	2018-02-23	04:23:00	0101000020E61000007A17EFC7ED57F1BFA779C7293AF24640	20	3.4300000000000002	0	t	0.012175429	0.10000000000000001	\N	0	16	0	2018-02-23 05:23:00+01
418	2018-02-23	04:53:00	0101000020E6100000D1949D7E5057F1BF826F9A3E3BF24640	12	3.46	0	t	0.014900004	0	\N	0	16	0	2018-02-23 05:53:00+01
419	2018-02-23	05:24:00	0101000020E610000027124C35B356F1BFE00F3FFF3DF24640	12	3.4900000000000002	0	t	0.012841556	0.10000000000000001	\N	0	16	0	2018-02-23 06:24:00+01
420	2018-02-23	05:54:00	0101000020E6100000D7A3703D0A57F1BF7DB262B83AF24640	13	3.46	0	t	0.043253213999999998	0.10000000000000001	\N	0	16	0	2018-02-23 06:54:00+01
421	2018-02-23	06:24:00	0101000020E610000084BD89213959F1BF431CEBE236F24640	19	3.4500000000000002	0	t	0.060364369000000001	0.10000000000000001	\N	0	16	0	2018-02-23 07:24:00+01
422	2018-02-23	06:55:00	0101000020E610000027124C35B356F1BF492A53CC41F24640	15	3.46	0	t	0.012706443	0.80000000000000004	\N	0	16	0	2018-02-23 07:55:00+01
423	2018-02-23	07:25:00	0101000020E6100000107A36AB3E57F1BFD1915CFE43F24640	19	3.48	0	t	0.029864659000000002	0.10000000000000001	\N	0	16	0	2018-02-23 08:25:00+01
424	2018-02-23	07:56:00	0101000020E61000005D70067FBF58F1BF446D1B4641F24640	14	3.48	0	t	0.018499721	0.10000000000000001	\N	0	16	0	2018-02-23 08:56:00+01
425	2018-02-23	08:26:00	0101000020E61000001211FE45D058F1BF5FB69DB646F24640	13	3.5099999999999998	0	t	0.02238501	0	\N	0	16	0	2018-02-23 09:26:00+01
426	2018-02-23	08:56:00	0101000020E61000009B559FABAD58F1BF98FBE42840F24640	12	3.5299999999999998	0	t	0.034333124	0	\N	0	16	0	2018-02-23 09:56:00+01
427	2018-02-23	09:27:00	0101000020E6100000873595456157F1BFCB83F41439F24640	12	3.5600000000000001	0	t	0.027153487	0	\N	0	16	0	2018-02-23 10:27:00+01
428	2018-02-23	09:57:00	0101000020E6100000FB592C45F255F1BFF54A598638F24640	16	3.5800000000000001	0	t	0.049989000999999998	0.20000000000000001	\N	0	16	0	2018-02-23 10:57:00+01
429	2018-02-23	10:28:00	0101000020E6100000637FD93D7958F1BFB6F7A92A34F24640	35	3.6000000000000001	0	t	0.001776077	0	\N	0	16	0	2018-02-23 11:28:00+01
430	2018-02-23	10:58:00	0101000020E6100000637FD93D7958F1BFBBB4E1B034F24640	9	3.6299999999999999	0	t	0.002210179	0	\N	0	16	0	2018-02-23 11:58:00+01
431	2018-02-23	11:29:00	0101000020E6100000A164726A6758F1BFB6F7A92A34F24640	9	3.6600000000000001	0	t	0.0031112140000000002	0	\N	0	16	0	2018-02-23 12:29:00+01
432	2018-02-23	11:59:00	0101000020E61000002AA913D04458F1BFBBB4E1B034F24640	9	3.6800000000000002	0	t	0.0045608480000000002	0	\N	0	16	0	2018-02-23 12:59:00+01
433	2018-02-23	12:29:00	0101000020E6100000A164726A6758F1BF672618CE35F24640	11	3.6800000000000002	0	t	0.001308593	0.10000000000000001	\N	0	16	0	2018-02-23 13:29:00+01
434	2018-02-23	13:00:00	0101000020E6100000637FD93D7958F1BF672618CE35F24640	13	3.6699999999999999	0	t	0.003669467	0.20000000000000001	\N	0	16	0	2018-02-23 14:00:00+01
435	2018-02-23	13:30:00	0101000020E6100000637FD93D7958F1BF431CEBE236F24640	11	3.6600000000000001	0	t	0.017049544	0.20000000000000001	\N	0	16	0	2018-02-23 14:30:00+01
436	2018-02-23	14:01:00	0101000020E6100000F8E12021CA57F1BFA779C7293AF24640	12	3.6899999999999999	0	t	0.023354083000000001	0.59999999999999998	\N	0	16	0	2018-02-23 15:01:00+01
437	2018-02-23	14:31:00	0101000020E6100000D7A3703D0A57F1BF923EADA23FF24640	11	3.6699999999999999	0	t	0.023810409000000001	0.80000000000000004	\N	0	16	0	2018-02-23 15:31:00+01
438	2018-02-23	15:01:00	0101000020E610000045B9347EE155F1BF349E08E23CF24640	17	3.6400000000000001	0	t	0.022560469999999999	0.20000000000000001	\N	0	16	0	2018-02-23 16:01:00+01
439	2018-02-23	15:32:00	0101000020E61000001689096AF856F1BFA779C7293AF24640	11	3.6299999999999999	0	t	0.010625546	0.20000000000000001	\N	0	16	0	2018-02-23 16:32:00+01
440	2018-02-23	16:02:00	0101000020E61000004850FC187357F1BFF54A598638F24640	11	3.6200000000000001	0	t	0.038339994000000002	0.20000000000000001	\N	0	16	0	2018-02-23 17:02:00+01
441	2018-02-23	16:33:00	0101000020E6100000B665C0594A56F1BF492A53CC41F24640	12	3.5600000000000001	0	t	0.018870167	0	\N	0	16	0	2018-02-23 17:33:00+01
442	2018-02-23	17:03:00	0101000020E6100000107A36AB3E57F1BF98FBE42840F24640	12	3.5499999999999998	0	t	0.016794158999999999	0.10000000000000001	\N	0	16	0	2018-02-23 18:03:00+01
443	2018-02-23	17:33:00	0101000020E6100000B3EDB4352258F1BF98FBE42840F24640	11	3.5899999999999999	0	t	0.046701991999999998	0	\N	0	16	0	2018-02-23 18:33:00+01
444	2018-02-23	18:04:00	0101000020E6100000873595456157F1BF0A86730D33F24640	13	3.5699999999999998	0	t	0.044141544999999997	0	\N	0	16	0	2018-02-23 19:04:00+01
445	2018-02-23	18:34:00	0101000020E6100000DDB243FCC356F1BF52499D8026F24640	13	3.5600000000000001	0	t	0.0032417309999999999	0.20000000000000001	\N	0	16	0	2018-02-23 19:34:00+01
446	2018-02-23	19:05:00	0101000020E610000060E811A3E756F1BF7B1002F225F24640	12	3.5800000000000001	0	t	0.064246862000000002	0.10000000000000001	\N	0	16	0	2018-02-23 20:05:00+01
447	2018-02-23	19:35:00	0101000020E61000004BC8073D9B55F1BF1955867137F24640	12	3.5600000000000001	0	t	0.057492631000000002	0.10000000000000001	\N	0	16	0	2018-02-23 20:35:00+01
448	2018-02-23	20:06:00	0101000020E6100000DA3A38D89B58F1BFBBB4E1B034F24640	38	3.5299999999999998	0	t	0.001237805	0	\N	0	16	0	2018-02-23 21:06:00+01
449	2018-02-23	20:36:00	0101000020E6100000249A40118B58F1BFBBB4E1B034F24640	9	3.52	0	t	0.0022585819999999999	0	\N	0	16	0	2018-02-23 21:36:00+01
450	2018-02-23	21:07:00	0101000020E6100000DA3A38D89B58F1BF91ED7C3F35F24640	9	3.52	0	t	0.019640366999999999	0.10000000000000001	\N	0	16	0	2018-02-23 22:07:00+01
451	2018-02-23	21:37:00	0101000020E6100000CE1C925A2859F1BFA779C7293AF24640	9	3.5099999999999998	0	t	0.01928846	0	\N	0	16	0	2018-02-23 22:37:00+01
452	2018-02-23	22:07:00	0101000020E6100000A164726A6758F1BF6DE34F5436F24640	16	3.5099999999999998	0	t	0.0091517820000000007	0.20000000000000001	\N	0	16	0	2018-02-23 23:07:00+01
453	2018-02-23	22:38:00	0101000020E61000007A17EFC7ED57F1BF672618CE35F24640	15	3.52	0	t	0.007452874	0.10000000000000001	\N	0	16	0	2018-02-23 23:38:00+01
454	2018-02-23	23:08:00	0101000020E61000002AA913D04458F1BFBBB4E1B034F24640	11	3.5	0	t	0.002210179	0.20000000000000001	\N	0	16	0	2018-02-24 00:08:00+01
455	2018-02-23	23:39:00	0101000020E6100000EBC37AA35658F1BFB6F7A92A34F24640	\N	\N	\N	t	0.001776077	0.20000000000000001	\N	0	16	0	2018-02-24 00:39:00+01
456	2018-02-24	00:09:00	0101000020E6100000EBC37AA35658F1BFBBB4E1B034F24640	17	3.48	0	t	0.0063542859999999998	0.20000000000000001	\N	0	16	0	2018-02-24 01:09:00+01
457	2018-02-24	00:40:00	0101000020E6100000DA3A38D89B58F1BF672618CE35F24640	39	3.4500000000000002	0	t	0.0018891890000000001	0	\N	0	16	0	2018-02-24 01:40:00+01
458	2018-02-24	01:10:00	0101000020E6100000DA3A38D89B58F1BF91ED7C3F35F24640	9	3.48	0	t	0.002302059	0.10000000000000001	\N	0	16	0	2018-02-24 02:10:00+01
459	2018-02-24	01:41:00	0101000020E61000009B559FABAD58F1BFBBB4E1B034F24640	9	3.5	0	t	0.002210179	0	\N	0	16	0	2018-02-24 02:41:00+01
460	2018-02-24	02:11:00	0101000020E6100000DA3A38D89B58F1BFB6F7A92A34F24640	9	3.4199999999999999	0	t	0.0039782309999999996	0	\N	0	16	0	2018-02-24 03:11:00+01
461	2018-02-24	02:41:00	0101000020E6100000249A40118B58F1BF0A86730D33F24640	9	3.3900000000000001	0	t	0.0023059700000000001	0	\N	0	16	0	2018-02-24 03:41:00+01
462	2018-02-24	03:12:00	0101000020E6100000637FD93D7958F1BFE0BE0E9C33F24640	10	3.3900000000000001	0	t	0.0098371480000000004	0	\N	0	16	0	2018-02-24 04:12:00+01
463	2018-02-24	03:42:00	0101000020E61000001211FE45D058F1BF672618CE35F24640	11	3.3900000000000001	0	t	0.0031771429999999999	0.29999999999999999	\N	0	16	0	2018-02-24 04:42:00+01
464	2018-02-24	04:12:00	0101000020E61000009B559FABAD58F1BF91ED7C3F35F24640	12	3.4199999999999999	0	t	0.020131208000000001	0.20000000000000001	\N	0	16	0	2018-02-24 05:12:00+01
465	2018-02-24	04:43:00	0101000020E61000008126C286A757F1BF431CEBE236F24640	16	3.3700000000000001	0	t	0.049126792000000002	0.5	\N	0	16	0	2018-02-24 05:43:00+01
466	2018-02-24	05:13:00	0101000020E610000063601DC70F55F1BF672618CE35F24640	11	3.3999999999999999	0	t	0.071058040000000003	0.5	\N	0	16	0	2018-02-24 06:13:00+01
467	2018-02-24	05:44:00	0101000020E61000006C06B8205B56F1BFBD56427749F24640	16	3.3599999999999999	0	t	0.065926943000000002	0.20000000000000001	\N	0	16	0	2018-02-24 06:44:00+01
468	2018-02-24	06:14:00	0101000020E6100000F2D24D621058F1BFF54A598638F24640	18	3.3500000000000001	0	t	0.012929337000000001	0.10000000000000001	\N	0	16	0	2018-02-24 07:14:00+01
469	2018-02-24	06:45:00	0101000020E6100000249A40118B58F1BF672618CE35F24640	36	3.3399999999999999	0	t	0.002210179	0	\N	0	16	0	2018-02-24 07:45:00+01
470	2018-02-24	07:15:00	0101000020E6100000637FD93D7958F1BF6DE34F5436F24640	9	3.3500000000000001	0	t	0.0044710389999999996	0	\N	0	16	0	2018-02-24 08:15:00+01
471	2018-02-24	07:46:00	0101000020E6100000DA3A38D89B58F1BF91ED7C3F35F24640	11	3.3799999999999999	0	t	0.0018891890000000001	0.20000000000000001	\N	0	16	0	2018-02-24 08:46:00+01
472	2018-02-24	08:16:00	0101000020E6100000DA3A38D89B58F1BF672618CE35F24640	11	3.4399999999999999	0	t	0.0042583530000000003	0.10000000000000001	\N	0	16	0	2018-02-24 09:16:00+01
473	2018-02-24	08:46:00	0101000020E61000001211FE45D058F1BF6DE34F5436F24640	10	3.5	0	t	0.024927702999999999	0.10000000000000001	\N	0	16	0	2018-02-24 09:46:00+01
474	2018-02-24	09:17:00	0101000020E61000003FC91D369159F1BF2FE1D05B3CF24640	11	3.5299999999999998	0	t	0.046720611000000002	0.20000000000000001	\N	0	16	0	2018-02-24 10:17:00+01
475	2018-02-24	09:47:00	0101000020E6100000698EACFC3258F1BF529ACDE330F24640	12	3.5499999999999998	0	t	0.027095339	0.10000000000000001	\N	0	16	0	2018-02-24 10:47:00+01
476	2018-02-24	10:18:00	0101000020E61000004BE7C3B30459F1BF1955867137F24640	11	3.5600000000000001	0	t	0.021881299	0.20000000000000001	\N	0	16	0	2018-02-24 11:18:00+01
477	2018-02-24	10:48:00	0101000020E61000002AA913D04458F1BF04C93B8732F24640	11	3.5699999999999998	0	t	0.0040030739999999997	0.20000000000000001	\N	0	16	0	2018-02-24 11:48:00+01
478	2018-02-24	11:18:00	0101000020E6100000EBC37AA35658F1BF5857056A31F24640	12	3.6000000000000001	0	t	0.00323895	0.10000000000000001	\N	0	16	0	2018-02-24 12:18:00+01
479	2018-02-24	11:49:00	0101000020E6100000698EACFC3258F1BF2E90A0F831F24640	12	3.6099999999999999	0	t	0.003669467	0	\N	0	16	0	2018-02-24 12:49:00+01
480	2018-02-24	12:19:00	0101000020E6100000698EACFC3258F1BF0A86730D33F24640	16	3.6099999999999999	0	t	0.0012414399999999999	0.10000000000000001	\N	0	16	0	2018-02-24 13:19:00+01
481	2018-02-24	12:50:00	0101000020E6100000B3EDB4352258F1BF0A86730D33F24640	12	3.6099999999999999	0	t	0.0077974189999999999	0.20000000000000001	\N	0	16	0	2018-02-24 13:50:00+01
482	2018-02-24	13:20:00	0101000020E610000030B8E68EFE57F1BF529ACDE330F24640	12	3.6299999999999999	0	t	0.009422059	0.10000000000000001	\N	0	16	0	2018-02-24 14:20:00+01
483	2018-02-24	13:50:00	0101000020E61000007A17EFC7ED57F1BFF4F928232EF24640	10	3.6400000000000001	0	t	0.0063521580000000001	0	\N	0	16	0	2018-02-24 14:50:00+01
484	2018-02-24	14:21:00	0101000020E61000008126C286A757F1BF1904560E2DF24640	12	3.6200000000000001	0	t	0.023547399	0.10000000000000001	\N	0	16	0	2018-02-24 15:21:00+01
485	2018-02-24	14:51:00	0101000020E6100000F2D24D621058F1BFE0BE0E9C33F24640	12	3.6200000000000001	0	t	0.0044710389999999996	0	\N	0	16	0	2018-02-24 15:51:00+01
486	2018-02-24	15:22:00	0101000020E61000007A17EFC7ED57F1BF04C93B8732F24640	11	3.6200000000000001	0	t	0.0066657829999999998	0.10000000000000001	\N	0	16	0	2018-02-24 16:22:00+01
487	2018-02-24	15:52:00	0101000020E61000002AA913D04458F1BF0A86730D33F24640	12	3.5499999999999998	0	t	0.0023059700000000001	0.20000000000000001	\N	0	16	0	2018-02-24 16:52:00+01
488	2018-02-24	16:22:00	0101000020E6100000698EACFC3258F1BFE0BE0E9C33F24640	12	3.5299999999999998	0	t	0.006151045	0	\N	0	16	0	2018-02-24 17:22:00+01
489	2018-02-24	16:53:00	0101000020E6100000EBC37AA35658F1BF91ED7C3F35F24640	13	3.52	0	t	0.010007459	0	\N	0	16	0	2018-02-24 17:53:00+01
490	2018-02-24	17:23:00	0101000020E6100000B3EDB4352258F1BF04C93B8732F24640	11	3.46	0	t	0.015137939	0.10000000000000001	\N	0	16	0	2018-02-24 18:23:00+01
491	2018-02-24	17:53:00	0101000020E61000004241295AB957F1BFCA32C4B12EF24640	13	3.4300000000000002	0	t	0.026366047	0	\N	0	16	0	2018-02-24 18:53:00+01
492	2018-02-24	18:24:00	0101000020E6100000637FD93D7958F1BF91ED7C3F35F24640	\N	\N	\N	t	0.010007459	0.10000000000000001	\N	0	16	0	2018-02-24 19:24:00+01
493	2018-02-24	18:54:00	0101000020E61000002AA913D04458F1BF1F12BEF737F24640	\N	\N	\N	t	0.017690345999999999	0.20000000000000001	\N	0	16	0	2018-02-24 19:54:00+01
494	2018-02-24	19:24:00	0101000020E6100000873595456157F1BFD1402C9B39F24640	11	3.3999999999999999	0	t	0.01270467	0	\N	0	16	0	2018-02-24 20:24:00+01
495	2018-02-24	19:55:00	0101000020E61000007A17EFC7ED57F1BF1955867137F24640	11	3.3700000000000001	0	t	0.01074322	0	\N	0	16	0	2018-02-24 20:55:00+01
496	2018-02-24	20:25:00	0101000020E6100000EBC37AA35658F1BF91ED7C3F35F24640	10	3.3700000000000001	0	t	9.4900000000000003e-005	0	\N	0	16	0	2018-02-24 21:25:00+01
497	2018-02-24	20:55:00	0101000020E6100000EBC37AA35658F1BF91ED7C3F35F24640	11	3.3700000000000001	0	t	0.022754785	0	\N	0	16	0	2018-02-24 21:55:00+01
498	2018-02-24	21:26:00	0101000020E6100000096B63EC8457F1BF7C61325530F24640	11	3.3500000000000001	0	t	0.011119594	0.10000000000000001	\N	0	16	0	2018-02-24 22:26:00+01
499	2018-02-24	21:56:00	0101000020E6100000096B63EC8457F1BFE0BE0E9C33F24640	13	3.3399999999999999	0	t	0.0090333319999999998	0.10000000000000001	\N	0	16	0	2018-02-24 22:56:00+01
500	2018-02-24	22:26:00	0101000020E6100000F8E12021CA57F1BF672618CE35F24640	11	3.3399999999999999	0	t	0.0053324569999999996	0.10000000000000001	\N	0	16	0	2018-02-24 23:26:00+01
501	2018-02-24	22:57:00	0101000020E610000030B8E68EFE57F1BF431CEBE236F24640	11	3.3399999999999999	0	t	0.003669467	0.10000000000000001	\N	0	16	0	2018-02-24 23:57:00+01
502	2018-02-24	23:28:00	0101000020E610000030B8E68EFE57F1BF672618CE35F24640	12	3.3599999999999999	0	t	0.051240090000000002	0	\N	0	16	0	2018-02-25 00:28:00+01
503	2018-02-25	00:00:00	0101000020E6100000EF3B86C77E56F1BFDF6DDE3829F24640	12	3.3900000000000001	0	t	0.012847521000000001	0.10000000000000001	\N	0	16	0	2018-02-25 01:00:00+01
504	2018-02-25	00:38:00	0101000020E61000004E5FCFD72C57F1BFDF6DDE3829F24640	11	3.3799999999999999	0	t	0.028667316000000002	0.10000000000000001	\N	0	16	0	2018-02-25 01:38:00+01
505	2018-02-25	01:38:00	0101000020E61000006C06B8205B56F1BF7C61325530F24640	12	3.3100000000000001	0	t	0.072027055000000006	0	\N	0	16	0	2018-02-25 02:38:00+01
506	2018-02-25	02:39:00	0101000020E6100000698EACFC3258F1BFF69B89E942F24640	13	3.3399999999999999	0	t	0.085245026000000002	0.10000000000000001	\N	0	16	0	2018-02-25 03:39:00+01
507	2018-02-25	03:39:00	0101000020E610000059F8FA5A975AF1BFEF3CF19C2DF24640	12	3.3300000000000001	0	t	0.057675830999999997	0.10000000000000001	\N	0	16	0	2018-02-25 04:39:00+01
508	2018-02-25	04:39:00	0101000020E6100000EBC37AA35658F1BFCB83F41439F24640	12	3.3199999999999998	0	t	0.0098045690000000008	0	\N	0	16	0	2018-02-25 05:39:00+01
509	2018-02-25	05:40:00	0101000020E610000030B8E68EFE57F1BF826F9A3E3BF24640	13	3.2999999999999998	0	t	0.017130494999999999	0	\N	0	16	0	2018-02-25 06:40:00+01
510	2018-02-25	06:40:00	0101000020E61000004E5FCFD72C57F1BFCB83F41439F24640	12	3.29	0	t	0.041808409999999997	0.20000000000000001	\N	0	16	0	2018-02-25 07:40:00+01
511	2018-02-25	07:41:00	0101000020E6100000CE1C925A2859F1BFE0BE0E9C33F24640	12	3.29	0	t	0.029952952000000001	0.10000000000000001	\N	0	16	0	2018-02-25 08:41:00+01
512	2018-02-25	08:41:00	0101000020E610000030B8E68EFE57F1BFD1402C9B39F24640	12	3.3399999999999999	0	t	0.06411451	0	\N	0	16	0	2018-02-25 09:41:00+01
513	2018-02-25	10:42:00	0101000020E610000027124C35B356F1BF03780B2428F24640	14	3.4900000000000002	0	t	0.085282655999999998	0.10000000000000001	\N	0	16	0	2018-02-25 11:42:00+01
514	2018-02-25	11:42:00	0101000020E6100000F56915FDA159F1BF826F9A3E3BF24640	12	3.52	0	t	0.052279361000000003	0.10000000000000001	\N	0	16	0	2018-02-25 12:42:00+01
515	2018-02-25	12:43:00	0101000020E61000004E5FCFD72C57F1BFB6F7A92A34F24640	12	3.54	0	t	0.038918146000000001	0	\N	0	16	0	2018-02-25 13:43:00+01
516	2018-02-25	13:43:00	0101000020E61000004E5FCFD72C57F1BFD9B0A6B228F24640	12	3.5600000000000001	0	t	0.057537135000000003	0	\N	0	16	0	2018-02-25 14:43:00+01
517	2018-02-25	14:43:00	0101000020E61000009B559FABAD58F1BF1955867137F24640	19	3.54	0	t	0.0096829350000000002	0	\N	0	16	0	2018-02-25 15:43:00+01
518	2018-02-25	15:44:00	0101000020E6100000249A40118B58F1BFBBB4E1B034F24640	12	3.5099999999999998	0	t	0.035774612999999997	0.10000000000000001	\N	0	16	0	2018-02-25 16:44:00+01
519	2018-02-25	16:44:00	0101000020E6100000B9FC87F4DB57F1BFE6CC76853EF24640	12	3.4500000000000002	0	t	0.025941841	0	\N	0	16	0	2018-02-25 17:44:00+01
520	2018-02-25	17:45:00	0101000020E6100000F8E12021CA57F1BF431CEBE236F24640	13	3.4100000000000001	0	t	0.017901283	0	\N	0	16	0	2018-02-25 18:45:00+01
521	2018-02-25	18:45:00	0101000020E6100000B3EDB4352258F1BF58A835CD3BF24640	11	3.3700000000000001	0	t	0.017436075999999998	0.10000000000000001	\N	0	16	0	2018-02-25 19:45:00+01
522	2018-02-25	19:45:00	0101000020E6100000096B63EC8457F1BF1F12BEF737F24640	11	3.3199999999999998	0	t	0.74473237299999995	0	\N	0	16	0	2018-02-25 20:45:00+01
523	2018-02-20	07:06:00	0101000020E61000008A1F63EE5A42F1BFA7751BD47EF14640	76	3.9100000000000001	0	t	0.019470533000000002	0.20000000000000001	\N	0	88	0	2018-02-20 08:06:00+01
1087	2018-02-21	02:22:00	0101000020E61000007AC7293A924BF1BF672618CE35F24640	11	3.9100000000000001	0	t	0.031571374999999999	0.5	\N	0	4	0	2018-02-21 03:22:00+01
1088	2018-02-21	02:53:00	0101000020E6100000F18288D4B44BF1BFBC0512143FF24640	16	3.9199999999999999	0	t	0.044645840999999999	0.29999999999999999	\N	0	4	0	2018-02-21 03:53:00+01
1089	2018-02-21	03:23:00	0101000020E610000029594E42E94BF1BF2E90A0F831F24640	13	3.9100000000000001	0	t	0.00323895	0.40000000000000002	\N	0	4	0	2018-02-21 04:23:00+01
299018	2015-12-14	11:26:00	0101000020E61000003049658A39C8F7BF4E44BFB67E1C4740	6	3.6200000000000001	\N	t	0.107593989	2.7999999999999998	\N	0	39	2	2015-12-14 12:26:00+01
299019	2015-12-14	11:56:00	0101000020E6100000B534B74258CDF7BF145D177E701C4740	7	3.5899999999999999	\N	t	0.087184103999999998	0.69999999999999996	\N	0	39	2	2015-12-14 12:56:00+01
299020	2015-12-14	12:26:00	0101000020E610000062105839B4C8F7BFEA95B20C711C4740	8	3.6200000000000001	\N	t	0.0031643520000000001	0.80000000000000004	\N	0	39	2	2015-12-14 13:26:00+01
353120	2016-07-26	05:32:00	0101000020E6100000C79BFC169D6CF7BF5C936E4BE41C4740	8	3.5099999999999998	\N	t	0.18807053900000001	0.10000000000000001	\N	0	79	2	2016-07-26 07:32:00+02
353121	2016-07-26	14:40:00	0101000020E6100000B43A39437187F7BFC6DCB5847C1C4740	12	3.6099999999999999	\N	t	0.143755836	0	\N	0	79	2	2016-07-26 16:40:00+02
353122	2016-07-26	15:11:00	0101000020E6100000BB2A508BC183F7BFE9D500A5A11C4740	14	3.6400000000000001	\N	t	0.104494658	0.10000000000000001	\N	0	79	2	2016-07-26 17:11:00+02
353123	2016-07-26	15:42:00	0101000020E61000007C6473D53C87F7BF545227A0891C4740	9	3.6800000000000002	\N	t	0.36489068099999999	0.29999999999999999	\N	0	79	2	2016-07-26 17:42:00+02
353124	2016-07-26	16:12:00	0101000020E610000061C3D32B6599F7BF86E7A562631C4740	6	3.6499999999999999	\N	t	0.222194275	0.20000000000000001	\N	0	79	2	2016-07-26 18:12:00+02
353125	2016-07-26	16:43:00	0101000020E61000004D840D4FAF94F7BFAA605452271C4740	5	3.6099999999999999	\N	t	0.21094166	1.3	\N	0	79	2	2016-07-26 18:43:00+02
353126	2016-07-26	17:14:00	0101000020E610000017450F7C0C96F7BF1DAB949EE91B4740	9	3.6000000000000001	\N	t	0.31200944600000002	0.40000000000000002	\N	0	79	2	2016-07-26 19:14:00+02
369406	2016-09-18	07:03:00	0101000020E610000010CAFB389AE3F7BF13109370211D4740	5	3.5499999999999998	\N	t	0.024160240999999999	0.69999999999999996	\N	0	45	1	2016-09-18 09:03:00+02
369407	2016-09-18	07:33:00	0101000020E61000008E942D9276E3F7BF4698A25C1A1D4740	5	3.52	\N	t	0.51703390500000002	0.10000000000000001	\N	0	45	1	2016-09-18 09:33:00+02
369408	2016-09-18	08:03:00	0101000020E6100000D4B9A29410ECF7BF545227A0891C4740	8	3.48	\N	t	0.088549037999999997	1.1000000000000001	\N	0	45	1	2016-09-18 10:03:00+02
385912	2015-12-28	07:53:00	0101000020E6100000C9E53FA4DFBEF7BFD026874F3A1B4740	9	3.0299999999999998	\N	t	0.079838328	0.10000000000000001	\N	0	80	1	2015-12-28 08:53:00+01
385913	2015-12-29	04:32:00	0101000020E610000070D1C952EB3DF8BF61E124CD1F1D4740	10	2.9399999999999999	\N	t	0.068650167999999998	0.10000000000000001	\N	0	80	1	2015-12-29 05:32:00+01
385914	2015-12-29	05:33:00	0101000020E6100000AED51EF64241F8BFDACA4BFE271D4740	6	3	\N	t	0.058228238000000002	0.29999999999999999	\N	0	80	1	2015-12-29 06:33:00+01
385915	2015-12-29	06:33:00	0101000020E6100000C9E53FA4DF3EF8BFB05417F0321D4740	20	2.8999999999999999	\N	t	3.2283857070000002	0.5	\N	0	80	1	2015-12-29 07:33:00+01
385916	2015-12-30	05:08:00	0101000020E61000006A4DF38E53F4F7BFC364AA60541A4740	15	2.9900000000000002	\N	t	0.0098128390000000003	0.29999999999999999	\N	0	80	1	2015-12-30 06:08:00+01
385917	2015-12-30	06:08:00	0101000020E6100000BABBCE86FCF3F7BF3BFDA02E521A4740	8	3.02	\N	t	0.011627152	0.20000000000000001	\N	0	80	1	2015-12-30 07:08:00+01
385918	2015-12-30	07:09:00	0101000020E6100000E108522976F4F7BFC364AA60541A4740	25	2.96	\N	t	2.3173280140000001	0	\N	0	80	1	2015-12-30 08:09:00+01
385919	2015-12-30	08:09:00	0101000020E6100000931B45D61A0AF8BF4D66BCADF41C4740	10	2.9100000000000001	\N	t	0.049713926999999998	0	\N	0	80	1	2015-12-30 09:09:00+01
385920	2015-12-31	06:15:00	0101000020E61000000C90680245ECF7BFB537F8C2641A4740	15	3.0800000000000001	\N	t	0.012862244	0.20000000000000001	\N	0	80	1	2015-12-31 07:15:00+01
385921	2015-12-31	07:15:00	0101000020E6100000C79BFC169DECF7BF1895D409681A4740	15	3.1000000000000001	\N	t	2.3281365379999999	0.10000000000000001	\N	0	80	1	2015-12-31 08:15:00+01
385922	2015-12-31	08:16:00	0101000020E6100000780B24287E0CF8BF7E3B8908FF1C4740	15	3.0499999999999998	\N	t	0.027026229999999998	0.40000000000000002	\N	0	80	1	2015-12-31 09:16:00+01
385923	2015-12-31	09:16:00	0101000020E6100000E9B7AF03E70CF8BFDB8AFD65F71C4740	9	3.1600000000000001	\N	t	0.35668401799999999	0.10000000000000001	\N	0	80	1	2015-12-31 10:16:00+01
385924	2016-01-01	06:53:00	0101000020E61000003F389F3A56E9F7BF917EFB3A701A4740	7	3.0099999999999998	\N	t	0.45042233999999998	0.40000000000000002	\N	0	80	1	2016-01-01 07:53:00+01
385925	2016-01-01	07:53:00	0101000020E61000003480B74082E2F7BFE57FF277EF1A4740	8	3.0099999999999998	\N	t	2.0356975080000002	0.5	\N	0	80	1	2016-01-01 08:53:00+01
385926	2016-01-01	08:54:00	0101000020E6100000228E75711B0DF8BFE23AC615171D4740	7	3.0499999999999998	\N	t	0.16842522600000001	0.20000000000000001	\N	0	80	1	2016-01-01 09:54:00+01
385927	2016-01-01	09:54:00	0101000020E610000004C8D0B1830AF8BFBFF04A92E71C4740	8	3.0499999999999998	\N	t	0.057376587999999999	0.29999999999999999	\N	0	80	1	2016-01-01 10:54:00+01
385928	2016-01-02	08:10:00	0101000020E6100000431CEBE2361AF8BFC5FEB27BF21C4740	6	2.8999999999999999	\N	t	0.220024939	0.29999999999999999	\N	0	80	1	2016-01-02 09:10:00+01
385929	2016-01-02	09:10:00	0101000020E6100000AD69DE718A0EF8BFDA39CD02ED1C4740	7	2.96	\N	t	0.081267609000000005	0.29999999999999999	\N	0	80	1	2016-01-02 10:10:00+01
388297	2018-02-28	11:01:00	0101000020E61000002A37514B736BF1BFDE02098A1FF34640	12	3.9500000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 12:01:00+01
388298	2018-02-28	11:31:00	0101000020E6100000384888F2056DF1BFC9C7EE0225F34640	12	3.9700000000000002	0	f	\N	0	13	0	12	0	2018-02-28 12:31:00+01
388299	2018-02-28	12:02:00	0101000020E6100000668522DDCF69F1BF113AE8120EF34640	14	3.9700000000000002	0	f	\N	0	13	0	12	0	2018-02-28 13:02:00+01
388300	2018-02-28	12:32:00	0101000020E6100000DBFCBFEAC851F1BFAC1C5A643BF34640	13	3.9700000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 13:32:00+01
388301	2018-02-28	13:02:00	0101000020E6100000ABB019E0822CF1BFF775E09C11F54640	12	3.9900000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 14:02:00+01
388302	2018-02-28	13:32:00	0101000020E61000005EBA490C022BF1BFC460FE0A99F54640	12	3.9700000000000002	0	f	\N	0.40000000000000002	13	0	12	0	2018-02-28 14:32:00+01
388303	2018-02-28	14:03:00	0101000020E6100000D575A8A6242BF1BF1232906797F54640	12	3.9700000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 15:03:00+01
388304	2018-02-28	14:33:00	0101000020E6100000BEBED6A54628F1BFB5334C6DA9F54640	13	3.9900000000000002	0	f	\N	0	13	0	12	0	2018-02-28 15:33:00+01
388306	2018-02-28	15:33:00	0101000020E6100000AE282504AB2AF1BF840D4FAF94F54640	11	3.96	0	f	\N	0.20000000000000001	13	0	12	0	2018-02-28 16:33:00+01
388307	2018-02-28	16:04:00	0101000020E61000002CF3565D872AF1BFF7E80DF791F54640	13	3.9500000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 17:04:00+01
388308	2018-02-28	16:34:00	0101000020E61000009D9FE238F02AF1BFD3DEE00B93F54640	13	3.9500000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 17:34:00+01
388309	2018-02-28	17:04:00	0101000020E61000005ED905836B2EF1BFE8BB5B59A2F54640	13	3.9300000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 18:04:00+01
388310	2018-02-28	17:35:00	0101000020E61000006CEA3C2AFE2FF1BFCB10C7BAB8F54640	14	3.9300000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 18:35:00+01
388311	2018-02-28	18:05:00	0101000020E6100000EE7C3F355E3AF1BF598638D6C5F54640	12	3.9199999999999999	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 19:05:00+01
388312	2018-02-28	18:35:00	0101000020E61000000EBBEF181E3BF1BFFD87F4DBD7F54640	13	3.9100000000000001	0	f	\N	0	13	0	12	0	2018-02-28 19:35:00+01
388313	2018-02-28	19:05:00	0101000020E6100000302AA913D044F1BF99D9E731CAF54640	11	3.9100000000000001	0	f	\N	0	13	0	12	0	2018-02-28 20:05:00+01
388314	2018-02-28	19:36:00	0101000020E6100000D3BCE3141D49F1BFBD344580D3F54640	11	3.9100000000000001	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 20:36:00+01
388315	2018-02-28	20:06:00	0101000020E6100000681F2BF86D48F1BF849ECDAACFF54640	12	3.9199999999999999	0	f	\N	0	13	0	12	0	2018-02-28 21:06:00+01
388316	2018-02-28	20:36:00	0101000020E610000048E17A14AE47F1BF6F1283C0CAF54640	11	3.9199999999999999	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 21:36:00+01
388317	2018-02-28	21:06:00	0101000020E6100000B14D2A1A6B3FF1BFCC61F71DC3F54640	12	3.9199999999999999	0	f	\N	0	13	0	12	0	2018-02-28 22:06:00+01
388318	2018-02-28	21:37:00	0101000020E610000002BC0512143FF1BFA8A8FA95CEF54640	13	3.9199999999999999	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 22:37:00+01
388319	2018-02-28	22:07:00	0101000020E610000076FF58880E41F1BF849ECDAACFF54640	11	3.9100000000000001	0	f	\N	0	13	0	12	0	2018-02-28 23:07:00+01
388320	2018-02-28	22:37:00	0101000020E6100000EA23F0879F3FF1BFA8A8FA95CEF54640	13	3.9100000000000001	0	f	\N	0.10000000000000001	13	0	12	0	2018-02-28 23:37:00+01
388956	2018-03-13	02:07:00	0101000020E6100000FB592C45F255F1BF03965CC5E2F14640	12	3.9399999999999999	0	f	\N	0.10000000000000001	13	0	12	0	2018-03-13 03:07:00+01
388957	2018-03-13	02:37:00	0101000020E610000027124C35B356F1BF3D2CD49AE6F14640	12	3.9500000000000002	0	f	\N	0.10000000000000001	13	0	12	0	2018-03-13 03:37:00+01
388959	2018-03-13	03:07:00	0101000020E61000003430F2B22656F1BF52B81E85EBF14640	12	3.96	0	f	\N	0.10000000000000001	13	0	12	0	2018-03-13 04:07:00+01
388961	2018-03-13	03:38:00	0101000020E61000006C06B8205B56F1BF28F1B913ECF14640	12	3.9300000000000002	0	f	\N	0	13	0	12	0	2018-03-13 04:38:00+01
388965	2018-03-13	04:39:00	0101000020E610000038F8C264AA60F1BFC669882AFCF34640	12	3.9100000000000001	0	f	\N	0.10000000000000001	13	0	12	0	2018-03-13 05:39:00+01
388966	2018-03-13	05:09:00	0101000020E6100000F9122A38BC60F1BF55DFF94509F44640	12	3.9199999999999999	0	f	\N	0	13	0	12	0	2018-03-13 06:09:00+01
388967	2018-03-13	05:39:00	0101000020E610000054556820968DF1BF4703780B24F44640	12	3.9100000000000001	0	f	\N	0.29999999999999999	13	0	12	0	2018-03-13 06:39:00+01
388968	2018-03-13	06:09:00	0101000020E6100000E9D66B7A5090F1BF32772D211FF44640	12	3.8999999999999999	0	f	\N	0.10000000000000001	13	0	12	0	2018-03-13 07:09:00+01
388969	2018-03-13	06:40:00	0101000020E61000004D6551D84591F1BF3885950A2AF44640	12	3.9100000000000001	0	f	\N	0.10000000000000001	13	0	12	0	2018-03-13 07:40:00+01
388970	2018-03-13	07:10:00	0101000020E6100000BE11DDB3AE91F1BFAA60545227F44640	12	3.9399999999999999	0	f	\N	0	13	0	12	0	2018-03-13 08:10:00+01
\.


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 218
-- Name: observation_obs_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('observation_obs_id_seq', 388970, true);


--
-- TOC entry 3640 (class 0 OID 44863)
-- Dependencies: 219
-- Data for Name: soleil; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY soleil (sol_id, sol_civil, sol_date_time, sol_tysol_id) FROM stdin;
\.


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 220
-- Name: soleil_sol_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('soleil_sol_id_seq', 1, false);


--
-- TOC entry 3642 (class 0 OID 44868)
-- Dependencies: 221
-- Data for Name: type_activite; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY type_activite (tyact_id, tyact_nom) FROM stdin;
0	Non défini
1	Reposoir
2	Alimentation
3	Intermédiaire
\.


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 222
-- Name: type_activite_tyact_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('type_activite_tyact_id_seq', 3, true);


--
-- TOC entry 3644 (class 0 OID 44873)
-- Dependencies: 223
-- Data for Name: type_maree; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY type_maree (tymar_id, tymar_libelle) FROM stdin;
1	Haute
2	Basse
3	Inter Montante
4	Inter Descendante
\.


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 224
-- Name: type_maree_tymar_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('type_maree_tymar_id_seq', 1, true);


--
-- TOC entry 3646 (class 0 OID 44878)
-- Dependencies: 225
-- Data for Name: type_soleil; Type: TABLE DATA; Schema: brut; Owner: postgres
--

COPY type_soleil (tysol_id, tysol_libelle) FROM stdin;
\.


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 226
-- Name: type_soleil_tysol_id_seq; Type: SEQUENCE SET; Schema: brut; Owner: postgres
--

SELECT pg_catalog.setval('type_soleil_tysol_id_seq', 1, true);


--
-- TOC entry 3449 (class 2606 OID 44898)
-- Name: pk_constraint_age; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY age
    ADD CONSTRAINT pk_constraint_age PRIMARY KEY (age_id);


--
-- TOC entry 3451 (class 2606 OID 44900)
-- Name: pk_constraint_ancien_logger; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY ancien_logger
    ADD CONSTRAINT pk_constraint_ancien_logger PRIMARY KEY (anc_log);


--
-- TOC entry 3453 (class 2606 OID 44902)
-- Name: pk_constraint_cycle_biologique; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY cycle_biologique
    ADD CONSTRAINT pk_constraint_cycle_biologique PRIMARY KEY (cycle_id);


--
-- TOC entry 3455 (class 2606 OID 44904)
-- Name: pk_constraint_district_capture; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY district_capture
    ADD CONSTRAINT pk_constraint_district_capture PRIMARY KEY (distr_id);


--
-- TOC entry 3457 (class 2606 OID 44906)
-- Name: pk_constraint_espece; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY espece
    ADD CONSTRAINT pk_constraint_espece PRIMARY KEY (esp_id);


--
-- TOC entry 3459 (class 2606 OID 44908)
-- Name: pk_constraint_fichier; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY fichier
    ADD CONSTRAINT pk_constraint_fichier PRIMARY KEY (fich_id);


--
-- TOC entry 3461 (class 2606 OID 44910)
-- Name: pk_constraint_individu; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY individu
    ADD CONSTRAINT pk_constraint_individu PRIMARY KEY (ind_id);


--
-- TOC entry 3463 (class 2606 OID 44912)
-- Name: pk_constraint_lune; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY lune
    ADD CONSTRAINT pk_constraint_lune PRIMARY KEY (lune_id);


--
-- TOC entry 3467 (class 2606 OID 44914)
-- Name: pk_constraint_maree; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY maree
    ADD CONSTRAINT pk_constraint_maree PRIMARY KEY (mar_id);


--
-- TOC entry 3471 (class 2606 OID 44916)
-- Name: pk_constraint_meteo; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY meteo
    ADD CONSTRAINT pk_constraint_meteo PRIMARY KEY (met_id);


--
-- TOC entry 3475 (class 2606 OID 44918)
-- Name: pk_constraint_observation; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT pk_constraint_observation PRIMARY KEY (obs_id);


--
-- TOC entry 3479 (class 2606 OID 44920)
-- Name: pk_constraint_soleil; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY soleil
    ADD CONSTRAINT pk_constraint_soleil PRIMARY KEY (sol_id);


--
-- TOC entry 3481 (class 2606 OID 44922)
-- Name: pk_constraint_type_activite; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY type_activite
    ADD CONSTRAINT pk_constraint_type_activite PRIMARY KEY (tyact_id);


--
-- TOC entry 3483 (class 2606 OID 44924)
-- Name: pk_constraint_type_maree; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY type_maree
    ADD CONSTRAINT pk_constraint_type_maree PRIMARY KEY (tymar_id);


--
-- TOC entry 3485 (class 2606 OID 44926)
-- Name: pk_constraint_type_soleil; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY type_soleil
    ADD CONSTRAINT pk_constraint_type_soleil PRIMARY KEY (tysol_id);


--
-- TOC entry 3465 (class 2606 OID 44928)
-- Name: uq_lune; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY lune
    ADD CONSTRAINT uq_lune UNIQUE (lune_date);


--
-- TOC entry 3469 (class 2606 OID 44930)
-- Name: uq_maree; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY maree
    ADD CONSTRAINT uq_maree UNIQUE (mar_date_time_p1, mar_date_time_p2, mar_tymar_id);


--
-- TOC entry 3473 (class 2606 OID 44932)
-- Name: uq_meteo; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY meteo
    ADD CONSTRAINT uq_meteo UNIQUE (met_date_time);


--
-- TOC entry 3477 (class 2606 OID 44934)
-- Name: uq_obs; Type: CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT uq_obs UNIQUE (obs_geom, obs_date, obs_heure, obs_ind_id);


--
-- TOC entry 3496 (class 2620 OID 44935)
-- Name: tri_maree_periode; Type: TRIGGER; Schema: brut; Owner: postgres
--

CREATE TRIGGER tri_maree_periode AFTER INSERT ON maree FOR EACH ROW EXECUTE PROCEDURE func_maree_periode();


--
-- TOC entry 3497 (class 2620 OID 44936)
-- Name: tri_obs_gmt; Type: TRIGGER; Schema: brut; Owner: postgres
--

CREATE TRIGGER tri_obs_gmt AFTER INSERT ON observation FOR EACH ROW EXECUTE PROCEDURE func_obs_gmt();


--
-- TOC entry 3486 (class 2606 OID 44937)
-- Name: fk_ancien_logger_ind_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY ancien_logger
    ADD CONSTRAINT fk_ancien_logger_ind_id FOREIGN KEY (anc_ind_id) REFERENCES individu(ind_id);


--
-- TOC entry 3487 (class 2606 OID 44942)
-- Name: fk_individu_age_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY individu
    ADD CONSTRAINT fk_individu_age_id FOREIGN KEY (ind_age_id) REFERENCES age(age_id);


--
-- TOC entry 3488 (class 2606 OID 44947)
-- Name: fk_individu_distr_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY individu
    ADD CONSTRAINT fk_individu_distr_id FOREIGN KEY (ind_distr_id) REFERENCES district_capture(distr_id);


--
-- TOC entry 3489 (class 2606 OID 44952)
-- Name: fk_individu_esp_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY individu
    ADD CONSTRAINT fk_individu_esp_id FOREIGN KEY (ind_esp_id) REFERENCES espece(esp_id);


--
-- TOC entry 3490 (class 2606 OID 44957)
-- Name: fk_maree_tymar; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY maree
    ADD CONSTRAINT fk_maree_tymar FOREIGN KEY (mar_tymar_id) REFERENCES type_maree(tymar_id);


--
-- TOC entry 3491 (class 2606 OID 44962)
-- Name: fk_observation_cycle_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT fk_observation_cycle_id FOREIGN KEY (obs_cycle_id) REFERENCES cycle_biologique(cycle_id);


--
-- TOC entry 3492 (class 2606 OID 44967)
-- Name: fk_observation_fich_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT fk_observation_fich_id FOREIGN KEY (obs_fich_id) REFERENCES fichier(fich_id);


--
-- TOC entry 3493 (class 2606 OID 44972)
-- Name: fk_observation_ind_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT fk_observation_ind_id FOREIGN KEY (obs_ind_id) REFERENCES individu(ind_id);


--
-- TOC entry 3494 (class 2606 OID 44977)
-- Name: fk_observation_type_act_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT fk_observation_type_act_id FOREIGN KEY (obs_tyact_id) REFERENCES type_activite(tyact_id);


--
-- TOC entry 3495 (class 2606 OID 44982)
-- Name: fk_soleil_type_sol_id; Type: FK CONSTRAINT; Schema: brut; Owner: postgres
--

ALTER TABLE ONLY soleil
    ADD CONSTRAINT fk_soleil_type_sol_id FOREIGN KEY (sol_tysol_id) REFERENCES type_soleil(tysol_id);


-- Completed on 2018-04-10 15:01:56

--
-- PostgreSQL database dump complete
--

