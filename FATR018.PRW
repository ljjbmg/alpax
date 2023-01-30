/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR018   ºAutor  ³Ocimar Rolli        º Data ³  01/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de Lucratividade                                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Protheus.ch"
                                                                      
User Function FATR018()

_cPerg := "FATR18"

PutSx1(_cPerg,"01","Mes","Mes","Mes","mv_ch1","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Ano","Ano","Ano","mv_ch2","C",04,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr011() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr011  ºAutor  ³Ocimar Rolli        º Data ³  01/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de processamento do relatorio.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr011()

Private nColIni 	:= 0100
Private nColFim 	:= 3300
Private nRowIni		:= 0050
Private nRowFim 	:= 2270
Private nIndice     := 0
Private oPrint, _nItem, _nItens, nPag

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8CN	:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11N	:= TFont():New("Arial"			,09,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14 	:= TFont():New("Arial"			,13,14,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)

_cQuery :="SELECT A3_NOME AS REPRESENTANTE
_cQuery +=",      SUBSTRING(D2.D2_EMISSAO,5,2) AS MES
_cQuery +=",      (Sum(D2.D2_TOTAL)+sum(D2_VALIPI)+SUM(D2_VALFRE)) AS FATURADO
_cQuery +=",      SUM(B1_AXCUS*D2_QUANT) AS CUSTO
_cQuery +=",      SUM(D2.D2_TOTAL-(B1_AXCUS*D2_QUANT)) AS LUCRO
_cQuery +="    FROM "+RetSqlName("SD2")+" D2 "
_cQuery +="        INNER JOIN "+RetSqlName("SC6")+" C6 "
_cQuery +="            ON    D2_PEDIDO = C6_NUM AND D2_ITEMPV = C6_ITEM "
_cQuery +="        INNER JOIN "+RetSqlName("SC5")+" C5 "
_cQuery +="            ON    C6_NUM = C5_NUM "
_cQuery +="        INNER JOIN "+RetSqlName("SF4")+" F4 "
_cQuery +="            ON    D2_TES = F4_CODIGO "
_cQuery +="        INNER JOIN "+RetSqlName("SB1")+" B1 "
_cQuery +="            ON    D2_COD = B1_COD "
_cQuery +="        INNER JOIN "+RetSqlName("SA3")+" A3 "
_cQuery +="            ON    C5_VEND1 = A3_COD  "
_cQuery +="    WHERE (D2.D_E_L_E_T_=' ') AND (C5.D_E_L_E_T_=' ') AND (B1.D_E_L_E_T_=' ') AND C6.D_E_L_E_T_ = ' ' "
_cQuery +="        AND   F4_DUPLIC = 'S' "
_cQuery +="        AND (MONTH(D2_EMISSAO)) = '" + MV_PAR01 + "' "
_cQuery +="        AND (YEAR(D2_EMISSAO)) = '" + MV_PAR02 + "' "
_cQuery +="        AND A3_COD NOT IN ('000032','000063') "
_cQuery +="    GROUP BY SUBSTRING(D2.D2_EMISSAO,5,2), A3_NOME "
_cQuery +="    ORDER BY (Sum(D2.D2_TOTAL)/SUM(B1_AXCUS*D2_QUANT)) DESC "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","FATURADO"  ,"N",12,2)
TcSetField("QR1","CUSTO"     ,"N",12,2)
TcSetField("QR1","LUCRO"     ,"N",12,2)                                                            

oPrint:= TMSPrinter():New( "Lucro por representante" )
oPrint:SetLandscape() // ou SetPortrait()

nLin      := 1

Do While ! QR1->(Eof())
	If nLin == 1
		fFormCab()
		nPos := 200
	EndIf
	fFormDet()
	QR1->(DbSkip())
EndDo
QR1->(DbCloseArea())

oPrint:Preview()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormCab  ºAutor  ³Ocimar Rolli        º Data ³  01/06/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta formulario completo, para preencher coom os dados.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fFormCab()

oPrint:StartPage()

// BOX EXTERNO
oPrint:Box(nRowIni,nColIni,nRowFim,nColFim)

// BOX CABECALHO
oPrint:Box(nRowIni+0010,nColIni+0010,nRowIni+100,nColFim-0010)
oPrint:Say(nRowIni+0040,nColIni+0050,"Alpax Com. Prods. p/ Labs. Ltda."    								 ,oFont12N)
oPrint:Say(nRowIni+0020,nColIni+1000,"LUCRO FATURAMENTO POR REPRESENTANTE"					 			 ,oFont20N)
oPrint:Say(nRowIni+0040,nColIni+2600,"Mes - "+MV_PAR01+"     Ano - "+MV_PAR02   						 ,oFont12N)

// BOX DETALHES - CABECALHO
oPrint:Box(nRowIni+0110,nColIni+0010,nRowIni+200,nColFim-0010)
oPrint:Say(nRowIni+0140,nColIni+0050,"Representante"   								 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+0750,"Faturado" 	   								 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+1350,"Custo"	 	   								 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+1950,"Lucro"    	    							 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+2550,"Indice"  		  								 ,oFont12N)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormDet  ºAutor  ³Ocimar Rolli        º Data ³  01/06/11   º±±
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

nIndice := (((QR1->FATURADO/QR1->CUSTO)-1)*100)

// BOX DETALHES - ITENS
oPrint:Box(nRowIni+nPos+0010,nColIni+0010,nRowIni+nPos+100,nColFim-0010)
oPrint:Say(nRowIni+nPos+0040,nColIni+0050,QR1->REPRESENTANTE								 ,oFont12N)
oPrint:Say(nRowIni+nPos+0040,nColIni+0745,"R$ "+Transform(QR1->FATURADO,"@e 999,999.99")	 ,oFont12N)
oPrint:Say(nRowIni+nPos+0040,nColIni+1345,"R$ "+Transform(QR1->CUSTO,"@e 999,999.99")		 ,oFont12N)
oPrint:Say(nRowIni+nPos+0040,nColIni+1945,"R$ "+Transform(QR1->LUCRO,"@e 999,999.99")		 ,oFont12N)
oPrint:Say(nRowIni+nPos+0040,nColIni+2545,Transform(nIndice,"@e 999,999.99")+" %"			 ,oFont12N)

nPos += 100
nLin ++

If nLin == 21
	nLin := 1
	oPrint:EndPage()
EndIf

Return()
