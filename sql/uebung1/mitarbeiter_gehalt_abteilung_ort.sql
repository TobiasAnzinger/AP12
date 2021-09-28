CREATE SCHEMA IF NOT EXISTS uebung1;
Use uebung1;
SET NAMES utf8;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;

DROP TABLE IF EXISTS ort;
DROP TABLE IF EXISTS abteilung;
DROP TABLE IF EXISTS gehalt;
DROP TABLE IF EXISTS mitabrbeiter;

CREATE TABLE ort
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    plz  VARCHAR(10),
    name VARCHAR(50)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE abteilung
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    abteilung VARCHAR(50),
    lid       INT
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE gehalt
(
    id     INT PRIMARY KEY AUTO_INCREMENT,
    gehalt DECIMAL(9, 2),
    iban   VARCHAR(25)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE mitarbeiter
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(50),
    vorname VARCHAR(50),
    gebdat  DATE,
    strasse VARCHAR(50),
    oid     INT,
    aid     INT
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

ALTER table gehalt
    ADD CONSTRAINT fk_gehalt_mitarbeiter Foreign key (id) References mitarbeiter (id);
ALTER table mitarbeiter
    ADD CONSTRAINT fk_mitarbeiter_ort Foreign key (oid) References ort (id);
ALTER table mitarbeiter
    ADD CONSTRAINT fk_mitarbeiter_abteilung Foreign key (aid) References abteilung (id);
ALTER table abteilung
    ADD CONSTRAINT fk_abteilung_mitarbeiter Foreign key (lid) References mitarbeiter (id);

SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
