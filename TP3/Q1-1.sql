-- Ajout de l'attribut note_moy a la table Livres
ALTER TABLE Livres ADD note_moy NUMBER(4,2);

-- Début du bloc PL/SQL

SET SERVEROUT ON;




-- Petit a
DECLARE
  liv Livres.refl%type;
  moyenne NUMBER(4,2);
  PAS_DE_LIVRE EXCEPTION;
  existe NUMBER(2);

BEGIN
  liv := '&liv';
  DBMS_OUTPUT.PUT_LINE('livre ? : ' || liv );

-- Requete calculant la moyenne
  SELECT COUNT(*) INTO existe
  FROM Livres
  WHERE refl = liv
  GROUP BY refl;

  IF (existe = 0) THEN RAISE PAS_DE_LIVRE;
  ELSE
-- Requete ajoutant la moyenne au tuple
    SELECT AVG(note) into moyenne
    FROM Avis
    WHERE refl = liv;

    UPDATE Livres SET note_moy = moyenne WHERE refl = liv;
    DBMS_OUTPUT.PUT_LINE('moyenne : ' || moyenne);

  END IF;

EXCEPTION
  WHEN PAS_DE_LIVRE THEN DBMS_OUTPUT.PUT_LINE('reférence inexistante' || existe);

END;
/






-- Petit b
DECLARE
  CURSOR c1 IS SELECT refl, AVG(note) AS m
               FROM Avis
               GROUP BY refl;
  ligne c1%rowtype;

BEGIN

-- Requete calculant la moyenne
  FOR ligne in C1 LOOP
    UPDATE LIVRES SET note_moy = ligne.m WHERE refl = ligne.refl;
  END LOOP;
  COMMIT;

END;
/





-- Petit c
CREATE OR REPLACE PROCEDURE MAJmoyenne IS

  CURSOR c1 IS SELECT refl, AVG(note) AS m
               FROM Avis
               GROUP BY refl;
  ligne c1%rowtype;

BEGIN
-- Requete calculant la moyenne
  FOR ligne in C1 LOOP
    UPDATE LIVRES SET note_moy = ligne.m WHERE refl = ligne.refl;
  END LOOP;
  COMMIT;

END MAJmoyenne;
/


--Appel de la procédure
BEGIN
  MAJmoyenne;
END;
/




-- Question 1 petit 2

CREATE TRIGGER tr_majmoy
BEFORE INSERT OR UPDATE ON Avis

DECLARE
  nbliv NUMBER;
  nmoy NUMBER;
BEGIN









SET SERVEROUT OFF;
