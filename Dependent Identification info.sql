select dpa.DependentId,dpa.identificationQualifier,dpa.identification,dpa.description,rs.responsetext,* from RequestMast rq inner join Response rs on rq.requestID  = rs.requestID
	--Response Rejections, If data in this table exists, it wont come up in the Benefit Details and child tables
	LEFT join Elig_Resp_Rejections eRespRej on eRespRej.ResponseID = rs.responseID
inner join Elig_SourceLevel sl on sl.ResponseId = rs.responseID
	--Additional Information of sourcelevel
	left join Elig_SrcLevel_AdditionalInfo sla on sla.SrcLevel_Id = sl.SrcLevel_Id
	left join Elig_SrcLevel_Contact slc on slc.SrcLevel_Id = sl.SrcLevel_Id
inner join Elig_Subscriber sb on sb.SourceLevelId = sl.SrcLevel_Id
	--Additional Information of Subscriber
	left join Elig_SBR_AdditionalInfo sba on sba.SubscriberId = sb.SubscriberId
	left join Elig_SBR_Contact sbc on sbc.SubscriberId = sb.SubscriberId
	left join Elig_SBR_Date sbd on sbd.SubscriberId = sb.SubscriberId
	left join Elig_SBR_HcdDiagnosesCode sbDiagnosis on sbDiagnosis.SubscriberID = sb.SubscriberId
	left join Elig_SBR_MiltaryPersonnelInfo sbMil on sbMil.SubscriberID = sb.SubscriberId
left join Elig_Dependent dp on dp.SubscriberId = sb.SubscriberId
	--Additional Information of Dependent
	left join Elig_DPT_AdditionalInfo dpa on dpa.DependentId = dp.DependentId

	where dpa.identificationQualifier is not null and dpa.description is not null and rs.responsetext is not null and dpa.identificationQualifier in ('1L','3H','CT','EA','18','6P','N6','Y4','SY','NQ','IG','HJ''GH','F6','EJ','1W','MRC') 


		select vaccno,* from PMPTXFT where ipatid=34652


		
	select * from Elig_DPT_AdditionalInfo where DependentId=1038

		insert into Elig_DPT_AdditionalInfo values (1038,'Y4',5441444,'Eligibility')