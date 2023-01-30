/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M440SC9I  ºAutor  ³Microsiga           º Data ³  07/09/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para gravacao de campos customizados no   º±±
±±º          ³ SC9.                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M440SC9I()

_aArea 		:= GetArea()
_aAreaA1 	:= SA1->(GetArea())
_aAreaC5	:= SC5->(GetArea())
_aAreaA2	:= SA2->(GetArea())

SC5->(DbSetOrder(1))
SC5->(DbSeek(xFilial("SC5")+SC9->C9_PEDIDO))

If ! SC5->C5_TIPO $ "DB"		// Clientes
	SA1->(DbSetOrder(1))
	SA1->(DbSeek(xFilial("SA1")+SC9->C9_CLIENTE+SC9->C9_LOJA))
	// Gravacao de campo customizado.
	RecLock("SC9",.f.)
	SC9->C9_AXCLI := SA1->A1_NOME
	SC9->C9_AXDTLIB := dDataBase
	SC9->C9_AXHRLIB := Transform(Time(),"99:99:99")
	SC9->(MsUnLock())
Else							// Fornecedores
	SA2->(DbSetOrder(1))
	SA2->(DbSeek(xFilial("SA2")+SC9->C9_CLIENTE+SC9->C9_LOJA))
	// Gravacao de campo customizado.
	RecLock("SC9",.f.)
	SC9->C9_AXCLI := SA2->A2_NOME
	SC9->C9_AXDTLIB := dDataBase
	SC9->C9_AXHRLIB := Transform(Time(),"99:99:99")
	SC9->(MsUnLock())
EndIf

RestArea(_aAreaA2)
RestArea(_aAreaC5)
RestArea(_aAreaA1)
RestArea(_aArea)
                
_aAreaC6	:= SC6->(GetArea())

SC6->(DbSetOrder(1))
SC6->(DbSeek(xFilial("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_PRODUTO))
RecLock("SC9",.f.)
SC9->C9_AXRISCO := SC6->C6_AXRISCO
SC9->(MsUnLock()) 

RestArea(_aAreaC6)

Return
