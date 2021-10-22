select distinct edl.IAPPTID,edl.ResponsiblePlan  
into #resubmitData from EDIDetailLOG edl
group by edl.IAPPTID,edl.ResponsiblePlan--,DSENDDATE
having count(edl.PatientAccount) > 1

select pa.VLNAME +','+pa.VFNAME as [Patient Name],
edl.PatientAccount as [Claim Identifier],
cm.VLNAME +','+ cm.VFNAME as [User Name],
charge.DSDATE as [AppointmentDate] from 
#resubmitData rd 
inner join EDIDetailLOG edl on rd.IAPPTID = edl.IAPPTID
inner join pmvixtr charge on charge.IAPPTID = edl.IAPPTID
inner join EDIHeadLOG ehl on ehl.ILOGID=edl.ILOGID and cast (ehl.DSENDDATE as DATE ) in ('2021-06-16' ,'2021-06-17')
inner join pmptxft pa on pa.IPATID = edl.IPATID
inner join CMUSXHD cm on ehl.IUSERID = cm.IUSERID

drop table #resubmitData