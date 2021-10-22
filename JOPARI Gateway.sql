select cpi.CarrierCode,cpg.Name,pln.vActualName,pln.ClaimFilingInd,* from CX_Profiles_InsuranceCarrierMapping cpim 
inner join ControlDB..CX_Profiles_InsuranceCarrier cpi on cpi.CarrierCode=cpim.CarrierCode --and cpim.CarrierCode='59932'
inner join ControlDB..CX_Profiles_TransactionRoute cptr on cptr.CarrierID=cpi.CarrierID
inner join ControlDB..CX_Profiles_Gateway cpg on cpg.GatewayID=cptr.GatewayID
inner join pmplxft pln on pln.IPLANID=cpim.IPlanID


where  cpim.CarrierCode in('54281') and IsPreferred = 1 --cpg.Name in ('E-BILL WC NF PIP CLAIMS')
--or pln.vActualName in ('')
--or 
order by cpim.CarrierCode desc



select EHCFA,* from PMPRXFT where IPRACID = 1    

update PMPRXFT
set EHCFA = 0
where IPRACID = 1

select cpi.CarrierCode,cpg.Name,pln.vActualName,* from CX_Profiles_InsuranceCarrierMapping cpim 
inner join ControlDB..CX_Profiles_InsuranceCarrier cpi on cpi.CarrierCode=cpim.CarrierCode --and cpim.CarrierCode='59932'
inner join ControlDB..CX_Profiles_TransactionRoute cptr on cptr.CarrierID=cpi.CarrierID
inner join ControlDB..CX_Profiles_Gateway cpg on cpg.GatewayID=cptr.GatewayID
inner join pmplxft pln on pln.IPLANID=cpim.IPlanID


where  cpg.Name in ('AVAILITY') order by cpim.CarrierCode desc



54281