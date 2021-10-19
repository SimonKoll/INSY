
drop table allergen;
drop table beitrag;
drop table eltern;
drop table essensbestellung;
drop table gruppe;
drop table kind;
drop table kinder_gruppeneinteilung;
drop table kindergarten;
drop table personal;
drop table profession;
drop table speise;
drop table speiseplan;
drop table tarif;


-- Generiert von Oracle SQL Developer Data Modeler 17.4.0.355.2131
--   am/um:        2018-03-18 11:30:06 MEZ
--   Site:      Oracle Database 11g
--   Typ:      Oracle Database 11g



CREATE TABLE allergen (
    id            CHAR(1) NOT NULL,
    bezeichnung   VARCHAR2(30) NOT NULL
);

ALTER TABLE allergen ADD CONSTRAINT allergen_pk PRIMARY KEY ( id );

CREATE TABLE beitrag (
    monat              INTEGER,
    jahr               INTEGER,
    betrag             NUMBER(8,2),
    anz_essen          INTEGER NOT NULL,
    eltern_eltern_id   NUMBER
);

CREATE TABLE eltern (
    vorname     VARCHAR2(30),
    nachname    VARCHAR2(30) NOT NULL,
    einkommen   NUMBER(8,2),
    eltern_id   NUMBER NOT NULL
);

ALTER TABLE eltern ADD CONSTRAINT eltern_pk PRIMARY KEY ( eltern_id );

CREATE TABLE essensbestellung (
    speiseplan_datum   DATE NOT NULL,
    kind_id            INTEGER NOT NULL
);

ALTER TABLE essensbestellung ADD CONSTRAINT essensbestellung_pk PRIMARY KEY ( speiseplan_datum,
kind_id );

CREATE TABLE gruppe (
    id_2              INTEGER NOT NULL,
    bezeichnung       VARCHAR2(30),
    kindergarten_id   INTEGER NOT NULL
);

ALTER TABLE gruppe ADD CONSTRAINT gruppe_pk PRIMARY KEY ( id_2 );

CREATE TABLE kind (
    id                        INTEGER NOT NULL,
    vorname                   VARCHAR2(30),
    nachname                  VARCHAR2(30),
    gebdatum                  DATE,
    eltern_id_vorschreibung   NUMBER NOT NULL,
    zweiteltern_id            NUMBER NOT NULL
);

ALTER TABLE kind ADD CONSTRAINT kind_pk PRIMARY KEY ( id );

CREATE TABLE kinder_gruppeneinteilung (
    gruppe_id   INTEGER NOT NULL,
    kind_id     INTEGER NOT NULL,
    jahr        INTEGER NOT NULL
);

ALTER TABLE kinder_gruppeneinteilung ADD CONSTRAINT kinder_gruppeneinteilung_pk PRIMARY KEY ( gruppe_id,
kind_id );

CREATE TABLE kindergarten (
    id            INTEGER NOT NULL,
    bezeichnung   VARCHAR2(50),
    plz           INTEGER
);

ALTER TABLE kindergarten ADD CONSTRAINT kindergarten_pk PRIMARY KEY ( id );

CREATE TABLE personal (
    persnr                     INTEGER NOT NULL,
    vorname                    VARCHAR2(30),
    nachname                   VARCHAR2(30),
    kindergarten_id            INTEGER NOT NULL,
    gruppe_id                  INTEGER NOT NULL,
    kindergarten_id2           INTEGER NOT NULL,
    profession_profession_id   NUMBER NOT NULL
);

CREATE UNIQUE INDEX personal__idx ON
    personal ( kindergarten_id ASC );

ALTER TABLE personal ADD CONSTRAINT personal_pk PRIMARY KEY ( persnr );

CREATE TABLE profession (
    bezeichnung     VARCHAR2(30),
    profession_id   NUMBER NOT NULL
);

ALTER TABLE profession ADD CONSTRAINT profession_pk PRIMARY KEY ( profession_id );

CREATE TABLE speise (
    bezeichnung   VARCHAR2(30),
    speise_id     NUMBER NOT NULL
);

ALTER TABLE speise ADD CONSTRAINT speise_pk PRIMARY KEY ( speise_id );

CREATE TABLE speise_allergen (
    speise_speise_id   NUMBER NOT NULL,
    allergen_id        CHAR(1) NOT NULL
);

ALTER TABLE speise_allergen ADD CONSTRAINT speise_allergen_pk PRIMARY KEY ( speise_speise_id,
allergen_id );

CREATE TABLE speiseplan (
    datum              DATE NOT NULL,
    speise_speise_id   NUMBER
);

ALTER TABLE speiseplan ADD CONSTRAINT speiseplan_pk PRIMARY KEY ( datum );

CREATE TABLE tarif (
    min_einkommen   NUMBER(8,2) NOT NULL,
    max_einkommen   NUMBER(8,2) NOT NULL,
    beitrag         NUMBER(8,2) NOT NULL,
    tarif_id        NUMBER NOT NULL
);

ALTER TABLE tarif ADD CONSTRAINT tarif_pk PRIMARY KEY ( tarif_id );

ALTER TABLE beitrag
    ADD CONSTRAINT beitrag_eltern_fk FOREIGN KEY ( eltern_eltern_id )
        REFERENCES eltern ( eltern_id );

ALTER TABLE essensbestellung
    ADD CONSTRAINT essensbestellung_kind_fk FOREIGN KEY ( kind_id )
        REFERENCES kind ( id );

ALTER TABLE essensbestellung
    ADD CONSTRAINT essensbestellung_speiseplan_fk FOREIGN KEY ( speiseplan_datum )
        REFERENCES speiseplan ( datum );

ALTER TABLE gruppe
    ADD CONSTRAINT gruppe_kindergarten_fk FOREIGN KEY ( kindergarten_id )
        REFERENCES kindergarten ( id );

ALTER TABLE kinder_gruppeneinteilung
    ADD CONSTRAINT gruppeneinteilung_kind_fk FOREIGN KEY ( kind_id )
        REFERENCES kind ( id );

ALTER TABLE kind
    ADD CONSTRAINT kind_eltern_fk FOREIGN KEY ( eltern_id_vorschreibung )
        REFERENCES eltern ( eltern_id );

ALTER TABLE kind
    ADD CONSTRAINT kind_eltern_fkv1 FOREIGN KEY ( zweiteltern_id )
        REFERENCES eltern ( eltern_id );

ALTER TABLE kinder_gruppeneinteilung
    ADD CONSTRAINT kinder_gruppe_fk FOREIGN KEY ( gruppe_id )
        REFERENCES gruppe ( id_2 );

ALTER TABLE personal
    ADD CONSTRAINT personal_gruppe_fk FOREIGN KEY ( gruppe_id )
        REFERENCES gruppe ( id_2 );

ALTER TABLE personal
    ADD CONSTRAINT personal_kindergarten_fk FOREIGN KEY ( kindergarten_id )
        REFERENCES kindergarten ( id );

ALTER TABLE personal
    ADD CONSTRAINT personal_kindergarten_fkv1 FOREIGN KEY ( kindergarten_id2 )
        REFERENCES kindergarten ( id );

ALTER TABLE personal
    ADD CONSTRAINT personal_profession_fk FOREIGN KEY ( profession_profession_id )
        REFERENCES profession ( profession_id );

ALTER TABLE speise_allergen
    ADD CONSTRAINT speise_allergen_allergen_fk FOREIGN KEY ( allergen_id )
        REFERENCES allergen ( id );

ALTER TABLE speise_allergen
    ADD CONSTRAINT speise_allergen_speise_fk FOREIGN KEY ( speise_speise_id )
        REFERENCES speise ( speise_id );

ALTER TABLE speiseplan
    ADD CONSTRAINT speiseplan_speise_fk FOREIGN KEY ( speise_speise_id )
        REFERENCES speise ( speise_id );

CREATE SEQUENCE eltern_eltern_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER eltern_eltern_id_trg BEFORE
    INSERT ON eltern
    FOR EACH ROW
    WHEN ( new.eltern_id IS NULL )
BEGIN
    :new.eltern_id := eltern_eltern_id_seq.nextval;
END;
/

CREATE SEQUENCE profession_profession_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER profession_profession_id_trg BEFORE
    INSERT ON profession
    FOR EACH ROW
    WHEN ( new.profession_id IS NULL )
BEGIN
    :new.profession_id := profession_profession_id_seq.nextval;
END;
/

CREATE SEQUENCE speise_speise_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER speise_speise_id_trg BEFORE
    INSERT ON speise
    FOR EACH ROW
    WHEN ( new.speise_id IS NULL )
BEGIN
    :new.speise_id := speise_speise_id_seq.nextval;
END;
/

CREATE SEQUENCE tarif_tarif_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tarif_tarif_id_trg BEFORE
    INSERT ON tarif
    FOR EACH ROW
    WHEN ( new.tarif_id IS NULL )
BEGIN
    :new.tarif_id := tarif_tarif_id_seq.nextval;
END;
/




-- Inserts
insert into allergen values ('G', 'Milch');
insert into allergen values ('E', 'Erdnüsse');

insert into speise values ('Schnitzel', 1);
insert into speise values ('Wokgericht', 2);

insert into speise_allergen values (1, 'G');
insert into speise_allergen values (2, 'G');
insert into speise_allergen values (2, 'E');

insert into tarif values (0, 10000, 20, 1);
insert into tarif values (10000, 20000, 40, 2);

insert into eltern values ('Max', 'Muster', 6000, 1);
insert into eltern values ('Susi', 'Muster', 3000, 2);
insert into kind values (1, 'Kleiner', 'Muster', to_date('01.01.2014', 'dd.mm.yyyy'), 1, 2);

insert into eltern values ('Max', 'Sonne', 6000, 3);
insert into eltern values ('Susi', 'Sonne', 5000, 4);
insert into kind values (2, 'Kleine', 'Sonne', to_date('01.01.2014', 'dd.mm.yyyy'), 3, 4);

-- SQL 1
select s.bezeichnung
from speise s
where s.speise_ID in (
  select speise_speise_id from speise_allergen
  where allergen_id='G')
and s.speise_ID in (
  select speise_speise_id from speise_allergen
  where allergen_id='E');


-- SQL 2
select g.id_2, g.bezeichnung, count(kind_id)
from gruppe g
left join kinder_gruppeneinteilung kg on (kg.gruppe_id=g.id_2)
where kg.jahr=2018
group by g.id_2, g.bezeichnung
order by 3 desc;


-- SQL 3
select * 
from kind k
left join eltern e1 on (e1.eltern_id = k.eltern_id_vorschreibung)
left join eltern e2 on (e2.eltern_id = k.zweiteltern_id)
where (e1.einkommen + nvl(e2.einkommen, 0) >= (
  select max(min_einkommen) from tarif
));