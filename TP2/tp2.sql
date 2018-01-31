-- TP2 PLOUHINEC Glenn & LE BADEZET Benoît

-- Drop de toutes les tables déjà existantes pour éviter les problèmes

DROP TABLE Achats;
DROP TABLE Avis;
DROP TABLE Livres;
DROP TABLE Clients;

-- Drop de la séquence --
DROP SEQUENCE enormeEtSeq;

-- Création de la séquence qui servira pour les id de clients

CREATE SEQUENCE enormeEtSeq START WITH 0 INCREMENT BY 1 MINVALUE 0;


-- Création des 4 tables demandées

CREATE TABLE Clients (
  idcl NUMBER,
  nom VARCHAR2(20),
  pren VARCHAR2(15),
  adr VARCHAR2(30),
  tel VARCHAR2(12),
    -- Contrainte déclarant la clef primaire idcl
  CONSTRAINT clients_PK PRIMARY KEY (idcl)
);

CREATE TABLE Livres (
  refl VARCHAR2(20),
  titre VARCHAR2(20),
  auteur VARCHAR2(20),
  genre VARCHAR2(15),
	-- Contrainte déclarant la clef primaire refl
  CONSTRAINT livres_PK PRIMARY KEY (refl)
);

CREATE TABLE Achats (
  idcl NUMBER,
  refl VARCHAR2(20),
  dateachat DATE,
	-- Contrainte déclarant les clefs primaires idcl refl et dateachat
  CONSTRAINT achats_PK PRIMARY KEY (idcl, refl, dateachat),
CONSTRAINT achats_FKcl FOREIGN KEY(idcl) REFERENCES Clients(idcl) ON DELETE CASCADE,
  CONSTRAINT achats_FKli FOREIGN KEY(refl) REFERENCES Livres(refl) ON DELETE CASCADE,
	-- Contrainte indiquant que les livres doivent être achetés entre le 1er janvier 2008 et le 31 decembre 2013
  CONSTRAINT achats_C CHECK (dateachat >= '01-JAN-2008' AND dateachat <= '31-DEC-2013')
);

CREATE TABLE Avis (
  idcl NUMBER,
  refl VARCHAR2(20),
  note NUMBER(4,2),
  commentaire VARCHAR2(60),
	-- Contrainte déclarant les clefs primaires idcl et refl
  CONSTRAINT avis_PK PRIMARY KEY (idcl, refl),
  CONSTRAINT avis_FKcl FOREIGN KEY(idcl) REFERENCES Clients(idcl) ON DELETE CASCADE,
  CONSTRAINT avis_FKli FOREIGN KEY(refl) REFERENCES Livres(refl) ON DELETE CASCADE,
	-- Contrainte indiquant que les notes doivent être comprises entre 1 et 20
  CONSTRAINT avis_C CHECK (note >= 1 AND note <= 20)
);


-- Remplissage des tables

INSERT INTO Clients VALUES (enormeEtSeq.nextval,'Tellie','Fancois','13, rue des lilas', NULL);
INSERT INTO Clients VALUES (enormeEtSeq.nextval,'Mitri','Dimitri','256000, rue de Poutine', '0666224488');
INSERT INTO Clients VALUES (enormeEtSeq.nextval,'A peu pres','Jean-Michel','13', '0692145322');
INSERT INTO Clients VALUES (enormeEtSeq.nextval,'Etienne','Pouly','6, allée des liserons', '08366565');

INSERT INTO Livres VALUES ('ISBN46545458','50Shades Of GrayCode','Emmanuel MACRON','PROJEEEET!');
INSERT INTO Livres VALUES ('ISBN68767855','50Shades Of OCaml','Benoit LE BADEZET','SF');
INSERT INTO Livres VALUES ('ISBN12111221','Les MATERNELLES','Prenom MELA','Autobiographie');


INSERT INTO Achats VALUES (1,'ISBN12111221','28-MAR-2012');
INSERT INTO Achats VALUES (1,'ISBN46545458','12-DEC-2009');
INSERT INTO Achats VALUES (2,'ISBN46545458','12-JAN-2011');
INSERT INTO Achats VALUES (3,'ISBN46545458','12-JAN-2011');
INSERT INTO Achats VALUES (4,'ISBN46545458','13-FEB-2013');



INSERT INTO Avis VALUES (1, 'ISBN46545458', 19.51, 'incroyable ! renversant ! J''ai pleure !');
INSERT INTO Avis VALUES (2, 'ISBN12111221', 4.72, 'Pas terrible, je me suis endormi devant le cinéma');
INSERT INTO Avis VALUES (2, 'ISBN68767855', 12.21, null);



-- Les meilleures ventes : les livres (titre, auteur, genre) qui ont été achetés en plus de 10000 exemplaires.

SELECT titre, auteur, genre
FROM Livres NATURAL JOIN Achats
GROUP BY titre, auteur, genre
HAVING COUNT (refl) >= 10000;
-- HAVING COUNT (refl) >= 2;


-- Les livres qui obtiennent une note moyenne supérieure à 16;

SELECT titre, auteur, genre
FROM Livres NATURAL JOIN Avis
GROUP BY titre, auteur, genre
HAVING AVG(note) >= 16;

-- Les clients qui n'ont pas renseigné l'attribut commentaire d'un livre (quel client, livre, note).

SELECT nom, pren
FROM Clients NATURAL JOIN Livres NATURAL JOIN Avis
WHERE commentaire IS NULL;
