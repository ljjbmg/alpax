#include "protheus.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"
/******************************************************************************
* TOTALIT                      01/2020                                        *
* P.E. apos a gravacao da Solicitacao pela funcao A110Grava em inclusao,      *
* alteracao e exclusao, localizado fora da transacao possibilitando assim a   *
* inclusao de interface apos a gravacao de todas as solicitacoes              *
******************************************************************************/
User Function M110STTS() // nOpcao, oProcess )
Local cNumSol  := ParamIXB[1]
Local nOpt     := ParamIXB[2]
Local lCopia   := ParamIXB[3]
Local oProcess
Local cMailID  := ""
Local aCond:={},nTotal := 0
Local aSM0Info := FWSM0Util():GetSM0Data(,,{"M0_FILIAL"})

DbSelectArea("SC1")
SC1->(DbSetOrder(1))
		
cNomeFor := ""
DbSelectArea("SA2")
SA2->(DbSetOrder(1))
If !Empty(AllTrim(SC1->C1_FORNECE))
	SA2->(DbSeek(xFilial("SA2") + SC1->C1_FORNECE + SC1->C1_LOJA))
	cNomeFor := AllTrim(SA2->A2_NOME)
Endif

SCR->(dBSetOrder(1))   // CR_FILIAL+CR_TIPO+CR_NUM+CR_NIVEL
If SCR->(dBSeek( xFilial("SCR") + "SC" + PADR(cNumSol,TamSX3("CR_NUM")[1]) + "01"))
	While SCR->(!EoF()) .And. SCR->CR_FILIAL == xFilial("SCR") .And. SCR->CR_TIPO == "SC" .And. AllTrim(SCR->CR_NUM) == AllTrim(cNumSol) .And. SCR->CR_NIVEL == "01"
		SC1->(DbSeek(xFilial("SC1") + cNumSol))
		cAprov   := SCR->CR_USER 
		cGrpApv	 := SCR->CR_GRUPO 

		U_AXMainWF(cFilAnt,SC1->C1_NUM,1,cAprov,cGrpApv)
		
		SCR->(DbSkip())
	EndDo
Endif
 
Return Nil
