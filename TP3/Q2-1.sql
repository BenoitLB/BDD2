
-- Déclencheur qui permet de vérifier qu'un client qui ajoute un avis sur un livre l'a bien acheté au préalable.
-- Dans le cas contraire, on renvoie une exception.
CREATE OR REPLACE TRIGGER tr_ajout_poss
BEFORE INSERT ON Avis
FOR EACH ROW

DECLARE
  impossibru EXCEPTION;
  nblivacht NUMBER;

BEGIN
  SELECT COUNT(refl) into nblivacht
  FROM Achats
  WHERE refl = :new.refl AND idcl = :new.idcl;

  IF nblivacht = 0 THEN RAISE impossibru;
  END IF;

EXCEPTION
  WHEN impossibru THEN
    RAISE_APPLICATION_ERROR(-20090, 'On ne note pas un livre qu''on a pas achete, ou alors t''es un pirate et c''est pas bien ');

END;
/

-- INSERT INTO Avis VALUES (1, 'ISBN68767855', 19.51, 'incroyable ! renversant ! J''ai pleure !');
