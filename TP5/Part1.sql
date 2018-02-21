DESCRIBE facts;
-- Name					                              Null?    Type
-- ----------------------------------------- -------- ----------------------------
-- PUBLICATION_ID 			                     NOT NULL   VARCHAR2(100)
-- SQUAD_ID				                           NOT NULL   VARCHAR2(100)
-- DATE_ID				                           NOT NULL   VARCHAR2(20)
-- SUPPORT_ID				                         NOT NULL   VARCHAR2(200)


DESCRIBE authors;
--  Name					                             Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  AUTHOR_ID				                          NOT NULL   VARCHAR2(100)
--  FIRST_NAME					                                 VARCHAR2(25)
--  LAST_NAME					                                   VARCHAR2(25)


DESCRIBE collaborations;
--  Name					                             Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  SQUAD_ID				                          NOT NULL   VARCHAR2(100)
--  AUTHOR_ID				                          NOT NULL   VARCHAR2(100)


DESCRIBE dates;
--  Name					                             Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  DATE_ID				                            NOT NULL   VARCHAR2(20)
--  YEAR					                            NOT NULL   NUMBER
--  MONTH_LABEL					                                 VARCHAR2(10)
--  MONTH						                                     NUMBER
--  DAY						                                       NUMBER



DESCRIBE publications;
--  Name					                               Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  PUBLICATION_ID 			                      NOT NULL  VARCHAR2(100)
--  TITLE						                                    VARCHAR2(500)
--  ABSTRACT					                                  VARCHAR2(1500)
--  NB_PAGES					                                  NUMBER



DESCRIBE squads;
--  Name					                              Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  SQUAD_ID				                          NOT NULL   VARCHAR2(100)


DESCRIBE supports;
--  Name					                             Null?    Type
--  ----------------------------------------- -------- ----------------------------
--  SUPPORT_ID				                        NOT NULL   VARCHAR2(200)
--  TYPE						                                     VARCHAR2(15)
--  NUM						                                       VARCHAR2(30)




SELECT COUNT(*) FROM facts;
--  COUNT(*)
--  ----------
--    473176
--
-- PRIMARY KEY = {PUBLICATION_ID, SQUAD_ID}
-- FOREIGN KEY = {  PUBLICATION_ID REFERENCES PUBLICATIONS (PUBLICATIONS_ID)
--                  SQUAD_ID REFERENCES SQUADS (SQUAD_ID)
--                  DATE_ID REFERENCES DATES (DATE_ID)
--                  SUPPORT_ID REFERENCES SUPPORTS (SUPPORTS_ID)    }

SELECT COUNT(*) FROM authors;
--  COUNT(*)
--  ----------
--    454807
--
-- PRIMARY KEY = {AUTHOR_ID}
-- FOREIGN KEY = { }

SELECT COUNT(*) FROM collaborations;
--  COUNT(*)
--  ----------
--   1212896
--
-- PRIMARY KEY = {SQUAD_ID, AUTHOR_ID}
-- FOREIGN KEY = {  SQUAD_ID REFERENCES SQUADS (SQUAD_ID)
--                  AUTHOR_ID REFERENCES AUTHORS (AUTHOR_ID)    }

SELECT COUNT(*) FROM dates;
--  COUNT(*)
--  ----------
--       407
--
-- PRIMARY KEY = {DATES_ID}
-- FOREIGN KEY = { }

SELECT COUNT(*) FROM publications;
--  COUNT(*)
--  ----------
--    481659
--
-- PRIMARY KEY = {PUBLICATION_ID}
-- FOREIGN KEY = { }

SELECT COUNT(*) FROM squads;
--  COUNT(*)
--  ----------
--    479540
--
-- PRIMARY KEY = {SQUAD_ID}
-- FOREIGN KEY = { }

SELECT COUNT(*) FROM supports;
--  COUNT(*)
--  ----------
--     11243
--
-- PRIMARY KEY = {SUPPORT_ID}
-- FOREIGN KEY = { }
