/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_MTDESCRNFE   ºAutor  ³Fagner / Biale  º Data ³  05/01/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ PE utilizado no relatório de impressão RPS MATR968 responsaº±±
±±º          ³ vel pelo complemento da descrição do serviço.              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MTDESCRNFE()
Local cRet 	:= ""
Local aArea := GetArea()
// Buscando os vencimentos dos titulos para serem apresentados como complemento da descrição dos produtos.

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

//Inclusão da mensagem do pedido como informações no corpo da nota- Por Fagner em 05/01/2012

If !empty(cMenNotaPed)
	cRet += "| " + ALLTRIM(cMenNotaPed)
Endif

If !empty(cPedCli)
	cRet += "|Num. Ped. Cliente: "+ALLTRIM(cPedCli)
Endif

				cNatOper += CHR(10) + CHR(13) + "ATENCAO : TEMOS O PRAZO DE 10 DIAS CORRIDOS DENTRO DO MES PARA CANCELAMENTO APOS A DATA DE EMISSAO"               // OCIMAR 08/08/18
				

RestArea(aArea)

Return cRet
