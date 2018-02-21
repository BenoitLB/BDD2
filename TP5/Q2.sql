EXPLAIN PLAN FOR SELECT title FROM publications WHERE nb_pages > 20;
select * from table(dbms_xplan.display);
--  ----------------------------------------------------------------------------------
--  | Id  | Operation	        | Name	       | Rows  | Bytes | Cost (%CPU)| Time	   |
--  ----------------------------------------------------------------------------------
--  |   0 | SELECT STATEMENT  |		           |     1 |    86 |  1916   (1)| 00:00:23 |
--  |*  1 |  TABLE ACCESS FULL| PUBLICATIONS |     1 |    86 |  1916   (1)| 00:00:23 |
--  ----------------------------------------------------------------------------------
--  Predicate Information (identified by operation id):
--  ---------------------------------------------------
--  PLAN_TABLE_OUTPUT
--  ---------------------------------------------------
--     1 - filter("NB_PAGES">20)





EXPLAIN PLAN FOR SELECT title FROM publications NATURAL JOIN facts WHERE date_id = 2008;
select * from table(dbms_xplan.display);

--  -----------------------------------------------------------------------------------
--  | Id  | Operation	         | Name	        | Rows  | Bytes | Cost (%CPU)| Time	    |
--  -----------------------------------------------------------------------------------
--  |   0 | SELECT STATEMENT   |		          | 37258 |  4875K|  3593   (1)| 00:00:44 |
--  |*  1 |  HASH JOIN	       |		          | 37258 |  4875K|  3593   (1)| 00:00:44 |
--  |*  2 |   TABLE ACCESS FULL| FACTS	      | 37258 |  1237K|  1677   (1)| 00:00:21 |
--  |   3 |   TABLE ACCESS FULL| PUBLICATIONS |   481K|    45M|  1914   (1)| 00:00:23 |
--  -----------------------------------------------------------------------------------
--  PLAN_TABLE_OUTPUT
--  ------------------------------------------------------------------------------------------------------------------------------------------------------
--  Predicate Information (identified by operation id):
--  -------------------------------------------------
--  1 - access("PUBLICATIONS"."PUBLICATION_ID"="FACTS"."PUBLICATION_ID")
--  2 - filter(TO_NUMBER("FACTS"."DATE_ID")=2008)






EXPLAIN PLAN FOR SELECT title FROM publications WHERE publication_id IN (SELECT publication_id FROM facts WHERE date_id = 2008);
select * from table(dbms_xplan.display);
--  -------------------------------------------------------------------------------------
--  | Id  | Operation	           | Name	    | Rows  | Bytes | Cost (%CPU)| Time         |
--  -------------------------------------------------------------------------------------
--  |   0 | SELECT STATEMENT     |		          | 37252 |  4874K|  3593   (1)| 00:00:44 |
--  |*  1 |  HASH JOIN RIGHT SEMI|		          | 37252 |  4874K|  3593   (1)| 00:00:44 |
--  |*  2 |   TABLE ACCESS FULL  | FACTS	      | 37258 |  1237K|  1677   (1)| 00:00:21 |
--  |   3 |   TABLE ACCESS FULL  | PUBLICATIONS |	481K  | 	 45M|  1914   (1)| 00:00:23 |
--  -------------------------------------------------------------------------------------
--  PLAN_TABLE_OUTPUT
--  ------------------------------------------------------------------------------------------------------------------------------------------------------
--  Predicate Information (identified by operation id):
--  ---------------------------------------------------
--     1 - access("PUBLICATION_ID"="PUBLICATION_ID")
--     2 - filter(TO_NUMBER("DATE_ID")=2008)





EXPLAIN PLAN FOR SELECT title FROM publications NATURAL JOIN facts NATURAL JOIN collaborations NATURAL JOIN authors WHERE last_name = 'Rosenthal';
select * from table(dbms_xplan.display);
--  -----------------------------------------------------------------------------------------------
--  | Id  | Operation		                  | Name	        | Rows  | Bytes | Cost (%CPU)| Time     |
--  -----------------------------------------------------------------------------------------------
--  |   0 | SELECT STATEMENT	           |		            |     5 |  1120 |   4537	(1)| 00:00:55 |
--  |   1 |  NESTED LOOPS		             |		            |       |       | 	         |	        |
--  |   2 |   NESTED LOOPS		           |		            |     5 |  1120 |   4537	(1)| 00:00:55 |
--  |*  3 |    HASH JOIN		             |		            |     5 |   620 |    4527	(1)| 00:00:55 |
--  |*  4 |     HASH JOIN		             |		            |     5 |   340 |    2850	(1)| 00:00:35 |
--  |*  5 |      TABLE ACCESS FULL	     | AUTHORS	      |     2 |    50 |    618	(1)| 00:00:08 |

--  PLAN_TABLE_OUTPUT
--  -----------------------------------------------------------------------------------------------
--  |   6 |      TABLE ACCESS FULL	     | COLLABORATIONS |  1212K|    49M|    2227	(1)| 00:00:27 |
--  |   7 |     TABLE ACCESS FULL	       | FACTS	        |   473K|    25M|    1676	(1)| 00:00:21 |
--  |*  8 |    INDEX UNIQUE SCAN	       | PK_PUBLICATION |     1 |       |       1	(0)| 00:00:01 |
--  |   9 |   TABLE ACCESS BY INDEX ROWID| PUBLICATIONS   |     1 |   100 |       2	(0)| 00:00:01 |
--  -----------------------------------------------------------------------------------------------

--  Predicate Information (identified by operation id):
--  ---------------------------------------------------

--     3 - access("FACTS"."SQUAD_ID"="COLLABORATIONS"."SQUAD_ID")
--     4 - access("COLLABORATIONS"."AUTHOR_ID"="AUTHORS"."AUTHOR_ID")

--  PLAN_TABLE_OUTPUT
--  ------------------------------------------------------------------------------------------------
--     5 - filter("AUTHORS"."LAST_NAME"='Rosenthal')
--     8 - access("PUBLICATIONS"."PUBLICATION_ID"="FACTS"."PUBLICATION_ID")
















EXPLAIN PLAN FOR SELECT title FROM publications1 WHERE nb_pages > 20;
select * from table(dbms_xplan.display);
--  ---------------------------------------------------------------------------------------------
--  | Id  | Operation		                | Name	        | Rows  | Bytes | Cost (%CPU)| Time     |
--  ---------------------------------------------------------------------------------------------
--  |   0 | SELECT STATEMENT	          |		            |	    1 |	   86 |	    0   (0)| 00:00:01 |
--  |   1 |  TABLE ACCESS BY INDEX ROWID| PUBLICATIONS1 |	    1 |	   86 |	    0   (0)| 00:00:01 |
--  |*  2 |   INDEX RANGE SCAN	        | INDEX_PUB1    |	    1 |	      |	    0   (0)| 00:00:01 |
--  ---------------------------------------------------------------------------------------------
--  Predicate Information (identified by operation id):
--  PLAN_TABLE_OUTPUT
--  ------------------------------------------------------------------------------------------------------------------------------------------------------
--     2 - access("NB_PAGES">20)
