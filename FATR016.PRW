/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR016   ºAutor  ³Ocimar Rolli        º Data ³  13/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de Tabela de preços                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function FATR016()

_cPerg := "FATR16"

PutSx1(_cPerg,"01","Tabela" ,"Tabela" ,"Tabela" ,"mv_ch1","C",03,0,0,"G",""   ,"","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Marca"  ,"Marca"  ,"Marca"  ,"mv_ch2","C",15,0,0,"G","","SZ2","","","mv_par02","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr011() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr011  ºAutor  ³Ocimar Rolli        º Data ³  13/04/11   º±±
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

_cQuery := "SELECT DA0.DA0_DESCRI "
_cQuery += ",      B1_PNUMBER "
_cQuery += ",      B1_DESC "
_cQuery += ",      B1_CAPACID "
_cQuery += ",      B1_MARCA "
_cQuery += ",      DA1_PRCVEN "
_cQuery += ",      DA0.DA0_ATIVO "
_cQuery += ",      DA0_DATDE "
_cQuery += ",      DA0.DA0_DATATE "
_cQuery += "    FROM " + RetSqlName("DA1")+" DA1 "
_cQuery += "        INNER JOIN " + RetSqlName("DA0")+" DA0 "
_cQuery += "            ON DA0.DA0_FILIAL = '" + xFilial("DA0") + "' AND DA1.DA1_CODTAB = DA0.DA0_CODTAB "
_cQuery += "        INNER JOIN " + RetSqlName("SB1")+" SB1 "
_cQuery += "            ON SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND DA1_CODPRO = SB1.B1_COD "
_cQuery += "    WHERE SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND DA1.DA1_CODTAB = '" + MV_PAR01 + "' "
_cQuery += "        AND DA1.D_E_L_E_T_ = ' ' AND DA0.D_E_L_E_T_ = ' ' "
If ! empty(MV_PAR02)
	_cQuery += "        AND SB1.B1_MARCA = '"+MV_PAR02+"' "
EndIf
_cQuery += "    ORDER BY B1_MARCA, B1_PNUMBER"

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","DA0_DATDE" ,"D",08,0)
TcSetField("QR1","DA0_DATATE","D",08,0)
TcSetField("QR1","DA1_PRCVEN","N",12,2)

oPrint:= TMSPrinter():New( "Tabela de Preços" )
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
±±ºPrograma  ³fFormCab  ºAutor  ³Ocimar Rolli        º Data ³  13/04/11   º±±
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
oPrint:Say(nRowIni+0040,nColIni+0050,"Alpax Com. Prods. p/ Labs. Ltda."    								 ,oFont12)
oPrint:Say(nRowIni+0020,nColIni+1000,"TABELA DE PREÇOS - "+QR1->DA0_DESCRI 					 			 ,oFont20N)
oPrint:Say(nRowIni+0040,nColIni+2400,"Vigencia -  de "+DToC(QR1->DA0_DATDE)+" ate "+DToC(QR1->DA0_DATATE),oFont12)

// BOX DETALHES - CABECALHO
oPrint:Box(nRowIni+0110,nColIni+0010,nRowIni+200,nColFim-0010)
oPrint:Say(nRowIni+0140,nColIni+0050,"Referencia"    								 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+0500,"Produto" 		   								 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+2000,"Capacidade" 	   								 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+2300,"Marca"    	    							 ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+2900,"Preço"   		  								 ,oFont12N)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormDet  ºAutor  ³Ocimar Rolli        º Data ³  13/05/11   º±±
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

// BOX DETALHES - ITENS
oPrint:Box(nRowIni+nPos+0010,nColIni+0010,nRowIni+nPos+100,nColFim-0010)
oPrint:Say(nRowIni+nPos+0040,nColIni+0050,QR1->B1_PNUMBER   								 ,oFont10)
oPrint:Say(nRowIni+nPos+0040,nColIni+0500,QR1->B1_DESC	   							  		 ,oFont10)
oPrint:Say(nRowIni+nPos+0040,nColIni+2000,QR1->B1_CAPACID   								 ,oFont10)
oPrint:Say(nRowIni+nPos+0040,nColIni+2300,QR1->B1_MARCA   									 ,oFont10)
oPrint:Say(nRowIni+nPos+0040,nColIni+2900,Transform(QR1->DA1_PRCVEN,"@e 999,999.99")		 ,oFont10)

nPos += 100
nLin ++

If nLin == 21
	nLin := 1
	oPrint:EndPage()
EndIf

Return()
