/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR002   ºAutor  ³Adriano Luis Brandaoº Data ³  18/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao de nota fiscal de entrada.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Rwmake.ch"

User Function ESTR002()

Local cDesc1		:= "Este programa tem como objetivo imprimir Nota "
Local cDesc2   		:= "Fiscal de entrada."
Local cDesc3        := ""
Local cPict         := ""
Local titulo       	:= "Imprime Nota Fiscal Entrada"
Local nLin         	:= 80

Local Cabec1		:= ""
Local Cabec2       	:= ""
Local imprime      	:= .T.
Local aOrd := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 80
Private tamanho     := "P"
Private nomeprog    := "ESTR002"
Private nTipo		:= 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "ESTR002"
Private _nLin		:= 1

Private cString := "SF1"

cPerg := "ESTR02"
//
// Criacao das perguntas do relatorio.
//

_fCriaSx1()
//
// chamada das perguntas do relatorio.
//
Pergunte(cPerg,.t.)

dbSelectArea("SF1")
dbSetOrder(1)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus( { |lEnd| _fImprime() })

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprime ºAutor  ³Adriano Luis Brandaoº Data ³  18/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para imprimir a nota fiscal de entrada              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fImprime()

//
//	Tabelas e indices utilizados.
//
SF1->(DbSetOrder(1))
//	F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
SD1->(DbSetOrder(1))
// D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
SA2->(DbSetOrder(1))
// A2_FILIAL+A2_COD+A2_LOJA
SA1->(DbSetOrder(1))
// A1_FILIAL+A1_COD+A1_LOJA
SD2->(DbSetOrder(3))

SF1->(DbSeek(xFilial("SF2")+MV_PAR01+MV_PAR02,.t.))

Do While ! SF1->(Eof()) .And. xFilial("SF1") == SF1->F1_FILIAL .And. SF1->F1_DOC == MV_PAR01 .And.;
		SF1->F1_SERIE == MV_PAR02
	If SF1->F1_TIPO $ "NDB"
		Exit
	EndIf
	SF1->(DbSkip())
EndDo

SetRegua(1)
_lPrimeiro := .t.
If ! SF1->(Eof()) .And. SF1->F1_FILIAL == xFilial("SF1") .And. SF1->F1_DOC == MV_PAR01 .And.;
		SF1->F1_SERIE == MV_PAR02 .And. SF1->F1_TIPO $ "NDB"
	//
	// Comprime impressao.
	//
	If _lPrimeiro
		@ 000,000 Psay Chr(15)
		_lPrimeiro := .f.
	EndIf
	
	IncRegua()
	If lEnd
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
//		Exit
	Endif
	//
	// Variaveis utilizadas na impressao da nota fiscal
	//
	_cPedido	:= ""
	_aItens 	:= {}
	_aDev		:= {}
	_cCFO 		:= ""
	_cNatureza	:= ""
	_cRazao		:= ""
	_cCGC		:= ""
	_dEmissao 	:= Ctod("")
	_cEndereco	:= ""
	_cBairro	:= ""
	_cCEP		:= ""
	_cMun		:= ""
	_cFone		:= ""
	_cEst		:= ""
	_cIE		:= ""
	
	_nBasIcms	:= 0
	_nValIcms	:= 0
	_nValMerc	:= 0
	_nValFrete	:= 0
	_nValSegur	:= 0
	_nValDesp	:= 0
	_nValIPI	:= 0
	_nValTotNF	:= 0

	_cRazaoTr	:= "-"
	_cTipoFr	:= ""
	_cCNPJTr	:= ""
	_cEndTr		:= "-"
	_cMunTr		:= ""
	_cEstTr		:= ""
	_cIETr		:= ""
	_nQtde		:= 0
	_cEspecie	:= ""
	_cMarca		:= ""
	_nPesoBru	:= 0
	_nPespLiq	:= 0
	_cVend1		:= ""
	_cCliente	:= ""
	
	SD1->(DbSeek(xFilial("SD1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA,.t.))
	// D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
	Do While ! SD1->(Eof()) .And. SD1->D1_FILIAL = xFilial("SD1") .And. SD1->D1_DOC == SF1->F1_DOC .And.;
				SD1->D1_SERIE == SF1->F1_SERIE .And. SD1->D1_FORNECE == SF1->F1_FORNECE .And. ;
				SD1->D1_LOJA ==	SF1->F1_LOJA
		//
		// Carrega os itens da nota fiscal a serem impressos.		
		//
		_fCarItem()	
		
		SD1->(DbSkip())
	EndDo
	//
	//  Se existir itens na nota fiscal, entao sera impressa
	//
	If Len(_aItens) > 0
		_fCarCab()		// Carrega o cabecalho da N.Fiscal
		
		_fCarRoda()		// Carrega o rodape da N.Fiscal
		
		_fImprCab()		// Impressao do cabecalho da nota fiscal
		
		_fImprDet()		// Impressao dos itens da nota fiscal
		
		_fImprRoda()	// Impressao do rodape da nota fiscal
		
	EndIf
EndIF

SET DEVICE TO SCREEN

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCriaSx1 ºAutor  ³Adriano Luis Brandaoº Data ³  09/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para criacao das perguntas do relatorio.            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fCriaSx1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Da Nota Fiscal                 ³
//³MV_PAR02 = Serie                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If ! SX1->(DbSeek(cPerg+"01"))
	RecLock("SX1",.t.)
	SX1->X1_GRUPO		:= cPerg
	SX1->X1_ORDEM		:= "01"
	SX1->X1_PERGUNT		:= "Nota Fiscal ?"
	SX1->X1_VARIAVL		:= "mv_ch1"
	SX1->X1_TIPO		:= "C"
	SX1->X1_TAMANHO		:= 6
	SX1->X1_DECIMAL		:= 0
	SX1->X1_GSC			:= "G"
	SX1->X1_VAR01		:= "MV_PAR01"
	SX1->X1_DEF01		:= ""
	SX1->X1_F3			:= ""
	MsUnLock()
EndIf

If ! SX1->(DbSeek(cPerg+"02"))
	RecLock("SX1",.t.)
	SX1->X1_GRUPO		:= cPerg
	SX1->X1_ORDEM		:= "02"
	SX1->X1_PERGUNT		:= "Serie ?"
	SX1->X1_VARIAVL		:= "mv_ch2"
	SX1->X1_TIPO		:= "C"
	SX1->X1_TAMANHO		:= 3
	SX1->X1_DECIMAL		:= 0
	SX1->X1_GSC			:= "G"
	SX1->X1_VAR01		:= "MV_PAR02"
	SX1->X1_DEF01		:= ""
	SX1->X1_F3			:= ""
	MsUnLock()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCarItem ºAutor  ³Adriano Luis Brandaoº Data ³  18/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para carregar os itens da nota fiscal.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fCarItem()	// Carrega os itens a serem impressos.

aAdd(_aItens,Array(12))

_nLinha := Len(_aItens)

SB1->(DbSeek(xFilial("SB1")+SD1->D1_COD))

_aItens[_nLinha,01] := iif(Empty(SB1->B1_PNUMBER),SD1->D1_COD,SB1->B1_PNUMBER)	// Codigo do produto
_aItens[_nLinha,02]	:= SB1->B1_DESC			// Descricao do produto
_aItens[_nLinha,03] := SD1->D1_LOTECTL		// Numero do lote.
_aItens[_nlinha,04] := SB1->B1_POSIPI		// NCM
_aItens[_nLinha,05] := "000"				// S.T.
_aItens[_nLinha,06] := SD1->D1_UM			// Unidade de medida
_aItens[_nLinha,07] := SD1->D1_QUANT		// Quantidade N.F.
_aItens[_nLinha,08] := SD1->D1_VUNIT		// Valor Unitario
_aItens[_nLinha,09] := SD1->D1_TOTAL		// Valor Total Produto
_aItens[_nLinha,10] := SD1->D1_PICM			// Percentual Icms
_aItens[_nLinha,11] := SD1->D1_IPI			// Percentual Ipi
_aItens[_nLinha,12] := SD1->D1_VALIPI		// Valor do IPI


If SD1->D1_TIPO == "D"
	If Ascan(_aDev,{|x| x[1] == SD1->D1_NFORI}) == 0
        //           D2_FILIAL     +D2_DOC        +D2_SERIE       +D2_CLIENTE    +D2_LOJA      +D2_COD    +D2_ITEM                                                                                                     
		SD2->(DbSeek(xFilial("SD2")+SD1->D1_NFORI+SD1->D1_SERIORI+SD1->D1_FORNECE+SD1->D1_LOJA+SD1->D1_COD+SD1->D1_ITEMORI))
		aAdd(_aDev,{SD1->D1_NFORI,SD2->D2_EMISSAO})
	EndIf
EndIf

If ! Alltrim(SD1->D1_CF) $ _cCFO
	_cCFO 		+= iif(! Empty(_cCFO),"/","") + Alltrim(SD1->D1_CF)
	_cNatureza	+= iif(! Empty(_cNatureza),"/","") +;
	               Alltrim(Posicione("SF4",1,xFilial("SF4")+SD1->D1_TES,"F4_TEXTO"))
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCarCab  ºAutor  ³Adriano Luis Brandaoº Data ³  09/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Carrega as variaveis do cabecalho da nota fiscal.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fCarCab()

If SF1->F1_TIPO # 'N'
	
	SA1->(DbSeek(xFilial("SA1")+SF1->F1_FORNECE+SF1->F1_LOJA))
	_cRazao		:= SA1->A1_NOME
	_cCGC		:= SA1->A1_CGC
	_dEmissao 	:= SF1->F1_EMISSAO
	_cEndereco	:= SA1->A1_END
	_cBairro	:= SA1->A1_BAIRRO
	_cCEP		:= SA1->A1_CEP
	_cMun		:= SA1->A1_MUN
	_cFone		:= SA1->A1_TEL
	_cEst		:= SA1->A1_EST
	_cIE		:= SA1->A1_INSCR
	
Else                      

	SA2->(DbSeek(xFilial("SA2")+SF1->F1_FORNECE+SF1->F1_LOJA))
	_cRazao		:= SA2->A2_NOME
	_cCGC		:= SA2->A2_CGC
	_dEmissao 	:= SF1->F1_EMISSAO
	_cEndereco	:= SA2->A2_END
	_cBairro	:= SA2->A2_BAIRRO
	_cCEP		:= SA2->A2_CEP
	_cMun		:= SA2->A2_MUN
	_cFone		:= SA2->A2_TEL
	_cEst		:= SA2->A2_EST
	_cIE		:= SA2->A2_INSCR
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCarRoda ºAutor  ³Adriano Luis Brandaoº Data ³  10/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para buscar informacoes do rodape da nota fiscal.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fCarRoda()
//
// Totais da Nota Fiscal, Mercadoria e impostos.
//
_nBasIcms	:= SF1->F1_BASEICM
_nValIcms	:= SF1->F1_VALICM
_nValMerc	:= SF1->F1_VALMERC
_nValFrete	:= SF1->F1_FRETE
_nValSegur	:= SF1->F1_SEGURO
_nValDesp	:= SF1->F1_DESPESA
_nValIPI	:= SF1->F1_VALIPI
_nValTotNF	:= SF1->F1_VALBRUT
//
// Transportadora
//
If SA4->(DbSeek(xFilial("SA4")+SF1->F1_AXTRANS))
	_cRazaoTr	:= SA4->A4_COD + " - " + SA4->A4_NOME
	_cTipoFr	:= "1"
	_cCNPJTr	:= SA4->A4_CGC
	_cEndTr		:= Alltrim(SA4->A4_END) + " - " + SA4->A4_BAIRRO
	_cMunTr		:= SA4->A4_MUN
	_cEstTr		:= SA4->A4_EST
	_cIETr		:= SA4->A4_INSEST
EndIf
_nQtde		:= 0
_cEspecie	:= ""
_cMarca		:= "Alpax"
_nPesoBru	:= 0
_nPespLiq	:= 0
_cVend1		:= 0
_cCliente	:= 0


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprCab ºAutor  ³Adriano Luis Brandaoº Data ³  10/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do cabecalho da nota fiscal.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fImprCab()		// Impressao do cabecalho da nota fiscal

SetPgEject(.f.)	// inibe o salto de pagina no final do relatorio.
_nLin	:= 1
@ _nLin,176 Psay "X"
@ _nLin,207 Psay SF1->F1_DOC
_nLin	+= 4
@ _nLin,000 Psay _cNatureza
@ _nLin,119 Psay _cCFO
_nLin	+= 3
@ _nLin,000 Psay _cRazao
@ _nLin,170 Psay _cCGC  		Picture "@R 99.999.999/9999-01"
@ _nLin,210 Psay Dtoc(_dEmissao)
_nLin	+= 2
@ _nLin,000 Psay _cEndereco
@ _nLin,138 Psay _cBairro
@ _nLin,180 Psay _cCEP 			Picture "@R 99999-999"
_nLin	+= 2
@ _nLin,000 Psay _cMun
@ _nLin,120 Psay _cFone
@ _nLin,148 Psay _cEst
@ _nLin,170 Psay _cIE
_nLin	+= 3
@ _nLin,000 Psay Dtoc(_dEmissao)
@ _nLin,025 Psay SF2->F2_DUPL
@ _nLin,040 Psay _nValTotNF		Picture "@e 999,999,999.99"
/*
If Len(_aDuplic) == 1
	@ _nLin,120 Psay SF2->F2_DUPL
	@ _nLin,158 Psay Dtoc(_aDuplic[1,3])
Else
	@ _nLin,110 Psay "Vide desdobramento de duplicatas"
endIf
*/
_nLin+= 3

@ _nLin,002 Psay Extenso(_nValTotNF)
_nLin++
//
// Impressao das duplicatas.
//
/*
If Len(_aDuplic) > 1
	_nColuna	:= 0
	_nCont		:= 1
	For _nY := 1 To Len(_aDuplic)
		@ _nLin,020 + _nColuna Psay _aDuplic[_nY,1]								// Nr.Duplicata
		@ _nLin,027 + _nColuna Psay _aDuplic[_nY,2]								// Parcela
		@ _nLin,029 + _nColuna Psay _aDuplic[_nY,3]								// Vencimento
		@ _nLin,040 + _nColuna Psay _aDuplic[_nY,4] Picture "@e 9,999,999.99"	// Valor
		_nCont++
		_nColuna += 55
		If _nCont > 4
			_nCont 	:= 1
			_nLin++
			_nColuna:= 0
		EndIf
	Next _nY
EndIf
*/
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprDet ºAutor  ³Adriano Luis Brandaoº Data ³  11/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de impressao dos itens da nota fiscal.              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fImprDet()

_nLin	:= 25

For _nY := 1 to Len(_aItens)
	@ _nLin,000 Psay _aItens[_nY,01]									// Codigo do Produto
	@ _nLin,020 Psay Left(_aItens[_nY,02],44)							// Descricao do produto
	@ _nLin,082 Psay _aItens[_nY,03]									// Numero do lote
	@ _nLin,131 Psay _aItens[_nY,04]	Picture "@R 9999.99.99"			// NCM
	@ _nLin,149 Psay _aItens[_nY,05]									// S.T.
	@ _nLin,154 Psay _aItens[_nY,06]									// Unidade de medida
	@ _nLin,159 Psay _aItens[_nY,07]	Picture "@e 9999"				// Quantidade N.F.
	@ _nLin,170 Psay _aItens[_nY,08]	Picture "@e 999,999.99"			// Valor Unitário
	@ _nLin,186 Psay _aItens[_nY,09]	Picture "@e 999,999,999.99"     // Valor Total Produto
	@ _nLin,202 Psay _aItens[_nY,10]	Picture "@e 99"					// Percentual do ICMS
	@ _nLin,207 Psay _aItens[_nY,11]	Picture "@e 99.99"				// Percentual do IPI
	@ _nLin,215 Psay _aItens[_nY,12]	Picture "@e 999,999.99"			// Valor do IPI
	_nLin++
next _nY

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprRodaºAutor  ³Adriano Luis Brandaoº Data ³  11/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de impressao dos totais e impostos e rodape da      º±±
±±º          ³ nota fiscal.                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fImprRoda()

_nLin	:= 52

@ _nLin,025 Psay _nBasIcms 	Picture "@e 9,999,999.99"		// Base de calculo ICMS
@ _nLin,070 Psay _nValIcms	Picture "@e 9,999,999.99"		// Valor do ICMS
@ _nLin,208 Psay _nValMerc	Picture "@e 9,999,999.99"		// Valor da mercadoria
_nLin+= 2
@ _nLin,025 Psay _nValFrete	Picture "@e 9,999,999.99"		// Valor do Frete
@ _nLin,070 Psay _nValSegur	Picture "@e 9,999,999.99"		// Valor do Seguro
@ _nLin,120 Psay _nValDesp	Picture "@e 9,999,999.99"		// Outras despesas acessorias
@ _nLin,165 Psay _nValIpi	Picture "@e 9,999,999.99"		// Valor total do IPI
@ _nLin,208 Psay _nValTotNf	Picture "@e 9,999,999.99"		// Valor total da Nota Fiscal

_nLin+= 3
@ _nLin,000 Psay _cRazaoTr									// Razao social da transportadora
@ _nLin,135 Psay _cTipoFr									// Tipo de frete 1- emitente / 2-destin.
@ _nLin,180 Psay _cCNPJTr	Picture "@R 99.999.999/9999-99"	// CNPJ da transportadora
_nLin+= 2
@ _nLin,002 Psay _cEndTr									// Endereco Transportadora
@ _nLin,120 Psay _cMunTr									// Municipio Transportadora.
@ _nLin,172 Psay _cEstTr									// U.F. Transportadora
@ _nLin,180 Psay _cIETr										// Inscricao Estadual Transportadora.
_nLin+= 2	
@ _nLin,010 Psay _nQtde										// Quantidade da especie.
@ _nLin,050 Psay _cEspecie									// Especie do produto
@ _nLin,090 Psay _cMarca									// Marca do produto
@ _nLin,175 Psay _nPesoBru	Picture "@e 9,999,999.999"		// Peso Bruto
@ _nLin,208 Psay _nPespLiq	Picture "@e 9,999,999.999"		// Peso Liquido
_nLin+=3
@ _nLin,002 Psay "Vendedor               Cliente  Pedido"
_nLin++
@ _nLin,002 Psay _cVend1									// codigo do vendedor
@ _nLin,026 Psay _cCliente									// Codigo do cliente
@ _nLin,034 Psay _cPedido									// Numero dos pedidos de vendas Alpax.
_nLin++
_cMens := ""
For _nY := 1 to Len(_aDev)
	If _nY == 1
		_cMens += "Ref.nossa Nota Fiscal de Saida "
	EndIf
	_cMens += _aDev[_nY,1]
	_cMens += " de "
	_cMens += Dtoc(_aDev[_nY,2])
	_cMens += ","
Next _Zy
@ _nLin,000 Psay _cMens
_nLin+=9
@ _nLin,095 Psay SF1->F1_DOC								// Nr. da Nota fiscal no canhoto
@ _nLin,212 Psay SF1->F1_DOC								// Nr. da Nota fiscal no canhoto
_nLin+=4
@ _nLin,000 Psay "."
SetPrc(00,00)

Return