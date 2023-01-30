/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATG008   ºAutor  ³Adriano Luis Brandaoº Data ³  31/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para ser acionada no gatilho nos campos CK_QTDVEN e º±±
±±º          ³ CK_PRODUTO e para atualizar o preco no orcamento p/tabela  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATG008(_cTipo) 

// Retorno da funcao
// _cTipo == 1 - Codigo do produto
// _cTipo == 2 - quantidade

_aArea 		:= GetArea()        
_aAreaDA1 	:= DA1->(GetArea())
_aAreaSB1	:= SB1->(GetArea())


DA1->(DbSetOrder(2))
// DA1_FILIAL + DA1_CODPRO + DA1_CODTAB + DA1_ITEM
SB1->(DbSetOrder(1))

DA1->(DbSeek(xFilial("DA1")+TMP1->CK_PRODUTO+M->CJ_TABELA))

If (DA1->DA1_FILIAL + DA1->DA1_CODPRO + DA1->DA1_CODTAB) == (xFilial("DA1")+TMP1->CK_PRODUTO+M->CJ_TABELA)
	TMP1->CK_PRCVEN 	:= TMP1->CK_PRCVEN-(iif(DA1->DA1_PRCVEN<>0,DA1->DA1_PRCVEN,TMP1->CK_PRCVEN)*(M->CJ_AXDESC/100))
	TMP1->CK_VALOR		:= TMP1->CK_PRCVEN * TMP1->CK_QTDVEN
Else
	SB1->(DbSeek(xFilial("SB1")+TMP1->CK_PRODUTO))
	If M->CJ_AXDESC > 0
		TMP1->CK_PRCVEN := TMP1->CK_PRCVEN-(TMP1->CK_PRCVEN * (M->CJ_AXDESC/100))
		TMP1->CK_VALOR	:= TMP1->CK_PRCVEN * TMP1->CK_QTDVEN
	EndIf
Endif

RestArea(_aAreaSB1)
RestArea(_aAreaDA1)
RestArea(_aArea)       

Return(iif(_cTipo=="1",TMP1->CK_PRODUTO,TMP1->CK_QTDVEN))