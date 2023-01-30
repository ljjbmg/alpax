/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR029   บAutor  ณOcimar Rolli        บ Data ณ  06/09/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de inventario.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function ESTR029()

_cPerg := "ESTR29"

//PutSx1(_cPerg,"01","Part Number de"   ,"Part Number de"   ,"Part Number de"   ,"mv_ch1" ,"C",20,0,0,"G","",""   ,"","","mv_par01",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"02","Part Number ate"  ,"Part Number ate"  ,"Part Number ate"  ,"mv_ch2" ,"C",20,0,0,"G","",""   ,"","","mv_par02",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"03","Marca de "        ,"Marca de "        ,"Marca de "        ,"mv_ch3" ,"C",15,0,0,"G","","SZ2","","","mv_par03",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"04","Marca ate"        ,"Marca ate"        ,"Marca ate"        ,"mv_ch4" ,"C",15,0,0,"G","","SZ2","","","mv_par04",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"05","Capacidade de"    ,"Capacidade de"    ,"Capacidade de"    ,"mv_ch5" ,"C",15,0,0,"G","","SZ5","","","mv_par05",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"06","Capacidade ate"   ,"Capacidade ate"   ,"Capacidade ate"   ,"mv_ch6" ,"C",15,0,0,"G","","SZ5","","","mv_par06",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"07","Armazem "         ,"Armazem "         ,"Armazem "         ,"mv_ch7" ,"C",02,0,0,"G","",""   ,"","","mv_par07",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"08","Descric. contem " ,"Descric. contem " ,"Descric. contem " ,"mv_ch8" ,"C",20,0,0,"G","",""   ,"","","mv_par08",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"09","Selecao "         ,"Selecao "         ,"Selecao "         ,"mv_ch9" ,"N",01,0,0,"C","",""   ,"","","mv_par09","Contagem","Contagem","Contagem","","Conferencia","Conferencia","Conferencia","Em branco","Em branco","Em branco","","","","","","",,,)
//PutSx1(_cPerg,"10","Classe Risco de " ,"Classe Risco de " ,"Classe Risco de " ,"mv_ch10","C",04,0,0,"G","","Z1" ,"","","mv_par10",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)
//PutSx1(_cPerg,"11","Classe Risco ate" ,"Classe Risco ate" ,"Classe Risco ate" ,"mv_ch11","C",04,0,0,"G","","Z1" ,"","","mv_par11",""        ,""        ,""        ,"",""           ,""           ,""           ,""         ,""         ,""         ,"","","","","","",,,)


If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr029() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImpr029  บAutor  ณOcimar Rolli        บ Data ณ  06/09/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de processamento do relatorio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImpr029()

Private nColIni 	:= 0100
Private nColFim 	:= 3100
Private nRowIni		:= 0050
Private nRowFim 	:= 2270
Private oPrint, _nItem, nPag

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8CN	:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11N	:= TFont():New("Arial"			,09,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)


_cQuery := "SELECT B1_PNUMBER AS REFERENCIA "
_cQuery += ",      B1_MARCA AS MARCA "
_cQuery += ",      B1_DESC AS DESCRICAO "
_cQuery += ",      B1_CAPACID AS CAPACIDADE "
_cQuery += ",      B2_LOCAL AS ARMAZEM "
_cQuery += ",      CASE WHEN(BF_LOTECTL = ' ') THEN 'SEM LOTE' ELSE BF_LOTECTL END AS LOTE "
_cQuery += ",      CASE WHEN(BF_NUMSERI = ' ') THEN 'SEM SERIE' ELSE BF_NUMSERI END AS SERIE "
_cQuery += ",      B2_QATU AS QUANT_B2 "
_cQuery += ",      ISNULL(BF_QUANT, 0) AS QUANT_BF "
_cQuery += ",      CASE WHEN(B1_AXRISCO = ' ') THEN 'SEM RISCO' ELSE RTRIM(X5_DESCRI) END AS RISCO "
_cQuery += "FROM " + RetSqlName("SB1") + " SB1 "
_cQuery += "LEFT OUTER JOIN " + RetSqlName("SBF") + " SBF "
_cQuery += "ON B1_COD = BF_PRODUTO AND SBF.D_E_L_E_T_ = ' ' AND BF_LOCAL = '" + MV_PAR07 + "' AND BF_QUANT <> 0"
_cQuery += "LEFT OUTER JOIN " + RetSqlName("SB2") + " SB2 "
_cQuery += "ON B1_COD = B2_COD AND SB2.D_E_L_E_T_ = ' ' "
_cQuery += "LEFT OUTER JOIN " + RetSqlName("SX5") + " SX5 "
_cQuery += "ON B1_AXRISCO = X5_CHAVE AND X5_TABELA = 'Z1' "
_cQuery += "WHERE B1_MSBLQL <> '1' "
_cQuery += "AND B1_PNUMBER BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "AND B1_MARCA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' AND BF_QUANT <> 0 "
_cQuery += "AND B1_CAPACID BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
_cQuery += "AND B2_LOCAL = '" + MV_PAR07 + "' "
_cQuery += "AND B1_DESC LIKE '%" + ALLTRIM(MV_PAR08) + "%' "
_cQuery += "AND B1_AXRISCO BETWEEN '" + MV_PAR10 + "' AND '" + MV_PAR11 + "' "
_cQuery += "ORDER BY B1_MARCA, B1_AXRISCO, B1_PNUMBER, BF_LOTECTL, BF_NUMSERI "


TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","QUANT_B2"    ,"N",12,0)
TcSetField("QR1","QUANT_B8"    ,"N",12,0)
TcSetField("QR1","QUANT_BF"    ,"N",12,0)

oPrint:= TMSPrinter():New( "Inventario" )
oPrint:SetLandscape() // ou SetPortrait()

nLin      := 17
nInc      := 100
nMarca    := " "
nRisco    := " "

If MV_PAR09 == 3
	fFormCab()
	fFormDet()
Else
	Do While ! QR1->(Eof())
		If nLin > 16
			nLin := 1
			nInc := 100
			nMarca := QR1->MARCA
			nRisco := QR1->RISCO
			oPrint:endpage()
			fFormCab()
		EndIf
		fFormDet()
		QR1->(DbSkip())
	EndDo
EndIf

QR1->(DbCloseArea())

oPrint:Preview()

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfFormCab  บAutor  ณOcimar Rolli        บ Data ณ  06/09/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta formulario completo, para preencher com os dados.    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fFormCab()

oPrint:StartPage()

// BOX CABECALHO
oPrint:Box(nRowIni,nColIni,nRowFim,nColFim)
oPrint:SayBitmap(nRowIni+20,nColIni+20,"\system\logo_alpax.bmp",600,170)
oPrint:Say(nRowIni+0050,nColIni+1500,"INVENTARIO"                                                 ,oFont21N)
oPrint:Box(nRowIni+0250,nColIni+0800,nRowIni+0350,nColFim-0250)
oPrint:Say(nRowIni+0270,nColIni+0300,"MARCA  : "                                                       ,oFont21N)
If QR1->RISCO == ' '
	oPrint:Say(nRowIni+0270,nColIni+1500,ALLTRIM(QR1->MARCA)+" - SEM RISCO "                                                        ,oFont21N)
Else
	oPrint:Say(nRowIni+0270,nColIni+1500,ALLTRIM(QR1->MARCA)+" - "+QR1->RISCO                                                        ,oFont21N)
EndIf

// BOX E CABECALHO DOS DETALHES
oPrint:Box(nRowIni+0500,nColIni+0010,nRowIni+0600,nColFim-0010)
oPrint:Say(nRowIni+0525,nColIni+0060,"PART NUMBER "                                                         ,oFont10N)
oPrint:Say(nRowIni+0525,nColIni+0350,"PRODUTO "                                                     ,oFont10N)
oPrint:Say(nRowIni+0525,nColIni+1600,"CAPACID"                                                         ,oFont10N)
oPrint:Say(nRowIni+0525,nColIni+1800,"LOTE"                                                           ,oFont10N)
oPrint:Say(nRowIni+0525,nColIni+2100,"SERIE"                                                           ,oFont10N)
oPrint:Say(nRowIni+0525,nColIni+2450,"QUANT."                                                           ,oFont10N)
oPrint:Say(nRowIni+0525,nColIni+2700,"CONTAGEM"                                                           ,oFont10N)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfFormDet  บAutor  ณOcimar Rolli        บ Data ณ  25/03/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Detalhes do relatorio                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fFormDet()

// DETALHES

If MV_PAR09 <> 3
	
	oPrint:Box(nRowIni+0500+nInc,nColIni+0010,nRowIni+0600+nInc,nColFim-0010)
	oPrint:Say(nRowIni+0525+nInc,nColIni+0060,QR1->REFERENCIA                                                         ,oFont10N)
	oPrint:Say(nRowIni+0525+nInc,nColIni+0350,QR1->DESCRICAO                                                     ,oFont10N)
	oPrint:Say(nRowIni+0525+nInc,nColIni+1600,QR1->CAPACIDADE                                                          ,oFont10N)
	oPrint:Say(nRowIni+0525+nInc,nColIni+1800,QR1->LOTE                                                            ,oFont10N)
	oPrint:Say(nRowIni+0525+nInc,nColIni+2100,QR1->SERIE                                                           ,oFont10N)
	If MV_PAR09 == 1
		oPrint:Say(nRowIni+0525+nInc,nColIni+2475," "                                        ,oFont10N)
	Else
		oPrint:Say(nRowIni+0525+nInc,nColIni+2475,Transform(QR1->QUANT_BF,"@e 999,999")                                        ,oFont10N)
	EndIf
	
	nLin ++
	nInc += 0100
	
	If nLin > 16 .Or. nMarca <> QR1->MARCA .Or. nRisco <> QR1->RISCO
		oPrint:EndPage()
		nLin := 1
		nInc := 100
		nMarca := QR1->MARCA
		nRisco := QR1->RISCO
		fFormCab()
	EndIf
	
Else
	nLin := 1
	Do While nLin < 17
		oPrint:Box(nRowIni+0500+nInc,nColIni+0010,nRowIni+0600+nInc,nColFim-0010)
		nLin += 1
		nInc += 100
	EndDo
EndIf

Return()
