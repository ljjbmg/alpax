/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR019   บAutor  ณOcimar Rolli        บ Data ณ  11/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de Emissao de selos do Ministerio do Exercito     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function FATR019()

_cPerg := "FATR19"

PutSx1(_cPerg,"01","Data de" ,"Data de" ,"Data de" ,"mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Data ate","Data ate","Data ate","mv_ch2","D",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr011() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImpr011  บAutor  ณOcimar Rolli        บ Data ณ  11/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de processamento do relatorio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImpr011()

Private nColIni 	:= 0100
Private nColFim 	:= 3100
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

_cQuery :="SELECT D2_DOC AS GUIA, D2_AXDTGT AS DTSELO, D2_AXGUTR AS SELO, (D2_QUANT*B1_CONV) AS QUANT, B1_SEGUM AS UNIDADE, ZS_DESCR AS DESCRICAO, C6_XAUTORI AS AUTORI "
_cQuery +="       FROM "+RetSqlName("SD2")+" D2 "
_cQuery +="            INNER JOIN "+RetSqlName("SC6")+" C6 "
_cQuery +="                  ON D2_PEDIDO = C6_NUM AND D2_ITEMPV = C6_ITEM "
_cQuery +="            INNER JOIN "+RetSqlName("SB1")+" B1 "
_cQuery +="                  ON D2_COD = B1_COD "
_cQuery +="            INNER JOIN "+RetSqlName("SZS")+" ZS "
_cQuery +="                  ON B1_AXCTEXE = ZS_CON AND ZS_ORGAO = '001' "
_cQuery +="       WHERE D2.D_E_L_E_T_ = ' ' AND B1_AXCTEXE <> ' ' "
_cQuery +="             AND D2_AXDTGT BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02) + "' "
_cQuery +="             AND D2_AXGUTR NOT LIKE '%ISE%' "                                                                                                           
_cQuery +="ORDER BY D2_AXDTGT, D2_AXGUTR "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","GUIA"        ,"C",09,0)
TcSetField("QR1","DTSELO"      ,"D",08,0)
TcSetField("QR1","SELO"        ,"C",15,0)
TcSetField("QR1","QUANT"       ,"N",12,3)
TcSetField("QR1","UNIDADE"     ,"C",03,0)
TcSetField("QR1","DESCRICAO"   ,"C",30,0)

oPrint:= TMSPrinter():New( "Mapa de Selos do Exercito" )
oPrint:SetLandscape() // ou SetPortrait()

nLin      := 1

Do While ! QR1->(Eof())
	If nLin == 1  
		nPos := 820
		fFormCab()
		fFormRod()
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
ฑฑบPrograma  ณfFormCab  บAutor  ณOcimar Rolli        บ Data ณ  11/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta formulario completo, para preencher coom os dados.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fFormCab()

oPrint:StartPage()

// BOX EXTERNO
oPrint:Box(nRowIni,nColIni,nRowFim,nColFim)

// BOX CABECALHO 1
//oPrint:Box(nRowIni+0010,nColIni+0010,nRowIni+200,nColFim-0010)
oPrint:Say(nRowIni+0050,nColIni+0050,"Excelentissimo Senhor"    					       ,oFont12N)
oPrint:Say(nRowIni+0100,nColIni+0050,"Comandante da 2. Regiao Militar"		 		       ,oFont12N)
oPrint:Say(nRowIni+0150,nColIni+0050,"Sao Paulo - SP"  						 		       ,oFont12N)

// BOX CABECALHO 2
//oPrint:Box(nRowIni+0210,nColIni+0010,nRowIni+400,nColFim-0010)
oPrint:Say(nRowIni+0260,nColIni+0700,"MAPA DE EMISSAO DE SELOS DE AUTENTICIDADE" 	       ,oFont20N)

// BOX CABECALHO 3
oPrint:Box(nRowIni+0400,nColIni+0010,nRowIni+0500,nColFim-0010)
oPrint:Line(nRowIni+0500,nColIni+0750,nRowIni+0600,nColIni+0750)
oPrint:Say(nRowIni+0430,nColIni+0050,"EMPRESA " 									       ,oFont12N)
oPrint:Say(nRowIni+0430,nColIni+0300," : "     										       ,oFont12N)
oPrint:Say(nRowIni+0435,nColIni+0350,"ALPAX COM. DE PRODUTOS P/ LABORATORIOS LTDA."        ,oFont11C)
oPrint:Box(nRowIni+0500,nColIni+0010,nRowIni+0600,nColFim-0010)
oPrint:Say(nRowIni+0530,nColIni+0050,"TR / CR "                                            ,oFont12N)
oPrint:Say(nRowIni+0530,nColIni+0300," : "                                                 ,oFont12N)
oPrint:Say(nRowIni+0535,nColIni+0350,"14865 "    								           ,oFont11C)
oPrint:Box(nRowIni+0600,nColIni+0010,nRowIni+0700,nColFim-0010)
oPrint:Say(nRowIni+0630,nColIni+0050,"PERIODO "                                            ,oFont12N)
oPrint:Say(nRowIni+0630,nColIni+0300," : "                                                 ,oFont12N)
oPrint:Say(nRowIni+0635,nColIni+0350,"DE : "+DtoC(MV_PAR01)+"       ATE : "+DtoC(MV_PAR02) ,oFont11C)
oPrint:Line(nRowIni+0400,nColIni+1550,nRowIni+0700,nColIni+1550)
oPrint:Say(nRowIni+0530,nColIni+0800,"VALIDADE "                                           ,oFont12N)
oPrint:Say(nRowIni+0530,nColIni+1050," : "                                                 ,oFont12N)
oPrint:Say(nRowIni+0535,nColIni+1100,"18/02/2012"    						               ,oFont11C)
oPrint:Say(nRowIni+0430,nColIni+1600,"E-MAIL "                                             ,oFont12N)
oPrint:Say(nRowIni+0430,nColIni+1950," : "                                                 ,oFont12N)
oPrint:Say(nRowIni+0435,nColIni+2000,"ALPAX@ALPAX.COM.BR"    							   ,oFont11C)
oPrint:Say(nRowIni+0530,nColIni+1600,"RESPONSAVEL "                                        ,oFont12N)
oPrint:Say(nRowIni+0530,nColIni+1950," : "                                                 ,oFont12N)
oPrint:Say(nRowIni+0535,nColIni+2000,"SRA. LUCI AKEMI MASUMOTO "    					   ,oFont11C)
oPrint:Say(nRowIni+0630,nColIni+1600,"TELEFONE "                                           ,oFont12N)
oPrint:Say(nRowIni+0630,nColIni+1950," : "                                                 ,oFont12N)
oPrint:Say(nRowIni+0635,nColIni+2000,"4057-9200 "    								       ,oFont11C)


// BOX DETALHES - CABECALHO
oPrint:Box(nRowIni+0710,nColIni+0010,nRowIni+0810,nColFim-0010)
oPrint:Say(nRowIni+0740,nColIni+0050,"N. GT"                                               ,oFont12N)
oPrint:Line(nRowIni+0710,nColIni+0250,nRowIni+0810,nColIni+0250)
oPrint:Say(nRowIni+0740,nColIni+0300,"DATA GT"                                             ,oFont12N)
oPrint:Line(nRowIni+0710,nColIni+0510,nRowIni+0810,nColIni+0510)
oPrint:Say(nRowIni+0740,nColIni+0570,"N. SELO"	                                           ,oFont12N)
oPrint:Line(nRowIni+0710,nColIni+0850,nRowIni+0810,nColIni+0850)
oPrint:Say(nRowIni+0740,nColIni+0940,"PRODUTO CONTROLADO"                                  ,oFont12N)
oPrint:Line(nRowIni+0710,nColIni+1550,nRowIni+0810,nColIni+1550)
oPrint:Say(nRowIni+0740,nColIni+1600,"GRUPO"                                               ,oFont12N)
oPrint:Line(nRowIni+0710,nColIni+1800,nRowIni+0810,nColIni+1800)
oPrint:Say(nRowIni+0740,nColIni+1840,"QUANTIDADE"	                                       ,oFont12N)
oPrint:Line(nRowIni+0710,nColIni+2150,nRowIni+0810,nColIni+2150)
oPrint:Say(nRowIni+0740,nColIni+2200,"KG / L"                                              ,oFont12N)
oPrint:Line(nRowIni+0710,nColIni+2400,nRowIni+0810,nColIni+2400)
oPrint:Say(nRowIni+0740,nColIni+2550,"OBSERVACAO"                                          ,oFont12N)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfFormDet  บAutor  ณOcimar Rolli        บ Data ณ  11/07/11   บฑฑ
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

_cAutori := IIf(QR1->AUTORI=" "," ","AUTORIZACAO ESPECIAL")

// BOX DETALHES - ITENS

oPrint:Box(nRowIni+nPos+0010,nColIni+0010,nRowIni+nPos+100,nColFim-0010)
oPrint:Say(nRowIni+nPos+0020,nColIni+0020,QR1->GUIA                                        ,oFont11C)
oPrint:Line(nRowIni+nPos+0010,nColIni+0250,nRowIni+nPos+100,nColIni+0250)
oPrint:Say(nRowIni+nPos+0020,nColIni+0300,DtoC(QR1->DTSELO)                                ,oFont11C)
oPrint:Line(nRowIni+nPos+0010,nColIni+0510,nRowIni+nPos+100,nColIni+0510)
oPrint:Say(nRowIni+nPos+0020,nColIni+0570,QR1->SELO                         	           ,oFont11C)
oPrint:Line(nRowIni+nPos+0010,nColIni+0850,nRowIni+nPos+100,nColIni+0850)
oPrint:Say(nRowIni+nPos+0020,nColIni+0940,QR1->DESCRICAO                                   ,oFont11C)
oPrint:Line(nRowIni+nPos+0010,nColIni+1550,nRowIni+nPos+100,nColIni+1550)
oPrint:Line(nRowIni+nPos+0010,nColIni+1800,nRowIni+nPos+100,nColIni+1800)
oPrint:Say(nRowIni+nPos+0020,nColIni+1860,Transform(QR1->QUANT,"@e 999.999")               ,oFont11C)
oPrint:Line(nRowIni+nPos+0010,nColIni+2150,nRowIni+nPos+100,nColIni+2150)
oPrint:Say(nRowIni+nPos+0020,nColIni+2230,QR1->UNIDADE                                     ,oFont11C)
oPrint:Line(nRowIni+nPos+0010,nColIni+2400,nRowIni+nPos+100,nColIni+2400)
oPrint:Say(nRowIni+nPos+0020,nColIni+2500,_cAutori                                         ,oFont11C)

nPos += 100
nLin ++

If nLin == 11
	nLin := 1
	fFormRod()
	oPrint:EndPage()
EndIf

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfFormRod  บAutor  ณOcimar Rolli        บ Data ณ  11/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rodape do relatorio.                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fFormRod()

// BOX RODAPE


_aTab := {"JANEIRO","FEVEREIRO","MARวO","ABRIL","MAIO","JUNHO","JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}

_cDia := Strzero(Day(dDataBase),2)
_cMes := _aTab[Month(dDataBase)]
_cAno := Strzero(Year(dDataBase),4)


oPrint:Box(nRowFim-0390,nColIni+0010,nRowFim-0010,nColFim-0010)
oPrint:Line(nRowFim-0390,nColIni+1550,nRowFim-0010,nColIni+1550)
oPrint:Line(nRowFim-0290,nColIni+1550,nRowFim-0290,nColFim-0010)
oPrint:Line(nRowFim-0100,nColIni+1550,nRowFim-0100,nColFim-0010)
oPrint:Say(nRowFim-0150,nColIni+0050,"ATENCAO : ENTREGAR NO SFPC/2 ATE O DIA 5 DO MES SUBSEQUENTE"        ,oFont11C)
oPrint:Say(nRowFim-0340,nColIni+1750,"DIADEMA , SP, "+_cDia+" de "+_cMes+" de "+_cAno                     ,oFont11C)
oPrint:Say(nRowFim-0075,nColIni+1850,"TERESA CRISTINA FERREIRA VILLELA - SOCIA"                           ,oFont11C)


Return()
