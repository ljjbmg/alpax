/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SF1100I   ºAutor  ³Adriano Luis Brandaoº Data ³  19/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para Gravacao da transportadora na nota fiscal de   º±±
±±º          ³ entrada.                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP  - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SF1100I()

Local oDlg,oGrp1,oSay2,oGet3,oGet4,oSay5,oGrp6,oGet7,oGet8,oSBtn9
Private _cFornece,_cTrans,_cDesTran

_aArea 		:= GetArea()
_aAreaA4    := SA4->(GetArea())

_cFornece := SA2->A2_COD + "/" + SA2->A2_LOJA + "-" + SA2->A2_NOME
_cTrans		:= Space(06)
_cDesTran	:= Space(40)	

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Transportadora"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 615
oDlg:nHeight := 242
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oGrp1 := TGROUP():Create(oDlg)
oGrp1:cName := "oGrp1"
oGrp1:cCaption := "Dados da Nota Fiscal"
oGrp1:nLeft := 30
oGrp1:nTop := 19
oGrp1:nWidth := 562
oGrp1:nHeight := 86
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oSay2 := TSAY():Create(oDlg)
oSay2:cName := "oSay2"
oSay2:cCaption := "Nota Fiscal"
oSay2:nLeft := 44
oSay2:nTop := 43
oSay2:nWidth := 65
oSay2:nHeight := 17
oSay2:lShowHint := .F.
oSay2:lReadOnly := .F.
oSay2:Align := 0
oSay2:lVisibleControl := .T.
oSay2:lWordWrap := .F.
oSay2:lTransparent := .F.

oGet3 := TGET():Create(oDlg)
oGet3:cName := "oGet3"
oGet3:cCaption := "oGet3"
oGet3:nLeft := 128
oGet3:nTop := 41
oGet3:nWidth := 80
oGet3:nHeight := 21
oGet3:lShowHint := .F.
oGet3:lReadOnly := .F.
oGet3:Align := 0
oGet3:cVariable := "CNFISCAL"
oGet3:bSetGet := {|u| If(PCount()>0,CNFISCAL:=u,CNFISCAL) }
oGet3:lVisibleControl := .T.
oGet3:lPassword := .F.
oGet3:lHasButton := .F.
oGet3:bWhen := {|| .f. }

oGet4 := TGET():Create(oDlg)
oGet4:cName := "oGet4"
oGet4:cCaption := "oGet4"
oGet4:nLeft := 127
oGet4:nTop := 69
oGet4:nWidth := 309
oGet4:nHeight := 21
oGet4:lShowHint := .F.
oGet4:lReadOnly := .F.
oGet4:Align := 0        
oGet4:cVariable := "_cFornece"
oGet4:bSetGet := {|u| If(PCount()>0,_cFornece:=u,_cFornece) }
oGet4:lVisibleControl := .T.
oGet4:lPassword := .F.
oGet4:lHasButton := .F.
oGet4:bWhen := {|| .f. }

oSay5 := TSAY():Create(oDlg)
oSay5:cName := "oSay5"
oSay5:cCaption := "Fornecedor"
oSay5:nLeft := 45
oSay5:nTop := 70
oSay5:nWidth := 65
oSay5:nHeight := 17
oSay5:lShowHint := .F.
oSay5:lReadOnly := .F.
oSay5:Align := 0
oSay5:lVisibleControl := .T.
oSay5:lWordWrap := .F.
oSay5:lTransparent := .F.

oGrp6 := TGROUP():Create(oDlg)
oGrp6:cName := "oGrp6"
oGrp6:cCaption := "Transportadora"
oGrp6:nLeft := 30
oGrp6:nTop := 112
oGrp6:nWidth := 561
oGrp6:nHeight := 49
oGrp6:lShowHint := .F.
oGrp6:lReadOnly := .F.
oGrp6:Align := 0
oGrp6:lVisibleControl := .T.

oGet7 := TGET():Create(oDlg)
oGet7:cName := "oGet7"
oGet7:cCaption := "oGet7"
oGet7:nLeft := 45
oGet7:nTop := 128
oGet7:nWidth := 69
oGet7:nHeight := 21
oGet7:lShowHint := .F.
oGet7:lReadOnly := .F.
oGet7:Align := 0
oGet7:cVariable := "_cTrans"
oGet7:bSetGet := {|u| If(PCount()>0,_cTrans:=u,_cTrans) }
oGet7:lVisibleControl := .T.
oGet7:lPassword := .F.
oGet7:lHasButton := .F.
oGet7:bValid := {|| Existcpo("SA4") .Or. Vazio() .And. _fAtu() }
oGet7:cF3 := "SA4"

oGet8 := TGET():Create(oDlg)
oGet8:cName := "oGet8"
oGet8:cCaption := "oGet8"
oGet8:nLeft := 128
oGet8:nTop := 128
oGet8:nWidth := 446
oGet8:nHeight := 21
oGet8:lShowHint := .F.
oGet8:lReadOnly := .F.
oGet8:Align := 0
oGet8:cVariable := "_cDesTran"
oGet8:bSetGet := {|u| If(PCount()>0,_cDesTran:=u,_cDesTran) }
oGet8:lVisibleControl := .T.
oGet8:lPassword := .F.
oGet8:lHasButton := .F.
oGet8:bWhen := {|| .f. }

oSBtn9 := SBUTTON():Create(oDlg)
oSBtn9:cName := "oSBtn9"
oSBtn9:cCaption := "OK"
oSBtn9:nLeft := 463
oSBtn9:nTop := 177
oSBtn9:nWidth := 52
oSBtn9:nHeight := 22
oSBtn9:lShowHint := .F.
oSBtn9:lReadOnly := .F.
oSBtn9:Align := 0
oSBtn9:lVisibleControl := .T.
oSBtn9:nType := 1
oSBtn9:bAction := {|| _fGrava(),oDlg:End() }

oDlg:Activate()

RestArea(_aAreaA4)
RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fGrava   ºAutor  ³Adriano Luis Brandaoº Data ³  19/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gravacao da transportadora na tabela SF1       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fGrava()


If ! Empty(_cTrans)
	_aAreaF1 := SF1->(GetArea())

	RecLock("SF1",.f.)
	SF1->F1_AXTRANS := _cTrans
	MsUnLock()

	RestArea(_aAreaF1)
	
EndIf

Return                      

Static Function _fAtu()

_cDesTran := SA4->A4_NOME
//oGet8:ReFresh()

Return(.t.)