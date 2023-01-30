/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPSA1    ºAutor  ³Adriano Luis Brandaoº Data ³  21/02/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Importacao do cadastro de cliente.                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "TopConn.ch"

User Function IMPSA1()

If ! ApMsgYesNo("Confirma importacao do arquivo cliente.dbf do system ???")
	Return
EndIf

DbUseArea(.t.,"DBFCDX","CLIENTES.DBF","TRB",.f.,.f.)

Processa({ || _fImport() })

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImport  ºAutor  ³Adriano Luis Brandaoº Data ³  21/02/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para importacao dos dados.                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fImport()

TRB->(DbGoTop())

ProcRegua(TRB->(Lastrec()))

_lImporta := .f.
_nCod 	:= 1
_cLoja	:= "01"

Begin Transaction

Do While ! TRB->(Eof())
	_lImporta := .t.
	IncProc("Importando clientes registro " + Strzero(TRB->(Recno()),7))
	
	Do While ! RecLock("SA1",.t.)
	EndDo
	
	SA1->A1_FILIAL	:= xfilial("SA1")
	SA1->A1_COD		:= Strzero(_nCod,6)
	SA1->A1_LOJA	:= _cLoja
	SA1->A1_NOME	:= TRB->NOME
	SA1->A1_PESSOA	:= Alltrim(TRB->TIPO)
	SA1->A1_CGC		:= TRB->CNPJ
	SA1->A1_TIPO	:= "F"
	SA1->A1_END		:= TRB->END_FAT
	SA1->A1_MUN		:= TRB->MUN_FAT
	SA1->A1_EST		:= TRB->EST_FAT
	SA1->A1_BAIRRO	:= TRB->BAIRRO_FAT
	SA1->A1_ESTADO	:= TRB->EST_FAT
	SA1->A1_CEP		:= TRB->CEP_FAT
	SA1->A1_DDD		:= TRB->DDD
	SA1->A1_TEL		:= TRB->NUM_FONE
	SA1->A1_FAX		:= TRB->NUM_FAX
	SA1->A1_ENDCOB	:= TRB->END_COB
	SA1->A1_INSCRM	:= TRB->INSC_MUNIC
	SA1->A1_SUFRAMA	:= ALLTRIM(TRB->SUFRAMA)
	SA1->A1_BAIRROC := TRB->BAIRRO_COB
	SA1->A1_EMAIL	:= TRB->EMAIL
	SA1->A1_INSCR	:= TRB->INSC_ESTAD
	SA1->A1_ENDENT	:= TRB->END_ENT
	SA1->A1_CEPC	:= TRB->CEP_COB
	SA1->A1_MUNC	:= TRB->MUN_COB
	SA1->A1_ESTC	:= TRB->EST_COB
	SA1->A1_BAIRROE	:= TRB->BAIRRO_ENT
	SA1->A1_CEPE	:= TRB->CEP_ENT
	SA1->A1_MUNE	:= TRB->MUN_ENT
	SA1->A1_ESTE	:= TRB->EST_ENT
	SA1->(MsUnLock())
	
	TRB->(DbSkip())                
	_nCod++
EndDo

End Transaction
TRB->(DbCloseArea())

If _lImporta
	ApMsgAlert("Importacao feita com sucesso, favor conferir o cadastro de cliente !!!")
EndIf

Return