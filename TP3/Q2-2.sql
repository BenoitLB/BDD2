-- On vérifie ici qu'un client ne modifie que les tuples qu'il a inséré.
-- On suppose que  l'idclient et la référence du livre sont passés en paramètre, en plus de la note et 
-- du commentaire que le client souhaite attribuer au livre.

-- Début du bloc PL/SQL
SET FEEDBACK ON;
-- Déclaration des Attributs
DECLARE
  idclient Avis.idcl%type;
  liv Avis.refl%type;
  nnote Avis.note%type;
  comz Avis.commentaire%type;

  valide NUMBER;

  impModif EXCEPTION;

-- Début des commandes
BEGIN
  idclient := &idclient;
  liv := '&liv';
  nnote := &nnote;
  comz := '&comz';

  SELECT COUNT(refl) INTO valide
  FROM Avis
  WHERE idcl = idclient AND refl = liv;

  IF valide = 0 THEN RAISE impModif;
    ELSE UPDATE Avis SET note = nnote , commentaire = comz WHERE refl = liv AND idcl = idclient;
  END IF;

EXCEPTION
  WHEN impModif THEN DBMS_OUTPUT.PUT_LINE('Impossible de modifier un avis qui n''existe pas');

END;
/


-- Faudra regarder le fait qu'il n'affiche pas les phrases
