/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTV001   �Autor  �Microsiga           � Data �  01/08/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Validacao do campo B1_AXCTPF                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ESTV001()

_lRet := .t.

_aArea 		:= GetArea()
_aAreaZB 	:= SZB->(GetArea())

If Posicione("SZB",1,xFilial("SZB")+M->B1_AXCTPF,"ZB_NCM") <> M->B1_POSIPI
	ApMsgStop("NCM " + M->B1_POSIPI + "Diferente do cadastro da policia Federal, favor ajustar")
	_lRet := .f.
EndIf

RestArea(_aAreaZB)
RestArea(_aArea)

Return(_lRet)