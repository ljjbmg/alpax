/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLFISR13   บAutor  ณAdriano Luis Brandaoบ Data ณ  19/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออ0อออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar um arquivo texto para importacao no sis  บฑฑ
ฑฑบ          ณ tema da policia federal.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Rwmake.ch"

User Function LFISR13()

Local oGrp1,oSay2,oGrp3,oGet4,oGet5,oGet6,oSay6,oSay7,oSay8,oSBtn8,oSBtn9
Private _cMes, _cMesF, _cAno, oDlg

_cMes  := Space(02) 
_cMesF := Space(02)
_cAno  := Strzero(Year(dDataBase),4)

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Arquivo TXT PERDCOM R13"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 412
oDlg:nHeight := 240
oDlg:lShowHint := .F.
oDlg:lCentered := .T.

oGrp1 := TGROUP():Create(oDlg)
oGrp1:cName := "oGrp1"
oGrp1:nLeft := 22
oGrp1:nTop := 19
oGrp1:nWidth := 347
oGrp1:nHeight := 57
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oSay2 := TSAY():Create(oDlg)
oSay2:cName := "oSay2"
oSay2:cCaption := "Este programa tem como objetivo gerar o arquivo da PERDCOM R13"
oSay2:nLeft := 32
oSay2:nTop := 37
oSay2:nWidth := 325
oSay2:nHeight := 17
oSay2:lShowHint := .F.
oSay2:lReadOnly := .F.
oSay2:Align := 0
oSay2:lVisibleControl := .T.
oSay2:lWordWrap := .F.
oSay2:lTransparent := .F.

oGrp3 := TGROUP():Create(oDlg)
oGrp3:cName := "oGrp3"
oGrp3:nLeft := 24
oGrp3:nTop := 92
oGrp3:nWidth := 200
oGrp3:nHeight := 94
oGrp3:lShowHint := .F.
oGrp3:lReadOnly := .F.
oGrp3:Align := 0
oGrp3:lVisibleControl := .T.

oGet4 := TGET():Create(oDlg)
oGet4:cName := "oGet4"
oGet4:cCaption := "oGet4"
oGet4:nLeft := 110
oGet4:nTop := 107
oGet4:nWidth := 52
oGet4:nHeight := 21
oGet4:lShowHint := .F.
oGet4:lReadOnly := .F.
oGet4:Align := 0
oGet4:cVariable := "_cMes"
oGet4:bSetGet := {|u| If(PCount()>0,_cMes:=u,_cMes) }
oGet4:lVisibleControl := .T.
oGet4:lPassword := .F.
oGet4:lHasButton := .F.
oGet4:bValid := {|| Val(_cMes) <= 12 .And. ! Empty(_cMes) }

oGet5 := TGET():Create(oDlg)
oGet5:cName := "oGet5"
oGet5:cCaption := "oGet5"
oGet5:nLeft := 110
oGet5:nTop := 127
oGet5:nWidth := 52
oGet5:nHeight := 21
oGet5:lShowHint := .F.
oGet5:lReadOnly := .F.
oGet5:Align := 0
oGet5:cVariable := "_cMesF"
oGet5:bSetGet := {|u| If(PCount()>0,_cMesF:=u,_cMes) }
oGet5:lVisibleControl := .T.
oGet5:lPassword := .F.
oGet5:lHasButton := .F.
oGet5:bValid := {|| Val(_cMesF) <= 12 .And. ! Empty(_cMesF) }

oGet6 := TGET():Create(oDlg)
oGet6:cName := "oGet6"
oGet6:cCaption := "oGet6"
oGet6:nLeft := 110
oGet6:nTop := 147
oGet6:nWidth := 69
oGet6:nHeight := 21
oGet6:lShowHint := .F.
oGet6:lReadOnly := .F.
oGet6:Align := 0
oGet6:cVariable := "_cAno"
oGet6:bSetGet := {|u| If(PCount()>0,_cAno:=u,_cAno) }
oGet6:lVisibleControl := .T.
oGet6:lPassword := .F.
oGet6:lHasButton := .F.

oSay6 := TSAY():Create(oDlg)
oSay6:cName := "oSay6"
oSay6:cCaption := "MES INICIAL"
oSay6:nLeft := 60
oSay6:nTop := 109
oSay6:nWidth := 70
oSay6:nHeight := 17
oSay6:lShowHint := .F.
oSay6:lReadOnly := .F.
oSay6:Align := 0
oSay6:lVisibleControl := .T.
oSay6:lWordWrap := .F.
oSay6:lTransparent := .F.

oSay7 := TSAY():Create(oDlg)
oSay7:cName := "oSay7"
oSay7:cCaption := "MES FINAL"
oSay7:nLeft := 60
oSay7:nTop := 129
oSay7:nWidth := 70
oSay7:nHeight := 17
oSay7:lShowHint := .F.
oSay7:lReadOnly := .F.
oSay7:Align := 0
oSay7:lVisibleControl := .T.
oSay7:lWordWrap := .F.
oSay7:lTransparent := .F.

oSay8 := TSAY():Create(oDlg)
oSay8:cName := "oSay8"
oSay8:cCaption := "ANO"
oSay8:nLeft := 60
oSay8:nTop := 149
oSay8:nWidth := 29
oSay8:nHeight := 17
oSay8:lShowHint := .F.
oSay8:lReadOnly := .F.
oSay8:Align := 0
oSay8:lVisibleControl := .T.
oSay8:lWordWrap := .F.
oSay8:lTransparent := .F.

oSBtn8 := SBUTTON():Create(oDlg)
oSBtn8:cName := "oSBtn8"
oSBtn8:cCaption := "OK"
oSBtn8:nLeft := 266
oSBtn8:nTop := 97
oSBtn8:nWidth := 60
oSBtn8:nHeight := 30
oSBtn8:lShowHint := .F.
oSBtn8:lReadOnly := .F.
oSBtn8:Align := 0
oSBtn8:lVisibleControl := .T.
oSBtn8:nType := 1
oSBtn8:bAction := {|| _fConfirma() }

oSBtn9 := SBUTTON():Create(oDlg)
oSBtn9:cName := "oSBtn9"
oSBtn9:cCaption := "CANCELAR"
oSBtn9:nLeft := 266
oSBtn9:nTop := 156
oSBtn9:nWidth := 60
oSBtn9:nHeight := 30
oSBtn9:lShowHint := .F.
oSBtn9:lReadOnly := .F.
oSBtn9:Align := 0
oSBtn9:lVisibleControl := .T.
oSBtn9:nType := 2
oSBtn9:bAction := {|| oDlg:End() }

oDlg:Activate()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fConfirmaบAutor  ณAdriano Luis Brandaoบ Data ณ  19/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออ0อออออออนฑฑ
ฑฑบDesc.     ณ Funcao para confirmar a execucao da rotina.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fConfirma()

_cMens := "Confirma geracao do arquivo para o PERDCOM R13 " + _cMes + "/"
_cMens += _cAno + " ??"

If ApMsgNoYes(_cMens)
	_fGeraTXT()
EndIf

oDlg:End()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGeraTXT บAutor  ณAdriano Luis Brandaoบ Data ณ  19/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar arquivo TXT.                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fGeraTXT()

Private _cArqTxt
Private nHdl


_cArqTxt := "\Perdcomp\R13" + _cAno + _cMes + _cMesF +".TXT"
nHdl    := fCreate(_cArqTxt)

cEOL := CHR(13)+CHR(10)

If nHdl == -1
	MsgAlert("O arquivo "+_cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
	ApMsgStop("O arquivo " + _cArqTxt + " nao pode ser criado ")
	Return
Endif
//
// Processamento do arquivo texto.
//
Processa( {|| _fProc() })


fClose(nHdl)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fProc    บAutor  ณAdrino Luis Brandao บ Data ณ  19/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento do arquivo texto.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fProc()

_aMes 		:= {"JAN","FEV","MAR","ABR","MAI","JUN","JUL","AGO","SET","OUT","NOV","DEZ"}

_cMesExt	:= _aMes[val(_cMes)]

//
// Gera Registro de movimentacao, (Notas fiscais de saida e entrada )
//
MsgRun("Gerando registro dos produtos",,{|| _fGeraMov()})


ApMsgAlert("Arquivo Gerado com sucesso !!!")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGeraMov บAutor  ณAdriano Luis Brandaoบ Data ณ  03/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para geracao do arquivo de movimentacao (Notas Fis  บฑฑ
ฑฑบ          ณ cais de entradas e saidas ).                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fGeraMov()

_cQuery := "SELECT 'R13' AS 'TIPO' "
_cQuery += ",      '65838344000110' AS 'DECLARANTE' "
_cQuery += ",      '              ' AS 'SUCEDIDA' "
_cQuery += ",      '65838344000110' AS 'CREDITO' "
_cQuery += ",      A2_CGC AS 'EMITENTE' "
_cQuery += ",      A2_TIPO AS 'TIPOFJ' "
_cQuery += ",      F3_NFISCAL AS 'NOTA' "
_cQuery += ",      F3_SERIE AS 'SERIE' "
_cQuery += ",      SUBSTRING(F3_EMISSAO,7,2)+SUBSTRING(F3_EMISSAO,5,2)+SUBSTRING(F3_EMISSAO,1,4) as 'EMISSAO' "
_cQuery += ",      SUBSTRING(F3_ENTRADA,7,2)+SUBSTRING(F3_ENTRADA,5,2)+SUBSTRING(F3_ENTRADA,1,4) AS 'ENTRADA' "
_cQuery += ",      SUBSTRING(F3_CFO,1,4) AS 'CFOP' "
_cQuery += ",      SUM(F3_VALCONT) AS 'TOTAL' "
_cQuery += ",      SUM(F3_VALIPI) AS 'DESTACADO' "
_cQuery += ",      SUM(F3_VALIPI) AS 'CREDITADO' "
_cQuery += "FROM " + RetSqlName("SF3") + " F3 "
_cQuery += "INNER JOIN " + RetSqlName("SA2") + " A2 "
_cQuery += "ON F3_CLIEFOR = A2_COD "
_cQuery += "WHERE F3.D_E_L_E_T_ = ' ' " 
_cQuery += "AND   F3_FILIAL = '" + xFilial("SF3") + "' 
_cQuery += "AND   A2_FILIAL = '" + xFilial("SA2") + "'
_cQuery += "AND   SUBSTRING(F3_CFO,1,1) < 5 "
_cQuery += "AND   SUBSTRING(F3_ENTRADA,1,6) BETWEEN '" + _cAno + _cMes + "' AND '" + _cAno + _cMesF + "' "
_cQuery += "AND   F3_VALIPI <> 0 AND F3_TIPO NOT IN ('D','B')"
_cQuery += "GROUP BY F3_CFO, A2_CGC, F3_NFISCAL, F3_SERIE, F3_EMISSAO, F3_ENTRADA, A2_TIPO "  
_cQuery += "UNION ALL "
_cQuery += "SELECT 'R13' AS 'TIPO' "
_cQuery += ",      '65838344000110' AS 'DECLARANTE' "
_cQuery += ",      '              ' AS 'SUCEDIDA' "
_cQuery += ",      '65838344000110' AS 'CREDITO' "
_cQuery += ",      A1_CGC AS 'EMITENTE' "
_cQuery += ",      A1_PESSOA AS 'TIPOFJ' "
_cQuery += ",      F3_NFISCAL AS 'NOTA' "
_cQuery += ",      F3_SERIE AS 'SERIE' "
_cQuery += ",      SUBSTRING(F3_EMISSAO,7,2)+SUBSTRING(F3_EMISSAO,5,2)+SUBSTRING(F3_EMISSAO,1,4) as 'EMISSAO' "
_cQuery += ",      SUBSTRING(F3_ENTRADA,7,2)+SUBSTRING(F3_ENTRADA,5,2)+SUBSTRING(F3_ENTRADA,1,4) AS 'ENTRADA' "
_cQuery += ",      SUBSTRING(F3_CFO,1,4) AS 'CFOP' "
_cQuery += ",      SUM(F3_VALCONT) AS 'TOTAL' "
_cQuery += ",      SUM(F3_VALIPI) AS 'DESTACADO' "
_cQuery += ",      SUM(F3_VALIPI) AS 'CREDITADO' "
_cQuery += "FROM " + RetSqlName("SF3") + " F3 "
_cQuery += "INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "ON F3_CLIEFOR = A1_COD "
_cQuery += "WHERE F3.D_E_L_E_T_ = ' ' " 
_cQuery += "AND   F3_FILIAL = '" + xFilial("SF3") + "' 
_cQuery += "AND   A1_FILIAL = '" + xFilial("SA1") + "'
_cQuery += "AND   SUBSTRING(F3_CFO,1,1) < 5 "
_cQuery += "AND   SUBSTRING(F3_ENTRADA,1,6) BETWEEN '" + _cAno + _cMes + "' AND '" + _cAno + _cMesF + "' "
_cQuery += "AND   F3_VALIPI <> 0 AND F3_TIPO IN ('D','B') "
_cQuery += "GROUP BY F3_CFO, A1_CGC, F3_NFISCAL, F3_SERIE, F3_EMISSAO, F3_ENTRADA, A1_PESSOA "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","BASE     "		,"N",14,2)
TcSetField("QR1","CREDITADO"		,"N",14,2)
TcSetField("QR1","ISENTAS"			,"N",14,2)
TcSetField("QR1","OUTRAS"			,"N",14,2)

QR1->(DbGoTop())

Do While ! QR1->(Eof())

_cNota := Strzero(Val(QR1->NOTA),9)
_cCnpj := Strzero(Val(QR1->EMITENTE),14)  

If QR1->TIPOFJ == 'F'
	_cCnpj := '65838344000110'
EndIf	
	
	_cRegistro	:= QR1->TIPO											
	_cRegistro	+= QR1->DECLARANTE										    	
	_cRegistro	+= QR1->SUCEDIDA							                	
	_cRegistro	+= QR1->CREDITO				                                    
	_cRegistro	+= _cCnpj							
	_cRegistro	+= _cNota	
	_cRegistro	+= QR1->SERIE		
	_cRegistro	+= QR1->EMISSAO				
	_cRegistro	+= QR1->ENTRADA
	_cRegistro	+= QR1->CFOP		
	_cRegistro	+= Strzero((QR1->TOTAL*100),14)
	_cRegistro	+= Strzero((QR1->DESTACADO*100),14)								
	_cRegistro	+= Strzero((QR1->CREDITADO*100),14)										
	_cRegistro	+= cEOL													

	If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
		If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
			Return
		Endif
	Endif
	
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return