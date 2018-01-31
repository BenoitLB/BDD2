SET ECHO OFF
SPOOL 2013-01-28-achats.lst
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0
"idcl   date achats   genre   prix  "
SELECT idcl, dateachat, genre, prix
FROM Achats NATURAL JOIN Livres;

SPOOL OFF
SET ECHO ON
