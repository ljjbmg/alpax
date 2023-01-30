/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTG005    �Autor  �Ocimar             � Data �  19/10/08   ���
�������������������������������������������������������������������������͹��
���Desc.     � Gatilho para atualizar o FCI em notas de devolucao de      ���
���          � produtos igual a de venda.                                 ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#include "Topconn.ch"
#Include "rwmake.ch"

User Function ESTG005()

_cQuery := "SELECT D2_FCICOD "
_cQuery += "FROM " + RetSqlName("SD2") + " SD2 " 
_cQuery += "INNER JOIN " + RetSqlName("SD1") + " SD1 "
_cQuery += "ON D1_NFORI = D2_DOC AND D1_SERIORI = D2_SERIE AND D1_ITEMORI = D2_ITEM "
_cQuery += "WHERE D1_NFORI = '" + M->D1_NFORI + "' AND D1_SERIORI = '" + M->D1_SERIORI + "' AND D1_ITEMORI = '" + M->D1_ITEMORI + "' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D2_FCICOD"	  ,"C",36,0)

QR1->(DbCloseArea())

Return(QR1->D2_FCICOD)
