/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �OS010REJ  �Autor  �Microsiga           � Data �  27/08/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao para atualizar ou nao o novo preco gravado.         ���
���          � recebe o preco anterior ao reajuste e o preco reajustado.  ���
���          � Paramixb[1] preco anterior/Paramixb[2] Novo preco.         ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function OS010REJ()

_aArea 		:= GetArea()
_aAreaB1 	:= SB1->(GetArea())
_aAreaD1 	:= SD1->(GetArea())

SB1->(DbSetOrder(1))
SB1->(DbSeek(xFilial("SB1")+DA1->DA1_CODPRO))
//
// Caso nao esteja dentro da marca selecionada nos parametros retorna preco anterior.
//
//If SB1->B1_MARCA < MV_PAR14 .or. SB1->B1_MARCA > MV_PAR15
If SB1->B1_MARCA < MV_PAR17 .or. SB1->B1_MARCA > MV_PAR18
	RecLock("DA1",.f.)
	DA1->DA1_PRCVEN := paramixb[1]
	DA1->(MsUnLock())
EndIf

RestArea(_aAreaB1)
RestArea(_aAreaD1)
RestArea(_aArea)

Return