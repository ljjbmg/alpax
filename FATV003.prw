/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FATV003   �Autor  �OCIMAR ROLLI        � Data �  19/04/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para verificacao de incompatibilidade de produtos   ���
���          �quimicos perigosos.                                         ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

#Include "rwmake.ch"
#Include "topconn.ch"

User Function FATV003()

Local _nPos     := aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXRISCO"})
Local lRet      := .t.


_aArea	:= GetArea()
_aAreaB1	:= SB1->(GetArea())
_aAreaZM	:= SZM->(GetArea())

SB1->(DbSetOrder(1))
SB1->(DbSeek(xFilial("SB1")+M->C6_PRODUTO))

_cRisco   := SB1->B1_AXRISCO

For _nY := 1 to Len(acols)
	_cIncompa := aCols[_nY,_nPos]
	If _nY <> n
		If SZM->(DbSeek(xFilial("SZM")+_cRisco+_cIncompa))
			APMSGSTOP("EXISTEM PRODUTOS INCOMPATIVEIS NESTE PEDIDO !!!")
		EndIf
	EndIf
Next _nY

RestArea(_aAreaB1)
RestArea(_aAreaZM)
RestArea(_aArea)

Return(lRet)