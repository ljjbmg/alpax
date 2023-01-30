/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATE009   ºAutor  ³Microsiga           º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para consulta padrao da tabela AC8 de contatos para º±±
±±º          ³ o cliente.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP -                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"

User Function FATE009(_cCliente,_cLoja)

Local oDlg,oGrp1,oSBtn2, oLbx

_aArea 		:= GetArea()
_aAreaA1	:= SA1->(GetArea())

If _cCliente <> Nil .and. _cLoja <> Nil
	SA1->(DbSetOrder(1))
	SA1->(Dbseek(xFilial("SA1")+_cCliente+_cLoja))
EndIf

_cQuery := "SELECT U5_CODCONT, U5_CONTAT, U5_EMAIL "
_cQuery += "FROM " + RetSqlName("SU5") + " SU, " + RetSqlName("AC8") + " AC "
_cQuery += "WHERE SU.D_E_L_E_T_ = ' ' AND AC.D_E_L_E_T_ = ' ' "
_cQuery += "      AND AC8_FILIAL = '" + xFilial("AC8") + "' AND U5_FILIAL = '" + xFilial("SU5") + "' "
_cQuery += "      AND AC8_ENTIDA = 'SA1' AND LEFT(AC8_CODENT,08) = '" + (SA1->A1_COD+SA1->A1_LOJA) + "' "
_cQuery += "      AND AC8_CODCON = U5_CODCONT "

TcQuery _cQuery New Alias "QR1"

aArrayF4 := {}

Do While ! QR1->(Eof())
	AAdd( aArrayF4,{QR1->U5_CODCONT, QR1->U5_CONTAT,QR1->U5_EMAIL})
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

If Empty(aArrayF4)                                
	AAdd( aArrayF4,{"  ","   ","    "})
EndIf                              12154


aCab := { 	OemToAnsi("Codigo"),;
			OemToAnsi("Contato"),;
			OemToAnsi("Email")	}


oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Contatos"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 463
oDlg:nHeight := 339
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oGrp1 := TGROUP():Create(oDlg)
oGrp1:cName := "oGrp1"
oGrp1:cCaption := "Selecione"
oGrp1:nLeft := 18
oGrp1:nTop := 21
oGrp1:nWidth := 420
oGrp1:nHeight := 232
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oLbx := RDListBox(2, 2, 200, 80, aArrayF4, aCab)

oSBtn2 := SBUTTON():Create(oDlg)
oSBtn2:cName := "OK"
oSBtn2:cCaption := "OK"
oSBtn2:nLeft := 345
oSBtn2:nTop := 266
oSBtn2:nWidth := 52
oSBtn2:nHeight := 22
oSBtn2:lShowHint := .F.
oSBtn2:lReadOnly := .F.
oSBtn2:Align := 0
oSBtn2:lVisibleControl := .T.
oSBtn2:nType := 1
oSBtn2:bAction := {|| _fExecuta(oLbx),oDlg:End() }

oDlg:Activate()

RestArea(_aAreaA1)
RestArea(_aArea)

Return(.t.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fExecuta ºAutor  ³Microsiga           º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ funcao para posicionar a tabela SU5 contatos.              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fExecuta(oLbx)

SU5->(DbSetOrder(1))
SU5->(DbSeek(xFilial("SU5")+oLbx:AARRAY[oLbx:Nat,1]))

Return