SET ECHO OFF
SPOOL 2013-01-28-achats.lst
SET FEEDBACK OFF
SET HEADING ON
SET LINESIZE 50
SET PAGESIZE 60

-- Titre du rapport
TTITLE CENTER 'Achats des clients au 28 janvier 2013'

-- Suppression de la ligne de '_' au debut du tableau
SET UNDERLINE OFF

-- Création de colonnes
COLUMN idcl   HEADING 'Idcl'
COLUMN dateachat  HEADING 'Date d''achat'  FORMAT A14
COLUMN genre   HEADING 'Genre'
COLUMN prix   HEADING 'Prix'  FORMAT 999.90

-- Affiche les moyennes et les somme par client
BREAK ON idcl SKIP 1
COMPUTE AVG LABEL 'avg (moy)' -
SUM LABEL 'sum (som)' OF prix ON idcl

-- Requete permettant d'afficher ce qu'on souhaite afficher
SELECT idcl, dateachat, genre, prix
FROM Achats NATURAL JOIN Livres
WHERE dateachat < '28-JAN-2013'
GROUP BY (idcl, dateachat, genre, prix)
ORDER BY (idcl);


SPOOL OFF
SET ECHO OFF
SET FEEDBACK ON
