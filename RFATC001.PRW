/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RFATC001  ºAutor  ³Microsiga           º Data ³  31/08/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Tela de consulta a tabela de precos.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"

User Function RFATC001(_cProduto)

Local oDlg,oList2,oGet4,oGet5,oGet6,oSay7,oSay8,oGrp9,oSBtn10

MsgRun("Aguarde processando",,{ || _cQuery(_cProduto) })

SB1->(DbSeek(xFilial("SB1")+_cProduto))

_cProd 	:= Alltrim(SB1->B1_PNUMBER) + "   -   " + SB1->B1_DESC
_cCapac := SB1->B1_CAPACID
_cMarca := SB1->B1_MARCA
_aItens := {}

QR1->(DbGoTop())
Do While ! QR1->(Eof())
	aAdd(_aItens," Tabela   " + QR1->DA1_CODTAB + "   R$." + Transform(QR1->DA1_PRCVEN,"@e 999,999.99") +;
	     "      Vigencia de " + Dtoc(QR1->DA0_DATDE) + "  ate  " + Dtoc(QR1->DA0_DATATE) )
	QR1->(DbSkip())
EndDo

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Precos das tabelas"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 663
oDlg:nHeight := 385
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oList2 := TLISTBOX():Create(oDlg)
oList2:cName := "oList2"
oList2:cCaption := "oList2"
oList2:nLeft := 76
oList2:nTop := 128
oList2:nWidth := 492
oList2:nHeight := 130
oList2:lShowHint := .F.
oList2:lReadOnly := .F.
oList2:Align := 0
oList2:lVisibleControl := .T.
oList2:nAt := 0
oList2:aItems := _aItens

oGet4 := TGET():Create(oDlg)
oGet4:cName := "oGet4"
oGet4:cCaption := "oGet4"
oGet4:nLeft := 47
oGet4:nTop := 25
oGet4:nWidth := 551
oGet4:nHeight := 21
oGet4:lShowHint := .F.
oGet4:lReadOnly := .F.
oGet4:Align := 0
oGet4:cVariable := "_cProd"
oGet4:bSetGet := {|u| If(PCount()>0,_cProd:=u,_cProd) }
oGet4:lVisibleControl := .T.
oGet4:lPassword := .F.
oGet4:lHasButton := .F.
oGet4:bWhen := {|| .f. }

oGet5 := TGET():Create(oDlg)
oGet5:cName := "oGet5"
oGet5:cCaption := "oGet5"
oGet5:nLeft := 124
oGet5:nTop := 59
oGet5:nWidth := 176
oGet5:nHeight := 21
oGet5:lShowHint := .F.
oGet5:lReadOnly := .F.
oGet5:Align := 0
oGet5:cVariable := "_cCapac"
oGet5:bSetGet := {|u| If(PCount()>0,_cCapac:=u,_cCapac) }
oGet5:lVisibleControl := .T.
oGet5:lPassword := .F.
oGet5:lHasButton := .F.
oGet5:bWhen := {|| .f. }

oGet6 := TGET():Create(oDlg)
oGet6:cName := "oGet6"
oGet6:cCaption := "oGet6"
oGet6:nLeft := 406
oGet6:nTop := 59
oGet6:nWidth := 190
oGet6:nHeight := 21
oGet6:lShowHint := .F.
oGet6:lReadOnly := .F.
oGet6:Align := 0
oGet6:cVariable := "_cMarca"
oGet6:bSetGet := {|u| If(PCount()>0,_cMarca:=u,_cMarca) }
oGet6:lVisibleControl := .T.
oGet6:lPassword := .F.
oGet6:lHasButton := .F.
oGet6:bWhen := {|| .f. }

oSay7 := TSAY():Create(oDlg)
oSay7:cName := "oSay7"
oSay7:cCaption := "Capacidade"
oSay7:nLeft := 45
oSay7:nTop := 62
oSay7:nWidth := 65
oSay7:nHeight := 17
oSay7:lShowHint := .F.
oSay7:lReadOnly := .F.
oSay7:Align := 0
oSay7:lVisibleControl := .T.
oSay7:lWordWrap := .F.
oSay7:lTransparent := .F.

oSay8 := TSAY():Create(oDlg)
oSay8:cName := "oSay8"
oSay8:cCaption := "Marca"
oSay8:nLeft := 319
oSay8:nTop := 60
oSay8:nWidth := 65
oSay8:nHeight := 17
oSay8:lShowHint := .F.
oSay8:lReadOnly := .F.
oSay8:Align := 0
oSay8:lVisibleControl := .T.
oSay8:lWordWrap := .F.
oSay8:lTransparent := .F. 

oGrp9 := TGROUP():Create(oDlg)
oGrp9:cName := "oGrp9"
oGrp9:cCaption := "Precos"
oGrp9:nLeft := 47
oGrp9:nTop := 94
oGrp9:nWidth := 553
oGrp9:nHeight := 190
oGrp9:lShowHint := .F.
oGrp9:lReadOnly := .F.
oGrp9:Align := 0
oGrp9:lVisibleControl := .T.

oSBtn10 := SBUTTON():Create(oDlg)
oSBtn10:cName := "oSBtn10"
oSBtn10:cCaption := "OK"
oSBtn10:nLeft := 413
oSBtn10:nTop := 305
oSBtn10:nWidth := 52
oSBtn10:nHeight := 22
oSBtn10:lShowHint := .F.
oSBtn10:lReadOnly := .F.
oSBtn10:Align := 0
oSBtn10:lVisibleControl := .T.
oSBtn10:nType := 1
oSBtn10:bAction := {|| oDlg:End() }

oDlg:Activate()        

QR1->(DbCloseArea())

Return                                      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_cQuery   ºAutor  ³Microsiga           º Data ³  31/08/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Query das tabelas de precos.                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _cQuery(_cProduto)

_cQuery := "SELECT DA1_CODTAB, DA1_PRCVEN, DA0_DATDE, DA0_DATATE "
_cQuery += "FROM " + RetSqlName("DA1") + " DA1, " + RetSqlName("DA0") + " DA0 "
_cQuery += "WHERE DA1.D_E_L_E_T_ = ' ' AND DA0.D_E_L_E_T_ = ' ' AND "
_cQuery += "      DA0_FILIAL = '" + xFilial("DA0") + "' AND DA1_FILIAL = '" + xFilial("DA1") +"' AND "
_cQuery += "      DA1_CODTAB = DA0_CODTAB AND DA1_CODPRO = '" + _cProduto + "' AND '" + Dtos(dDataBase) + "' " 
_cQuery += "      BETWEEN DA0_DATDE AND DA0_DATATE AND DA0_ATIVO = '1' AND '"+ Dtos(dDataBase) + "' >= DA1_DATVIG " 

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","DA1_PRCVEN","N",12,2)
TcSetField("QR1","DA0_DATDE","D",8,0)
TcSetField("QR1","DA0_DATATE","D",8,0)

Return