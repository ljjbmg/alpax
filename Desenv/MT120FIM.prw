#Include "RwMake.ch"
#Include "TopConn.ch"
#DEFINE CRLF Chr(13)+Chr(10)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT120FIM  �Autor  �Marcio Medeiros Junior� Data � 20/12/20  ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada depois da grava��o de um pedido de compra. ���
���          �Confirmando-se que o pedido foi gravado, grava SC7 e SCR.   ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MT120FIM

cCodUser  := RetCodUsr()  
cNumPed   := ParamixB[2] 
/*
ParamixB[1] = Parametro que indica op��o de pedido (2=VISUALIZAR, 3=INCLUIR ou 4=ALTERAR)
ParamixB[3] = Parametro que indica a��o na tela de pedido (1=BOTAO CONFIRMAR ou 0=BOTAO CANCELAR)
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
