#Include "protheus.ch"
#Include "topconn.ch"
                      
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR010   บAutor  ณAdriano Luis Brandaoบ Data ณ  30/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para tela da impressao da FISPQ.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ     
*/        
User Function FATR010()

Private _cQuery
Private _cArqTmp           
Private cCadastro := "Impresssao da Ficha de Emergencia."
Private aSize, aInfo, aPosObj
Private cMarca 	:= GetMark()
Private lInverte	:= .F.
                                                                                                                                                            

MsgRun("Aguarde selecionando registro .....",,{ || fSelec()	})

_aBrowse := {	{"OK"			,"", "OK"					},;
{"F2_SERIE"			,"", "Serie"							},;
{"F2_DOC"			,"", "Nota Fiscal" 						},;
{"F2_EMISSAO"		,"", "Emissao"							},;
{"A1_NOME"			,"", "Cliente"							}	}

aSize := MsAdvSize()
_lImprime := .f.
aObjects := {}
AAdd( aObjects, { 100, 010 , .T., .F. } )
AAdd( aObjects, { 100, 090 , .T., .T. } )
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5, 5 }
aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)

TMP->(DbGoTop())

DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

oMark:= MsSelect():New("TMP","OK",,_aBrowse,@lInverte,@cMarca,{aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4]})

oMark:oBrowse:lhasMark := .t.
oMark:oBrowse:lCanAllmark := .t.
//oMark:oBrowse:bAllMark := {|| fInverte(cMarca,@oMark)}

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| iif(fConf010(),(_lImprime := .t.,oDlg:End()),oDlg:End()) },{||oDlg:End()},,)

If _lImprime
	fImpr010()
EndIf

TMP->(DbCloseArea())

Ferase(_cArqTmp+".DBF")

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR010   บAutor  ณAdriano Luis Brandaoบ Data ณ  30/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para montagem da tela de dados.                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
Static Function fSelec()

_cQuery := "SELECT DISTINCT F2_SERIE, F2_DOC, F2_EMISSAO, A1_NOME "
_cQuery += "       FROM " + RetSqlName("SF2") + " F2 "
_cQuery += "            INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "                    ON A1_FILIAL = '" + xFilial("SA1") + "' AND F2_CLIENTE = A1_COD AND F2_LOJA = A1_LOJA "
_cQuery += "            INNER JOIN " + RetSqlName("SD2") + " D2 "
_cQuery += "                    ON D2_FILIAL = '" + xFilial("SD2") + "' AND F2_SERIE = D2_SERIE AND F2_DOC = D2_DOC "
_cQuery += "            INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                    ON B1_FILIAL = '" + xFilial("SB1") + "' AND D2_COD = B1_COD "
_cQuery += "       WHERE F2_FILIAL = '" + xFilial("SF2") + "' AND F2_TIPO = 'N' "
_cQuery += "             AND F2.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND D2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "             AND F2_AXIMPFE = ' ' AND B1_AXFISPQ <> ' ' "

TcQuery _cQuery New Alias "QR1"

TcSetfield("QR1","F2_EMISSAO","D",8,0)

_aCampos := QR1->(DbStruct())
aAdd(_aCampos,{"OK","C",2,0})

_cArqTmp := Criatrab(_acampos,.t.)
DbUseArea(.t.,,_cArqTmp,"TMP",.f.,.f.)

QR1->(DbGotop())

Do While ! QR1->(Eof())
	RecLock("TMP",.t.)
	For _nY := 1 to LEN(_aCampos)
		If _aCampos[_nY,1] <> "OK"
			TMP->&(_aCampos[_nY,1]) := QR1->&(_aCampos[_nY,1])
		EndIf
	Next _nY
	TMP->(MsUnLock())

	QR1->(Dbskip())
EndDo

QR1->(DbCloseArea())


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfConf010  บAutor  ณAdriano Luis Brandaoบ Data ณ  30/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de confirmacao de impressao.                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fConf010()

local lRet := .t.

If ! ApMsgYesNo("Confirma a impressao das fichas das Nfs. selecionadas ??","Confirmar")
	lRet := .f.
EndIf

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImpr010  บAutor  ณAdriano Luis Brandaoบ Data ณ  30/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento para a chamada de impressao.                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function fImpr010()

Local _aFichas := {}

SD2->(DbSetOrder(3))
TMP->(DbGoTop())

Do While ! TMP->(Eof())
	If TMP->OK == cMarca
		SD2->(DbSeek(xFilial("SD2")+TMP->F2_DOC   ))
		_cQuery := " SELECT DISTINCT D2_SERIE, D2_DOC, B1_AXFISPQ "         
		_cQuery += " FROM " + RetSqlName("SD2") + " D2 "
		_cQuery += "      INNER JOIN " + RetSqlName("SB1") + " B1 "
		_cQuery += "              ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = D2_COD "
		_cQuery += "      WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND D2_SERIE = '" + TMP->F2_SERIE + "' "
		_cQuery += "            AND D2_DOC = '" + TMP->F2_DOC + "' AND B1_AXFISPQ <> ' ' "
		
		TcQuery _cQuery New Alias "QR1"

		Do While ! QR1->(Eof())
			aAdd(_aFichas,{QR1->B1_AXFISPQ, QR1->D2_SERIE, QR1->D2_DOC})
			QR1->(DbSkip())
		EndDo
		QR1->(DbCloseArea())
	EndIf
	TMP->(DbSkip())
EndDo
If Len(_aFichas) > 0
	fImprime(_aFichas)
EndIf

Return                


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR010AUTบAutor  ณAdriano Luis Brandaoบ Data ณ  22/09/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao acionada no final da impressao da      บฑฑ
ฑฑบ          ณ nota fiscal.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FATR010AUT(_cNFDE,_cNFATE,_cSerie)

Local _cQuery
Local _aFichas := {}

_cQuery := " SELECT DISTINCT D2_SERIE, D2_DOC, B1_AXFISPQ "
_cQuery += " FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "      INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "              ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = D2_COD "
_cQuery += "      WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND D2_SERIE = '" + _cSerie + "' "
_cQuery += "            AND D2_DOC BETWEEN '" + _cNFDE + "' AND '" + _cNFATE + "' AND B1_AXFISPQ <> ' ' "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())
	aAdd(_aFichas,{QR1->B1_AXFISPQ, QR1->D2_SERIE, QR1->D2_DOC})
	QR1->(DbSkip())
EndDo
QR1->(DbCloseArea())

If Len(_aFichas) > 0
	fImprime(_aFichas)
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImprime  บAutor  ณAdriano Luis Brandaoบ Data ณ  09/07/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ funcao de impressao da ficha de emergencia.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/ 
Static Function fImprime(_aItens)

Private nRow1 	:= 0050
Private nColIni := 0100
Private nColFim := 2300
Private nRowFim := 3250   

Private oArial8N	:= TFont():New("Arial",9,8,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCourier11	:= TFont():New("Courier New",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial10N	:= TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial12N	:= TFont():New("Arial",9,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial14N	:= TFont():New("Arial",9,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial16N	:= TFont():New("Arial",9,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial20N	:= TFont():New("Arial",9,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial21N	:= TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial26N 	:= TFont():New("Arial",9,26,.T.,.T.,5,.T.,5,.T.,.F.)
Private oTreb12N	:= TFont():New("Trebuchet MS",9,12,.T.,.T.,5,.T.,5,.T.,.F.)

If Len(_aItens) > 0
	oPrint:= TMSPrinter():New( "Imprimindo Ficha emergencia" )
	oPrint:SetPortrait() // ou SetLandscape()
EndIf

_lImprimiu := .f.
SF2->(DbSetOrder(1))
SZL->(DbSetOrder(1))
For _nY := 1 to Len(_aItens)

	_lImprimiu := .t.

	oPrint:StartPage() 		// Inicia uma nova pagina
	oPrint:SayBitmap(0150,0150,"\system\logo_alpax.bmp",600,170)
	_nLinIni := nRow1+0050 
	oPrint:Say(_nLinIni		,0900			,"FICHA DE EMERGENCIA"							,oArial16N )      
	_nLinIni += 0100
    SZL->(DbSeek(xFilial("SZL")+_aItens[_nY,1]))
    
    _cEnd 		:= ALLTRIM(SM0->M0_ENDCOB)+" - " +Alltrim(SM0->M0_BAIRCOB)+" - " +Alltrim(SM0->M0_CIDCOB)
    _cCompEnd   := SM0->M0_ESTCOB+"- CEP:"+Transform(SM0->M0_CEPCOB,"@R 99999-999")
    _cRisco		:= Posicione("SX5",1,xFilial("SX5")+"Z1"+SZL->ZL_RISCO,"X5_DESCRI")
	// cabecalho da ficha de emergencia.    
	oPrint:Say(_nLinIni		,1100			,"NOME DO PRODUTO"								,oArial12N )      
	oPrint:Say(_nLinIni+0050,1100			,SZL->ZL_2SUBST									,oArial12N )
	oPrint:Say(_nLinIni+0100,1100			,SZL->ZL_2GENER									,oArial12N )
                                        	
	oPrint:Say(_nLinIni+0150,0100			,_cEnd											,oArial10N )
	oPrint:Say(_nLinIni+0200,0100			,_cCompEnd										,oArial10N )
	oPrint:Say(_nLinIni+0250,0100			,"Tel: (11) 4057 9200  Fax: (11) 4057 9204"		,oArial10N )
	oPrint:Say(_nLinIni+0300,0100			,"www.alpax.com.br  -  alpax@alpax.com.br"		,oArial10N )

	oPrint:Say(_nLinIni+0150,1800			,"N๚mero de risco:"	+SZL->ZL_NRRISCO			,oArial10N )
	oPrint:Say(_nLinIni+0200,1800			,"N๚mero da ONU:"	+SZL->ZL_ONU				,oArial10N )
	oPrint:Say(_nLinIni+0250,1800			,"Classe de risco:"	+SZL->ZL_RISCO				,oArial10N )	
	oPrint:Say(_nLinIni+0300,1800			,"Descricao da Classe ou"						,oArial10N )		
	oPrint:Say(_nLinIni+0350,1800			,"SubClasse: " + _cRisco						,oArial10N )		
	_nLinIni+= 0550
	oPrint:Line(_nLinIni,nColIni,_nLinIni,nColFim) 
	// Aspectos.                              
	_cAspecto := Alltrim(SZL->ZL_9ESTFIS)+" "+Alltrim(SZL->ZL_9ODOR)+" "+Alltrim(SZL->ZL_9SOLUBI)
	oPrint:Say(_nLinIni+0050,nColIni		,"Aspecto: " 									,oArial12N )			
	oPrint:Say(_nLinIni+0050,nColIni+0400	,_cAspecto										,oArial10N )			
	oPrint:Line(_nLinIni+0100,nColIni,_nLinIni+0100,nColFim)
	_nLinIni+= 0150
	_cEPI1 	:= Alltrim(SZL->ZL_8EPIRES)+","+Alltrim(SZL->ZL_8EPIMAO)+"."
	_cEPI2	:= Alltrim(SZL->ZL_8EPIOLH)+","+Alltrim(SZL->ZL_8EPIPEL)+"."
	
	oPrint:Say(_nLinIni,nColIni				,"EPI:"											,oArial12N )				 	
	oPrint:Say(_nLinIni,nColIni+0400		,_cEPI1											,oArial10N )				 		
	oPrint:Say(_nLinIni+0050,nColIni+0400	,_cEPI2											,oArial10N )				 		
	oPrint:Line(_nLinIni+0100,nColIni,_nLinIni+0100,nColFim)	
	_nLinIni+=150       
	oPrint:Say(_nLinIni+0010,nColIni+1000	,"RISCOS"										,oArial12N )				 			
	oPrint:Say(_nLinIni+0100,nColIni		,"Fogo:"										,oArial12N )				 				
	oPrint:Say(_nLinIni+0100,nColIni+0400	,Alltrim(SZL->ZL_9ESTFIS)+" "+Alltrim(SZL->ZL_9PONFUL)	,oArial10N )				 						
	oPrint:Say(_nLinIni+0200,nColIni		,"Sa๚de:"										,oArial12N )				 				
	oPrint:Say(_nLinIni+0200,nColIni+0400	,Alltrim(SZL->ZL_4ACOES)						,oArial10N )				 						
	oPrint:Say(_nLinIni+0300,nColIni		,"Meio Ambiente:"								,oArial12N )				 						
	oPrint:Say(_nLinIni+0300,nColIni+0400	,Alltrim(SZL->ZL_CIMPAMB)						,oArial10N )				 							
	_nLinIni+= 0400
	oPrint:Line(_nLinIni,nColIni,_nLinIni,nColFim)	
	oPrint:Say(_nLinIni+0050,nColIni+0700	,"EM CASO DE ACIDENTES"							,oArial12N )				 								
	oPrint:Line(_nLinIni+0100,nColIni,_nLinIni+0100,nColFim)	
	_nLinIni+=0150
	oPrint:Say(_nLinIni,nColIni				,"VAZAMENTOS: "									, oArial12N)
	oPrint:Say(_nLinIni,nColIni+0400		, SZL->ZL_6CONPOE								, oArial10N)
	oPrint:Say(_nLinIni+0050,nColIni+0400	, SZL->ZL_6PRECON								, oArial10N)
	oPrint:Say(_nLinIni+0100,nColIni+0400	, SZL->ZL_6SISALA								, oArial10N)
	oPrint:Say(_nLinIni+0150,nColIni+0400	, SZL->ZL_6RECUPE								, oArial10N)
	oPrint:Say(_nLinIni+0200,nColIni+0400	, SZL->ZL_6NEUTRA								, oArial10N)
	oPrint:Say(_nLinIni+0250,nColIni+0400	, SZL->ZL_6DISPOS								, oArial10N)
	oPrint:Say(_nLinIni+0300,nColIni+0400	, SZL->ZL_6PREPER								, oArial10N)
	_nLinIni+=0400
	oPrint:Say(_nLinIni,nColIni				,"FOGO: "										, oArial12N)
	oPrint:Say(_nLinIni,nColIni+0400		,SZL->ZL_5MEIOS									, oArial10N)
	oPrint:Say(_nLinIni+0050,nColIni+0400		,SZL->ZL_5PROBOM								, oArial10N)
	_nLinIni+=150
	oPrint:Say(_nLinIni,nColIni				,"POLUIวรO:"									, oArial12N)	
	oPrint:Say(_nLinIni,nColIni+0400		,SZL->ZL_CMOBILI								, oArial10N)
	oPrint:Say(_nLinIni+0050,nColIni+0400	,SZL->ZL_CECOTOX								, oArial10N)
	_nLinIni+=150
	oPrint:Say(_nLinIni,nColIni				,"ENVOLVIMENTO"									, oArial12N)	
	oPrint:Say(_nLinIni,nColIni+0400		,SZL->ZL_4INALAC								, oArial10N)	
	oPrint:Say(_nLinIni+0050,nColIni		,"DE PESSOAS:"									, oArial12N)	
	oPrint:Say(_nLinIni+0050,nColIni+0400	,SZL->ZL_4PELE									, oArial10N)	
	oPrint:Say(_nLinIni+0100,nColIni+0400	,SZL->ZL_4OLHOS									, oArial10N)		
	oPrint:Say(_nLinIni+0150,nColIni+0400	,SZL->ZL_4INGEST								, oArial10N)				
	oPrint:Say(_nLinIni+0200,nColIni+0400	,SZL->ZL_4PELE									, oArial10N)		
	_nLinIni+=0300
	oPrint:Say(_nLinIni,nColIni				,"INFORMAวีES AO MษDICO:"						, oArial12N)	
	oPrint:Say(_nLinIni,nColIni+0400		,SZL->ZL_4NOTAS									, oArial10N)		
	_nLinIni+=150
	oPrint:Say(_nLinIni,nColIni				,"NOME DO FABRICANTE OU IMPORTADOR : Alpax Com้rcio de produtos p/Laborat๓rios Ltda."	, oArial12N)	
	If SF2->(DbSeek(xFilial("SF2")+_aItens[_nY,3]+_aItens[_nY,2],.t.))
		RecLock("SF2",.f.)
		SF2->F2_AXIMPFE := "I"
		SF2->(MsUnLock())
		oPrint:Say(_nLinIni+0100,nColIni+1800	,"NF:" + SF2->F2_DOC							, oArial8N)
	EndIf
	_nLinIni+=0100
	oPrint:EndPage()     // Finaliza a pแgina			     

Next _nY

If _lImprimiu          
	oPrint:Preview()     // Visualiza antes de imprimir
EndIf

Return              