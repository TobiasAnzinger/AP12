Use gm2;

-- SQL-Abfragen für die Personalabteilung

# 1. In welcher Straße (incl. Hausnummer) wohnt Frau Sophia Lorenz? Kontrollergebnis:
#    +---------------+
#    |Strasse        |
#    +---------------+
#    |Hammer Str. 349|
#    +---------------+
SELECT strasse FROM mitarbeiter WHERE name='Lorenz' AND vorname='Sophia';

#     2. Gesucht ist das Einstellungsdatum von Sonja Kaufmann und Michael Wolff. Kontrollergebnis:
#    +-------+--------+-----------+
#    |vorname|name    |eingestellt|
#    +-------+--------+-----------+
#    |Sonja  |Kaufmann|2001-08-01 |
#    |Michael|Wolff   |2017-06-01 |
#    +-------+--------+-----------+
SELECT vorname, name, eingestellt FROM mitarbeiter WHERE (vorname='Sonja' AND name='Kaufmann') OR (vorname='Michael' AND name='Wolff');


# 3. Erstellen Sie eine alphabetisch sortierte Liste der Mitarbeiter (Name und Vorname). Dabei soll nach nach dem Nachnamen absteigend sortiert werden. Bei gleichen Nach- namen soll aufsteigend nach dem Vornamen sortiert werden.
# Kontrollergebnis:
#    +-------+----------+
#    |Name   |Vorname   |
#    +-------+----------+
#    |Wolff  |Bettina   |
#    |Wolff  |Michael   |
#    |Wolff  |Theodor   |
#    |Wieland|Brunhilde |
#    |Weber  |Karl-Heinz|
#    |...    |...       |
#    +-------+----------+
SELECT name, vorname FROM mitarbeiter ORDER BY name DESC, vorname ASC;


# 4. Erstellen Sie eine Liste aller Mitarbeiter mit Name und Vorname. Dabei soll zwischen Vor- und Nachname ein ", " gesetzt werden. Benennen Sie die Spalte entsprechend dem Kontrollergebnis. (Hinweis: Concat, Schlüsselwort AS in Select) Kontrollergebnis:
#   +-----------------+
#   |Nachname, Vorname|
#   +-----------------+
#   |Lorenz, Sophia   |
#   |Ritter, Tatjana  |
#   |Wolff, Theodor   |
#   |...              |
#   +-----------------+
SELECT CONCAT(name, ', ', vorname) FROM mitarbeiter;


# 5. Erstellen Sie ein Liste mit Vor-, Nachname und Geburtsdatum der Mitarbeiter. Die Liste soll dabei nach ihrem Alter aufsteigend sortiert sein. (Hinweis: Sie müssen dafür das Alter nicht berechnen.)
# Kontrollergebnis:
#   +------+-------+----------+
#   |name  |vorname|gebdat    |
#   +------+-------+----------+
#   |Huber |Sepp   |2001-04-04|
#   |Wolff |Michael|2000-01-13|
#   |Schlau|Susi   |1999-10-14|
#   |...   |...    |...       |
#   +------+-------+----------+
SELECT name, vorname, gebdat FROM mitarbeiter ORDER BY gebdat DESC
