/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR009   ºAutor  ³  Ocimar            º Data ³  28/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Lucratividade de faturamento baseado no preco de compra    º±±
±±º          ³ no cadastro de produtos                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP -ALPAX                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Protheus.ch"
#Include "Topconn.ch"  

User Function FATR009()

If APMsgYesNo("Confirma a impressao do relatorio ")
	MsgRun("Aguarde Gerando relatorio",,{|| fProcessa() })
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³          ºAutor  ³  Ocimar            º Data ³  28/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ processamento dos dados para impressao.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - alpax.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fProcessa()

Local _cDesc1 		:= 0
Local _cDesc2		:= 0           
Local _aDesc		:= {}
Local _nY

Private _nPixL, _nICMS, _lPrimeiro, oPrint
Private _nPag		:= 0
Private nColIni 	:= 0050
Private nColFim 	:= 2200
Private nRowFim 	:= 2600
Private nRowPage	:= 3000
Private	_nTotal		:= 0

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8CN	:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
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

// Posicionamento das tabelas de consulta
SD2->(DbSetOrder(1))
SB1->(DbSetOrder(1))
SF4->(DbSetOrder(1))

_cQuery := "SELECT D2_DOC AS NF, "
_cQuery += "       SUM(D2_TOTAL) AS VENDA, "
_cQuery += "       SUM(B1_AXCUS*D2_QUANT) AS COMPRA, "
_cQuery += "       ((SUM(D2_TOTAL)/SUM(B1_AXCUS*D2_QUANT))-1)*100 AS LUCRATIVIDADE "
_cQuery += "FROM " + RetSqlName("SD2") + "D2 "
_cQuery += "         INNER JOIN " + RetSqlNAme("SB1") + " B1 "
_cQuery += "                 ON B1_COD = D2_COD AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "         INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "                 ON F4_CODIGO = D2_TES AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "WHERE D2.D_E_L_E_T_ = ' ' AND B1_AXCUS <> 0 AND D2_QUANT <> 0 AND F4_DUPLIC = 'S' "
_cQuery += "      AND D2_EMISSAO BETWEEN '20061201' AND '20061231' "
_cQuery += "GROUP BY D2_DOC, D2_PEDIDO

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D2_DOC"	     ,"N",06,00)
TcSetField("QR1","VENDA"    	 ,"N",12,02)
TcSetField("QR1","COMPRA"   	 ,"N",12,02)
TcSetField("QR1","LUCRATIVIDADE" ,"N",05,02)

_nPixL := 6000
_lPrimeiro := .t.

oPrint:= TMSPrinter():New( "Lucratividade do Faturamento" )
oPrint:SetPortrait() // ou SetLandscape()

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	If _nPixL >= (nRowFim-40)
		If ! _lPrimeiro
			oPrint:EndPage()
		EndIf
		// Imprime formulario e cabecalho do relatorio.
		_lPrimeiro := .f.
		_nPixL := _fForm()
	EndIf
	For _nY := 1 To Len(_cDescr) Step 35
		aAdd(_aDesc,Substr(_cDescr,_nY,35))
	Next _nY
	
	oPrint:Say(_nPixL,nColIni+0050,QR1->D2_DOC																		,oFont8CN)
	oPrint:Say(_nPixL,nColIni+1130,Transform(QR1->VENDA,"@e 999,999.99")											,oFont8CN)
	oPrint:Say(_nPixL,nColIni+1330,Transform(QR1->COMPRA,"@e 999,999.99")   										,oFont8CN)
	oPrint:Say(_nPixL,nColIni+1410,Transform(QR1->LUCRATIVIDADE,"@e 9,999.99")										,oFont8CN)
	_nPixL+=40
	If Len(_aDesc) > 1
		For _nY := 2 To Len(_aDesc)
			If _nPixL >= (nRowFim-40)
				oPrint:EndPage()
				// Imprime formulario e cabecalho do relatorio.
				_nPixL := _fForm()
			EndIf
			oPrint:Say(_nPixL,nColIni+0430,_aDesc[_nY]																	,oFont8CN)
			_nPixL+=40                 
		Next _nY
	EndIf
	
	QR1->(dbskip())
	
EndDo

QR1->(DbCloseArea())


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fform    ºAutor  ³ Ociamr             º Data ³  28/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³monta o cabecalho com o formulario completo.                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fForm()

Local _nRet 	:= 0
Local nRow1 	:= 0050 // Linha para retorno

_nPag++

oPrint:StartPage() 		// Inicia uma nova pagina

// Impressao do cabecalho.

oPrint:SayBitmap(nRow1,nColIni,"\system\logo_alpax.bmp",600,170) 
oPrint:Say(nRow1	,nColIni+1600,"Lucratividade" 	   															,oFont18N)
oPrint:Say(nRow1+080,nColIni+1700,"Emissao:" + Dtoc(SCJ->CJ_EMISSAO)											,oFont14N)

// box dos itens, linhas verticais dos itens e quadro do rodape
oPrint:box(nRow1,ncolIni,nRowFim,ncolFim)                      
oPrint:box(nRowFim+10,ncolIni,nRowPage,ncolFim)                      
// Linhas verticais do cabecalho
oPrint:Line(nRow1,nColIni+0400,nRow1+0210,nColIni+0400)
oPrint:Line(nRow1,nColIni+1100,nRow1+0140,nColIni+1100)
oPrint:Line(nRow1,nColIni+1500,nRow1+0140,nColIni+1500)
oPrint:Line(nRow1+0210,nColIni,nRow1+0210,nColIni+0400)
// titulos das linhas
oPrint:Say(nRow1+0020,nColIni+0050,"Pedido Cliente"																	,oFont10N)
oPrint:Say(nRow1+0090,nColIni+0050,"Condição Pagto."																,oFont10N)
oPrint:Say(nRow1+0160,nColIni+0050,"Observação"																		,oFont10N)
oPrint:Say(nRow1+0020,nColIni+1150,"Valid.Proposta"																	,oFont10N)
oPrint:Say(nRow1+0090,nColIni+1150,"Frete"																			,oFont10N)
//oPrint:Say(nRow1+0160,nColIni+1150,"Fone Transp."																	,oFont10N)
// Campos do cabecalho nas tabelas ja pre-posicionadas.
oPrint:Say(nRow1+0020,nColIni+0430,QR1->CJ_AXPEDCL																	,oFont10 )
oPrint:Say(nRow1+0020,nColIni+1530,DTOC(QR1->CJ_VALIDA)																,oFont10 )
oPrint:Say(nRow1+0090,nColIni+0430,SE4->E4_DESCRI																	,oFont10 )
oPrint:Say(nRow1+0090,nColIni+1530,iif(QR1->CJ_AXFRETE=="F","FOB","CIF")											,oFont10 )
oPrint:Say(nRow1+0160,nColIni+0430,QR1->CJ_OBSERV1																	,oFont8CN)
oPrint:Say(nRow1+0230,nColIni+0050,QR1->CJ_OBSERV2																	,oFont8CN)

For _nY := 1 to 2
	nRow1 += 070
	oPrint:Line(nRow1,nColIni,nRow1,nColFim) 
Next _nY
nRow1 += 070
For _nY := 1 to 2
	nRow1 += 070
	oPrint:Line(nRow1,nColIni,nRow1,nColFim) 
Next _nY

// linhas horizontais duplas do titulo.
oPrint:Line(nRow1-65,nColIni,nRow1-65,nColFim) 
nRow1 += 5                                     
oPrint:Line(nRow1,nColIni,nRow1,nColFim)
// colunas dos itens
oPrint:Line(nRow1-70,nColIni+0400,nRowfim,nColIni+0400) // codigo
oPrint:Line(nRow1-70,nColIni+1100,nRowfim,nColIni+1100) // descricao
oPrint:Line(nRow1-70,nColIni+1300,nRowfim,nColIni+1300) // entrega
oPrint:Line(nRow1-70,nColIni+1400,nRowfim,nColIni+1400) // UM
oPrint:Line(nRow1-70,nColIni+1530,nRowfim,nColIni+1530) // Qtde
oPrint:Line(nRow1-70,nColIni+1720,nRowfim,nColIni+1720) // Unitario
oPrint:Line(nRow1-70,nColIni+1800,nRowfim,nColIni+1800) // IPI
oPrint:Line(nRow1-70,nColIni+1900,nRowfim,nColIni+1900) // ICMS	
// nome das colunas                                            
oPrint:Say(nRow1-050,nColIni+0050,"Código"																			,oFont10N)
oPrint:Say(nRow1-050,nColIni+0430,"Descrição"																		,oFont10N)
oPrint:Say(nRow1-050,nColIni+1130,"Entrega"																			,oFont10N)
oPrint:Say(nRow1-050,nColIni+1320,"U.M."																			,oFont10N)
oPrint:Say(nRow1-050,nColIni+1410,"Qtde."																			,oFont10N)
oPrint:Say(nRow1-050,nColIni+1540,"Unitário"																		,oFont10N)
oPrint:Say(nRow1-050,nColIni+1740,"IPI"																				,oFont10N)
oPrint:Say(nRow1-050,nColIni+1810,"ICMS"																			,oFont10N)
oPrint:Say(nRow1-050,nColIni+1930,"TOTAL"																			,oFont10N)

// Rodape (Observacoes Gerais)
oPrint:box(nRowFim+10,ncolIni,nRowPage,ncolFim)                                                                               
oPrint:Line(nRowPage-50,nColIni,nRowPage-50,nColFim)
// linhas verticais da observacao
oPrint:Line(nRowPage-50,nColIni+0700,nRowPage,nColIni+0700)
oPrint:Line(nRowPage-50,nColIni+1650,nRowPage,nColIni+1650)
// titulos do box observacoes
oPrint:Say(nRowFim+030,nColIni+0050,"Observações Gerais"															,oFont10N)
oPrint:Say(nRowPage+30,nColIni+1900,"Página: "+Alltrim(Str(_nPag))													,oFont12N)
// Retorno da linha inicial de impressao dos itens do orcamento.
_nRet := nRow1+20

Return(_nRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fAliqIcmsºAutor  ³Microsiga           º Data ³  10/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para verificar a aliquota de ICMS.                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fAliqIcms()

Local _nAliq := 0

Do Case
	Case SA1->A1_EST == "SP"
		_nAliq = 18
	Case SA1->A1_EST $ "MG/PR/RJ/RS/SC"
		_nAliq := 12
	Otherwise
		_nAliq := 7
EndCase       

Return(_nAliq)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fRodape  ºAutor  ³Microsiga           º Data ³  02/12/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ funcao para impressao do rodape final do relatorio.        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fRodape()

Local _nValPis 		:= 0
Local _nValCofin	:= 0                                           
Local _nTotDesZF	:= 0

// Caso seja zona franca de manaus, desconta-se o PIS/COFINS/ICMS da regiao.
If SA1->A1_CODMUN == "00255"
	_nTotal		-=  _nTotIcms
	If ! Empty(SA1->A1_SUFRAMA) .And. SA1->A1_RECCOFI <> "S" .And. SA1->A1_RECPIS <> "S"
		_nValPis 	:= _nTotal * (GetMv("MV_TXPIS")/100)
		_nValCofin	:= _nTotal * (GetMv("MV_TXCOFIN")/100)
		_nTotal		-= (_nValPis+_nValCofin)
	EndIf
	_nTotDesZF 	:= (_nTotIcms+_nValPis+_nValCofin)
EndIf
// salto de linha com 40 pixels cada.
oPrint:Say(nRowFim+080,nColIni+0050,"Faturamento Mínimo R$."+Getmv("MV_ALFATMIN")							,oFont8CN)
oPrint:Say(nRowFim+120,nColIni+0050,"Prazo de entrega sujeito a confirmação do pedido."						,oFont8CN)
oPrint:Say(nRowFim+160,nColIni+0050,"Favor mencionar número deste orçamento em seu Pedido;"					,oFont8CN)
oPrint:Say(nRowFim+200,nColIni+0050,"Também confirmar todos os dados para faturamento/entrega."				,oFont8CN)
oPrint:Say(nRowPage-40,nColIni+0050,"IPI nao incluso R$."+Transform(_nTotIpi,"@e 999,999.99")				,oFont10N)
If _nTotDesZF > 0
	oPrint:Say(nRowPage-40,nColIni+0750,"Icms Incluso R$."+Transform(0,"@e 999,999.99")						,oFont10N)
Else
	oPrint:Say(nRowPage-40,nColIni+0750,"Icms Incluso R$."+Transform(_nTotIcms,"@e 999,999.99")				,oFont10N)
EndIf
oPrint:Say(nRowPage-40,nColIni+1700,"Total em R$."+Transform(_nTotal,"@e 9,999,999.99")						,oFont10N)

// Impressao caso seja Zona Franca de Manaus
If _nTotDesZF > 0
	oPrint:Line(nRowFim+115,nColIni+1250,nRowFim+115,nColIni+1450)
	oPrint:Line(nRowFim+230,nColIni+1250,nRowFim+230,nColIni+1450)	

	oPrint:Say(nRowFim+060,nColIni+1100,"Descontos Zona Franca Manaus"										,oFont10N)
	oPrint:Say(nRowFim+120,nColIni+1100,"ICMS   "+Transform(_nTotIcms,	"@e 9,999,999.99")					,oFont8CN)
	oPrint:Say(nRowFim+160,nColIni+1100,"PIS    "+Transform(_nValPis,	"@e 9,999,999.99")					,oFont8CN)	
	oPrint:Say(nRowFim+200,nColIni+1100,"COFINS "+Transform(_nValCofin,	"@e 9,999,999.99")					,oFont8CN)	
	oPrint:Say(nRowFim+240,nColIni+1100,"TOTAL  "+Transform(_nTotDesZF,	"@e 9,999,999.99")					,oFont8CN)	
EndIf

Return