-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2023-12-25 19:30:16 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE lmsrccountry (
    id   INTEGER NOT NULL,
    name VARCHAR2(50 BYTE) NOT NULL
);

ALTER TABLE lmsrccountry ADD CONSTRAINT lmsrccountry_pk PRIMARY KEY ( id );

CREATE TABLE lmsrcdeveloper (
    id         INTEGER NOT NULL,
    name       VARCHAR2(50 BYTE) NOT NULL,
    country_id INTEGER NOT NULL
);

ALTER TABLE lmsrcdeveloper ADD CONSTRAINT lmsrcdeveloper_pk PRIMARY KEY ( id );

CREATE TABLE lmsrcgame (
    id              INTEGER NOT NULL,
    name            VARCHAR2(100 BYTE) NOT NULL,
    developer_id    INTEGER NOT NULL,
    releasedate     DATE NOT NULL,
    publisher_id    INTEGER NOT NULL,
    price           NUMBER(10, 2) NOT NULL,
    achievements    INTEGER NOT NULL,
    metacriticscore NUMBER(10, 2) NOT NULL,
    game_id         INTEGER
);

ALTER TABLE lmsrcgame ADD CONSTRAINT lmsrcgame_pk PRIMARY KEY ( id );

CREATE TABLE lmsrcgenre (
    id   INTEGER NOT NULL,
    name VARCHAR2(50 BYTE) NOT NULL
);

ALTER TABLE lmsrcgenre ADD CONSTRAINT lmsrcgenre_pk PRIMARY KEY ( id );

CREATE TABLE lmsrcgenreofgame (
    game_id  INTEGER NOT NULL,
    genre_id INTEGER NOT NULL
);

ALTER TABLE lmsrcgenreofgame ADD CONSTRAINT lmsrcgenreofgame_pk PRIMARY KEY ( game_id,
                                                                              genre_id );

CREATE TABLE lmsrcpublisher (
    id   INTEGER NOT NULL,
    name VARCHAR2(50 BYTE) NOT NULL
);

ALTER TABLE lmsrcpublisher ADD CONSTRAINT lmsrcpublisher_pk PRIMARY KEY ( id );

CREATE TABLE lmsrcpurchase (
    id                  INTEGER NOT NULL,
    isbundle            CHAR(1) NOT NULL,
    dateofpurchase      DATE NOT NULL,
    totalprice          NUMBER(10, 2) NOT NULL,
    user_id             INTEGER NOT NULL,
    purchasedwithwallet CHAR(1) NOT NULL
);

ALTER TABLE lmsrcpurchase ADD CONSTRAINT lmsrcpurchase_pk PRIMARY KEY ( id );

CREATE TABLE lmsrcpurchaseitem (
    id          INTEGER NOT NULL,
    gameid      INTEGER NOT NULL,
    purchaseid  INTEGER NOT NULL,
    game_id     INTEGER NOT NULL,
    purchase_id INTEGER NOT NULL
);

ALTER TABLE lmsrcpurchaseitem ADD CONSTRAINT lmsrcpurchaseitem_pk PRIMARY KEY ( id );

CREATE TABLE lmsrctag (
    id   INTEGER NOT NULL,
    name VARCHAR2(50 BYTE) NOT NULL
);

ALTER TABLE lmsrctag ADD CONSTRAINT lmsrctag_pk PRIMARY KEY ( id );

CREATE TABLE lmsrctagofgame (
    game_id INTEGER NOT NULL,
    tag_id  INTEGER NOT NULL
);

ALTER TABLE lmsrctagofgame ADD CONSTRAINT lmsrctagofgame_pk PRIMARY KEY ( game_id,
                                                                          tag_id );

CREATE TABLE lmsrcuser (
    id         INTEGER NOT NULL,
    name       VARCHAR2(50 BYTE) NOT NULL,
    surname    VARCHAR2(50 BYTE) NOT NULL,
    email      VARCHAR2(50 BYTE) NOT NULL,
    username   VARCHAR2(50 BYTE) NOT NULL,
    countryid  INTEGER NOT NULL,
    country_id INTEGER NOT NULL,
    wallet     NUMBER(10, 2) NOT NULL
);

ALTER TABLE lmsrcuser ADD CONSTRAINT lmsrcuser_pk PRIMARY KEY ( id );

ALTER TABLE lmsrcdeveloper
    ADD CONSTRAINT lmsrcdeveloper_country_fk FOREIGN KEY ( country_id )
        REFERENCES lmsrccountry ( id );

ALTER TABLE lmsrcgame
    ADD CONSTRAINT lmsrcgame_developer_fk FOREIGN KEY ( developer_id )
        REFERENCES lmsrcdeveloper ( id );

ALTER TABLE lmsrcgame
    ADD CONSTRAINT lmsrcgame_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmsrcgame ( id );

ALTER TABLE lmsrcgame
    ADD CONSTRAINT lmsrcgame_publisher_fk FOREIGN KEY ( publisher_id )
        REFERENCES lmsrcpublisher ( id );

ALTER TABLE lmsrcgenreofgame
    ADD CONSTRAINT lmsrcgenreofgame_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmsrcgame ( id );

ALTER TABLE lmsrcgenreofgame
    ADD CONSTRAINT lmsrcgenreofgame_genre_fk FOREIGN KEY ( genre_id )
        REFERENCES lmsrcgenre ( id );

ALTER TABLE lmsrcpurchase
    ADD CONSTRAINT lmsrcpurchase_user_fk FOREIGN KEY ( user_id )
        REFERENCES lmsrcuser ( id );

ALTER TABLE lmsrcpurchaseitem
    ADD CONSTRAINT lmsrcpurchaseitem_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmsrcgame ( id );

ALTER TABLE lmsrcpurchaseitem
    ADD CONSTRAINT lmsrcpurchaseitem_purchase_fk FOREIGN KEY ( purchase_id )
        REFERENCES lmsrcpurchase ( id );

ALTER TABLE lmsrctagofgame
    ADD CONSTRAINT lmsrctagofgame_game_fk FOREIGN KEY ( game_id )
        REFERENCES lmsrcgame ( id );

ALTER TABLE lmsrctagofgame
    ADD CONSTRAINT lmsrctagofgame_tag_fk FOREIGN KEY ( tag_id )
        REFERENCES lmsrctag ( id );

ALTER TABLE lmsrcuser
    ADD CONSTRAINT lmsrcuser_country_fk FOREIGN KEY ( country_id )
        REFERENCES lmsrccountry ( id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             23
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
-- ERRORS                                   0
-- WARNINGS                                 0