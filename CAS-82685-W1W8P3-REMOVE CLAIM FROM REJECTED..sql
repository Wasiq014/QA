--select LatestResponseStatus,Latest_Status,VresponseStatus,* from edidetaillog where iapptid = 4035 and patientaccount ='CM0V41E4035'

--select Vresponsestatus,vstatus,* 
--from INS_Responses ir
--join ins_response_status irs on irs.iIRlogid = ir.iIRlogid
--where Vpatientaccount = 'CM0V41E4035'
--order by dIRLogDate desc

--update edidetaillog
--set LatestResponseStatus = 'Processed' ,
--Latest_Status = 'P' , VresponseStatus = 'Acknowledgement: ACKRECEIPT  ENTITY ACKNOWLEDGES RECEIPT OF CLAIMENCOUNTER. USAGE: THIS CODE REQUIRES USE OF AN ENTITY CODE.'
--where iapptid = 4035 and patientaccount ='CM0V41E4035'