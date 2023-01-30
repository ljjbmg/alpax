/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATG009   ºAutor  ³Microsiga           º Data ³  24/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gatilho para trazer endereco de entrega de cliente ou      º±±
±±º          ³ fornecedor para o pedido de vendas.                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATG009()

Local _aArea := GetArea()
Local _aAreaA1 := SA1->(GetArea())
Local _aAreaA2 := SA2->(GetArea())
Local _cRet	 := ""


If M->C5_TIPO $ "BD"
	SA2->(DbSetOrder(1))
	SA2->(DbSeek(xFilial("SA2")+M->C5_CLIENTE,.t.))
	_cRet := Rtrim(SA2->A2_END)+" - "+RTRIM(SA2->A2_BAIRRO)+" - "+RTRIM(SA2->A2_MUN)+" - "+(SA2->A2_EST) + " - CEP:"
	_cRet += Transform(SA2->A2_CEP,"@R 99999-999")
Else
	SA1->(DbSetOrder(1))
	SA1->(DbSeek(xFilial("SA1")+M->C5_CLIENTE,.t.))
	_cRet := RTRIM(SA1->A1_ENDENT)+" - "+RTRIM(SA1->A1_BAIRROE)+" - "+RTRIM(SA1->A1_MUNE)+" - "+(SA1->A1_ESTE)
	_cRet += " - CEP:" + Transform(SA1->A1_CEPE,"@R 99999-999")   
EndIf        

RestArea(_aAreaA1)
RestArea(_aAreaA2)
RestArea(_aArea)

Return(_cRet)
