/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR025   ºAutor  ³Ocimar Rolli        º Data ³  25/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de tabela de precos.                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function FATR025()

_cPerg := "FATR25"

PutSx1(_cPerg,"01","Codigo da tabela" ,"Codigo da tabela" ,"Codigo da tabela" ,"mv_ch1","C",03,0,0,"G","","DA0","","","mv_par01","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr025() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr025  ºAutor  ³Ocimar Rolli        º Data ³  25/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de processamento do relatorio.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr025()

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

_cQuery := "SELECT B1_COD AS CODIGO "
_cQuery += ",      B1_PNUMBER AS REFERENCIA "
_cQuery += ",      B1_MARCA AS MARCA "
_cQuery += ",      B1_DESC AS PRODUTO "
_cQuery += ",      B1_CAPACID AS CAPACIDADE "
_cQuery += ",      DA1_PRCVEN AS PRECO "
_cQuery += ",      DA0_DESCRI AS DESCRICAO "
_cQuery += ",      DA0_DATATE AS VIGENCIA "
_cQuery += "       FROM " + RetSqlName("SB1")+" SB1 "
_cQuery += "              INNER JOIN " + RetSqlName("DA1")+" DA1 "
_cQuery += "                      ON SB1.B1_COD = DA1.DA1_CODPRO " 
_cQuery += "              INNER JOIN " + RetSqlName("DA0")+" DA0 "
_cQuery += "                      ON DA1.DA1_CODTAB = DA0.DA0_CODTAB "
_cQuery += "       WHERE SB1.D_E_L_E_T_ = ' ' "
_cQuery += "       AND   DA1.D_E_L_E_T_ = ' ' " 
_cQuery += "       AND   DA0.D_E_L_E_T_ = ' ' "
_cQuery += "       AND   DA1.DA1_CODTAB = '" + MV_PAR01 + "' " 
_cQuery += "       ORDER BY MARCA, REFERENCIA "

TcQuery _cQuery New Alias "QR1"
                                                          	
TcSetField("QR1","PREÇO"      ,"N",12,2)
TcSetField("QR1","VIGENCIA"   ,"D",08,0)

oPrint:= TMSPrinter():New( "Tabela de preco" )
oPrint:SetPortrait() // ou SetLandscape()

nLin      := 26 
nInc      := 970
nMarca    := " "

Do While ! QR1->(Eof())
	If nLin > 25 
		nLin := 1
		nInc := 970
		nMarca := QR1->MARCA
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
±±ºPrograma  ³fFormCab  ºAutor  ³Ocimar Rolli        º Data ³  25/03/14   º±±
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
oPrint:Say(nRowIni+0050,nColIni+1050,"TABELA DE PREÇO"                                                 ,oFont21N)
oPrint:Box(nRowIni+0350,nColIni+0800,nRowIni+0450,nColFim-0250)
oPrint:Say(nRowIni+0360,nColIni+0300,"TABELA : "                                                       ,oFont21N)
oPrint:Say(nRowIni+0360,nColIni+0900,QR1->DESCRICAO                                                    ,oFont21N)
oPrint:Box(nRowIni+0500,nColIni+0800,nRowIni+0600,nColFim-0250)
oPrint:Say(nRowIni+0510,nColIni+0300,"MARCA  : "                                                       ,oFont21N)
oPrint:Say(nRowIni+0510,nColIni+0900,QR1->MARCA                                                        ,oFont21N)
oPrint:Box(nRowIni+0650,nColIni+0800,nRowIni+0750,nColFim-0250)
oPrint:Say(nRowIni+0660,nColIni+0300,"VIGÊNCIA : "                                                     ,oFont21N)
oPrint:Say(nRowIni+0660,nColIni+0900,DtoC(QR1->VIGENCIA)                                               ,oFont21N)

// BOX E CABECALHO DOS DETALHES
oPrint:Box(nRowIni+0850,nColIni+0010,nRowFim-2010,nColFim-0010)
oPrint:Say(nRowIni+0870,nColIni+0060,"CODIGO "                                                         ,oFont10N)
oPrint:Line(nRowIni+0850,nColIni+0320,nRowFim-2010,nColIni+0320)
oPrint:Say(nRowIni+0870,nColIni+0350,"REFERENCIA "                                                     ,oFont10N)
oPrint:Line(nRowIni+0850,nColIni+0620,nRowFim-2010,nColIni+0620)
oPrint:Say(nRowIni+0870,nColIni+0650,"PRODUTO"                                                         ,oFont10N)
oPrint:Line(nRowIni+0850,nColIni+1800,nRowFim-2010,nColIni+1800)
oPrint:Say(nRowIni+0870,nColIni+1900,"PREÇO"                                                           ,oFont10N)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormDet  ºAutor  ³Ocimar Rolli        º Data ³  25/03/14   º±±
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

// DETALHES

oPrint:Box( nRowIni+nInc,nColIni+0010,nRowIni+0080+nInc,nColFim-0010)
oPrint:Line(nRowIni+nInc,nColIni+0320,nRowIni+0080+nInc,nColIni+0320)
oPrint:Line(nRowIni+nInc,nColIni+0620,nRowIni+0080+nInc,nColIni+0620)
oPrint:Line(nRowIni+nInc,nColIni+1800,nRowIni+0080+nInc,nColIni+1800)
oPrint:Say(nRowIni+20+nInc,nColIni+0040,QR1->CODIGO                                                ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+0350,QR1->REFERENCIA                                            ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+0650,AllTrim(QR1->PRODUTO)+" - "+AllTrim(QR1->CAPACIDADE)       ,oFont8CN)
//oPrint:Say(nRowIni+nInc,nColIni+1600,QR1->CAPACIDADE                                            ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColIni+1860,"R$ "                                                      ,oFont8CN)
oPrint:Say(nRowIni+20+nInc,nColFim-0220,Transform(QR1->PRECO,"@e 9,999,999.99")                    ,oFont8CN) 

nLin ++
nInc += 0080

	If nLin > 25 .Or. nMarca <> QR1->MARCA
		oPrint:EndPage()
		nLin := 1
		nInc := 970
		nMarca := QR1->MARCA		
		fFormCab()
	EndIf

Return()