
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FCVEN415  �Autor  �Adriano Luis Brandao� Data �  13/10/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao para consultar as ultimas vendas do cliente e produto���
���          �selecionado no pedido de vendas.                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#Include "Topconn.ch"

User Function fCVen415(_cCod)

_nItem := 1
_cProduto := ""

_aArea   	:= GetArea()
_aAreaB1 	:= SB1->(GetArea())

aItems		:= {}

_cProduto	:= Posicione("SB1",1,xFilial("SB1")+_cCod,"B1_DESC")

If Empty(_cCod)
	ApMsgAlert("Digite o codigo do produto no item para consultar")
	Return
EndIf

If Empty(M->CJ_CLIENTE) .or. Empty(M->CJ_LOJA)
	ApMsgAlert("Digite o codigo e loja do cliente para consultar")
	Return
EndIf     

_cQuery := "SELECT D2_DOC, D2_QUANT, D2_PRCVEN, D2_EMISSAO "
_cQuery += "FROM " + RetSqlName("SD2") + " D2, " + RetSqlName("SF4") + " F4 "
_cQuery += "WHERE D2.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D2_FILIAL = '" + xFilial("SD2") +"' AND F4_FILIAL = '" 
_cQuery +=        xFilial("SF4") + "' AND "
_cQuery += "      D2_CLIENTE = '" + M->CJ_CLIENTE + "' AND D2_LOJA = '"
_cQuery +=        M->CJ_LOJA + "' AND D2_COD = '" + _cCod + "' AND "
_cQuery += "      D2_TES = F4_CODIGO AND F4_DUPLIC = 'S' "
_cQuery += "ORDER BY D2_EMISSAO DESC"

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D2_QUANT"		,"N",12,2)
TcSetField("QR1","D2_PRCVEN"	,"N",12,2)
TcSetField("QR1","D2_EMISSAO"	,"D",08,0)

QR1->(DbGoTop())

_nCont := 1
Do While ! QR1->(Eof()) .Or. _nCont > 10
	aAdd(aItems,"N.F. " + QR1->D2_DOC + " Quantidade " +;
				Transform(QR1->D2_QUANT,"@e 999,999.99") +;
				"- Prc.Unit." + Transform(QR1->D2_PRCVEN,"@e 999,999.99")+;
				" de " + Dtoc(QR1->D2_EMISSAO))
	QR1->(DbSkip())
	_nCont++
EndDo

QR1->(DbCloseArea())

RestArea(_aAreaB1)
RestArea(_aArea)


oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Ultimas Vendas"
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