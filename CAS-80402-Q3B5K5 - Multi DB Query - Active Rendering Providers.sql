IF Object_id('tempdb.dbo.#ResultSet', 'U') IS NOT NULL 
  DROP TABLE #RESULTSET; 

CREATE TABLE #RESULTSET 
  ( 
     [Server]                        VARCHAR(255), 
     [Database]                      VARCHAR(255), 
     [Practice Name]                 [VARCHAR](95),
     [Rendering Providers]			 VARCHAR(MAX)
  ) 

GO 

DECLARE @Database VARCHAR (50); 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

DECLARE GETNAME CURSOR STATIC FOR 
  SELECT NAME 
  FROM   SYS.databases 
  WHERE  NAME LIKE '%_CureMD'
         AND NAME NOT IN ( 'creationset%_curemd%', '%test%', 'demo_curemd', 'HL_CureMD', 'TrainingDB_CureMD', 'PHDBsets_CUreMD' , 'Sales_CureMD', 'PBDB_CureMD', 'Oncology_CureMD', 'OBGYNDB_CureMD', 'AppStore_CureMD', 'Fax_CureMD', 'oncdata_CureMD', 'ptchiro_CureMD', 'oncol_CureMD' ) 
         AND state_desc = 'ONLINE'; 

OPEN GETNAME; 

FETCH NEXT FROM GETNAME INTO @Database; 

WHILE @@Fetch_Status = 0 
  BEGIN 
      -- PRINT ( @Database );

      EXEC ( '   INSERT INTO [#ResultSet] 
	  select '''+ @@SERVERNAME +''', ''' + @Database + ''', pr.vname, ISNULL(STUFF((SELECT '', '' + prv.VFNAME + '' '' + prv.VLNAME 
			    from pmprvft prv
				where prv.VTYPE = ''provider''
				and prv.bActive = 1
				and prv.IPRACID = pr.IPRACID
		   FOR XML PATH('''')), 1, 1, ''''), '''')
	  from ['+ @Database+'].DBO.PMPRXFT pr WITH (NOLOCK)
	  where pr.isCureBillingClient = 1
	  
	     ' );

      FETCH NEXT FROM GETNAME INTO @Database;
  END; 

CLOSE GETNAME;
DEALLOCATE GETNAME; 

------------------------------------------------------------------------------------------------------------------------

SELECT * FROM  #RESULTSET