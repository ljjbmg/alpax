/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATV002   ºAutor  ³Microsiga           º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para validar o valor do preco unitario do produto no º±±
±±º          ³pedido de vendas, para limite o valor do desconto concedido.º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATV002()

Local _cProd 	:= GdFieldGet("C6_PRODUTO")
Local _nPrcV	:= M->C6_PRCVEN
Local _nPrMin	:= 0  
Local cUsrMsg := SUPERGETMV("AX_MSGPRMI", .T., "LUCI/JABSON/FABIO RODRIGUES/LUCIANO/MARCO ANTONIO/ELAINE/COMERCIAL LIBERACOES")

_lRet := .t.

If SB1->(DbSeek(xFilial("SB1")+_cProd))
	_nPrMin := U_FATG017(SB1->B1_COD,M->C5_CLIENTE,M->C5_LOJACLI,GdFieldGet("C6_OPER"))
	If _nPrcV < _nPrMin .And. ! upper(Alltrim(cUserName)) $ cUsrMsg .And. _nPrcV > SB1->B1_AXCUS
			ApMsgStop("Preco de venda esta menor que o preco minimo, solicitar alteracao ao cadastro !!!")
		_lRet := .f.
	Else
		If _nPrcV < SB1->B1_AXCUS .And. ! upper(Alltrim(cUserName)) $ cUsrMsg
			ApMsgStop("Preco de venda esta menor que o preco de custo, solicitar alteracao a Sra. Luci ou Sr. Ocimar !!!")
			_lRet := .f.
		EndIf
	EndIf
EndIf                                                    
            


If _lRet .And. ! upper(Alltrim(cUserName)) $ cUsrMsg
	_nPrcTab    := U_FATG016(SB1->B1_PRV1,M->C5_TABELA,SB1->B1_COD,M->C5_CLIENTE,M->C5_LOJACLI,GdFieldGet("C6_OPER"))  // PRECO DO CADASTRO PARA EFEITO DE CALCULO DO DESCONTO
	//	_nPrcTab    := SB1->B1_PRV1 // PRECO DO CADASTRO PARA EFEITO DE CALCULO DO DESCONTO
	//	_nPrcTab	:= Posicione("DA1",2,xFilial("DA1")+_cProd+M->C5_TABELA,"DA1_PRCVEN")
	//	_nPrcTab	:= iif(_nPrcTab==0,SB1->B1_PRV1,_nPrcTab)
	_nPerc		:= Posicione("SZ7",2,xFilial("SZ7")+__cUserId,"Z7_PERC")
	If _nPerc > 0
		_nPerc	:= _nPerc / 100
	EndIf
	_nMin		:= _nPrcTab - (_nPrcTab * _nPerc)
	
	If _nPrcV < _nMin
		ApMsgStop("Preco minimo R$." + Alltrim(Strtran(Str(_nMin,16,2),".",","))+" ,voce ultrapassou o limite de desconto deste item")
		_lRet := .f.
	EndIf
	
EndIf

Return(_lRet)
