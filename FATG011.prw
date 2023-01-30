/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FATG011   �Autor  �Microsiga           � Data �  24/06/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Gatilho para trazer nome de embarque do produto no cadas- ���
���          � de produto ao se digitar o numero da ONU.                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#Include "Topconn.ch"

User Function FATG011()

Local _aArea := GetArea()
Local _aAreaBG := ZBG->(GetArea())
Local _cRet	 := "" 
Local _cNonu := Str(M->B1_AXNONU)

ZBG->(DbSetOrder(1))
If	ZBG->(DbSeek(xFilial("ZBG")+ltrim(_cNonu),.t.))
	_cRet := RTRIM(ZBG->ZBG_NOMEMB)
Else 
		ApMsgStop("CODIGO NAO CADASTRADO !!!!")
EndIf        

RestArea(_aAreaBG)
RestArea(_aArea)

Return(_cRet)