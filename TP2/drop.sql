SET ECHO OFF
SPOOL clean.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0

SELECT 'DROP TABLE ' || table_name || ' CASCADE CONSTRAINT;'
FROM USER_TABLES ;

SPOOL OFF
SET ECHO ON