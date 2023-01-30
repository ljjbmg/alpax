/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR017   บAutor  ณOCIMAR              บ Data ณ  04/11/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressao da Nota Fiscal de Entrada(MULTI VOLUME)           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Rwmake.ch"

User Function ESTR017()

Local cDesc1		:= "Este programa tem como objetivo imprimir Nota "
Local cDesc2   		:= "Fiscal de saida."
Local cDesc3        := ""
Local cPict         := ""
Local titulo       	:= "Imprime Nota Fiscal MULTI-VOLUME"
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
Private nomeprog    := "ESTR017"
Private nTipo		:= 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "ESTR017"
Private _nLin		:= 1
Private _nLimiteIt	:= 18	// limite de linhas de produto por nota fiscal
Private cString := "SF1"

cPerg := "ESTR17"
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprime บAutor  ณAdriano Luis Brandaoบ Data ณ  10/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para imprimir a nota fiscal de saida.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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

SF1->(DbSeek(xFilial("SF1")+MV_PAR01+MV_PAR02,.t.))

Do While ! SF1->(Eof()) .And. xFilial("SF1") == SF1->F1_FILIAL .And. SF1->F1_DOC == MV_PAR01 .And.;
		SF1->F1_SERIE == MV_PAR02
	If SF1->F1_TIPO $ "NDBI"
		Exit
	EndIf
	SF1->(DbSkip())
EndDo

SetRegua(1)
_lPrimeiro := .t.
If ! SF1->(Eof()) .And. SF1->F1_FILIAL == xFilial("SF1") .And. SF1->F1_DOC == MV_PAR01 .And.;
		SF1->F1_SERIE == MV_PAR02 .And. SF1->F1_TIPO $ "NDBI"
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
	If Len(_aItens) > 0 .Or. Len(_aItServ) > 0
		_fCarCab()		// Carrega o cabecalho da N.Fiscal
		
		_fCarRoda()		// Carrega o rodape da N.Fiscal
		
		_fImprDet()		// Impressao do cabecalho e dos itens da nota fiscal 
		
		
	EndIf
EndIf

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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณAdriano Luis Brandaoบ Data ณ  09/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para criacao das perguntas do relatorio.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fCriaSx1()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Da Nota Fiscal                 ณ
//ณMV_PAR02 = Serie				             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","Nota Fiscal ?","Nota Fiscal ?","Nota Fiscal ?","mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Serie ?"      ,"Serie ?"      ,"Serie ?"      ,"mv_ch2","C",03,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","","","")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCarItem บAutor  ณAdriano Luis Brandaoบ Data ณ  09/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para carregar os itens da nota fiscal.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCarCab  บAutor  ณAdriano Luis Brandaoบ Data ณ  09/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega as variaveis do cabecalho da nota fiscal.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCarRoda บAutor  ณAdriano Luis Brandaoบ Data ณ  10/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para buscar informacoes do rodape da nota fiscal.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprCab บAutor  ณAdriano Luis Brandaoบ Data ณ  10/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para impressao do cabecalho da nota fiscal.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fImprCab()		// Impressao do cabecalho da nota fiscal

SetPgEject(.f.)	// inibe o salto de pagina no final do relatorio.
_nLin	:= 1
@ _nLin,177 Psay "X"
@ _nLin,207 Psay SF1->F1_DOC
_nLin	+= 4
@ _nLin,000 Psay _cNatureza
@ _nLin,120 Psay _cCFO
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
@ _nLin,025 Psay SF1->F1_DUPL
@ _nLin,040 Psay _nValTotNF		Picture "@e 999,999,999.99"
/*
If Len(_aDuplic) == 1
	@ _nLin,120 Psay SF2->F2_DUPL
	@ _nLin,158 Psay Dtoc(_aDuplic[1,3])
Else
	@ _nLin,110 Psay "Vide desdobramento de duplicatas"
endIf
*/
_nLin+= 2

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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprDet บAutor  ณAdriano Luis Brandaoบ Data ณ  11/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao dos itens da nota fiscal.              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fImprDet()

Local _nItem	:= 0
Local _aItens2	:= {}
Local _aItServ2	:= {}
Local _lProd	:= .f.	// se terminou o numero de itens de produtos
Local _lEncerra	:= .f.	// se encerra a nota fiscal.
Local _nY

_nItem 		:= 1	// Numero de Itens de produtos Impressos

Do While !_lProd .or. !_lEncerra
	
	_aItens2	:= {}
	
	// Carrega Itens de produtos parciais com limite da nota fiscal
	For _nY := 1 to _nLimiteIt
		If _nItem <= Len(_aItens)	// verifica se nao estourou os itens da nota fiscal
			aAdd(_aItens2,aClone(_aItens[_nItem]))
			_nItem++
		Else		// se ja carregou tudo forca saida do looping
			_nY := _nLimiteIt + 1
		EndIf
	Next _nY
	
	// Verifica se carregou todos os itens da Nota fiscal
	If Len(_aItens) == 0 .Or. (_nItem-1) == Len(_aItens)
		_lProd := .t.
	EndIf
	
	// Se carregou todos os itens de produtos e servicos e tem espaco para as mensagens para o corpo da Nota Fiscal
	If _lProd .And. (Len(_aItens2)) <= _nLimiteIt
		_lEncerra := .t.
	EndIf

	_fImprCab(_lEncerra)
		
	_nLin	:= 25
	
For _nY := 1 to Len(_aItens2)
	@ _nLin,000 Psay _aItens2[_nY,01]									// Codigo do Produto
	@ _nLin,020 Psay Left(_aItens2[_nY,02],44)							// Descricao do produto
	@ _nLin,083 Psay _aItens2[_nY,03]									// Numero do lote
	@ _nLin,147 Psay _aItens2[_nY,04]	Picture "@R 9999.99.99"			// NCM
	@ _nLin,160 Psay _aItens2[_nY,05]									// S.T.
	@ _nLin,167 Psay _aItens2[_nY,06]									// Unidade de medida
	@ _nLin,172 Psay _aItens2[_nY,07]	Picture "@e 99999"				// Quantidade N.F.
	@ _nLin,179 Psay _aItens2[_nY,08]	Picture "@e 999,999.99"			// Valor Unitแrio
	@ _nLin,193 Psay _aItens2[_nY,09]	Picture "@e 999,999,999.99"     // Valor Total Produto
	@ _nLin,209 Psay _aItens2[_nY,10]	Picture "@e 99"					// Percentual do ICMS
	@ _nLin,213 Psay _aItens2[_nY,11]	Picture "@e 99.99"				// Percentual do IPI
	@ _nLin,218 Psay _aItens2[_nY,12]	Picture "@e 999,999.99"			// Valor do IPI
	_nLin++
next _nY

	// Impressao das mensagens do corpo da nota fiscal se estiver encerrando a ultima nota fiscal.
	
	_fImprRoda(_lEncerra)	// Impressao do rodape da nota fiscal
	
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprRodaบAutor  ณAdriano Luis Brandaoบ Data ณ  11/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao dos totais e impostos e rodape da      บฑฑ
ฑฑบ          ณ nota fiscal.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fImprRoda(_lValor)

_nLin	:= 51

// verifica se ira imprimir os valores, apenas se o ultimo formulario da nota fiscal.
If _lValor
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
	@ _nLin,137 Psay _cTipoFr									// Tipo de frete 1- emitente / 2-destin.
	@ _nLin,182 Psay _cCNPJTr	Picture "@R 99.999.999/9999-99"	// CNPJ da transportadora
	_nLin+= 2
	@ _nLin,002 Psay _cEndTr									// Endereco Transportadora
	@ _nLin,120 Psay _cMunTr									// Municipio Transportadora.
	@ _nLin,174 Psay _cEstTr
	// U.F. Transportadora
	@ _nLin,182 Psay _cIETr										// Inscricao Estadual Transportadora.
	_nLin+= 2
	@ _nLin,010 Psay _nQtde										// Quantidade da especie.
	@ _nLin,050 Psay _cEspecie									// Especie do produto
	@ _nLin,090 Psay _cMarca									// Marca do produto
	@ _nLin,175 Psay _nPesoBru	Picture "@e 9,999,999.999"		// Peso Bruto
	@ _nLin,208 Psay _nPespLiq	Picture "@e 9,999,999.999"		// Peso Liquido
	_nLin+=3
	@ _nLin,002 Psay "Vendedor                        Cliente                              Box "
	_nLin++
	@ _nLin,002 Psay _cVend1									// codigo do vendedor
	@ _nLin,034 Psay _cCliente									// Codigo do cliente 
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
	
	_nLin++
	@ _nLin,002 Psay "Observacao:" + _cMens
	_nLin++
	@ _nLin,002 Psay "           " 
	_nLin++
	
	_cPeds := ""
	_nLin+=7
Else
	@ _nLin,025 Psay "************"		// Base de calculo ICMS
	@ _nLin,070 Psay "************"		// Valor do ICMS
	@ _nLin,208 Psay "************"		// Valor da mercadoria
	_nLin+= 2
	@ _nLin,025 Psay "************"		// Valor do Frete
	@ _nLin,070 Psay "************"		// Valor do Seguro
	@ _nLin,120 Psay "************"		// Outras despesas acessorias
	@ _nLin,165 Psay "************"		// Valor total do IPI
	@ _nLin,208 Psay "************"		// Valor total da Nota Fiscal
	
	_nLin+= 3
	@ _nLin,000 Psay _cRazaoTr									// Razao social da transportadora
	@ _nLin,135 Psay _cTipoFr									// Tipo de frete 1- emitente / 2-destin.
	@ _nLin,180 Psay _cCNPJTr	Picture "@R 99.999.999/9999-99"	// CNPJ da transportadora
	_nLin+= 2
	@ _nLin,002 Psay _cEndTr									// Endereco Transportadora
	@ _nLin,120 Psay _cMunTr									// Municipio Transportadora.
	@ _nLin,172 Psay _cEstTr
	// U.F. Transportadora
	@ _nLin,180 Psay _cIETr										// Inscricao Estadual Transportadora.
	_nLin+= 2
	@ _nLin,010 Psay "********"									// Quantidade da especie.
	@ _nLin,050 Psay "********"									// Especie do produto
	@ _nLin,090 Psay "********"         						// Marca do produto
	@ _nLin,175 Psay "********"									// Peso Bruto
	@ _nLin,208 Psay "********"									// Peso Liquido
	_nLin+=13
EndIf
@ _nLin,097 Psay SF1->F1_DOC								// Nr. da Nota fiscal no canhoto
@ _nLin,212 Psay SF1->F1_DOC								// Nr. da Nota fiscal no canhoto
_nLin+=3

@ _nLin,000 Psay "."
SetPrc(00,00)
SetPgEject(.f.)

Return
