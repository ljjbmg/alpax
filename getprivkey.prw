user function getPrivKey()
  Local cPFX := "\certs\alpax2023.pfx"
  Local cKey := "\certs\01_033_key.pem"
  Local cError := ""
  Local cContent := ""
  Local lRet
  lRet := PFXKey2PEM( cPFX, cKey, @cError, "1Q2W3E4R5T6y@" )
  If( lRet == .F. )
    conout( "Error: " + cError )
  Else
    cContent := MemoRead( cKey )
    varinfo( "Key", cContent )
  Endif
Return

user function getCert()
  Local cPFX := "\certs\alpax2023.pfx"
  Local cCert := "\certs\01_033_cert.pem"
  Local cError := ""
  Local lRet
  lRet := PFXCert2PEM( cPFX, cCert, @cError, "1Q2W3E4R5T6y@" )
  If( lRet == .F. )
    conout( "Error: " + cError )
  Else
    cContent := MemoRead( cCert )
    varinfo( "Cert", cContent )
  Endif
return
