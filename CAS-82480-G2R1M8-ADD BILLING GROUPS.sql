DECLARE @IPRACID INT = 2
DECLARE @IPlanId INT
DECLARE @GroupName VARCHAR(35) = 'Gasnel Bryan'
DECLARE @GroupDesc VARCHAR(100)=NULL
DECLARE @NPI VARCHAR(15)= '1235110701'
DECLARE @Type VARCHAR(50) = 'Billing'
DECLARE @TaxID VARCHAR(25) = '660869659'
DECLARE @Address1 VARCHAR(50) = '4000 Beeston Hill Medical Center'
DECLARE @Address2 VARCHAR(50) = 'Suite 11'
DECLARE @City VARCHAR(30) = 'Christiansted'
DECLARE @Zipcode VARCHAR(9) = '00820'
DECLARE @UPIN VARCHAR(80)
DECLARE @State VARCHAR(2) = 'VI'
DECLARE @StateLicenceNo VARCHAR(30)
DECLARE @vPayToAddress1 VARCHAR(50) = 'PO Box 1112'
DECLARE @vPayToAddress2 VARCHAR(50) = ''
DECLARE @vPayToCity VARCHAR(30) = 'Christiansted'
DECLARE @vPayToState VARCHAR(2) = 'VI'
DECLARE @vPayToZipCode VARCHAR(9) = '00820'
DECLARE @SpecialtyID INT = 0

 

DECLARE @ilocid INT = 5
DECLARE @IUserId INT = 7
DECLARE @NewGroupId INT
DECLARE @iPrvID INT = 18
DECLARE @bActive INT = 1

 


DECLARE @T1 TABLE 
(
    iplanid int 
)

 

Declare plans scroll cursor for select distinct IPLANID from pmplxft WHERE IPRACID = @IPRACID  order by IPLANID asc

 

Open plans

 

Fetch First From plans Into @IPlanId
While @@fetch_status = 0
Begin
    
        exec InsertGroupsInfo @IPracID=@IPRACID,@vGroupName=@GroupName,@vGroupDesc=default,@vNPI=@NPI,@vType='Billing',@iPlanid=@IPlanId
        ,@iUserID=@IUserId,@ILocID=@ilocid,@vTAXID= @TaxID,@vAddress1=@Address1,@vAddress2=@Address2 ,@vCity=@City,@vzipcode=@Zipcode
        ,@UPIN='',@vState=@State,@vStateLicenceNo='',@vEPIN='',@vEPINType='0',@vTaxType='EIN',@vPayToAddr1=@vPayToAddress1, @vPayToAddr2=@vPayToAddress2,@vPayToCity=@vPayToCity,@vPayToState=@vPayToState
        ,@vPayToZipCode=@vPayToZipCode,@iSpecialtyID=0

        IF @@ROWCOUNT > 0
        BEGIN
            select @NewGroupId= IDENT_CURRENT('Groupsinfo')
			insert into GroupProviderList(iGroupID, iPrvID, iPracID, bActive)
			values(@NewGroupId, @iPrvID ,@IPRACID , @bActive)
        END
        ELSE
        BEGIN
            INSERT INTO @T1 VALUES(@IPlanId)
        END
        
Fetch Next From plans Into @IPlanId
End

 

Close plans
Deallocate plans

 
