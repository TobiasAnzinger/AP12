Use gm2;
SET NAMES utf8;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;


DROP TABLE IF EXISTS csv_getraenke_temp;

CREATE TABLE csv_getraenke_temp
(
    TEMP_name     varchar(255),
    TEMP_anzliter varchar(255),
    TEMP_preis    VARCHAR(255),
    TEMP_pfand    VARCHAR(255),
    TEMP_id       int(11) PRIMARY KEY AUTO_INCREMENT
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


LOAD DATA LOCAL INFILE '/Users/tanzinger/Projects/AP12/sql/a_db_06_die_firma_import/schnell_und_durstig.csv'
    INTO TABLE csv_getraenke_temp
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


ALTER table getraenke
    ADD CONSTRAINT fk_getraenke_typ Foreign key (tfk) References typ (id);


CREATE FUNCTION getTypeId(getraenkeID INTEGER)
    RETURNS INTEGER(11)
BEGIN
    RETURN (SELECT id
            FROM typ
            WHERE bez =
                  (SELECT TEMP_name
                   from csv_getraenke_temp
                   where TEMP_id < getraenkeID
                     and TEMP_pfand = 'Pfand'
                   ORDER BY TEMP_id DESC
                   LIMIT 1));
END;


INSERT INTO getraenke (name, preis, pfand, anz, liter, tfk)
SELECT TEMP_name,
       CAST(TEMP_preis AS DECIMAL(5, 2)),
       CAST(TEMP_pfand AS DECIMAL(5, 2)),
       CAST((SUBSTRING(TEMP_anzliter, 1, 2)) AS INTEGER),
       CAST(REPLACE(TRIM(SUBSTR(TEMP_anzliter, LOCATE('x ', TEMP_anzliter) + 2, 4)), ',', '.') AS DECIMAL(5, 2)),
       getTypeId(TEMP_id)
FROM csv_getraenke_temp
WHERE TEMP_pfand != ''
  AND TEMP_pfand != 'Pfand';


TRUNCATE typ;
INSERT INTO typ (bez)
SELECT TEMP_name
FROM csv_getraenke_temp
WHERE TEMP_pfand = 'Pfand';


SELECT id
FROM typ
WHERE bez =
      (SELECT TEMP_name
       from csv_getraenke_temp
       where TEMP_id < 23
         and TEMP_pfand = 'Pfand' > 0
       ORDER BY id DESC
       LIMIT 1);


SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;