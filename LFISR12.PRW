/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LFISR12   ºAutor  ³Adriano Luis Brandaoº Data ³  19/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍ0ÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gerar um arquivo texto para importacao no sis  º±±
±±º          ³ tema da policia federal.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Rwmake.ch"

User Function LFISR12()

Local oGrp1,oSay2,oGrp3,oGet4,oGet5,oSay6,oSay7,oSBtn8,oSBtn9
Private _cMes, _cAno, oDlg

_cMes := Space(02)
_cAno := Strzero(Year(dDataBase),4)

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Arquivo TXT PERDCOM R12"
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
oSay2:cCaption := "Este programa tem como objetivo gerar o arquivo da PERDCOM R12"
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
oGrp3:nWidth := 186
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
oGet5:nTop := 141
oGet5:nWidth := 69
oGet5:nHeight := 21
oGet5:lShowHint := .F.
oGet5:lReadOnly := .F.
oGet5:Align := 0
oGet5:cVariable := "_cAno"
oGet5:bSetGet := {|u| If(PCount()>0,_cAno:=u,_cAno) }
oGet5:lVisibleControl := .T.
oGet5:lPassword := .F.
oGet5:lHasButton := .F.

oSay6 := TSAY():Create(oDlg)
oSay6:cName := "oSay6"
oSay6:cCaption := "MES"
oSay6:nLeft := 64
oSay6:nTop := 109
oSay6:nWidth := 37
oSay6:nHeight := 17
oSay6:lShowHint := .F.
oSay6:lReadOnly := .F.
oSay6:Align := 0
oSay6:lVisibleControl := .T.
oSay6:lWordWrap := .F.
oSay6:lTransparent := .F.

oSay7 := TSAY():Create(oDlg)
oSay7:cName := "oSay7"
oSay7:cCaption := "ANO"
oSay7:nLeft := 64
oSay7:nTop := 142
oSay7:nWidth := 29
oSay7:nHeight := 17
oSay7:lShowHint := .F.
oSay7:lReadOnly := .F.
oSay7:Align := 0
oSay7:lVisibleControl := .T.
oSay7:lWordWrap := .F.
oSay7:lTransparent := .F.

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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fConfirmaºAutor  ³Adriano Luis Brandaoº Data ³  19/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍ0ÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para confirmar a execucao da rotina.                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fConfirma()

_cMens := "Confirma geracao do arquivo para o PERDCOM R12 " + _cMes + "/"
_cMens += _cAno + " ??"

If ApMsgNoYes(_cMens)
	_fGeraTXT()
EndIf

oDlg:End()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fGeraTXT ºAutor  ³Adriano Luis Brandaoº Data ³  19/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gerar arquivo TXT.                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fGeraTXT()

Private _cArqTxt
Private nHdl


_cArqTxt := "\Perdcomp\R12" + _cAno + _cMes + ".TXT"
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fProc    ºAutor  ³Adrino Luis Brandao º Data ³  19/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento do arquivo texto.                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fGeraMov ºAutor  ³Adriano Luis Brandaoº Data ³  03/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para geracao do arquivo de movimentacao (Notas Fis  º±±
±±º          ³ cais de entradas e saidas ).                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fGeraMov()

_cQuery := "SELECT 'R12' AS 'TIPO' "
_cQuery += ",      '65838344000110' AS 'DECLARANTE' "
_cQuery += ",      '              ' AS 'SUCEDIDA' "
_cQuery += ",      '65838344000110' AS 'CREDITO' "
_cQuery += ",      SUBSTRING(F3_EMISSAO,1,4) AS 'ANO' "
_cQuery += ",      SUBSTRING(F3_EMISSAO,5,2) AS 'MES' "
_cQuery += ",      '0' AS 'DECENDIO' "
_cQuery += ",      SUBSTRING(F3_CFO,1,4) AS 'CFOP' "
_cQuery += ",      SUM(F3_BASEIPI) AS 'BASE' "
_cQuery += ",      SUM(F3_VALIPI) AS 'DEBITADO' "
_cQuery += ",      SUM(F3_ISENIPI) AS 'ISENTAS' "
_cQuery += ",      SUM(F3_OUTRIPI) AS 'OUTRAS' "
_cQuery += "FROM " + RetSqlName("SF3") + " F3 "
_cQuery += "WHERE F3.D_E_L_E_T_ = ' ' "
_cQuery += "AND   F3_FILIAL = '" + xFilial("SF3") + "'
_cQuery += "AND   SUBSTRING(F3_CFO,1,1) >= 5 "
_cQuery += "AND   SUBSTRING(F3_EMISSAO,1,6) = '" + _cAno + _cMes + "' "
_cQuery += "GROUP BY F3_CFO, SUBSTRING(F3_EMISSAO,1,4), SUBSTRING(F3_EMISSAO,5,2) "
_cQuery += "HAVING (SUM(F3_BASEIPI)+SUM(F3_VALIPI)+SUM(F3_ISENIPI)+SUM(F3_OUTRIPI)) > 0 "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","BASE     "		,"N",14,2)
TcSetField("QR1","CREDITADO"		,"N",14,2)
TcSetField("QR1","ISENTAS"			,"N",14,2)
TcSetField("QR1","OUTRAS"			,"N",14,2)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	_cRegistro	:= QR1->TIPO											
	_cRegistro	+= QR1->DECLARANTE										    	
	_cRegistro	+= QR1->SUCEDIDA							                	
	_cRegistro	+= QR1->CREDITO				                                    
	_cRegistro	+= QR1->ANO							
	_cRegistro	+= QR1->MES	
	_cRegistro	+= QR1->DECENDIO		
	_cRegistro	+= QR1->CFOP				
	_cRegistro	+= Strzero((QR1->BASE*100),14)
	_cRegistro	+= Strzero((QR1->DEBITADO*100),14)								
	_cRegistro	+= Strzero((QR1->ISENTAS*100),14)										
	_cRegistro	+= Strzero((QR1->OUTRAS*100),14)
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