#Include "rwmake.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#Include "Topconn.ch"

User Function Importa()

WFPrepEnv("01","01")

Chkfile("SZA")
ChkFile("SZL")

SZA->(DbSetOrder(1))
SZL->(DbSetOrder(1))

SZL->(DbGoTop())

Do While ! SZL->(Eof())
	RecLock("SZA",.T.)
	SZA->ZA_FILIAL 	:= xFilial("SZA")
	SZA->ZA_TRANSP	:= SZL->ZL_TRANSP
	SZA->ZA_LICENCA	:= SZL->ZL_LICENCA
	SZA->ZA_DTINI	:= SZL->ZL_DTINI
	SZA->ZA_DTFIM	:= SZL->ZL_DTFIM
	SZA->(MsUnLock())

	SZL->(DbSkip())
EndDo

Alert("TERMINO FUNCIONAMENTO")

Return