/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTV005   �Autor  � Ocimar Rolli       � Data �  12/11/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Gatilho para verificacao do produto se controlado pelo     ���
���          � exercito e informa usuario se necessita guia de trafego.   ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#Include "Topconn.ch"

User Function ESTV005(_aParam)

Local _aArea := GetArea()
Local _aAreaB1 := SB1->(GetArea())

SB1->(DbSeek(xFilial("SB1")+_aParam,.t.))

If SB1->B1_AXCTEXE <> " "
	ApMsgStop("PRODUTO : < "+ALLTRIM(SB1->B1_PNUMBER)+" > NECESSITA DE GUIA DE TRAFEGO !!!!")
EndIf

Return(.t.)
