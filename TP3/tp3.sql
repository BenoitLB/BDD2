-- @creation_insertion_tables.sql
spool creation_insertion_tables.log
prompt *************************************************************
prompt ******************** DROP TABLE *****************************
prompt *************************************************************

DROP TABLE AVIS CASCADE CONSTRAINTS;
DROP TABLE ACHATS CASCADE CONSTRAINTS;
DROP TABLE LIVRES CASCADE CONSTRAINTS;
DROP TABLE CLIENTS CASCADE CONSTRAINTS;

prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************

CREATE TABLE CLIENTS (
	idcl 	NUMBER,
	nom		VARCHAR2(20),
	pren	VARCHAR2(15),
	adr		VARCHAR2(30),
	tel		VARCHAR2(12),
	CONSTRAINT pk_clients PRIMARY KEY(idcl)
);

CREATE TABLE LIVRES (
	refl	VARCHAR2(10),
	titre	VARCHAR2(50),
	auteur	VARCHAR2(20),
	genre	VARCHAR2(15),
	CONSTRAINT pk_livres PRIMARY KEY(refl)
);

CREATE TABLE ACHATS (
	idcl		NUMBER,
	refl		VARCHAR2(10),
	dateachat	DATE,
	CONSTRAINT pk_achats PRIMARY KEY(idcl,refl,dateachat),
	CONSTRAINT fk_achats_clients FOREIGN KEY(idcl) REFERENCES CLIENTS(idcl),
	CONSTRAINT fk_achats_livres FOREIGN KEY(refl) REFERENCES LIVRES(refl),
	CONSTRAINT check_dateachat 
		CHECK (dateachat BETWEEN to_date('01-01-2008','dd-mm-yyyy')
			AND to_date('31-12-2013','dd-mm-yyyy'))
);

CREATE TABLE AVIS (
	idcl		NUMBER,
	refl		VARCHAR2(10),
	note		NUMBER(4,2),
	commentaire	VARCHAR2(50),
	CONSTRAINT pk_avis PRIMARY KEY(idcl,refl),
	CONSTRAINT fk_avis_clients FOREIGN KEY(idcl) REFERENCES CLIENTS(idcl),
	CONSTRAINT fk_avis_livres FOREIGN KEY(refl) REFERENCES LIVRES(refl),
	CONSTRAINT check_note_avis CHECK (note BETWEEN 1 AND 20)
);

prompt *************************************************************
prompt ******************** INSERT TUPLES **************************
prompt *************************************************************

INSERT INTO CLIENTS VALUES (1,'Moizeau','Isabelle','1 rue des roses','025031589');
INSERT INTO CLIENTS VALUES (2,'Guilet','Pierre','1 rue des roses','025031575');
INSERT INTO CLIENTS VALUES (3,'Dos Santos','Leonor','17 boulevard de Launay','065032089');
INSERT INTO CLIENTS VALUES (4,'Douillard','Lucie','20 avenue wonderland','085031566');

INSERT INTO LIVRES VALUES ('04B52','Fahrenheit 451','Ray Bradbury','science-fiction');
INSERT INTO LIVRES VALUES ('08E52','Le seigneur des anneaux','J. R. R. Tolkien','fantasy');
INSERT INTO LIVRES VALUES ('12V52','Le Guide du voyageur galactique','Douglas Adams','science-fiction');
INSERT INTO LIVRES VALUES ('AB52U','orgueil et prejuges','Jane Austen','romance');

INSERT INTO ACHATS VALUES (1,'04B52',to_date('10-10-2012','dd-mm-yyyy'));
INSERT INTO ACHATS VALUES (1,'08E52',to_date('01-01-2010','dd-mm-yyyy'));
INSERT INTO ACHATS VALUES (1,'12V52',to_date('10-10-2009','dd-mm-yyyy'));
INSERT INTO ACHATS VALUES (2,'04B52',to_date('05-02-2011','dd-mm-yyyy'));
INSERT INTO ACHATS VALUES (3,'04B52',to_date('05-02-2011','dd-mm-yyyy'));

INSERT INTO AVIS VALUES (1,'04B52',18,'tres juste.');
INSERT INTO AVIS VALUES (1,'08E52',15,'pas mal.');
INSERT INTO AVIS VALUES (1,'12V52',20,'imbattable.');
INSERT INTO AVIS VALUES (2,'04B52',20,'genial.');
INSERT INTO AVIS (idcl,refl,note) VALUES (3,'04B52',20);

spool off