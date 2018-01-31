--Ajout de l'attribut prix, de type numérique à la relation Achats
ALTER TABLE Achats ADD prix NUMBER(*,2);


--Requêtes permettant de remplir le prix des Achats
UPDATE Achats SET prix = 10.80 WHERE refl = 'ISBN46545458';
UPDATE Achats SET prix = 30.70 WHERE refl = 'ISBN12111221';
