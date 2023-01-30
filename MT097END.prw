#Include "RwMake.ch"
#Include "topconn.ch"
#Include "Ap5Mail.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT097END �Autor  �Marcio Medeiros Junior� Data �  22/12/20  ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada na aprova��o do PC, responsavel por enviar ���
���          �email para aprovadores e/ou compradores					  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MT097END

local na
/*
ParamIXB = {cDocto,cTipo,nOpc,cFilDoc}
 nOpc == 1 --> Cancela;
 nOpc == 2 --> Libera;
 nOpc == 3 --> Bloqueia

 Customizados:
 ParamixB[5] := cCodAprov
 ParamixB[6] := cRet
*/

If ParamixB[2] == "PC" .And. Len(PARAMIXB) >= 5

	lPendNvl	:= .F.
	aNxtAprov	:= {}

	Conout('<<<MT097END>>>')
	Conout('--------------> Filial: ' + ParamixB[4] + '<----------------')
	Conout('--------------> PC: ' + ParamixB[1] + '<----------------')
	Conout('--------------> Aprovador: ' +  ParamixB[5]  + '<----------------')
	Conout('--------------> Opc: ' + cValToChar(ParamixB[3])  + '<----------------')
	
	nSC7Rec		:= SC7->(RecNo())
	If Len(PARAMIXB) < 5
		cCodAprov 	:= RetCodUsr()
	Else
		cCodAprov 	:= ParamixB[5] 
	Endif

	If Len(PARAMIXB) < 6
		cRet := ""
	Else
		cRet := ParamixB[6] 
	Endif

	cNumSol := ParamixB[1]
	cFilC7  := ParamixB[4]

	If ParamixB[3] == 2
		
		cNivel 	:= ""
		
		DbSelectArea("SCR")
		SCR->(dBSetOrder(2))   // CR_FILIAL+CR_TIPO+CR_NUM+CR_USER
		If SCR->(dBSeek( cFilC7 + "PC" + PADR(cNumSol,TamSX3("CR_NUM")[1]) + cCodAprov))
			conout("Encontrou Aprovador na SCR")	
			cNivel := SCR->CR_NIVEL

			SCR->(DbGoTop())
			SCR->(dBSetOrder(1))   // CR_FILIAL+CR_TIPO+CR_NUM+CR_NIVEL
			If SCR->(dBSeek( cFilC7 + "PC" + PADR(cNumSol,TamSX3("CR_NUM")[1]) + cNivel))		
				conout("Posicionou no nivel do aprovador na SCR")
				While SCR->(!EoF()) .And. SCR->CR_FILIAL == cFilC7 .And. SCR->CR_TIPO == "PC" .And. AllTrim(SCR->CR_NUM) == AllTrim(cNumSol)// + SCR->CR_NIVEL == cNivel 
					If SCR->CR_NIVEL == cNivel .And. SCR->CR_STATUS == "02"// .And.  AllTrim(SCR->CR_USER) <> AllTrim(cCodAprov)
						conout("Achou outro aprovador do mesmo nivel com status 02")
						lPendNvl := .T.
					Endif
					If SCR->CR_NIVEL > cNivel .And. SCR->CR_STATUS == "02"
						cGrpApv	 := SCR->CR_GRUPO 					
						aAdd(aNxtAprov,{SCR->CR_USER,cGrpApv})
					Endif
					SCR->(DbSkip())
				EndDo

				If !lPendNvl 
					conout("Nada pendente")
					If Len(aNxtAprov) > 0
						conout("Mandando email para aprovadores dos niveis superiores")
						For nA := 1 to Len(aNxtAprov)
						If MsgYesNo("Deseja enviar workflow para aprova��o?","WorkFlow")
							U_AXMainWF(cFilC7,cNumSol,12,aNxtAprov[nA][1],aNxtAprov[nA][2])
						End
						Next
					Else
						conout("Mandando email ao solicitante " + SC7->C7_USER)
						U_AXMainWF(cFilC7,cNumSol,13,SC7->C7_USER,,,ParamixB[5])
					Endif
				Endif
			Endif
		Endif
	Else
		If !IsBlind()
			aRetRej := U_TelaRej()//cMotRej   := U_TelaRej()
			lRetRej	:= aRetRej[1] 

			If aRetRej[1] 
				U_AXMainWF(cFilC7,cNumSol,14,SC7->C7_USER,,,cCodAprov)
			Endif
		Else
			U_AXMainWF(cFilC7,cNumSol,14,SC7->C7_USER,,ParamixB[6],PARAMIXB[5])
		Endif
	Endif
ElseIf ParamixB[2] == "PC" .And. Len(PARAMIXB) < 5
	If ParamixB[3] == 2
		U_AXMainWF(cFilC7,cNumSol,13,SC7->C7_USER,,,cCodAprov)
	Else
		U_AXMainWF(cFilC7,cNumSol,14,SC7->C7_USER,,,cCodAprov)
	Endif
Endif
Return
