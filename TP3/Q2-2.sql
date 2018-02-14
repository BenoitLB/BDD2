-- Début du bloc PL/SQL
SET FEEDBACK ON;
-- Déclaration des Attributs
DECLARE
  id Avis.idcl%type;
  liv Avis.refl%type;
  nnote Avis.note%type;
  comz Avis.commentaire%type;

  valide NUMBER;

  impModif EXCEPTION;

-- Début des commandes
BEGIN
  id := &id;
  liv := '&liv';
  nnote := &nnote;
  comz := '&comz';

  SELECT COUNT(refl) INTO valide
  FROM Avis
  WHERE idcl = id AND refl = liv;

  IF valide = 0 THEN RAISE impModif;
    ELSE UPDATE Avis SET note = nnote , commentaire = comz WHERE refl = liv AND idcl = id;
  END IF;

EXCEPTION
  WHEN impModif THEN DBMS_OUTPUT.PUT_LINE('Impossible de modifier un avis qui n''existe pas');

END;
/
