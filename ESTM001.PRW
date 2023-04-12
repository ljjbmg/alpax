/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM001   บAutor  ณAdriano Luis Brandaoบ Data ณ  19/07/04   บฑฑ
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

User Function ESTM001()

Local oGrp1,oSay2,oGrp3,oGet4,oGet5,oSay6,oSay7,oSBtn8,oSBtn9
Private _cMes, _cAno, oDlg

_cMes := Space(02)
_cAno := Strzero(Year(dDataBase),4)

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Arquivo TXT Policia Federal"
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
oSay2:cCaption := "Este programa tem como objetivo gerar o arquivo da policia federal"
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

_cMens := "Confirma geracao do arquivo para a policia federal do periodo de " + _cMes + "/"
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

Local cNomeArq
Private _cArqTxt
Private nHdl
Private cArqLoc

_aMes 		:= {"JAN","FEV","MAR","ABR","MAI","JUN","JUL","AGO","SET","OUT","NOV","DEZ"}
_cMesExt	:= _aMes[val(_cMes)]
cNomeArq    := "M" + _cAno + _cMesExt + SM0->M0_CGC + ".TXT"

//cArqTxt:= cGetFile( '*.txt|*.txt' , 'Textos (TXT)', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T., .T. )
//nHdl:= fCreate(cArqTxt+cNomeArq)	//Cria o arquivo texto  
//If nHdl == -1
//	MsgAlert("O arquivo "+_cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
//	ApMsgStop("O arquivo " + _cArqTxt + " nao pode ser criado ")
//	Return
//Endif

cArqLoc  := cGetFile( '*.txt|*.txt' , 'Textos (TXT)', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T., .T. )
_cArqTxt := "\Export\" 
_cArqTxt := _cArqTxt + cNomeArq
nHdl     := fCreate(_cArqTxt)
cEOL 	 := CHR(13)+CHR(10)

If nHdl == -1
	MsgAlert("O arquivo "+_cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
	ApMsgStop("O arquivo " + _cArqTxt + " nao pode ser criado")
	Return
Endif
//
// Processamento do arquivo texto.
//
Processa( {|| _fProc() })
fClose(nHdl)
CpyS2T( _cArqTxt, cArqLoc, .F. )

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
// Gera Registro do cabecalho
//
MsgRun("Gerando cabecalho do arquivo",,{ || _fGeraCab()})
//
// Gera Registro de produtos
//
MsgRun("Gerando registro dos produtos",,{|| _fGeraProd()})
//
// Gera Registro de movimentacao, (Notas fiscais de saida e entrada )
//
MsgRun("Gerando registro dos produtos",,{|| _fGeraMov()})
//
// Gera Registro de movimentacao, (Notas fiscais de saida e entrada )
//
//MsgRun("Gerando registro dos produtos",,{|| _fGeraSub()})

ApMsgAlert("Arquivo Gerado com sucesso !!!")

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGeraCab บAutor  ณAdriano Luis Brandaoบ Data ณ  21/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar o cabecalho do arquivo Texto.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - Alpax.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fGeraCab()

_cRegistro 	:= "EM"																// Tipo
_cRegistro 	+= SM0->M0_CGC														// CNPJ
_cRegistro	+= _cMesExt                                                         // MES
_cRegistro	+= _cAno                                                            // ANO
_cRegistro	+= "1"                                                              // COMERCIALIZAวรO NACIONAL (1 SE SIM OU 0 SE NAO)
_cRegistro	+= "0"                                                              // COMERCIALIZAวรO INTERNACIONAL (1 SE SIM OU 0 SE NAO)
_cRegistro	+= "0"                                                              // PRODUวรO (1 SE SIM OU 0 SE NAO)
_cRegistro	+= "0"                                                              // TRANSFORMAวรO (1 SE SIM OU 0 SE NAO)
_cRegistro	+= "0"                                                              // CONSUMO (1 SE SIM OU 0 SE NAO)
_cRegistro	+= "0"                                                              // FABRICAวรO (1 SE SIM OU 0 SE NAO)
_cRegistro	+= "0"                                                              // TRANSPORTE (1 SE SIM OU 0 SE NAO)
_cRegistro	+= "0"                                                              // ARMAZENAMENTO (1 SE SIM OU 0 SE NAO)
_cRegistro	+= cEOL																// final de linha

If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
	If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
		Return
	Endif
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGeraProdบAutor  ณAdriano Luis Brandaoบ Data ณ  03/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera os registros dos produtos.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fGeraProd()

Local cAliasSub := GetNextAlias()
Local nCount	:= 0
Local cCodAnt	:= ''
Local nReg      := 1
_cRegistro		:= ''

//ALTERAวรO DO LAYOUT - ANDRE R. ESTEVES - 09/10/2019
_cRegistro 	:= "DG"		// ABERTURA DA SEวรO DE DEMONSTRATIVO GERAL
_cRegistro	+= cEOL																// final de linha

_cPeriodo := _cAno+_cMes
_cQuery := "SELECT 'S' AS TIPO,B1_AXCTPF, ROUND(B1_AXCONC,0) B1_AXCONC, B1_AXDENS, B1_POSIPI, ZB_UM AS UM,  "
_cQuery += "       D2_CF AS CFO, ZB_DESC, SUM(D2_QUANT * B1_CONV) AS QUANT, ZB_CODPFED, YD_CODPFED "
_cQuery += "FROM   " + RetSqlName("SD2") +" D2, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZB") + " ZB, "+RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE  D2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND ZB.D_E_L_E_T_ = ' ' AND "
_cQuery += "       D2_FILIAL = '" + xFilial("SD2") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "       ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "       D2_COD = B1_COD AND B1_AXFEDER = 'S' AND LEFT(D2_EMISSAO,6) = '" +_cPeriodo+ "' AND "
_cQuery += "       B1_MSBLQL <> '1' AND B1_AXCTPF = ZB_CODIGO AND D2_TES NOT IN ('522','519','505') "   
_cQuery += "       AND F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "       AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND ROUND(B1_AXCONC,0) > 0 "
_cQuery += "GROUP BY B1_AXCTPF, B1_AXCONC, B1_AXDENS, B1_POSIPI, ZB_UM, D2_CF, ZB_DESC, YD_CODPFED, ZB_CODPFED "
_cQuery += "UNION ALL "
_cQuery += "SELECT 'E' AS TIPO,B1_AXCTPF, ROUND(B1_AXCONC,0) B1_AXCONC, B1_AXDENS, B1_POSIPI, ZB_UM AS UM,  "
_cQuery += "       D1_CF AS CFO, ZB_DESC, SUM(D1_QUANT * B1_CONV) AS QUANT, ZB_CODPFED, YD_CODPFED "
_cQuery += "FROM   " + RetSqlName("SD1") +" D1, " + RetSqlName("SB1") + " B1, " + RetSqlName("SZB") + " ZB, "+RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE  D1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND ZB.D_E_L_E_T_ = ' ' AND "
_cQuery += "       D1_FILIAL = '" + xFilial("SD1")+ "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "       ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "       D1_COD = B1_COD AND B1_AXFEDER = 'S' AND LEFT(D1_EMISSAO,6) = '" +_cPeriodo+ "' AND "
_cQuery += "       B1_MSBLQL <> '1' AND B1_AXCTPF = ZB_CODIGO "                                          
_cQuery += "       AND F4_FILIAL = '" + xFilial("SF4") + "' AND D1_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "       AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND ROUND(B1_AXCONC,0) > 0 "
_cQuery += "GROUP BY B1_AXCTPF, B1_AXCONC, B1_AXDENS, B1_POSIPI, ZB_UM, D1_CF, ZB_DESC, YD_CODPFED, ZB_CODPFED "

MemoWrite("\queries\estm0001.sql",_cQuery)
_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_AXDENS"		,"N",12,2)
TcSetField("QR1","B1_AXCONC"		,"N",12,2)
TcSetField("QR1","QUANT"			,"N",12,3)

_aCampos := { 	{ "TMP_NOME"	,"C",70,0	}	,;	// Nome Produto
{ "TMP_AXCTPF"	,"C",06,0	}	,;	// Classificao policia federal (SZB)
{ "TMP_CONC"	,"C",06,0 	}	,;	// Concentracao
{ "TMP_DENS"	,"C",06,0 	}	,;	// Densidade
{ "TMP_QANTER"	,"N",12,3	}	,;	// Quantidade anterior de estoque
{ "TMP_COMPRA"	,"N",12,3	}	,;	// Quantidade de compras
{ "TMP_VENDA"	,"N",12,3	}	,;	// Quantidade de vendas.
{ "TMP_ENTDV"	,"N",12,3	}	,;	// Quantidade de algumas Compras e dev.estoque
{ "TMP_SAIDV"	,"N",12,3	}	,;	// Quantidade de algumas saidas e requis.estoque
{ "TMP_UM"		,"C",06,0	}	,;	// Unidade de medida.
{ "TMP_NCM"		,"C",10,0	}	,;  // NCM
{ "TMP_CODPFD"  ,"C",11,0	} }	    //COD PRODUTO NA POL. FEDEREAL
//
// Arquivo temporario e o indice.
//
_cArqTmp := Criatrab(_aCampos,.t.)
DbUseArea(.t.,,_cArqTmp,"TMP",.f.,.f.)
_cIndTmp := Criatrab(,.f.)
IndRegua("TMP",_cIndTmp,"TMP_AXCTPF+TMP_CONC",,,"Criando Indice temporario")

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	_cConc 	:= StrTran(Strzero(QR1->B1_AXCONC,6,2),".",",")
	_cDens	:= StrTran(Strzero(QR1->B1_AXDENS,6,2),".",",")
	If ! TMP->(DbSeek(QR1->B1_AXCTPF+_cConc))
		RecLock("TMP",.t.)
		TMP->TMP_AXCTPF	:= QR1->B1_AXCTPF
		TMP->TMP_NOME	:= QR1->ZB_DESC
		TMP->TMP_CONC	:= _cConc
		TMP->TMP_DENS	:= _cDens
		TMP->TMP_UM		:= QR1->UM
		TMP->TMP_NCM	:= QR1->B1_POSIPI
		TMP->TMP_CODPFD := QR1->ZB_CODPFED
	Else
		RecLock("TMP",.f.)
	EndIf
	
	Do Case
		//
		// Nota fiscal de venda
		//
		Case QR1->TIPO == "S"
			If Alltrim(QR1->CFO) $ "5102/6102/5117/6117/5108/6108/5110/6110/5403/5405/6403/6404"
				TMP->TMP_VENDA 	+= QR1->QUANT
			Else
				TMP->TMP_SAIDV 	+= QR1->QUANT
			EndIf
			//
			// Nota Fiscal de compra
			//
		Case QR1->TIPO = "E"
			If Alltrim(QR1->CFO) $ "1101/1102/2102/1117/2117/1403/2403/1405/2405"
				TMP->TMP_COMPRA	+= QR1->QUANT
			Else
				TMP->TMP_ENTDV	+= QR1->QUANT
			EndIf
	EndCase
	TMP->(MsUnLock())
	// salta registro
	QR1->(DbSkip())
EndDo


QR1->(DbCloseArea())
TMP->(dbGoTop())

_cAnoPer := iif(val(_cMes)==12,Strzero(val(_cAno)+1,4),_cAno)
_cMesPer := iif(val(_cMes)==12,"01",strzero(val(_cMes)+1,2))
_cProxPer := _cAnoPer+_cMesPer

// Deleta os saldos iniciais do proximo mes se existirem para serem recriados
_cQuery := "DELETE " + RetSqlName("SZC") 
_cQuery += " WHERE D_E_L_E_T_ = ' ' AND ZC_PERIODO = '" + _cProxPer + "' "
TcSqlExec(_cQuery)

SZC->(DbSetOrder(1))

If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
	If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
		Return
	Endif
Endif
//Verifica็ใo se existe movimenta็ใo de Produto Composto

BeginSql Alias cAliasSub
	
	SELECT 	DISTINCT 'S' TIPO, 
			D2_COD, 
			ZA9_AXCTPF, 
			ZA9_POSIPI, 
			B1_UM, 
			B1_AXDENS, 
			D2_CF, 
			ZB_DESC, 
			ZB_CODPFED, 
			ZA9_AXCONC,  
			B1_POSIPI,
			SUM(D2_QUANT * B1_CONV) AS QUANT
		FROM %Table:SD2% SD2 	INNER JOIN %Table:ZA9% ZA9 ON ZA9_COD = D2_COD
								INNER JOIN %Table:SB1% SB1 ON D2_COD = B1_COD 
								INNER JOIN %Table:SF4% SF4 ON F4_CODIGO = D2_TES 
								INNER JOIN %Table:SZB% SZB ON ZB_CODIGO = ZA9_AXCTPF
		WHERE
		LEFT(SD2.D2_EMISSAO,6) = %Exp:_cPeriodo% AND
		SB1.B1_MSBLQL <> '1' AND 
		D2_TES NOT IN ('522','519','505')   AND 
		F4_ESTOQUE = 'S' AND 
		SD2.%NotDel% AND SF4.%NotDel% AND SB1.%NotDel% AND ZA9.%NotDel% 
		Group by D2_COD , ZA9_AXCTPF, ZA9_POSIPI , B1_UM, D2_CF , ZB_DESC 	, ZB_CODPFED , ZA9_AXCONC , B1_AXDENS, B1_POSIPI

		Union All

	SELECT 	DISTINCT 'S' TIPO, 
			D1_COD, 
			ZA9_AXCTPF, 
			ZA9_POSIPI, 
			B1_UM, 
			B1_AXDENS, 
			D1_CF, 
			ZB_DESC, 
			ZB_CODPFED, 
			ZA9_AXCONC,  
			B1_POSIPI,
			SUM(D1_QUANT * B1_CONV) AS QUANT
		FROM %Table:SD1% SD1 	INNER JOIN %Table:ZA9% ZA9 ON ZA9_COD = D1_COD
								INNER JOIN %Table:SB1% SB1 ON D1_COD = B1_COD 
								INNER JOIN %Table:SF4% SF4 ON F4_CODIGO = D1_TES 
								INNER JOIN %Table:SZB% SZB ON ZB_CODIGO = ZA9_AXCTPF
		WHERE
		LEFT(SD1.D1_DTDIGIT,6) = %Exp:_cPeriodo% AND
		SB1.B1_MSBLQL <> '1' AND 
		F4_ESTOQUE = 'S' AND 
		SD1.%NotDel% AND SF4.%NotDel% AND SB1.%NotDel% AND ZA9.%NotDel% 
		Group by D1_COD , ZA9_AXCTPF, ZA9_POSIPI , B1_UM, D1_CF , ZB_DESC 	, ZB_CODPFED , ZA9_AXCONC , B1_AXDENS, B1_POSIPI
		ORDER BY 2, 3 ASC 


EndSql

aSql := GetLastQuery()
cSql := aSql[2]
MemoWrite("\queries\estm001_sub.sql",cSql)

(cAliasSub)->(dbEval({|| nCount++},,{|| !EOF()}))

IF nCount > 0
	
	(cAliasSub)->(dbGoTop())
	
	While (cAliasSub)->(!Eof())
			
		_cConc 	:= Str((cAliasSub)->ZA9_AXCONC)
		_cDens	:= StrTran(Strzero((cAliasSub)->B1_AXDENS ,6,2),".",",")
		
		If nReg == 1
			
			_cRegistro	+= "PC"																	// TIPO	
			_cRegistro	+= Subs((cAliasSub)->B1_POSIPI,1,4)+"."+Subs((cAliasSub)->B1_POSIPI,5,2)+"."+Subs((cAliasSub)->B1_POSIPI,7,2)                                  // Cod.PRODUTO POL. FEDERAL - TABELA OFICIAL
			_cRegistro	+= PadR((cAliasSub)->ZB_DESC,70)										// Nome Produto
			_cRegistro	+= Substring(_cDens,2,5)	                            				// Densidade
			_cRegistro	+= cEOL																	// Final de linha
			_cRegistro	+= "SC"																	// TIPO	
			_cRegistro  += Left((cAliasSub)->ZB_CODPFED,11)
			_cRegistro  += StrZero(Val(_cConc),2)
			_cRegistro	+= cEOL																	// Final de linha
	
			nReg++		
			If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
				If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
					Return
				Endif
			Endif

		Else
			If (cAliasSub)->D2_COD == cCodAnt
				
				_cRegistro	:= "SC"																	// TIPO	
				_cRegistro  += Left((cAliasSub)->ZB_CODPFED,11)
				_cRegistro  += Left(AllTrim(_cConc),2)
				_cRegistro	+= cEOL																	// Final de linha

				If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
					If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
						Return
					Endif
				Endif
			
			Else

				_cRegistro	:= "PC"																	// TIPO	
				_cRegistro	+= Subs((cAliasSub)->ZA9_POSIPI,1,4)+"."+Subs((cAliasSub)->ZA9_POSIPI,5,2)+"."+Subs((cAliasSub)->ZA9_POSIPI,7,2)                                  // Cod.PRODUTO POL. FEDERAL - TABELA OFICIAL
				_cRegistro	+= PadR((cAliasSub)->ZB_DESC,70)										// Nome Produto
				_cRegistro	+= Substring(_cDens,2,5)	                           					// Densidade
				_cRegistro	+= cEOL																	// Final de linha
			
				If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
					If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
						Return
					Endif
				Endif

			EndIf
		EndIf
		cCodAnt := (cAliasSub)->D2_COD
		(cAliasSub)->(DbSkip())
	Enddo
 

End

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Do While ! TMP->(Eof())
	_nSaldoIni := 0
	If SZC->(DbSeek(xFilial("SZC")+_cAno+_cMes+TMP->TMP_AXCTPF+TMP->TMP_CONC))
		_nSaldoIni := SZC->ZC_SALDO
	EndIf
	
	_nEstAtual	:= (_nSaldoIni + TMP->TMP_COMPRA - TMP->TMP_VENDA + TMP->TMP_ENTDV - TMP->TMP_SAIDV)
	_cRegistro	:= "PR"														// TIPO	
	_cRegistro	+= TMP->TMP_CODPFD	                                        // Cod.PRODUTO POL. FEDERAL - TABELA OFICIAL
	_cRegistro	+= Left(TMP->TMP_NOME,70)									// Nome Produto
	_cRegistro	+= Left(TMP->TMP_CONC,3)// + "," + Right(TMP->TMP_CONC,2)	// Concentracao - Manuten็ใo novo lay out Andre R. Esteves 10/10/2019
	_cRegistro	+= Substring(TMP->TMP_DENS,2,5)	                            // Densidade
	_cRegistro	+= cEOL														// Final de linha

	If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
		If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
			Return
		Endif
	Endif

	RecLock("SZC",.t.)
	SZC->ZC_FILIAL	:= xFilial("SZC")
	SZC->ZC_PERIODO := _cProxPer
	SZC->ZC_CODIGO	:= TMP->TMP_AXCTPF
	SZC->ZC_CONC	:= TMP->TMP_CONC
	SZC->ZC_DENS	:= TMP->TMP_DENS
	SZC->ZC_SALDO	:= _nEstAtual
	SZC->(MsUnLock())
	
	TMP->(DbSkip())
EndDo

TMP->(DbCloseArea())
Ferase(_cArqTmp+".DBF")
Ferase(_cIndTmp+OrdBagExt())

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

Local cIndice := ""

// Entradas de fornecedores
_cQuery	:= "SELECT D1_EMISSAO, D1_CF, ROUND(B1_AXCONC,0) B1_AXCONC, SUM(D1_QTSEGUM) D1_QTSEGUM,D1_DOC,A2_CGC,F1_AXTRANS, "
_cQuery += "       ZB_DESC,B1_TIPCONV,B1_CONV,CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM,SUM(D1_QUANT) D1_QUANT,'F' AS TIPO, F4_CODOPPF, A2_NOME, B1_AXDENS, ZB_CODPFED, YD_CODPFED, 'PFC' as FLAG, B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD1") + " D1, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA2")
_cQuery += "       A2, " + RetSqlName("SF1") + " F1, " + RetSqlName("SZB") + " ZB, "+RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A2.D_E_L_E_T_ = ' ' AND ZB.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D1_FILIAL = '" + xFilial("SD1") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F1_FILIAL = '" + xFilial("SF1") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' AND "
_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D1_COD = B1_COD AND D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND "
_cQuery += "      D1_FORNECE = F1_FORNECE AND D1_LOJA = F1_LOJA AND D1_FORNECE = A2_COD AND "
_cQuery += "      D1_LOJA = A2_LOJA AND Left(D1_EMISSAO,06) = '" + _cAno + _cMes + "' AND "
_cQuery += "      B1_AXCTPF = ZB_CODIGO AND "
_cQuery += "      B1_AXFEDER = 'S' AND D1_TIPO = 'N' "            
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D1_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND ROUND(B1_AXCONC,0) > 0 "
_cQuery += "GROUP BY A2_CGC, D1_DOC, D1_EMISSAO, D1_CF, B1_AXCONC, B1_AXDENS, ZB_CODPFED, YD_CODPFED, F1_AXTRANS, ZB_DESC, B1_TIPCONV, B1_CONV, ZB_UM, F4_CODOPPF,A2_NOME, B1_UM, B1_SEGUM, B1_POSIPI "
_cQuery += "UNION ALL "

// Entradas de clientes (devolucoes e beneficiamentos)
_cQuery	+= "SELECT D1_EMISSAO, D1_CF, ROUND(B1_AXCONC,0) B1_AXCONC, SUM(D1_QTSEGUM) D1_QTSEGUM,D1_DOC, A1_CGC, F1_AXTRANS, "
_cQuery += "       ZB_DESC, B1_TIPCONV, B1_CONV, CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM, SUM(D1_QUANT) D1_QUANT, 'F' AS TIPO, F4_CODOPPF, A1_NOME, B1_AXDENS, ZB_CODPFED, YD_CODPFED, 'PFC' as FLAG , B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD1") + " D1, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA1")
_cQuery += "       A1, " + RetSqlName("SF1") + " F1, " + RetSqlName("SZB") + " ZB, "+RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A1.D_E_L_E_T_ = ' ' AND ZB.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D1_FILIAL = '" + xFilial("SD1") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F1_FILIAL = '" + xFilial("SF1") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' AND "
_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D1_COD = B1_COD AND D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND "
_cQuery += "      D1_FORNECE = F1_FORNECE AND D1_LOJA = F1_LOJA AND D1_FORNECE = A1_COD AND "
_cQuery += "      D1_LOJA = A1_LOJA AND Left(D1_EMISSAO,06) = '" + _cAno + _cMes + "' AND "
_cQuery += "      B1_AXCTPF = ZB_CODIGO AND "
_cQuery += "      B1_AXFEDER = 'S' AND D1_TIPO IN ('D','B') "                                          
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D1_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND ROUND(B1_AXCONC,0) > 0 "
_cQuery += "GROUP BY A1_CGC, D1_DOC, D1_EMISSAO, D1_CF, B1_AXCONC, B1_AXDENS, ZB_CODPFED, YD_CODPFED, F1_AXTRANS, ZB_DESC, B1_TIPCONV, B1_CONV, ZB_UM, F4_CODOPPF, A1_NOME, B1_UM, B1_SEGUM, B1_POSIPI "
_cQuery += "UNION ALL "

// Saidas para clientes
_cQuery += "SELECT D2_EMISSAO, D2_CF, ROUND(B1_AXCONC,0) B1_AXCONC,SUM(D2_QTSEGUM) D2_QTSEGUM, D2_DOC, A1_CGC, F2_TRANSP, "
_cQuery += "       ZB_DESC, B1_TIPCONV, B1_CONV,  CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM, SUM(D2_QUANT) D2_QUANT, 'C' AS TIPO, F4_CODOPPF, A1_NOME, B1_AXDENS, ZB_CODPFED, YD_CODPFED, 'PFC' as FLAG, B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD2") + " D2, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA1")
_cQuery += "       A1, " + RetSqlName("SF2") + " F2, " + RetSqlName("SZB") + " ZB, "+RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A1.D_E_L_E_T_ = ' ' AND ZB.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D2_FILIAL = '" + xFilial("SD2") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F2_FILIAL = '" + xFilial("SF2") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' AND "
_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D2_COD = B1_COD AND D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE AND "
_cQuery += "      D2_CLIENTE = A1_COD AND D2_LOJA = A1_LOJA AND B1_AXCTPF = ZB_CODIGO AND D2_TES NOT IN ('522','519','505') AND "
_cQuery += "      Left(D2_EMISSAO,06) = '" + _cAno + _cMes + "' AND B1_AXFEDER = 'S' AND D2_TIPO = 'N' "
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND ROUND(B1_AXCONC,0) > 0 "
_cQuery += "GROUP BY A1_CGC, D2_DOC, D2_EMISSAO, D2_CF, B1_AXCONC, B1_AXDENS, ZB_CODPFED, YD_CODPFED, F2_TRANSP, ZB_DESC, B1_TIPCONV, B1_CONV, ZB_UM, F4_CODOPPF, A1_NOME, B1_UM, B1_SEGUM , B1_POSIPI "
_cQuery += "UNION ALL "

// Saidas para fornecedores (devolucoes e beneficiamentos a fornecedores)
_cQuery += "SELECT D2_EMISSAO, D2_CF, ROUND(B1_AXCONC,0) B1_AXCONC,SUM(D2_QTSEGUM) D2_QTSEGUM, D2_DOC, A2_CGC, F2_TRANSP, "
_cQuery += "       ZB_DESC, B1_TIPCONV, B1_CONV,  CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM,SUM(D2_QUANT) D2_QUANT, 'C' AS TIPO, F4_CODOPPF, A2_NOME, B1_AXDENS, ZB_CODPFED, YD_CODPFED, 'PFC' as FLAG , B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD2") + " D2, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA2")
_cQuery += "       A2, " + RetSqlName("SF2") + " F2, " + RetSqlName("SZB") + " ZB, "+RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A2.D_E_L_E_T_ = ' ' AND ZB.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D2_FILIAL = '" + xFilial("SD2") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F2_FILIAL = '" + xFilial("SF2") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' AND "
_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D2_COD = B1_COD AND D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE AND "
_cQuery += "      D2_CLIENTE = A2_COD AND D2_LOJA = A2_LOJA AND B1_AXCTPF = ZB_CODIGO AND D2_TES NOT IN ('522','519','505') AND "
_cQuery += "      Left(D2_EMISSAO,06) = '" + _cAno + _cMes + "' AND B1_AXFEDER = 'S' AND D2_TIPO IN ('B','D') "
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND ROUND(B1_AXCONC,0) > 0 "
_cQuery += "GROUP BY A2_CGC, D2_DOC, D2_EMISSAO, D2_CF, B1_AXCONC, B1_AXDENS, ZB_CODPFED, YD_CODPFED, F2_TRANSP, ZB_DESC, B1_TIPCONV, B1_CONV, ZB_UM, F4_CODOPPF,A2_NOME, B1_UM, B1_SEGUM, B1_POSIPI "
_cQuery += "UNION ALL "

////////SUBSTANCIA CONTROLADA 
_cQuery	+= "SELECT D1_EMISSAO, D1_CF, ROUND(B1_AXCONC,0) B1_AXCONC, SUM(D1_QTSEGUM) D1_QTSEGUM,D1_DOC,A2_CGC,F1_AXTRANS, "
_cQuery += "  '' as     ZB_DESC,B1_TIPCONV,B1_CONV,CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM,SUM(D1_QUANT) D1_QUANT,'F' AS TIPO, F4_CODOPPF, A2_NOME, B1_AXDENS, '' as ZB_CODPFED, YD_CODPFED, 'PFS' as FLAG, B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD1") + " D1, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA2")
_cQuery += "       A2, " + RetSqlName("SF1") + " F1, " + RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A2.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D1_FILIAL = '" + xFilial("SD1") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F1_FILIAL = '" + xFilial("SF1") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' AND "
//_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D1_COD = B1_COD AND D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND "
_cQuery += "      D1_FORNECE = F1_FORNECE AND D1_LOJA = F1_LOJA AND D1_FORNECE = A2_COD AND "
_cQuery += "      D1_LOJA = A2_LOJA AND Left(D1_EMISSAO,06) = '" + _cAno + _cMes + "' AND "
//_cQuery += "      B1_AXCTPF = ZB_CODIGO AND "
_cQuery += "      D1_TIPO = 'N' "            
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D1_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND B1_AXSUBS = '1' "
_cQuery += "GROUP BY A2_CGC, D1_DOC, D1_EMISSAO, D1_CF, B1_AXCONC, B1_AXDENS,  YD_CODPFED, F1_AXTRANS,  B1_TIPCONV, B1_CONV, F4_CODOPPF,A2_NOME, B1_UM, B1_SEGUM, B1_POSIPI "
_cQuery += "UNION ALL "

// Entradas de clientes (devolucoes e beneficiamentos)
_cQuery	+= "SELECT D1_EMISSAO, D1_CF, ROUND(B1_AXCONC,0) B1_AXCONC, SUM(D1_QTSEGUM) D1_QTSEGUM,D1_DOC, A1_CGC, F1_AXTRANS, "
_cQuery += "    '' as   ZB_DESC, B1_TIPCONV, B1_CONV, CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM, SUM(D1_QUANT) D1_QUANT, 'F' AS TIPO, F4_CODOPPF, A1_NOME, B1_AXDENS, '' as ZB_CODPFED, YD_CODPFED, 'PFS' as FLAG ,B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD1") + " D1, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA1")
_cQuery += "       A1, " + RetSqlName("SF1") + " F1, " +RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D1_FILIAL = '" + xFilial("SD1") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F1_FILIAL = '" + xFilial("SF1") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' AND "
//_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D1_COD = B1_COD AND D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND "
_cQuery += "      D1_FORNECE = F1_FORNECE AND D1_LOJA = F1_LOJA AND D1_FORNECE = A1_COD AND "
_cQuery += "      D1_LOJA = A1_LOJA AND Left(D1_EMISSAO,06) = '" + _cAno + _cMes + "' AND "
//_cQuery += "      B1_AXCTPF = ZB_CODIGO AND "
_cQuery += "      D1_TIPO IN ('D','B') "                                          
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D1_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND B1_AXSUBS = '1' "
_cQuery += "GROUP BY A1_CGC, D1_DOC, D1_EMISSAO, D1_CF, B1_AXCONC, B1_AXDENS, YD_CODPFED, F1_AXTRANS, B1_TIPCONV, B1_CONV, F4_CODOPPF, A1_NOME, B1_UM, B1_SEGUM, B1_POSIPI "
_cQuery += "UNION ALL "

// Saidas para clientes
_cQuery += "SELECT D2_EMISSAO, D2_CF, ROUND(B1_AXCONC,0) B1_AXCONC,SUM(D2_QTSEGUM) D2_QTSEGUM, D2_DOC, A1_CGC, F2_TRANSP, "
_cQuery += "      '' as ZB_DESC, B1_TIPCONV, B1_CONV,  CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM, SUM(D2_QUANT) D2_QUANT, 'C' AS TIPO, F4_CODOPPF, A1_NOME, B1_AXDENS, '' as ZB_CODPFED, YD_CODPFED, 'PFS' as FLAG, B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD2") + " D2, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA1")
_cQuery += "       A1, " + RetSqlName("SF2") + " F2, " +RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D2_FILIAL = '" + xFilial("SD2") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F2_FILIAL = '" + xFilial("SF2") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' AND "
//_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D2_COD = B1_COD AND D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE AND "
_cQuery += "      D2_CLIENTE = A1_COD AND D2_LOJA = A1_LOJA AND D2_TES NOT IN ('522','519','505') AND "
_cQuery += "      Left(D2_EMISSAO,06) = '" + _cAno + _cMes + "' AND D2_TIPO = 'N' "
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND B1_AXSUBS = '1' "
_cQuery += "GROUP BY A1_CGC, D2_DOC, D2_EMISSAO, D2_CF, B1_AXCONC, B1_AXDENS, YD_CODPFED, F2_TRANSP, B1_TIPCONV, B1_CONV, F4_CODOPPF, A1_NOME, B1_UM, B1_SEGUM, B1_POSIPI "
_cQuery += "UNION ALL "

// Saidas para fornecedores (devolucoes e beneficiamentos a fornecedores)
_cQuery += "SELECT D2_EMISSAO, D2_CF, ROUND(B1_AXCONC,0) B1_AXCONC,SUM(D2_QTSEGUM) D2_QTSEGUM, D2_DOC, A2_CGC, F2_TRANSP, "
_cQuery += "      '' as ZB_DESC, B1_TIPCONV, B1_CONV,  CASE WHEN B1_UM = 'L' THEN 'L' WHEN B1_UM = 'KG' THEN 'KG' ELSE B1_SEGUM END AS ZB_UM,SUM(D2_QUANT) D2_QUANT, 'C' AS TIPO, F4_CODOPPF, A2_NOME, B1_AXDENS, '' as ZB_CODPFED, YD_CODPFED, 'PFS' as FLAG , B1_POSIPI "
_cQuery += "FROM " + RetSqlName("SD2") + " D2, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA2")
_cQuery += "       A2, " + RetSqlName("SF2") + " F2, " +RetSqlName("SF4")+ " F4, " +RetSqlName("SYD")+ " YD "
_cQuery += "WHERE D2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A2.D_E_L_E_T_ = ' ' AND "
_cQuery += "      D2_FILIAL = '" + xFilial("SD2") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND "
_cQuery += "      F2_FILIAL = '" + xFilial("SF2") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' AND "
//_cQuery += "      ZB_FILIAL = '" + xFilial("SZB") + "' AND "
_cQuery += "      D2_COD = B1_COD AND D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE AND "
_cQuery += "      D2_CLIENTE = A2_COD AND D2_LOJA = A2_LOJA AND  D2_TES NOT IN ('522','519','505') AND "
_cQuery += "      Left(D2_EMISSAO,06) = '" + _cAno + _cMes + "' AND D2_TIPO IN ('B','D') "
_cQuery += "      AND F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND YD.D_E_L_E_T_ = ' ' AND YD_FILIAL = '" + xFilial("SYD") + "' AND B1_POSIPI = YD_TEC AND B1_AXSUBS = '1' "
_cQuery += "GROUP BY A2_CGC, D2_DOC, D2_EMISSAO, D2_CF, B1_AXCONC, B1_AXDENS, YD_CODPFED, F2_TRANSP, B1_TIPCONV, B1_CONV, F4_CODOPPF,A2_NOME, B1_UM, B1_SEGUM , B1_POSIPI "
_cQuery += "ORDER BY A2_CGC, D1_EMISSAO, D1_DOC "

MemoWrite("\queries\estm0001-1.sql",_cQuery)
_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

//TcSetField("QR1","B1_AXCONC"		,"N",7,2)
TcSetField("QR1","D1_QTSEGUM"		,"N",12,3)
TcSetField("QR1","D1_QUANT"			,"N",12,3)
TcSetField("QR1","B1_AXDENS"		,"N",12,2)
TcSetField("QR1","D1_EMISSAO"       ,"D",8,0)




cIndice := "A2_CGC, DTOS(D1_EMISSAO), D1_DOC"
QR1->(indregua( "QR1" , CriaTrab(Nil,.F.) , cIndice ,,,"Selecionando registros QR1..."))

QR1->(DbGoTop())

lFirst := .T.
cChave := QR1->A2_CGC + DTOS(QR1->D1_EMISSAO) + QR1->D1_DOC

Do While ! QR1->(Eof())

		_nQtdSeg := 0
		If QR1->B1_CONV # 0
			If QR1->B1_TIPCONV == "M"
				_nQtdSeg := QR1->D1_QUANT * QR1->B1_CONV
			ElseIf QR1->B1_TIPCONV == "D"
				_nQtdSeg := QR1->D1_QUANT / QR1->B1_CONV
			EndIf
		EndIF

	If lFirst	
		cEntSai := Iif(	Left(QR1->D1_CF,1) < "5", "E", "S")
		cArmz   := Iif(cEntSai == 'E','N','F')
	
		//IDENTIFICA TIPO DE TRANSPORTE
		If QR1->TIPO == 'F' .Or. (QR1->TIPO == "C" .AND. !Empty(QR1->F1_AXTRANS)) //NESTES CASOS SEMPRE TEM TRANSPORTADORA
			If Posicione("SA4",1,xFilial("SA4")+AllTrim(QR1->F1_AXTRANS),"A4_CGC") == "65838344000110"  //cnpj DA ALPAX - Transporte pelo fornecedor na venda e adquirinte na compra
				cTransp :=  Iif(cEntSai=="S","F","A")
			Else  // Transporte por terceiros
				cTransp := Iif(cEntSai=="S","T", Iif(Posicione("SA4",1,xFilial("SA4")+AllTrim(QR1->F1_AXTRANS),"A4_CGC")==QR1->A2_CGC,"F","T") )
			EndIf
		ElseIf QR1->TIPO == "C"	.AND. Empty(QR1->F1_AXTRANS) //NESTE CASO ษ TRANSPORTADO PELO CLIENTE
			cTransp := "A"
		Endif	
		// SEวรO MOV. NACIONAL DE PRODUTOS QUIMICOS - MVN
		//Set(_SET_DATEFORMAT, 'dd/mm/yyyy')
		_cRegistro	:= "MVN"													// TIPO DO REGISTRO
		_cRegistro  += cEntSai                                                  // ENTRADA / SAIDA 
		_cRegistro  += QR1->F4_CODOPPF                                          // CODIGO DA OPERAวรO - TABELA NO MANUAL DO SIPROQUIM 2 
		_cRegistro	+= QR1->A2_CGC												// CNPJ DO ADQUIRINTE / FORNECEDOR
		_cRegistro	+= QR1->A2_NOME + REPLICATE(" ",69-LEN(QR1->A2_NOME))       // RAZAO SOCIAL ADQUIRINTE / FORNECEDOR                                             	
 	    _cRegistro	+= Alltrim(Str(Val(QR1->D1_DOC))) + Replicate(" ", 10-Len(AllTrim(Str(Val(QR1->D1_DOC)))))		// Nota Fiscal
		_cRegistro	+= DTOC(QR1->D1_EMISSAO)									// DATA EMISSAO NF
		_cRegistro	+= cArmz                                                    // Armazenagem
		_cRegistro	+= cTransp                                                  // transporte (A)dquirinte, (F)ornecedor, (T)erceirizada
		_cRegistro	+= cEOL														// Fim de linha

		If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
			If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
				Return
			Endif
		Endif
	EndIf

	if QR1->D1_DOC = "000102583"
	   MsgAlert(Strzero(QR1->B1_AXCONC/1000,3)) 
	End

	If QR1->FLAG = 'PFS'

		_cRegistro	:= "MM"													              // TIPO DO REGISTRO
		_cRegistro  += "PC"                                                               // IDENTIFICADOR DE PRODUTO   
		_cRegistro	+= Subs(QR1->B1_POSIPI,1,4)+"."+Subs(QR1->B1_POSIPI,5,2)+"."+Subs(QR1->B1_POSIPI,7,2) + Space(01)       	                                          // Cod.Produto na Pol. Federal - Tabela oficial
		_cRegistro	+= Space(03)           	          									  // Concentracao - Manuten็ใo novo lay out Andre R. Esteves 10/10/2019
		_cRegistro	+= StrTran(Strzero(QR1->B1_AXDENS,5,2),".",",")              // DENSIDADE
		_cRegistro	+= StrTran(Strzero(_nQtdSeg,15,3),".",",")					          // Qtde.Produto
		_cRegistro	+= iif(alltrim(QR1->ZB_UM)=="L","L","K")	                  // Unidade Medida
		_cRegistro	+= cEOL											            		  // Fim de linha

	Else

		//SUBSEวรO MOVIMENTO - Substancia Controlada
		_cRegistro	:= "MM"													              // TIPO DO REGISTRO
		_cRegistro  += "PR"                                                               // IDENTIFICADOR DE PRODUTO   
		_cRegistro	+= QR1->ZB_CODPFED       	                                          // Cod.Produto na Pol. Federal - Tabela oficial
		_cRegistro	+= StrTran(Strzero(QR1->B1_AXCONC,03,0),".",",")           	          // Concentracao - Manuten็ใo novo lay out Andre R. Esteves 10/10/2019
		_cRegistro	+= StrTran(Strzero(QR1->B1_AXDENS,5,2),".",",")                       // DENSIDADE
		_cRegistro	+= StrTran(Strzero(_nQtdSeg,15,3),".",",")					          // Qtde.Produto
		_cRegistro	+= iif(alltrim(QR1->ZB_UM)=="L","L","K")	                          // Unidade Medida
		_cRegistro	+= cEOL											            		  // Fim de linha

	EndIf 

	If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
		If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
			Return
		Endif
	Endif

	If lFirst
		//SUBSEวรO TRANSPORTE - MT - SOMENTE PARA TRANSPORTE = T
		If cTransp == "T"	
		
			_cNomeTrans := Posicione("SA4",1,xFilial("SA4")+QR1->F1_AXTRANS,"A4_NOME")

			_cRegisTrans	:= "MT"													                // TIPO DO REGISTRO
			_cRegisTrans	+= Left(Posicione("SA4",1,xFilial("SA4")+QR1->F1_AXTRANS,"A4_CGC"),14)  // CNPJ TRANSP
			_cRegisTrans    +=  _cNomeTrans + REPLICATE(" ",70-LEN(_cNomeTrans))                    // RAZAO SOCIAL TRANSPORTADORA
			_cRegisTrans	+= cEOL														            // Fim de linha

		EndIf
		//SUBSEวรO ARMAZENAGEM - MA - SOMENTE PARA NOTAS DE SAIDA
		If cEntSai == "S"

			dbSelectArea("SA1")
			DbSetOrder(3)
			DbSeek(xFilial("SA1") + QR1->A2_CGC)
			
			_cEndArm    := SA1->A1_XEND                            //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_XEND")
			_cCEPArm    := Transform(SA1->A1_CEP,"@R 99.999-999")  //Transform(Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_CEP"),"@R 99.999-999")
			_cNumArm    := SA1->A1_XNUM                            //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_XNUM")
			_cComplArm  := SA1->A1_COMPLEM                         //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_COMPLEM")
			_cBairroArm := SA1->A1_BAIRRO                          //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_BAIRRO")
			_cUFArm     := SA1->A1_EST                             //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_EST")
			_cCdIBGEArm := SA1->A1_COD_MUN                         //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_COD_MUN")

			dbSelectArea("CC2")
			DbSetOrder(1)
			DbSeek(xFilial("CC2")+_cUFArm+_cCdIBGEArm)

			_cCdIBGEArm := CC2->CC2_XCODUF + _cCdIBGEArm                         //Posicione("CC2",1,xFilial("CC2")+_cUFArm+_cCdIBGEArm,"CC2_XCODUF") + _cCdIBGEArm

			_cRegisArm	:= "MA"													                // TIPO DO REGISTRO
			_cRegisArm	+= QR1->A2_CGC												            // CNPJ DO ADQUIRINTE 
			_cRegisArm	+= QR1->A2_NOME + REPLICATE(" ",70-LEN(QR1->A2_NOME))                   // RAZAO SOCIAL ADQUIRINTE 
			_cRegisArm	+= _cEndArm + REPLICATE(" ",70-LEN(_cEndArm))                           // ENDEREวO DE ARMAZENAGEM
			_cRegisArm	+= _cCEPArm                                                             // CEP ARMAZENAGEM
			_cRegisArm	+= Substr(_cNumArm,1,5)                                                 // NUMERO DO ENDEREวO ARMAZENAGEM
			_cRegisArm	+= Substr(_cComplArm,1,20)                                              // COMPLEMENTO DO ENDEREวO ARMAZENAGEM
			_cRegisArm	+= Substr(_cBairroArm,1,30)                                             // BAIRRO DO ENDEREวO ARMAZENAGEM
			_cRegisArm	+= _cUFArm                                                              // UF DO ENDEREวO ARMAZENAGEM
			_cRegisArm  += _cCdIBGEArm                                                          // COD IBGE MUNICIPIO ARMAZENAGEM
			_cRegisArm	+= cEOL	

			SA1->(DbCloseArea())
			CC2->(DbCloseArea())
		EndIf 
	EndIf

	QR1->(DbSkip())

	If cChave == QR1->A2_CGC + DTOS(QR1->D1_EMISSAO) + QR1->D1_DOC
		lFirst := .F.
	Else
		lFirst := .T.
		cChave := QR1->A2_CGC + DTOS(QR1->D1_EMISSAO) + QR1->D1_DOC
		//GRAVA DADOS DA TRANSPORTADORA	
		If cTransp == "T"
			If fWrite(nHdl,_cRegisTrans,Len(_cRegisTrans)) != Len(_cRegisTrans) 
				If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
					Return
				Endif
			Endif
		EndIf
		//GRAVA DADOS DE ARMAZENAGEM
		If cEntSai == "S"
			If fWrite(nHdl,_cRegisArm,Len(_cRegisArm)) != Len(_cRegisArm) 
				If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
					Return
				Endif
			Endif
		EndIf
	EndIf	
EndDo

QR1->(DbCloseArea())

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGeraSub บAutor  ณ                                         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para geracao do arquivo de movimentacao (Notas Fis  บฑฑ
ฑฑบ          ณ cais de entradas e saidas ).                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fGeraSub()


Local cAliasMSub 	:= GetNextAlias()
Local nCount 		:= 0

_cPeriodo := _cAno + _cMes

BeginSql Alias cAliasMSub


		SELECT DISTINCT 
		D1_COD, D1_EMISSAO, D1_QTSEGUM, D1_DOC, A2_CGC, A2_NOME, F1_AXTRANS, B1_TIPCONV, B1_CONV, 'F' TIPO,
		F4_CODOPPF, B1_UM, B1_AXDENS, D1_CF, D1_QUANT, B1_POSIPI
		FROM 
		%Table:SD1% SD1 (NOLOCK) 
		INNER JOIN %Table:ZA9% ZA9 (NOLOCK) ON ZA9_COD = D1_COD 
		INNER JOIN %Table:SB1% SB1 (NOLOCK) ON D1_COD = B1_COD 
		INNER JOIN %Table:SF4% SF4 (NOLOCK) ON F4_CODIGO = D1_TES 
		INNER JOIN %Table:SA2% SA2 (NOLOCK) ON A2_COD = D1_FORNECE AND A2_LOJA = D1_LOJA 
		INNER JOIN %Table:SF1% SF1 (NOLOCK) ON D1_FILIAL = F1_FILIAL AND D1_DOC = F1_DOC AND D1_FORNECE = F1_FORNECE AND F1_LOJA = D1_LOJA AND D1_EMISSAO = F1_EMISSAO 
		WHERE  
		LEFT(SD1.D1_EMISSAO,6) = %Exp:_cPeriodo% AND
		D1_TIPO = 'N' AND SB1.B1_MSBLQL <> '1' AND D1_TES NOT IN ('522','519','505') AND 
		F4_ESTOQUE = 'S' AND 
		SD1.%NotDel% AND SF4.%NotDel% AND SB1.%NotDel% AND ZA9.%NotDel% AND SA2.%NotDel% 
		GROUP BY D1_COD, B1_UM, D1_CF, B1_AXDENS, D1_EMISSAO, D1_QTSEGUM,B1_POSIPI,
		D1_DOC, A2_CGC, A2_NOME, F4_CODOPPF, F1_AXTRANS , B1_TIPCONV, B1_CONV, D1_QUANT 

		UNION ALL

		SELECT DISTINCT 
		D1_COD, D1_EMISSAO, D1_QTSEGUM, D1_DOC, A1_CGC, A1_NOME, F1_AXTRANS, B1_TIPCONV, B1_CONV,  'F' TIPO,
		F4_CODOPPF, B1_UM, B1_AXDENS, D1_CF, D1_QUANT, B1_POSIPI
		FROM 
		%Table:SD1% SD1 (NOLOCK) 
		INNER JOIN %Table:ZA9% ZA9 (NOLOCK) ON ZA9_COD = D1_COD 
		INNER JOIN %Table:SB1% SB1 (NOLOCK) ON D1_COD = B1_COD 
		INNER JOIN %Table:SF4% SF4 (NOLOCK) ON F4_CODIGO = D1_TES 
		INNER JOIN %Table:SA1% SA1 (NOLOCK) ON A1_COD = D1_FORNECE AND A1_LOJA = D1_LOJA 
		INNER JOIN %Table:SF1% SF1 (NOLOCK) ON D1_FILIAL = F1_FILIAL AND D1_DOC = F1_DOC AND D1_FORNECE = F1_FORNECE AND F1_LOJA = D1_LOJA AND D1_EMISSAO = F1_EMISSAO 
		WHERE  
		LEFT(SD1.D1_EMISSAO,6) =  %Exp:_cPeriodo% AND
		D1_TIPO IN ('D', 'B') AND 
		SB1.B1_MSBLQL <> '1' AND D1_TES NOT IN ('522','519','505') AND 
		F4_ESTOQUE = 'S' AND 
		SD1.%NotDel% AND SF4.%NotDel% AND SB1.%NotDel% AND ZA9.%NotDel% AND SA1.%NotDel% 
		GROUP BY D1_COD, B1_UM, D1_CF, B1_AXDENS, D1_EMISSAO, D1_QTSEGUM,B1_POSIPI,
		D1_DOC, A1_CGC, A1_NOME, F4_CODOPPF, F1_AXTRANS , B1_TIPCONV, B1_CONV, D1_QUANT 

		UNION ALL

		SELECT DISTINCT 
		D2_COD, D2_EMISSAO, D2_QTSEGUM, D2_DOC,  A1_CGC, A1_NOME, F2_TRANSP, B1_TIPCONV, B1_CONV, 'C' TIPO,
		F4_CODOPPF, B1_UM, B1_AXDENS, D2_CF, D2_QUANT, B1_POSIPI
		FROM 
		%Table:SD2% SD2 (NOLOCK) INNER JOIN ZA9010 ZA9 (NOLOCK) ON ZA9_COD = D2_COD 
		INNER JOIN %Table:SB1% SB1 (NOLOCK) ON D2_COD = B1_COD 
		INNER JOIN %Table:SF4% SF4 (NOLOCK) ON F4_CODIGO = D2_TES 
		INNER JOIN %Table:SA1% SA1 (NOLOCK) ON A1_COD = D2_CLIENTE AND A1_LOJA = D2_LOJA 
		INNER JOIN %Table:SF2% SF2 (NOLOCK) ON D2_FILIAL = F2_FILIAL AND D2_DOC = F2_DOC AND F2_CLIENTE = D2_CLIENTE AND F2_LOJA = D2_LOJA AND D2_EMISSAO = F2_EMISSAO 
		WHERE  
		LEFT(SD2.D2_EMISSAO,6) = %Exp:_cPeriodo% AND
		D2_TIPO = 'N' AND 
		SB1.B1_MSBLQL <> '1' AND D2_TES NOT IN ('522','519','505') AND 
		F4_ESTOQUE = 'S' AND 
		SD2.%NotDel% AND SF4.%NotDel% AND SB1.%NotDel% AND ZA9.%NotDel% AND SA1.%NotDel%
		GROUP BY D2_COD, B1_UM, D2_CF, B1_AXDENS, D2_EMISSAO, D2_QTSEGUM,B1_POSIPI,
		D2_DOC, A1_CGC, A1_NOME, F4_CODOPPF, F2_TRANSP, B1_TIPCONV, B1_CONV, D2_QUANT 

		UNION ALL

		SELECT DISTINCT 
		D2_COD, D2_EMISSAO,	D2_QTSEGUM, D2_DOC, A2_CGC, A2_NOME, F2_TRANSP, B1_TIPCONV, B1_CONV, 'C' TIPO,
		F4_CODOPPF, B1_UM, B1_AXDENS, D2_CF, D2_QUANT, B1_POSIPI  
		FROM 
		%Table:SD2% SD2 (NOLOCK) INNER JOIN ZA9010 ZA9 (NOLOCK) ON ZA9_COD = D2_COD 
		INNER JOIN %Table:SB1% SB1 (NOLOCK) ON D2_COD = B1_COD 
		INNER JOIN %Table:SF4% SF4 (NOLOCK) ON F4_CODIGO = D2_TES 
		INNER JOIN %Table:SA2% SA2 (NOLOCK) ON A2_COD = D2_CLIENTE AND A2_LOJA = D2_LOJA 
		INNER JOIN %Table:SF2% SF2 (NOLOCK) ON D2_FILIAL = F2_FILIAL AND D2_DOC = F2_DOC AND F2_CLIENTE = D2_CLIENTE AND F2_LOJA = D2_LOJA AND D2_EMISSAO = F2_EMISSAO 
		WHERE  
		LEFT(SD2.D2_EMISSAO,6) = %Exp:_cPeriodo% AND
		D2_TIPO IN ('D','B') AND 
		SB1.B1_MSBLQL <> '1' AND D2_TES NOT IN ('522','519','505') AND 
		F4_ESTOQUE = 'S' AND SD2.D_E_L_E_T_= ' ' AND 
		SF4.D_E_L_E_T_= ' ' AND SB1.D_E_L_E_T_= ' ' AND ZA9.D_E_L_E_T_= ' ' AND SA2.D_E_L_E_T_ = ''
		GROUP BY D2_COD, B1_UM, D2_CF, B1_AXDENS, D2_EMISSAO, D2_QTSEGUM,B1_POSIPI,
		D2_DOC, A2_CGC, A2_NOME, F4_CODOPPF, F2_TRANSP, B1_TIPCONV, B1_CONV, D2_QUANT 
		ORDER BY  2, 3 ASC

Endsql 

aSql := GetLastQuery()
cSql := aSql[2]
MemoWrite("\queries\estm001_msub.sql",cSql)

(cAliasMSub)->(dbEval({|| nCount++},,{|| !EOF()}))
(cAliasMSub)->(DbGoTop())

lFirst := .T.
cChave := (cAliasMSub)->A2_CGC + (cAliasMSub)->D1_EMISSAO + (cAliasMSub)->D1_DOC

Do While ! (cAliasMSub)->(Eof())

		_nQtdSeg := 0
		If (cAliasMSub)->B1_CONV # 0
			If (cAliasMSub)->B1_TIPCONV == "M"
				_nQtdSeg := (cAliasMSub)->D1_QUANT * (cAliasMSub)->B1_CONV
			ElseIf (cAliasMSub)->B1_TIPCONV == "D"
				_nQtdSeg := (cAliasMSub)->D1_QUANT / (cAliasMSub)->B1_CONV
			EndIf
		EndIF

	If lFirst	
		cEntSai := Iif(	Left((cAliasMSub)->D1_CF,1) < "5", "E", "S")
		cArmz   := Iif(cEntSai == 'E','N','F')
	
		//IDENTIFICA TIPO DE TRANSPORTE
		If (cAliasMSub)->TIPO == 'F' .Or. ((cAliasMSub)->TIPO == "C" .AND. !Empty((cAliasMSub)->F1_AXTRANS)) //NESTES CASOS SEMPRE TEM TRANSPORTADORA
			If Posicione("SA4",1,xFilial("SA4")+AllTrim((cAliasMSub)->F1_AXTRANS),"A4_CGC") == "65838344000110"  //cnpj DA ALPAX - Transporte pelo fornecedor na venda e adquirinte na compra
				cTransp :=  Iif(cEntSai=="S","F","A")
			Else  // Transporte por terceiros
				cTransp := Iif(cEntSai=="S","T", Iif(Posicione("SA4",1,xFilial("SA4")+AllTrim((cAliasMSub)->F1_AXTRANS),"A4_CGC")==(cAliasMSub)->A2_CGC,"F","T") )
			EndIf
		ElseIf (cAliasMSub)->TIPO == "C"	.AND. Empty((cAliasMSub)->F1_AXTRANS) //NESTE CASO ษ TRANSPORTADO PELO CLIENTE
			cTransp := "A"
		Endif	
		// SEวรO MOV. NACIONAL DE PRODUTOS QUIMICOS - MVN
		//Set(_SET_DATEFORMAT, 'dd/mm/yyyy')
		_cRegistro	:= "MVN"																					// TIPO DO REGISTRO
		_cRegistro  += cEntSai                                          								        // ENTRADA / SAIDA 
		_cRegistro  += (cAliasMSub)->F4_CODOPPF                                 								// CODIGO DA OPERAวรO - TABELA NO MANUAL DO SIPROQUIM 2 
		_cRegistro	+= (cAliasMSub)->A2_CGC																		// CNPJ DO ADQUIRINTE / FORNECEDOR
		_cRegistro	+= (cAliasMSub)->A2_NOME + REPLICATE(" ",69-LEN((cAliasMSub)->A2_NOME))       				// RAZAO SOCIAL ADQUIRINTE / FORNECEDOR                                             	
 	    _cRegistro	+= Alltrim(Str(Val((cAliasMSub)->D1_DOC))) + Replicate(" ", 10-Len(AllTrim(Str(Val((cAliasMSub)->D1_DOC)))))		// Nota Fiscal
		_cRegistro	+= DTOC(STOD((cAliasMSub)->D1_EMISSAO))															// DATA EMISSAO NF
		_cRegistro	+= cArmz                                                    								// Armazenagem
		_cRegistro	+= cTransp                                                  								// transporte (A)dquirinte, (F)ornecedor, (T)erceirizada
		_cRegistro	+= cEOL																						// Fim de linha

		If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
			If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
				Return
			Endif
		Endif
	EndIf

	if (cAliasMSub)->D1_DOC = "000102583"
	   MsgAlert(Strzero((cAliasMSub)->B1_AXCONC/1000,3)) 
	End
	//SUBSEวรO MOVIMENTO - MM
	_cRegistro	:= "MM"													              // TIPO DO REGISTRO
	_cRegistro  += "PC"                                                               // IDENTIFICADOR DE PRODUTO   
	_cRegistro	+= Subs((cAliasMSub)->B1_POSIPI,1,4)+"."+Subs((cAliasMSub)->B1_POSIPI,5,2)+"."+Subs((cAliasMSub)->B1_POSIPI,7,2) + Space(01)       	                                          // Cod.Produto na Pol. Federal - Tabela oficial
	_cRegistro	+= Space(03)           	          									  // Concentracao - Manuten็ใo novo lay out Andre R. Esteves 10/10/2019
	_cRegistro	+= StrTran(Strzero((cAliasMSub)->B1_AXDENS,5,2),".",",")              // DENSIDADE
	_cRegistro	+= StrTran(Strzero(_nQtdSeg,15,3),".",",")					          // Qtde.Produto
	_cRegistro	+= iif(alltrim((cAliasMSub)->B1_UM)=="L","L","K")	                  // Unidade Medida
	_cRegistro	+= cEOL											            		  // Fim de linha

	If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
		If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
			Return
		Endif
	Endif

	If lFirst
		//SUBSEวรO TRANSPORTE - MT - SOMENTE PARA TRANSPORTE = T
		If cTransp == "T"	
		
			_cNomeTrans := Posicione("SA4",1,xFilial("SA4")+(cAliasMSub)->F1_AXTRANS,"A4_NOME")

			_cRegisTrans	:= "MT"													                // TIPO DO REGISTRO
			_cRegisTrans	+= Left(Posicione("SA4",1,xFilial("SA4")+(cAliasMSub)->F1_AXTRANS,"A4_CGC"),14)  // CNPJ TRANSP
			_cRegisTrans    +=  _cNomeTrans + REPLICATE(" ",70-LEN(_cNomeTrans))                    // RAZAO SOCIAL TRANSPORTADORA
			_cRegisTrans	+= cEOL														            // Fim de linha

		EndIf
		//SUBSEวรO ARMAZENAGEM - MA - SOMENTE PARA NOTAS DE SAIDA
		If cEntSai == "S"

			dbSelectArea("SA1")
			DbSetOrder(3)
			DbSeek(xFilial("SA1") + (cAliasMSub)->A2_CGC)
			
			_cEndArm    := SA1->A1_XEND                            //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_XEND")
			_cCEPArm    := Transform(SA1->A1_CEP,"@R 99.999-999")  //Transform(Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_CEP"),"@R 99.999-999")
			_cNumArm    := SA1->A1_XNUM                            //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_XNUM")
			_cComplArm  := SA1->A1_COMPLEM                         //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_COMPLEM")
			_cBairroArm := SA1->A1_BAIRRO                          //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_BAIRRO")
			_cUFArm     := SA1->A1_EST                             //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_EST")
			_cCdIBGEArm := SA1->A1_COD_MUN                         //Posicione("SA2",3,xFilial("SA2")+QR1->A2_CGC,"A2_COD_MUN")

			dbSelectArea("CC2")
			DbSetOrder(1)
			DbSeek(xFilial("CC2")+_cUFArm+_cCdIBGEArm)

			_cCdIBGEArm := CC2->CC2_XCODUF + _cCdIBGEArm                         //Posicione("CC2",1,xFilial("CC2")+_cUFArm+_cCdIBGEArm,"CC2_XCODUF") + _cCdIBGEArm

			_cRegisArm	:= "MA"													                // TIPO DO REGISTRO
			_cRegisArm	+= (cAliasMSub)->A2_CGC												            // CNPJ DO ADQUIRINTE 
			_cRegisArm	+= (cAliasMSub)->A2_NOME + REPLICATE(" ",70-LEN((cAliasMSub)->A2_NOME))                   // RAZAO SOCIAL ADQUIRINTE 
			_cRegisArm	+= _cEndArm + REPLICATE(" ",70-LEN(_cEndArm))                           // ENDEREวO DE ARMAZENAGEM
			_cRegisArm	+= _cCEPArm                                                             // CEP ARMAZENAGEM
			_cRegisArm	+= Substr(_cNumArm,1,5)                                                 // NUMERO DO ENDEREวO ARMAZENAGEM
			_cRegisArm	+= Substr(_cComplArm,1,20)                                              // COMPLEMENTO DO ENDEREวO ARMAZENAGEM
			_cRegisArm	+= Substr(_cBairroArm,1,30)                                             // BAIRRO DO ENDEREวO ARMAZENAGEM
			_cRegisArm	+= _cUFArm                                                              // UF DO ENDEREวO ARMAZENAGEM
			_cRegisArm  += _cCdIBGEArm                                                          // COD IBGE MUNICIPIO ARMAZENAGEM
			_cRegisArm	+= cEOL	

			SA1->(DbCloseArea())
			CC2->(DbCloseArea())
		EndIf 
	EndIf

	(cAliasMSub)->(DbSkip())

	If cChave == (cAliasMSub)->A2_CGC + (cAliasMSub)->D1_EMISSAO + (cAliasMSub)->D1_DOC
		lFirst := .F.
	Else
		lFirst := .T.
		cChave := (cAliasMSub)->A2_CGC + (cAliasMSub)->D1_EMISSAO + (cAliasMSub)->D1_DOC
		//GRAVA DADOS DA TRANSPORTADORA	
		If cTransp == "T"
			If fWrite(nHdl,_cRegisTrans,Len(_cRegisTrans)) != Len(_cRegisTrans) 
				If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
					Return
				Endif
			Endif
		EndIf
		//GRAVA DADOS DE ARMAZENAGEM
		If cEntSai == "S"
			If fWrite(nHdl,_cRegisArm,Len(_cRegisArm)) != Len(_cRegisArm) 
				If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
					Return
				Endif
			Endif
		EndIf
	EndIf	
EndDo

(cAliasMSub)->(DbCloseArea())

Return
