Use gm2;
SET NAMES utf8;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;


DROP TABLE IF EXISTS csv_biere;
DROP TABLE IF EXISTS csv_biere_temp;

CREATE TABLE csv_biere_temp
(
    name     varchar(255),
    anzliter varchar(255),
    preis    VARCHAR(255),
    pfand    VARCHAR(255)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


LOAD DATA LOCAL INFILE '/Users/tanzinger/Projects/AP12/sql/a_db_06_die_firma_import/schnell_und_durstig.csv'
    INTO TABLE csv_biere_temp
    CHARACTER SET utf8
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;


DROP TABLE IF EXISTS getraenke;
CREATE TABLE getraenke
(
    id    int(11) PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(255),
    preis decimal(5, 2),
    pfand decimal(5, 2),
    anz   INTEGER(11),
    liter decimal(5, 2),
    tfk   int(11)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


INSERT INTO getraenke (name, preis, pfand, anz, liter)
SELECT name,
       CAST(preis AS DECIMAL(5, 2)),
       CAST(pfand AS DECIMAL(5, 2)),
       CAST((SUBSTRING(anzliter, 1, 2)) AS INTEGER),
       CAST(REPLACE(TRIM(SUBSTR(anzliter, LOCATE('x ', anzliter) + 2, 4)), ',', '.') AS DECIMAL(5, 2))
FROM csv_biere_temp
WHERE pfand != ''
  AND pfand != 'Pfand';


TRUNCATE typ;
INSERT INTO typ (bez)
SELECT name
FROM csv_biere_temp
WHERE pfand = 'Pfand';


SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;