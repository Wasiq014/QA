select  sb.SubscriberId,sba.identificationQualifier,sba.identification,sba.description,rs.responsetext,* from RequestMast rq inner join Response rs on rq.requestID  = rs.requestID
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

	where sba.identificationQualifier is not null and sba.description is not null and rs.responsetext is not null and sba.identificationQualifier in ('1L','3H','CT','EA','18','6P','N6','Y4','SY','NQ','IG','HJ''GH','F6','EJ','1W') and rq.patientID= 33552

		select vaccno,* from PMPTXFT where VAccNo= 8358892

		 sba.SubscriberId = 28183
	select * from Elig_SBR_AdditionalInfo where SubscriberId=29959
	

	insert into Elig_SBR_AdditionalInfo values (28193,'CT',1252347541,'My name is khan')

	insert into Elig_SBR_AdditionalInfo values (28183,'F6',1414242,'My name is faizzan')

	delete from Elig_SBR_AdditionalInfo where ID in (3455,
3456,
3457)


	insert into Elig_SBR_AdditionalInfo values (28183,'IG',14152524242,'My name is faizzan')
	insert into Elig_SBR_AdditionalInfo values (28183,'SY',14145252242,'My name is faizz2an')
	insert into Elig_SBR_AdditionalInfo values (28183,'NQ',14145252242,'My name is faizghgzan')
	insert into Elig_SBR_AdditionalInfo values (28183,'Y4',1412524242,'My name is faizgfghzan')
	insert into Elig_SBR_AdditionalInfo values (28183,'F6',14142525242,'My name is fhhghaizzan')
	insert into Elig_SBR_AdditionalInfo values (28183,'SY',2252,'My name is faizzan')
	insert into Elig_SBR_AdditionalInfo values (28183,'6P',14525242,'My name is faizzan')
	insert into Elig_SBR_AdditionalInfo values (28183,'18',14242,'My name is ')