/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA022   ºAutor  ³Ocimar Rolli        º Data ³  07/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de Consulta Status das licencas do cliente e da      º±±
±±º          ³transportadora.                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "TopConn.ch"
#Include "Protheus.ch"

User Function FATA022()

Local _aItens 	:= {}
Local _aArea		:= GetArea()

_cAlias := GetNextAlias()

_cQuery := "SELECT C6_PRODUTO, C6_QTDVEN-C6_QTDENT AS SALDO "
_cQuery += "FROM " + RetSqlName("SC6") + " C6 "
_cQuery += "WHERE C6_FILIAL = '" + xFilial("SC6") + "' AND C6_NUM = '" + M->C5_NUM + "' "
_cQuery += "      AND (C6_QTDVEN-C6_QTDENT) > 0 "
_cQuery += "      AND D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias (_cAlias)

TcSetField((_cAlias),"SALDO","N",12,2)

Do While ! (_cAlias)->(Eof())
	aAdd(_aItens,{(_cAlias)->C6_PRODUTO,(_cAlias)->SALDO})
	(_cAlias)->(DbSkip())
EndDo

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
	// _aRet[2] = Log da aprovacao
	// _aRet[3] = Mostra ou nao Log, retorno .t. ou .f. (Para os casos de monitore)
	If ! _aRet1[1] .Or. ! _aRet2[1]
		U_ESTV004A(_aRet1[2]+_aRet2[2])
	Else
		ApMsgInfo("Pedido OK !")
	EndIf
Else
	ApMsgInfo("Pedido OK !")
EndIf

RestArea(_aArea)

Return()

