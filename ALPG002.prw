#include "protheus.ch"
/*
=========================================================================================
FONTE       : ALPG002
AUTOR       : OCIMAR ROLLI (OTIMIZACAO ALPG001 EDUARDO NAKAMATU / BIALE)
DATA        : 3 DE SETEMBRO DE 2012
OBJETIVO    : DETERMINAR COMISSAO A SER PAGA
ARQUITETURA : GATILHOS, SZQ, SB1, SA3, CAMPOS DE LINHA, FAMILIA, MARCA, COMISSAO
=========================================================================================
*/


USER FUNCTION ALPG002(cVend,cProd,nVend,nLista,cCliente)

Local nRetCli  := getadvfval("SA1","A1_COMIS",xFilial("SA1")+cCliente,1)    // PEGA COMISSAO DO CADASTRO DE CLIENTE
Local nRet     := getadvfval("SA3","A3_COMIS",XFILIAL("SA3")+cVend,1)       // PEGA COMISSAO DO CADASTRO DO VENDEDOR
Local nPer     := IIF(nVend>nLista,0,  ((1-nVend/nLista)*100)   )           // CARCULA MARGEM DE DESCONTO
Local aArea001 := getarea(), aAreaB1
Local aArea002 := getarea(), aAreaZQ
Local cTab     := criatrab(,.f.)
Local _cProd   := cProd
Local cLinPro  := SubStr(_cProd,1,2)                                        // PEGA A LINHA DO PRODUTO NO CADASTRO  -  OCIMAR
Local cMarPro  := ' '                                                       // VARIAVEL PARA PEGAR A MARCA
Local lRet     := .F.

// POSICIONA PRODUTO PARA BUSCA DE DADOS
dbselectarea("SB1")
aAreaB1 := getarea()
dbsetorder(1)
dbgotop()
IF !DBSEEK(XFILIAL("SB1")+ALLTRIM(cProd))
	Alert("Falha ao definir produto!")
	Return(0)
ELSE
	cMarPro :=ALLTRIM(SB1->B1_MARCA)
ENDIF

dbselectarea("SZQ")
aAreaZQ := getarea()
dbsetorder(1)
dbgotop()

Do Case
	Case DBSEEK(XFILIAL("SZQ")+cVend+cLinPro+cMarPro+'  ') .And. lRet == .F.
		nRet := SZQ->ZQ_COMISSA
		lRet := .T.
	Case DBSEEK(XFILIAL("SZQ")+cVend+'  '+cMarPro+'  ') .And. lRet == .F.
		nRet := SZQ->ZQ_COMISSA
		lRet := .T.
	Case DBSEEK(XFILIAL("SZQ")+cVend+cLinPro+'  '+'  ') .And. lRet == .F.
		nRet := SZQ->ZQ_COMISSA
		lRet := .T.
	Case lRet == .F.
		lRet := .T.
EndCase

dbselectarea("SA1")
aAreaA1 := getarea()
dbsetorder(1)
dbgotop()

If nRetCli <> 0
	SA1->(Dbseek(xFilial("SA1")+cCliente+'01'))
	nRet := SA1->A1_COMIS
	lRet := .T.
EndIf

restarea(aAreaB1)
restarea(aArea001)
restarea(aAreaZQ)
restarea(aArea002)
restarea(aAreaA1)


return(nRet)
