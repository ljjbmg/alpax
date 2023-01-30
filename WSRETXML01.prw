#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"                   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWSRETXML01   บAutor  ณFagner / Biale     บ Data ณ  19/08/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEsta rotina tem como funcao Buscar o XML das notas fiscais  บฑฑ
ฑฑบ          ณde saํda transmitidas e canceladas.                          ฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP11 - ALPAX    							                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบParametrosณ _cNota = Serie + Nota da NF Emitida                        บฑฑ
ฑฑบ          ณ _cTipo = Tipo de Retorno Esperado                           ฑฑ
ฑฑบ          ณ          1 = Nota Transmitida                               ฑฑ
ฑฑบ          ณ          2 = Cancelamento                                   ฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบRetorno   ณ Conte๚do do XML                                            บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
                    
USER FUNCTION WSRETXML01(_cNota, _cTipo) // CLIENTE WEBSERVICE
                                                   
Local   _xURL       := GetMV("MV_SPEDURL")
Local   aArea		:= GetArea()
Private cURL        := _xURL+'/NFESBRA.apw'
Private cSoapAction := "http://webservices.totvs.com.br/nfsebra.apw/RETORNANOTAS"

cSoapSend := ''
cSoapSend += '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:nfs="http://webservices.totvs.com.br/nfsebra.apw">'
cSoapSend += '   <soapenv:Header/>'
cSoapSend += '   <soapenv:Body>'
cSoapSend += '      <nfs:RETORNANOTAS>'
cSoapSend += '         <nfs:USERTOKEN>TOTVS</nfs:USERTOKEN>'
cSoapSend += '         <nfs:ID_ENT>000001</nfs:ID_ENT>'
cSoapSend += '         <nfs:NFEID>'
cSoapSend += '            <nfs:NOTAS>'
cSoapSend += '               <nfs:NFESID2>'
cSoapSend += '                  <nfs:ID>'+_cNota+'</nfs:ID>'
cSoapSend += '               </nfs:NFESID2>'
cSoapSend += '            </nfs:NOTAS>'
cSoapSend += '         </nfs:NFEID>'
cSoapSend += '         <nfs:DIASPARAEXCLUSAO>0</nfs:DIASPARAEXCLUSAO>'
cSoapSend += '      </nfs:RETORNANOTAS>'
cSoapSend += '   </soapenv:Body>'
cSoapSend += '</soapenv:Envelope>'
                          
                  
oXml := ITFSvcSoapCall(cUrl, cSoapSend, cSoapAction, 1)

if type("oXml") <> "O"
      UserException("Falha de objeto oXML Consulta TSS")
      restarea(aArea)
     RETURN 
Endif

cXMLRET:= ''

If _cTipo == '1' // Transmissใo  
	iF TYPE('oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFE:_XML:TEXT	') <> 'U'
	    cXMLRET :=  '<nfeProc xmlns="http://www.portalfiscal.inf.br/nfe" versao="2.00">'
		cXMLRET +=  oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFE:_XML:TEXT	
		cXMLRET +=  oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFE:_XMLPROT:TEXT
		cXMLRET +=  '</nfeProc>'
	Endif
Else // Cancelamento                                                                   
	// Se retornar vazio a nota nใo tem cancelamento
	iF type("oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFECANCELADA:_XML:TEXT	")   =='U'
		cXMLRET:= ''
	Else
		if type("oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFECANCELADA:_XMLPROT:TEXT") == 'U'
			cXMLRET:= ''
		ElseIf 'CANCELAMENTO DE NF-E HOMOLOGADO' $ UPPER(oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFECANCELADA:_XMLPROT:TEXT)
			
			cRet := oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFECANCELADA:_XML:TEXT
			
			cXMLRET := '<procCancNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="2.00">'
			cXMLRET += cRet   //substr(cRet,39,len(cret))		
			cXMLRET += oXml:_RETORNANOTASRESPONSE:_RETORNANOTASRESULT:_NOTAS:_NFES3:_NFECANCELADA:_XMLPROT:TEXT
			cXMLRET += '</procCancNFe>'
			
			__cChaveNFE := SUBSTRING(cXMLRET,at("<chNFe>",cXMLRET) + 7,44)
		Endif		
	Endif
Endif
                     
restarea(aArea)
return(cXMLRET)
              
                
STATIC Function ITFSvcSoapCall(cUrl, cSoapSend, cSoapAction, DbgLevel)

// variaveis para o request e reponse do post
Local XMLPostRet := ""
Local nTimeOut	:= 120
Local aHeadOut	:= {}
Local XMLHeadRet := ""

// variaveis para checar o header response
Local cHeaderRet := ""
Local nPosCType := 0
Local nPosCTEnd := 0

// variaveis para o parser XML
Local oXmlRet := NIL
Local cError := ""
Local cWarning := ""

// variaveis para retirar ENVELOPE e BODY
Local aTmp1 := {}
Local aTmp2 := {}
Local cEnvSoap := ""
Local cEnvBody := ""
Local cSoapPrefix := ""

// variaveis para determinar soapfault
Local cFaultString := ""
Local cFaultCode := ""

DEFAULT DbgLevel := 0

// Adiciona informa็oes no header HTTP
aadd(aHeadOut,'SOAPAction: '+cSoapAction)
aadd(aHeadOut,'Content-Type: text/xml; charset=utf-8' )
// Acrescenta o UserAgent na requisi็ใo ...
aadd(aHeadOut,'User-Agent: Mozilla/4.0 (compatible; Protheus '+GetBuild()+')')

/*
If DbgLevel > 0
	conout(padc(" SOAPSEND ",79,"-"))
	conout(strtran(cSoapSend,"><",">"+CHR(13)+CHR(10)+"<"))
	conout(replicate("-",79))
Endif
*/

// REALIZANDO O POST
XMLPostRet := HttpPost(cUrl,"",cSoapSend,nTimeOut,aHeadOut,@XMLHeadRet)

// Verifica Retorno
If XMLPostRet == NIL
	wserrolog("WSCERR044 / Nใo foi possํvel POST : URL " + cURL)
	return .f.
ElseIf Empty(XMLPostRet)
	If !empty(XMLHeadRet)
		wserrolog("WSCERR045 / Retorno Vazio de POST : URL "+cURL+' ['+XMLHeadRet+']')
		return .f.
	Else
		wserrolog("WSCERR045 / Retorno Vazio de POST : URL "+cURL)
		return .f.
	Endif
Endif


If DbgLevel > 0
	conout(padc(" POST RETURN ",79,'='))
	If !empty(XMLHeadRet)
		conout(XMLHeadRet)
		conout(replicate('-',79))
	Endif
	conout(XMLPostRet)
	conout(replicate('=',79))
Endif


// --------------------------------------------------------
// Antes de Mandar o XML para o PArser , Verifica se o Content-Type ้ XML !
// --------------------------------------------------------
If !empty(XMLHeadRet)
	cHeaderRet := XMLHeadRet
	nPosCType := at("CONTENT-TYPE:",Upper(cHeaderRet))
	If nPosCType > 0
		cHeaderRet := substr(cHeaderRet,nPosCType)
		nPosCTEnd := at(CHR(13)+CHR(10) , cHeaderRet)
		cHeaderRet := substr(cHeaderRet,1,IIF(nPosCTEnd > 0 ,nPosCTEnd-1, NIL ) )
		If !"XML"$upper(cHeaderRet)
			wserrolog("WSCERR064 / Invalid Content-Type return ("+cHeaderRet+") from "+cURL+CHR(13)+CHR(10)+" HEADER:["+XMLHeadRet+"] POST-RETURN:["+XMLPostRet+"]")
			return .f.
		Endif
	Else
		wserrolog("WSCERR065 / EMPTY Content-Type return ("+cHeaderRet+") from "+cURL+CHR(13)+CHR(10)+" HEADER:["+XMLHeadRet+"] POST-RETURN:["+XMLPostRet+"]")
		return .f.
	Endif
Endif

//--------------------------------------------------------
// Passa pela XML Parser...
//-------------------------------------------------------
oXmlRet := XmlParser(XMLPostRet,'_',@cError,@cWarning)


If !empty(cWarning)
	wserrolog('WSCERR046 / XML Warning '+cWarning+' ( POST em '+cURL+' )'+CHR(13)+CHR(10)+" HEADER:["+XMLHeadRet+"] POST-RETURN:["+XMLPostRet+"]")
	return .f.
ElseIf !empty(cError)
	wserrolog('WSCERR047 / XML Error '+cError+' ( POST em '+cURL+' )'+CHR(13)+CHR(10)+" HEADER:["+XMLHeadRet+"] POST-RETURN:["+XMLPostRet+"]")
	return .f.
ElseIF oXmlRet = NIL
	wserrolog('WSCERR073 / Build '+GETBUILD()+' XML Internal Error.'+CHR(13)+CHR(10)+" HEADER:["+XMLHeadRet+"] POST-RETURN:["+XMLPostRet+"]")
	return .f.
Endif


//--------------------------------------------------------
// Identifica os nodes inicias ENVELOPE e BODY Eles devem ser os primeiros niveis do XML
// RETIRA OS NODES E RETORNA APENAS OS DADOS
//--------------------------------------------------------

If Empty(aTmp1 := ClassDataArr(oXmlRet))
	aTmp1 := NIL
	wserrolog('WSCERR056 / Invalid XML-Soap Server Response : soap-envelope not found.')
	return .f.
Endif

If empty(cEnvSoap := aTmp1[1][1])
	aTmp1 := NIL
	wserrolog('WSCERR057 / Invalid XML-Soap Server Response : soap-envelope empty.')
	return .f.
Endif

// Limpa a variแvel temporแria
aTmp1 := NIL

// ITFxGetInfo no lugar de xGetInfo ้ uma fun็ใo da LIB de WEB SERVICES
// Elimina este node, re-atribuindo o Objeto
oXmlRet := ITFxGetInfo( oXmlRet, cEnvSoap  )

If valtype(oXmlRet) <> 'O'
	wserrolog('WSCERR058 / Invalid XML-Soap Server Response : Invalid soap-envelope ['+cEnvSoap+'] object as valtype ['+valtype(oXmlRet)+']')
	return .f.
Endif

If Empty(aTmp2 := ClassDataArr(oXmlRet))
	aTmp2 := NIL
	wserrolog('WSCERR059 / Invalid XML-Soap Server Response : soap-body not found.')
	return .f.
Endif

If empty(cEnvBody := aTmp2[1][1])
	aTmp2 := NIL
	wserrolog('WSCERR060 / Invalid XML-Soap Server Response : soap-body envelope empty.')
	return .f.
Endif

// Limpa a variแvel temporแria
aTmp2 := NIL

// Elimina este node, re-atribuindo o Objeto
oXmlRet := ITFxGetInfo( oXmlRet, cEnvBody )

If valtype(oXmlRet) <> 'O'
	wserrolog('WSCERR061 / Invalid XML-Soap Server Response : Invalid soap-body ['+cEnvBody+'] object as valtype ['+valtype(oXmlRet)+']')
	return .f.
Endif

cSoapPrefix := substr(cEnvSoap,1,rat("_",cEnvSoap)-1)

If Empty(cSoapPrefix)
	wserrolog('WSCERR062 / Invalid XML-Soap Server Response : Unable to determine Soap Prefix of Envelope ['+cEnvSoap+']')
	return .f.
Endif

//--------------------------------------------------------
// TRATAMENTO DO SOAP FAULT, CASO TENHA SIDO RETORNADO UM
//--------------------------------------------------------
If ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:TEXT" ) != NIL
	// Se achou um soap_fault....
	
	cFaultString := ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:_FAULTCODE:TEXT" )
	
	If !empty(cFaultString)
		// deve ser protocolo soap 1.0 ou 1.1
		cFaultCode := ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:_FAULTCODE:TEXT" )
		cFaultString := ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:_FAULTSTRING:TEXT" )
	Else
		// caso contrario, trato como soap 1.2
		cFaultCode := ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:_FAULTCODE:TEXT" )
		If Empty(cFaultCode)
			cFaultCode := ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:"+cSoapPrefix+"_CODE:TEXT" )
		Else
			cFaultCode += " [FACTOR] " + ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:_FAULTACTOR:TEXT" )
		EndIf
		DEFAULT cFaultCode := ""
		cFaultString := ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:_DETAIL:TEXT" )
		If !Empty(cFaultString)
			cFaultString := ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:_FAULTSTRING:TEXT" ) + " [DETAIL] " + cFaultString
		Else
			cFaultString :=  ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:"+cSoapPrefix+"_REASON:"+cSoapPrefix+"_TEXT:TEXT" )
			DEFAULT cFaultString := ""
			cFaultString += " [DETAIL] " + ITFxGetInfo( oXmlRet ,cSoapPrefix+"_FAULT:"+cSoapPrefix+"_DETAIL:TEXT" )
			DEFAULT cFaultString := ""
		Endif
	Endif
	
	
	// Aborta processamento atual com EXCEPTION
	wserrolog('WSCERR048 / SOAP FAULT '+cFaultCode+' ( POST em '+cURL+' ) : ['+cFaultString+']')
	return .f.
	
Endif

//--------------------------------------------------------
// Passou por Tudo .. entใo retorna um XML parseado Bonitinho ...
//--------------------------------------------------------

return oXmlRet







/* ----------------------------------------------------------------------------------
Funcao        ITFxGetInfo no lugar de xGetInfo
Parametros     oObj = Objeto XML
cObjCpoInfo = propriedade:xxx do objeto a retornar
Retorno        Conteudo solicitado. Caso nใo exista , retorna xDefault
Se xDefault nใo especificado , default = NIL
Exemplo        xGetInfo( oXml , '_SOAP_ENVELOPE:_SOAP_BODY:_NODE:TEXT' )
---------------------------------------------------------------------------------- */
STATIC FUNCTION ITFxGetInfo( oXml ,cObjCpoInfo , xDefault , cNotNILMsg )

Local bEval    := &('{ |x| x:' + cObjCpoInfo +' } ')
Local xRetInfo
Local bOldError := Errorblock({|e| Break(e) })

BEGIN SEQUENCE
xRetInfo := eval(bEval , oXml)
RECOVER
xRetInfo := NIL
END SEQUENCE

ErrorBlock(bOldError)

DEFAULT xRetInfo := xDefault

If xRetInfo == NIL .and. !empty(cNotNILMsg)
	__XMLSaveInfo := .T.
	wserrolog("WSCERR041 / "+cNotNILMsg)
Endif

Return xRetInfo    


/*
===========================================================================================
funcao wserrolog(cTexto)
Faz o tratamento das excecoes, gravando no log do console e liberando as variaveis de ambiente
__lWsErro := .t. ou seja, com erro
__cWSErro := "Texto do erro"

*/
   
Static function wserrolog(cParam)

__lWsErro := .t.
__cWSErro := alltrim(cParam) 

ConOut(replicate("=",50))
ConOut(".")
ConOut("  wserrolog ")
ConOut("  Data: "+DTOC(DATE())+"  Hora: "+time())
ConOut("  "+cParam)
ConOut(".") 
ConOut(".")
ConOut(".")
ConOut(replicate("=",50))
                  
return nil
