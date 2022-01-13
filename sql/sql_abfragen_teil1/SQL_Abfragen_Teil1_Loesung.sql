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
SELECT name, vorname, gebdat FROM mitarbeiter ORDER BY gebdat DESC;


# 6. Welche Mitarbeiter (Id, Name und Vorname) wurden vor dem 01.01.2005 eingestellt? (Hinweis: Datentyp DATE)
# Kontrollergebnis:
#   +---+-------+---------+
#   |id |Name   |Vorname  |
#   +---+-------+---------+
#   |1  |Lorenz |Sophia   |
#   |2  |Ritter |Tatjana  |
#   |3  |Wolff  |Theodor  |
#   |4  |Richter|Hans-Otto|
#   |8  |Hagen  |Friedhelm|
#   |...|...    |...      |
#   +---+-------+---------+
SELECT id, name, vorname FROM mitarbeiter WHERE eingestellt<DATE('2005-01-01');


# 7. Welche Mitarbeiter (Id, Name und Vorname) wurden im Jahr 2006 eingestellt? (Hinweis: YEAR)
# Kontrollergebnis:
#   +--+--------+------------+
#   |id|name    |vorname     |
#   +--+--------+------------+
#   |5 |Wieland |Brunhilde   |
#   |6 |Wolff   |Bettina     |
#   |11|Hoelzer |Richard     |
#   |19|Hoffmann|Theresa     |
#   |26|Hannes  |Klaus-Dieter|
#   |28|Lindner |Dieter      |
#   +--+--------+------------+
SELECT id, name, vorname, eingestellt FROM mitarbeiter WHERE YEAR(eingestellt)=2006;


# 8. Welche Mitarbeiter (Id, Name und Vorname) wurden im Jahr 2001 zwischen April und Oktober eingestellt?
#   +--+----------+-------+
#   |id|name      |vorname|
#   +--+----------+-------+
#   |18|Kaufmann  |Sonja  |
#   |24|Lauterbach|Wilma  |
#   +--+----------+-------+
SELECT id, name, vorname, eingestellt FROM mitarbeiter WHERE DATE('2001-04-01')<=eingestellt AND eingestellt<DATE('2001-11-01');


# 9. (a) Gesucht ist eine Liste aller Mitarbeiter (Id, Name und Vorname) und ihr dazu- gehöriges Alter. Achten Sie darauf, dass dieser SQL-Befehl immer das richtige Alter bestimmt und bei mehrfacher Ausführung zu unterschiedlichen Zeitpunk- ten nicht angepasst werden muss. (Hinweis: TimeStampDiff)
#    +---+-------+---------+-----+
#    |id |name   |vorname  |Alter|
#    +---+-------+---------+-----+
#    |1  |Lorenz |Sophia   |46   |
#    |2  |Ritter |Tatjana  |43   |
#    |3  |Wolff  |Theodor  |36   |
#    |4  |Richter|Hans-Otto|55   |
#    |5  |Wieland|Brunhilde|33   |
#    |...|...    |...      |...  |
#    +---+-------+---------+-----+
SELECT id, name, vorname, TIMESTAMPDIFF(year, gebdat, CURDATE()) AS 'Alter' FROM mitarbeiter;


# (b) Für Experten:
# Die Funktion TimeStampDiff gibt es nicht in allen SQL-Dialekten. Folgender Befehl für die Altersberechnung funktioniert unabhängig für jeden SQL-Dialekt. Dabei wird verwendet, dass der boolesche Wert für die Bedingung intern als Zahl repräsentiert wird (1 = TRUE, 0 = FALSE):
# Select id, name, vorname, YEAR(CURDATE()) - YEAR(geburtsdatum) -
#                           (DATE_FORMAT(CURDATE(), ’%m%d’) < DATE_FORMAT(geburtsdatum, ’%m%d’))
#     AS ’Alter’
# From Mitarbeiter;
# Informieren Sie sich über den den Befehl DATE_FORMAT und erklären Sie diese
# Altersberechnung.

