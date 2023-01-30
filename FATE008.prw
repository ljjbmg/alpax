/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹
¹¹ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹¹
¹¹ºPrograma  ³FATE008   ºAutor  ³Microsiga           º Data ³  05/10/05   º¹¹
¹¹ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍš¹¹
¹¹ºDesc.     ³ Funcao para consulta o TEs digitado e validar as simples   º¹¹
¹¹º          ³ remessa / Demonstracao.                                    º¹¹
¹¹ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍš¹¹
¹¹ºUso       ³ AP - ALPAX.                                                º¹¹
¹¹ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍŸ¹¹
¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATE008()

_lRet 		:= .t.
_cOperRem	:= GetMv("MV_PETIOP")
_nPosOper 	:= aScan(aHeader,{|x| Alltrim(x[2]) == "CK_OPER" })
_cOper	 	:= M->CK_OPER
aArea       := getArea()

dbSelectArea("ZBD")   //ABRE TABELA DE CONTROLE DE ACESSO DE PEDIDOS DE VENDA
ZBD->(dbSetOrder(2))  //ZBD_FILIAL+ZBD_NOME
IF ZBD->(dbSeek(xFilial("ZBD")+cUserName ) )
	IF _cOper $ ZBD->ZBD_TPOP 
		_lRet := .T.
	ELSE 
		IF ALLTRIM(ZBD->ZBD_TPOP) == "*"
			_lRet := .T.
		ELSE 
			ApMsgAlert("Usuario sem permissao para utilizar operacao diferente de "+alltrim(ZBD->ZBD_TPOP),"Bloqueado")
			_lRet := .F.
		ENDIF
	ENDIF
ELSE
	ApMsgAlert("Usuario sem permissao para utilizar operacao diferente de "+alltrim(ZBD->ZBD_TPOP),"Bloqueado")
	_lRet := .F.
ENDIF
dbSelectArea("ZBD")
dbCloseArea()           
RestArea(aArea)
/*
If  ! _cOper $ _cOperRem .And. ! Upper(Alltrim(cUserName)) $ (GetMv("MV_PEALTI"))
	_lIgual := .f.
		If ! _lIgual
			ApMsgAlert("Usuario sem permissao para utilizar operacao diferente de 01","Bloqueado")
			_lRet := .f.
		EndIf
Endif
*/
Return(_lRet)