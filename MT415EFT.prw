/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT415EFT  ºAutor  ³Adriano Luis Brandaoº Data ³  13/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de validacao no momento da efetivacao do orcamento.  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Protheus.ch"
#Include "Topconn.ch"


User Function MT415EFT()

Local _lRet      := .t.
Local _cMen      := ""
Local _nLimCre   := 0

Private _cCliente := ""
Private _nValOrc := 0

TMP1->(DbGoTop())

_aItens := {}
Do While ! TMP1->(Eof())
	SF4->(DbSetOrder(1))
	SF4->(Dbseek(xFilial("SF4")+TMP1->CK_TES))
	If SF4->F4_DUPLIC == 'S'
		_nValOrc += TMP1->CK_VALOR
	EndIf
	If Empty(TMP1->CK_XAUTORI)
		aAdd(_aItens,{TMP1->CK_PRODUTO, TMP1->CK_QTDVEN})
	Else
		SZU->(DbSetOrder(5))
		If ! SZU->(DbSeek(xFilial("SZU")+TMP1->CK_XAUTORI+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
			_lRet := .f.
			_cMen += "Produto:" + TMP1->CK_PRODUTO + "Licença especial:" + TMP1->CK_XAUTORI + " nao encontrada " + CHR(13)+CHR(10)
		Else
			If ! Empty(SZU->ZU_PEDIDO)
				_cMen := "Produto:" + TMP1->CK_PRODUTO + "Licença ja utilizada em outro pedido " + CHR(13)+CHR(10)
				_lRet := .f.
			EndIf
		EndIf
	EndIf
	
	TMP1->(DbSkip())
EndDo

_aRet	:= U_ESTV004("C",SCJ->CJ_CLIENTE+SCJ->CJ_LOJA,_aItens)	// Checagem dos produtos e licencas.
// Retorno
// _aRet[1] = .t. ou .f. = se foi aprovado
// _aRet[2] = Log da aprovacao

// Se nao houve liberacao das licencas, apresenta mensagem e retorna false, bloqueando a efetivacao do orcamento.
If ! _aRet[1] .or. ! _lRet
	_cMen := _cMen + CHR(13)+CHR(10)
	_cMen += _aRet[2]
	U_ESTV004A(_aRet[2])
	_lRet := .f.
EndIf

// Testa se saldo do limite de credito é suficiente para efetivacao.   Ocimar

If _lRet == .t.
	SA1->(DbSetOrder(1))
	SA1->(Dbseek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
	_cCliente := AllTrim(SA1->A1_NOME)
	If SA1->A1_RISCO <> 'A'
		If SA1->A1_VENCLC >= dDataBase
			_nLimCre :=(SA1->A1_LC+SA1->A1_LCFIN-SA1->A1_SALPED)
			If _nLimCre < _nValOrc
				_lRet := .f.
				ApMsgStop("Valor do orcamento ultrapassa o limite de credito disponivel, orcamento nao será efetivado ")
				_fGeraEnv()
			EndIf
		Else
			_lRet := .f.
			ApMsgStop("Limite de credito com data vencida, orcamento nao será efetivado ")
			_fGeraEnv()
		EndIf
	EndIf
EndIf


IF SCJ->CJ_VALIDA < dDataBase 

	_lRet := .f.
	ApMsgStop("Orçamento com data de validade vencida, nao será efetivado ")

End

Return(_lRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fGeraEnv ºAutor  ³Adriano Luis Brandaoº Data ³  04/06/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para envio de e-mail                                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fGeraEnv()

oProcess := TWFProcess():New( "CRED3", "Bloqueio de credito" )

// Cria-se uma nova tarefa para o processo.
oProcess:NewTask( "Bloqueio", "\WORKFLOW\BLOCRED3.HTM" )
oProcess:cSubject := "Bloqueio de credito - Alpax"
oProcess:cTo  := "financeiro@alpax.com.br"
oProcess:cCC  := ""
oProcess:cBCC := ""
oProcess:bReturn := ""

// Faz uso do objeto ohtml que pertence ao processo
oHtml := oProcess :oHtml

aadd( (oHtml:ValByName( "IT.ORC"     )), SCJ->CJ_NUM)
aadd( (oHtml:ValByName( "IT.CODCLI"  )), SCJ->CJ_CLIENTE)
aadd( (oHtml:ValByName( "IT.CLIENTE" )), SA1->A1_NOME)
aadd( (oHtml:ValByName( "IT.VALOR"   )), "R$ "+Transform(_nValOrc,"@e 999,999,999.99"))
aadd( (oHtml:ValByName( "IT.ATENDE"  )), UsrRetName(SCJ->CJ_AXATEND))

oProcess:Start()

Return
