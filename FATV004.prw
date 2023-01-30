/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FATV004   �Autor  �OCIMAR ROLLI        � Data �  19/04/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Gatilho para verificacao de incompatibilidade de produtos   ���
���          �quimicos perigosos no orcamento.                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

#Include "rwmake.ch"
#Include "topconn.ch"

User Function FATV004()

Local _nPos     := aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "CK_AXRISCO"})
Local lRet      := .T.

_aArea	:= GetArea()
_aAreaB1	:= SB1->(GetArea())
_aAreaZM	:= SZM->(GetArea())
_aAreaTMP1  := TMP1->(GetArea())

SB1->(DbSetOrder(1))
SB1->(DbSeek(xFilial("SB1")+M->CK_PRODUTO)) 

_cRisco   := SB1->B1_AXRISCO   

dbSelectArea("TMP1")
dbGoTop()

Do While !Eof()
	_cIncompa := TMP1->CK_AXRISCO
	If SZM->(DbSeek(xFilial("SZM")+_cRisco+_cIncompa))
		APMSGSTOP("EXISTEM PRODUTOS INCOMPATIVEIS NESTE ORCAMENTO !!!")
		//lRet := .F.
	EndIf
	dbSkip()
EndDo

RestArea(_aAreaB1)
RestArea(_aAreaZM)
RestArea(_aAreaTMP1)
RestArea(_aArea)

Return(lRet)