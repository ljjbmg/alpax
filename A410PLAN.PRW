#INCLUDE "PROTHEUS.CH"
/*
PROJETO CRM SIMPLES ALPAX
*/
USER FUNCTION A410PLAN()

Local lver


if alltrim(UPPER(GETENVSERVER())) == "CRM-PRODUCAO/CRM-TESTE" 
	lver := .f.
else
	lver := .t.
	//MsgAlert("*** ATENCAO, USAR AMBIENTE CRM-PRODUCAO***")
endif	



RETURN(lver)
