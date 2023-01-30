/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹
¹¹ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹¹
¹¹ºPrograma  ³ESTG004   ºAutor  ³Ocimar Rolli        º Data ³  08/01/14   º¹¹
¹¹ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍš¹¹
¹¹ºDesc.     ³ Funcao para validação do tipo de material requisitado pelo º¹¹
¹¹º          ³ usuario.                                                   º¹¹
¹¹ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍš¹¹
¹¹ºUso       ³ AP - ALPAX.                                                º¹¹
¹¹ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍŸ¹¹
¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ESTG004()

Local _lRet 		:= .t.
//Local _nPosOper 	:= aScan(aHeader,{|x| Alltrim(x[2]) == "D3_COD" })
Local _cProd	 	:= M->D3_COD
Local _cTipProd   := " "
Local aArea       := getArea()

dbSelectArea("SB1")   //ABRE TABELA DE PRODUTO
SB1->(dbSetOrder(1))  //SB1_FILIAL+SB1_COD
IF SB1->(dbSeek(xFilial("SB1")+_cProd))
	_cTipProd := SB1->B1_TIPO
ELSE
	ApMsgAlert("Produto não encontrado !")
	_lRet := .F.
	_cTipProd := " " //LIMPA VARIAVEL
ENDIF


dbSelectArea("ZBD")   //ABRE TABELA DE CONTROLE DE ACESSO DE PEDIDOS DE VENDA
ZBD->(dbSetOrder(2))  //ZBD_FILIAL+ZBD_NOME
IF ZBD->(dbSeek(xFilial("ZBD")+cUserName ) )
	IF _cTipProd $ ZBD->ZBD_TPPROD .And. _cTipProd <> " " 
		_lRet := .T.
	ELSE 
		IF ALLTRIM(ZBD->ZBD_TPPROD) == "*"
			_lRet := .T.
		ELSE 
			ApMsgAlert("Usuario nao tem permissao para requisitar produtos do tipo "+alltrim(_cTipProd),+" Bloqueado")
			_lRet := .F.
		ENDIF
	ENDIF
ELSE
	ApMsgAlert("Usuario nao tem permissao para requisitar produtos do tipo "+alltrim(_cTipProd),+" Bloqueado")
	_lRet := .F.
ENDIF
dbSelectArea("ZBD")
dbCloseArea("ZBD")
dbSelectArea("SB1")
dbCloseArea("SB1")           
RestArea(aArea)

Return(_lRet)