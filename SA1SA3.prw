#include 'protheus.ch'
#include 'parmtype.ch'

user function SA1SA3()

Local _lRet := .T.
Local _cCODSA3 := GETADVFVAL("ZBD","ZBD_CODVEN",XFILIAL("ZBD")+RetCodUsr(),1,"",.T.)

_lRet := SA1->A1_VEND == _cCODSA3	
	
return(_lRet)