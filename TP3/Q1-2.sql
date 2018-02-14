ALTER TABLE Livres ADD note_moy NUMBER(4,2);


-- Déclencheur qui met à jour l'attribut note_moy lorsqu'on ajoute un avis (un tuple) sur un livre
CREATE OR REPLACE TRIGGER tr_majmoy
BEFORE INSERT OR UPDATE ON Avis
FOR EACH ROW
DECLARE
  nbliv NUMBER;
  nmoy NUMBER;
BEGIN
  SELECT COUNT(refl) into nbliv
  FROM Avis
  WHERE refl = :new.refl;

  SELECT note_moy INTO nmoy
  FROM Livres
  WHERE refl = :new.refl;

  UPDATE LIVRES SET note_moy = ((nbliv * nmoy + :new.note) / (nbliv + 1)) WHERE refl = :new.refl;
END;
/


-- INSERT INTO Avis VALUES (3, 'ISBN46545458', 5.24, 'incroyable ! renversant ! J''ai pleure !');
-- UPDATE Avis SET note = 19 WHERE idcl = 3;


-- Ce trigger ne fonctionne seulement a l'ajout d'un nouveau tuple, en effet le problème des 
-- tables mutantes (une table avec les nouveaux attributs et les anciens) posent problème a la modification

-- Un correctif pourrait être de modifier ce trigger en deux triggers disctinct 
-- un pour l'ajout de tuples et l'autre pour la modification de tuples.
