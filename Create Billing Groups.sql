1. First Query

select * from pmprxft
select * from pmplxft where vname = 'UNITED CLAIM SOLUTIONS'  --517
select * from pmplxft where vname = 'COVENTRY HEALTH CARE OF FLORIDA'  -- 15

 

select * into backup3242021_2groupsinfo from groupsinfo
select * into backup3242021_2groupproviderlist from groupproviderlist

 

select * from groupsinfo where ipracid=2 and iplanid=517
select * from groupproviderlist where igroupid in (select igroupid from groupsinfo where ipracid=2 and iplanid=517 )

2. Second Query

select * from ControlDB..practiceuserdata where vUserName like '%mdadminddc1%'
use ddc_CureMD

 

select * from PMPRXFT --ipracid = 2
--select * into GroupsInfo04272020 from GroupsInfo
--select * into GroupProviderList04272020 from GroupProviderList

 

--plans for which new billing groups are to be created
--select * from PMPLXFT where VNAME like '%BRIGHT HEALTH INSURANCE%' -- ipracid = 2, iplanid = 389

 


--replicate from the following plan
--select * from PMPLXFT where VNAME like 'COVENTRY HEALTH CARE OF FLORIDA' -- ipracid = 2, iplanid = 15
--select * from CMUSXHD where VUNAME like '%mdadminddc1%' --iuserid = 10

 

--select * from groupsinfo where iPlanid = 389    --no billing groups
--select * from groupsinfo where iPlanid = 15    --39 billing groups

 


--select * from GroupProviderList where iPracID = 2 and iGroupID in (select distinct iGroupID  from groupsinfo where iPlanid = 389)
--select * from GroupProviderList where iPracID = 2 and iGroupID in (select distinct iGroupID  from groupsinfo where iPlanid = 15)

 


--select distinct igroupid from GroupsInfo where iplanid = 15 -- 39 groups

 

-------------------------------------------------------------------------------------------------

 

---use ddc_CureMD

 

DECLARE @IPRACID INT = 2
DECLARE @IPlanId INT = 15 -- To be copied from
DECLARE @NEWPLANID INT = 517
DECLARE @IUserId INT = 10
DECLARE @GroupName VARCHAR(35) 
DECLARE @iGroupId INT
DECLARE @GroupDesc VARCHAR(100)
DECLARE @NPI VARCHAR(15) 
DECLARE @Type VARCHAR(50) = 'Billing'
DECLARE @TaxID VARCHAR(25)
DECLARE @Address1 VARCHAR(50)
DECLARE @Address2 VARCHAR(50) 
DECLARE @City VARCHAR(30)
DECLARE @Zipcode VARCHAR(9) 
DECLARE @UPIN VARCHAR(80)
DECLARE @State VARCHAR(2)
DECLARE @StateLicenceNo VARCHAR(30)
DECLARE @vPayToAddress1 VARCHAR(50) 
DECLARE @vPayToAddress2 VARCHAR(50) 
DECLARE @vPayToCity VARCHAR(30) 
DECLARE    @vPayToState VARCHAR(2) 
DECLARE @vPayToZipCode VARCHAR(9) 
DECLARE @SpecialtyID INT 
DECLARE @vEPIN VARCHAR(30)
DECLARE @vEPINType VARCHAR(3)
DECLARE @vTaxType VARCHAR(3)
DECLARE @ilocid INT
DECLARE @NewGroupId INT

 

 


DECLARE @T1 TABLE -- temp variable
(
    iGroupId INT,
    iPlanId INT
)

 


SELECT *,0 as IsProcessed INTO #TempTable
FROM GroupsInfo WHERE iplanid = @IPlanId and ipracid = @IPRACID
select * from #TempTable
--drop table #TempTable

 

WHILE exists(
    SELECT * FROM #TempTable WHERE isProcessed = 0
)

 

BEGIN
     select top 1 @iGroupId = iGroupID, @GroupName = vGroupName, @GroupDesc = vGroupDesc, @IPlanId = iPlanid, @vEPINType = vEPINType,
                  @TaxID = VTAXID, @Address1 = vAddress1, @Address2 = vAddress2, @City = vCity, @State = vState, 
                  @Zipcode = vzipcode, @UPIN = UPIN,  @StateLicenceNo = vStateLicenceNo, @vTaxType = vTaxType, @NPI = vNPI,
                  @vEPIN = vEPIN, @vPayToAddress1 = vPayToAddress1, @vPayToAddress2 = vPayToAddress2, @vPayToCity = vPayToCity, 
                  @vPayToState = vPayToState, @vPayToZipCode = vPayToZipCode, @SpecialtyID = SpecialtyID, @ilocid = ILocID
                  from #TempTable
                  Where isProcessed = 0 
                  order by iGroupID
                  
        exec InsertGroupsInfo @IPracID=@IPRACID,@vGroupName=@GroupName,@vGroupDesc=@GroupDesc,@vNPI=@NPI,@vType=@Type,@iPlanid=@NEWPLANID
        ,@iUserID=@IUserId,@ILocID=@ilocid,@vTAXID= @TaxID,@vAddress1=@Address1,@vAddress2=@Address2,@vCity=@City,@vzipcode=@Zipcode
        ,@UPIN=@UPIN,@vState=@State,@vStateLicenceNo=@StateLicenceNo,@vEPIN=@vEPIN,@vEPINType=@vEPINType,@vTaxType=@vTaxType,@vPayToAddr1=@vPayToAddress1,@vPayToAddr2=@vPayToAddress2,
        @vPayToCity=@vPayToCity,@vPayToState=@vPayToState
        ,@vPayToZipCode=@vPayToZipCode,@iSpecialtyID=@SpecialtyID 
        
        IF @@ROWCOUNT > 0
        BEGIN
            SELECT @NewGroupId =  IDENT_CURRENT( 'GroupsInfo' )  
            print IDENT_CURRENT( 'GroupsInfo' )  
            SELECT *,0 as IsProcessed INTO #TempTableProviderList
            FROM groupproviderlist WHERE iGroupID = @iGroupId  and ipracid = @IPRACID
            select * from #TempTableProviderList
            
            DECLARE @iprivlist VARCHAR(8000) 
            SELECT @iprivlist = COALESCE(@iprivlist + ',', '') + Cast(iPrvID as varchar(10)) 
            FROM #TempTableProviderList
            WHERE iGroupID = @iGroupId
            and iPracID = @IPRACID
            Select @iprivlist = @iprivlist + ','
            Select @iprivlist
            --exec InsertProviderList @IPracID=@IPRACID,@IGroupID=@NewGroupId,@MultipleSelection=@iprivlist,@ProviderType=@Type
            SELECT @iprivlist = NULL
            print @iGroupId
            print @NewGroupId
            Update #TempTableProviderList
            Set isProcessed = 1 where iGroupID = @iGroupId
    
            Select * from #TempTableProviderList
            drop table #TempTableProviderList
        END
        ELSE
        BEGIN
            INSERT INTO @T1 VALUES(@iGroupId, @IPlanId)
        END

 

    Update #TempTable
    Set isProcessed = 1 where iGroupID = @iGroupID
     
END

 

select * from #TempTable
drop table #TempTable

 

select * from @T1