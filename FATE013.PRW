/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹
¹¹ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹¹
¹¹ºPrograma  ³FATE013   ºAutor  ³Microsiga           º Data ³  05/10/05   º¹¹
¹¹ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍš¹¹
¹¹ºDesc.     ³ Funcao para consulta a condicao de pagamento digitado sendoº¹¹
¹¹º          ³ liberado somente os cadastrados.                           º¹¹
¹¹ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍš¹¹
¹¹ºUso       ³ AP - ALPAX.                                                º¹¹
¹¹ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍŸ¹¹
¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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