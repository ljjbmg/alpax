/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR028   ºAutor  ³Ocimar Rolli        º Data ³  09/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de saldos dos produtos controlados em uma data.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function ESTR028()

_cPerg := "ESTR28"

PutSx1(_cPerg,"01","Orgao "    ,"Orgao "    ,"Orgao "    ,"mv_ch1","C",03,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Saldo em " ,"Saldo em " ,"Saldo em " ,"mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr028() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr028  ºAutor  ³Ocimar Rolli        º Data ³  09/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de processamento do relatorio.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr028()

Private nColIni 	:= 0100
Private nColFim 	:= 2250
Private nRowIni		:= 0100
Private nRowFim 	:= 3090
Private _cRet    	:= " "
Private _cOrgao     := " "
Private oPrint, _nItem, nPag
Private cData       := Substr(DtoS(MV_PAR02),1,6)

Do Case
	Case MV_PAR01 == "001"
		_cRet := "ON SZS.ZS_CON = SB1.B1_AXCTEXE AND SZS.ZS_ORGAO = '001' "
		_cOrgao := "EXERCITO"
	Case MV_PAR01 == "002"
		_cRet := "ON SZS.ZS_CON = SB1.B1_AXCTPF  AND SZS.ZS_ORGAO = '002' "
		_cOrgao := "POLICIA FEDERAL"
	Case MV_PAR01 == "003"
		_cRet := "ON SZS.ZS_CON = SB1.B1_AXCTSSP AND SZS.ZS_ORGAO = '003' "
		_cOrgao := "SEC. SEG. PUBLICA"
EndCase






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

If MV_PAR01 == "002"
	_cQuery := "SELECT ORGAO, CODIGO, CLASSIFICACAO, UNIDADE, CONCENTRACAO, SUM(SALDO) AS SALDO, SUM(ENTRADAS) AS ENTRADAS, SUM(SAIDAS) AS SAIDAS, "
Else
	_cQuery := "SELECT ORGAO, CODIGO, CLASSIFICACAO, UNIDADE, SUM(SALDO) AS SALDO, SUM(ENTRADAS) AS ENTRADAS, SUM(SAIDAS) AS SAIDAS, "
EndIf
_cQuery += "SUM(REQUISITADO) AS REQUISITADO, SUM(ENT_EST) AS ENT_EST FROM "
If MV_PAR01 == "002"
	_cQuery += "(SELECT ORGAO, CODIGO, CLASSIFICACAO, UNIDADE, CONCENTRACAO, "
Else
	_cQuery += "(SELECT ORGAO, CODIGO, CLASSIFICACAO, UNIDADE, "
EndIf
_cQuery += "CASE WHEN TIPO = 'SALDO' THEN SUM(SALDO) ELSE 0 END SALDO, "
_cQuery += "CASE WHEN TIPO = 'ENTRADAS' THEN SUM(SALDO) ELSE 0 END ENTRADAS, "
_cQuery += "CASE WHEN TIPO = 'SAIDAS' THEN SUM(SALDO) ELSE 0 END SAIDAS, "
_cQuery += "CASE WHEN TIPO = 'REQUISITADO' THEN SUM(SALDO) ELSE 0 END REQUISITADO, "
_cQuery += "CASE WHEN TIPO = 'ENT_EST' THEN SUM(SALDO) ELSE 0 END ENT_EST "
_cQuery += "FROM "
_cQuery += "(SELECT 'SALDO' AS TIPO "
_cQuery += ",      SZS.ZS_ORGAO AS ORGAO "
_cQuery += ",      SZS.ZS_CON AS CODIGO "
If MV_PAR01 == "002"
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO, SB1.B1_AXCONC AS CONCENTRACAO "
Else
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO "
EndIf
_cQuery += ",      SUM(SB2.B2_QATU*SB1.B1_CONV) AS SALDO "
_cQuery += ",      SZS.ZS_UM AS UNIDADE "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += _cRet
_cQuery += "INNER JOIN " + RetSqlName("SB2") + " SB2 "
_cQuery += "ON SB1.B1_COD = SB2.B2_COD "
_cQuery += "WHERE SZS.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' "
If MV_PAR01 == "002"
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO, SB1.B1_AXCONC "
Else
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO "
EndIf
_cQuery += "UNION ALL "
_cQuery += "SELECT 'ENTRADAS' AS TIPO "
_cQuery += ",      SZS.ZS_ORGAO AS ORGAO "
_cQuery += ",      SZS.ZS_CON AS CODIGO "
If MV_PAR01 == "002"
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO, SB1.B1_AXCONC AS CONCENTRACAO "
Else
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO "
EndIf
_cQuery += ",      SUM(SD1.D1_QUANT*SB1.B1_CONV) AS SALDO "
_cQuery += ",      SZS.ZS_UM AS UNIDADE "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += _cRet
_cQuery += "INNER JOIN " + RetSqlName("SD1") + " SD1 "
_cQuery += "ON SB1.B1_COD = SD1.D1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SF1") + " SF1 "
_cQuery += "ON SD1.D1_DOC = SF1.F1_DOC AND SD1.D1_SERIE = SF1.F1_SERIE AND SD1.D1_FORNECE = SF1.F1_FORNECE "
_cQuery += "WHERE SZS.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' AND SD1.D_E_L_E_T_ = ' ' "
_cQuery += "AND SUBSTRING(SD1.D1_DTDIGIT,1,6) > '" + cData + "' "
_cQuery += "AND SF1.F1_STATUS <> ' ' "
If MV_PAR01 == "002"
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO, SB1.B1_AXCONC "
Else
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO "
EndIf
_cQuery += "UNION ALL "
_cQuery += "SELECT 'SAIDAS' AS TIPO "
_cQuery += ",      SZS.ZS_ORGAO AS ORGAO "
_cQuery += ",      SZS.ZS_CON AS CODIGO "
If MV_PAR01 == "002"
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO, SB1.B1_AXCONC AS CONCENTRACAO "
Else
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO "
EndIf
_cQuery += ",      SUM(SD2.D2_QUANT*SB1.B1_CONV) AS SALDO "
_cQuery += ",      SZS.ZS_UM AS UNIDADE "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += _cRet
_cQuery += "INNER JOIN " + RetSqlName("SD2") + " SD2 "
_cQuery += "ON SB1.B1_COD = SD2.D2_COD "
_cQuery += "WHERE SZS.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' AND SD2.D_E_L_E_T_ = ' ' "
_cQuery += "AND SUBSTRING(SD2.D2_EMISSAO,1,6) > '" + cData + "' "
If MV_PAR01 == "002"
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO, SB1.B1_AXCONC "
Else
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO "
EndIf
_cQuery += "UNION ALL "
_cQuery += "SELECT 'REQUISITADO' AS TIPO "
_cQuery += ",      SZS.ZS_ORGAO AS ORGAO "
_cQuery += ",      SZS.ZS_CON AS CODIGO "
If MV_PAR01 == "002"
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO, SB1.B1_AXCONC AS CONCENTRACAO "
Else
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO "
EndIf
_cQuery += ",      SUM(SD3.D3_QUANT*SB1.B1_CONV) AS SALDO "
_cQuery += ",      SZS.ZS_UM AS UNIDADE "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += _cRet
_cQuery += "INNER JOIN " + RetSqlName("SD3") + " SD3 "
_cQuery += "ON SB1.B1_COD = SD3.D3_COD "
_cQuery += "INNER JOIN " + RetSqlName("SF5") + " SF5 "
_cQuery += "ON SD3.D3_TM = SF5.F5_CODIGO AND SF5.F5_TIPO = 'R' "
_cQuery += "WHERE SZS.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' AND SD3.D_E_L_E_T_ = ' ' "
_cQuery += "AND SUBSTRING(SD3.D3_EMISSAO,1,6) > '" + cData + "' "
If MV_PAR01 == "002"
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO, SB1.B1_AXCONC "
Else
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO "
EndIf
_cQuery += "UNION ALL "
_cQuery += "SELECT 'ENT_EST' AS TIPO "
_cQuery += ",      SZS.ZS_ORGAO AS ORGAO "
_cQuery += ",      SZS.ZS_CON AS CODIGO "
If MV_PAR01 == "002"
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO, SB1.B1_AXCONC AS CONCENTRACAO "
Else
	_cQuery += ",      SZS.ZS_DESCR AS CLASSIFICACAO "
EndIf
_cQuery += ",      SUM(SD3.D3_QUANT*SB1.B1_CONV) AS SALDO "
_cQuery += ",      SZS.ZS_UM AS UNIDADE "
_cQuery += "FROM " + RetSqlName("SZS") + " SZS "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += _cRet
_cQuery += "INNER JOIN " + RetSqlName("SD3") + " SD3 "
_cQuery += "ON SB1.B1_COD = SD3.D3_COD "
_cQuery += "INNER JOIN " + RetSqlName("SF5") + " SF5 "
_cQuery += "ON SD3.D3_TM = SF5.F5_CODIGO AND SF5.F5_TIPO <> 'R' "
_cQuery += "WHERE SZS.D_E_L_E_T_ = ' ' AND SB1.D_E_L_E_T_ = ' ' AND SD3.D_E_L_E_T_ = ' ' "
_cQuery += "AND SUBSTRING(SD3.D3_EMISSAO,1,6) > '" + cData + "' "
If MV_PAR01 == "002"
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO, SB1.B1_AXCONC) X "
Else
	_cQuery += "GROUP BY SZS.ZS_DESCR, SZS.ZS_CON, SZS.ZS_UM, SZS.ZS_ORGAO) X "
EndIf
If MV_PAR01 == "002"
	_cQuery += "GROUP BY TIPO, ORGAO, CODIGO, CLASSIFICACAO, UNIDADE, CONCENTRACAO) Y "
Else
	_cQuery += "GROUP BY TIPO, ORGAO, CODIGO, CLASSIFICACAO, UNIDADE) Y "
EndIf
IF MV_PAR01 == "002"
	_cQuery += "GROUP BY ORGAO, CODIGO, CLASSIFICACAO, UNIDADE, CONCENTRACAO "
Else
	_cQuery += "GROUP BY ORGAO, CODIGO, CLASSIFICACAO, UNIDADE "
EndIf
_cQuery += "ORDER BY CODIGO "
If MV_PAR01 == "002"
	_cQuery += ", CONCENTRACAO "
EndIf

TcQuery _cQuery New Alias "QR1"

If MV_PAR01 == "002"
	TcSetField("QR1","SALDO"            ,"N",12,3)
	TcSetField("QR1","ENTRADAS"         ,"N",12,3)
	TcSetField("QR1","SAIDAS"           ,"N",12,3)
	TcSetField("QR1","REQUISITADO"      ,"N",12,3)
	TcSetField("QR1","ENT_EST"          ,"N",12,3)
	TcSetField("QR1","CONCENTRACAO"     ,"N",03,2)
Else
	TcSetField("QR1","SALDO"            ,"N",12,3)
	TcSetField("QR1","ENTRADAS"         ,"N",12,3)
	TcSetField("QR1","SAIDAS"           ,"N",12,3)
	TcSetField("QR1","REQUISITADO"      ,"N",12,3)
	TcSetField("QR1","ENT_EST"          ,"N",12,3)
EndIf


oPrint:= TMSPrinter():New( "Estoque produtos controlados" )
oPrint:SetPortrait() // ou SetLandscape()

QR1->(DbGoTop())

nLin      := 32
nInc      := 470
nPercent  := 0

Do While ! QR1->(Eof())
	If nLin > 31
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
±±ºPrograma  ³fFormCab  ºAutor  ³Ocimar Rolli        º Data ³  09/10/14   º±±
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
oPrint:Say(nRowIni+0050,nColIni+0950,_cOrgao                                                           ,oFont21N)
oPrint:Say(nRowIni+0200,nColIni+0950,"SALDO FINAL - EM : "+DtoC(MV_PAR02)                              ,oFont21N)

// BOX E CABECALHO DOS DETALHES
oPrint:Box(nRowIni+0350,nColIni+0010,nRowFim-2510,nColFim-0010)
oPrint:Say(nRowIni+0370,nColIni+0050,"CLASSIFICACAO"                                                   ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+0480,nRowFim-2510,nColIni+0480)
oPrint:Say(nRowIni+0370,nColIni+0500,"UNID."                                                           ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+0600,nRowFim-2510,nColIni+0600)
oPrint:Say(nRowIni+0370,nColIni+0630,"SALDO DATA"                                                      ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+0850,nRowFim-2510,nColIni+0850)
oPrint:Say(nRowIni+0370,nColIni+0900,"VENDAS"                                                          ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+1100,nRowFim-2510,nColIni+1100)
oPrint:Say(nRowIni+0370,nColIni+1140,"COMPRAS"                                                         ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+1350,nRowFim-2510,nColIni+1350)
oPrint:Say(nRowIni+0370,nColIni+1400,"SAIDAS"                                                          ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+1600,nRowFim-2510,nColIni+1600)
oPrint:Say(nRowIni+0370,nColIni+1620,"ENTRADAS"                                                        ,oFont10N)
oPrint:Line(nRowIni+0350,nColIni+1850,nRowFim-2510,nColIni+1850)
oPrint:Say(nRowIni+0370,nColIni+1900,"SALDO ATUAL"                                                     ,oFont10N)

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
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fFormDet()

// Calcula o percentual

nSalData := (QR1->SALDO+QR1->SAIDAS-QR1->ENTRADAS+QR1->REQUISITADO-QR1->ENT_EST)

// DETALHES

oPrint:Box( nRowIni+nInc,nColIni+0010,nRowIni+0080+nInc,nColFim-0010)
oPrint:Line(nRowIni+nInc,nColIni+0480,nRowIni+0080+nInc,nColIni+0480)
oPrint:Line(nRowIni+nInc,nColIni+0600,nRowIni+0080+nInc,nColIni+0600)
oPrint:Line(nRowIni+nInc,nColIni+0850,nRowIni+0080+nInc,nColIni+0850)
oPrint:Line(nRowIni+nInc,nColIni+1100,nRowIni+0080+nInc,nColIni+1100)
oPrint:Line(nRowIni+nInc,nColIni+1350,nRowIni+0080+nInc,nColIni+1350)
oPrint:Line(nRowIni+nInc,nColIni+1600,nRowIni+0080+nInc,nColIni+1600)
oPrint:Line(nRowIni+nInc,nColIni+1850,nRowIni+0080+nInc,nColIni+1850)

If MV_PAR01 == "002"
	oPrint:Say(nRowIni+10+nInc,nColIni+0050,QR1->CLASSIFICACAO                                     ,oFont8CN)
	oPrint:Say(nRowIni+40+nInc,nColIni+0050,Transform(QR1->CONCENTRACAO,"@e 999.99")               ,oFont8CN)
Else
	oPrint:Say(nRowIni+20+nInc,nColIni+0050,QR1->CLASSIFICACAO                                     ,oFont8CN)
EndIf
oPrint:Say(nRowIni+20+nInc,nColIni+0530,QR1->UNIDADE                                               ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+0650,Transform(nSalData        ,"@e 999,999.999")               ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+0900,Transform(QR1->SAIDAS     ,"@e 999,999.999")               ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1150,Transform(QR1->ENTRADAS   ,"@e 999,999.999")               ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1400,Transform(QR1->REQUISITADO,"@e 999,999.999")               ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1650,Transform(QR1->ENT_EST    ,"@e 999,999.999")               ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1920,Transform(QR1->SALDO      ,"@e 999,999.999")               ,oFont8CN)

nLin ++
nInc += 0080

If nLin > 31
	oPrint:EndPage()
	nLin := 1
	nInc := 470
	fFormCab()
EndIf

Return()
