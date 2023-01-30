#include "protheus.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"
#include 'parmtype.ch'

User Function AXMainWF(cFilDoc,cNumDoc,nOpcWF,cDest,cGrpApv,cRej,cCodAprov)

Local oProcess
Local cMailID  		:= ""
Local aSM0Info 		:= FWSM0Util():GetSM0Data(,cFilDoc,{"M0_FILIAL"})
Local cAXURLWF 		:= SuperGetMV('AX_URLWF',.T.,'http://10.0.0.4:8800')
Default cGrpApv		:= ""
Default cRej		:= ""
Default cCodAprov	:= ""

cAprov   := cDest 
PswOrder(1)
If PswSeek(cAprov,.t.)// .and. cAprov <> "000000"
   	aInfo   := PswRet(1)
   	cMailAp := alltrim(aInfo[1,14])
   	cNomeAP := AllTrim(aInfo[1,2])
Endif

PswOrder(1)
If PswSeek(cCodAprov,.t.)// .and. cAprov <> "000000"
	aInfo    := PswRet(1)
   	cQuemAprv := AllTrim(aInfo[1,2])
Endif

Conout('--> Aprov: ' + cAprov)
VarInfo('aSM0Info: ',aSM0Info)
/* nOpcWF
1 = Envio de SC para aprovadores primeiro nivel
2 = Envio de aprova��o de SC para proximo nivel
3 = Aviso ao solicitante sobre aprova��o total da SC
4 = Aviso ao solicitante sobre reprova��o da SC

11= Envio de PC para aprovadores primeiro nivel
12= Envio de aprova��o de PC para proximo nivel
13 = Aviso ao solicitante sobre aprova��o total do PC
14 = Aviso ao solicitante sobre reprova��o do PC
*/

If nOpcWF == 1 .Or. nOpcWF == 2
	cModHTML := "\WORKFLOW\HTML\WF_SCFRM.HTML"	
	cModLINK := "\WORKFLOW\HTML\WF_SCINC.HTML"
	cSubject := "Solicitacao de Compra - " + cNumDoc
	cCodFrm  := "WF_SCFRM"  
ElseIf nOpcWF == 3
	cModHTML := "\WORKFLOW\HTML\WF_SCAPV.HTML"	
	cSubject := "[APROVADA] Solicitacao de Compra - " + cNumDoc
	cCodFrm  := "WF_SCAPV"  	
ElseIf nOpcWF == 4
	cModHTML := "\WORKFLOW\HTML\WF_SCREJ.HTML"
	cSubject := "[RECUSADA] Solicitacao de Compra - " + cNumDoc
	cCodFrm  := "WF_SCREJ"  	
ElseIf nOpcWF == 11 .Or. nOpcWF == 12
	cModHTML := "\WORKFLOW\HTML\WF_PGFRM.HTML"	
	cModLINK := "\WORKFLOW\HTML\WF_PGINC.HTML"
	cSubject := "Pedido de Compra - " + cNumDoc
	cCodFrm  := "WF_PGFRM" 
ElseIf nOpcWF == 13
	cModHTML := "\WORKFLOW\HTML\WF_PGAPV.HTML"	
	cSubject := "[APROVADO] Pedido de Compra - " + cNumDoc
	cCodFrm  := "WF_PGAPV"  
ElseIf nOpcWF == 14
	cModHTML := "\WORKFLOW\HTML\WF_PGREJ.HTML"
	cSubject := "[RECUSADO] Pedido de Compra - " + cNumDoc
	cCodFrm  := "WF_PGREJ"  			
Endif

nTotalPC := 0
cNomeFor := ""
cCodFor  := ""
cCondPag := ""
cCondDes := ""
DbSelectArea("SA2")
SA2->(DbSetOrder(1))

If nOpcWF < 10
	DbSelectArea("SC1")
	SC1->(dBSetOrder(1))  // C1_FILIAL+C1_NUM+C1_ITEM+C1_ITEMGRD
	SC1->(dBSeek(cFilDoc+cNumDoc))

	If !Empty(AllTrim(SC1->C1_FORNECE))
		SA2->(DbSeek(xFilial("SA2") + SC1->C1_FORNECE + SC1->C1_LOJA))
		cNomeFor := AllTrim(SA2->A2_NOME)
		cCodFor  := SC1->C1_FORNECE
	Endif	
	If !Empty(AllTrim(SC1->C1_CONDPAG))
		SE4->(DbSeek(xFilial("SE4") + SC1->C1_CONDPAG))
		cCondPag := AllTrim(SE4->E4_CODIGO) +"-"+ AllTrim(SE4->E4_DESCRI)
	Endif	

	cTpSol	:= "SC"
	cCodSol := SC1->C1_SOLICIT
	dDtEmis := dtoc(SC1->C1_EMISSAO)

	oProcess 			:= TWFProcess():New( "SOLCOM", "Solicita��o de Compras" )
	oProcess:NewTask( "Solicita��o", cModHTML )
	oProcess:fDesc := "Solicita��o de Compras "+SC1->C1_NUM
Else
	DbSelectArea("SC7")
	SC7->(dBSetOrder(1))  // C1_FILIAL+C1_NUM+C1_ITEM+C1_ITEMGRD
	SC7->(dBSeek(cFilDoc+cNumDoc))

	SA2->(DbSeek(xFilial("SA2") + SC7->C7_FORNECE + SC7->C7_LOJA))
	cNomeFor := AllTrim(SA2->A2_NOME)
	cCodFor  := SC7->C7_FORNECE
	cTpSol	:= "PC"
	cCodSol := SC7->C7_USER
	dDtEmis := dtoc(SC7->C7_EMISSAO)

	If !Empty(AllTrim(SC7->C7_COND))
		SE4->(DbSeek(xFilial("SE4") + SC7->C7_COND))
		cCondPag := AllTrim(SE4->E4_CODIGO)+"-"+AllTrim(SE4->E4_DESCRI)
	Endif	

	nTotalPC:= 0
	nRecSC7 := SC7->(RecNo())
    While SC7->(!EoF()) .And. SC7->C7_FILIAL == cFilDoc .And. SC7->C7_NUM == cNumDoc
        nTotalPC += SC7->C7_TOTAL 
    	
    	SC7->(DbSkip())
    EndDo	
	SC7->(DbGoTo(nRecSC7))

	oProcess 		:= TWFProcess():New( "PEDCOM", "Pedido de Compras" )
	oProcess:NewTask( "Pedido", cModHTML )
	oProcess:fDesc := "Pedido de Compras "+SC7->C7_NUM
Endif
		
oProcess:cSubject 	:= cSubject
oProcess:bReturn 	:= "U_RETSOLC()"
//oProcess:bTimeOut := {{"U_WFW120P(2)", 0 ,0 ,2 }}
//oProcess:bTimeOut := { { <cFuncao>, <nDias>, <nHoras>, <nMinutos> }
oHTML 				:= oProcess:oHTML

/*** Preenche os dados do cabecalho ***/
oHtml:ValByName("CONTROLE" , cNumDoc)
oHtml:ValByName("NUMSOL"   , cNumDoc)
oHtml:ValByName("DTSOL"    , dDtEmis)
oHtml:ValByName("DTPED"    , dDtEmis)
oHtml:ValByName("CODFIL"   , cFilDoc)
oHtml:ValByName("CODRET"   , cCodFrm)
oHtml:ValByName("GRPAPRV"  , cGrpApv)
oHtml:ValByName("TOTAL"    , Transform(nTotalPC,"@E 999,999,999.99")   )    
oHtml:ValByName("CODFOR"   , cCodFor)
oHtml:ValByName("NOMEFOR"  , cNomeFor)
oHtml:ValByName("CONDPAG"  , cCondPag)


If nOpcWF < 10		
	PswOrder(2) // pesquisar pelo nome do usu�rio
	If PswSeek(cCodSol,.T.)
		aRet := PswRet(1)
		oHtml:ValByName("NOMESOL", aRet[1,4])
	Endif	

	While SC1->(!Eof() .and. SC1->C1_FILIAL = cFilDoc .and. SC1->C1_NUM = cNumDoc)
		SB1->(dBSetOrder(1))  // B1_FILIAL+B1_COD
		SB1->(dBSeek(xFilial("SB1")+SC1->C1_PRODUTO))

		AAdd((oHtml:ValByName( "s.1" )) ,SC1->C1_ITEM )		
		AAdd((oHtml:ValByName( "s.2" )) ,SC1->C1_PRODUTO )
		AAdd((oHtml:ValByName( "s.7" )) ,SB1->B1_PNUMBER )			       
		AAdd((oHtml:ValByName( "s.8" )) ,SB1->B1_CAPACID )		      
		AAdd((oHtml:ValByName( "s.6" ))	,SB1->B1_DESC )		              
		AAdd((oHtml:ValByName( "s.3" )) ,TRANSFORM( SC1->C1_QUANT,"@E 999,999.99" ) )		              		                     
		AAdd((oHtml:ValByName( "s.4" )) ,SC1->C1_DATPRF)  	              
		AAdd((oHtml:ValByName( "s.5" )) ,SC1->C1_OBS )		              
				
		SC1->(dBSkip())
	Enddo
Else
	PswOrder(1) // pesquisar pelo nome do usu�rio
	If PswSeek(cCodSol,.T.)
		aRet := PswRet(1)
		oHtml:ValByName("NOMESOL", aRet[1,4])
	Endif		
	While SC7->(!Eof() .and. SC7->C7_FILIAL = cFilDoc .and. SC7->C7_NUM = cNumDoc)
		SB1->(dBSetOrder(1))  // B1_FILIAL+B1_COD
		SB1->(dBSeek(xFilial("SB1")+SC7->C7_PRODUTO))

		AAdd((oHtml:ValByName( "p.1" )) ,SC7->C7_ITEM )		
		AAdd((oHtml:ValByName( "p.2" )) ,SC7->C7_PRODUTO )		       
		AAdd((oHtml:ValByName( "p.9" )) ,SB1->B1_PNUMBER )		      
		AAdd((oHtml:ValByName( "p.10")) ,SB1->B1_CAPACID )		      
		AAdd((oHtml:ValByName( "p.8" ))	,SB1->B1_DESC )		              
		AAdd((oHtml:ValByName( "p.3" )) ,TRANSFORM( SC7->C7_QUANT,"@E 999,999.99" ) )	
		AAdd((oHtml:ValByName( "p.4" )) ,TRANSFORM( SC7->C7_PRECO,"@E 999,999.99" ) )	
		AAdd((oHtml:ValByName( "p.5" )) ,TRANSFORM( SC7->C7_TOTAL,"@E 999,999.99" ) )	              		                     
		AAdd((oHtml:ValByName( "p.6" )) ,SC7->C7_DATPRF )  	              
		AAdd((oHtml:ValByName( "p.7" )) ,SC7->C7_OBS )		              
				
		SC7->(dBSkip())
	Enddo
Endif
		
If nOpcWF == 1 .Or. nOpcWF == 2 .Or. nOpcWF == 11 .Or. nOpcWF == 12
	oHtml:valByName("CODAPRV",cAprov )

	cNomeFil := ""
	aSM0Info := FWSM0Util():GetSM0Data(cEmpAnt,cFilDoc,{"M0_FILIAL"})
	If Len(aSM0Info) > 0
		cNomeFil := AllTrim(aSM0Info[1,2])
	Endif
	
	oProcess:ClientName( Subs(cUsuario,7,15) )
	oProcess:cTo := cAprov  
	cMailID := oProcess:Start()

	oProcess:NewTask( "MSGLINK",cModLINK )
	oHtml:valByName("DESTAPV",cNomeAP)
	oHtml:ValByName("LINK",cAXURLWF + "/workflow/messenger/emp"+cEmpAnt+"/"+cAprov+"/"+cMailID+".htm")
	oProcess:cTo 	  := cMailAp//"teste@alpax.com.br"
	//oProcess:cTo 	  := "aresteves@totalitsolutions.com.br"
	oProcess:cSubject := "Aprovacao via link - Filial: " + cNomeFil + " | " + cTpSol + ": " + cNumDoc
	oProcess:Start()	
Else

	conout("Nome do Aprovador: " + cQuemAprv)
	conout("email destino: " + cMailAp)

	oHtml:valByName('MOTREJ', cRej)
	oHtml:valByName("DESTAPV",cQuemAprv)
	oProcess:cTo 	  := cMailAp//"teste@alpax.com.br"  
	//oProcess:cTo 	  := "aresteves@totalitsolutions.com.br"  
	cMailID := oProcess:Start()
Endif		
		
oProcess:Finish()
//		oProcess:Free() 
		
Return

User Function RETSOLC(oProcess)
Local cCodUsr 	:= SubStr(Alltrim(oProcess:oHtml:RetByName("CODAPRV")),1,6)
Local cLocal  	:= oProcess:oHtml:RetByName("CODFIL")
Local cGrpApv 	:= Alltrim(oProcess:oHtml:RetByName("GRPAPRV"))
Local cRej	  	:= oProcess:oHtml:RetByName("MOTREJ")
Local cRetAprov := oProcess:oHtml:RetByName("RADIOAPROVAR")
Local cCodRet	:= oProcess:oHtml:RetByName("CODRET")  
Local lRet    	:= .T.

/*
A110Aprov()

"Solicitac�o Aprovada" 	OPC = 1
"Solicitac�o Rejeitada" OPC = 2
"Solicitac�o Bloqueada" OPC = 3
*/

DbSelectArea("SCR")
SCR->(dBSetOrder(2))   // CR_FILIAL+CR_TIPO+CR_NUM+CR_USER

If UPPER(cCodRet) == "WF_SCFRM"
	cNumSC  	:= Alltrim(oProcess:oHtml:RetByName("NUMSOL"))
	DbSelectArea("SC1")
	SC1->(DbSetOrder(1))
	SC1->(DbSeek( cLocal + cNumSC ))
	If SC1->C1_APROV == "B"
		If cRetAprov = "S" 
			If SCR->(dBSeek(cLocal+"SC"+PADR(cNumSC,TamSX3("CR_NUM")[1])+cCodUsr))
				While SCR->(!EoF()) .And. SCR->CR_FILIAL == cLocal .And. SCR->CR_TIPO == "SC" .And. SCR->CR_NUM == PADR(cNumSC,TamSX3("CR_NUM")[1]) .And. SCR->CR_USER == cCodUsr
					If SCR->CR_GRUPO == cGrpApv
						lRet := A097ProcLib(SCR->(Recno()),2,,,,,dDataBase)
					Endif
					SCR->(DbSkip())
				EndDo
			Endif
			nOpcA:= 1
		Else
			If SCR->(dBSeek(cLocal+"SC"+PADR(cNumSC,TamSX3("CR_NUM")[1])+cCodUsr))
				While SCR->(!EoF()) .And. SCR->CR_FILIAL == cLocal .And. SCR->CR_TIPO == "SC" .And. SCR->CR_NUM == PADR(cNumSC,TamSX3("CR_NUM")[1]) .And. SCR->CR_USER == cCodUsr
					If SCR->CR_GRUPO == cGrpApv
						lRet := A097ProcLib(SCR->(Recno()),3,,,,,dDataBase)
						RecLock("SCR",.F.)
						SCR->CR_OBS := cRej
						MsUnlock()
					Endif
					SCR->(DbSkip())
				EndDo
			Endif
			nOpcA:= 2
		Endif

		ExecBlock("MT110END",.F.,.F.,{cNumSc,nOpcA,cLocal,cCodUsr,cRej})
	Endif

ElseIf UPPER(cCodRet) == "WF_PGFRM"
	cNumSC  	:= Alltrim(oProcess:oHtml:RetByName("CONTROLE"))
	DbSelectArea("SC7")
	SC7->(DbSetOrder(1))
	SC7->(DbSeek( cLocal + cNumSC ))
	If SC7->C7_CONAPRO == "B"
		If cRetAprov = "S" 
			If SCR->(dBSeek(cLocal+"PC"+PADR(cNumSC,TamSX3("CR_NUM")[1])+cCodUsr))
				While SCR->(!EoF()) .And. SCR->CR_FILIAL == cLocal .And. SCR->CR_TIPO == "PC" .And. SCR->CR_NUM == PADR(cNumSC,TamSX3("CR_NUM")[1]) .And. SCR->CR_USER == cCodUsr
					If SCR->CR_GRUPO == cGrpApv
						lRet := A097ProcLib(SCR->(Recno()),2,,,,,dDataBase)
					Endif
					SCR->(DbSkip())
				EndDo
			Endif
			nOpcA := 2
		Else
			If SCR->(dBSeek(cLocal+"PC"+PADR(cNumSC,TamSX3("CR_NUM")[1])+cCodUsr))
				While SCR->(!EoF()) .And. SCR->CR_FILIAL == cLocal .And. SCR->CR_TIPO == "PC" .And. SCR->CR_NUM == PADR(cNumSC,TamSX3("CR_NUM")[1]) .And. SCR->CR_USER == cCodUsr
					If SCR->CR_GRUPO == cGrpApv
						lRet := A097ProcLib(SCR->(Recno()),3,,,,,dDataBase)
						RecLock("SCR",.F.)
						SCR->CR_OBS := cRej
						MsUnlock()
					Endif
					SCR->(DbSkip())
				EndDo
			//	U_AXMainWF(cLocal,cNumSC,14,SC7->C7_USER,,cRej,cCodUsr)
			Endif
			nOpcA := 1
		Endif

		SC7->(DbSetOrder(1))
		SC7->(DbSeek( cLocal + cNumSC ))

		ExecBlock("MT097END",.F.,.F.,{cNumSC,"PC",nOpcA,cLocal,cCodUsr,cRej})
	Endif
Endif 
Return Nil 

STATIC FUNCTION SPCTimeOut( oProcess )
  ConOut("Funcao de TIMEOUT executada")  
  oProcess:NewTask('Time Out',"\workflow\EVENTO\timeout.htm")
  oHtml:=oProcess:oHtml
  oHtml:RetByName("Titulo","Usuario não respondeu e-mail")
  oHtml:RetByName("numPed",_cPedido)
  oHtml:RetByName("cliente",_ccliente)
  _cUser = Subs(cUsuario,7,15)
  oHtml:RetByName("usuario",_cUser)
  subj := "Pedido"+ _cPedido + " por " + _ccliente
  oProcess:Start() 
  WFSendMail()
Return 

STATIC FUNCTION TestProcess(oProc)
    //Prepare Environment Empresa '99' Filial '01'
    //Proc:oHtml:valByName('botoes',"")

  	oHTML := oProc:oHTML
  	ConOut("abe")
	oProc:cTo := "vendedor@microsiga"	
	//oProcess:cBody := 'Processo do Pedido: '+oProc:oHTML:RetByName('Pedido')+' concluido!'	

    oProc:Start()
    WFSendMail()
    //RastreiaWF(oProc:fProcessID+'.'+oProc:fTaskID,oProc:fProcCode,'1003','Finalizando Processo',Subs(cUsuario,7,15))
Return .T.
STATIC FUNCTION SeekEml(cAprovador)  
  	PswOrder(1)
	IF PswSeek(cAprovador,.t.)
       aInfo   := PswRet(1)
	   cMailAp := alltrim(aInfo[1,14])
	   conout ("Email do Aprovador" + cMailAp)	   
    ENDIF
RETURN  
