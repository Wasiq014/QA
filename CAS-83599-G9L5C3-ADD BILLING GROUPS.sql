select * from pmplxft 
where vname like '%wellcare%' -- 301

select * from pmplxft 
where vname like '%Amerihealth%' -- 29

select * from pmplxft 
where vname like '%Healthy Blue%' -- 562

select * from pmplxft 
where vname like '%UnitedHealthCare%' -- 559

select * from pmplxft 
where vname like '%Carolina Co%' -- 563

select * from pmlcxft where VNAME like '%Perquimans Behavioral Health%'

select * from GroupsInfo
order by 1 desc


select * from GroupProviderList
where iGroupID = 11200


----------------------------------------------------------
DECLARE 
@IPRACID INT = 2,
@IPlanId INT = 563, -- PlanId
@GroupName VARCHAR(35) = 'ALBEMARLE REGIONAL HEALTH SERVICES',
@GroupDesc VARCHAR(100)= NULL,
@NPI VARCHAR(15)= '1487738951',
@Type VARCHAR(50) = 'Billing',
@TaxID VARCHAR(25) = '566000798',
@Address1 VARCHAR(50) = '711 ROANOKE AVENUE',
@Address2 VARCHAR(50) = '',
@City VARCHAR(30) = 'ELIZABETH',
@Zipcode VARCHAR(9) = '279095643',
@UPIN VARCHAR(80) = '',
@State VARCHAR(2) = 'NC',
@StateLicenceNo VARCHAR(30) = '',
@vPayToAddress1 VARCHAR(50) = 'PO BOX 189',
@vPayToAddress2 VARCHAR(50) = '',
@vPayToCity VARCHAR(30) = 'Elizabeth City',
@vPayToState VARCHAR(2) = 'NC',
@vPayToZipCode VARCHAR(9) = '279070189',
@SpecialtyID INT = 0,
@ilocid INT = 19,
@IUserId INT = 100,
@NewGroupId INT,
@iPrvID INT,
@bActive INT = 1,
@TOTALPROVIDER INT,
@GroupType Varchar(15) = 'Billing'

DECLARE @T1 TABLE 
(
	iplanid int 
)

DECLARE @ProviderTable Table
(
	IPRVID INT,
	ROWNUMBER INT IDENTITY(1,1)
)

-- All providers 
INSERT @ProviderTable (IPRVID)
SELECT IPRVID
FROM PMPRVFT (NOLOCK)
WHERE bBilling = 1 
AND VTYPE = 'PROVIDER' 
AND bActive = 1
AND IPRACID = @IPRACID
		
SET @TOTALPROVIDER  = (SELECT COUNT(*) FROM @ProviderTable)

		exec InsertGroupsInfo 
			 @IPracID = @IPRACID,
			 @vGroupName = @GroupName, 
			 @vGroupDesc = default, 
			 @vNPI = @NPI,
			 @vType='Billing', 
			 @iPlanid = @IPlanId,
			 @iUserID = @IUserId,
			 @ILocID = @ilocid,
			 @vTAXID = @TaxID,
			 @vAddress1 = @Address1,
			 @vAddress2 = @Address2,
			 @vCity = @City, 
			 @vzipcode = @Zipcode,
			 @UPIN = @UPIN,
			 @vState = @State,
			 @vStateLicenceNo = @StateLicenceNo, 
			 @vEPIN = '' ,
			 @vEPINType ='0',
			 @vTaxType = '',
			 @vPayToAddr1 = @vPayToAddress1,
			 @vPayToAddr2 =@vPayToAddress2,
			 @vPayToCity = @vPayToCity,
			 @vPayToState = @vPayToState, 
			 @vPayToZipCode = @vPayToZipCode,
			 @iSpecialtyID = @SpecialtyID

		SELECT @NewGroupId = IDENT_CURRENT('GroupsInfo')

		IF(@NewGroupId > 0 AND @TOTALPROVIDER > 0)
		BEGIN

				DECLARE @rowNumber int = 1

				WHILE (@rowNumber <= @TOTALPROVIDER)
				BEGIN 
						SET @iPrvID = (SELECT IPRVID FROM @ProviderTable WHERE ROWNUMBER = @rowNumber )
				
						Insert Into GroupProviderList (iGroupID, iPRVID, iPracID, bActive)
						SELECT B.iGroupID, C.iPRVID, B.iPracID, 1
						FROM GroupsInfo B
						LEFT JOIN 
						 (
								SELECT IPrvID, IPracID 
								FROM PMPRVFT 
								WHERE bActive = 1
								AND vType = 'PROVIDER'
								AND bBilling = 1
								AND IPRVID = Case When IsNull(@IPRVID, 0) = 0 THEN IPRVID ELSE @IPRVID End
						  ) C

							On B.iPracID = C.iPracID
							LEFT JOIN GroupProviderList A On A.iGroupID = B.iGroupID AND C.iPRVID = A.IPRVID
							WHERE B.iPracID = @IPracID
								  AND B.vType = @GroupType
								  AND A.iPrvid IS NULL
								  AND ISNULL(C.iPRVID, 0) != 0
								  AND B.iGroupID in (SELECT iGroupID FROM GroupsInfo WHERE iGroupID = @NewGroupId)

							ORDER BY B.iGroupID

						SET @rowNumber = @rowNumber  + 1

				END

			END
	    
