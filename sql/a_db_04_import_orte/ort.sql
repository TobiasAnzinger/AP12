CREATE SCHEMA IF NOT EXISTS uebung1;
Use uebung1;
SET NAMES utf8;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;



DROP TABLE IF EXISTS csv_ort;

CREATE TABLE csv_ort
(
    osm_id    VARCHAR(20),
    args      VARCHAR(20),
    ort       VARCHAR(50),
    plz       VARCHAR(10),
    landkreis VARCHAR(50),
    bundesland VARCHAR(50)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


LOAD DATA LOCAL INFILE '/Users/tanzinger/Projects/AP12/sql/a_db_04_import_orte/zuordnung_plz_ort_landkreis.csv'
    INTO TABLE csv_ort
    CHARACTER SET utf8
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;


DROP TABLE IF EXISTS ort;
DROP TABLE IF EXISTS landkreis;
DROP TABLE IF EXISTS bundesland;


CREATE TABLE bundesland
(
    id  INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


CREATE TABLE ort
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    plz   VARCHAR(10),
    lid   INT(11),
    name  VARCHAR(50),
    lname VARCHAR(50)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE landkreis
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(50),
    bid   INT(11),
    bname VARCHAR(50)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

# Bundesländer einfügen und anzeigen
SELECT DISTINCT bundesland FROM csv_ort;
INSERT INTO bundesland (name) SELECT DISTINCT bundesland FROM csv_ort;

SELECT * FROM bundesland;

# Landkreise einfügen und anzeigen
INSERT INTO landkreis (name, bname) SELECT DISTINCT landkreis, bundesland
FROM csv_ort WHERE landkreis > '' ORDER BY landkreis;

UPDATE landkreis SET bid=(SELECT id FROM bundesland WHERE bname=name);

SELECT * FROM landkreis LIMIT 10;


# Orte einfügen und anzeigen
TRUNCATE ort;
INSERT INTO ort (plz,name,lname) SELECT plz,ort,landkreis FROM csv_ort ORDER BY ort;
UPDATE ort SET lid=(SELECT id FROM landkreis WHERE lname=name);

SELECT * FROM ort LIMIT 10;

# aufräumen
ALTER TABLE ort DROP COLUMN lname;
ALTER TABLE landkreis DROP COLUMN bname;
DROP TABLE csv_ort;


# Mitarbeiter: oid neu setzen
update mitarbeiter set oid=(
    select id from ort where plz='85662' AND name='Hohenbrunn')
where id in (8,9);
update mitarbeiter set oid=(
    select id from ort where plz='85653' AND name='Aying')
where id in (6,7);
update mitarbeiter set oid=(
    select id from ort where plz='82061' AND name='Neuried')
where id in (4,5);
update mitarbeiter set oid=(
    select id from ort where plz='85521' AND name='Hohenbrunn')
where id=3;
update mitarbeiter set oid=(
    select id from ort where plz='85653' AND name='Aying')
where id=2;
update mitarbeiter set oid=(
    select id from ort where plz='85609' AND name='Aschheim')
where id=1;
# FKs
ALTER table ort ADD CONSTRAINT fk_ort_landkreis
    Foreign key (lid) References landkreis (id);
ALTER table landkreis ADD CONSTRAINT fk_landkreis_bundesland
    Foreign key (bid) References bundesland (id);


SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;