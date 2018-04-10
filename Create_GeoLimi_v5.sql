------------------------------------------------------------
--        Script Postgre 
------------------------------------------------------------


CREATE SCHEMA brut;

-------------------------------------------------------------
-- Table: espece
-------------------------------------------------------------

CREATE TABLE brut.espece(
        esp_id        serial  NOT NULL ,
        esp_nomFr     character varying (50) ,
        esp_nom_latin character varying (50) NOT NULL ,
        CONSTRAINT pk_constraint_espece PRIMARY KEY (esp_id )
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: maree
-------------------------------------------------------------

CREATE TABLE brut.maree(
        mar_id   serial  NOT NULL ,
        mar_date date NOT NULL ,
        CONSTRAINT pk_constraint_maree PRIMARY KEY (mar_id )
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: observation
-------------------------------------------------------------

CREATE TABLE brut.observation(
        obs_id              serial  NOT NULL ,
        obs_date            date NOT NULL ,
        obs_heure           time without time zone NOT NULL ,
        obs_geom            geometry(Point, 4326) NOT NULL ,
        obs_searching_time  integer ,
        obs_gps_voltage     double precision ,
        obs_gps_temperature integer ,
        obs_verifiee        boolean default FALSE,
        obs_distance_points double precision ,
        obs_data_time       time without time zone ,
        obs_speed           double precision NOT NULL ,
        obs_fich_id             integer ,
        obs_cycle_id            integer default 0,
        obs_ind_id              integer ,
        obs_tyact_id         integer NOT NULL default 0,
        CONSTRAINT pk_constraint_observation PRIMARY KEY (obs_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: soleil
-------------------------------------------------------------

CREATE TABLE brut.soleil(
        sol_id      serial  NOT NULL ,
        sol_civil   boolean NOT NULL ,
        sol_date    date NOT NULL ,
        sol_heure   time with time zone NOT NULL ,
        sol_tysol_id integer ,
        CONSTRAINT pk_constraint_soleil PRIMARY KEY (sol_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: meteo
-------------------------------------------------------------

CREATE TABLE brut.meteo(
        met_id          serial  NOT NULL ,
        met_nebulosite  integer NOT NULL ,
        met_vent        double precision NOT NULL ,
        met_directionV  integer NOT NULL ,
        met_temperature Float NOT NULL ,
        met_heure       time with time zone NOT NULL ,
        met_date        date NOT NULL ,
        CONSTRAINT pk_constraint_meteo PRIMARY KEY (met_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: cycle_biologique
-------------------------------------------------------------

CREATE TABLE brut.cycle_biologique(
        cycle_id      serial  NOT NULL ,
        cycle_libelle character varying (25) NOT NULL ,
        CONSTRAINT pk_constraint_cycle_biologique PRIMARY KEY (cycle_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: individu
-------------------------------------------------------------

CREATE TABLE brut.individu(
        ind_id          serial  NOT NULL ,
        ind_sexe_M      boolean default FALSE,
        ind_aile        double precision default 0 ,
        ind_bec         double precision default 0 ,
        ind_tarse       double precision default 0 ,
        ind_masse       double precision default 0 ,
        ind_date_capt   date ,
        ind_no_bague    character varying (10) ,
        ind_log         character varying (6) NOT NULL ,
        ind_code_droit  character varying (15) ,
        ind_code_gauche character varying (15) NOT NULL ,
        ind_esp_id          integer ,
        ind_distr_id        integer NOT NULL ,
        ind_age_id          integer default 0,
        ind_actif       boolean default TRUE,
		ind_sexe_verif  boolean default FALSE,
        CONSTRAINT pk_constraint_individu PRIMARY KEY (ind_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: lune
-------------------------------------------------------------

CREATE TABLE brut.lune(
        lune_id    serial  NOT NULL ,
        lune_date  date NOT NULL ,
        lune_heure time with time zone NOT NULL ,
        lune_phase character varying (20) ,
        CONSTRAINT pk_constraint_lune PRIMARY KEY (lune_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: fichier
-------------------------------------------------------------

CREATE TABLE brut.fichier(
        fich_id          serial  NOT NULL ,
        fich_date_insert Date NOT NULL DEFAULT date(now()),
        fich_chemin      character varying(2000) NOT NULL ,
        fich_goel_id     integer ,
		fich_goel        boolean NOT NULL,
		fich_goel_chemin character varying (2000) NOT NULL ,
        CONSTRAINT pk_constraint_fichier PRIMARY KEY (fich_id)
)WITHOUT OIDS;



-------------------------------------------------------------
--Table: district_capture
-------------------------------------------------------------

CREATE TABLE brut.district_capture(
        distr_id  serial NOT NULL ,
        distr_nom character varying (50) ,
        CONSTRAINT pk_constraint_district_capture PRIMARY KEY (distr_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: age
-------------------------------------------------------------

CREATE TABLE brut.age(
        age_id      serial NOT NULL ,
        age_libelle character varying (20) NOT NULL ,
        CONSTRAINT pk_constraint_age PRIMARY KEY (age_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: type_maree
-------------------------------------------------------------

CREATE TABLE brut.type_maree(
        tymar_id      serial  NOT NULL ,
        tymar_libelle character varying (25) NOT NULL ,
        CONSTRAINT pk_constraint_type_maree PRIMARY KEY (tymar_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: type_soleil
-------------------------------------------------------------

CREATE TABLE brut.type_soleil(
        tysol_id      serial  NOT NULL ,
        tysol_libelle character varying (25) NOT NULL ,
        CONSTRAINT pk_constraint_type_soleil PRIMARY KEY (tysol_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: ancien_logger
-------------------------------------------------------------

CREATE TABLE brut.ancien_logger(
        anc_log character (5) NOT NULL ,
        anc_ind_id integer,
        CONSTRAINT pk_constraint_ancien_logger PRIMARY KEY (anc_log)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: type_activite
-------------------------------------------------------------

CREATE TABLE brut.type_activite(
        tyact_id  serial  NOT NULL ,
        tyact_nom character varying (25) NOT NULL ,
        CONSTRAINT pk_constraint_type_activite PRIMARY KEY (tyact_id)
)WITHOUT OIDS;


-------------------------------------------------------------
--Table: periode
-------------------------------------------------------------

CREATE TABLE brut.periode(
        peri_h_deb time with time zone NOT NULL,
        peri_h_fin time with time zone NOT NULL,
		peri_coef integer ,
		peri_marnage double precision ,
        peri_mar_id    integer NOT NULL ,
        peri_tymar_id  integer NOT NULL ,
        CONSTRAINT pk_constraint_a_type_maree PRIMARY KEY (peri_h_deb,peri_h_fin,peri_mar_id)
)WITHOUT OIDS;

ALTER TABLE brut.observation ADD CONSTRAINT FK_observation_fich_id FOREIGN KEY (obs_fich_id) REFERENCES brut.fichier(fich_id);
ALTER TABLE brut.observation ADD CONSTRAINT FK_observation_cycle_id FOREIGN KEY (obs_cycle_id) REFERENCES brut.cycle_biologique(cycle_id);
ALTER TABLE brut.observation ADD CONSTRAINT FK_observation_ind_id FOREIGN KEY (obs_ind_id) REFERENCES brut.individu(ind_id);
ALTER TABLE brut.observation ADD CONSTRAINT FK_observation_type_act_id FOREIGN KEY (obs_tyact_id) REFERENCES brut.type_activite(tyact_id);
ALTER TABLE brut.soleil ADD CONSTRAINT FK_soleil_type_sol_id FOREIGN KEY (sol_tysol_id) REFERENCES brut.type_soleil(tysol_id);
ALTER TABLE brut.individu ADD CONSTRAINT FK_individu_esp_id FOREIGN KEY (ind_esp_id) REFERENCES brut.espece(esp_id);
ALTER TABLE brut.individu ADD CONSTRAINT FK_individu_distr_id FOREIGN KEY (ind_distr_id) REFERENCES brut.district_capture(distr_id);
ALTER TABLE brut.individu ADD CONSTRAINT FK_individu_age_id FOREIGN KEY (ind_age_id) REFERENCES brut.age(age_id);
ALTER TABLE brut.ancien_logger ADD CONSTRAINT FK_ancien_logger_ind_id FOREIGN KEY (anc_ind_id) REFERENCES brut.individu(ind_id);
ALTER TABLE brut.periode ADD CONSTRAINT FK_periode_id FOREIGN KEY (peri_mar_id) REFERENCES brut.maree(mar_id);
ALTER TABLE brut.periode ADD CONSTRAINT FK_periode_tymar_id FOREIGN KEY (peri_tymar_id) REFERENCES brut.type_maree(tymar_id);

