SET ECHO OFF
SPOOL 2013-01-28-achats.lst
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING ON
SET LINESIZE 50
SET PAGESIZE 60
TTITLE CENTER 'Achats des clients au 28 janvier 2013'

-- Création de colonnes
COLUMN idcl   HEADING 'Idcl'
COLUMN dateachat  HEADING 'Date d''achat'  FORMAT A14
COLUMN genre   HEADING 'Genre'
COLUMN prix   HEADING 'Prix'  FORMAT 999.90

SELECT idcl, dateachat, genre, prix
FROM Achats NATURAL JOIN Livres
WHERE dateachat < '28-JAN-2013';


SPOOL OFF
SET ECHO ON
