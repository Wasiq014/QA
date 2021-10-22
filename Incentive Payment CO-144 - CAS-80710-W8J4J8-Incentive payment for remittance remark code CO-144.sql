select distinct pt.VAccNo as [Act#] ,
PT_FirstName + ' ' + PT_LastName as [Patient Name], 
esr.PatientControlNumber as [Claim Identifier],
cast(ec.PayerClaimControlNo as varchar) AS [Payer Claim Control Number],
d.DAPTDATE as [DOS],
prv.VFNAME + ' ' + prv.VLNAME as [Provider Name] , 
CLM_ChargeAmount as [Total Charged Amount]
,CLM_PaymentAmount  as [Total Payment Amount]
,GRP_Reason as [Incentive Code]
,RC_AMT as [Incentive Amount]
 ,pl.vActualName as [Plan Actual Name]
 
from ERASummaryReport esr
inner join ERAClaim ec on esr.ClaimID = ec.ClaimID --and PlanPriority = 'P' and FilingIndicator = 'MC' 
inner join EDIDetailLOG d on d.IAPPTID = ec.IApptID
inner join PMPRVFT prv on prv.IPRVID = d.iActualPrvID
inner join pmptxft pt on pt.IPATID = d.IPATID
inner join pmplxft pl on pl.iplanid = ec.iplanid
 where GRP_Reason = 'CO-144' and cast(d.DAPTDATE as date) between '2019-01-01' and '2019-09-30' 
 and ec.ClaimID in (select max(claimid) claimid from eraclaim (nolock) group by PatientControlNumber)
group by pt.VAccNo ,esr.PatientControlNumber,
PT_FirstName,
PT_LastName,
prv.VFNAME,
prv.VLNAME,
ec.PayerClaimControlNo,
d.DAPTDATE ,
--prv.VFNAME + ' ' + prv.VLNAME as [Provider Name] , 
CLM_ChargeAmount 
,CLM_PaymentAmount
,GRP_Reason 
,RC_AMT
 ,pl.vActualName 
 order by RC_AMT