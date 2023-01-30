/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CNABVAL  �Autor  �Ocimar              � Data �  12/08/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao para retornar o valor do tiutlo a ser enviado       ���
���          � ao banco                                                   ���
�������������������������������������������������������������������������͹��
���Uso       � AP - Alpax                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function CNABVAL()

LOCAL _cRet := ""

If SE1->E1_PREFIXO <> 'NFS'
	_cRet := SE1->E1_SALDO
Else
	_cRet := (SE1->E1_SALDO-SE1->E1_IRRF-SE1->E1_PIS-SE1->E1_COFINS-SE1->E1_CSLL)
EndIf

Return(_cRet)
