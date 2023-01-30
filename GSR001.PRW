/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGSR001    บAutor  ณOcimar Rolli        บ Data ณ  21/10/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaturamento por linha  .                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function GSR001()

_cPerg := "GSR001"

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
Private oPrint, nLin
Private cMarca      := ""

// Fontes utilizadas no relatorio.
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont10 	:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont08 	:= TFont():New("Arial"			,08,08,.T.,.F.,5,.T.,5,.T.,.F.)

// Variavel pra determinar se ้ uma marca ou varias
If mv_par04 <> mv_par05
	cMarca := "Varias marcas"
Else
	cMarca := ALLTRIM(MV_PAR04)
EndIf

_cQuery := "SELECT D2_DOC AS NOTA "
_cQuery += ",      A1_NREDUZ AS CLIENTE "
_cQuery += ",      D2_EMISSAO AS EMISSAO "
_cQuery += ",      RTRIM(B1_DESC)+' - '+RTRIM(B1_CAPACID)+' - '+RTRIM(B1_MARCA) AS PRODUTO "
_cQuery += ",      D2_LOTECTL AS LOTE "
_cQuery += ",      D2_QUANT AS QUANT "
_cQuery += ",      CJ_AXNOMCT AS CONTATO "
_cQuery += ",      A1_DDD AS DDD "
_cQuery += ",      A1_TEL AS FONE "
_cQuery += ",      U5_EMAIL AS EMAIL "
_cQuery += ",      B1_PNUMBER AS REFER "
_cQuery += "FROM SD2010 SD2 "
_cQuery += "INNER JOIN SF2010 SF2 "
_cQuery += "ON D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE AND D2_CLIENTE = F2_CLIENTE "
_cQuery += "INNER JOIN SC6010 SC6 "
_cQuery += "ON D2_PEDIDO = C6_NUM AND D2_ITEMPV = C6_ITEM "
_cQuery += "INNER JOIN SCK010 SCK "
_cQuery += "ON C6_NUMORC = (CK_NUM + CK_ITEM) "
_cQuery += "INNER JOIN SA1010 SA1 "
_cQuery += "ON D2_CLIENTE = A1_COD "
_cQuery += "INNER JOIN SCJ010 SCJ "
_cQuery += "ON CK_NUM = CJ_NUM "
_cQuery += "INNER JOIN SB1010 SB1 "
_cQuery += "ON D2_COD = B1_COD "
_cQuery += "INNER JOIN SF4010 SF4 "
_cQuery += "ON D2_TES = F4_CODIGO "
_cQuery += "INNER JOIN SU5010 SU5 "
_cQuery += "ON CJ_AXCTATO = U5_CODCONT "
_cQuery += "WHERE SCK.D_E_L_E_T_ = ' ' "
_cQuery += "AND SC6.D_E_L_E_T_ = ' ' "
_cQuery += "AND SD2.D_E_L_E_T_ = ' ' "
_cQuery += "AND SCJ.D_E_L_E_T_ = ' ' "
_cQuery += "AND SB1.D_E_L_E_T_ = ' ' "
_cQuery += "AND SF2.D_E_L_E_T_ = ' ' "
_cQuery += "AND SF4.D_E_L_E_T_ = ' ' "
_cQuery += "AND SU5.D_E_L_E_T_ = ' ' "
_cQuery += "AND SC6.C6_BLOQUEI <> 'R' "
_cQuery += "AND F4_DUPLIC = 'S' "
_cQuery += "AND D2_EMISSAO BETWEEN '"+DtoS(MV_PAR01)+"' AND '"+DtoS(MV_PAR02)+"' "
_cQuery += "AND B1_DESC LIKE '%"+ALLTRIM(MV_PAR03)+"%' "
_cQuery += "AND B1_MARCA BETWEEN '"+ALLTRIM(MV_PAR04)+"' AND '"+ALLTRIM(MV_PAR05)+"' "
_cQuery += "ORDER BY D2_DOC, D2_COD "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","EMISSAO"     ,"D",12,2)
TcSetField("QR1","LOTE"        ,"C",15,0)
TcSetField("QR1","QUANT"       ,"N",12,2)

oPrint:= TMSPrinter():New( "VENDIDO" )
oPrint:SetLandscape() // ou SetPortrait()

nLin      := 1
nInc      := 100

Do While ! QR1->(Eof())
	If nLin == 1
		fFormCab()
	EndIf
	fFormDet()
	QR1->(DbSkip())
EndDo
QR1->(DbCloseArea())

oPrint:Preview()

Return

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
oPrint:Say(nRowIni+0080,nColIni+1100,ALLTRIM(MV_PAR03)+" com venda entre "+DTOC(MV_PAR01)+" e "+DTOC(MV_PAR02)                 ,oFont10N)
oPrint:Box(nRowIni+0050,nColIni+1000,nRowIni+0150,nColFim-0100)
oPrint:Say(nRowIni+0180,nColIni+1100,"Marca : "+cMarca                                                                         ,oFont10N)
oPrint:Box(nRowIni+0150,nColIni+1000,nRowIni+250,nColFim-0100)

// BOX E CABECALHO DOS DETALHES
oPrint:Box(nRowIni+0300,nColIni+0010,nRowIni+0400,nColFim-0010)
oPrint:Say(nRowIni+0325,nColIni+0060,"NOTA "                                                           ,oFont10N)
oPrint:Say(nRowIni+0325,nColIni+0300,"CLIENTE "                                                        ,oFont10N)
oPrint:Say(nRowIni+0325,nColIni+0870,"REFERENCIA"                                                      ,oFont10N)
oPrint:Say(nRowIni+0325,nColIni+1120,"PRODUTO"                                                         ,oFont10N)
oPrint:Say(nRowIni+0325,nColIni+2500,"LOTE"                                                            ,oFont10N)
oPrint:Say(nRowIni+0325,nColIni+2750,"QUANT."                                                          ,oFont10N)

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

oPrint:Box(nRowIni+0300+nInc,nColIni+0010,nRowIni+0500+nInc,nColFim-0010)
oPrint:Say(nRowIni+0325+nInc,nColIni+0060,QR1->NOTA                                                           ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+0300,QR1->CLIENTE                                                        ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+0870,QR1->REFER                                                          ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+1120,QR1->PRODUTO                                                        ,oFont08)
oPrint:Say(nRowIni+0325+nInc,nColIni+2500,QR1->LOTE                                                           ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+2800,Transform(QR1->QUANT,"@e 9999")                                     ,oFont10)
nInc += 0100
oPrint:Say(nRowIni+0325+nInc,nColIni+0060,DTOC(QR1->EMISSAO)                                                  ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+0300,"CONTATO : "+QR1->CONTATO                                           ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+1100,"DDD : ("+ALLTRIM(QR1->DDD)+")"                                     ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+1300,"FONE : "+QR1->FONE                                                 ,oFont10)
oPrint:Say(nRowIni+0325+nInc,nColIni+1900,"EMAIL : "+QR1->EMAIL                                               ,oFont10)

nLin ++
nInc += 0100

If nLin == 10
	nLin := 1
	nInc := 0100
	oPrint:EndPage()
EndIf

Return()
