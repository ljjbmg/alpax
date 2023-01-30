/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT440GR   ºAutor  ³Adriano Luis Brandaoº Data ³  13/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para bloquear os pedidos de vendas que os itens sejamº±±
±±º          ³controlados pelo exercito e policia federal e que a quantidaº±±
±±º          ³de e data de inicio e fim da licenca esteja vencida.        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"

User Function MT440GR()


Local _lRet		:= .t.
Local _nPosProd	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_PRODUTO" })
Local _nPosQLib	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_QTDLIB" 	})
Local _nPosLic	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "C6_XAUTORI" 	})
Local _aItens 	:= {}
Local _aArea		:= GetArea()
Local UserLib	:= SuperGetMV("MV_USERLIB",,"000000")
Local _nW

If _lRet .And. M->C5_AXATEN1 <> __cUserId .and. !__cUserId $ UserLib 
	// se nao é o usuario do pedido, testa se é supervisor do atendente
	PswOrder(1)
	if PswSeek(M->C5_AXATEN1,.t.)
		_aSuperior :=pswret(1)
		If _aSuperior[1,11] <> __cUserId		// se tambem nao é o supervisor do atendente bloqueia liberacao
			ApMsgStop("Este pedido pertence a outro usuario, vc nao pode liberar....")
			_lRet := .f.
		EndIf
	Endif

Elseif _lRet .And. SC5->C5_AXATEN1 == __cUserId .And. !(M->C5_AXATEN1 $ UserLib )
	ApMsgStop("Usuario sem direito a liberacao de pedido....")
	_lRet := .f.
EndIf

// Adiciona a matriz os itens a serem checadas as licencas.
For _nW := 1 To Len(aCols)                     
	If aCols[_nW,_nPosQLib] > 0 .And. Empty(aCols[_nW,_nPosLic])
		aAdd(_aItens,{aCols[_nW,_nPosProd],aCols[_nW,_nPosQLib]})
	EndIf
Next _nW	

// Se tiver item a liberar saira checando as licencas.
If ! Empty(_aItens)
	_aRet1	:= U_ESTV004("C",M->C5_CLIENTE+M->C5_LOJACLI,_aItens)	// Checa as licencas do cliente por produto
	// Retorno
	// _aRet[1] = .t. ou .f. = se foi aprovado
	// _aRet[2] = Log da aprovacao  
	// _aRet[3] = Mostra ou nao Log, retorno .t. ou .f. (Para os casos de monitore)
	_aRet2	:= U_ESTV004("T",M->C5_TRANSP,_aItens)				// Checa as Licencas da transportadora por produto
	// Retorno
	// _aRet[1] = .t. ou .f. = se foi aprovado
	// _aRet[2] = Log da aprovacao                                         b
	// _aRet[3] = Mostra ou nao Log, retorno .t. ou .f. (Para os casos de monitore)
	If ! _aRet1[1] .Or. ! _aRet2[1]
		U_ESTV004A(_aRet1[2]+_aRet2[2])                                
		_lRet := .f.
	EndIf
	
EndIf                                      

RestArea(_aArea)

Return(_lRet)
