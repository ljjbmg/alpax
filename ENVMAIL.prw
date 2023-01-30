#include "TOTVS.CH"
#include "AP5MAIL.CH"
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณENVMAIL   บAutor  ณTOTALIT             บ Data ณ  03/19/19   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                              

User Function ENVMAIL(_pcOrigem,_pcDestino,_pcSubject,_pcBody,_pcArquivo,_plAutomatico,_pcBcc)

Local cUser 	 := GetMV("MV_RELACNT") 
Local cPass 	 := GetMV("MV_RELPSW") 
Local cSendSrv 	 := GetMV("MV_RELSERV")
Local cMsg 		 := ""
Local nSendPort  := 0, nSendSec := 1, nTimeout := 0
Local xRet
Local oServer, oMessage

If _pcDestino == NIL
	Return()
EndIf
_pcDestino := StrTran(_pcDestino," ","")

If _pcBcc == NIL
	_pcBcc := "nfesaida@alpax.com.br"  
EndIf
 
_pcBcc := StrTran(_pcBcc," ","")
 
If _pcOrigem == NIL
	_pcOrigem := GetMV("MV_WFMAIL")
EndIf
 
_pcOrigem := StrTran(_pcOrigem," ","")
 
If _pcSubject == NIL
	_pcSubject := "DANFE"
EndIf
   
nTimeout := 60 // define the timout para 60 seconds
   
oServer := TMailManager():New()
   
oServer:SetUseSSL( .F. )
oServer:SetUseTLS( .F. )
   
If nSendSec == 0
	nSendPort := 25 //porta default para SMTP
ElseIf nSendSec == 1
  	nSendPort := 465 //porta defaul SMTP com SSL
  	oServer:SetUseSSL( .T. )
Else
  	nSendPort := 587 //porta defaul para SMTPS com TLS
	oServer:SetUseTLS( .T. )
EndIf

xRet := oServer:Init( "", cSendSrv, cUser, cPass, , nSendPort )
If xRet != 0
	cMsg := "Nao foi possivel inicializar o servidor SMTP: " + oServer:GetErrorString( xRet )
	conout( cMsg )
	Return()
EndIf
   
xRet := oServer:SetSMTPTimeout( nTimeout )
If xRet != 0
	cMsg := "Nao foi possivel configurar timeout para " + cValToChar( nTimeout )
    conout( cMsg )
EndIf
   
xRet := oServer:SMTPConnect()
If xRet <> 0
	cMsg := "Nao foi possivel conectar no servidor SMTP: " + oServer:GetErrorString( xRet )
    conout( cMsg )
	Return()
EndIf
   
xRet := oServer:SmtpAuth( cUser, cPass )
If xRet <> 0
  	cMsg := "Nao foi possivel autenticar no servidor SMTP: " + oServer:GetErrorString( xRet )
  	conout( cMsg )
  	oServer:SMTPDisconnect()
  	Return()
EndIf
   
oMessage := TMailMessage():New()
oMessage:Clear()

_cHTML:='<HTML><HEAD><TITLE></TITLE>'                   
_cHTML+='	<META http-equiv=Content-Type content="text/html; charset=windows-1252">'
_cHTML+='	<META content="MSHTML 6.00.6000.16735" name=GENERATOR></HEAD>'
_cHTML+='	<BODY>'
_cHTML+='		<H1><FONT color=#ff0000>Esta mensagem refere-se a Nota Fiscal Eletr๔nica Nacional</FONT></H1>'
_cHTML+='		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#afeeee background="" border=1>'
_cHTML+='			<TBODY>'
_cHTML+='  				<TR>'
_cHTML+='    				<TD>Para verificar a autoriza็ใo da SEFAZ referente เ nota acima mencionada, acesse o sitio http://www.nfe.fazenda.gov.br/portal</TD>'
_cHTML+='    				<TD></TD>'
_cHTML+='  				</TR>'
_cHTML+='  				<TR>'
_cHTML+='    				<TD>Este e-mail foi enviado automaticamente pelo Sistema de Nota Fiscal Eletr๔nica (NF-e)</TD>'
_cHTML+='    				<TD></TD>'
_cHTML+='  				</TR>'
_cHTML+='  				<TR>'
_cHTML+='    				<TD>da ALPAX COMERCIO DE PRODUTOS PARA LABORATORIOS LTDA</TD>'
_cHTML+='    				<TD></TD>'
_cHTML+='  				</TR>'
_cHTML+='			</TBODY>'
_cHTML+='		</TABLE>'
_cHTML+='		<P>&nbsp;</P>'
_cHTML+='		<P><powered by TotvsServices - Totvs S/A</P>'
_cHTML+='	</BODY>'
_cHTML+='</HTML>'

If _pcBody == NIL
	_pcBody := _CHTML
EndIf
   
oMessage:cDate 		:= cValToChar( Date() )
oMessage:cFrom 		:= _pcOrigem
oMessage:cTo 		:= _pcDestino
oMessage:cCc        := _pcBcc
oMessage:cSubject 	:= _pcSubject
oMessage:cBody 		:= _pcBody
  
xRet := oMessage:AttachFile(_pcArquivo)
If xRet < 0
	cMsg := "Nao foi possivel anexar o arquivo " + _pcArquivo
    conout( cMsg )
    Return()
EndIf

xRet := oMessage:Send( oServer )
If xRet <> 0
	cMsg := "Nao foi possivel enviar o e-mail: " + oServer:GetErrorString( xRet )
    conout( cMsg )
EndIf
   
xRet := oServer:SMTPDisconnect()
If xRet <> 0
	cMsg := "Nao foi possivel desconectar o servidor SMTP: " + oServer:GetErrorString( xRet )
    conout( cMsg )
EndIf
Return()