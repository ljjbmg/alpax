/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT120F    บAutor  ณMicrosiga           บ Data ณ  08/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada apos a gravacao do pedido de compras       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MT120F()

Local oDlg,oGrp1,oGet4,oGet5,oSBtn6

If Inclui .or. Altera
	_cPedido 	:= PARAMIXB
	_cTransp 	:= Space(06)
	_cDesc		:= Space(Len(SA4->A4_NREDUZ))
	
	oDlg := MSDIALOG():Create()
	oDlg:cName := "oDlg"
	oDlg:cCaption := "Dados adicionais do pedido"
	oDlg:nLeft := 0
	oDlg:nTop := 0
	oDlg:nWidth := 496
	oDlg:nHeight := 179
	oDlg:lShowHint := .F.
	oDlg:lCentered := .T.
	
	oGrp1 := TGROUP():Create(oDlg)
	oGrp1:cName := "oGrp1"
	oGrp1:cCaption := "Transportadora"
	oGrp1:nLeft := 29
	oGrp1:nTop := 20
	oGrp1:nWidth := 425
	oGrp1:nHeight := 44
	oGrp1:lShowHint := .F.
	oGrp1:lReadOnly := .F.
	oGrp1:Align := 0
	oGrp1:lVisibleControl := .T.
	
	oGet4 := TGET():Create(oDlg)
	oGet4:cF3 := "SA4A"
	oGet4:cName := "oGet4"
	oGet4:cCaption := "oGet4"
	oGet4:nLeft := 38
	oGet4:nTop := 36
	oGet4:nWidth := 71
	oGet4:nHeight := 21
	oGet4:lShowHint := .F.
	oGet4:lReadOnly := .F.
	oGet4:Align := 0
	oGet4:cVariable := "_cTransp"
	oGet4:bSetGet := {|u| If(PCount()>0,_cTransp:=u,_cTransp) }
	oGet4:lVisibleControl := .T.
	oGet4:lPassword := .F.
	oGet4:lHasButton := .F.
	oGet4:bValid := {|| vazio() .or. existcpo("SA4") }
	oGet4:bChange := {|| _cDesc := Posicione("SA4",1,xFilial("SA4")+_cTransp,"A4_NREDUZ"),oDlg:Refresh() }
	
	
	oGet5 := TGET():Create(oDlg)
	oGet5:cName := "oGet5"
	oGet5:cCaption := "oGet5"
	oGet5:nLeft := 122
	oGet5:nTop := 35
	oGet5:nWidth := 323
	oGet5:nHeight := 21
	oGet5:lShowHint := .F.
	oGet5:lReadOnly := .F.
	oGet5:Align := 0
	oGet5:cVariable := "_cDesc"
	oGet5:bSetGet := {|u| If(PCount()>0,_cDesc:=u,_cDesc) }
	oGet5:lVisibleControl := .T.
	oGet5:lPassword := .F.
	oGet5:lHasButton := .F.
	oGet5:bWhen := {|| .f. }
	
	oSBtn6 := SBUTTON():Create(oDlg)
	oSBtn6:cName := "oSBtn6"
	oSBtn6:cCaption := "OK"
	oSBtn6:nLeft := 352
	oSBtn6:nTop := 101
	oSBtn6:nWidth := 52
	oSBtn6:nHeight := 22
	oSBtn6:lShowHint := .F.
	oSBtn6:lReadOnly := .F.
	oSBtn6:Align := 0
	oSBtn6:lVisibleControl := .T.
	oSBtn6:nType := 1
	oSBtn6:bAction := {|| _fGrava(),oDlg:End() }
	
	oDlg:Activate()
	
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGrava   บAutor  ณMicrosiga           บ Data ณ  08/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava os campos no pedido de compras.                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fGrava()

_cUpdate := "UPDATE " + RetSqlName("SC7") + " "
_cUpdate += "SET C7_AXTRANS = '" + _cTransp + "' "
_cUpdate += "WHERE C7_FILIAL = '" + Left(_cPedido,2) + "' AND C7_NUM = '" + Substr(_cPedido,3,6) + "' "
_cUpdate += "      AND D_E_L_E_T_ = ' ' "

TcSqlExec(_cUpdate)

Return