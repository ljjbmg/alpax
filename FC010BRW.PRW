#include "protheus.ch"
/*
PONTO DE ENTRADA: FC010BRW
USO: ACRESCENTANDO ITEM NO MENU DA FUNCAO FINC010, CHAMANDO ALTERACAO DO CADASTRO DE CLIENTE


*/
user function FC010BRW

AADD(aRotina,{"*** Altera","U_SA1ALT",0,4})

return                           

USER FUNCTION SA1ALT(lLibCred)          

Private aRotAuto := Nil 

IF VALTYPE(lLibCred)=="C"
     lLibCred := .F.
ENDIF


if lLibCred
	dbselectarea("SA1")
	dbsetorder(1)
	if !dbseek(xfilial("SA1")+TRB->(A1_COD+A1_LOJA))   
	     ALERT("FALHA NA BUSCA DOS DADOS...")
	     RETURN
	ENDIF
ENDIF

A030Altera("SA1",SA1->(RECNO()),4)


RETURN