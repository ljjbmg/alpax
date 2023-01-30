/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTA009   บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar arquivo de movimento para o relatorio    บฑฑ
ฑฑบ          ณ do Ministerio do Exercito                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"

User Function ESTA009()

Private oDlg,oGrp1,oSay3,oGet4,oSay5,oCombo6,oSBtn7,oSBtn8,oGrp9,oSay10,oSay12
Private _cAno := Strzero(Year(dDataBase),4)
Private _aItem := { "1o.Trimestre","2o.Trimestre","3o.Trimestre","4o.Trimestre"}
Private _cDtIni := ""


oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Gera Movimento Ministerio do Exercito"
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
oSBtn7:bAction := {|| fProc009(),oDlg:End() }

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
oSay10:cCaption := "Gera movimento na tabela (SZG), que sera utilizado nos relatorios"
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
oSay12:cCaption := "para o Ministerio do Exercito."
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
ฑฑบPrograma  ณfProc009  บAutor  ณMicrosiga           บ Data ณ  15/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de processamento da rotina.                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fProc009()

If ! ApMsgYesNo("Confirma geracao dos movimentos para o ministerio do Exercito ???")
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

ApMsgAlert("Rotina concluida com sucesso, ja pode-se emitir os relatorios do Exercito !!!","Termino Processamento")

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

_cQuery := "SELECT B1_AXCTEXE, ZF_DESC, ZF_UM, SUM(D1_QUANT * B1_CONV) AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD1") + " D1, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZF") + " ZF, "
_cQuery +=              RetSqlName("SF4") + " F4 "
_cQuery += "       WHERE D1.D_E_L_E_T_ = ' '  AND B1.D_E_L_E_T_ = ' ' AND ZF.D_E_L_E_T_ = ' ' "
_cQuery += "             AND F4.D_E_L_E_T_ = ' ' AND D1_FILIAL = '" + xFilial("SD1")+"' AND B1_FILIAL = '"
_cQuery +=               xFilial("SB1") + "' AND ZF_FILIAL = '" + xFilial("SZF") + "' AND F4_FILIAL = '"
_cQuery +=               xFilial("SF4") + "' AND D1_COD = B1_COD AND B1_AXCTEXE = ZF_CODIGO "
_cQuery += "             AND D1_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND D1_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "' AND D1_TES <> '222'"
_cQuery += "       GROUP BY B1_AXCTEXE, ZF_DESC, ZF_UM "

TcQuery _cQuery New Alias "QR1"               

TcSetField("QR1","QUANT","N",12,2)

SZG->(DbSetOrder(1))
QR1->(DbGoTop())
Do While ! QR1->(Eof())
	If ! SZG->(DbSeek(xFilial("SZG")+_cAno+Strzero(_nTrim,1)+QR1->B1_AXCTEXE))
		RecLock("SZG",.t.)
		SZG->ZG_FILIAL 	:= xFilial("SZG")
		SZG->ZG_ANO		:= _cAno
		SZG->ZG_TRIMEST	:= Strzero(_nTrim,1)
		SZG->ZG_CODIGO  := QR1->B1_AXCTEXE
	Else                  
		RecLock("SZG",.f.)
	EndIf    	  
       	SZG->ZG_COMPRAS += QR1->QUANT	
		SZG->(MsUnLock())       	
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())
//
//  Busca todos os fornecedores com controle do ministerio do exercito do periodo e grava na tabela SZO.
//
_cQuery := "SELECT DISTINCT B1_AXCTEXE, D1_FORNECE, D1_LOJA "
_cQuery += "       FROM " + RetSqlname("SD1") + " D1 "
_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "               ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = D1_COD "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "               ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D1_TES "
_cQuery += "       WHERE D1_FILIAL = '" + xFilial("SD1") + "' AND D1_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "' AND D1_TES <> '222' AND D1.D_E_L_E_T_ = ' ' "
_cQuery += "             AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' AND B1_AXCTEXE <> ' ' "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())
    RecLock("SZO",.t.)
	SZO->ZO_FILIAL  := xFilial("SZO")
	SZO->ZO_FORN	:= QR1->D1_FORNECE+QR1->D1_LOJA
	SZO->ZO_PRODUTO := QR1->B1_AXCTEXE
	SZO->ZO_TRIMEST := Strzero(_nTrim,1)
	SZO->ZO_ANO		:= _cAno
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
ฑฑบDesc.     ณ Funcao para atualizar o saldo de consumo e perdas.         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
/*
Static Function fConsumo()

_cQuery := "SELECT B1_AXCTEXE, ZF_DESC, ZF_UM, D3_TM, SUM(D3_QUANT * B1_CONV) AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD3") + " D3, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZF") + " ZF "
_cQuery += "       WHERE D3.D_E_L_E_T_ = ' '  AND B1.D_E_L_E_T_ = ' ' AND ZF.D_E_L_E_T_ = ' ' "
_cQuery += "             AND D3_FILIAL = '" + xFilial("SD3")+"' AND B1_FILIAL = '"
_cQuery +=               + xFilial("SB1") + "' AND ZF_FILIAL = '" + xFilial("SZF") + "' "
_cQuery += "             AND D3_COD = B1_COD AND B1_AXCTEXE = ZF_CODIGO "
_cQuery += "             AND D3_TM > '500' AND D3_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "' AND D3_ESTORNO <> 'S' "
_cQuery += "       GROUP BY B1_AXCTEXE, ZF_DESC, ZF_UM, D3_TM "

TcQuery _cQuery New Alias "QR1"               

TcSetField("QR1","QUANT","N",12,2)

SZG->(DbSetOrder(1))
QR1->(DbGoTop())
Do While ! QR1->(Eof())
	If ! SZG->(DbSeek(xFilial("SZG")+_cAno+Strzero(_nTrim,1)+QR1->B1_AXCTEXE))
		RecLock("SZG",.t.)
		SZG->ZG_FILIAL 	:= xFilial("SZG")
		SZG->ZG_ANO		:= _cAno
		SZG->ZG_TRIMEST	:= Strzero(_nTrim,1)
		SZG->ZG_CODIGO  := QR1->B1_AXCTEXE
	Else
		RecLock("SZG",.f.)
	EndIf
	// Tipo de movimento 501 entra como perda
	If QR1->D3_TM == "501"
		SZG->ZG_PERDAS 	:= QR1->QUANT        
	// Outros tipos de movimentos com excecao do tipo 999 (transferencias) entram como consumo.
	ElseIf QR1->D3_TM # "999"
		SZG->ZG_CONSUMO	:= QR1->QUANT	
	EndIf
	
	SZG->(MsUnLock())
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

_cQuery := "SELECT B1_AXCTEXE, ZF_DESC, ZF_UM, SUM(D2_QUANT * B1_CONV) AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD2") + " D2, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZF") + " ZF, "
_cQuery +=              RetSqlName("SF4") + " F4 "
_cQuery += "       WHERE D2.D_E_L_E_T_ = ' '  AND B1.D_E_L_E_T_ = ' ' AND ZF.D_E_L_E_T_ = ' ' "
_cQuery += "             AND F4.D_E_L_E_T_ = ' ' AND D2_FILIAL = '" + xFilial("SD2")+"' AND B1_FILIAL = '"
_cQuery +=               xFilial("SB1") + "' AND ZF_FILIAL = '" + xFilial("SZF") + "' AND F4_FILIAL = '"
_cQuery +=               xFilial("SF4") + "' AND D2_COD = B1_COD AND B1_AXCTEXE = ZF_CODIGO "
_cQuery += "             AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND D2_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "' AND D2_TES <> '522'"
_cQuery += "       GROUP BY B1_AXCTEXE, ZF_DESC, ZF_UM "

TcQuery _cQuery New Alias "QR1"               

TcSetField("QR1","QUANT","N",12,2)

SZG->(DbSetOrder(1))
QR1->(DbGoTop())
Do While ! QR1->(Eof())
	If ! SZG->(DbSeek(xFilial("SZG")+_cAno+Strzero(_nTrim,1)+QR1->B1_AXCTEXE))
		RecLock("SZG",.t.)
		SZG->ZG_FILIAL 	:= xFilial("SZG")
		SZG->ZG_ANO		:= _cAno
		SZG->ZG_TRIMEST	:= Strzero(_nTrim,1)
		SZG->ZG_CODIGO  := QR1->B1_AXCTEXE
	Else
		RecLock("SZG",.f.)
	EndIf
	SZG->ZG_SAIDAS += QR1->QUANT
	SZG->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())                              

//
//	Busca todas as notas fiscais do periodo e grava como sendo Numero de Guia de Trafego ministerio do exercito.
//

_cQuery := "SELECT DISTINCT B1_AXCTEXE, D2_DOC "
_cQuery += "       FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "               ON B1_FILIAL = '" + xFilial("SB1") + "' AND D2_COD = B1_COD "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "               ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D2_TES "
_cQuery += "       WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND D2_EMISSAO BETWEEN '" + _cDiaMesI + "' "
_cQuery += "             AND '" + _cDiaMesF + "' AND D2_TES <> '522' AND D2.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' AND F4_ESTOQUE = 'S' AND B1_AXCTEXE <> ' ' "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())     
	RecLock("SZN",.t.)
	SZN->ZN_FILIAL	:= xFilial("SZN")
	SZN->ZN_PRODUTO	:= QR1->B1_AXCTEXE
	SZN->ZN_NF		:= QR1->D2_DOC
	SZN->ZN_TRIMEST := Strzero(_nTrim,1)
	SZN->ZN_ANO		:= _cAno
	MsUnLock()
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

SZG->(DbGotop())
SZG->(DbSeek(xFilial("SZG")+_cAno+Strzero(_nTrim,1),.T.))

ProcRegua(SZG->(Lastrec()-SZG->(Recno())))

Do While ! SZG->(Eof()) .And. SZG->ZG_FILIAL == xFilial("SZG") .And. SZG->ZG_ANO == _cAno .And.;
			SZG->ZG_TRIMEST == Strzero(_nTrim,1)
	IncProc("Atualizando " + SZG->ZG_CODIGO + " ....")
	RecLock("SZG",.f.)
	SZG->ZG_SALFIN := SZG->ZG_SALANT + SZG->ZG_COMPRAS - SZG->ZG_CONSUMO - SZG->ZG_PERDAS - SZG->ZG_SAIDAS
	SZG->(MsUnLock())	
	SZG->(DbSkip())			
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

SZG->(DbGotop())
SZG->(DbSeek(xFilial("SZG")+_cAno+Strzero(_nTrim,1),.T.))

ProcRegua(SZG->(Lastrec()-SZG->(Recno())))

_cAnoFim 	:= iif(_nTrim == 4,Strzero(Val(_cAno)+1,4),_cAno)

_cTrimFim 	:= iif(_nTrim == 4,"1",Strzero(_nTrim+1,1))

_cQuery := "SELECT * "
_cQuery += "FROM " + RetSqlName("SZG") + " ZG "
_cQuery += "WHERE ZG.D_E_L_E_T_ = ' ' AND ZG_ANO = '" + _cAno + "' AND ZG_TRIMEST = '" + Strzero(_nTrim,1) + "' "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())

	IncProc("Gerando saldo final " + SZG->ZG_CODIGO + " ....")
	RecLock("SZG",.t.)
	SZG->ZG_FILIAL 	:= xFilial("SZG")
	SZG->ZG_ANO		:= _cAnoFim
	SZG->ZG_TRIMEST	:= _cTrimFim
	SZG->ZG_CODIGO  := QR1->ZG_CODIGO
	SZG->ZG_SALANT	:= QR1->ZG_SALFIN
	SZG->(MsUnLock())		
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

// Zera saldos do trimestre corrente e movimento.
_cUpdate := "UPDATE " + RetSqlName("SZG")
_cUpdate += "       SET ZG_COMPRAS = 0, ZG_CONSUMO = 0, ZG_SAIDAS = 0, ZG_SALFIN = 0, ZG_PERDAS = 0 "
_cUpdate += "       WHERE D_E_L_E_T_ = ' ' AND ZG_FILIAL = '" + xFilial("SZG") + "' "
_cUpdate += "             AND ZG_ANO = '" + _cAno + "' AND ZG_TRIMEST = '" + Strzero(_nTrim,1) + "' "

TcSqlExec(_cUpdate)

_cDelete := "DELETE FROM " + RetSqlName("SZN")
_cDelete += "       WHERE D_E_L_E_T_ = ' ' AND ZN_FILIAL = '" + xFilial("SZN") + "' "
_cDelete += "             AND ZN_ANO = '" + _cAno + "' AND ZN_TRIMEST = '" + Strzero(_nTrim,1) + "' "

TcSqlExec(_cDelete)

_cDelete := "DELETE FROM " + RetSqlName("SZO")
_cDelete += "       WHERE D_E_L_E_T_ = ' ' AND ZO_FILIAL = '" + xFilial("SZO") + "' "
_cDelete += "             AND ZO_ANO = '" + _cAno + "' AND ZO_TRIMEST = '" + Strzero(_nTrim,1) + "' "

TcSqlExec(_cDelete)

// Limpeza do proximo saldo
_cAnoFim 	:= iif(_nTrim == 4,Strzero(Val(_cAno)+1,4),_cAno)
_cTrimFim 	:= iif(_nTrim == 4,"1",Strzero(_nTrim+1,1))

_cDelete := "DELETE FROM " + RetSqlName("SZG")
_cDelete += "       WHERE D_E_L_E_T_ = ' ' AND ZG_FILIAL = '" + xFilial("SZG") + "' "
_cDelete += "             AND ZG_ANO = '" + _cAnoFim + "' AND ZG_TRIMEST = '" + _cTrimFim + "' "

TcSqlExec(_cDelete)


Return