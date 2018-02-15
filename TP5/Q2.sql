EXPLAIN PLAN FOR SELECT title FROM publications WHERE nb_pages > 20;
select * from table(dbms_xplan.display);
--  1 - filter("NB_PAGES">20)



EXPLAIN PLAN FOR SELECT title FROM publications NATURAL JOIN facts WHERE date_id = 2008;
select * from table(dbms_xplan.display);
--  1 - access("PUBLICATIONS"."PUBLICATION_ID"="FACTS"."PUBLICATION_ID")
--  2 - filter(TO_NUMBER("FACTS"."DATE_ID")=2008)




EXPLAIN PLAN FOR SELECT title FROM publications WHERE publication_id IN (SELECT publication_id FROM facts WHERE date_id = 2008);
select * from table(dbms_xplan.display);
-- 1 - access("PUBLICATION_ID"="PUBLICATION_ID")
-- 2 - filter(TO_NUMBER("DATE_ID")=2008)




EXPLAIN PLAN FOR SELECT title FROM publications NATURAL JOIN facts NATURAL JOIN collaborations NATURAL JOIN authors WHERE nb_pages > 20;
select * from table(dbms_xplan.display);
--




--
