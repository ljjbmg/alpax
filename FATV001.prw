/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATV001   ºAutor  ³Adriano Luis Brandaoº Data ³  17/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para validacao do preco VK_PRCVEN, onde o preco deve º±±
±±º          ³ra ser igual ou maior que o B1_PRV1                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
Alterado dia 29/08/2022 por Matheo Totalit
	- Inclusão de usuário novo para substituir a Luci em sua ausência.
*/
User Function FATV001()

Local _nPrMin   := 0   
Local _cCodUsr  := RetCodUsr()
Local _cUsrlib1 := SuperGetMV("MV_XUSRLI1",.F.,"000000") //Parâmetro que diz os códigos dos usuários que podem usar preços menores que o preço mínimo.
Local _cUsrLib2 := SuperGetMV("MV_XUSRLI2",.F.,"000000") //Parâmetro que diz os códigos dos usuários que podem usar preços menores que o preço de custo.

_lRet := .t.

If SB1->(DbSeek(xFilial("SB1")+TMP1->CK_PRODUTO))
	_nPrMin := U_FATG017(SB1->B1_COD,M->CJ_CLIENTE,M->CJ_LOJA,TMP1->CK_OPER)  
	If TMP1->CK_PRCVEN < _nPrMin .And. !_cCodUsr $ alltrim(_cUsrlib1) .And. TMP1->CK_PRCVEN >= SB1->B1_AXCUS
		ApMsgStop("Preco de venda menor que o preco minimo, solicitar alteracao ao cadastro !!!")
		_lRet := .f.
	Else
		If TMP1->CK_PRCVEN < SB1->B1_AXCUS .And. !_cCodUsr $ alltrim(_cUsrLib2)
			ApMsgStop("Preco de venda menor que o preco de custo, solicitar alteracao a Sra. Luci!!!")
			_lRet := .f.
		EndIf
	EndIf
EndIf
If _lRet
	_cProd		:= TMP1->CK_PRODUTO
	_nPrcV		:= TMP1->CK_PRCVEN 
	_nPrcTab    := U_FATG016(SB1->B1_PRV1,M->CJ_TABELA,SB1->B1_COD,M->CJ_CLIENTE,M->CJ_LOJA,TMP1->CK_OPER) // COMPRARAR COM PRECO DO CADASTRO PARA EFEITO DE CALCULO DE DESCONTO
 	_nPerc		:= Posicione("SZ7",2,xFilial("SZ7")+__cUserId,"Z7_PERC")
	
	If _nPerc > 0
		_nPerc	:= _nPerc / 100
	EndIf
	_nMin		:= _nPrcTab - (_nPrcTab * _nPerc)
	
	If _nPrcV < _nPrMin
		ApMsgStop("Preco minimo R$." + Alltrim(Strtran(Str(_nPrMin,16,2),".",","))+" ,voce ultrapassou o limite de desconto deste item")
		
		If !_cCodUsr $ alltrim(_cUsrLib2)
			_lRet := .f.
		else
			_lRet := .t.
		EndIf
	EndIf
	
EndIf

Return(_lRet)
