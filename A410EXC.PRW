/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A410EXC   ºAutor  ³Adriano Luis Brandaoº Data ³  27/10/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validacao da exclusao do pedido de vendas, onde so podera   º±±
±±º          ³ser deletado se for do proprio usuario.                     º±±
±±º          ³Limpeza Licenca Especiais                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A410EXC()

Local _aArea 	:= GetArea()
Local _aAreaC6	:= SC6->(GetArea())

_lRet := .t.

If SC5->C5_AXATEN1 <> __cUserId .And. ! Upper(Alltrim(cUserName)) $ "LUCI/OCIMAR/ADMINISTRADOR/BETH/CLEBERSON/JABSON"
	APMSGSTOP("Este pedido pertence a outro usuario, vc nao pode excluir....")
	_lRet := .f.
EndIf

If _lRet                                     
	SZU->(DbSetOrder(5))
	SC6->(DbSetOrder(1))
	SC6->(DbSeek(xFilial("SC6")+SC5->C5_NUM))
	Do While ! SC6->(Eof()) .And. SC6->C6_FILIAL == xFilial("SC6") .And. SC6->C6_NUM == SC5->C5_NUM
		If ! Empty(SC6->C6_XAUTORI)
			If SZU->(Dbseek(xfilial("SZU")+SC6->C6_XAUTORI+SC5->C5_CLIENTE+SC5->C5_LOJACLI))
				RecLock("SZU",.f.)
				SZU->ZU_PEDIDO := " "
				SZU->(MsUnLock())
			EndIf
		EndIf
		SC6->(DbSkip())
	EndDo
EndIf

RestArea(_aAreaC6)
RestArea(_aArea)

Return(_lRet)