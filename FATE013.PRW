/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????͝??
???Programa  ?FATE013   ?Autor  ?Microsiga           ? Data ?  05/10/05   ???
?????????????????????????????????????????????????????????????????????????͚??
???Desc.     ? Funcao para consulta a condicao de pagamento digitado sendo???
???          ? liberado somente os cadastrados.                           ???
?????????????????????????????????????????????????????????????????????????͚??
???Uso       ? AP - ALPAX.                                                ???
?????????????????????????????????????????????????????????????????????????͟??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/
User Function FATE013()

_lRet 		:= .F.
_nPosOper 	:= aScan(aHeader,{|x| Alltrim(x[2]) == "C5_CONDPAG" })
_cOper	 	:= M->C5_CONDPAG
_cGrupo     := Posicione("SE4",1,xFilial("SE4")+_cOper,"E4_GRPUSU")
aArea       := getArea()

dbSelectArea("ZBD")   //ABRE TABELA DE CONTROLE DE ACESSO DE PEDIDOS DE VENDA
ZBD->(dbSetOrder(2))  //ZBD_FILIAL+ZBD_NOME

IF ZBD->(dbSeek(xFilial("ZBD")+cUserName ) )
	
	Do Case
		Case _cGrupo == 'U' .And. ZBD->ZBD_CONDPG = 'U'          // GRUPO "U" PARA TODOS USUARIOS
			_lRet := .T.
		Case _cGrupo == 'U' .And. ZBD->ZBD_CONDPG = 'S'          // GRUPO "U" PARA SUP.
			_lRet := .T.
		Case _cGrupo == 'U' .And. ZBD->ZBD_CONDPG = 'A'          // GRUPO "U" PARA ADM.
			_lRet := .T.
		Case _cGrupo == 'S' .And. ZBD->ZBD_CONDPG = 'S'          // GRUPO DE CONDICAO DE PAGTO PARA SUP.
			_lRet := .T.
		Case _cGrupo == 'S' .And. ZBD->ZBD_CONDPG = 'A'          // GRUPO DE CONDICAO DE PAGTO PARA ADM.
			_lRet := .T.
		Case _cGrupo == 'A' .And. ZBD->ZBD_CONDPG = 'A'          // GRUPO DE CONDICAO DE PAGTO PARA ADM.
			_lRet := .T.
	EndCase
ENDIF

IF _lRet == .F.
	ApMsgAlert("Usuario sem permissao para utilizar essa condicao, solicitar ao supervisor")
ENDIF

dbSelectArea("ZBD")
dbCloseArea()
RestArea(aArea)

Return(_lRet)