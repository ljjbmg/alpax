#INCLUDE "PROTHEUS.CH"

/*
FUNCAO   : RADVL003
OBJETIVO : ROTINA AUTOMATICA PARA APONTAMENTO DA PRODUCAO
AUTOR    : FABRICA DE SOFTWARE ADVPL  (advpl@advpl.com.br)
PROJETO  : ALPAX
DATA     : 19.11.09

-------------------------------------------------------------------------- 
PARAMETROS
01) VETOR COM CONTEUDO DOS CAMPOS A SEREM UTILIZADOS
02) OPCAO DA ROTINA

-------------------------------------------------------------------------- 
RETORNO
.T. PARA PROCESSAMENTO CONFIRMADO
.F. PARA FALHA NO PROCESSAMENTO

--------------------------------------------------------------------------
19.11.09 : IMPLEMENTADO CODIGO PADRAO

*/

USER FUNCTION RADVL003(aParam,lInclui)

Local aDados      := {}

Local _lRet       := .T.                // RETORNO
Local MD3_OP      := aParam[1]          // PRODUCAO NUMERO DA OP 
Local MD3_TM      := aParam[2]          // PRODUCAO TIPO DE MOVIMENTO  
Local MD3_QUANT   := aParam[3]          // PRODUCAO QUANTIDADE PRODUZIDA
LOcal MD3_doc     := aParam[4]                                            
LOcal MD3_COD     := aParam[5]    
lOCAL MD3_LOCAL   := ""
Local nOper       := IIF(lInclui,3,5)   // OPERACAO, 3 INCLUIR, 5 EXCLUIR  
Private lMsErroAuto  := .f.             // FLAG EXECAUTO

// FORCANDO POSICIONAMENTO DO SB2 POIS ESTA COM FALHA NO EXECAUTO
DBSELECTAREA("SB2")
RETINDEX("SB2")
DBGOTOP()
DBSETORDER(1)
DBGOTOP()
//DBSEEK(XFILIAL("SB2")+"01"+MD3_COD)

IF nOper == 3
     AADD(aDados,{"D3_OP"     ,MD3_OP         ,NIL})  
     AADD(aDados,{"D3_TM"     ,MD3_TM         ,NIL})  
     AADD(aDados,{"D3_QUANT"  ,MD3_QUANT      ,NIL})  
else  
     MD3_LOCAL := SD3->D3_LOCAL
	 AADD(aDados,{"D3_OP",MD3_OP,NIL})
	 AADD(aDados,{"D3_COD",MD3_COD,NIL})
	 AADD(aDados,{"D3_LOCAL",MD3_LOCAL,NIL})
	 AADD(aDados,{"D3_DOC",MD3_DOC,NIL})
	 
endif

MSExecAuto({|x,y| mata250(x,y)},aDados,nOper) 

If lMsErroAuto
    Mostraerro()
	_lRet := .F.  
	Return(_lRet)
else
	_lRet := .T.
EndIf


Return(_lRet)