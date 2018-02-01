ALTER TABLE Livres ADD note_moy NUMBER(4,2);

-- Début du bloc PL/SQL
DECLARE
  no_liv Livres.refl%type;
  moyenne NUMBER(4,2);
  PAS_DE_LIVRE Exception;
  existe NUMBER;

BEGIN
  no_liv := &no_liv;

-- Requete calculant la moyenne
  SELECT COUNT(*) INTO existe
  FROM Livres
  WHERE refl = no_liv

  IF (existe = 0) THEN RAISE PAS_DE_LIVRE;
  ELSE
-- Requete ajoutant la moyenne au tuple
    SELECT AVG(note) into moyenne
    FROM Livres NATURAL JOIN Avis
    WHERE refl = no_liv
    GROUP BY (idcl);

    UPDATE Livres SET note_moy = moyenne WHERE refl = no_liv;
    DBMS_OUTPUT.Put_line('moyenne : ' || moyenne);

  END IF;

EXCEPTION
  WHEN PAS_DE_LIVRE THEN DBMS_OUTPUT.Put_line('reférence inexistante');




  --UTILISER Trigger BEFORE pour l'insertion

END;
/
