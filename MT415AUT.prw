#Include "Protheus.ch"
#Include "Topconn.ch"

/*/{Protheus.doc} User Function MT415AUT
	(long_description) Ponto de entrada para validar a efetivação de orçamentos
	@type  Function
	@author user
	@since
	@version version
	@param param_name, param_type, param_descr
	@return return_var, return_type, return_description
	@example
	(examples)
	@see (links_or_references)
	Ultima alteração por Matheo C. Totalit em 01/09/2022
		- Criados os parâmetros cTabDA0 e lTabPro
		- Adicionado lTabPro == .f.  no If _nPrMin > SCK->CK_PRCVEN
	/*/

User Function MT415AUT()

Local _lRet      := .T.
Local _cMen      := ""
Local _nLimCre   := 0
Local _areasck   := SCK->(GetArea()) 
Local _areascj   := SCJ->(GetArea()) 
Local cNumOrc    := SCJ->CJ_NUM
Local cCliente   := SCJ->CJ_CLIENTE
Local cLoja      := SCJ->CJ_LOJA
Local dDataOrc   := SCJ->CJ_VALIDA
Local _nPrMin	 := 0
Local lPrcMin    := .F.
Local cUsrPrcMin := SuperGetMv("AX_USRPRC",.T.,"luiz.araujo|LUCI|COMERCIAL LIBERACOES",)
Local cTabDA0    := SCJ->CJ_TABELA
Local lTabPro    := .F.

Private _cCliente := ""
Private _nValOrc := 0

lTabPro    := Iif(Posicione("DA0",1,xFilial("DA0")+cTabDA0,"DA0_TABPRO")=="2",.T.,.F.)


DbSelectArea("SCK")
DbSetOrder(1)
//CK_FILIAL, CK_NUM, CK_ITEM, CK_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
MsSeek(xFilial("SCK")+cNumOrc )     // Filial: 01 / Código: 000001 / Loja: 02

_aItens := {}
//--Do While !SCK->(Eof()) .Or. SCK->CK_NUM == cNumOrc 
Do While SCK->CK_NUM == cNumOrc 
	SF4->(DbSetOrder(1))
	SF4->(Dbseek(xFilial("SF4")+SCK->CK_TES))
	If SF4->F4_DUPLIC == 'S'
		_nValOrc += SCK->CK_VALOR
	EndIf
	If Empty(SCK->CK_XAUTORI)
		aAdd(_aItens,{SCK->CK_PRODUTO, SCK->CK_QTDVEN})
	Else
		SZU->(DbSetOrder(5))
		If ! SZU->(DbSeek(xFilial("SZU")+SCK->CK_XAUTORI+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
			_lRet := .f.
			_cMen += "Produto:" + SCK->CK_PRODUTO + "Licença especial:" + SCK->CK_XAUTORI + " nao encontrada " + CHR(13)+CHR(10)
		Else
			If ! Empty(SZU->ZU_PEDIDO)
				_cMen := "Produto:" + SCK->CK_PRODUTO + "Licença ja utilizada em outro pedido " + CHR(13)+CHR(10)
				_lRet := .f.
			EndIf
		EndIf
	EndIf
	_nPrMin := U_FATG017(SCK->CK_PRODUTO,SCJ->CJ_CLIENTE,SCJ->CJ_LOJA,SCK->CK_OPER)  
	IF _nPrMin > SCK->CK_PRCVEN .and. lTabPro ==.f.
	
		Alert("Preço do produto - " + SCK->CK_PRODUTO + " - abaixo do valor Mínimo","Alerta de Preço! Abaixo do mínimo.")
		lPrcMin := .T.
	
	End
	SCK->(DbSkip())
EndDo

_aRet	:= U_ESTV004("C",cCliente+cLoja,_aItens)	// Checagem dos produtos e licencas.
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

If _lRet == .T.

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

IF dDataOrc < dDataBase 

	_lRet := .f.
	ApMsgStop("Orçamento com data de validade vencida, nao será efetivado ")

End

If lPrcMin .And. !upper(Alltrim(cUserName)) $ cUsrPrcMin
   _lRet := .f.
   Alert("Orçamento não será efetivado, corrigir os preços")
elseIf lPrcMin .And. upper(Alltrim(cUserName)) $ cUsrPrcMin
	Alert("Orçamento Liberado, com preços abaixo do mínimo")
End

restarea(_areasck)
restarea(_areascj)

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
