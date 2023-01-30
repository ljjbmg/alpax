/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FCONSPROD ºAutor  ³Adriano Luis Brandaoº Data ³  06/10/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Consulta as compras programadas.                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#INCLUDE "TOPCONN.CH"

User Function fConsProd()


Local oDlg,oList1,oSBtn2,oGet3

_nItem := 1
_cProduto := ""


_aArea 		:= GetArea()
_aAreaB1 	:= SB1->(GetArea())

aItems		:= {}
_nPosProd 	:= Ascan(aHeader,{|x| Alltrim(x[2])=="C6_PRODUTO" })

_cProduto 	:= Posicione("SB1",1,xFilial("SB1")+aCols[n,_nPosProd],"B1_DESC")
_cCod	    := aCols[n,_nPosProd]

If Empty(_cProduto)
	ApMsgAlert("Digite o codigo do produto no item para consultar")
	Return
EndIf

_cQuery := "SELECT C7_NUM, C7_QUANT, C7_QUJE, C7_DATPRF "
_cQuery += "FROM " + RetSqlName("SC7") + " C7 "
_cQuery += "WHERE C7.D_E_L_E_T_ = ' ' AND C7_FILIAL = '" + xFilial("SC7") + "' AND "
_cQuery += "      C7_PRODUTO = '" + _cCod + "' AND C7_QUJE < C7_QUANT "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","C7_QUANT"	,"N",12,2)
TcSetField("QR1","C7_QUJE"	,"N",12,2)
TcSetField("QR1","C7_DATPRF","D",08,2)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	aAdd(aItems,"Pedido Compra " + QR1->C7_NUM + " Quantidade " +;
				Transform(QR1->C7_QUANT - QR1->C7_QUJE,"@e 999,999.99") +;
				" Entrega em " + Dtoc(QR1->C7_DATPRF))
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

RestArea(_aAreaB1)
RestArea(_aArea)


oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Compra programada"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 422
oDlg:nHeight := 285
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oList1 := TLISTBOX():Create(oDlg)
oList1:cName := "oList1"
oList1:cCaption := "oList1"
oList1:nLeft := 34
oList1:nTop := 52
oList1:nWidth := 343
oList1:nHeight := 158
oList1:lShowHint := .F.
oList1:lReadOnly := .F.
oList1:Align := 0
oList1:cVariable := "_nItem"
oList1:bSetGet := {|u| If(PCount()>0,_nItem:=u,_nItem) }
oList1:lVisibleControl := .T.
oList1:nAt := 0
oList1:aItems  := aClone(aItems)

oSBtn2 := SBUTTON():Create(oDlg)
oSBtn2:cName := "oSBtn2"
oSBtn2:cCaption := "oSBtn2"
oSBtn2:nLeft := 314
oSBtn2:nTop := 224
oSBtn2:nWidth := 52
oSBtn2:nHeight := 22
oSBtn2:lShowHint := .F.
oSBtn2:lReadOnly := .F.
oSBtn2:Align := 0
oSBtn2:lVisibleControl := .T.
oSBtn2:nType := 2
oSBtn2:bAction := {|| odlg:end() }

oGet3 := TGET():Create(oDlg)
oGet3:cName := "oGet3"
oGet3:cCaption := "oGet3"
oGet3:nLeft := 34
oGet3:nTop := 13
oGet3:nWidth := 343
oGet3:nHeight := 21
oGet3:lShowHint := .F.
oGet3:lReadOnly := .F.
oGet3:Align := 0
oGet3:cVariable := "_cProduto"
oGet3:bSetGet := {|u| If(PCount()>0,_cProduto:=u,_cProduto) }
oGet3:lVisibleControl := .T.
oGet3:lPassword := .F.
oGet3:lHasButton := .F.
oGet3:bWhen := {|| .f. }

oDlg:Activate()

Return