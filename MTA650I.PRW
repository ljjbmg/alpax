#INCLUDE "PROTHEUS.CH"

/*
Ponto de Entrada para trocar o armazem da OP
*/

User Function MTA650I

If ApMsgYesNo("Confirma alteração do Local para 'EL' ???")
	Reclock("SC2",.F.)
	SC2->C2_LOCAL := "EL"   
	SC2->(MsUnLock())
	cLocal := "EL"
EndIf

Return( Nil )