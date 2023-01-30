/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR014   บAutor  ณAdriano Luis Brandaoบ Data ณ  03/11/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de Ordem de servico interna por pedido e grupo de บฑฑ
ฑฑบ          ณcalibracao.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function FATR014()

_cPerg := "FATR14"

PutSx1(_cPerg,"01","Pedido de" ,"Pedido de" ,"Pedido de" ,"mv_ch1","C",06,0,0,"G","","SC5","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Pedido ate","Pedido ate","Pedido ate","mv_ch2","C",06,0,0,"G","","SC5","","","mv_par02","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr014() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImpr014  บAutor  ณAdriano Luis Brandaoบ Data ณ  03/11/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de processamento do relatorio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImpr014()

Private nColIni 	:= 0100
Private nColFim 	:= 2250
Private nRow		:= 0100
Private nRowFim 	:= 2650
Private nRowPage	:= 3000
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
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)

_cQuery := "SELECT B1_AXLABOR, C6_NUM, (C6_QTDVEN - C6_QTDENT) AS SALDO, C6_DESCRI, C6_ENTREG, C6_CLI, C6_LOJA, C6_AXPTCAL, B1_PNUMBER, B1_CAPACID, "
_cQuery += "       C6_AXTIPCA, B1_MARCA, C6_AXTOLER, CASE C6_AXTIPCA WHEN 'N' THEN 'Nao calibrado' WHEN 'I' THEN 'Rastreavel'  "
_cQuery += "       WHEN 'R' THEN 'RBC' ELSE 'Nao Calibrado' END AS CALIB "
_cQuery += "       FROM " + RetSqlName("SC6")+" C6 "
_cQuery += "             INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                        ON B1_FILIAL = '" + xFilial("SB1") + "' AND C6_PRODUTO = B1_COD "
_cQuery += "       WHERE C6_FILIAL = '" + xFilial("SC6") + "' "
_cQuery += "             AND C6_NUM BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' AND C6_LOCAL = 'SL' "
_cQuery += "             AND C6.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND B1_AXLABOR <> ' ' "
_cQuery += "             AND (C6_QTDVEN-C6_QTDENT) > 0 AND C6_BLQ <> 'R'"
_cQuery += "       ORDER BY C6_NUM, B1_AXLABOR, C6_AXTIPCA "

TcQuery _cQuery New Alias "QR1"
                                                          	
TcSetField("QR1","C6_ENTREG","D",8,0)

oPrint:= TMSPrinter():New( "Ordem de servico interna" )
oPrint:SetPortrait() // ou SetLandscape()


Do While ! QR1->(Eof())
	_cNum := QR1->C6_NUM
	_aItens := 	{}
	SA1->(DbSeek(xFilial("SA1")+QR1->C6_CLI+QR1->C6_LOJA))                       
	
	Do While ! QR1->(Eof()) .And. _cNum == QR1->C6_NUM
		_cLabor := QR1->B1_AXLABOR
		_cTipCal := QR1->C6_AXTIPCA
		_lPrimeiro := .t.
		_nItem	:= 1
		_nLimItem := 7
		_nItens := _nLimItem+1
		nPag	:= 1
		
		Do While ! QR1->(Eof()) .And. _cNum == QR1->C6_NUM .And. QR1->B1_AXLABOR == _cLabor .And. QR1->C6_AXTIPCA = _cTipCal
			
			_cQuery := "SELECT B1_AXLABOR, COUNT(*) AS ITENS"
			_cQuery += "       FROM " + RetSqlName("SC6")+" C6 "
			_cQuery += "             INNER JOIN " + RetSqlName("SB1") + " B1 "
			_cQuery += "                        ON B1_FILIAL = '" + xFilial("SB1") + "' AND C6_PRODUTO = B1_COD "
			_cQuery += "       WHERE C6_FILIAL = '" + xFilial("SC6") + "' "
			_cQuery += "             AND C6_NUM = '" + QR1->C6_NUM + "' AND C6_LOCAL = 'SL' AND B1_AXLABOR = '" + _cLabor + "' "
			_cQuery += "             AND C6.D_E_L_E_T_ = ' '  AND B1_AXLABOR <> ' ' "
			_cQuery += "       GROUP BY B1_AXLABOR "
			
			TcQuery _cQuery New Alias "QR2"
			
			TcSetField("QR2","ITENS","N",5,0)
			
			_nPagina := (QR2->ITENS/_nLimItem)
			If _nPagina <> int(_nPagina)
				_nPagina := int(_nPagina)+1
			EndIf
			
			QR2->(DbCloseArea())
			
			// se passou de 10 itens salta pagina.
			
			If _nItens > _nLimItem
				If ! _lPrimeiro
					oPrint:EndPage()
				EndIf
				// Imprime o formulario completo e retorna o numero de linha do item de material
				nRow := fForm()                                                                                
				nPag++
				_nItens := 1
			EndIf
			
			_lPrimeiro := .f.
			// Imprimir o item           
			
			oPrint:Say(nRow+0040,nColIni+040,Strzero(_nItem,3),oFont8)
			oPrint:Say(nRow+0040,nColIni+0200,Transform(QR1->SALDO,"@e 9,999,999.99"),oFont8)
			oPrint:Say(nRow-020,nColIni+0410,QR1->C6_DESCRI,oFont8)
			oPrint:Say(nRow+030,nColIni+0410,"Referencia: " + QR1->B1_PNUMBER + " Capacidade: " + QR1->B1_CAPACID,oFont8)
			oPrint:Say(nRow+030,nColIni+1140,"Marca: " + QR1->B1_MARCA,oFont8)
			oPrint:Say(nRow+030,nColIni+1610,"Tipo de calibracao: "+ QR1->CALIB,oFont8)
			oPrint:Say(nRow+080,nColIni+0410,"Ponto de calibracao: "+iif(Empty(QR1->C6_AXPTCAL),"Padrao",QR1->C6_AXPTCAL),oFont8)
			oPrint:Say(nRow+080,nColIni+1140,"Tolerancia: "+iif(Empty(QR1->C6_AXTOLER),"Padrao",QR1->C6_AXTOLER),oFont8)
//			oPrint:Say(nRow,nColIni+1960,Dtoc(QR1->C6_ENTREG),oFont8)
			_nItem++
			_nItens++
			
			nRow+=0150
			QR1->(DbSkip())
		EndDo
		oPrint:EndPage()
	EndDo
EndDo

QR1->(DbCloseArea())
oPrint:Preview()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfForm     บAutor  ณAdriano Luis Brandaoบ Data ณ  03/11/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta formulario completo, para preencher coom os dados.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fForm()

oPrint:StartPage()

oPrint:Say(005,nColFim-300,"Pagina : " + Alltrim(Str(nPag,3,0)) + " de " + Alltrim(Str(_nPagina,3,0)),oFont10n)
nRow := 0050
oPrint:box(nRow,ncolIni,nRow+0250,ncolFim)
oPrint:Line(nRow+0125,nColIni+1600,nRow+0125,nColFim)
oPrint:Line(nRow,nColIni+0700,nRow+0250,nColIni+0700)
oPrint:Line(nRow,nColIni+1600,nRow+0250,nColIni+1600)
oPrint:SayBitmap(nRow+10,nColIni+10,"\system\logo_alpax.bmp",600,170)

oPrint:Say(nRow+0100,nColIni+0780,"ORDEM DE SERVIวO INTERNA",oFont14N)
oPrint:Say(nRow+0020,nColIni+1620,"O.S. Nr.",oFont12N)
oPrint:Say(nRow+0135,nColIni+1620,"Emitida em " + Dtoc(dDataBase),oFont12N)

nRow+=280

// Bloco de dados do solicitante e dados do contratante.
oPrint:Box(nRow,nColIni,nRow+0300,nColFim)
oPrint:Line(nRow,nColIni+0300,nRow+0300,nColIni+0300)
For _nZ := (nRow+050) To nRow+0250 Step 0050
	oPrint:Line(_nZ,nColIni+0300,_nZ,nColFim)
Next _nZ
oPrint:Line(nRow+0150,nColIni,nRow+0150,nColIni+0300)
oPrint:Line(nRow+0100,nColIni+1200,nRow+0150,nColIni+1200)
oPrint:Line(nRow+0100,nColIni+1700,nRow+0150,nColIni+1700)
oPrint:Line(nRow+0250,nColIni+1200,nRow+0300,nColIni+1200)
oPrint:Line(nRow+0250,nColIni+1700,nRow+0300,nColIni+1700)

oPrint:Say(nRow+0070,nColIni+030,"Solicitante",oFont10N)
oPrint:Say(nRow+0200,nColIni+030,"Contratante",oFont10N)

oPrint:Say(nRow+0002,nColIni+0310,"Nome:",oFont10n)
oPrint:Say(nRow+0052,nColIni+0310,"Endere็o:",oFont10n)
oPrint:Say(nRow+0102,nColIni+0310,"Cidade/Estado:",oFont10n)
oPrint:Say(nRow+0102,nColIni+1210,"Telefone:",oFont10n)
oPrint:Say(nRow+0102,nColIni+1710,"Fax:",oFont10n)
oPrint:Say(nRow+0152,nColIni+0310,"Nome: " + SA1->A1_NOME,oFont10n)
oPrint:Say(nRow+0202,nColIni+0310,"Endere็o: " + Alltrim(SA1->A1_END)+"-"+Alltrim(SA1->A1_BAIRRO),oFont10n)
oPrint:Say(nRow+0252,nColIni+0310,"Cidade/Estado: " + Alltrim(SA1->A1_MUN) + "-" + SA1->A1_EST,oFont10n)
oPrint:Say(nRow+0252,nColIni+1210,"Telefone: " + Alltrim(SA1->A1_TEL),oFont10n)
oPrint:Say(nRow+0252,nColIni+1710,"Fax: " + Alltrim(SA1->A1_FAX),oFont10n)
nRow+=310
// bloco com numero do pedido de vendas.
oPrint:Box(nRow,nColIni,nRow+0100,nColFim)
oPrint:Say(nRow+0005,nColIni+0010,"Nr.do Pedido Interno: " + _cNum,oFont14N)
nRow+=0150

// bloco dos itens em branco.
oPrint:Box(nRow,nColIni,nRow+1180,nColFim)
For _nZ := (nRow+130) To nRow+1180 Step 150
	oPrint:Line(_nZ,nColIni,_nZ,nColFim)
Next _nZ
oPrint:Line(nRow,nColIni+0150,nRow+1180,nColIni+0150)
oPrint:Line(nRow,nColIni+0400,nRow+1180,nColIni+0400)
//oPrint:Line(nRow,nColIni+1450,nRow+1130,nColIni+1450)
//oPrint:Line(nRow,nColIni+1700,nRow+1130,nColIni+1700)
//oPrint:Line(nRow,nColIni+1950,nRow+1130,nColIni+1950)

oPrint:Say(nRow+005,nColIni+0020,"ITEM"                 ,oFont12N)
oPrint:Say(nRow+005,nColIni+0165,"QUANTID."             ,oFont12N)
oPrint:Say(nRow+050,nColIni+0165,"RECEBIDA"             ,oFont12N)
oPrint:Say(nRow+040,nColIni+0900,"DESCRIวAO DO MATERIAL/ SERVICO",oFont12N)
//oPrint:Say(nRow+005,nColIni+1460,"   TIPO   "           ,oFont10N)
//oPrint:Say(nRow+050,nColIni+1460,"CALIBRAวAO"           ,oFont10N)
//oPrint:Say(nRow+005,nColIni+1710," PONTO DE "           ,oFont10N)
//oPrint:Say(nRow+050,nColIni+1710,"CALIBRAวAO"           ,oFont10N)
//oPrint:Say(nRow+005,nColIni+1958," TOLERAN- "           ,oFont10N)
//oPrint:Say(nRow+050,nColIni+1958,"   CIA    "           ,oFont10N)

nRet := nRow+150
nRow+=1180

// Bloco do Vendedor
oPrint:Box(nRow,nColIni,nRow+0070,nColFim)
oPrint:Say(nRow+0005,nColIni+0010,"Vendedor : "+Posicione("SC5",1,xFilial("SC5")+QR1->C6_NUM,"C5_AXATEND"),oFont11N)
oPrint:Say(nRow+0005,nColIni+1800,"____/____/____",oFont11N)

nRow+=0120

// Bloco da Entrada e Saida Laboratorio.
oPrint:Box(nRow,nColIni,nRow+0400,nColFim)
For _nZ := (nRow+100) To (nRow+0300) Step 100
	oPrint:Line(_nZ,nColIni,_nZ,nColFim)
Next _nZ

oPrint:Line(nRow,nColIni+1100,nRow+0400,nColIni+1100)
oPrint:Say(nRow+0005,nColIni+0300,"LABORATORIO (ENTRADA)",oFont12N)
oPrint:Say(nRow+0005,nColIni+1400,"LABORATORIO (SAIDA)",oFont12N)
oPrint:Say(nRow+0105,nColIni+0010,"Recebido Por:",oFont11N)
oPrint:Say(nRow+0105,nColIni+1110,"Recebido Por:",oFont11N)
oPrint:Say(nRow+0205,nColIni+0010,"Entregue Por:",oFont11N)
oPrint:Say(nRow+0205,nColIni+1110,"Entregue Por:",oFont11N)
oPrint:Say(nRow+0305,nColIni+0010,"Data do Recebimento ____/____/____",oFont11N)
oPrint:Say(nRow+0305,nColIni+1110,"Data da Retira ____/____/____",oFont11N)
nRow+=450

oPrint:Box(nRow,nColIni,nRow+300,nColFim)
oPrint:Say(nRow+0005,nColIni+0010,"OBSERVAวีES",oFont12N)
nRow+=0350

oPrint:Box(nRow,nColIni,nRow+0100,nColFim)
oPrint:Say(nRow+0005,nColIni+0010,"ANALISADO CRITICAMENTE POR:",oFont12N)
oPrint:Say(nRow+0120,nColIni+1900,"Anexo 03 - Rev. 09",oFont8)

Return(nRet)