#Include "RwMake.ch"
#Include "TopConn.ch"
#DEFINE CRLF Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT120FIM  ºAutor  ³Marcio Medeiros Juniorº Data ³ 20/12/20  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada depois da gravação de um pedido de compra. º±±
±±º          ³Confirmando-se que o pedido foi gravado, grava SC7 e SCR.   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MT120FIM

cCodUser  := RetCodUsr()  
cNumPed   := ParamixB[2] 
/*
ParamixB[1] = Parametro que indica opção de pedido (2=VISUALIZAR, 3=INCLUIR ou 4=ALTERAR)
ParamixB[3] = Parametro que indica ação na tela de pedido (1=BOTAO CONFIRMAR ou 0=BOTAO CANCELAR)
*/

If (ParamixB[1] == 3 .Or. ParamixB[1] == 4) .And. ParamixB[3] == 1

	SCR->(dBSetOrder(1))   // CR_FILIAL+CR_TIPO+CR_NUM+CR_NIVEL
	If SCR->(dBSeek( xFilial("SCR") + "PC" + PADR(cNumPed,TamSX3("CR_NUM")[1]) + "01"))
		While SCR->(!EoF()) .And. SCR->CR_FILIAL == xFilial("SCR") .And. SCR->CR_TIPO == "PC" .And. AllTrim(SCR->CR_NUM) == AllTrim(cNumPed) .And. SCR->CR_NIVEL == "01"
			SC7->(DbSeek(xFilial("SC7") + cNumPed))
			cAprov   := SCR->CR_USER 
			cGrpApv	 := SCR->CR_GRUPO 

			U_AXMainWF(cFilAnt,cNumPed,11,cAprov,cGrpApv)
			
			SCR->(DbSkip())
		EndDo
	Endif		

Endif
Return
