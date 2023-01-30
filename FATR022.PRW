/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR022   บAutor  ณAdriano Luis Brandaoบ Data ณ  24/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar relatorio de Produtos Controlados comer- บฑฑ
ฑฑบ          ณ cializados pela Alpax.                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Protheus.ch"
#Include "Topconn.ch"

User Function FATR022()

// Se confirmar a impressao chama rotina de processamento.
If ApMsgYesNo("Confirma Impressao do relatorio ??","Confirmar")

	oPrint:= TMSPrinter():New( "Produtos Controlados" )
	oPrint:SetPortrait() // SetLandscape()

	Processa({ || fImprime() })
	oPrint:Preview()
EndIf	                   
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImprime  บAutor  ณAdriano Luis Brandaoบ Data ณ  24/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para processamento da impressao grafica.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImprime()

// Fontes utilizadas no relatorio.
Private oArial08	:= TFont():New("Arial"			,08,07,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial09	:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial10	:= TFont():New("Arial"			,10,09,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial12	:= TFont():New("Arial"			,12,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial14	:= TFont():New("Arial"			,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial09N	:= TFont():New("Arial"			,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial10N	:= TFont():New("Arial"			,10,09,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial12N	:= TFont():New("Arial"			,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial14N	:= TFont():New("Arial"			,14,13,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial16N	:= TFont():New("Arial"			,16,15,.T.,.T.,5,.T.,5,.T.,.F.)

Private oCour09		:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour09N	:= TFont():New("Courier New"	,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour10		:= TFont():New("Courier New"	,10,09,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour10T	:= TFont():New("Courier New"	,10,09,.T.,.F.,5,.T.,5,.T.,.T.)
Private oCour11		:= TFont():New("Courier New"	,11,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour11N	:= TFont():New("Courier New"	,11,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour12		:= TFont():New("Courier New"	,12,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour12N	:= TFont():New("Courier New"	,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour12T	:= TFont():New("Courier New"	,12,11,.F.,.F.,5,.T.,5,.T.,.T.)
Private oCour14		:= TFont():New("Courier New"	,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour09N	:= TFont():New("Courier New"	,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour10N	:= TFont():New("Courier New"	,10,09,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour10S	:= TFont():New("Courier New"	,10,09,.T.,.T.,5,.T.,5,.T.,.T.)
Private oCour12N	:= TFont():New("Courier New"	,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour12S	:= TFont():New("Courier New"	,12,11,.T.,.F.,5,.T.,5,.T.,.T.)
Private oCour14 	:= TFont():New("Courier New"	,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour14N	:= TFont():New("Courier New"	,14,13,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour15 	:= TFont():New("Courier New"	,15,14,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour16 	:= TFont():New("Courier New"	,16,16,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour16N	:= TFont():New("Courier New"	,16,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour16S	:= TFont():New("Courier New"	,16,16,.T.,.T.,5,.T.,5,.T.,.T.)
Private oCour18N	:= TFont():New("Courier New"	,18,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour20N	:= TFont():New("Courier New"	,20,20,.T.,.T.,5,.T.,5,.T.,.F.)

Private oTreb10 	:= TFont():New("Trebuchet MS"	,10,09,.T.,.F.,5,.T.,5,.T.,.F.)
Private oTreb10N 	:= TFont():New("Trebuchet MS"	,10,09,.T.,.T.,5,.T.,5,.T.,.F.)
Private oTreb12 	:= TFont():New("Trebuchet MS"	,12,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oTreb12N 	:= TFont():New("Trebuchet MS"	,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oTreb14 	:= TFont():New("Trebuchet MS"	,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oTreb14N 	:= TFont():New("Trebuchet MS"	,14,13,.T.,.T.,5,.T.,5,.T.,.F.)

Private nRowIni		:= 0050
Private nRowFim		:= 3210
Private nColIni		:= 0050
Private nColFim		:= 2300

_cQuery := "SELECT SZS.ZS_DESCR "
_cQuery += ",      'EXERCITO' AS ORGAO "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS  "
_cQuery += "WHERE ZS_FILIAL = '" + xFilial("SZS") + "' AND SZS.D_E_L_E_T_ = ' ' AND SZS.ZS_ORGAO = '001' "
_cQuery += "UNION ALL "
_cQuery += "SELECT SZS.ZS_DESCR "
_cQuery += ",      'POLICIA FEDERAL' AS ORGAO "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS  "
_cQuery += "WHERE ZS_FILIAL = '" + xFilial("SZS") + "' AND SZS.D_E_L_E_T_ = ' ' AND SZS.ZS_ORGAO = '002' "
_cQuery += "UNION ALL "
_cQuery += "SELECT SZS.ZS_DESCR "
_cQuery += ",      'SEC. SEG. PUBLICA' AS ORGAO "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS  "
_cQuery += "WHERE ZS_FILIAL = '" + xFilial("SZS") + "' AND SZS.D_E_L_E_T_ = ' ' AND SZS.ZS_ORGAO = '003' "
_cQuery += "ORDER BY SZS.ZS_DESCR "

TcQuery _cQuery New Alias "QR1"

QR1->(DbGoTop())

nLinha := 3100
lPrimeiro := .t.
Do While ! QR1->(Eof())

	If nLinha > 3090
		If ! lPrimeiro 
			oPrint:EndPage()
		EndIf 
		lPrimeiro := .f.
		fForm()
		nLinha := 0370
	EndIf             
	
oPrint:Say(nRowIni+nLinha,nColIni+0100,QR1->ZS_DESCR						           ,oArial10N)
oPrint:Say(nRowIni+nLinha,nColIni+1380,QR1->ORGAO   						           ,oArial10N)
nLinha += 0100

	QR1->(DbSkip())
	
EndDo

QR1->(DbCloseArea())

oPrint:EndPage()     // Finaliza a pแgina                    

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfForm     บAutor  ณAdriano Luis Brandaoบ Data ณ  24/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para montar o formulario de impressao em branco.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fForm()

oPrint:StartPage()

//
// CABECALHO
//
oPrint:box(nRowIni,nColIni,nRowFim,nColFim) // Box Externo
oPrint:Box(nRowIni+0020,nColIni+0020,nRowIni+0150,nColFim-0020) 	// cabecalho principal
oPrint:Say(nRowIni+0040,nColIni+0040,"Produtos Controlados Comercializados pela ALPAX",oCour20N)   
oPrint:Box(nRowIni+0190,nColIni+0020,nRowIni+0300,nColFim-0020) 	// cabecalho das colunas
oPrint:Line(nRowIni+0190,nColIni+1280,nRowIni+0300,nColIni+1280)
oPrint:Say(nRowIni+0210,nColIni+0100,"Descri็ใo dos produtos",oCour16N)
oPrint:Say(nRowIni+0210,nColIni+1380,"Orgใo Fiscalizador",oCour16N)
oPrint:box(nRowIni+0340,nColIni+0020,nRowFim-0020,nColFim-0020) // Box dos itens

// Linhas dos itens
nLinTmp := nRowIni+0340+100
For _nY := 1 To 28
	oPrint:Line(nLinTmp,nColIni+0020,nLinTmp,nColFim-0020)
	nLinTmp+=100
Next _nY  

oPrint:Line(nRowIni+0340,nColIni+1280,nRowFim-0020,nColIni+1280)
oPrint:Say(3300,1980,"Anexo I - R.T.A. : 7.5.1-03",oArial09) 

Return
