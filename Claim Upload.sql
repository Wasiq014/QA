select FTPUserName,FTPPassword,FTPURL,EncryptionPublicKey,FTPDirectory,FTPProtocol,FTPMode,FTPEncryption,SslFingerPrint,FTPPort,FTPClaimStatusDir,BatchEligibilityDir from CX_Profiles_ClientConfigurations

 

 

ediftps    E@d!fTp$    ftps.curemd.com    support@curemd.com    /incoming/CMDM2/Claims    FTPS    Active    ExplicitTLS    f1:0c:5d:32:03:c2:cf:8b:de:6d:16:26:b2:44:33:b8:bb:97:2d:1f    21    /Incoming/CMDM2/ClaimStatus/    /Incoming/CMDM2/Eligibility/

 


Update PMPRXFT
set vElectronicClaimID='CMDM2'
where IPRACID=1