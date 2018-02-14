-- tp3.sql

prompt *************************************************************
prompt ******************** DROP TABLE *****************************
prompt *************************************************************

DROP TABLE Avis CASCADE CONSTRAINTS;
DROP TABLE Achats CASCADE CONSTRAINTS;
DROP TABLE Livres CASCADE CONSTRAINTS;
DROP TABLE Clients CASCADE CONSTRAINTS;
DROP TABLE Parcours CASCADE CONSTRAINTS;
DROP TABLE Compo_parcours CASCADE CONSTRAINTS;
DROP TABLE Inscrip_parcours CASCADE CONSTRAINTS;
DROP TABLE Inscrip_evt CASCADE CONSTRAINTS;

-- Drop de la séquence --
DROP SEQUENCE enormeEtSeq;


prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************

CREATE TABLE Clients (
	idcl 	NUMBER,
	nom		VARCHAR2(20),
	pren	VARCHAR2(15),
	adr		VARCHAR2(30),
	tel		VARCHAR2(12),
	CONSTRAINT pk_clients PRIMARY KEY(idcl)
);

CREATE TABLE Livres (
	refl	VARCHAR2(12),
	titre	VARCHAR2(50),
	auteur	VARCHAR2(20),
	genre	VARCHAR2(15),
	CONSTRAINT pk_livres PRIMARY KEY(refl)
);

CREATE TABLE Achats (
	idcl		NUMBER,
	refl		VARCHAR2(12),
	dateachat	DATE,
	CONSTRAINT pk_achats PRIMARY KEY(idcl,refl,dateachat),
	CONSTRAINT fk_achats_clients FOREIGN KEY(idcl) REFERENCES Clients(idcl),
	CONSTRAINT fk_achats_livres FOREIGN KEY(refl) REFERENCES Livres(refl),
	CONSTRAINT c_achats
		CHECK (dateachat BETWEEN to_date('01-01-2008','dd-mm-yyyy')
			AND to_date('31-12-2013','dd-mm-yyyy'))
);

CREATE TABLE Avis (
	idcl		NUMBER,
	refl		VARCHAR2(12),
	note		NUMBER(4,2),
	commentaire	VARCHAR2(50),
	CONSTRAINT pk_avis PRIMARY KEY(idcl,refl),
	CONSTRAINT fk_avis_clients FOREIGN KEY(idcl) REFERENCES Clients(idcl),
	CONSTRAINT fk_avis_livres FOREIGN KEY(refl) REFERENCES Livres(refl),
	CONSTRAINT c_avis CHECK (note BETWEEN 1 AND 20)
);


CREATE TABLE Parcours (
	idp		VARCHAR2(10),
	intitulep 	VARCHAR2(15),
	genre 		VARCHAR2(15),
	date_deb 	DATE,
	CONSTRAINT pk_pracours PRIMARY KEY(idp)
);


CREATE TABLE Compo_parcours (
	idp 	VARCHAR2(10),
	id_evt VARCHAR2(10),
	CONSTRAINT pk_compo PRIMARY KEY(idp, id_evt),
	CONSTRAINT fk_comp_p FOREIGN KEY(idp) REFERENCES Parcours(idp)
);


CREATE TABLE Inscrip_parcours (
	idcl 	NUMBER,
	idp 	VARCHAR2(10),
	CONSTRAINT pk_insc PRIMARY KEY(idp, idcl),
	CONSTRAINT fk_insc_p FOREIGN KEY(idp) REFERENCES Parcours(idp),
	CONSTRAINT fk_insc_cl FOREIGN KEY(idcl) REFERENCES Clients(idcl)
);


CREATE TABLE Inscrip_evt (
	idcl	 NUMBER,
	idp 	VARCHAR2(10),
	id_evt VARCHAR2(10),
	CONSTRAINT pk_evt_1 PRIMARY KEY(id_evt, idp, idcl),
	CONSTRAINT fk_evt_cl FOREIGN KEY(idcl) REFERENCES Clients(idcl),
	CONSTRAINT fk_evt_cp FOREIGN KEY(id_evt, idp) REFERENCES Compo_parcours(id_evt, idp)
);



-- Création de la séquence qui servira pour les id de clients

CREATE SEQUENCE enormeEtSeq START WITH 0 INCREMENT BY 1 MINVALUE 0;

prompt *************************************************************
prompt ******************** INSERT TUPLES **************************
prompt *************************************************************

INSERT INTO Clients VALUES (enormeEtSeq.nextval,'Tellie','Fancois','13, rue des lilas', NULL);
INSERT INTO Clients VALUES (enormeEtSeq.nextval,'Mitri','Dimitri','256000, rue de Poutine', '0666224488');
INSERT INTO Clients VALUES (enormeEtSeq.nextval,'A peu pres','Jean-Michel','13', '0692145322');
INSERT INTO Clients VALUES (enormeEtSeq.nextval,'Etienne','Pouly','6, allée des liserons', '08366565');

INSERT INTO Livres VALUES ('ISBN46545458','50Shades Of GrayCode','Emmanuel MACRON','PROJEEEET!');
INSERT INTO Livres VALUES ('ISBN68767855','50Shades Of OCaml','Benoit LE BADEZET','SF');
INSERT INTO Livres VALUES ('ISBN12111221','Les MATERNELLES','Prenom MELA','Otobiografie');


INSERT INTO Achats VALUES (1,'ISBN12111221','28-MAR-2012');
INSERT INTO Achats VALUES (1,'ISBN46545458','12-DEC-2009');
INSERT INTO Achats VALUES (2,'ISBN46545458','12-JAN-2011');
INSERT INTO Achats VALUES (3,'ISBN46545458','12-JAN-2011');
INSERT INTO Achats VALUES (4,'ISBN46545458','13-FEB-2013');



INSERT INTO Avis VALUES (1, 'ISBN46545458', 19.51, 'incroyable ! renversant ! J''ai pleure !');
INSERT INTO Avis VALUES (2, 'ISBN46545458', 8.69, 'Choqué et déçu');
INSERT INTO Avis VALUES (4, 'ISBN46545458', 15.42, 'Peut mieux faire');

INSERT INTO Avis VALUES (2, 'ISBN12111221', 4.72, 'Pas terrible, je me suis endormi devant le cinéma');
INSERT INTO Avis VALUES (2, 'ISBN68767855', 12.21, null);
