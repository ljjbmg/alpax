/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLFISR21   บAutor  ณOcimar Rolli        บ Data ณ  16/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออ0อออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar um arquivo texto para importacao no sis  บฑฑ
ฑฑบ          ณ tema Perdcomp.                                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Rwmake.ch"

User Function LFISR21()

Local oGrp1,oSay2,oGrp3,oSBtn8,oSBtn9
Private  oDlg

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Arquivo TXT PERDCOM R21"
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

_cMens := "Confirma geracao do arquivo para o PERDCOM R21ALPAX "

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


_cArqTxt := "\Perdcomp\R21ALPAX.TXT"
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

_cQuery := "SELECT 'R21' AS 'TIPO' "
_cQuery += ",      '65838344000110' AS 'DECLARANTE' "
_cQuery += ",      '              ' AS 'SUCEDIDA' "
_cQuery += ",      '65838344000110' AS 'CREDITO' "
_cQuery += ",      SUBSTRING(F3_ENTRADA,1,4) AS 'ANO' "
_cQuery += ",      SUBSTRING(F3_ENTRADA,5,2) AS 'MES' "
_cQuery += ",      '0' AS 'DECENDIO' ""
_cQuery += ",      '2' AS 'MOVIMENTO' "
_cQuery += ",      SUBSTRING(F3_CFO,1,4) AS 'CFOP' "
_cQuery += ",      SUM(F3_VALIPI) AS 'CREDITADO' "
_cQuery += "FROM " + RetSqlName("SF3") + " F3 " + "(NOLOCK) "
_cQuery += "WHERE F3.D_E_L_E_T_ = ' ' "
_cQuery += "AND   F3_FILIAL = '" + xFilial("SF3") + "' "
_cQuery += "AND   SUBSTRING(F3_CFO,1,1) < 5 "
_cQuery += "AND   SUBSTRING(F3_ENTRADA,1,6) BETWEEN '200804' AND '201203' AND F3_CFO <> '1928' "
_cQuery += "GROUP BY F3_CFO, SUBSTRING(F3_ENTRADA,1,4), SUBSTRING(F3_ENTRADA,5,2) "
_cQuery += "HAVING SUM(F3_VALIPI) > 0 "
_cQuery += "UNION ALL "
_cQuery += "SELECT 'R21' AS 'TIPO' "
_cQuery += ",      '65838344000110' AS 'DECLARANTE' "
_cQuery += ",      '              ' AS 'SUCEDIDA' "
_cQuery += ",      '65838344000110' AS 'CREDITO' "
_cQuery += ",      SUBSTRING(F3_EMISSAO,1,4) AS 'ANO' "
_cQuery += ",      SUBSTRING(F3_EMISSAO,5,2) AS 'MES' "
_cQuery += ",      '0' AS 'DECENDIO' "
_cQuery += ",      '2' AS 'MOVIMENTO' "
_cQuery += ",      SUBSTRING(F3_CFO,1,4) AS 'CFOP' "
_cQuery += ",      SUM(F3_VALIPI) AS 'CREDITADO' "
_cQuery += "FROM " + RetSqlName("SF3") + " F3 " + "(NOLOCK) "
_cQuery += "WHERE F3.D_E_L_E_T_ = ' ' "
_cQuery += "AND   F3_FILIAL = '" + xFilial("SF3") + "' "
_cQuery += "AND   SUBSTRING(F3_CFO,1,1) >= 5 "
_cQuery += "AND   SUBSTRING(F3_EMISSAO,1,6) BETWEEN '200804' AND '201203' "
_cQuery += "GROUP BY F3_CFO, SUBSTRING(F3_EMISSAO,1,4), SUBSTRING(F3_EMISSAO,5,2) "
_cQuery += "HAVING SUM(F3_VALIPI) > 0 "
_cQuery += "ORDER BY ANO, MES, CFOP "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","CREDITADO"		,"N",14,2)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	_cCreNac  := 0
	_cMerExt  := 0
	_cDebNac  := 0
	_cEstCre  := 0
	_cPeriodo := (QR1->ANO+QR1->MES)
	
	_cRegistro	:= QR1->TIPO
	_cRegistro	+= QR1->DECLARANTE
	_cRegistro	+= QR1->SUCEDIDA
	_cRegistro	+= QR1->CREDITO	
	_cRegistro	+= QR1->ANO
	_cRegistro	+= QR1->MES
	_cRegistro	+= QR1->DECENDIO
	_cRegistro	+= QR1->MOVIMENTO
	Do While (QR1->ANO+QR1->MES) == _cPeriodo
		Do Case
			
			Case SubStr(QR1->CFOP,1,4) $ "1101/1102/1201/1202/1401/1403/1407/1556/1912/1913/1914/1922/1949/2101/2102/2122/2201/2202/2401/2403/2407/2912/2913/2949"
				_cCreNac += QR1->CREDITADO
				
			Case SubStr(QR1->CFOP,1,4) $ "3101/3102"
				_cMerExt += QR1->CREDITADO
				
			Case SubStr(QR1->CFOP,1,4) $ "5101/5102/5401/5910/5910/5912/5913/5914/5949/6101/6102/6107/6108/6110/6119/6401/6910/6912/6922"
				_cDebNac += QR1->CREDITADO
				
			Case SubStr(QR1->CFOP,1,4) $ "5201/5202/5411/6201/6202/6411
				_cEstCre += QR1->CREDITADO
				
		EndCase
		QR1->(DbSkip())
	EndDo
	_cRegistro	+= Strzero((_cCreNac*100),14)
	_cRegistro	+= Strzero((_cMerExt*100),14)
	_cRegistro	+= '00000000000000'
	_cRegistro	+= '00000000000000'
	_cRegistro	+= '00000000000000'
	_cRegistro	+= '00000000000000'
	_cRegistro	+= Strzero((_cDebNac*100),14)
	_cRegistro	+= Strzero((_cEstCre*100),14)
	_cRegistro	+= '00000000000000'
	_cRegistro	+= '00000000000000'
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
