SET ECHO OFF
SPOOL deleted.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0
SELECT 'DELETE FROM ' || table_name || ';'
FROM USER_TABLES ;
SPOOL OFF
SET ECHO ON


SET ECHO OFF
SPOOL droped.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0
SELECT 'DROP TABLE ' || table_name || ' CASCADE CONSTRAINT;'
FROM USER_TABLES ;
SPOOL OFF
SET ECHO ON
