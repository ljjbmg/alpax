/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR026   ºAutor  ³Ocimar Rolli        º Data ³  10/09/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de metas de vendas.                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function FATR026()

_cPerg := "FATR26"

PutSx1(_cPerg,"01","Data de " ,"Data de " ,"Data de " ,"mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Data ate" ,"Data ate" ,"Data ate" ,"mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr026() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr026  ºAutor  ³Ocimar Rolli        º Data ³  10/09/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de processamento do relatorio.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr026()

Private nColIni 	:= 0100
Private nColFim 	:= 2250
Private nRowIni		:= 0100
Private nRowFim 	:= 3090
// Private nRowPage	:= 3000
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

_cQuery := " SELECT CODIGO, ATENDENTE, EQUIPE, SUM(FATURAMENTO) FATURAMENTO, SUM(DEVOLUCAO) DEVOLUCAO, META "
_cQuery += " FROM( "
_cQuery += " SELECT CODIGO, ATENDENTE, EQUIPE, "
_cQuery += " CASE WHEN TIPO = 'FATURAMENTO' THEN SUM(VALOR) ELSE 0 END FATURAMENTO, "
_cQuery += " CASE WHEN TIPO = 'DEVOLUCAO' THEN SUM(VALOR) ELSE 0 END DEVOLUCAO, "
_cQuery += " META "
_cQuery += " FROM ( "
_cQuery += " SELECT C5_AXATEN1 AS CODIGO, C5_AXATEND AS ATENDENTE, Z7_EQUIPE AS EQUIPE, "
_cQuery += "       SUM(D2_TOTAL) AS VALOR, 'FATURAMENTO' AS TIPO, ZA8_VALOR AS META "
_cQuery += " FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "       INNER JOIN " + RetSqlName("SC5") + " C5 "
_cQuery += "          ON D2.D2_PEDIDO = C5.C5_NUM "
_cQuery += "	   INNER JOIN " + RetSqlName("SZ7") + " Z7 "
_cQuery += "	      ON C5.C5_AXATEN1 = Z7.Z7_CODUSR "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "          ON D2.D2_TES = F4.F4_CODIGO "
_cQuery += "       LEFT JOIN " + RetSqlName("ZA8") + " ZA8 "
_cQuery += "          ON C5_AXATEN1 = ZA8_CODUSR AND ZA8.ZA8_DATADE = '" + DtoS(MV_PAR01) + "' AND ZA8.ZA8_DATATE = '" + DtoS(MV_PAR02) + "' AND ZA8.D_E_L_E_T_ = ' '"
_cQuery += " WHERE D2.D_E_L_E_T_ = ' ' AND C5.D_E_L_E_T_ = ' ' AND Z7.D_E_L_E_T_ = ' ' AND F4_DUPLIC = 'S' "
_cQuery += "         AND D2_EMISSAO BETWEEN  '" + DtoS(MV_PAR01) + "' AND  '" + DtoS(MV_PAR02) + "' "
_cQuery += "         AND Z7_EQUIPE IN ('VD NACIONAL','REVENDA','LICITACAO','DIVISAO ANALITICA','DIVISAO MAGISTRAL') "
_cQuery += " GROUP BY C5_AXATEND, Z7_EQUIPE, C5_AXATEN1, ZA8.ZA8_VALOR "
_cQuery += " UNION ALL "
_cQuery += " SELECT C5_AXATEN1 AS CODIGO, C5_AXATEND AS ATENDENTE, Z7_EQUIPE AS EQUIPE, "
_cQuery += "       (SUM(D1_TOTAL) * - 1) AS VALOR, 'DEVOLUCAO' AS TIPO, ZA8_VALOR AS META "
_cQuery += " FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "        INNER JOIN " + RetSqlName("SD2") + " D2 "
_cQuery += "           ON D1_NFORI = D2_DOC AND D1_SERIORI = D2_SERIE AND D1_ITEMORI = D2_ITEM "
_cQuery += "        INNER JOIN " + RetSqlName("SC5") + " C5 "
_cQuery += "           ON D2.D2_PEDIDO = C5.C5_NUM "
_cQuery += "        INNER JOIN " + RetSqlName("SZ7") + " Z7 "
_cQuery += "           ON C5.C5_AXATEN1 = Z7.Z7_CODUSR "
_cQuery += "        INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "           ON D2.D2_TES = F4.F4_CODIGO "
_cQuery += "        LEFT JOIN " + RetSqlName("ZA8") + " ZA8 "
_cQuery += "           ON C5.C5_AXATEN1 = ZA8.ZA8_CODUSR AND ZA8.ZA8_DATADE = '" + DtoS(MV_PAR01) + "' AND ZA8.ZA8_DATATE = '" + DtoS(MV_PAR02) + "' AND ZA8.D_E_L_E_T_ = ' ' "
_cQuery += " WHERE D1.D_E_L_E_T_ = ' ' AND D2.D_E_L_E_T_ = ' ' AND C5.D_E_L_E_T_ = ' ' AND Z7.D_E_L_E_T_ = ' '  "
_cQuery += "         AND D1_TIPO = 'D' AND F4_DUPLIC = 'S' AND D1_DTDIGIT BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02) + "' "
_cQuery += "         AND Z7_EQUIPE IN ('VD NACIONAL','REVENDA','LICITACAO','DIVISAO ANALITICA','DIVISAO MAGISTRAL') "
_cQuery += " GROUP BY C5_AXATEND, Z7_EQUIPE, C5_AXATEN1, ZA8.ZA8_VALOR
_cQuery += " ) X "
_cQuery += " GROUP BY CODIGO, ATENDENTE, EQUIPE,TIPO, META "
_cQuery += " ) Y "
_cQuery += " GROUP BY CODIGO, ATENDENTE, EQUIPE, META "
_cQuery += " ORDER BY EQUIPE, CODIGO "


TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","FATURAMENTO"      ,"N",12,2)
TcSetField("QR1","DEVOLUCAO"        ,"N",12,2)
TcSetField("QR1","META"             ,"N",12,2)


oPrint:= TMSPrinter():New( "Metas de vendas" )
oPrint:SetPortrait() // ou SetLandscape()

nLin      := 31
nInc      := 470
nPercent  := 0

Do While ! QR1->(Eof())
	If nLin > 30
		nLin := 1
		nInc := 470
		fFormCab()
	EndIf
	
	fFormDet()
	
	QR1->(DbSkip())
	
EndDo

QR1->(DbCloseArea())

oPrint:Preview()

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormCab  ºAutor  ³Ocimar Rolli        º Data ³  10/09/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta formulario completo, para preencher com os dados.    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fFormCab()

oPrint:StartPage()

// BOX CABECALHO
oPrint:Box(nRowIni,nColIni,nRowFim,nColFim)
oPrint:SayBitmap(nRowIni+20,nColIni+20,"\system\logo_alpax.bmp",600,170)
oPrint:Say(nRowIni+0050,nColIni+1050,"METAS DE VENDAS"                                                 ,oFont21N)
oPrint:Say(nRowIni+0200,nColIni+0850,"PERIODO DE : "+DtoC(MV_PAR01)+" ATE "+DtoC(MV_PAR02)             ,oFont18N)

// BOX E CABECALHO DOS DETALHES
oPrint:Box(nRowIni+0350,nColIni+0010,nRowFim-2510,nColFim-0010)
oPrint:Say(nRowIni+0370,nColIni+0060,"ATENDENTE"                                                       ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+0375,nRowFim-2510,nColIni+0375)
oPrint:Say(nRowIni+0370,nColIni+0425,"EQUIPE"                                                          ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+0750,nRowFim-2510,nColIni+0750)
oPrint:Say(nRowIni+0370,nColIni+0800,"FATURADO"                                                        ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+1125,nRowFim-2510,nColIni+1125)
oPrint:Say(nRowIni+0370,nColIni+1175,"DEVOLVIDO"                                                       ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+1500,nRowFim-2510,nColIni+1500)
oPrint:Say(nRowIni+0370,nColIni+1550,"META"                                                            ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+1875,nRowFim-2510,nColIni+1875)
oPrint:Say(nRowIni+0370,nColIni+1915,"% ATINGIDO"                                                      ,oFont10N)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormDet  ºAutor  ³Ocimar Rolli        º Data ³  10/09/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Detalhes do relatorio                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fFormDet()

// Calcula o percentual

nPercent := (((QR1->FATURAMENTO - QR1->DEVOLUCAO)/QR1->META)*100)

// DETALHES

oPrint:Box( nRowIni+nInc,nColIni+0010,nRowIni+0080+nInc,nColFim-0010)
oPrint:Line(nRowIni+nInc,nColIni+0375,nRowIni+0080+nInc,nColIni+0375)
oPrint:Line(nRowIni+nInc,nColIni+0750,nRowIni+0080+nInc,nColIni+0750)
oPrint:Line(nRowIni+nInc,nColIni+1125,nRowIni+0080+nInc,nColIni+1125)
oPrint:Line(nRowIni+nInc,nColIni+1500,nRowIni+0080+nInc,nColIni+1500)
oPrint:Line(nRowIni+nInc,nColIni+1875,nRowIni+0080+nInc,nColIni+1875)
oPrint:Say(nRowIni+20+nInc,nColIni+0060,QR1->ATENDENTE                                             ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+0425,QR1->EQUIPE                                                ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+0800,"R$ "                                                      ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+0850,Transform(QR1->FATURAMENTO,"@e 9,999,999.99")              ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1175,"R$ "                                                      ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1200,Transform(QR1->DEVOLUCAO,"@e 9,999,999.99")                ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1550,"R$ "                                                      ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1600,Transform(QR1->META,"@e 9,999,999.99")                     ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColFim-0220,Transform(nPercent,"@e 999.99")                            ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni-0180,"% "                                                       ,oFont8CN)

nLin ++
nInc += 0080

If nLin > 30
	oPrint:EndPage()
	nLin := 1
	nInc := 470
	fFormCab()
EndIf

Return()
