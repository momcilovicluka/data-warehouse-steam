-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2023-12-26 20:41:25 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE lmdwcountry (
    id   INTEGER NOT NULL,
    name VARCHAR2(50 BYTE) NOT NULL
);

ALTER TABLE lmdwcountry ADD CONSTRAINT lmdwcountry_pk PRIMARY KEY ( id );

CREATE TABLE lmdwcountrystatistics (
    id                INTEGER NOT NULL,
    averagewallet     NUMBER(10, 2) NOT NULL,
    totalgamessold    INTEGER NOT NULL,
    totalrevenuesum   NUMBER(20, 2) NOT NULL,
    country_id        INTEGER NOT NULL,
    averagetotalprice NUMBER(10, 2),
    time_id           INTEGER NOT NULL
);

CREATE UNIQUE INDEX countrystatistics__idx ON
    lmdwcountrystatistics (
        country_id
    ASC );

ALTER TABLE lmdwcountrystatistics ADD CONSTRAINT lmdwcountrystatistics_pk PRIMARY KEY ( id );

CREATE TABLE lmdwdeveloper (
    id         INTEGER NOT NULL,
    name       VARCHAR2(50 BYTE) NOT NULL,
    country_id INTEGER NOT NULL
);

ALTER TABLE lmdwdeveloper ADD CONSTRAINT lmdwdeveloper_pk PRIMARY KEY ( id );

CREATE TABLE lmdwdeveloperstatistics (
    id             INTEGER NOT NULL,
    totalrevenue   NUMBER(20, 2) NOT NULL,
    totalgamessold INTEGER NOT NULL,
    developer_id   INTEGER NOT NULL,
    averagerevenue NUMBER(20, 2) NOT NULL,
    averagescore   NUMBER(5, 2) NOT NULL
);

CREATE UNIQUE INDEX developerstatistics__idx ON
    lmdwdeveloperstatistics (
        developer_id
    ASC );

ALTER TABLE lmdwdeveloperstatistics ADD CONSTRAINT lmdwdeveloperstatistics_pk PRIMARY KEY ( id );

CREATE TABLE lmdwgame (
    id              INTEGER NOT NULL,
    name            VARCHAR2(100 BYTE) NOT NULL,
    developer_id    INTEGER NOT NULL,
    price           NUMBER(10, 2) NOT NULL,
    metacriticscore NUMBER(10, 2) NOT NULL,
    game_id         INTEGER
);

ALTER TABLE lmdwgame ADD CONSTRAINT lmdwgame_pk PRIMARY KEY ( id );

CREATE TABLE lmdwgamestatistics (
    id          INTEGER NOT NULL,
    totalsales  INTEGER NOT NULL,
    totalincome NUMBER(20, 2) NOT NULL,
    game_id     INTEGER NOT NULL,
    country_id  INTEGER NOT NULL,
    time_id     INTEGER NOT NULL
);

CREATE UNIQUE INDEX gamestatistics__idx ON
    lmdwgamestatistics (
        game_id
    ASC );

CREATE UNIQUE INDEX gamestatistics__idxv1 ON
    lmdwgamestatistics (
        country_id
    ASC );

ALTER TABLE lmdwgamestatistics ADD CONSTRAINT lmdwgamestatistics_pk PRIMARY KEY ( id );

CREATE TABLE lmdwgenre (
    id   INTEGER NOT NULL,
    name VARCHAR2(50 BYTE) NOT NULL
);

ALTER TABLE lmdwgenre ADD CONSTRAINT lmdwgenre_pk PRIMARY KEY ( id );

CREATE TABLE lmdwgenreofgame (
    game_id  INTEGER NOT NULL,
    genre_id INTEGER NOT NULL
);

ALTER TABLE lmdwgenreofgame ADD CONSTRAINT lmdwgenreofgame_pk PRIMARY KEY ( game_id,
                                                                            genre_id );

CREATE TABLE lmdwpurchase (
    id                  INTEGER NOT NULL,
    dateofpurchase      DATE NOT NULL,
    totalprice          NUMBER(10, 2),
    user_id             INTEGER NOT NULL,
    purchasedwithwallet CHAR(1) NOT NULL
);

ALTER TABLE lmdwpurchase ADD CONSTRAINT lmdwpurchase_pk PRIMARY KEY ( id );

CREATE TABLE lmdwpurchaseitem (
    id          INTEGER NOT NULL,
    game_id     INTEGER NOT NULL,
    purchase_id INTEGER NOT NULL
);

ALTER TABLE lmdwpurchaseitem ADD CONSTRAINT lmdwpurchaseitem_pk PRIMARY KEY ( id );

CREATE TABLE lmdwtime (
    id    INTEGER NOT NULL,
    year  INTEGER NOT NULL,
    month INTEGER NOT NULL
);

ALTER TABLE lmdwtime ADD CONSTRAINT lmdwtime_pk PRIMARY KEY ( id );

CREATE TABLE lmdwuser (
    id         INTEGER NOT NULL,
    country_id INTEGER NOT NULL,
    wallet     NUMBER(10, 2) NOT NULL
);

ALTER TABLE lmdwuser ADD CONSTRAINT lmdwuser_pk PRIMARY KEY ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE lmdwcountrystatistics
    ADD CONSTRAINT lmdwcountrystatistics_country_fk FOREIGN KEY ( country_id )
        REFERENCES lmdwcountry ( id );

ALTER TABLE lmdwcountrystatistics
    ADD CONSTRAINT lmdwcountrystatistics_time_fk FOREIGN KEY ( time_id )
        REFERENCES lmdwtime ( id );

ALTER TABLE lmdwdeveloper
    ADD CONSTRAINT lmdwdeveloper_country_fk FOREIGN KEY ( country_id )
        REFERENCES lmdwcountry ( id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE lmdwdeveloperstatistics
    ADD CONSTRAINT lmdwdeveloperstatistics_developer_fk FOREIGN KEY ( developer_id )
        REFERENCES lmdwdeveloper ( id );

ALTER TABLE lmdwgame
    ADD CONSTRAINT lmdwgame_developer_fk FOREIGN KEY ( developer_id )
        REFERENCES lmdwdeveloper ( id );

ALTER TABLE lmdwgame
    ADD CONSTRAINT lmdwgame_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmdwgame ( id );

ALTER TABLE lmdwgamestatistics
    ADD CONSTRAINT lmdwgamestatistics_country_fk FOREIGN KEY ( country_id )
        REFERENCES lmdwcountry ( id );

ALTER TABLE lmdwgamestatistics
    ADD CONSTRAINT lmdwgamestatistics_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmdwgame ( id );

ALTER TABLE lmdwgamestatistics
    ADD CONSTRAINT lmdwgamestatistics_time_fk FOREIGN KEY ( time_id )
        REFERENCES lmdwtime ( id );

ALTER TABLE lmdwgenreofgame
    ADD CONSTRAINT lmdwgenreofgame_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmdwgame ( id );

ALTER TABLE lmdwgenreofgame
    ADD CONSTRAINT lmdwgenreofgame_genre_fk FOREIGN KEY ( genre_id )
        REFERENCES lmdwgenre ( id );

ALTER TABLE lmdwpurchase
    ADD CONSTRAINT lmdwpurchase_user_fk FOREIGN KEY ( user_id )
        REFERENCES lmdwuser ( id );

ALTER TABLE lmdwpurchaseitem
    ADD CONSTRAINT lmdwpurchaseitem_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmdwgame ( id );

ALTER TABLE lmdwpurchaseitem
    ADD CONSTRAINT lmdwpurchaseitem_purchase_fk FOREIGN KEY ( purchase_id )
        REFERENCES lmdwpurchase ( id );

ALTER TABLE lmdwuser
    ADD CONSTRAINT lmdwuser_country_fk FOREIGN KEY ( country_id )
        REFERENCES lmdwcountry ( id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             4
-- ALTER TABLE                             27
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0
