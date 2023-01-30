/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR005   บAutor  ณOCIMAR ROLLI        * Data ณ  22/02/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar relatorio de movimento produto quimicos  บฑฑ
ฑฑบ          ณ controlados SSP/POLICIA CIVIL ESTADUAL.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTR005()

Private cPerg := "RESTR005"
Private oPrint
Private nPag := 1

// Criacao das perguntas
fCriaSx1()

// Abre Perguntas em tela.
If ! Pergunte(cPerg,.t.)
	Return
EndIf

// Se confirmar a impressao chama rotina de processamento.
If ApMsgYesNo("Confirma Impressao do relatorio ??","Confirmar")
	
	oPrint:= TMSPrinter():New( "Movimento compras SSP" )
	oPrint:SetLandscape() // SetPortrait()
	
	Processa({ || fImprime() })
	oPrint:Preview()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImprime  บAutor  ณOCIMAR ROLLI        * Data ณ  22/02/09   บฑฑ
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
Private nRowFim		:= 2300
Private nColIni		:= 0050
Private nColFim		:= 3160
Private nAno        := SUBSTR(DTOS(MV_PAR01),1,4)
Private nTrim       := "4"

Do Case
	Case SUBSTR(DTOS(MV_PAR01),5,2) $ "01/02/03"
		nTrim := "1"
	Case SUBSTR(DTOS(MV_PAR01),5,2) $ "04/05/06"
		nTrim := "2"
	Case SUBSTR(DTOS(MV_PAR01),5,2) $ "07/08/09"
		nTrim := "3"
EndCase

_cQuery:="SELECT A2_NOME AS NOME, A2_END AS ENDE, A2_MUN AS MUN, A2_EST AS EST, A2_TEL AS FONE, A2_CEP AS CEP, A4_COD AS CODT, "
_cQuery+="       A4_NOME AS NOMET, A4_END AS ENDET, A4_MUN AS MUNT, A4_EST AS ESTT, A4_TEL AS FONET, A4_CEP AS CEPT,"
_cQuery+="       D1_EMISSAO, D1_DOC,(D1_QUANT * B1_CONV) AS QUANT, ZS_UM, ZS_DESCR "
_cQuery+="       FROM " + RetSqlName("SD1") + " D1 "
_cQuery+="       INNER JOIN " + RetSqlName("SA2") + " A2 "
_cQuery+="             ON    D1_FORNECE = A2_COD "
_cQuery+="       INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery+="             ON    D1_COD = B1_COD "
_cQuery+="       INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery+="             ON    B1_AXCTSSP = ZS_CON AND ZS_ORGAO = '003' "
_cQuery+="       INNER JOIN " + RetSqlName("SF1") + " F1 "
_cQuery+="             ON    D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND D1_FORNECE = F1_FORNECE "
_cQuery+="       LEFT JOIN " + RetSqlName("SA4") + " A4 "
_cQuery+="             ON    F1_AXTRANS = A4_COD "
_cQuery+="       LEFT JOIN " + RetSqlName("SF4") + " F4 "
_cQuery+="             ON    D1_TES = F4_CODIGO "
_cQuery+="       WHERE D1.D_E_L_E_T_ = ' ' AND A2.D_E_L_E_T_ = ' ' AND ZS.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' "
_cQuery+="             AND D1_FILIAL = '" + xFilial("SD1") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' AND ZS_FILIAL = '" + xFilial("SZS") + "' "
_cQuery+="             AND B1_FILIAL = '" + xFilial("SB1") + "' AND F1_FILIAL = '" + XfILIAL("SF1") + "' AND A4_FILIAL = '" + xFilial("SA4") + "' "
_cQuery+="             AND D1_TIPO = 'N' AND D1_EMISSAO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "' AND F4_ESTOQUE = 'S' AND B1_AXCTSSP != '' "
_cQuery+="UNION ALL "
_cQuery+="SELECT A1_NOME AS NOME, A1_END AS ENDE, A1_MUN AS MUN, A1_EST AS EST, A1_TEL AS FONE, A1_CEP AS CEP, A4_COD AS CODT, "
_cQuery+="       A4_NOME AS NOMET, A4_END AS ENDET, A4_MUN AS MUNT, A4_EST AS ESTT, A4_TEL AS FONET, A4_CEP AS CEPT, "
_cQuery+="       D1_EMISSAO, D1_DOC,(D1_QUANT * B1_CONV) AS QUANT, ZS_UM, ZS_DESCR "
_cQuery+="       FROM " + RetSqlName("SD1") + " D1 "
_cQuery+="       INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery+="             ON    D1_FORNECE = A1_COD "
_cQuery+="       INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery+="             ON    D1_COD = B1_COD "
_cQuery+="       INNER JOIN " + rETsQLnAME("SZS") + " ZS "
_cQuery+="             ON    B1_AXCTSSP = ZS_CON AND ZS_ORGAO = '003' "
_cQuery+="       INNER JOIN " + RetSqlName("SF1") + " F1 "
_cQuery+="             ON    D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND D1_FORNECE = F1_FORNECE "
_cQuery+="       LEFT JOIN " + RetSqlName("SA4") + " A4 "
_cqUERY+="             ON    F1_AXTRANS = A4_COD "
_cQuery+="       LEFT JOIN " + RetSqlName("SF4") + " F4 "
_cQuery+="             ON    D1_TES = F4_CODIGO "
_cQuery+="       WHERE D1.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND ZS.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' "
_cQuery+="             AND D1_FILIAL = '" + xFilial("SD1") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' AND ZS_FILIAL = '" + xFilial("SZS") + "' "
_cQuery+="             AND B1_FILIAL = '" + xFilial("SB1") + "' AND F1_FILIAL = '" + xFilial("SF1") + "' AND A4_FILIAL = '" + xFilial("SA4") + "' "
_cQuery+="             AND D1_TIPO IN ('B','D') AND D1_EMISSAO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "' AND F4_ESTOQUE = 'S' AND B1_AXCTSSP != ''"
_cQuery+="       ORDER BY D1_EMISSAO, NOME "

MemoWrite("\queries\estr005.sql",_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D1_EMISSAO"	,"D",08,0)
TcSetField("QR1","QUANT"		,"N",12,3)

QR1->(DbGoTop())


nLinha := 1860
lPrimeiro := .t.
_cNomTrans := " "
_cEndTran1 := " "
_cEndTran2 := " "
Do While ! QR1->(Eof())
	
	If nLinha > 1850
		If ! lPrimeiro
			oPrint:EndPage()
		EndIf
		lPrimeiro := .f.
		fForm()
		nLinha := 0450
	EndIf
	
	If QR1->CODT == "000008"
		_cNomTrans := "ALPAX COM. DE PRODS. P/ LABS. LTDA."
		_cEndTran1 := "RUA SERRA DA BORBOREMA, 40 / 09930-580"
		_cEndTran2 := "DIADEMA / SAO PAULO / 40579200"
	Else
		_cNomTrans :=QR1->NOMET
		_cEndTran1 :=(RTRIM(QR1->ENDET)+" / "+SUBSTR(QR1->CEPT,1,5)+"-"+SUBSTR(QR1->CEPT,6,3))
		_cEndTran2 :=(RTRIM(QR1->MUNT)+" / "+QR1->ESTT+" / "+QR1->FONET)
	EndIf
	
	oPrint:Say(nRowIni+nLinha+0040,nColIni+0040,DTOC(QR1->D1_EMISSAO)						              ,oArial10N)
	oPrint:Say(nRowIni+nLinha+0040,nColIni+0230,QR1->D1_DOC											      ,oArial10N)
	oPrint:Say(nRowIni+nLinha+0040,nColIni+0430,(Transform(QR1->QUANT,"@e 999,999.999")+" "+QR1->ZS_UM)   ,oArial10N)
	oPrint:Say(nRowIni+nLinha+0045,nColIni+0660,QR1->ZS_DESCR										      ,oArial09N)
	oPrint:Say(nRowIni+nLinha,nColIni+1490,QR1->NOME        			 							      ,oArial08)
	oPrint:Say(nRowIni+nLinha+0050,nColIni+1490,(RTRIM(QR1->ENDE)+" / "+SUBSTR(QR1->CEP,1,5)+"-"+SUBSTR(QR1->CEP,6,3)),oArial08)
	oPrint:Say(nRowIni+nLinha+0100,nColIni+1490,(RTRIM(QR1->MUN)+" / "+QR1->EST+" / "+QR1->FONE) 	      ,oArial08)
	oPrint:Say(nRowIni+nLinha,nColIni+2450,_cNomTrans        			 							      ,oArial08)
	oPrint:Say(nRowIni+nLinha+0050,nColIni+2450,_cEndTran1												  ,oArial08)
	oPrint:Say(nRowIni+nLinha+0100,nColIni+2450,_cEndTran2										 	      ,oArial08)
	nLinha += 0150
	
	QR1->(DbSkip())
	
EndDo

QR1->(DbCloseArea())

oPrint:EndPage()     // Finaliza a pแgina

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSX1  บAutor  ณOCIMAR ROLLI        * Data ณ  22/02/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas do relatorio.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fCriaSx1()

PutSx1(cPerg,"01","Da Emissao :" ,"Da Emissao :"  ,"Da Emissao :"  ,"mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Ate Emissao :","Ate Emissao :" ,"Ate Emissao :" ,"mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfForm     บAutor  ณOCIMAR ROLLI        * Data ณ  22/02/09   บฑฑ
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

LOCAL _NY 
oPrint:StartPage()

//
// CABECALHO
//
oPrint:box(nRowIni,nColIni,nRowFim,nColFim) // Box Externo
oPrint:Box(nRowIni+0020,nColIni+0020,nRowIni+0250,nColFim-0020) 	// cabecalho
oPrint:Line(nRowIni+0020,nColIni+1230,nRowIni+0250,nColIni+1230)    // Coluna1 cabecalho
oPrint:Line(nRowIni+0020,nColIni+2110,nRowIni+0250,nColIni+2110)    // Coluna2 cabecalho
// PRIMEIRO QUADRO
oPrint:Say(nRowIni+0040,nColIni+0040,"ALPAX COMERCIO DE PRODUTOS P/LABORATORIOS LTDA."	 				,oTreb10N)
//oPrint:Line(nRowIni+0080,nColIni+0280,nRowIni+0080,nColIni+1150)
//oPrint:Line(nRowIni+0090,nColIni+0280,nRowIni+0090,nColIni+1150)
oPrint:Say(nRowIni+0120,nColIni+0040,"LOCAL LICENCIADO: "												,oTreb12)
//oPrint:Line(nRowIni+0160,nColIni+0040,nRowIni+0160,nColIni+0700)
oPrint:Say(nRowIni+0180,nColIni+0040," R.SERRA DA BORBOREMA, 40 CAMPANARIO-DIADEMA-SP"		    		,oTreb10N)
// SEGUNDO QUADRO
oPrint:Say(nRowIni+0040,nColIni+1250,"MAPA TRIMESTRAL REFERENTE A COMPRAS"								,oCour12N)
oPrint:Say(nRowIni+0105,nColIni+1250,"RELATORIO DO "													,oCour12)
oPrint:Say(nRowIni+0100,nColIni+1570,nTrim 																,oCour14N)
oPrint:Say(nRowIni+0100,nColIni+1600,"บ" 																,oCour14N)
oPrint:Say(nRowIni+0105,nColIni+1645,"TRIMESTRE DE "													,oCour12)
oPrint:Say(nRowIni+0100,nColIni+1980,nAno 																,oCour14N)
oPrint:Line(nRowIni+0150,nColIni+1250,nRowIni+0150,nColIni+2100)
//oPrint:Say(nRowIni+0180,nColIni+1350,"NUMERO DO ALVARA : 010/2021"										,oCour12)
oPrint:Say(nRowIni+0180,nColIni+1350,"NUMERO DO ALVARA : " + MV_PAR03									,oCour12)  //moises 110422
// TERCEIRO QUADRO
oPrint:Say(nRowIni+0050,nColIni+2800,"Pagina : "+ Strzero(nPag,3)                                       ,oCour12)
nPag++
oPrint:Say(nRowIni+0100,nColIni+2250,"CNPJ : 65.838.344/0001-10"										,oCour14N)
//
// ITENS
//

oPrint:Box(nRowIni+0270,nColIni+0020,nRowFim-0320,nColFim-0020)	 // Itens
oPrint:Line(nRowIni+0430,nColIni+0020,nRowIni+0430,nColFim-0020) // linha Sub-titulos
// PRIMEIRO QUADRO
oPrint:Say(nRowIni+0320,nColIni+0060,"DATA"	,oCour10N)
// SEGUNDO QUADRO
oPrint:Say(nRowIni+0300,nColIni+0220,"NUMERO DA"	,oCour10N)
oPrint:Say(nRowIni+0360,nColIni+0190,"NOTA FISCAL"	,oCour10N)
// TERCEIRO QUADRO
oPrint:Say(nRowIni+0300,nColIni+0450,"QUANTIDADE"	,oCour10N)
oPrint:Say(nRowIni+0360,nColIni+0420," E UN. MEDIDA"	,oCour09)
// QUARTO QUADRO
oPrint:Say(nRowIni+0300,nColIni+0770,"NOME DO PRODUTO"	,oCour11N)
oPrint:Say(nRowIni+0360,nColIni+0820,"CONTROLADO"	,oCour11N)
// QUINTO QUADRO
oPrint:Say(nRowIni+0300,nColIni+1250,"RAZAO SOCIAL COMPLETA/END. COMPLETO/CEP/CIDADE/UF DO"	,oCour09)
oPrint:Say(nRowIni+0360,nColIni+1490,"FORNECEDOR/REMETENTE"	,oCour12N)
// SEXTO QUADRO
oPrint:Say(nRowIni+0300,nColIni+2180,"RAZAO SOCIAL COMPLETA/END. COMPLETO/CEP/CIDADE/UF DO"	,oCour09)
oPrint:Say(nRowIni+0360,nColIni+2450,"TRANSPORTADOR"	,oCour12N)

// Linhas dos itens

nLinTmp := nRowIni+0430
For _nY := 1 To 10
	oPrint:Line(nLinTmp+0150,nColIni,nLinTmp+0150,nColFim-0020)
	oPrint:Line(nLinTmp+0050,nColIni+1220,nLinTmp+0050,nColFim-0020)
	oPrint:Say(nLinTmp+0010,nColIni+1250,"Razao Social"	,oCour09N)
	oPrint:Say(nLinTmp+0010,nColIni+2180,"Razao Social"	,oCour09N)
	oPrint:Say(nLinTmp+0060,nColIni+1250,"Endere็o/Cep"	,oCour09)
	oPrint:Say(nLinTmp+0060,nColIni+2180,"Endere็o/Cep"	,oCour09)
	oPrint:Line(nLinTmp+0100,nColIni+1480,nLinTmp+0100,nColIni+2160)
	oPrint:Line(nLinTmp+0100,nColIni+2440,nLinTmp+0100,nColFim-0020)
	oPrint:Say(nLinTmp+0110,nColIni+1250,"Cidade/UF/Fone"	,oCour09)
	oPrint:Say(nLinTmp+0110,nColIni+2180,"Cidade/UF/Fone"	,oCour09)
	nLinTmp+=0150
Next _nY

// Colunas dos Itens
oPrint:Line(nRowIni+0270,nColIni+0180,nRowFim-0320,nColIni+0180)
oPrint:Line(nRowIni+0270,nColIni+0430,nRowFim-0320,nColIni+0430)
oPrint:Line(nRowIni+0270,nColIni+0650,nRowFim-0320,nColIni+0650)
oPrint:Line(nRowIni+0270,nColIni+1220,nRowFim-0320,nColIni+1220)
oPrint:Line(nRowIni+0430,nColIni+1480,nRowFim-0320,nColIni+1480)
oPrint:Line(nRowIni+0270,nColIni+2160,nRowFim-0320,nColIni+2160)
oPrint:Line(nRowIni+0430,nColIni+2440,nRowFim-0320,nColIni+2440)
//
// RODAPE
//
oPrint:Box(nRowFim-0300,nColIni+0020,nRowFim-0020,nColIni+1200) // Rodape 1
oPrint:Box(nRowFim-0300,nColIni+1220,nRowFim-0020,nColIni+2030)	// Rodape 2
oPrint:Box(nRowFim-0300,nColIni+2050,nRowFim-0020,nColFim-0020)	// Rodape 3
// PRIMEIRO QUADRO
oPrint:Say(nRowFim-0280,nColIni+0040,"ENVIAR EM TRES(3) VIAS. A NรO ENTREGA ATษ O DษCIMO(10บ) DIA ฺTIL"	,oCour09)
oPrint:Say(nRowFim-0240,nColIni+0040,"APำS O TษRMINO DE CADA TRIMESTRE PODE ACARRETAR EM PENALIDADES.",oCour09)
oPrint:Say(nRowFim-0210,nColIni+0040,"Obs.:",oCour09)
// SEGUNDO QUADRO
oPrint:Say(nRowFim-0260,nColIni+1300,"ARNON REIS - ASSESSORIA",oCour14N)
oPrint:Say(nRowFim-0200,nColIni+1300,"E  DOCUMENTOS ESPECIAIS",oCour14N)
oPrint:Say(nRowFim-0150,nColIni+1250,"RUA BARAO DE ITAPETININGA 255 3.ANDAR CJ.309 CENTRO",oArial08)
//oPrint:Line(nRowFim-0118,nColIni+1250,nRowFim-0115,nColFim-1250)
oPrint:Say(nRowFim-0110,nColIni+1250,"SAO PAULO, SP   -    ",oArial08)
oPrint:Say(nRowFim-0110,nColIni+1500,"METRO REPUBLICA",oArial08)
oPrint:Say(nRowFim-0110,nColIni+1725,"   -   CEP 01042-917",oArial08)
//oPrint:Line(nRowFim-0078,nColIni+1250,nRowFim-0078,nColFim-1250)
oPrint:Say(nRowFim-0070,nColIni+1250,"arnonreis@arnonreis.com.br",oArial08)
oPrint:Say(nRowFim-0070,nColIni+1650,"  -        TEL 11.3255-7720",oArial08)
//oPrint:Line(nRowFim-0038,nColIni+1250,nRowFim-0038,nColIni+2005)
// TERCEIRO QUADRO
oPrint:Say(nRowFim-0260,nColIni+2100,"O QUE DECLARO E VERDADE, SOB AS PENAS DA LEI.",oCour10N)
oPrint:Say(nRowFim-0210,nColIni+2100,"DIADEMA,",oCour10N)
oPrint:Say(nRowFim-0110,nColIni+2100,"ASSINATURA :",oCour10)
oPrint:Line(nRowFim-0080,nColIni+2350,nRowFim-0080,nColIni+3060)
oPrint:Say(nRowFim-0060,nColIni+2100,"NOME/CARGO/RG :",oCour10)
oPrint:Say(nRowFim-0055,nColIni+2405,"LUCI AKEMI MASUMOTO / SOCIA / 7.700.270-2",oArial08)

Return
