/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FATE006   �Autor  �Microsiga           � Data �  04/06/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao para retornar o saldo na consulta padrao SB1         ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function FATE006()   

cLOC:=getmv("MV_AXLCPAD")

_cRet := POSICIONE("SB2",1,XFILIAL("SB2")+SB1->B1_COD+cLOC,"B2_QATU")-(SB2->B2_QPEDVEN+SB2->B2_RESERVA+SB2->B2_QEMP)

Return(_cRet)