#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fatE002   º Autor ³ Wagner Gomes       º Data ³  08/06/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Validacao de Usuario do Campo C6_DESCONT                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Alpax                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FatE002()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local _nPercTot	:= 100*(1-(1 - M->C5_DESC1/100)*(1 - M->C5_DESC2/100)*(1 - M->C5_DESC3/100)*(1 - M->C5_DESC4/100)*(1 - M->C6_DESCONT/100))
Local _cUser	:= Subs(cUsuario,7,15)
Local _nPerc	:= GetAdvfVal("SZ7","Z7_PERC",xFilial("SZ7")+_cUser,1,-1)  
// Local _nPrcVen := Posicione("SB1",1,xFilial("SB1")+M->C6_COD,"B1_PRV1")                OCIMAR 15/05/07
// LOcal _nPrcMin := (_nPercTot*_nPrcVen)                                                 OCIMAR 15/05/07
_lret := .t.

If _nPerc < 0
	Alert("Cadastre o usuario na Tabela de Descontos Maximo por Usuario(SZ7)")
	_lRet := .f.
Else
	If _nPercTot > _nPerc
		Alert("O limite de desconto foi excedido"+chr(13)+chr(10)+"Verifique!")
		_lRet := .f.           
/*      Else                                                                              OCIMAR 15/05/07
            If _nPrcMin > M->C6_PRCVEN                                                    OCIMAR 15/05/07
		        Alert("O limite de desconto foi excedido"+chr(13)+chr(10)+"Verifique!")   OCIMAR 15/05/07
		    EndIf                                                                         OCIMAR 15/05/07
*/		                                                                                  
	EndIf	
EndIf 
Return(_lRet)
