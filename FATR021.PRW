/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR021   บAutor  ณOcimar Rolli        บ Data ณ  10/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio Mapa de venda de nitrato de amonio                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function FATR021()

_cPerg := "FATR21"

PutSx1(_cPerg,"01","Data de" ,"Data de" ,"Data de" ,"mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Data ate","Data ate","Data ate","mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr011() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImpr011  บAutor  ณOcimar Rolli        บ Data ณ  10/08/11   บฑฑ
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

Private nColIni 	:= 0040
Private nColFim 	:= 2320
Private nRowIni		:= 0040
Private nRowFim 	:= 3140
Private oPrint, _nItem, _nItens, nPag

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10C	:= TFont():New("Courier New"	,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11N	:= TFont():New("Courier New"	,09,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12S	:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.T.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14 	:= TFont():New("Arial"			,13,14,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16S	:= TFont():New("Arial"			,15,16,.T.,.F.,5,.T.,5,.T.,.T.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)


_cQuery :="SELECT D2_EMISSAO AS DATANF, (D2_QUANT*B1_CONV) AS QUANT, SUBSTRING(A1_NOME,1,41) AS CLIENTE "
_cQuery +=",      (RTRIM(A1_END)) AS ENDERECO, (RTRIM(A1_BAIRRO)+' - '+RTRIM(A1_MUN)+' - '+RTRIM(A1_EST)) AS CIDADE, A1_CGC AS CNPJ "
_cQuery +=",      ZU_NRLIC AS LICENCA, D2_DOC AS NOTA, ZU_TPLIC AS TIPO "
_cQuery +="       FROM "+RetSqlName("SD2")+" D2 " 
_cQuery +="            INNER JOIN  "+RetSqlName("SA1")+" A1 "
_cQuery +="                  ON D2_CLIENTE = A1_COD "
_cQuery +="            INNER JOIN  "+RetSqlName("SC6")+" C6 "
_cQuery +="                  ON D2_PEDIDO = C6_NUM AND D2_ITEMPV = C6_ITEM "
_cQuery +="            INNER JOIN  "+RetSqlName("SB1")+" B1 "
_cQuery +="                  ON D2_COD = B1_COD "
_cQuery +="            LEFT JOIN  "+RetSqlName("SZU")+" ZU "
_cQuery +="                  ON A1_COD = ZU_CLIENTE AND ZU_ORGAO = '001' AND ZU_CLASS = B1_AXCTEXE "
_cQuery +="       WHERE D2.D_E_L_E_T_ = ' ' AND D2_EMISSAO BETWEEN '" + DtoS(MV_PAR01) +" ' AND '" + DtoS(MV_PAR02) + "' "
_cQuery +="             AND B1_AXCTEXE = '002830' AND ZU.D_E_L_E_T_ = ' ' AND ZU_TPLIC = 'N' "
_cQuery +="UNION ALL "
_cQuery +="SELECT D2_EMISSAO AS DATANF, (D2_QUANT*B1_CONV) AS QUANT, SUBSTRING(A1_NOME,1,41) AS CLIENTE "
_cQuery +=",      (RTRIM(A1_END)) AS ENDERECO, (RTRIM(A1_BAIRRO)+' - '+RTRIM(A1_MUN)+' - '+RTRIM(A1_EST)) AS CIDADE, A1_CGC AS CNPJ "
_cQuery +=",      ZU_NRLIC AS LICENCA, D2_DOC AS NOTA, ZU_TPLIC AS TIPO "
_cQuery +="       FROM "+RetSqlName("SD2")+" D2 " 
_cQuery +="            INNER JOIN  "+RetSqlName("SA1")+" A1 "
_cQuery +="                  ON D2_CLIENTE = A1_COD "
_cQuery +="            INNER JOIN  "+RetSqlName("SC6")+" C6 "
_cQuery +="                  ON D2_PEDIDO = C6_NUM AND D2_ITEMPV = C6_ITEM "
_cQuery +="            INNER JOIN  "+RetSqlName("SB1")+" B1 "
_cQuery +="                  ON D2_COD = B1_COD "
_cQuery +="            LEFT JOIN  "+RetSqlName("SZU")+" ZU "
_cQuery +="                  ON A1_COD = ZU_CLIENTE AND ZU_ORGAO = '001' AND ZU_CLASS = B1_AXCTEXE AND ZU_PEDIDO = D2_PEDIDO "
_cQuery +="       WHERE D2.D_E_L_E_T_ = ' ' AND D2_EMISSAO BETWEEN '" + DtoS(MV_PAR01) +" ' AND '" + DtoS(MV_PAR02) + "' "
_cQuery +="             AND B1_AXCTEXE = '002830' AND ZU.D_E_L_E_T_ = ' ' AND ZU_TPLIC = 'E' "
_cQuery +="       ORDER BY D2_EMISSAO"

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","PRODUTO"        ,"C",20,0)
TcSetField("QR1","DATANF"         ,"D",08,0)
TcSetField("QR1","QUANT"          ,"N",09,3)
TcSetField("QR1","CLIENTE"        ,"C",41,0)                                         
TcSetField("QR1","ENDERECO"       ,"C",50,0)
TcSetField("QR1","CIDADE"         ,"C",30,0)
TcSetField("QR1","CNPJ"           ,"C",14,0)
TcSetField("QR1","LICENCA"        ,"C",20,0)
TcSetField("QR1","NOTA"           ,"N",09,0)
TcSetField("QR1","TIPO"           ,"C",01,0)

oPrint:= TMSPrinter():New( "Mapa de nitrato de amonio" )
oPrint:SetPortrait() // SetLandscape()

nLin      := 1
nPos      := 1070

Do While ! QR1->(Eof())
	If nLin == 1
		nPos := 1070
		fFormCab()
		fFormRod()
	EndIf
	fFormDet()
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

oPrint:Preview()

Return()


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


_aTab := {"JANEIRO","FEVEREIRO","MARวO","ABRIL","MAIO","JUNHO","JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}
_cMes := _aTab[Month(MV_PAR02)]
_cAno := Strzero(Year(MV_PAR02),4)

oPrint:StartPage()

// BOX CABECALHO 1
oPrint:Box(nRowIni,nColIni,nRowFim,nColFim)
oPrint:Say(nRowIni+0050,nColIni+1000,"ANEXO II"                             		                      					   ,oFont11N)
oPrint:Say(nRowIni+0150,nColIni+0650,"MAPA DE VENDA DE NITRATO DE AMONIO"   		                   						   ,oFont11N)
oPrint:Say(nRowIni+0250,nColIni+0300,"EMPRESA VENDEDORA  : ALPAX COMERCIO DE PRODUTOS PARA LABORATORIOS LTDA."                 ,oFont11N)
oPrint:Say(nRowIni+0350,nColIni+0300,"ENDEREวO : RUA SERRA DA BORBOREMA 40, CAMPANARIO - DIADEMA, ESTADO DE SP,"               ,oFont11N)
oPrint:Say(nRowIni+0450,nColIni+0750,"REGISTRO NO EXERCITO : 14865 "                                                           ,oFont11N)
oPrint:Say(nRowIni+0650,nColIni+0350,"NITRATO DE AMONIO VENDIDO NO MES DE  "+_cMes+" DO ANO DE  "+_cAno 					   ,oFont11N)

// BOX E CABECALHO DOS DETALHES
oPrint:Box(nRowIni+0850,nColIni+0010,nRowFim-1230,nColFim-0010)
oPrint:Say(nRowIni+0870,nColIni+0050,"PRODUTO "                                                            ,oFont11N)
oPrint:Say(nRowIni+0920,nColIni+0050,"VENDIDO "                                                            ,oFont11N)
oPrint:Say(nRowIni+0970,nColIni+0090,"(1)"                                                                 ,oFont11N)
oPrint:Line(nRowIni+0850,nColIni+0280,nRowFim-1230,nColIni+0280)
oPrint:Say(nRowIni+0870,nColIni+0320,"DATA DA"                                                             ,oFont11N)
oPrint:Say(nRowIni+0920,nColIni+0320," VENDA "                                                             ,oFont11N)
oPrint:Line(nRowIni+0850,nColIni+0520,nRowFim-1230,nColIni+0520)
oPrint:Say(nRowIni+0870,nColIni+0550,"QUANTIDADE"                                                          ,oFont11N)
oPrint:Say(nRowIni+0920,nColIni+0610,"(KG)"                                                                ,oFont11N)
oPrint:Line(nRowIni+0850,nColIni+0810,nRowFim-1230,nColIni+0810)
oPrint:Say(nRowIni+0870,nColIni+1180,"COMPRADOR"                                                           ,oFont11N)
oPrint:Say(nRowIni+0920,nColIni+1250,"(2)"                                                                 ,oFont11N)
oPrint:Line(nRowIni+0850,nColIni+1740,nRowFim-1230,nColIni+1740)
oPrint:Say(nRowIni+0870,nColIni+1755,"NUM. DO CR"                                                          ,oFont11N)
oPrint:Say(nRowIni+0920,nColIni+1840,"(4)"                                                                 ,oFont11N)
oPrint:Line(nRowIni+0850,nColIni+2000,nRowFim-1230,nColIni+2000)                                                           
oPrint:Say(nRowIni+0870,nColIni+2020,"OBSERVACAO"                                                          ,oFont11N)
oPrint:Say(nRowIni+0920,nColIni+2100,"(3)"                                                                 ,oFont11N)
oPrint:Line(nRowIni+1050,nColIni+0010,nRowIni+1050,nColFim-0010)

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

// BOX DETALHES - ITENS
oPrint:Say(nRowIni+nPos,nColIni+0030,"NITRATO DE "                                                         ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+0320,DtoC(QR1->DATANF)                                                     ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+0600,Transform(QR1->QUANT,"@e 999.999")                                    ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+0830,QR1->CLIENTE                                                          ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+1750,Iif(QR1->TIPO == 'E',"AUT. ESP.",QR1->LICENCA)                        ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+2020,"INDUSTRIAL"                                                          ,oFont10C)
nPos += 50
nLin ++
oPrint:Say(nRowIni+nPos,nColIni+0070,"AMONIO"                                                              ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+1750,Iif(QR1->TIPO == 'E',QR1->LICENCA,"     ")                            ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+0830,QR1->ENDERECO                                                         ,oFont10C)
nPos += 50
nLin ++
oPrint:Say(nRowIni+nPos,nColIni+0830,QR1->CIDADE                                                           ,oFont10C)
nPos += 50
nLin ++
oPrint:Say(nRowIni+nPos,nColIni+0830,"CNPJ : "                                                             ,oFont10C)
oPrint:Say(nRowIni+nPos,nColIni+0980,Transform(QR1->CNPJ,"@R 99.999.999/9999-99")                          ,oFont10C)
nPos += 50
nLin ++
oPrint:Line(nRowIni+nPos,nColIni+0010,nRowIni+nPos,nColFim-0010)

If nLin >= 16
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

_aTab1 := {"JANEIRO","FEVEREIRO","MARวO","ABRIL","MAIO","JUNHO","JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}
_cDia1 := Strzero(Day(dDataBase),2)
_cMes1 := _aTab1[Month(dDataBase)]
_cAno1 := Strzero(Year(dDataBase),4)

oPrint:Say(nRowFim-1000,nColIni+0250,"Diadema , "+_cDia1+" de "+_cMes1+" de "+_cAno1                                                      ,oFont11C)
oPrint:Line(nRowFim-0800,nColIni+0600,nRowFim-0800,nColIni+1690)
oPrint:Say(nRowFim-0780,nColIni+0800,"SRA. LUCI AKEMI MASUMOTO"                                                                           ,oFont11C)
oPrint:Say(nRowFim-0730,nColIni+0600,"R.G. 7.700.270-2   CPF 111.805.808-93   SOCIA"                                                      ,oFont11C)
oPrint:Say(nRowFim-0500,nColIni+0150,"Obs : "                                                                                             ,oFont10C)              
oPrint:Say(nRowFim-0450,nColIni+0150,"(1)Na coluna destinada ao produto vendido citar o tipo de NA, se denso(uso agricola) ou de baixa "  ,oFont10C)
oPrint:Say(nRowFim-0400,nColIni+0150,"densidade(utilizado na producao de explosivos). "                                                   ,oFont10C)
oPrint:Say(nRowFim-0350,nColIni+0150,"(Ex:NA baixa densidade ou NA denso)."                                                               ,oFont10C)
oPrint:Say(nRowFim-0300,nColIni+0150,"(2)O comprador devera ser identificado com o nome e endereco."                                      ,oFont10C)
oPrint:Say(nRowFim-0250,nColIni+0150,"(3)Citar a finalidade do NA vendido, se para fins agricola ou industrial."                          ,oFont10C)
oPrint:Say(nRowFim-0200,nColIni+0150,"(4)Quando o comprador for isento de registro, de acordo com o art. 11 desta Portaria, colocar "     ,oFont10C)
oPrint:Say(nRowFim-0150,nColIni+0150,"'isento de registro' na coluna destinado ao numero do CR."                                          ,oFont10C)

Return()
