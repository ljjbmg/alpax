/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT460EST  �Autor  �Microsiga           � Data �  12/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida estorno de liberacao, se for produto controlado por ���
���          � exercito bloqueia o estorno.                               ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MT460EST()

_lRet		:= .t.
_aArea 		:= GetArea()
_aAreaB1 	:= SB1->(GetArea())

If ! Empty(Posicione("SB1",1,xFilial("SB1")+SC9->C9_PRODUTO,"B1_AXCTEXE")) .And. Alltrim(Funname()) == "MATA460A"
	ApMsgStop("Produto controlado pelo exercito, nao pode ser estornado por esta rotina, altere o pedido !!!!","Rotina bloqueada !!")
	_lRet := .f.
EndIf	

RestArea(_aAreaB1)
RestArea(_aArea)

Return(_lRet)