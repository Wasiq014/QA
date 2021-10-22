
--select * from ControlDB..PracticeUserData where vUserName like '%mdadminwellness%'
--use wellness_CureMD
--select * from PMPRVFT where VFNAME like '%ALYS%' --iprvid = 2555 --pracid 4

--select distinct iGroupID from GroupsInfo where iPracID = 4 --2531 groups
--select * from GroupProviderList where iPrvID = 2555 -- is not attached with any BG
 
 --select distinct iPrvID from GroupProviderList where iGroupID in (
 --select igroupid from GroupProviderList)

Declare @IPRVID Int
Declare @IPRACID Int
Declare @GroupType Varchar(15)

Select @IPRVID = 4506, @IPRACID = 2, @GroupType = 'Billing'
--Insert Into GroupProviderList (iGroupID, iPRVID, iPracID, bActive)
Select B.iGroupID, C.iPRVID, B.iPracID, 1
From GroupsInfo B
	Left Outer Join (
	Select IPrvID, IPracID From PMPRVFT Where bActive = 1
	And vType = 'PROVIDER'
	And bBilling = 1
	And IPRVID = Case When IsNull(@IPRVID, 0) = 0 Then IPRVID Else @IPRVID End
	) C

	On B.iPracID = C.iPracID
	Left Outer Join GroupProviderList A
	On A.iGroupID = B.iGroupID
	And C.iPRVID = A.IPRVID
	Where B.iPracID = @IPracID
	And B.vType = @GroupType
	And A.iPrvid Is Null
	And IsNull(C.iPRVID, 0) != 0
	And B.iGroupID in (
	Select iGroupID from GroupsInfo 
	)
	Order By B.iGroupID
	
	
	
	