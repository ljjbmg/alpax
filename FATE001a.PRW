#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fatE001   º Autor ³ Wagner Gomes       º Data ³  08/06/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Validacao de Usuario dos Campos                            º±±
±±º          ³ Cj_DESC1 Cj_DESC2 Cj_DESC3 Cj_DESC4                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Alpax                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FatE001a()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local _nPercTot0	:= 100*(1-(1 - M->Cj_DESC1/100)*(1 - M->Cj_DESC2/100)*(1 - M->Cj_DESC3/100)*(1 - M->Cj_DESC4/100))
Local _cUser	:= Subs(cUsuario,7,15)
Local _nPerc	:= GetAdvfVal("SZ7","Z7_PERC",xFilial("SZ7")+_cUser,1,-1)
                      
_lret := .t.

If _nPerc < 0
	Alert("Cadastre o usuario na Tabela de Descontos Maximo por Usuario(SZ7)")
	_lRet := .f.
Else
	If _nPercTot0 > _nPerc
		Alert("O limite de desconto foi excedido"+chr(13)+chr(10)+"Verifique!")
		_lRet := .f.
	EndIf	
EndIf 
dbSelectArea("TMP1")
_aArea := GetArea()

DBGOTOP()

While !Eof()
	_nPercTMP := TMP1->CK_DESCONT
	_nPercTot1	:= 100*(1-(1 - M->Cj_DESC1/100)*(1 - M->Cj_DESC2/100)*(1 - M->Cj_DESC3/100)*(1 - M->Cj_DESC4/100)*(1 - _nPercTMP/100))
	If _nPercTot1 > _nPerc .AND. _nPercTMP <> 0
	   
		Alert("O limite de desconto foi excedido na linha "+alltrim(str(Recno()))+" do orcamento."+chr(13)+chr(10)+"Verifique!")
		_lRet := .f.
		/*		
		RecLock("TMP1",.f.)
 		TMP1->CK_DESCONT	:= 0
  		TMP1->CK_VALOR		+= TMP1->CK_VALDESC
		TMP1->CK_PRCVEN		:= TMP1->CK_VALOR / TMP1->CK_QTDVEN
		IF _nPercTot0 <= _nPerc
			TMP1->CK_PRCVEN		:= Round( TMP1->CK_PRCVEN * ( 1 - _nPercTot0 ) , 2 )
			TMP1->CK_VALDESC	:= TMP1->CK_VALOR - TMP1->CK_QTDVEN * TMP1->CK_PRCVEN
			TMP1->CK_VALOR		:= TMP1->CK_VALOR - TMP1->CK_VALDESC
		Endif
		MsUnLock()
		*/

	EndIf	

dbskip()
EndDo

/*
IF _nPercTot0 > _nPerc
	M->CJ_DESC1 := 0
	M->CJ_DESC2 := 0
	M->CJ_DESC3 := 0
	M->CJ_DESC4 := 0
EndIf
*/
dbGotop()
oGetDad:oBrowse:refresh()
//RestArea(_aArea)

Return(_lRet)
