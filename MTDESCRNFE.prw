/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �_MTDESCRNFE   �Autor  �Fagner / Biale  � Data �  05/01/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � PE utilizado no relat�rio de impress�o RPS MATR968 responsa���
���          � vel pelo complemento da descri��o do servi�o.              ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MTDESCRNFE()
Local cRet 	:= ""
Local aArea := GetArea()
// Buscando os vencimentos dos titulos para serem apresentados como complemento da descri��o dos produtos.

dbSelectArea("SE1")
dbSetOrder(2)
If dbSeek(xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_SERIE+SF2->F2_DOC)
	While !Eof() .And. xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_SERIE+SF2->F2_DOC == ;
		xFilial("SE1")+SE1->E1_CLIENTE+SE1->E1_LOJA+SE1->E1_PREFIXO+SE1->E1_NUM ;
		.And. SE1->E1_TIPO = "NF"
		cRet += "|Titulo: " + SE1->E1_NUM +"/"+ALLTRIM(SE1->E1_PARCELA) + " Vencto.:" + DTOC(SE1->E1_VENCREA )
		SE1->(dbSkip())
	EndDo
EndIf

//Inclus�o da mensagem do pedido como informa��es no corpo da nota- Por Fagner em 05/01/2012

If !empty(cMenNotaPed)
	cRet += "| " + ALLTRIM(cMenNotaPed)
Endif

If !empty(cPedCli)
	cRet += "|Num. Ped. Cliente: "+ALLTRIM(cPedCli)
Endif

				cNatOper += CHR(10) + CHR(13) + "ATENCAO : TEMOS O PRAZO DE 10 DIAS CORRIDOS DENTRO DO MES PARA CANCELAMENTO APOS A DATA DE EMISSAO"               // OCIMAR 08/08/18
				

RestArea(aArea)

Return cRet
