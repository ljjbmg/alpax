/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTA120G2  �Autor  �Ocimar              � Data �  06/08/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada para gravacao de campos customizados da   ���
���          � solicitacao para o pedido de compras.                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP - alpax.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MTA120G2()

_aArea 		:= GetArea()
_aAreaB1 	:= SB1->(GetArea())

SB1->(DbSetOrder(1))
SB1->(DbSeek(xFilial("SB1")+SC7->C7_PRODUTO))

RecLock("SC7",.f.)
SC7->C7_AXPART	:= SB1->B1_PNUMBER
MsUnLock()

RestArea(_aAreaB1)
RestArea(_aArea)

Return