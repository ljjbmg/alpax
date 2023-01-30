/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTA006   บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar arquivo de movimento para o relatorio    บฑฑ
ฑฑบ          ณ da SSP.                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"

User Function ESTA006()

Private oDlg,oGrp1,oSay3,oGet4,oSay5,oCombo6,oSBtn7,oSBtn8,oGrp9,oSay10,oSay12
Private _cAno := Strzero(Year(dDataBase),4)
Private _aItem := { "1o.Trimestre","2o.Trimestre","3o.Trimestre","4o.Trimestre"}
Private _cDtIni := ""


oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Gera SSP"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 510
oDlg:nHeight := 318
oDlg:lShowHint := .F.
oDlg:lCentered := .T.

oGrp1 := TGROUP():Create(oDlg)
oGrp1:cName := "oGrp1"
oGrp1:nLeft := 39
oGrp1:nTop := 106
oGrp1:nWidth := 403
oGrp1:nHeight := 109
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oSay3 := TSAY():Create(oDlg)
oSay3:cName := "oSay3"
oSay3:cCaption := "Trimestre"
oSay3:nLeft := 65
oSay3:nTop := 132
oSay3:nWidth := 89
oSay3:nHeight := 17
oSay3:lShowHint := .F.
oSay3:lReadOnly := .F.
oSay3:Align := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap := .F.
oSay3:lTransparent := .F.

oGet4 := TGET():Create(oDlg)
oGet4:cName := "oGet4"
oGet4:cCaption := "oGet4"
oGet4:nLeft := 179
oGet4:nTop := 169
oGet4:nWidth := 121
oGet4:nHeight := 21
oGet4:lShowHint := .F.
oGet4:lReadOnly := .F.
oGet4:Align := 0
oGet4:cVariable := "_cAno"
oGet4:bSetGet := {|u| If(PCount()>0,_cAno:=u,_cAno) }
oGet4:lVisibleControl := .T.
oGet4:lPassword := .F.
oGet4:lHasButton := .F.

oSay5 := TSAY():Create(oDlg)
oSay5:cName := "oSay5"
oSay5:cCaption := "Ano"
oSay5:nLeft := 65
oSay5:nTop := 171
oSay5:nWidth := 73
oSay5:nHeight := 17
oSay5:lShowHint := .F.
oSay5:lReadOnly := .F.
oSay5:Align := 0
oSay5:lVisibleControl := .T.
oSay5:lWordWrap := .F.
oSay5:lTransparent := .F.

oCombo6 := TCOMBOBOX():Create(oDlg)
oCombo6:cName := "oCombo6"
oCombo6:cCaption := "oCombo6"
oCombo6:nLeft := 179
oCombo6:nTop := 130
oCombo6:nWidth := 145
oCombo6:nHeight := 21
oCombo6:lShowHint := .F.
oCombo6:lReadOnly := .F.
oCombo6:Align := 0
oCombo6:lVisibleControl := .T.
oCombo6:aItems := _aItem 
oCombo6:nAt := 0

oSBtn7 := SBUTTON():Create(oDlg)
oSBtn7:cName := "oSBtn7"
oSBtn7:cCaption := "Executar"
oSBtn7:nLeft := 226
oSBtn7:nTop := 237
oSBtn7:nWidth := 52
oSBtn7:nHeight := 22
oSBtn7:lShowHint := .F.
oSBtn7:lReadOnly := .F.
oSBtn7:Align := 0
oSBtn7:lVisibleControl := .T.
oSBtn7:nType := 1
oSBtn7:bAction := {|| fProc006(),oDlg:End() }

oSBtn8 := SBUTTON():Create(oDlg)
oSBtn8:cName := "oSBtn8"
oSBtn8:cCaption := "oSBtn8"
oSBtn8:nLeft := 363
oSBtn8:nTop := 236
oSBtn8:nWidth := 52
oSBtn8:nHeight := 22
oSBtn8:lShowHint := .F.
oSBtn8:lReadOnly := .F.
oSBtn8:Align := 0
oSBtn8:lVisibleControl := .T.
oSBtn8:nType := 2                 
oSBtn8:bAction := {|| oDlg:End() }


oGrp9 := TGROUP():Create(oDlg)
oGrp9:cName := "oGrp9"
oGrp9:nLeft := 39
oGrp9:nTop := 12
oGrp9:nWidth := 405
oGrp9:nHeight := 85
oGrp9:lShowHint := .F.
oGrp9:lReadOnly := .F.
oGrp9:Align := 0
oGrp9:lVisibleControl := .T.

oSay10 := TSAY():Create(oDlg)
oSay10:cName := "oSay10"
oSay10:cCaption := "Gera movimento na tabela (SZE), que sera utilizado no relatorio"
oSay10:nLeft := 64
oSay10:nTop := 26
oSay10:nWidth := 350
oSay10:nHeight := 17
oSay10:lShowHint := .F.
oSay10:lReadOnly := .F.
oSay10:Align := 0
oSay10:lVisibleControl := .T.
oSay10:lWordWrap := .F.
oSay10:lTransparent := .F.

oSay12 := TSAY():Create(oDlg)
oSay12:cName := "oSay12"
oSay12:cCaption := "para SSP."
oSay12:nLeft := 63
oSay12:nTop := 56
oSay12:nWidth := 353
oSay12:nHeight := 17
oSay12:lShowHint := .F.
oSay12:lReadOnly := .F.
oSay12:Align := 0
oSay12:lVisibleControl := .T.
oSay12:lWordWrap := .F.
oSay12:lTransparent := .F.

oDlg:Activate()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfProc006  บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da rotina.                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fProc006()

If ! ApMsgYesNo("Confirma geracao dos movimentos para SSP ???")
	Return
EndIf

_nTrim := iif(oCombo6:nAt==0,1,oCombo6:nAt)   // numero do trimestre
_cDiaMesI := ""
_cDiaMesF := ""
Do Case
	Case _nTrim == 1
   		_cDiaMesI := _cAno + "0101"
   		_cDiaMesF := _cAno + "0331"
	Case _nTrim == 2
   		_cDiaMesI := _cAno + "0401"
		_cDiaMesF := _cAno + "0630"
	Case _nTrim == 3
   		_cDiaMesI := _cAno + "0701"
   		_cDiaMesF := _cAno + "0930"
	Otherwise
   		_cDiaMesI := _cAno + "1001"
   		_cDiaMesF := _cAno + "1231"
EndCase

MsgRun("Checagem de reprocessamento e limpeza nos dados !!!"		,,{ || fLimpeza() 	})	
MsgRun("Gerando movimento das compras !!!"							,,{ || fCompras() 	})
//MsgRun("Gerando movimento dos consumos !!!!"						,,{ || fConsumo() 	})
MsgRun("Gerando movimento Saidas diversas !!!!" 					,,{ || fSaidas() 	})

Processa({ || fSaldo() 		})
Processa({ || fProxSal() 	})

ApMsgAlert("Rotina concluida com sucesso, ja pode-se emitir os relatorios da SSP !!!","Termino Processamento")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCompras  บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para atualizar o saldo de compras.                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCompras()

_cQuery := "SELECT B1_AXCTSSP, ZD_DESC, ZD_UM, SUM(D1_QUANT * B1_CONV) AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD1") + " D1, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZD") + " ZD, "
_cQuery +=              RetSqlName("SF4") + " F4 "
_cQuery += "       WHERE D1.D_E_L_E_T_ = ' '  AND B1.D_E_L_E_T_ = ' ' AND ZD.D_E_L_E_T_ = ' ' "
_cQuery += "             AND F4.D_E_L_E_T_ = ' ' AND D1_FILIAL = '" + xFilial("SD1")+"' AND B1_FILIAL = '"
_cQuery +=               xFilial("SB1") + "' AND ZD_FILIAL = '" + xFilial("SZD") + "' AND F4_FILIAL = '"
_cQuery +=               xFilial("SF4") + "' AND D1_COD = B1_COD AND B1_AXCTSSP = ZD_CODIGO AND D1_CF NOT IN ('1922','2922')"
_cQuery += "             AND D1_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND D1_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "'  AND D1_TES <> '222'"
_cQuery += "       GROUP BY B1_AXCTSSP, ZD_DESC, ZD_UM "

TcQuery _cQuery New Alias "QR1"               

TcSetField("QR1","QUANT","N",12,2)

SZE->(DbSetOrder(1))
QR1->(DbGoTop())
Do While ! QR1->(Eof())
	If ! SZE->(DbSeek(xFilial("SZE")+_cAno+Strzero(_nTrim,1)+QR1->B1_AXCTSSP))
		RecLock("SZE",.t.)
		SZE->ZE_FILIAL 	:= xFilial("SZE")
		SZE->ZE_ANO		:= _cAno
		SZE->ZE_TRIMEST	:= Strzero(_nTrim,1)
		SZE->ZE_CODIGO  := QR1->B1_AXCTSSP 
	else	                         // alterado por ocimar 31/10/05
		RecLock("SZE",.f.)  		 // alterado por ocimar 31/10/05
	EndIf                            // alterado por ocimar 31/10/05		
	SZE->ZE_COMPRAS := QR1->QUANT
	SZE->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfConsumo  บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para atualizar o saldo de consumo.                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/  
/*
Static Function fConsumo()

_cQuery := "SELECT B1_AXCTSSP, ZD_DESC, ZD_UM, SUM(D3_QUANT * B1_CONV) AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD3") + " D3, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZD") + " ZD "
_cQuery += "       WHERE D3.D_E_L_E_T_ = ' '  AND B1.D_E_L_E_T_ = ' ' AND ZD.D_E_L_E_T_ = ' ' "
_cQuery += "             AND D3_FILIAL = '" + xFilial("SD3")+"' AND B1_FILIAL = '"
_cQuery +=               xFilial("SB1") + "' AND ZD_FILIAL = '" + xFilial("SZD") + "' "
_cQuery += "             AND D3_COD = B1_COD AND B1_AXCTSSP = ZD_CODIGO "
_cQuery += "             AND D3_TM > '500' AND D3_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "' AND D3_ESTORNO <> 'S' "
_cQuery += "       GROUP BY B1_AXCTSSP, ZD_DESC, ZD_UM "

TcQuery _cQuery New Alias "QR1"               

TcSetField("QR1","QUANT","N",12,2)

SZE->(DbSetOrder(1))
QR1->(DbGoTop())
Do While ! QR1->(Eof())
	If ! SZE->(DbSeek(xFilial("SZE")+_cAno+Strzero(_nTrim,1)+QR1->B1_AXCTSSP))
		RecLock("SZE",.t.)
		SZE->ZE_FILIAL 	:= xFilial("SZE")
		SZE->ZE_ANO		:= _cAno
		SZE->ZE_TRIMEST	:= Strzero(_nTrim,1)
		SZE->ZE_CODIGO  := QR1->B1_AXCTSSP
	Else
		RecLock("SZE",.f.)
	EndIf
	SZE->ZE_CONSUMO += QR1->QUANT
	SZE->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfSaidas   บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para atualizar o saldo das saidas diversas.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fSaidas()

_cQuery := "SELECT B1_AXCTSSP, ZD_DESC, ZD_UM, SUM(D2_QUANT * B1_CONV) AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD2") + " D2, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZD") + " ZD, "
_cQuery +=              RetSqlName("SF4") + " F4 "
_cQuery += "       WHERE D2.D_E_L_E_T_ = ' '  AND B1.D_E_L_E_T_ = ' ' AND ZD.D_E_L_E_T_ = ' ' "
_cQuery += "             AND F4.D_E_L_E_T_ = ' ' AND D2_FILIAL = '" + xFilial("SD2")+"' AND B1_FILIAL = '"
_cQuery +=               xFilial("SB1") + "' AND ZD_FILIAL = '" + xFilial("SZD") + "' AND F4_FILIAL = '"
_cQuery +=               xFilial("SF4") + "' AND D2_COD = B1_COD AND B1_AXCTSSP = ZD_CODIGO AND D2_CF NOT IN ('5922','6922')"
_cQuery += "             AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND D2_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "'  AND D2_TES <> '522'"
_cQuery += "       GROUP BY B1_AXCTSSP, ZD_DESC, ZD_UM "

TcQuery _cQuery New Alias "QR1"               

TcSetField("QR1","QUANT","N",12,2)

SZE->(DbSetOrder(1))
QR1->(DbGoTop())
Do While ! QR1->(Eof())
	If ! SZE->(DbSeek(xFilial("SZE")+_cAno+Strzero(_nTrim,1)+QR1->B1_AXCTSSP))
		RecLock("SZE",.t.)
		SZE->ZE_FILIAL 	:= xFilial("SZE")
		SZE->ZE_ANO		:= _cAno
		SZE->ZE_TRIMEST	:= Strzero(_nTrim,1)
		SZE->ZE_CODIGO  := QR1->B1_AXCTSSP
	Else
		RecLock("SZE",.f.)
	EndIf
	SZE->ZE_SAIDAS += QR1->QUANT
	SZE->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfSaldo    บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para analisar o saldo final.                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fSaldo()

SZE->(DbGotop())
SZE->(DbSeek(xFilial("SZE")+_cAno+Strzero(_nTrim,1),.T.))

ProcRegua(SZE->(Lastrec()-SZE->(Recno())))

Do While ! SZE->(Eof()) .And. SZE->ZE_FILIAL == xFilial("SZE") .And. SZE->ZE_ANO == _cAno .And.;
			SZE->ZE_TRIMEST == Strzero(_nTrim,1)
	IncProc("Atualizando " + SZE->ZE_CODIGO + " ....")
	RecLock("SZE",.f.)
	SZE->ZE_SALFIN := SZE->ZE_SALANT + SZE->ZE_COMPRAS - SZE->ZE_CONSUMO - SZE->ZE_SAIDAS
	SZE->(MsUnLock())	
	SZE->(DbSkip())			
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfProxSal  บAutor  ณMicrosiga           บ Data ณ  17/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar o proximo saldo.                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fProxSal() 

SZE->(DbGotop())
SZE->(DbSeek(xFilial("SZE")+_cAno+Strzero(_nTrim,1),.T.))

ProcRegua(SZE->(Lastrec()-SZE->(Recno())))

_cAnoFim 	:= iif(_nTrim == 4,Strzero(Val(_cAno)+1,4),_cAno)

_cTrimFim 	:= iif(_nTrim == 4,"1",Strzero(_nTrim+1,1))

_cQuery := "SELECT * "
_cQuery += "FROM " + RetSqlName("SZE") + " ZE "
_cQuery += "WHERE ZE.D_E_L_E_T_ = ' ' AND ZE_ANO = '" + _cAno + "' AND ZE_TRIMEST = '" + Strzero(_nTrim,1) + "' "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())

	IncProc("Gerando saldo final " + SZE->ZE_CODIGO + " ....")
	RecLock("SZE",.t.)
	SZE->ZE_FILIAL 	:= xFilial("SZE")
	SZE->ZE_ANO		:= _cAnoFim
	SZE->ZE_TRIMEST	:= _cTrimFim
	SZE->ZE_CODIGO  := QR1->ZE_CODIGO
	SZE->ZE_SALANT	:= QR1->ZE_SALFIN
	SZE->(MsUnLock())		
	QR1->(DbSkip())	
EndDo

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfLimpeza  บAutor  ณMicrosiga           บ Data ณ  29/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Limpeza, caso for um reprocessamento no mesmo trimestre.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fLimpeza()

// Zera saldos do trimestre corrente.
_cUpdate := "UPDATE " + RetSqlName("SZE")
_cUpdate += "       SET ZE_COMPRAS = 0, ZE_CONSUMO = 0, ZE_SAIDAS = 0, ZE_SALFIN = 0 "
_cUpdate += "       WHERE D_E_L_E_T_ = ' ' AND ZE_FILIAL = '" + xFilial("SZE") + "' "
_cUpdate += "             AND ZE_ANO = '" + _cAno + "' AND ZE_TRIMEST = '" + Strzero(_nTrim,1) + "' "

TcSqlExec(_cUpdate)

// Limpeza do proximo saldo
_cAnoFim 	:= iif(_nTrim == 4,Strzero(Val(_cAno)+1,4),_cAno)
_cTrimFim 	:= iif(_nTrim == 4,"1",Strzero(_nTrim+1,1))

_cDelete := "DELETE FROM " + RetSqlName("SZE")
_cDelete += "       WHERE D_E_L_E_T_ = ' ' AND ZE_FILIAL = '" + xFilial("SZE") + "' "
_cDelete += "             AND ZE_ANO = '" + _cAnoFim + "' AND ZE_TRIMEST = '" + _cTrimFim + "' "

TcSqlExec(_cDelete)


Return