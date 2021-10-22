select bBlockUnAuthorizedLocations from pmprxft where IPRACID = 2

 

select * from PMPRXFT

 

 SELECT ul.ILOCID as LocationId  
     FROM UserLocation ul
     INNER JOIN PMLCXFT  lc on lc.ILOCID = ul.ILOCID
     WHERE ul.iUserId = 25

 

     select * from CMUSXHD where VUNAME = '%shahzaib%'

 


     exec dbo.sp_EDI_ERA_GetClaimsList @iSortOrder=N'1',@IPracId=N'2',@ChargesType=N'Normal',@postable=N'1',@ERAStatus=N'0',@PageSize=N'15',@SortField=N'LastName',@PostedAndMarkAsPosted=N'0',@ClaimStatus=N'',@IUserId=N'25',@PageNo=N'1',@IsProblematic=N'False',@MarkAsPosted=N'0'

 

     exec dbo.sp_EDI_ERA_GetClaimsList @iSortOrder=N'1',@IPracId=N'2',@ChargesType=N'Normal',@postable=default,@ERAStatus=N'0',@PageSize=N'15',@SortField=N'LastName',@PostedAndMarkAsPosted=N'0',@ClaimStatus=N'',@IUserId=N'25',@PageNo=N'1',@IsProblematic=N'True',@MarkAsPosted=N'0'

 

     select IApptID,* from ERAClaim where ClaimID in ( 238809, 238825)