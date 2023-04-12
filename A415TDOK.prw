/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A415TDOK  ºAutor  ³Microsiga           º Data ³  01/08/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para validacao total do orcamento de ven  º±±
±±º          ³ das.                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Rwmake.ch"

User Function A415TDOK()

Local _lRet 		:= .t. 
Local _lRetFin 		:= .t.
Local _aArea 		:= GetArea()
Local _aAreaTMP1  	:= TMP1->(GetArea())
Local _aAreaB1		:= SB1->(GetArea())
Local _cMens		:= ""
Local _nValOrc      := 0
Local UserLib		:= SuperGetMV("MV_USERLIB",,"000000")

// Testa se o pedido é do usuario
If Altera
	If M->CJ_AXATEND <> __cUserId .and. ! __cUserId $ UserLib
		// se nao é o usuario do pedido, testa se é supervisor do atendente
		PswOrder(1)
		if PswSeek(M->CJ_AXATEND,.t.)
			_aSuperior :=pswret(1)
			If _aSuperior[1,11] <> __cUserId		// se tambem nao é o supervisor do atendente bloqueia alteracao
				ApMsgStop("Este orcamento pertence a outro usuario, vc nao pode altera-lo....")
				_lRet := .f.
			EndIf
		Endif
	endif
endIf

// Validacao da Policia Federal, Exercito, Secretaria da seguranca publica.

If _lRet
	
	TMP1->(DbGoTop())
	
	_aItens := {}
	Do While ! TMP1->(Eof())
		If Empty(TMP1->CK_XAUTORI)
			aAdd(_aItens,{TMP1->CK_PRODUTO, TMP1->CK_QTDVEN})
		EndIf
		TMP1->CK_PRUNIT = TMP1->CK_PRCVEN      // Incluido Ocimar -> preco de lista igual preco de venda
		_nValOrc += TMP1->CK_VALOR
		TMP1->(DbSkip())
	EndDo
	
	_aRet	:= U_ESTV004("C",M->CJ_CLIENTE+M->CJ_LOJA,_aItens)	// Validacao Policia Federal
	If ! _aRet[1]
		U_ESTV004A(_aRet[2])
	EndIf
	
EndIf

// Testa se saldo do limite de credito é suficiente para efetivacao.   Ocimar

If _lRetFin == .t.
	SA1->(DbSetOrder(1))
	SA1->(Dbseek(xFilial("SA1")+M->CJ_CLIENTE+M->CJ_LOJA))
	_cCliente := AllTrim(SA1->A1_NOME)
	If SA1->A1_RISCO <> 'A'
		_nLimCre :=(SA1->A1_LC+SA1->A1_LCFIN-SA1->A1_SALPED)
		If _nLimCre < _nValOrc                                                          •
			_lRetFin := .f.
		EndIf
	EndIf
EndIf

// se houve problema de credito da uma mensagem de alerta ao usuario.
If ! _lRetFin
	ApMsgStop("Havera bloqueio de credito futuro neste cliente, verificar cadastro !!!")
EndIf

Return(_lRet)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTV004A  ºAutor  ³Adriano Luis Brandaoº Data ³  04/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para apresentar em tela um log.                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ESTV004A(_cMens)

Local aSize := MsAdvSize()
Local aObjects := {}
Local aInfo
Local aPosObj
Local oDlg

AAdd( aObjects, { 100, 010 , .T., .F. } )
AAdd( aObjects, { 100, 090 , .T., .T. } )
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5, 5 }
aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)

cCadastro := "LOG DE PRODUTOS CONTROLADOS"

DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 To aSize[6]-100,aSize[5]-50 of oMainWnd PIXEL
oObs:=TMultiGet():New(014,003,{|u| If(PCount()>0,_cMens := u,_cMens)},oDlg,aPosObj[2,4]-30,aPosObj[2,3]-070,,.F.,,,,.T.,"",.f.,,.F.,.F.,.T.,,,.F.,,.F.)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||oDlg:End()},{||oDlg:End()},,,,,.F.,.F.,.F.)

Return

/*
STATIC FUNCTION CHKSU5()
// NAKAMATU
RETURN(.T.)
*/
