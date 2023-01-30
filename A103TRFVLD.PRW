#INCLUDE "PROTHEUS.CH"

/*
AUTOR	: ANDERSON BIALE
DATA	: 05/11/12
DESC	: P.E. EXCLUSAO DA NF DE ENTRADA
*/

USER FUNCTION A103TRFVLD()

LOCAL nTipo		:= PARAMIXB[1]
LOCAL lDeleta	:= PARAMIXB[2]
LOCAL lRet		:= .T.// Validações desejadas conforme a regra de negócio praticada

IF lDeleta
	
	//DELETANDO REGISTROS DA ZBB(ENDEREÇAMENTO POR SERIE)
	cUPD:=" UPDATE "+RETSQLNAME("ZBB")+" SET D_E_L_E_T_ = '*' "			+CRLF  
	cUPD+=" FROM "+RETSQLNAME("ZBB")+" AS ZBB (NOLOCK)"                	+CRLF
	cUPD+=" WHERE ZBB.D_E_L_E_T_ = '' " 								+CRLF      	
	cUPD+=" 	AND ZBB_FILIAL = '"+xFILIAL("ZBB")+"' "     			+CRLF
	cUPD+="		AND ZBB_DOC 	= '"+ALLTRIM(SF1->F1_DOC)+"' "    		+CRLF
	cUPD+="		AND ZBB_SERIE 	= '"+ALLTRIM(SF1->F1_SERIE)+"' "    	+CRLF
	cUPD+="		AND ZBB_FORNEC 	= '"+ALLTRIM(SF1->F1_FORNECE)+"' "    	+CRLF
	cUPD+="		AND ZBB_LOJA 	= '"+ALLTRIM(SF1->F1_LOJA)+"' "    		+CRLF
	TCSQLEXEC(cUPD)		

ENDIF

RETURN lRet