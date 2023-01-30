user Function tstwsdl()

  Local oWsdl := TWsdlManager():New()
  Local xRet
  
  oWsdl:cSSLCACertFile := "\cert\ngf\ca_site.pem"
  
  xRet := oWsdl:ParseURL("https://preproducao.roadcard.com.br/sistemapamcard/services/WSPamcard?wsdl")
  if xRet == .F.
    conout( "Erro : " + oWsdl:cError )
  else
    conout( "Sucesso!" )
  endif
return
