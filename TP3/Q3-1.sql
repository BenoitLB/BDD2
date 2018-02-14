INSERT INTO Parcours VALUES ('idp1','saut d''obstacle', 'Science-Fiction','02-FEB-2013');
INSERT INTO Parcours VALUES ('idp2','100m haies', 'Policier','02-MAR-2013');

INSERT INTO Compo_parcours VALUES ('idp1','idevt1');
INSERT INTO Compo_parcours VALUES ('idp1','idevt2');
INSERT INTO Compo_parcours VALUES ('idp1','idevt3');
INSERT INTO Compo_parcours VALUES ('idp1','idevt4');
INSERT INTO Compo_parcours VALUES ('idp2','idevt1');
INSERT INTO Compo_parcours VALUES ('idp2','idevt3');
INSERT INTO Compo_parcours VALUES ('idp2','idevt5');
INSERT INTO Compo_parcours VALUES ('idp2','idevt6');



SET SERVEROUT ON;
-- Inscrit un client a un parcours, en passant le numero du client + le numero du parcours en parametre
-- Met egalement a jour la relation Inscrip_evt automatiquement
-- Debut du bloc PL/SQL
DECLARE
  idclient Clients.idcl%type;
  idparcours Parcours.idp%type;
  PAS_DE_CLIENT EXCEPTION;
  PAS_DE_PARCOURS EXCEPTION;
  existe NUMBER(2);
  pres NUMBER(2);
  CURSOR c1 IS SELECT id_evt
               FROM Compo_parcours NATURAL JOIN Parcours
               WHERE idp = idparcours;
  ligne c1%rowtype;

BEGIN
  idclient := '&idclient';
  DBMS_OUTPUT.PUT_LINE('idclient ? : ' || idclient );
  idparcours := '&idparcours'; 
  DBMS_OUTPUT.PUT_LINE('idparcours ? : ' || idparcours );

  SELECT COUNT(*) INTO existe
  FROM Clients
  WHERE idcl = idclient
  GROUP BY idcl;
  
  SELECT COUNT(*) INTO pres
  FROM Parcours
  WHERE idp = idparcours
  GROUP BY idp;

  IF (existe = 0) THEN RAISE PAS_DE_CLIENT;
  ELSE
    IF (pres = 0)THEN RAISE PAS_DE_PARCOURS;
    ELSE
        INSERT INTO Inscrip_parcours VALUES (idclient,idparcours);
        
        FOR ligne in C1 LOOP
            INSERT INTO Inscrip_evt VALUES (idclient, idparcours, ligne.id_evt);
        END LOOP;
        COMMIT;
    END IF;
  END IF;

EXCEPTION
  WHEN PAS_DE_CLIENT THEN DBMS_OUTPUT.PUT_LINE('Ce client n''existe pas' || idclient);
  WHEN PAS_DE_PARCOURS THEN DBMS_OUTPUT.PUT_LINE('Ce parcours n''existe pas' || idparcours);
END;
/





--Meme chose, mais sous forme de procedure

CREATE OR REPLACE PROCEDURE insert_evt_parcours IS
  idclient Clients.idcl%type;
  idparcours Parcours.idp%type;
  PAS_DE_CLIENT EXCEPTION;
  PAS_DE_PARCOURS EXCEPTION;
  existe NUMBER(2);
  pres NUMBER(2);
  CURSOR c1 IS SELECT id_evt
               FROM Compo_parcours NATURAL JOIN Parcours
               WHERE idp = idparcours;
  ligne c1%rowtype;
BEGIN
  idclient := '&idclient';
  DBMS_OUTPUT.PUT_LINE('idclient ? : ' || idclient );
  idparcours := '&idparcours'; 
  DBMS_OUTPUT.PUT_LINE('idparcours ? : ' || idparcours );

  SELECT COUNT(*) INTO existe
  FROM Clients
  WHERE idcl = idclient
  GROUP BY idcl;
  
  SELECT COUNT(*) INTO pres
  FROM Parcours
  WHERE idp = idparcours
  GROUP BY idp;

  IF (existe = 0) THEN RAISE PAS_DE_CLIENT;
  ELSE
    IF (pres = 0)THEN RAISE PAS_DE_PARCOURS;
    ELSE
        INSERT INTO Inscrip_parcours VALUES (idclient,idparcours);
        
        FOR ligne in C1 LOOP
            INSERT INTO Inscrip_evt VALUES (idclient, idparcours, ligne.id_evt);
        END LOOP;
        COMMIT;
    END IF;
  END IF;

EXCEPTION
  WHEN PAS_DE_CLIENT THEN DBMS_OUTPUT.PUT_LINE('Ce client n''existe pas' || idclient);
  WHEN PAS_DE_PARCOURS THEN DBMS_OUTPUT.PUT_LINE('Ce parcours n''existe pas' || idparcours);
END insert_evt_parcours;
/

--Appel de la procedure
BEGIN
    insert_evt_parcours;
END;
/


SET SERVEROUT OFF;
