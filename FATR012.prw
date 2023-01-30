#Include "Protheus.ch"
#Include "topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR012   ºAutor  ³Adriano luis Brandaoº Data ³  10/11/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para imprimir a Guia de Trafego do Ministerio do     º±±
±±º          ³Exercito.                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATR012()

_cPerg := "FATR12"

PutSx1(_cPerg,"01","Serie" ,"Serie" ,"Serie"								,"mv_ch1","C",03,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Da Nota Fiscal" ,"Da Nota Fiscal" ,"Da Nota Fiscal"		,"mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"03","Ate Nota Fiscal" ,"Ate Nota Fiscal" ,"Ate Nota Fiscal"	,"mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio....",,{ || fImpr012() })
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR012   ºAutor  ³Adriano Luis Brandaoº Data ³  24/11/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Processamento do relatorio                                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr012()

Private nColIni 	:= 0050
Private nLinIni		:= 0050
Private nColFim 	:= 2200
Private nRowFim 	:= 2600
Private nRowPage	:= 3000
Private _nAliqIcm	:= 0
Private	_nTotIpi	:= 0
Private	_nTotal		:= 0
Private _nTotIcms	:= 0
Private nLin		:= nLinIni

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,08,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8CN	:= TFont():New("Courier New"	,08,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,11,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,10,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,10,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12N	:= TFont():New("Arial"			,12,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,14,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"			,16,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,18,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,20,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,21,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,16,10,.T.,.F.,5,.T.,5,.T.,.F.)

_cQuery := "SELECT D2_DOC, ZF_CODIGO, ZF_DESC, D2_COD, D2_EMISSAO, D2_CLIENTE, D2_LOJA, A1_NOME, A1_END, A1_MUN, A1_TEL, A1_EST, "
_cQuery += "       A1_DDD, A1_BAIRRO, CASE B1_CONV WHEN 0 THEN D2_QUANT ELSE D2_QUANT * B1_CONV END AS QUANT, B1_MARCA "
_cQuery += "FROM " + RetSqlname("SD2") + " D2 "
_cQuery += "     INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "             ON D2_COD = B1_COD "
_cQuery += "     INNER JOIN " + RetSqlName("SZF") + " ZF "
_cQuery += "             ON B1_AXCTEXE = ZF.ZF_CODIGO "
_cQuery += "     INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "             ON D2_CLIENTE = A1_COD AND D2_LOJA = A1_LOJA "
_cQuery += "WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND D2_SERIE = '" + MV_PAR01 + "' AND D2_DOC BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR03 + "' "
_cQuery += "      AND B1_FILIAL = '" + xFilial("SB1") + "' AND ZF_FILIAL = '" + xFilial("SZF") + "' AND ZF.D_E_L_E_T_ = ' ' "
_cQuery += "      AND B1.D_E_L_E_T_ = ' ' AND A1_FILIAL = '" + xFilial("SA1") + "' AND A1.D_E_L_E_T_ = ' ' AND D2_TIPO = 'N' "
_cQuery += "      AND D2.D_E_L_E_T_ = ' ' " 

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","QUANT","N",12,2)
TcSetField("QR1","D2_EMISSAO","D",8,0)

oPrint:= TMSPrinter():New( "Guia de Trafego" )
oPrint:SetPortrait() // ou SetLandscape()

nPag := 1

Do While ! QR1->(Eof())
	
	_cDoc := QR1->D2_DOC
	// Busca Licenca do cliente
	_cLicCli := fLicencCli()
	// Busca licenca da transportadora
	_cLicTra := fLicencTra()
	// Montagem do formulario.
	fForm()
	Do While ! QR1->(Eof()) .And. QR1->D2_DOC == _cDoc
		
		
		
		
		QR1->(DbSkip())
	EndDo
	oPrint:EndPage()
EndDo               

QR1->(DbCloseArea())

oPrint:Preview()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fForm     ºAutor  ³Adriano luis Brandaoº Data ³  01/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta o formulario com itens em branco para serem atualiza º±±
±±º          ³ dos.                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fForm()

nLin:=nLinIni

oPrint:StartPage()

oPrint:Say(nLin,1000,"MINISTERIO DA DEFESA",oFont12N)
oPrint:Say(nLin+0050,1000,"EXERCITO BRASILEIRO",oFont12N)
oPrint:Say(nLin+0100,1000,"DEPARTAMENTO LOGISTICO",oFont12N)
oPrint:Say(nLin+0150,0500,"DIRETORIA DE FISCALIZACAO DE PRODUTOS CONTROLADOS",oFont12N)
oPrint:Say(nLin+0250,0500,"GUIA DE TRAFEGO Nr.________/("+Strzero(nPag,3)+") - SFPC /____________",oFont14N)
oPrint:Say(nLin+0350,0070,"Permissao para trafego das mercadorias abaixo de acordo com:",oFont10N)
nLin+=0400
oPrint:Box(nLin,nColIni+0100,nLin+0070,nColFim-0200)
oPrint:Say(nLin+0010,nColIni+0600,"Nota Fiscal Nr." + QR1->D2_DOC + " / Data " + Dtoc(QR1->D2_EMISSAO),oFont10N)
oPrint:Box(nLin+0090,nColIni+0100,nLin+0160,nColFim-0200)
oPrint:Say(nLin+0100,nColIni+0600,"Numero de Volumes:___________________",oFont10N)
nLin+=0200
// Dados da empresa Origem (Alpax)
oPrint:Say(nLin,nColIni+0020,"Empresa origem:",oFont10N)
oPrint:Say(nLin+0050,nColIni+0020,SM0->M0_NOMECOM,oFont10N)
oPrint:Say(nLin+0100,nColIni+0020,GetNewPar("MV_XLICEX","0000"),oFont10)
oPrint:Say(nLin+0100,nColIni+1700,Transform(SM0->M0_CGC,"@r 99.999.999/9999-99"),oFont10)
oPrint:Say(nLin+0150,nColIni+0020,RTRIM(SM0->M0_ENDENT)+"-"+RTRIM(SM0->M0_CIDENT)+"-"+RTRIM(SM0->M0_ESTENT),oFont10)
oPrint:Say(nLin+0150,nColIni+1700,"Telefone:"+SM0->M0_TEL,oFont10)
nLin+=0250                                                                                                            
// Dados da empresa de transporte
oPrint:Say(nLin,nColIni+0020,"Empresa de Transporte:",oFont10N)
oPrint:Say(nLin+0050,nColIni+0020,iif(! Empty(_cLicTra),RTRIM(SA4->A4_NOME),""),oFont10N)
oPrint:Say(nLin+0100,nColIni+0020,_cLicTra,oFont10)
oPrint:Say(nLin+0100,nColIni+1700,iif(! empty(_cLicTra),Transform(SA4->A4_CGC,"@r 99.999.999/9999-99"),""),oFont10)
oPrint:Say(nLin+0150,nColIni+0020,iif(! empty(_cLicTra),RTRIM(SA4->A4_END)+"-"+RTRIM(SA4->A4_BAIRRO)+"-"+;
          RTRIM(SA4->A4_MUN)+"-"+RTRIM(SA4->A4_EST),""),oFont10)
oPrint:Say(nLin+0150,nColIni+1700,iif(! empty(_cLicTra),"Fone:"+SA4->A4_DDD+" "+SA4->A4_TEL,""),oFont10)
nLin+=0250
// Dados da empresa de destino (Cliente).
oPrint:Say(nLin,nColIni+0020,"Empresa Destino:",oFont10N)
oPrint:Say(nLin+0050,nColIni+0020,QR1->A1_NOME,oFont10N)
oPrint:Say(nLin+0100,nColIni+0020,_cLicCli,oFont10)
oPrint:Say(nLin+0100,nColIni+1700,Transform(SA1->A1_CGC,"@r 99.999.999/9999-99"),oFont10)
oPrint:Say(nLin+0150,nColIni+0020,RTRIM(QR1->A1_END)+"-"+RTRIM(QR1->A1_BAIRRO)+"-"+RTRIM(QR1->A1_MUN)+"-"+QR1->A1_EST,oFont10)
oPrint:Say(nLin+0150,nColIni+1700,"Fone:"+QR1->A1_DDD+" "+QR1->A1_TEL,oFont10)
nLin+=0250
// Dados da empresa Consignataria
oPrint:Say(nLin,nColIni+0020,"Empresa Consignataria:",oFont10N)
nLin+=0250                                                            
nColFimTab := nColFim-0100

// Tabela do Redespacho.
oPrint:Box(nLin,nColIni+0020,nLin+0210,nColFimTab)
oPrint:Line(nLin+0070,nColIni+0020,nLin+0070,nColFimTab)
oPrint:Line(nLin+0140,nColIni+0020,nLin+0140,nColFimTab)
oPrint:Line(nLin+0070,nColIni+0450,nLin+0210,nColIni+0450)
oPrint:Line(nLin+0070,nColIni+0875,nLin+0210,nColIni+0875)
oPrint:Line(nLin+0070,nColIni+1300,nLin+0210,nColIni+1300)
oPrint:Line(nLin+0070,nColIni+1725,nLin+0210,nColIni+1725)

oPrint:Say(nLin+0010,nColIni+0040,"Redespacho:",oFont8CN)
oPrint:Say(nLin+0080,nColIni+0040,"Nome Transportadora",oFont8CN)
oPrint:Say(nLin+0080,nColIni+0470,"Endereço",oFont8CN)
oPrint:Say(nLin+0080,nColIni+0895,"Nr.Registro",oFont8CN)
oPrint:Say(nLin+0080,nColIni+1320,"CNPJ",oFont8CN)
oPrint:Say(nLin+0080,nColIni+1745,"Telefone",oFont8CN)
nLin+=0240

// Tabela dos Produtos
oPrint:Box(nLin,nColIni+0020,nLin+420,nColFimTab)
For _nY := nLin+70 To (nLin+0419) Step 70
	oPrint:Line(_nY,nColIni+0020,_nY,nColFimTab)
Next _nY   
                      
oPrint:Line(nLin,nColIni+0400,nLin+0420,nColIni+0400)
oPrint:Line(nLin,nColIni+0825,nLin+0420,nColIni+0825)
oPrint:Line(nLin,nColIni+1050,nLin+0420,nColIni+1050)
oPrint:Line(nLin,nColIni+1250,nLin+0420,nColIni+1250)
oPrint:Line(nLin,nColIni+1430,nLin+0420,nColIni+1430)
oPrint:Line(nLin,nColIni+1750,nLin+0420,nColIni+1750)

oPrint:Say(nLin+0010,nColIni+0040,"Produto",oFont10n)
oPrint:Say(nLin+0010,nColIni+0410,"Complemento",oFont10n)
oPrint:Say(nLin+0010,nColIni+0835,"Unidade",oFont10n)
oPrint:Say(nLin+0010,nColIni+1060,"Qtde.",oFont10n)
oPrint:Say(nLin+0010,nColIni+1260,"Volume",oFont10n)
oPrint:Say(nLin+0010,nColIni+1440,"Marca",oFont10n)
oPrint:Say(nLin+0010,nColIni+1760,"Nr.",oFont10n)

nLin+=440

// Box do selo de autenticidade.
oPrint:Box(nLin,nColIni+0020,nLin+560,nColFimTab)
oPrint:Line(nLin+0350,nColIni+0020,nLin+0350,nColFimTab)
oPrint:Line(nLin,nColIni+0800,nLin+560,nColIni+0800)

nPag++

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fLicencCliºAutor  ³Adriano Luis Brandaoº Data ³  01/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para encontrar a licenca do cliente atual.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fLicencCli()

Local _cRet := " "

_cQuery := "SELECT Z8_LICENCA "
_cQuery += "       FROM " + RetSqlName("SZ8") + " Z8 "
_cQuery += "       WHERE Z8_FILIAL = '" + xFilial("SZ8") + "' AND Z8_CLIENTE = '" + QR1->D2_CLIENTE + "' "
_cQuery += "             AND Z8_LOJA = '" + QR1->D2_LOJA + "' AND '" + DTOS(dDataBase) + "' >= Z8_DTINI "
_cQuery += "             AND '" + DTOS(dDataBase) + "' <= Z8_DTFIM AND D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias "QR2"

_cRet := QR2->Z8_LICENCA

QR2->(DbCloseArea())

// se nao encontrar licenca, buscar autorizacao especial.
If Empty(_cRet)
	_cQuery := "SELECT ZH_LICENCA "
	_cQuery += "       FROM " + RetSqlName("SZH") + " SZH "
	_cQuery += "       WHERE ZH_FILIAL = '" + xFilial("SZH") + "' AND ZH_CLIENTE = '" + QR1->D2_CLIENTE + "' "
	_cQuery += "             AND ZH_LOJA = '" + QR1->D2_LOJA + "' AND '" + DTOS(dDataBase) + "' >= ZH_DTINI "
	_cQuery += "             AND '" + DTOS(dDataBase) + "' <= ZH_DTFIM AND D_E_L_E_T_ = ' ' "
	
	TcQuery _cQuery New Alias "QR2"
	
	_cRet := QR2->ZH_LICENCA
	
	QR2->(DbCloseArea())
	
EndIf

Return(_cRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fLicencTraºAutor  ³Adriano Luis Brandaoº Data ³  01/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para retornar o numero da licenca da transportadora  º±±
±±º          ³atual.                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fLicencTra()

Local _cRet := ""
// Posiciona na transportadora.
SF2->(DbSetOrder(1))
SF2->(DbSeek(xFilial("SF2")+QR1->D2_DOC+MV_PAR01,.T.))
// se nao estiver vazio a transportadora, busca a licenca.
If ! Empty(SF2->F2_TRANSP)
	SA4->(DbSetOrder(1))
	SA4->(DbSeek(xFilial("SA4")+SF2->F2_TRANSP))
	
	_cQuery := "SELECT ZA_LICENCA "
	_cQuery += "       FROM " + RetSqlName("SZA") + " ZA "
	_cQuery += "       WHERE ZA_FILIAL = '" + xFilial("SZA") + "' AND ZA_TRANSP = '" + SF2->F2_TRANSP + "' "
	_cQuery += "             AND '" + DTOS(dDataBase) + "' >= ZA_DTINI "
	_cQuery += "             AND '" + DTOS(dDataBase) + "' <= ZA_DTFIM AND D_E_L_E_T_ = ' ' "
	
	TcQuery _cQuery New Alias "QR2"
	
	_cRet := QR2->ZA_LICENCA
	
	QR2->(DbCloseArea())
EndIf

Return(_cRet)