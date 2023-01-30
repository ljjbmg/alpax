/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR029   ºAutor  ³Ocimar Rolli        º Data ³  25/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Orcamento de vendas em modo grafico.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "FWEVENTVIEWCONSTS.CH"
#INCLUDE "FWADAPTEREAI.CH"

User Function FATR029()

//_cPerg := "FATR29"

//If Pergunte(_cPerg,.t.)
MsgRun("Aguarde gerando relatorio",,{ || fImpr029() })
//EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr029  ºAutor  ³Ocimar Rolli        º Data ³  25/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de processamento do relatorio.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr029()

Private nColIni 	:= 0050
Private nColFim 	:= 3300
Private nRowIni		:= 0050
Private nRowFim 	:= 2300
Private oPrint, _nItem, nPag

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8N 	:= TFont():New("Arial"			,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont9CN	:= TFont():New("Courier New"	,09,09,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11N	:= TFont():New("Arial"			,09,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14		:= TFont():New("Arial"			,13,14,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)

oPrint:= TMSPrinter():New( "Tabela de preco" )
oPrint:SetLandscape() // ou SetPortrait()

nLin      := 26
nInc      := 970
nMarca    := " "

fFormCab()

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

DbSelectArea("SCJ")
SCJ->(DbSetOrder(1))
SCJ->( DbSeek( SCJ->CJ_FILIAL + SCJ->CJ_NUM ) )

cAtdMail := ""
PswOrder(1)
If PswSeek( SCJ->CJ_AXATEND, .T. )
	cAtdMail := AllTrim(PSWRET()[1][14])
Endif

cVddMail := ""
PswOrder(1)
If PswSeek( SCJ->CJ_AXVEND, .T. )
	cVddMail := AllTrim(PSWRET()[1][14])
Endif

dbSelectArea("SA1")
dbSetOrder(1)
SA1->(DbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA) )

cTelCtt := ""
cMailCtt:= ""
DbSelectArea("SU5")
SU5->(DbSetOrder(1))
If SU5->(DbSeek(xFilial("SU5") + SCJ->CJ_AXCTATO))
	cTelCtt := "(" + SU5->U5_DDD + ")" + TransForm(SU5->U5_FONE,"@R 9999-9999")
	cMailCtt:= AllTrim(SU5->U5_EMAIL)
Endif

cDescCP := ""
If !Empty(AllTrim(SCJ->CJ_CONDPAG))
	DbSelectArea("SE4")
	SE4->(DbSetOrder(1))
	SE4->(DbSeek( xFilial("SE4") + SCJ->CJ_CONDPAG ))
	cDescCP := AllTrim(SE4->E4_DESCRI)
Endif

aTemp := Ma415Impos(3)	//"Planilha Financeira"

oPrint:StartPage()
PrtCabec()
PrtDet(aTemp)
MaFisEnd()
Return

Static Function PrtCabec
// BOX CABECALHO
oPrint:Box(nRowIni,nColIni,nRowFim,nColFim)
oPrint:SayBitmap(nRowIni+0030,nColIni+30,"\system\logo_alpax.bmp",400,100)
oPrint:SayBitmap(nRowIni+0130,nColIni+30,"\system\logo_iso_2015.gif",400,100)
oPrint:Say(nRowIni+0020,nColIni+0600,"Alpax comercio de produtos para laboratorios Ltda."                       ,oFont12N)
oPrint:Say(nRowIni+0080,nColIni+0600,"Rua Serra da Borborema, 40 - Campanario Diadema - SP"                     ,oFont12)
oPrint:Say(nRowIni+0140,nColIni+0600,"Telefone : 55(11) 4057-9200 / Fax 55(11) 4057-9204"                       ,oFont12)
oPrint:Say(nRowIni+0200,nColIni+0600,"CNPJ : 65.838.344/0001-10 / Insc. Est. 286.100.047.111"                   ,oFont12)
oPrint:Say(nRowIni+0020,nColIni+2050,"Atendente :"                                                              ,oFont8)
oPrint:Say(nRowIni+0060,nColIni+2050,UsrFullName(SCJ->CJ_AXATEND)                                                ,oFont8)
oPrint:Say(nRowIni+0100,nColIni+2050,cAtdMail						                                            ,oFont8)
oPrint:Say(nRowIni+0140,nColIni+2050,"Representante :"                                                          ,oFont8)
oPrint:Say(nRowIni+0180,nColIni+2050,FDesc("SA3",SCJ->CJ_AXVEND,"A3_NOME")                                      ,oFont8)
oPrint:Say(nRowIni+0220,nColIni+2050,FDesc("SA3",SCJ->CJ_AXVEND,"A3_EMAIL")	                                    ,oFont8)
oPrint:Say(nRowIni+0080,nColIni+2800,"Orçamento  " + SCJ->CJ_NUM                                                ,oFont12N)
oPrint:Say(nRowIni+0140,nColIni+2800,"Emissao : " + DTOC(SCJ->CJ_EMISSAO)                                       ,oFont12)
oPrint:Line(nRowIni+0260,nColIni,nRowIni+0260,nColFim)
oPrint:Line(nRowIni+0270,nColIni,nRowIni+0270,nColFim)
oPrint:Say(nRowIni+0290,nColIni+0050,"Faturamento :"                                                            ,oFont9CN)
oPrint:Say(nRowIni+0330,nColIni+0050,AllTrim(SA1->A1_NOME)									                    ,oFont8)
oPrint:Say(nRowIni+0370,nColIni+0050,AllTrim(SA1->A1_END)			                                            ,oFont8)
oPrint:Say(nRowIni+0410,nColIni+0050,AllTrim(SA1->A1_BAIRRO) + " - " + AllTrim(SA1->A1_MUN) + "-" + AllTrim(SA1->A1_EST) + " - CEP : " + AllTrim(Transform(SA1->A1_CEP,"@R 99999-999")),oFont8)
oPrint:Say(nRowIni+0450,nColIni+0050,"CNPJ : " + Transform(SA1->A1_CGC,"@R 99.999.999/9999-99") + "   Isnc. Est. : " + AllTrim(SA1->A1_INSCR),oFont8)
oPrint:Say(nRowIni+0290,nColIni+1200,"Contato : "                                                               ,oFont9CN)
oPrint:Say(nRowIni+0330,nColIni+1200,AllTrim(SCJ->CJ_AXNOMCT)                                                   ,oFont8)
oPrint:Say(nRowIni+0370,nColIni+1200,"Telefone : " + cTelCtt	                                                ,oFont8)
oPrint:Say(nRowIni+0410,nColIni+1200,"Email : " + cMailCtt			                                            ,oFont8)
oPrint:Say(nRowIni+0290,nColIni+2050,"Entrega :"                                                                ,oFont9CN)
oPrint:Say(nRowIni+0330,nColIni+2050,AllTrim(SA1->A1_ENDENT)		                                            ,oFont8)
oPrint:Say(nRowIni+0370,nColIni+2050,AllTrim(SA1->A1_BAIRROE) + " - " + AllTrim(SA1->A1_MUNE) + " - " + SA1->A1_ESTE + " - CEP : " + AllTrim(Transform(SA1->A1_CEPE,"@R 99999-999")),oFont8)
oPrint:Say(nRowIni+0410,nColIni+2050,"CNPJ : " + Transform(SA1->A1_CGC,"@R 99.999.999/9999-99") + "   Isnc. Est. : " + AllTrim(SA1->A1_INSCR),oFont8)

PrtMeio()

Return

Static Function PrtMeio
oPrint:Line(nRowIni+0500,nColIni,nRowIni+0500,nColFim)
oPrint:Line(nRowIni+0510,nColIni,nRowIni+0510,nColFim)
oPrint:Say(nRowIni+0540,nColIni+0050,"Pedido cliente : " + AllTrim(SCJ->CJ_AXPEDCL)                             ,oFont9CN)
oPrint:Line(nRowIni+0510,nColIni+0800,nRowIni+0600,nColIni+0800)
oPrint:Say(nRowIni+0540,nColIni+1000,"Validade : " + DTOC(SCJ->CJ_VALIDA)                                       ,oFont9CN)
oPrint:Line(nRowIni+0510,nColIni+1600,nRowIni+0600,nColIni+1600)
oPrint:Say(nRowIni+0540,nColIni+1700,"Cond. Pagto : " +cDescCP                                                  ,oFont9CN)
oPrint:Line(nRowIni+0510,nColIni+2400,nRowIni+0600,nColIni+2400)
oPrint:Say(nRowIni+0540,nColIni+2500,"Frete : " + Iif(SCJ->CJ_AXFRETE=="F","FOB","CIF")                         ,oFont9CN)
oPrint:Line(nRowIni+0600,nColIni,nRowIni+0600,nColFim)
oPrint:Line(nRowIni+0610,nColIni,nRowIni+0610,nColFim)
oPrint:Say(nRowIni+0630,nColIni+0100,"Codigo"                                                                   ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+0300,nRowIni+1790,nColIni+0300)
oPrint:Say(nRowIni+0630,nColIni+0400,"Descricao do produto"                                                     ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+1550,nRowIni+1790,nColIni+1550)
oPrint:Say(nRowIni+0630,nColIni+1570,"Entrega"                                                                  ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+1750,nRowIni+1790,nColIni+1750)
oPrint:Say(nRowIni+0630,nColIni+1790,"Quantidade"                                                               ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+2020,nRowIni+1790,nColIni+2020)
oPrint:Say(nRowIni+0630,nColIni+2090,"Unitario"                                                                 ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+2300,nRowIni+1790,nColIni+2300)
oPrint:Say(nRowIni+0630,nColIni+2405,"Total"                                                                    ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+2600,nRowIni+1790,nColIni+2600)
oPrint:Say(nRowIni+0630,nColIni+2655,"IPI"                                                                      ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+2800,nRowIni+1790,nColIni+2800)
oPrint:Say(nRowIni+0630,nColIni+2825,"ICMS"                                                                     ,oFont9CN)
oPrint:Line(nRowIni+0610,nColIni+2950,nRowIni+1790,nColIni+2950)
oPrint:Say(nRowIni+0630,nColIni+3000,"ICMS-ST"                                                                  ,oFont9CN)
oPrint:Line(nRowIni+0680,nColIni,nRowIni+0680,nColFim)
oPrint:Line(nRowIni+0690,nColIni,nRowIni+0690,nColFim)
/*
oPrint:Line(nRowIni+1790,nColIni,nRowIni+1790,nColFim)
oPrint:Line(nRowIni+1800,nColIni,nRowIni+1800,nColFim)
oPrint:Line(nRowIni+1890,nColIni,nRowIni+1890,nColFim)
oPrint:Line(nRowIni+1900,nColIni,nRowIni+1900,nColFim)
oPrint:Line(nRowIni+1990,nColIni,nRowIni+1990,nColFim)
oPrint:Line(nRowIni+2000,nColIni,nRowIni+2000,nColFim)
*/

Return


Static Function PrtDet(aTemp)

DbSelectArea("SCK")
SCK->(DbSetOrder(1)) //CK_FILIAL, CK_NUM, CK_ITEM, CK_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
SCK->(DbSeek( SCJ->CJ_FILIAL + SCJ->CJ_NUM ))

nAuxLn := 0
nItem  := 0     
nVlrProd := 0     

While SCK->(!Eof()) .And. SCK->CK_FILIAL == SCJ->CJ_FILIAL .And. SCK->CK_NUM == SCJ->CJ_NUM
	nItem ++
	nValIPI := MaFisRet(nItem,"IT_ALIQIPI")
	nValICM := MaFisRet(nItem,"IT_ALIQICM")
	nValSol := MaFisRet(nItem,"IT_VALSOL")
	nDias   := DateDiffDay( SCK->CK_ENTREG , SCJ->CJ_EMISSAO )//CtoD(SCK->CK_ENTREG) - CtoD(SCJ-CJ_EMISSAO)
	
	nAuxLn += 30
	If nAuxLn >= 1450
		
		oPrint:Line(nRowIni+1790,nColIni+0300,nRowFim,nColIni+0300)
		oPrint:Line(nRowIni+0610,nColIni+1550,nRowFim,nColIni+1550)
		oPrint:Line(nRowIni+0610,nColIni+1750,nRowFim,nColIni+1750)
		oPrint:Line(nRowIni+0610,nColIni+2020,nRowFim,nColIni+2020)
		oPrint:Line(nRowIni+0610,nColIni+2300,nRowFim,nColIni+2300)
		oPrint:Line(nRowIni+0610,nColIni+2600,nRowFim,nColIni+2600)
		oPrint:Line(nRowIni+0610,nColIni+2800,nRowFim,nColIni+2800)
		oPrint:Line(nRowIni+0610,nColIni+2950,nRowFim,nColIni+2950)
		
		nAuxLn := 30
		oPrint:EndPage()
		oPrint:StartPage()
		PrtCabec()
	Endif
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0045-10,SCK->CK_PRODUTO                                        ,oFont8)
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,SCK->CK_DESCRI                                         ,oFont8N)
	If SCK->CK_PRODUTO == "160484228001002"
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+1590-10,"  "                                               ,oFont8)
	Else
		If nDias == 0
			oPrint:Say(nRowIni+0690+nAuxLn,nColIni+1580-10,"Imediato"                                     ,oFont8)
		Else
			oPrint:Say(nRowIni+0690+nAuxLn,nColIni+1580-10,Transform(nDias,"@e 999")+ " dias"             ,oFont8)
		EndIf
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+1790-10,Transform(SCK->CK_QTDVEN,X3Picture("CK_QTDVEN"))   ,oFont8)
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+2090-10,Transform(SCK->CK_PRCVEN,X3Picture("CK_VALOR"))    ,oFont8)
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+2385-10,Transform(SCK->CK_VALOR,X3Picture("CK_VALOR"))     ,oFont8)
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+2665-10,Transform(nValIPI,"@e 99999.99")                   ,oFont8)
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+2815-10,Transform(nValICM,"@e 99999.99")                   ,oFont8)
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+3000-10,Transform(nValSol,X3Picture("F2_VALICM"))          ,oFont8)
		nVlrProd := nVlrProd + SCK->CK_VALOR

	EndIf
	
	// Imprime informaçôes adicionais do produto
	nAuxLn += 30
	SB1->(DbSetOrder(1))
	SB1->(DbSeek(xFilial("SB1")+SCK->CK_PRODUTO))
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,"Referencia : "+SB1->B1_PNUMBER   ,oFont8)
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0850-10,"Marca : "+SB1->B1_MARCA   ,oFont8)
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+1200-10,"Capacidade : "+SB1->B1_CAPACID   ,oFont8)
	nAuxLn += 30
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,"NCM : "+SB1->B1_POSIPI   ,oFont8)
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0850-10,"CST : "+SCK->CK_CLASFIS   ,oFont8)
	nAuxLn += 30
	oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,SCK->CK_XOPER   ,oFont8)
	SB1->(MsUnLock())
	
	// Verifica se produto é substituiçâo tributária
	SF4->(DbSetOrder(1))
	SF4->(DbSeek(xFilial("SF4")+SCK->CK_TES))
	If SUBSTR(SF4->F4_CF,2,3) == "405"
		nAuxLn += 30
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10," ICMS já recolhido por substituição tributária"   ,oFont8)
	EndIf
	SF4->(MsUnLock())
	
	// Verifica se o produto tem foto
	If SB1->B1_AXFOTO <> ' '
		nAuxLn += 400
		If nAuxLn >= 1450
			nAuxLn := 30
			oPrint:Line(nRowIni+1790,nColIni+0300,nRowFim,nColIni+0300)
			oPrint:Line(nRowIni+0610,nColIni+1550,nRowFim,nColIni+1550)
			oPrint:Line(nRowIni+0610,nColIni+1750,nRowFim,nColIni+1750)
			oPrint:Line(nRowIni+0610,nColIni+2020,nRowFim,nColIni+2020)
			oPrint:Line(nRowIni+0610,nColIni+2300,nRowFim,nColIni+2300)
			oPrint:Line(nRowIni+0610,nColIni+2600,nRowFim,nColIni+2600)
			oPrint:Line(nRowIni+0610,nColIni+2800,nRowFim,nColIni+2800)
			oPrint:Line(nRowIni+0610,nColIni+2950,nRowFim,nColIni+2950)
			oPrint:EndPage()
			oPrint:StartPage()
			PrtCabec()
			oPrint:SayBitmap(nRowIni+0690+nAuxLn,nColIni+400,SB1->B1_AXFOTO,400,400)
			nAuxLn += 400
		Else
			nAuxLn -= 370
			oPrint:SayBitmap(nRowIni+0690+nAuxLn,nColIni+400,SB1->B1_AXFOTO,400,400)
			nAuxLn += 400
		EndIf
	EndIf
	
	SB1->(MsUnLock())
	
	nAuxLn += 30
	
	SCK->(DbSkip())
EndDo
             
AAdd(aTemp, nVlrProd)

If nAuxLn+500 < 1450
	If SCJ->CJ_OBSERV1 <> ' ' .Or. SCJ->CJ_OBSERV2 <> ' '
		nAuxLn += 30
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,"Observações : "                            ,oFont8N)
		nAuxLn += 30
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,SCJ->CJ_OBSERV1                             ,oFont8N)
		nAuxLn += 30
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,SCJ->CJ_OBSERV2                             ,oFont8N)
		PrtRodape(aTemp)
	Else
		PrtRodape(aTemp)
	EndIf
Else
	oPrint:Line(nRowIni+1790,nColIni+0300,nRowFim,nColIni+0300)
	oPrint:Line(nRowIni+0610,nColIni+1550,nRowFim,nColIni+1550)
	oPrint:Line(nRowIni+0610,nColIni+1750,nRowFim,nColIni+1750)
	oPrint:Line(nRowIni+0610,nColIni+2020,nRowFim,nColIni+2020)
	oPrint:Line(nRowIni+0610,nColIni+2300,nRowFim,nColIni+2300)
	oPrint:Line(nRowIni+0610,nColIni+2600,nRowFim,nColIni+2600)
	oPrint:Line(nRowIni+0610,nColIni+2800,nRowFim,nColIni+2800)
	oPrint:Line(nRowIni+0610,nColIni+2950,nRowFim,nColIni+2950)
	oPrint:EndPage()
	oPrint:StartPage()
	PrtCabec()
	nAuxLn := 30
	If SCJ->CJ_OBSERV1 <> ' ' .Or. SCJ->CJ_OBSERV2 <> ' '
		nAuxLn += 30
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,"Observações : "                            ,oFont8N)
		nAuxLn += 30
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,SCJ->CJ_OBSERV1                             ,oFont8N)
		nAuxLn += 30
		oPrint:Say(nRowIni+0690+nAuxLn,nColIni+0400-10,SCJ->CJ_OBSERV2                             ,oFont8N)
		PrtRodape(aTemp)
	Else
		PrtRodape(aTemp)
	EndIf
EndIf

Return

Static Function PrtRodape(aTemp)
//ANDRE R. ESTEVES - 19/06/2020 - TRATAMENTO PARA IMPRESSAO DO DIFAL UF DESTINATARIO
nValPIS    := 0
nValCof    := 0
aImp       := MaFisRet(,"NF_IMPOSTOS") //Array contendo todos os impostos calculados na funcao fiscal com quebra por impostos + Ali
nPosDflDst := ASCAN(aImp,{ |X| X[1]= "DIF" }) 
nValDifDst := 0

If nPosDflDst > 0 //Existe DIFAL para destinatario calculado
	nValDifDst := aImp[nPosDflDst][5]
EndIf

If Len(aTemp) > 0
	For nT := 1 to Len(aTemp)-1
		If aTemp[nT][1] $ "PIS/PS2"
			nValPIS := aTemp[nT][5]
		ElseIf aTemp[nT][1] $ "COF/CF2"
			nValCof := aTemp[nT][5]
		Endif
	Next
Endif

oPrint:Line(nRowIni+1790,nColIni,nRowIni+1790,nColFim)
oPrint:Line(nRowIni+1800,nColIni,nRowIni+1800,nColFim)
oPrint:Line(nRowIni+1890,nColIni,nRowIni+1890,nColFim)
oPrint:Line(nRowIni+1900,nColIni,nRowIni+1900,nColFim)
oPrint:Line(nRowIni+1990,nColIni,nRowIni+1990,nColFim)

oPrint:Say(nRowIni+1805,nColIni+0005,"Base Calc. ICMS"                                                          ,oFont8)
oPrint:Say(nRowIni+1835,nColIni+0005,Transform(MaFisRet(,"NF_BASEICM"),X3Picture("F2_BASEICM")),oFont10)
oPrint:Line(nRowIni+1800,nColIni+0380,nRowIni+1890,nColIni+0380)
oPrint:Say(nRowIni+1805,nColIni+0385,"Valor do ICMS"                                                            ,oFont8)
oPrint:Say(nRowIni+1835,nColIni+0385,Transform(MaFisRet(,"NF_VALICM"),X3Picture("F2_VALICM")),oFont10)
oPrint:Line(nRowIni+1800,nColIni+0760,nRowIni+1890,nColIni+0760)
oPrint:Say(nRowIni+1805,nColIni+0765,"Base Calc. ICMS-ST"                                                       ,oFont8)
oPrint:Say(nRowIni+1835,nColIni+0765,Transform(MaFisRet(,"NF_BASESOL"),X3Picture("F2_BASEICM")),oFont10)
oPrint:Line(nRowIni+1800,nColIni+1140,nRowIni+1890,nColIni+1140)
oPrint:Say(nRowIni+1805,nColIni+1145,"Valor do ICMS-ST"                                                         ,oFont8)
oPrint:Say(nRowIni+1835,nColIni+1145,Transform(MaFisRet(,"NF_VALSOL"),X3Picture("F2_VALICM"))  ,oFont10)
oPrint:Line(nRowIni+1800,nColIni+1520,nRowIni+1890,nColIni+1520)
oPrint:Say(nRowIni+1805,nColIni+1525,"Valor ICMS UF remet."                                                     ,oFont8)
oPrint:Say(nRowIni+1835,nColIni+1525,Transform(MaFisRet(,"NF_VALCMP"),X3Picture("F2_VALICM")) ,oFont10)
oPrint:Line(nRowIni+1800,nColIni+1900,nRowIni+1890,nColIni+1900)
oPrint:Say(nRowIni+1805,nColIni+1905,"Valor do FCP"                                                             ,oFont8)
oPrint:Say(nRowIni+1835,nColIni+1905,Transform(MaFisRet(,"NF_VALFECP"),X3Picture("F2_VALICM")),oFont10)
oPrint:Line(nRowIni+1800,nColIni+2280,nRowIni+1890,nColIni+2280)
oPrint:Say(nRowIni+1805,nColIni+2285,"Valor do PIS"                                                             ,oFont8)
//oPrint:Say(nRowIni+1835,nColIni+2285,Transform(MaFisRet(,"NF_VALPIS"),X3Picture("F2_VALICM")),oFont10)
oPrint:Say(nRowIni+1835,nColIni+2285,Transform(nValPIS,X3Picture("F2_VALICM")),oFont10)
oPrint:Line(nRowIni+1800,nColIni+2670,nRowIni+1890,nColIni+2670)
oPrint:Say(nRowIni+1805,nColIni+2675,"Valor total produto"                                                      ,oFont8)
//oPrint:Say(nRowIni+1835,nColIni+2675,Transform(MaFisRet(,"NF_BASEDUP"),X3Picture("F2_VALICM")),oFont10)
oPrint:Say(nRowIni+1835,nColIni+2675,Transform(aTemp[len(aTemp)],X3Picture("F2_VALICM")),oFont10)
oPrint:Say(nRowIni+1905,nColIni+0005,"Valor do frete"                                                           ,oFont8)
oPrint:Say(nRowIni+1935,nColIni+0005,Transform(MaFisRet(,"NF_FRETE"),X3Picture("F2_VALICM")),oFont10)
oPrint:Line(nRowIni+1900,nColIni+0380,nRowIni+1990,nColIni+0380)
oPrint:Say(nRowIni+1905,nColIni+0385,"Valor do seguro"                                                          ,oFont8)
oPrint:Say(nRowIni+1935,nColIni+0385,Transform(MaFisRet(,"NF_DESCONTO"),X3Picture("F2_VALICM"))  ,oFont10)
oPrint:Line(nRowIni+1900,nColIni+0760,nRowIni+1990,nColIni+0760)
oPrint:Say(nRowIni+1905,nColIni+0765,"Desconto"                                                                 ,oFont8)
oPrint:Say(nRowIni+1935,nColIni+0765,Transform(MaFisRet(,"NF_SEGURO"),X3Picture("F2_VALICM")) ,oFont10)
oPrint:Line(nRowIni+1900,nColIni+1140,nRowIni+1990,nColIni+1140)
oPrint:Say(nRowIni+1905,nColIni+1145,"Outras despesas"                                                          ,oFont8)
oPrint:Say(nRowIni+1935,nColIni+1145,Transform(MaFisRet(,"NF_DESPESA"),X3Picture("F2_VALICM"))   ,oFont10)
oPrint:Line(nRowIni+1900,nColIni+1520,nRowIni+1990,nColIni+1520)
oPrint:Say(nRowIni+1905,nColIni+1525,"Valor ICMS UF dest."                                                      ,oFont8)
oPrint:Say(nRowIni+1935,nColIni+1525,Transform(nValDifDst,X3Picture("F2_VALICM"))  ,oFont10)
oPrint:Line(nRowIni+1900,nColIni+1900,nRowIni+1990,nColIni+1900)
oPrint:Say(nRowIni+1905,nColIni+1905,"Valor total do IPI"                                                       ,oFont8)
oPrint:Say(nRowIni+1935,nColIni+1905,Transform(MaFisRet(,"NF_VALIPI"),X3Picture("F2_VALICM")),oFont10)
oPrint:Line(nRowIni+1900,nColIni+2280,nRowIni+1990,nColIni+2280)
oPrint:Say(nRowIni+1905,nColIni+2285,"Valor da COFINS"                                                          ,oFont8)
//oPrint:Say(nRowIni+1935,nColIni+2285,Transform(MaFisRet(,"NF_VALCOF"),X3Picture("F2_VALICM")) ,oFont10)
oPrint:Say(nRowIni+1935,nColIni+2285,Transform(nValCOF,X3Picture("F2_VALICM")) ,oFont10)
oPrint:Line(nRowIni+1900,nColIni+2670,nRowIni+1990,nColIni+2670)
oPrint:Say(nRowIni+1905,nColIni+2675,"Valor total da nota"                                                      ,oFont8)
oPrint:Say(nRowIni+1935,nColIni+2675,Transform(MaFisRet(,"NF_TOTAL"),X3Picture("F2_VALICM")) ,oFont10)
oPrint:Say(nRowIni+2005,nColIni+0005,"Observaçoes gerais :"                                                     ,oFont8)
oPrint:Say(nRowIni+2005,nColIni+0300,"Faturamento minimo R$ 300,00."                                            ,oFont8)
oPrint:Say(nRowIni+2055,nColIni+0300,"Prazo de entrega sujeito à confirmação do pedido."                        ,oFont8)
oPrint:Say(nRowIni+2105,nColIni+0300,"Favor mencionar numero deste orçamento em seu pedido."                    ,oFont8)
oPrint:Say(nRowIni+2155,nColIni+0300,"Confirmar dados faturamento/entrega."                                     ,oFont8)
oPrint:Line(nRowIni+2000,nColIni+1100,nRowFim,nColIni+1100)
oPrint:Say(nRowIni+2005,nColIni+1105,"Observaçoes serviços :"                                                   ,oFont8)
oPrint:Line(nRowIni+2000,nColIni+2200,nRowFim,nColIni+2200)
oPrint:Say(nRowIni+2005,nColIni+2205,"Observaçoes produtos :"                                                   ,oFont8)
oPrint:Line(nRowIni+2100,nColIni+1100,nRowIni+2100,nColFim)
oPrint:Line(nRowIni+2110,nColIni+1100,nRowIni+2110,nColFim)
oPrint:Say(nRowIni+2200,nColIni+1500,"Aprovaçao solicitante"                                                    ,oFont8)
oPrint:Line(nRowIni+2195,nColIni+1200,nRowIni+2195,nColIni+2100)
oPrint:Say(nRowIni+2200,nColIni+2600,"Departamento comercial"                                                   ,oFont8)
oPrint:Line(nRowIni+2195,nColIni+2300,nRowIni+2195,nColFim-0100)
//Return

// Impressao do final do orcamento PROPAG
//oPrint:EndPage()
//oPrint:StartPage()
//oPrint:SayBitmap(10,10,"\microsiga\fotos\PROPAG.bmp",2480,3300)
//oPrint:EndPage()
//oPrint:StartPage()
//oPrint:SayBitmap(10,10,"\microsiga\fotos\PROPAG2.bmp",2480,3300)
//oPrint:EndPage()     // Finaliza a página
//oPrint:Preview()     // Visualiza antes de imprimir


Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³MA415Impos³ Autor ³ Eduardo Riera         ³ Data ³24.07.2000 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Ma415Impos(nOpc)                                             ³±±
±±³          ³Funcao de calculo dos impostos contidos no orcamento de venda³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ nOpc                                                        ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                       ³±±
±±³          ³                                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Esta funcao efetua os calculos de impostos (ICMS,IPI,ISS,etc)³±±
±±³          ³com base nas funcoes fiscais, a fim de possibilitar ao usua- ³±±
±±³          ³rio o valor de desembolso financeiro.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Ma415Impos( nOpc, lRetTotal, aRefRentab )

Local aArea		:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
//Local aAreaTMP1 := TMP1->(GetArea())
Local aTitles   := {"Nota Fiscal","Duplicatas","Rentabilidade"}
Local aDupl     := {}
Local aFlHead   := { "Vencimento","Valor" }
Local aVencto   := {}
Local aRFHead   := { RetTitle("C6_PRODUTO"),RetTitle("C6_VALOR"),"C.M.V","Vlr.Presente","Lucro Bruto","Margem de Contribuição(%)"}
Local aRentab   := {}
Local nX        := 0
Local nAcerto   := 0
Local nPrcLista := 0
Local nValMerc  := 0
Local nDesconto := 0
Local nAcresFin := 0
Local nQtdPeso  := 0
Local nItem     := 0
Local cParc     := ""

Local lCondVenda := .F.  // Template GEM - Se existe condicao de venda
Local oDlg
Local oDupl
Local oFolder
Local oRentab
Local nValTotal := 0 //Valor total utilizado no retorno quando lRetTotal for .T.
Local lProspect := .F.
Local cTipo	  := ""

Default lRetTotal := .F.
Default aRefRentab := {}

aTemp	:= {{"","",0,0,0,""}}

//DbSelectArea("SCJ")
//SCJ->(DbSetOrder(1))
//If SCJ->( DbSeek( "01" + "425003" ) )
dDataCnd  := SCJ->CJ_EMISSAO

dbSelectArea("SA1")
dbSetOrder(1)
SA1->(DbSeek(xFilial("SA1")+If(!Empty(SCJ->CJ_CLIENT),SCJ->CJ_CLIENT,SCJ->CJ_CLIENTE)+SCJ->CJ_LOJAENT) )

dbSelectArea("SE4")
dbSetOrder(1)
SE4->(DbSeek(xFilial("SE4")+SCJ->CJ_CONDPAG))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a funcao fiscal                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Empty(SCJ->CJ_PROSPE) .And. !Empty(SCJ->CJ_LOJPRO)
	cTipo := Posicione("SUS",1,xFilial("SUS") + SCJ->CJ_PROSPE + SCJ->CJ_LOJPRO,"US_TIPO")
	lProspect := .T.
Endif

//	MaFisSave()
//	MaFisEnd()
MaFisIni(SCJ->CJ_CLIENTE,;	// 1-Codigo Cliente/Fornecedor
SCJ->CJ_LOJA,;		// 2-Loja do Cliente/Fornecedor
"C",;				// 3-C:Cliente , F:Fornecedor
"N",;				// 4-Tipo da NF
Iif(lProspect,cTipo,SA1->A1_TIPO),;		// 5-Tipo do Cliente/Fornecedor
Nil,;
Nil,;
Nil,;
Nil,;
"MATA461",;
Nil,;
Nil,;
"")

DbSelectArea("SCK")
SCK->(DbSetOrder(1)) //CK_FILIAL, CK_NUM, CK_ITEM, CK_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
SCK->(DbSeek( SCJ->CJ_FILIAL + SCJ->CJ_NUM ))

While SCK->(!Eof()) .And. SCK->CK_FILIAL == SCJ->CJ_FILIAL .And. SCK->CK_NUM == SCJ->CJ_NUM
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a linha foi deletada                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(SCK->CK_PRODUTO)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona Registros                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->(dbSetOrder(1))
		If SB1->(DbSeek(xFilial("SB1")+SCK->CK_PRODUTO))
			nQtdPeso := SCK->CK_QTDVEN*SB1->B1_PESO
		EndIf
		SB2->(dbSetOrder(1))
		SB2->(DbSeek(xFilial("SB2")+SCK->CK_PRODUTO+SCK->CK_LOCAL))
		SF4->(dbSetOrder(1))
		SF4->(DbSeek(xFilial("SF4")+SCK->CK_TES))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula o preco de lista                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nValMerc  := SCK->CK_VALOR
		nPrcLista := SCK->CK_PRUNIT
		nQtdPeso  := 0
		nItem++
		If ( nPrcLista == 0 )
			nPrcLista := A410Arred(nValMerc/SCK->CK_QTDVEN,"CK_PRCVEN")
		EndIf
		nAcresFin := A410Arred(SCK->CK_PRCVEN*SE4->E4_ACRSFIN/100,"D2_PRCVEN")
		nValMerc  += A410Arred(nAcresFin*SCK->CK_QTDVEN,"D2_TOTAL")
		nDesconto := A410Arred(nPrcLista*SCK->CK_QTDVEN,"D2_DESCON")-nValMerc
		nDesconto := IIf(nDesconto==0,SCK->CK_VALDESC,nDesconto)
		nDesconto := Max(0,nDesconto)
		nPrcLista += nAcresFin
		
		//Para os outros paises, este tratamento e feito no programas que calculam os impostos.
		If cPaisLoc=="BRA"
			nValMerc  += nDesconto
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica a data de entrega para as duplicatas³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( SCK->(FieldPos("CK_ENTREG"))>0 )
			If ( dDataCnd > SCK->CK_ENTREG .And. !Empty(SCK->CK_ENTREG) )
				dDataCnd := SCK->CK_ENTREG
			EndIf
		Else
			dDataCnd  := SCJ->CJ_EMISSAO
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Agrega os itens para a funcao fiscal         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MaFisAdd(SCK->CK_PRODUTO,;   	// 1-Codigo do Produto ( Obrigatorio )
		SCK->CK_TES,;	   	// 2-Codigo do TES ( Opcional )
		SCK->CK_QTDVEN,;  	// 3-Quantidade ( Obrigatorio )
		nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
		nDesconto,; 	// 5-Valor do Desconto ( Opcional )
		"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
		"",;				// 7-Serie da NF Original ( Devolucao/Benef )
		0,;					// 8-RecNo da NF Original no arq SD1/SD2
		0,;					// 9-Valor do Frete do Item ( Opcional )
		0,;					// 10-Valor da Despesa do item ( Opcional )
		0,;					// 11-Valor do Seguro do item ( Opcional )
		0,;					// 12-Valor do Frete Autonomo ( Opcional )
		nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
		0)					// 14-Valor da Embalagem ( Opiconal )
		
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+SCK->CK_PRODUTO))
			nQtdPeso := SCK->CK_QTDVEN*SB1->B1_PESO
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calculo do ISS                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SA1->A1_INCISS == "N"
			If ( SF4->F4_ISS=="S" )
				nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(nItem)/100)),"D2_PRCVEN")
				nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(nItem)/100)),"D2_PRCVEN")
				MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
				MaFisAlt("IT_VALMERC",nValMerc,nItem)
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera peso para calcular frete              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MaFisAlt("IT_PESO",nQtdPeso,nItem)
		MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
		MaFisAlt("IT_VALMERC",nValMerc,nItem)
		
	EndIf
	SCK->(dbSkip())
EndDo
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Indica os valores do cabecalho               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MaFisAlt("NF_FRETE",SCJ->CJ_FRETE)
MaFisAlt("NF_SEGURO",SCJ->CJ_SEGURO)
MaFisAlt("NF_AUTONOMO",SCJ->CJ_FRETAUT)
MaFisAlt("NF_DESPESA",SCJ->CJ_DESPESA)
MaFisAlt("NF_DESCONTO",MaFisRet(,"NF_DESCONTO")+MaFisRet(,"NF_VALMERC")*SCJ->CJ_PDESCAB/100)
MaFisAlt("NF_DESCONTO",MaFisRet(,"NF_DESCONTO")+SCJ->CJ_DESCONT)
MaFisWrite(1)

aTemp := MeuMafis(1)

//	MaFisEnd()
//	MaFisRestore()
//Endif
RestArea(aAreaSA1)
RestArea(aArea)

Return aTemp


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±³Funcao    ³MaFisRodape³ Autor ³ Edson Maricate       ³ Data ³13.12.1999³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Atualiza o Array de Resumos da NF.                          ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß/*/
Static Function MeuMaFis(nTipo)

Local aTemp

aNFCab := MaFisNFCab()

If Empty(aNfCab)
	aTemp	:= {{"","",0,0,0,""}}
Else
	aTemp	:= aNFCab
EndIf

Conout('---aTemp---')
VarInfo('',aTemp)
Return aTemp
