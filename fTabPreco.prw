/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fTabPreco �Autor  �Microsiga           � Data �  29/04/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function fTabPreco()

Local _nTabPre := Posicione("SA1",1,xFilial("SA1")+M->CJ_CLIENTE,"A1_TABELA")

If Empty(_nTabPre)
	
	_aTab := {"JAN","FEV","MAR","ABR","MAI","JUN","JUL","AGO","SET","OUT","NOV","DEZ"}
	
	_cRet := _aTab[Month(dDataBase)]
	
Else
	_cRet := SA1->A1_TABELA
	
EndIf

Return(_cRet)