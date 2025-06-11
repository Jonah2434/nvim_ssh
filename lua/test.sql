-- example.sql
-- Datenbank erstellen
CREATEDATABASE IFNOTEXISTSbeispiel_db;
USE beispiel_db;
-- Tabelle erstellen
CREATETABLEIFNOTEXISTSkunden(
idINTAUTO_INCREMENTPRIMARYKEY,
vornameVARCHAR(50),
nachnameVARCHAR(50),
emailVARCHAR(100)
);
-- Daten einfügen
INSERT INTO kunden(
vorname,
nachname,
email
)
VALUES(
'Max',
'Mustermann',
'max@example.com'
),
(
'Erika',
'Musterfrau',
'erika@example.com'
),
(
'John',
'Doe',
'john.doe@example.com'
);
