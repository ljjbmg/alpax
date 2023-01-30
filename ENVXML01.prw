#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"                   
#include "Topconn.ch"
#include "TbiConn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ENVXML01     �Autor  �Fagner / Biale     � Data �  19/08/13 ���
�������������������������������������������������������������������������͹��
���Desc.     �Esta rotina tem como funcao enviar o XML  e a DANFE de notas���
���          �fiscais de sa�da transmitidas e canceladas aos clientes.     ��
�������������������������������������������������������������������������͹��
���Uso       � AP11 - ALPAX    							                  ���
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
                    
USER FUNCTION ENVXML01()

Private cPerg := "ENVXML"        
Private cXml := ''

fCriaSX1()                

If ! Pergunte(cPerg,.t.) 
	MsgInfo("Opera��o Cancelada pelo usu�rio !") 
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
	    cMsgInfo := "Favor realizar PRIMEIRO a impress�o da DANFE referente a Nota Fiscal:  "+ CRLF+ CRLF+ TMP->F2_SERIE +  " - " + TMP->F2_DOC
		aviso("Arquivo PDF n�o existe ! ", cMsgInfo,{"OK"}, 2)          

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
  	                CRLF+ CRLF+ "Verifique o Status desta nota na Rotina MONITOR da Nota Fiscal Eletr�nica !" 
		aviso("Arquivo XML com problemas ! ", cMsgInfo,{"OK"}, 2)          
    Endif
                                        
     
	TMP->(DBSKIP())
Enddo
                    
                                                                   
TMP->(DBCLOSEAREA())

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fCriaSX1  �Autor  �Fagner / Biale      � Data �  19/08/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao para criacao das perguntas.                          ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fCriaSX1()

PutSx1(cPerg,"01","Serie" 	   ,"Serie"      ,"Serie"      ,"mv_ch1","C",03,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","N.F. de"    ,"N.F. de"    ,"N.F. de"    ,"mv_ch2","C",09,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","N.F. ate"   ,"N.F. ate"   ,"N.F. ate"   ,"mv_ch3","C",09,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Cliente de" ,"Cliente de" ,"Cliente de" ,"mv_ch4","C",06,0,0,"G","","CLI","","","MV_PAR04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Cliente ate","Cliente ate","Cliente ate","mv_ch5","C",06,0,0,"G","","CLI","","","MV_PAR05","","","","","","","","","","","","","","","","",,,)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EnvNotas  �Autor  �Fagner / Biale      � Data �  19/08/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o para envio do XML e DANFE .                          ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function EnvNotas(cDest, cNota)

Private cFig := GetSrvProfString("StartPath","")                
Private lConectou := .f. 
Private lEnviado  := .f. 

//���������������������������������������������������������
//�Define informacoes referentes a configuracao do e-mail.�
//���������������������������������������������������������

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
    MsgInfo(cMensagem, "E-mail N�O foi enviado")
Endif

DISCONNECT SMTP SERVER Result lDesConectou

Return