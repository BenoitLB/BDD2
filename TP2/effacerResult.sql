ALTER TABLE CLIENTS DISABLE CONSTRAINT ALL ;                                    
ALTER TABLE LIVRES DISABLE CONSTRAINT ALL ;                                     
ALTER TABLE ACHATS DISABLE CONSTRAINT ALL ;                                     
ALTER TABLE AVIS DISABLE CONSTRAINT ALL ;                                       
DELETE FROM CLIENTS;                                                            
DELETE FROM LIVRES;                                                             
DELETE FROM ACHATS;                                                             
DELETE FROM AVIS;                                                               
ALTER TABLE CLIENTS ENABLE CONSTRAINT ALL ;                                     
ALTER TABLE LIVRES ENABLE CONSTRAINT ALL ;                                      
ALTER TABLE ACHATS ENABLE CONSTRAINT ALL ;                                      
ALTER TABLE AVIS ENABLE CONSTRAINT ALL ;                                        