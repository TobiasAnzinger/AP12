USE gm2;

SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;


DROP TABLE IF EXISTS funktion;
CREATE TABLE funktion
(
    id         int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    taetigkeit varchar(50) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

ALTER TABLE mitarbeiter
    ADD fid int;

ALTER TABLE mitarbeiter
    ADD FOREIGN KEY (fid) REFERENCES funktion (id);


DROP TABLE IF EXISTS kunde;
CREATE TABLE kunde
(
    id        int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name`    varchar(50) DEFAULT NULL,
    `strasse` varchar(50) DEFAULT NULL,
    `telefon` varchar(50) DEFAULT NULL,
    `email`   varchar(50) DEFAULT NULL,
    `oid`     int(11)     DEFAULT NULL,
    KEY `fk_kunde_ort` (`oid`),
    CONSTRAINT `fk_kunde_ort` FOREIGN KEY (`oid`) REFERENCES `ort` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS bestellung;
CREATE TABLE bestellung
(
    id          int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `bezahlt`   tinyint DEFAULT 0,
    `bestdatum` DATE    DEFAULT NULL,
    `liefdatum` DATE    DEFAULT NULL,
    `kid`       int(11) DEFAULT NULL,
    `mid`       int(11) DEFAULT NULL,
    KEY `fk_bestellung_kunde` (`kid`),
    CONSTRAINT `fk_bestellung_kunde` FOREIGN KEY (`kid`) REFERENCES `kunde` (`id`),
    KEY `fk_bestellung_mitarbeiter` (`mid`),
    CONSTRAINT `fk_bestellung_mitarbeiter` FOREIGN KEY (`mid`) REFERENCES `mitarbeiter` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS typ;
CREATE TABLE typ
(
    id  int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bez varchar(50) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS einheit;
CREATE TABLE einheit
(
    id      int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bez     varchar(50)   DEFAULT NULL,
    anzahl  int(11)       DEFAULT NULL,
    volumen decimal(6, 2) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS produkt;
CREATE TABLE produkt
(
    id           int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bez          varchar(50)   DEFAULT NULL,
    vpreis       decimal(9, 2) DEFAULT NULL,
    mwst         decimal(5, 2) DEFAULT NULL,
    lagerbestand int(11)       DEFAULT NULL,
    eid          int(11)       DEFAULT NULL,
    tid          int(11)       DEFAULT NULL,
    KEY fk_produkt_einheit (eid),
    CONSTRAINT fk_produkt_einheit FOREIGN KEY (eid) REFERENCES einheit (id),
    KEY fk_produkt_typ (tid),
    CONSTRAINT fk_produkt_typ FOREIGN KEY (tid) REFERENCES typ (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS lieferant;
CREATE TABLE lieferant
(
    id      int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name    varchar(50) DEFAULT NULL,
    strasse varchar(50) DEFAULT NULL,
    telefon varchar(50) DEFAULT NULL,
    email   varchar(50) DEFAULT NULL,
    oid     int(11)     DEFAULT NULL,
    KEY `fk_lieferant_ort` (oid),
    CONSTRAINT `fk_lieferant_ort` FOREIGN KEY (oid) REFERENCES `ort` (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS lieferung;
CREATE TABLE lieferung
(
    id        int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    bestdatum DATE    DEFAULT NULL,
    liefdatum DATE    DEFAULT NULL,
    lid       int(11) DEFAULT NULL,
    mid       int(11) DEFAULT NULL,
    KEY `fk_lieferung_lieferant` (lid),
    CONSTRAINT `fk_lieferung_lieferant` FOREIGN KEY (lid) REFERENCES lieferant (id),
    KEY `fk_lieferung_mitarbeiter` (mid),
    CONSTRAINT `fk_lieferung_mitarbeiter` FOREIGN KEY (mid) REFERENCES mitarbeiter (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


DROP TABLE IF EXISTS lieferpos;
CREATE TABLE lieferpos
(
    lid    int(11)       DEFAULT NULL,
    pid    int(11)       DEFAULT NULL,
    vpreis decimal(9, 2) DEFAULT NULL,
    mwst   decimal(5, 2) DEFAULT NULL,
    menge  int(11)       DEFAULT NULL,
    KEY `fk_lieferpos_lieferung` (lid),
    CONSTRAINT `fk_lieferpos_lieferung` FOREIGN KEY (lid) REFERENCES lieferant (id),
    KEY `fk_lieferpos_produkt` (pid),
    CONSTRAINT `fk_lieferpos_produkt` FOREIGN KEY (pid) REFERENCES produkt (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;



SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;