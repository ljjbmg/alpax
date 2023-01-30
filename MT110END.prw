#Include "RwMake.ch"
#Include "TopConn.ch"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT110END  ºAutor  ³Marcio Medeiros Juniorº Data ³  03/04/20 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada após ação na avaliacao da solicitacao      º±±
±±º          ³															  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MT110END

Local na
/*
PARAMIXB[2]       
 1 = Aprovar; 
 2 = Rejeitar; 
 3 = Bloquear

PARAMIXB[3] = Filial quando vem de aprovacao via email
PARAMIXB[4] = Aprovador quando vem de aprovacao via email
PARAMIXB[5] = Motivo Rejeicao

CR_STATUS='01' - Bloqueado (aguardando outros níveis)
CR_STATUS='02' - Aguardando Liberação do usuário
CR_STATUS='03' - Documento Liberado pelo usuário
CR_STATUS='04' - Documento Bloqueado pelo usuário
CR_STATUS='05' - Documento Liberado por outro usuário
CR_STATUS='06' - Documento Rejeitado pelo usuário
CR_STATUS='07' - Documento Rejeitado ou Bloqueado por outro usuário
*/

nSC1Rec		:= SC1->(RecNo())

lPendNvl	:= .F.
aNxtAprov	:= {}
cNumSol 	:= PARAMIXB[1]//SC1->C1_NUM

If Len(PARAMIXB) > 2
	cFilWF := PARAMIXB[3]
	SC1->(DbSetOrder(1))
	SC1->(DbSeek(cFilWF + cNumSol))	
Else
	cFilWF := cFilAnt
Endif

If Len(PARAMIXB) > 3
	cCodAprov := PARAMIXB[4]
Else
	cCodAprov := RetCodUsr()
Endif

cSolicit	:= SC1->C1_USER

Conout('<<<MT110END>>>')
Conout('--------------> Filial: ' + cFilWF + '<----------------')
Conout('--------------> SC: ' + cNumSol + '<----------------')
Conout('--------------> Aprovador: ' + cCodAprov + '<----------------')

If ParamixB[2] == 1 
	
	cNivel 	:= ""
	DbSelectArea("SCR")
	SCR->(dBSetOrder(2))   // CR_FILIAL+CR_TIPO+CR_NUM+CR_USER
	If SCR->(dBSeek( cFilWF + "SC" + PADR(cNumSol,TamSX3("CR_NUM")[1]) + cCodAprov))
		
		cNivel := SCR->CR_NIVEL

		SCR->(DbGoTop())
		SCR->(dBSetOrder(1))   // CR_FILIAL+CR_TIPO+CR_NUM+CR_NIVEL
		If SCR->(dBSeek( cFilWF + "SC" + PADR(cNumSol,TamSX3("CR_NUM")[1]) + cNivel))		

			While SCR->(!EoF()) .And. SCR->CR_FILIAL == cFilWF .And. SCR->CR_TIPO == "SC" .And. AllTrim(SCR->CR_NUM) == AllTrim(cNumSol)// + SCR->CR_NIVEL == cNivel 
				If SCR->CR_NIVEL == cNivel .And. SCR->CR_STATUS == "02"// .And.  AllTrim(SCR->CR_USER) <> AllTrim(cCodAprov)
				 	lPendNvl := .T.
				Endif
				If SCR->CR_NIVEL > cNivel .And. SCR->CR_STATUS == "02"
					cGrpApv	 := SCR->CR_GRUPO 					
					aAdd(aNxtAprov,{SCR->CR_USER,cGrpApv})
				Endif
				SCR->(DbSkip())
			EndDo

			If !lPendNvl 
				If Len(aNxtAprov) > 0
					For nA := 1 to Len(aNxtAprov)
					If MsgYesNo("Deseja enviar workflow para aprovação?","WorkFlow")
						U_AXMainWF(cFilWF,cNumSol,2,aNxtAprov[nA][1],aNxtAprov[nA][2])
					End 
					Next
				Else
					U_AXMainWF(cFilWF,cNumSol,3,cSolicit,,,cCodAprov)
	
					SC1->(DbSetOrder(1))
					SC1->(DbSeek(cFilWF + cNumSol))
					While SC1->(!EoF()) .And. SC1->C1_FILIAL == cFilWF .And. SC1->C1_NUM == cNumSol
						Reclock('SC1',.F.)
						SC1->C1_APROV := 'L'
						MsUnlock()
						SC1->(DbSkip())
					EndDo
					
					SC1->(DbGoTo(nSC1Rec))
				Endif
			Endif
		Endif
	Endif
	
Else//If ParamixB[2] == 2 

	U_AXMainWF(cFilWF,cNumSol,4,cSolicit,,PARAMIXB[5],cCodAprov)

Endif

Return        
