#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"                   
#include "Topconn.ch"
#include "TbiConn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณENVXML01     บAutor  ณFagner / Biale     บ Data ณ  19/08/13 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEsta rotina tem como funcao enviar o XML  e a DANFE de notasบฑฑ
ฑฑบ          ณfiscais de saํda transmitidas e canceladas aos clientes.     ฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP11 - ALPAX    							                  บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
                    
USER FUNCTION ENVXML01()

Private cPerg := "ENVXML"        
Private cXml := ''

fCriaSX1()                

If ! Pergunte(cPerg,.t.) 
	MsgInfo("Opera็ใo Cancelada pelo usuแrio !") 
	Return 
Endif

cQry := " SELECT F2_CLIENTE, F2_LOJA, F2_DOC, F2_SERIE, A1_NOME ,A1_EMAIL  " + CRLF
CqRY += " FROM "+RetSqlName("SF2")+" F2 " + CRLF
CqRY += " INNER JOIN "+RetSqlName("SA1")+" A1  " + CRLF
CqRY += " ON F2_CLIENTE = A1_COD AND F2_LOJA = A1_LOJA AND A1.D_E_L_E_T_ = '' AND A1_FILIAL = '"+xFilial("SA1")+"' " + CRLF
CqRY += " WHERE F2.D_E_L_E_T_ = '' " + CRLF
CqRY += " AND F2_FILIAL = '"+xFilial("SF2")+"' " + CRLF
CqRY += " AND F2_SERIE = '"+MV_PAR01+"' " + CRLF
CqRY += " AND F2_DOC BETWEEN '"+MV_PAR02+"' AND '"+MV_PAR03+"' " + CRLF
CqRY += " AND F2_CLIENTE BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR05+"' " + CRLF
CqRY += " AND F2_FIMP = 'S' " + CRLF                           

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"TMP",.T.,.T.)

DBSELECTAREA("TMP")                
TMP->(DBGOTOP())

WHILE TMP->(!EOF())                               

	Processa({||cXml := u_WSRETXML01(TMP->F2_SERIE+TMP->F2_DOC, '1') }, "Processando ... ")        
	
	If !file("\notas\"+TMP->F2_SERIE+TMP->F2_DOC+".pdf")
	    cMsgInfo := "Favor realizar PRIMEIRO a impressใo da DANFE referente a Nota Fiscal:  "+ CRLF+ CRLF+ TMP->F2_SERIE +  " - " + TMP->F2_DOC
		aviso("Arquivo PDF nใo existe ! ", cMsgInfo,{"OK"}, 2)          

		TMP->(DBSKIP())
	    loop 
	Endif
	
	If !empty(cXml)
		MEMOWRITE("\notas\"+TMP->F2_SERIE+TMP->F2_DOC+".xml", cXml)
		envnotas(TMP->A1_EMAIL, TMP->F2_SERIE+TMP->F2_DOC )
     	// Apago arquivo para comprometer o servidor 
     	ferase("\notas\"+TMP->F2_SERIE+TMP->F2_DOC+".xml")      
  	Else
  	    cMsgInfo := "Problemas encontrados com o XML referente a Nota Fiscal:  "+ CRLF+ CRLF+ TMP->F2_SERIE +  " - " + TMP->F2_DOC +; 
  	                CRLF+ CRLF+ "Verifique o Status desta nota na Rotina MONITOR da Nota Fiscal Eletr๔nica !" 
		aviso("Arquivo XML com problemas ! ", cMsgInfo,{"OK"}, 2)          
    Endif
                                        
     
	TMP->(DBSKIP())
Enddo
                    
                                                                   
TMP->(DBCLOSEAREA())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSX1  บAutor  ณFagner / Biale      บ Data ณ  19/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSX1()

PutSx1(cPerg,"01","Serie" 	   ,"Serie"      ,"Serie"      ,"mv_ch1","C",03,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","N.F. de"    ,"N.F. de"    ,"N.F. de"    ,"mv_ch2","C",09,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","N.F. ate"   ,"N.F. ate"   ,"N.F. ate"   ,"mv_ch3","C",09,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Cliente de" ,"Cliente de" ,"Cliente de" ,"mv_ch4","C",06,0,0,"G","","CLI","","","MV_PAR04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Cliente ate","Cliente ate","Cliente ate","mv_ch5","C",06,0,0,"G","","CLI","","","MV_PAR05","","","","","","","","","","","","","","","","",,,)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEnvNotas  บAutor  ณFagner / Biale      บ Data ณ  19/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFun็ใo para envio do XML e DANFE .                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function EnvNotas(cDest, cNota)

Private cFig := GetSrvProfString("StartPath","")                
Private lConectou := .f. 
Private lEnviado  := .f. 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefine informacoes referentes a configuracao do e-mail.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cServer   := ALLTRIM(GETMV("MV_RELSERV"))    //SERVIDOR SMTP
cAccount  := ALLTRIM(GETMV("MV_RELACNT"))    //CONTA DE EMAIL
cPassword := ALLTRIM(GETMV("MV_RELPSW"))     //SENHA DA CONTA                             
lAuth  	  := GetMv("MV_RELAUTH")             //AUTENTICA	

cEnvia    := cAccount                       //EMAIL ORIGEM
cCopia    := ""
cRecebe   := cDest                          //EMAIL DESTINATARIO
cAssunto  := "ALPAX NF: " + cNota          
cMensagem := "Envio de XML e DANFE referente a NF: " + cNota
_cCC        := ""
                          
PswOrder(2)
PswSeek(cUserName,.T.)                                                                            
inf := PswRet()

If !empty(inf[1,14])
	_cCC := inf[1,14]
Endif

CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lConectou
                                                            
If lAuth
	lOk :=  MailAuth(cAccount, cPassword)
	If !lOk
		lOk := QAGetMail() // Funcao que abre uma janela perguntando o usuario e senha para fazer autenticacao
	EndIf
Endif
                       
cAnexo := "\notas\"+cNota+".xml"
cAnexo += ";\notas\"+cNota+".pdf"

SEND MAIL FROM cEnvia  TO cRecebe CC _cCC BCC "" SUBJECT cAssunto BODY cMensagem ATTACHMENT cAnexo FORMAT TEXT RESULT lEnviado

If lEnviado
   cMensagem:="" 
   cItens:= ""
   MsgInfo("E-Mail enviado com sucesso!","Enviado")
Else
	cMensagem := ""
	GET MAIL ERROR cMensagem                                            
    MsgInfo(cMensagem, "E-mail NรO foi enviado")
Endif

DISCONNECT SMTP SERVER Result lDesConectou

Return