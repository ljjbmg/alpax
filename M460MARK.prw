/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M460MARK  ºAutor  ³Adriano Luis Brandaoº Data ³  23/07/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para verificar a licenca na geracao da nota fiscal  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M460MARK()

//Return .t.

//User Function xx

Local _aArea 		:= GetArea()
Local _aAreaC9 		:= SC9->(GetArea())
Local _aAreaC5		:= SC5->(GetArea())
Local _aAreaC6		:= SC6->(GetArea())

Local _lRet			:= .t. 
Local _cMens460		:= ""
Local _cEol			:= CHR(13) + CHR(10)


//paramixb[1] = cMarca
//paramixb[2] = lInverte

// Quando paramixb[2] for .t. os marcados sao C9_OK <> Paramixb[1]
// Quando paramixb[2] for .F. os marcados sao C9_OK == paramixb[1]


If Paramixb[2] // lIverte
	_cCond := "SC9->C9_OK <> Paramixb[1]"
Else
	_cCond := "SC9->C9_OK == Paramixb[1]"
EndIf
                
dbselectarea("SC9") 
SC9->(DBSETORDER(2))
SC9->(DbGoTop())                        
If SC9->(DBSEEK(xFilial("SC9")+SC5->(C5_CLIENTE+C5_LOJACLI+C5_NUM)))
  Do While ! SC9->(Eof()) .and. xFilial("SC9")+SC5->(C5_CLIENTE+C5_LOJACLI+C5_NUM) == sc9->(C9_FILIAL+C9_CLIENTE+C9_LOJA+C9_PEDIDO)
	// Se estiver marcado executa
	If &(_cCond)
		
		SC6->(DbSetOrder(1))
		SC6->(DbSeek(xFilial("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM))
		If Empty(SC6->C6_XAUTORI)
			
			_aItem := {{SC9->C9_PRODUTO,SC9->C9_QTDLIB}}
			// checa licencas do cliente
			_aRet1 := U_ESTV004("C",SC9->C9_CLIENTE+SC9->C9_LOJA,_aItem,.t.)
			// param1           = C=Cliente, T=Transportadora, F=Fornecedor.
			// param2           = Codigo e Loja do cadastro
			// param3           = Produto a serem checados.
			// param4 (opcional)= Checa apenas se a licenca existe, quantidade nao eh checada (opcional).
			SC5->(DbSetOrder(1))
			SC5->(DbSeek(xFilial("SC5")+SC9->C9_PEDIDO))
			
			_aRet2	:= U_ESTV004("T",SC5->C5_TRANSP,_aItem,.t.)
			
			If ! _aRet1[1] .Or. ! _aRet2[1]
				_cMens460 += iif(! _aRet1[1],"Consulta Cliente Pedido: " + SC5->C5_NUM + " PRODUTO: " + SC9->C9_PRODUTO + _cEol,"")
				_cMens460 += iif(! _aRet2[1],"Consulta Transportadora Pedido: " + SC5->C5_NUM + " PRODUTO: " + SC9->C9_PRODUTO + _cEol,"")
				_lRet := .f.
			EndIf
		EndIf
		
	EndIf
	SC9->(DbSkip())
 EndDo
Endif 
If ! _lRet
	ApMsgInfo("Nao podera ser Faturado, licenca vencida ou nao existe, veja log","Aviso")
	U_ESTV004A(_cMens460)                                
EndIf

RestArea(_aAreaC5)
RestArea(_aAreaC6)
RestArea(_aAreaC9)
RestArea(_aArea)

U_ESTV005(SC9->C9_PRODUTO)

Return(_lRet)
