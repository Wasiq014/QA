Select 
clm.*
from ERAFile (NoLock) as fl
inner join ERAInterChange (NoLock) as isa on fl.ERAID = isa.ERAID
inner join ERAFunctionalGroup (NoLock) as gs on isa.InterChangeID = gs.InterChangeID
inner join ERATransaction (NoLock) as ts on gs.FunctionalGroupID = ts.FunctionalGroupID
inner join ERAPayer (NoLock) as n1 on ts.TSID = n1.TSID
inner join ERAPayee (NoLock) as pe on ts.TSID = pe.TSID
inner join ERAProviderSummary (NoLock)  as prs on ts.TSID = prs.TSID
left  join ERAClaim  (NoLock) as clm on prs.ProviderSummaryID = clm.ProviderSummaryID
left  join ERAPayeeIdentification (NoLock) as peId on pe.PayeeID = peId.PayeeID
left  join ERAPayerIdentification  (NoLock) as ref on n1.PayerID = ref.PayerID
left join ERAProcedure ep on ep.claimid = clm.claimid
left join eraprocedureadjustment epa on epa.procedureid = ep.procedureid
left join eraprocedureremark epr on epr.procedureid = ep.procedureid

 

where 
ts.checktraceno = ''
order by 1 desc