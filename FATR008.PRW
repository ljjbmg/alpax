/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR008   บAutor  ณOCIMAR              บ Data ณ  04/11/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressao da Nota Fiscal de Saida.(MULTI VOLUME).           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Rwmake.ch"
#Include "Topconn.ch"


User Function FATR008()

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
Private nomeprog    := "FATR008"
Private nTipo		:= 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "FATR008"
Private _nLin		:= 1
Private _nTxPis		:= GetMv("MV_TXPIS")
PRIVATE _nTxCofin	:= GetMv("MV_TXCOFIN")
Private _nLimiteIt	:= 6	// limite de linhas de produto por nota fiscal -- colocar 8 quando linha detalhe for dupla
Private _nLimItSrv  := 4	// limite de linhas de servico por nota fiscal

Private cString := "SF2"

cPerg := "FATR08"
//
// Criacao das perguntas do relatorio.
//

_fCriaSx1()
//
// chamada das perguntas do relatorio.
//
Pergunte(cPerg,.t.)
// Verifica o numero de formularios e da uma mensagem
_fNrForm()

dbSelectArea("SF2")
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

MSGRUN("Aguarde imprimindo Ficha de emergencia !!!",,{ || U_FATR010AUT(MV_PAR01,MV_PAR02,MV_PAR03) })

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

dbSelectArea("SF2")
dbSetOrder(1)

SetRegua(Val(MV_PAR02) - Val(MV_PAR01))
//
//	Tabelas e indices utilizados.
//
SB1->(DbSetOrder(1))
// B1_FILIAL + B1_COD
SF4->(DbSetOrder(1))
// F4_FILIAL + F4_COD
SF2->(DbSetOrder(1))
// F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL
SD2->(DbSetOrder(3))
// D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
SA1->(DbSetOrder(1))
// A1_FILIAL+A1_COD+A1_LOJA
SE1->(DbSetOrder(1))
// E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
SC5->(DbSetOrder(1))
// C5_FILIAL+C5_NUM

SF2->(DbSeek(xFilial("SF2")+MV_PAR01+MV_PAR03,.t.))

_lPrimeiro := .t.
IncRegua()
Do While ! SF2->(Eof()) .And. SF2->F2_FILIAL == xFilial("SF2") .And. SF2->F2_SERIE == MV_PAR03 .And. SF2->F2_DOC <= MV_PAR02
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
		Exit
	Endif
	//
	// Variaveis utilizadas na impressao da nota fiscal
	//
	_cPedido	:= ""
	_cPedCli	:= ""
	_aItens 	:= {}
	_aItServ	:= {}
	_aDuplic	:= {}
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
	_cMens1		:= ""
	_cMens2		:= ""
	
	_nBasIcms	:= 0
	_nValIcms	:= 0
	_nValMerc	:= 0
	_nValFrete	:= 0
	_nValSegur	:= 0
	_nValDesp	:= 0
	_nValIPI	:= 0
	_nValTotNF	:= 0
	_nValIss	:= 0
	_nValTotSr	:= 0
	_nValDesZF  := 0
	_nBsRetIcm	:= 0
	_nRetIcm	:= 0
	
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
	_cBox		:= ""
	_cSubTrib   := ""
	_cEndEntr	:= ""
	
	_aPedido 	:= {}
	
	SD2->(DbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE,.t.))
	Do While ! SD2->(Eof()) .And. SD2->D2_FILIAL = xFilial("SD2") .And. SD2->D2_DOC == SF2->F2_DOC .And.;
		SD2->D2_SERIE == SF2->F2_SERIE
		
		_cPedido	:= SD2->D2_PEDIDO //iif(_cPedido $ SD2->D2_PEDIDO,"",iif(Empty(_cPedido),;
		//ALLTRIM(SD2->D2_PEDIDO),"/"+ALLTRIM(SD2->D2_PEDIDO)))
		If Ascan(_aPedido,_cPedido) == 0
			aAdd(_aPedido,_cPedido)
		EndIf
		//
		// Carrega os itens da nota fiscal a serem impressos.
		//
		_fCarItem()
		
		SD2->(DbSkip())
	EndDo
	//
	//  Se existir itens na nota fiscal, entao sera impressa
	//
	If Len(_aItens) > 0 .Or. Len(_aItServ) > 0
		_fCarCab()		// Carrega o cabecalho da N.Fiscal
		
		_fCarRoda()		// Carrega o rodape da N.Fiscal
		
		_fImprDet()		// Impressao do cabecalho e dos itens da nota fiscal
		
		
	EndIf
	//
	// proximo registro.
	//
	SF2->(DbSkip())
EndDo

SET DEVICE TO SCREEN

SetPgEject(.F.)

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
//ณMV_PAR02 = Ate Nota Fiscal                ณ
//ณMV_PAR03 = Serie                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","Da Nota Fiscal"        ,"Da Nota Fiscal"        ,"Da Nota Fiscal"          ,"mv_ch1","C",09,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Ate Nota Fiscal"       ,"Ate Nota Fiscal"       ,"Ate Nota Fiscal"         ,"mv_ch2","C",09,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Serie ?"       ,"Serie ?"       ,"Serie ?"         ,"mv_ch3","C",03,0,0,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",,,)

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

SF4->(DbSeek(xFilial("SF4")+SD2->D2_TES))
SB1->(DbSeek(xFilial("SB1")+SD2->D2_COD))
If ! SF2->F2_TIPO $ "DB"
	SA1->(DbSeek(xFilial("SA1")+SD2->D2_CLIENTE+SD2->D2_LOJA))
EndIf

If SD2->D2_TES == "552"		// se for TES de frete ira apenas somar no total e nao ira incluir nos itens
	_nValFrete	+= SD2->D2_TOTAL
Else
	
	//
	//	Carrega Item de servicos
	//
	If SF4->F4_ISS == "S" 
		
		aAdd(_aItServ,{SD2->D2_QUANT,SB1->B1_DESC,SD2->D2_TOTAL})  // quantidade + descricao produto + Preco total
		_nValTotSr += SD2->D2_TOTAL
		//
		//	Carrega Item de produtos
		//
	Else
		aAdd(_aItens,Array(20))	// NUMERO DE COLUNAS
		_nLinha := Len(_aItens)
		_cPedCli := Left(Posicione("SC5",1,xFilial("SC5")+SD2->D2_PEDIDO,"C5_AXPEDCL"),12)
		_aItens[_nLinha,01] := IIF(Empty(SB1->B1_PNUMBER),SD2->D2_COD,SB1->B1_PNUMBER)	// Codigo do produto
		_aItens[_nLinha,02]	:= Left(SB1->B1_DESC,44)+"-(PC."+_cPedCli+")" 				// Descricao do produto
		_aItens[_nLinha,03] := SD2->D2_LOTECTL											// Numero do lote.
		_aItens[_nlinha,04] := SB1->B1_POSIPI											// NCM
		//	_aItens[_nLinha,05] := "000"													// S.T.
		_aItens[_nLinha,05] :=(IIF(EMPTY(SB1->B1_ORIGEM+SB1->B1_CLASFIS),"000",(SB1->B1_ORIGEM+SB1->B1_CLASFIS)))
		_aItens[_nLinha,06] := SB1->B1_UM												// Unidade de medida
		_aItens[_nLinha,07] := SD2->D2_QUANT											// Quantidade N.F.
		If SD2->D2_DESCZFR > 0 .And. Substr(SD2->D2_CF,2,3) $ "110/109"	// Desconto zona franca de manaus tem que ser somado no valor unitario e total do item.
			_aItens[_nLinha,08] := SD2->D2_PRCVEN + (SD2->D2_DESCZFR/SD2->D2_QUANT)		// Valor Unitario
			_aItens[_nLinha,09] := SD2->D2_TOTAL + SD2->D2_DESCZFR						// Valor Total Produto
			_nValDesZF+= SD2->D2_DESCZFR
		Else
			_aItens[_nLinha,08] := SD2->D2_PRCVEN										// Valor Unitario
			_aItens[_nLinha,09] := SD2->D2_TOTAL										// Valor Total Produto
		EndIf
		_aItens[_nLinha,10] := SD2->D2_PICM												// Percentual Icms
		_aItens[_nLinha,11] := SD2->D2_IPI												// Percentual Ipi
		_aItens[_nLinha,12] := SD2->D2_VALIPI											// Valor do IPI
		_aItens[_nLinha,13] := SB1->B1_MARCA											// Marca
		_aItens[_nLinha,14] := SB1->B1_CAPACID											// Embalagem
		_aItens[_nLinha,15]	:= SB1->B1_AXNONU											// Nr.ONU
		_aItens[_nLinha,16]	:= SB1->B1_AXRISCO											// Risco
		_aItens[_nLinha,17]	:= SB1->B1_AXNRRIS											// Numero Risco
		_aItens[_nLinha,18]	:= _fgrupo()											// Grupo de Embalagem
		_aItens[_nLinha,19]	:= (IIF(EMPTY(Dtoc(SD2->D2_DTVALID)),"X",Dtoc(SD2->D2_DTVALID)))	// Validade do Lote
		If Substr(SD2->D2_CF,2,3) $ "405/404"
			_aItens[_nLinha,20] := "ICMS RETIDO NA FONTE POR SUBSTITUICAO TRIBUTARIA"
		Else
			If Substr(SD2->D2_CF,2,3) == "403"
				_aItens[_nLinha,20] := "ICMS RECOLHIDO PELO REGIME DE SUBSTITUICAO TRIBUTARIA"
			EndIf
		EndIf
	EndIf
	If ! Alltrim(SD2->D2_CF) $ _cCFO
		_cCFO 		+= iif(! Empty(_cCFO),"/","") + Alltrim(SD2->D2_CF)
		_cNatureza	+= iif(! Empty(_cNatureza),"/","") +;
		Alltrim(SF4->F4_TEXTO)
	EndIf
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

If ! SF2->F2_TIPO $ "DB"
	
	SA1->(DbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA))
	SD2->(DbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE,.t.))
	SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
	
	_cRazao		:= SA1->A1_NOME
	_cCGC		:= SA1->A1_CGC
	_dEmissao 	:= SF2->F2_EMISSAO
	_cEndereco	:= SA1->A1_END
	_cBairro	:= SA1->A1_BAIRRO
	_cCEP		:= SA1->A1_CEP
	_cMun		:= SA1->A1_MUN
	_cFone		:= SA1->A1_TEL
	_cEst		:= SA1->A1_EST
	_cIE		:= IIF(SA1->A1_TIPO == "L",SA1->A1_INSCRUR,SA1->A1_INSCR)
	_nValIss	:= SF2->F2_VALISS
	_cBox		:= SF2->F2_AXBOX
	_cEndEntr   := SC5->C5_AXENDEN
	//
	// Consulta as duplicatas geradas.
	//
	SE1->(DbSeek(xFilial("SE1")+SF2->F2_SERIE+SF2->F2_DUPL,.t.))
	
	Do While ! SE1->(Eof()) .and. SE1->E1_FILIAL == xFilial("SE1") .And. ;
		SE1->E1_PREFIXO == SF2->F2_SERIE .And. SE1->E1_NUM == SF2->F2_DUPL
		If ! Left(SE1->E1_TIPO,3) $ "NF "
			SE1->(DbSkip())
			Loop
		Endif
		aAdd(_aDuplic,{SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_VENCTO, SE1->E1_VALOR })
		SE1->(DbSkip())
	EndDo
	
Else
	SA2->(DbSeek(xFilial("SA2")+SF2->F2_CLIENTE+SF2->F2_LOJA))
	SD2->(DbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE,.t.))
	SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
	
	_cRazao		:= SA2->A2_NOME
	_cCGC		:= SA2->A2_CGC
	_dEmissao 	:= SF2->F2_EMISSAO
	_cEndereco	:= SA2->A2_END
	_cBairro	:= SA2->A2_BAIRRO
	_cCEP		:= SA2->A2_CEP
	_cMun		:= SA2->A2_MUN
	_cFone		:= ALLTRIM(SA2->A2_TEL)
	_cEst		:= SA2->A2_EST
	_cIE		:= SA2->A2_INSCR
	_nValIss	:= SF2->F2_VALISS
	_cBox		:= SF2->F2_AXBOX
	_cEndEntr   := SC5->C5_AXENDEN
	
EndIf

SD2->(DbSkip())

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
_nBasIcms	:= SF2->F2_BASEICM
If SF2->F2_TIPO = 'I'
	_nValIcms	:= SF2->F2_VALMERC
	_nValMerc	:= 0
	_nValTotNF	:= 0                       //OCIMAR 08/05/07
Else
	_nValIcms	:= SF2->F2_VALICM
	_nValMerc	:= (SF2->F2_VALMERC - _nValTotSr - _nValFrete)
	_nValTotNF	:= SF2->F2_VALBRUT	       //OCIMAR 08/05/07
	
EndIf
//_nValFrete	:= SF2->F2_FRETE
_nValSegur	:= SF2->F2_SEGURO
_nValDesp	:= SF2->F2_DESPESA
_nValIPI	:= SF2->F2_VALIPI
_nBsRetIcm	:= SF2->F2_BRICMS
_nRetIcm	:= SF2->F2_ICMSRET

//
// Transportadora
//
SC5->((xFilial("SC5")+SUBSTR(_cPedido,1,6)))
If SA4->(DbSeek(xFilial("SA4")+SF2->F2_TRANSP))
	_cRazaoTr	:= SA4->A4_COD + " - " + SA4->A4_NOME
	_cTipoFr	:= iif(SC5->C5_TPFRETE=="C","1","2")
	_cCNPJTr	:= SA4->A4_CGC
	_cEndTr		:= Alltrim(SA4->A4_END) + " - " + SA4->A4_BAIRRO
	_cMunTr		:= SA4->A4_MUN
	_cEstTr		:= SA4->A4_EST
	_cIETr		:= SA4->A4_INSEST
EndIf
_nQtde		:= SF2->F2_VOLUME1 //0
_cEspecie	:= SF2->F2_ESPECI1 //"Caixa"
_cMarca		:= "Alpax"
_nPesoBru	:= SF2->F2_PBRUTO
_nPespLiq	:= SF2->F2_PLIQUI
// Busca nome completo do usuario
psworder(1)
if pswseek(SC5->C5_AXATEN1,.t.)
	_aUsuario := pswret(1)
	_cVend1		:= _aUsuario[1,4]
endif

_cCliente	:= SF2->F2_CLIENTE
_cMens1		:= SC5->C5_MENNOTA
//_cMens2		:= SC5->C5_MENNOT2
_cPedCli	:= SC5->C5_AXPEDCL

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
Local _lServ	:= .f.	// se terminou o numero de itens de servicos.
Local _lEncerra	:= .f.	// se encerra a nota fiscal.
Local _nY
Local _aMens	:= {}	// Mensagem para nota fiscal, incluindo descontos ZF


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncao para retornar todas as mensagens da nota fiscalณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
_aMens	:= fMensCorpo()

// numero de formularios para contador de paginas. (terminar Ocimar)
/*
_nLinhas := Max(Len(_aItens),Len(_aItServ))+Len(_aMens)
_nLinhas := _nLinhas /
*/

_nItem 		:= 1	// Numero de Itens de produtos Impressos
_nItemSrv 	:= 1	// Numero de Itens de servicos Impressos

Do While !_lProd .or. !_lServ .or. ! _lEncerra
	
	_aItens2	:= {}
	_aItServ2 	:= {}
	
	// Carrega Itens de produtos parciais com limite da nota fiscal
	For _nY := 1 to _nLimiteIt
		If _nItem <= Len(_aItens)	// verifica se nao estourou os itens da nota fiscal
			aAdd(_aItens2,aClone(_aItens[_nItem]))
			_nItem++
		Else		// se ja carregou tudo forca saida do looping
			_nY := _nLimiteIt + 1
		EndIf
	Next _nY
	
	// Carrega Itens de Servico parciais com limite da nota fiscal.
	For _nY := 1 To _nLimItSrv
		If _nItemSrv <= Len(_aItServ)
			aAdd(_aItServ2,aClone(_aItServ[_nItemSrv]))
			_nItemSrv++
		Else		// se ja carregou tudo forca saida do looping
			_nY := _nLimItSrv + 1
		EndIf
	Next _nY
	
	// Verifica se carregou todos os itens da Nota fiscal
	If Len(_aItens) == 0 .Or. (_nItem-1) == Len(_aItens)
		_lProd := .t.
	EndIf
	
	// Verifica se carregou todos os itens de servicos
	If Len(_aItServ) == 0 .Or. (_nItemSrv-1) == Len(_aItServ)
		_lServ	:= .t.
	EndIf
	
	// Se carregou todos os itens de produtos e servicos e tem espaco para as mensagens para o corpo da Nota Fiscal
	If _lProd .And. _lServ .And. (Len(_aItens2)+Len(_aMens)) <= _nLimiteIt
		_lEncerra := .t.
	EndIf
	
	_fImprCab(_lEncerra)
	
	_nLin	:= 25
	If SF2->F2_TIPO = 'I'                                      // OCIMAR INICIO DETALHE ZERADO
		//    For _nY := 1 to Len(_aItens2)
		@ _nLin,000 Psay "-"									// Codigo do Produto
		@ _nLin,020 Psay "-"									// Descricao do produto
		@ _nLin,083 Psay "-"									// Numero do lote
		@ _nLin,097 Psay "-"									// Marca
		@ _nLin,114 Psay "-"									// Embalagem
		@ _nLin,132 Psay "-"            						// ONU
		@ _nLin,137 Psay "-"									// Risco
		@ _nLin,141 Psay "-"									// Numero Risco
		@ _nLin,147 Psay "-"                        			// NCM
		@ _nLin,160 Psay "-"									// S.T.
		@ _nLin,167 Psay "-"									// Unidade de medida
		@ _nLin,173 Psay "-"                    				// Quantidade N.F.
		@ _nLin,179 Psay "-"                        			// Valor Unitแrio
		@ _nLin,193 Psay "-"                                    // Valor Total Produto
		@ _nLin,209 Psay "-"                  					// Percentual do ICMS
		@ _nLin,213 Psay "-"                    				// Percentual do IPI
		@ _nLin,218 Psay "-"                        			// Valor do IPI
		_nLin++
		//	next _nY
	Else                                                   // OCIMAR TERMINO DETALHE ZERADO
		For _nY := 1 to Len(_aItens2)
			@ _nLin,000 Psay _aItens2[_nY,01]									// Codigo do Produto
			@ _nLin,020 Psay _aItens2[_nY,02]									// Descricao do produto
			@ _nLin,083 Psay _aItens2[_nY,03]									// Numero do lote
			@ _nLin,097 Psay _aItens2[_nY,13]									// Marca
			@ _nLin,114 Psay _aItens2[_nY,14]									// Embalagem
			@ _nLin,132 Psay Alltrim(Str(_aItens2[_nY,15]))					    // ONU
			@ _nLin,137 Psay left(_aItens2[_nY,16],4)							// Risco
			@ _nLin,141 Psay _aItens2[_nY,17]									// Numero Risco
			@ _nLin,147 Psay _aItens2[_nY,04]	Picture "@R 9999.99.99"			// NCM
			@ _nLin,160 Psay _aItens2[_nY,05]									// S.T.
			@ _nLin,167 Psay _aItens2[_nY,06]									// Unidade de medida
			@ _nLin,172 Psay _aItens2[_nY,07]	Picture "@e 99999"				// Quantidade N.F.
			@ _nLin,179 Psay _aItens2[_nY,08]	Picture "@e 999,999.999"			// Valor Unitแrio
			@ _nLin,193 Psay _aItens2[_nY,09]	Picture "@e 999,999,999.99"     // Valor Total Produto
			@ _nLin,209 Psay _aItens2[_nY,10]	Picture "@e 99"					// Percentual do ICMS
			@ _nLin,213 Psay _aItens2[_nY,11]	Picture "@e 99.99"				// Percentual do IPI
			@ _nLin,218 Psay _aItens2[_nY,12]	Picture "@e 999,999.99"			// Valor do IPI
			_nLin++
			If ! Empty(_aItens2[_nY,03])
				@ _nLin,020 Psay "G.Embalagem : "
				@ _nLin,034 Psay _aItens2[_nY,18]								// Grupo de Embalagem
				@ _nLin,050 Psay "Validade Lote : "
				@ _nLin,065 Psay _aItens2[_nY,19]                             	// Validade do Lote
				_nLin ++
			EndIf
			If ! Empty(_aItens2[_nY,20])
				@ _nLin,020 Psay _aItens2[_nY,20]                             // SUBST. TRIBUTARIA
				_nLin ++
			EndIf
		next _nY
	EndIf
	// Impressao das mensagens do corpo da nota fiscal se estiver encerrando a ultima nota fiscal.
	If _lEncerra
		For _nY := 1 to Len(_aMens)	               //nao esta pulando linha OCIMAR
			@ _nLin,020 Psay _aMens[_nY]
			_nLin++
		Next _nY
	EndIf
	//
	// Impressao dos servicos
	//
	_nLin	:= 46
	For _nY := 1 to Len(_aItServ2)
		@ _nLin,002 Psay _aItServ2[_nY,001] Picture "@e 9999" 		// Quantidade
		@ _nLin,009 Psay _aItServ2[_nY,002]					    	// Descricao do produto
		@ _nLin,087 Psay "R$."
		@ _nLin,090 Psay _aItServ2[_nY,003] Picture "@e 999,999.99"	// Total servico
		if _nY == 2
			If _lEncerra    	// se estiver encerrando imprime valor
				@ _nLin,208 Psay _nValIss		Picture "@e 9,999,999.99"	// Valor ISS
			Else
				@ _nLin,208 Psay "************"
			EndIf
		EndIf
		_nLin++
	Next _nY
	
	If Len(_aItServ2) < 2 .and. _lEncerra
		@ 047,208 Psay _nValIss		Picture "@e 9,999,999.99"	// Valor ISS
		_nLin++
	EndIf
	
	If _nValTotSr > 0
		_nLin := 49
		If _lEncerra			// se estiver encerrando imprime valor
			@ _nLin,208 Psay _nValTotSr	Picture "@e 9,999,999.99"			// Valor total de servicos
		Else
			@ _nLin,208 Psay "************"
		EndIf
		_nLin++
	EndIf
	
	_fImprRoda(_lEncerra)	// Impressao do rodape da nota fiscal
	
EndDo

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

Static Function _fImprCab(_lValor)		// Impressao do cabecalho da nota fiscal

SetPgEject(.f.)	// inibe o salto de pagina no final do relatorio.

If Len(ALLTRIM(_cCGC)) > 11
	_cCGC := Transform(_cCGC,"@R 99.999.999/9999-99")
Else
	_cCGC := Transform(_cCGC,"@R 999.999.999-99")
EndIf

_nLin	:= 1
@ _nLin,162 Psay "X"
@ _nLin,207 Psay SF2->F2_DOC
_nLin	+= 5
@ _nLin,000 Psay _cNatureza
@ _nLin,120 Psay _cCFO
_nLin	+= 3
@ _nLin,000 Psay _cRazao
@ _nLin,170 Psay _cCGC
@ _nLin,210 Psay Dtoc(_dEmissao)
_nLin	+= 2
@ _nLin,000 Psay _cEndereco
@ _nLin,138 Psay _cBairro
@ _nLin,180 Psay _cCEP 			Picture "@R 99999-999"
_nLin	+= 2
@ _nLin,000 Psay _cMun
@ _nLin,120 Psay _cFone
@ _nLin,149 Psay _cEst
@ _nLin,170 Psay _cIE
_nLin	+= 3

// se estiver encerrando a nota fiscal emite os valores, caso contrato os campos de valores com caracter *
If _lValor
	@ _nLin,000 Psay Dtoc(_dEmissao)
	@ _nLin,025 Psay SF2->F2_DUPL
	@ _nLin,040 Psay SF2->F2_VALFAT	Picture "@e 999,999,999.99"
	If Len(_aDuplic) == 1
		@ _nLin,120 Psay SF2->F2_DUPL
		@ _nLin,158 Psay Dtoc(_aDuplic[1,3])
	Else
		@ _nLin,110 Psay "Vide desdobramento de duplicatas"
	endIf
	_nLin+= 2
	
	@ _nLin,002 Psay iif(SF2->F2_VALFAT > 0,Extenso(SF2->F2_VALFAT),"")
	_nLin++
	//
	// Impressao das duplicatas.
	//
	If Len(_aDuplic) > 1
		_nColuna	:= 0
		_nCont		:= 1
		For _nY := 1 To Len(_aDuplic)
			@ _nLin,020 + _nColuna Psay _aDuplic[_nY,1]								// Nr.Duplicata
			@ _nLin,030 + _nColuna Psay _aDuplic[_nY,2]								// Parcela
			@ _nLin,032 + _nColuna Psay _aDuplic[_nY,3]								// Vencimento
			@ _nLin,042 + _nColuna Psay _aDuplic[_nY,4] Picture "@e 9,999,999.99"	// Valor
			_nCont++
			_nColuna += 55
			If _nCont > 4
				_nCont 	:= 1
				_nLin++
				_nColuna:= 0
			EndIf
		Next _nY
	EndIf
Else		// campo de valores
	@ _nLin,000 Psay "********"
	@ _nLin,025 Psay "******"
	@ _nLin,040 Psay "**************"
	@ _nLin,120 Psay "******"
	@ _nLin,158 Psay "********"
	_nLin+= 2
	@ _nLin,002 Psay Replicate("*",200)  // valor por extenso
	_nLin++
	@ _nLin,020 Psay Replicate("*",200)  // discriminacao das duplicatas
	
EndIf

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

_nLin	:= 52

// verifica se ira imprimir os valores, apenas se o ultimo formulario da nota fiscal.
If _lValor
	@ _nLin,025 Psay _nBasIcms 	Picture "@e 9,999,999.99"		// Base de calculo ICMS
	@ _nLin,070 Psay _nValIcms	Picture "@e 9,999,999.99"		// Valor do ICMS
	@ _nLin,120 Psay _nBsRetIcm	Picture "@e 9,999,999.99"		// Base ICMS Retido
	@ _nLin,165 Psay _nRetIcm	Picture "@e 9,999,999.99"		// Valor ICMS Retido
	
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
	//@ _nLin,042 Psay _cPedido									// Numero dos pedidos de vendas Alpax.
	@ _nLin,051 Psay _cPedCli									// Numero do pedido do cliente.
	@ _nLin,071 Psay _cBox										// Box
	_nLin++
	@ _nLin,002 Psay "Observacao:" + _cMens1
	_nLin++
	@ _nLin,002 Psay "           " + _cMens2
	_nLin++
	
	_cPeds := ""
	For _xY := 1 to Len(_aPedido)
		_cPeds += iif(_xY == 1,_aPedido[_xY],"/" + _aPedido[_xY])
	Next _xY
	@ _nLin,002 Psay "Nossos Pedidos:" + _cPeds
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
	_nLin+=14
EndIf
@ _nLin,097 Psay SF2->F2_DOC								// Nr. da Nota fiscal no canhoto
@ _nLin,212 Psay SF2->F2_DOC								// Nr. da Nota fiscal no canhoto
_nLin+=3

@ _nLin,000 Psay "."
SetPrc(00,00)
SetPgEject(.f.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfMensCorpoบAutor  ณOcimar              บ Data ณ  04/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para retornar as linhas de mensagens para o          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fMensCorpo()

Local _aRet      := {}
Local _nValPis   := 0
Local _nValCofin := 0
Local _nValIpi   := 0             // OCIMAR 17/09/08

// se houver desconto zona franca Pis e Cofins, discrimina os impostos no corpo da NF.
If SF2->F2_TIPO = 'I'                                      // OCIMAR nao sai endereco de entrega
	aAdd(_aRet," ")
Else
	If _nValDesZF > 0
		_nValMerc := _nValMerc + _nValDesZF   // Ocimar 30/10/06
		SA1->(DbSetOrder(1))
		SA1->(Dbseek(xfilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA))
		If SA1->A1_CODMUN == "00255" .And. SA1->A1_RECCOFI <> "S" .And. SA1->A1_RECPIS <> "S"
			_nValPis 	:= _nValMerc * (_nTxPis/100)
			_nValCofin	:= _nValMerc * (_nTxCofin/100)
			_nValIpi    := SF2->F2_VALIPI             // OCIMAR 17/09/08
			aAdd(_aRet,"Desconto Valor do Pis ..........R$." + Transform(_nValPis,"@e 999,999.99"))
			aAdd(_aRet,"Desconto Valor do Cofins .......R$." + Transform(_nValCofin,"@e 999,999.99"))
			If _nValIpi > 0
				aAdd(_aRet,"Desconto Valor do IPI ..........R$." + Transform(_nValIpi,"@e 999,999.99"))
			EndIf
		EndIf
		//    	aAdd(_aRet,"Desconto Valor do ICMS ...R$." + Transform(_nValDesZF,"@e 999,999.99"))
		If SA1->A1_INSCR <> "ISENTO"					// OCIMAR 17/09/08
			aAdd(_aRet,"Desconto Valor do ICMS ...R$." + Transform((_nValDesZF-_nValPis-_nValCofin),"@e 999,999.99"))
		Else
			_cMens1 := "ICMS Conf. RICMS - SP Lei 45.450/00 Art. 84 anexo I"
		EndIf											// OCIMAR 17/09/08
	EndIf
	aAdd(_aRet,"Endereco Entrega:"  + _cEndEntr)
EndIf

Return(_aRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR008   บAutor  ณMicrosiga           บ Data ณ  18/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica o numero de formularios e mostra uma mensagem em   บฑฑ
ฑฑบ          ณtela da quantidade.                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
// Verifica o numero de formularios e mostra uma mensagem em tela da quantidade.
Static Function _fNrForm()

Local _nNrNotas 	:= 0
Local _nNrNFSrv 	:= 0
Local _nNrNFProd	:= 0
Local _nNrNFSrv		:= 0
Local _cDoc			:= ""
Local _cQuery		:= ""
Local _nTemp		:= 0

// produtos fora da zona franca (TIPO sera 1)
_cQuery := "SELECT DISTINCT D2_DOC, F4_ISS, COUNT(D2_DOC)+1 AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "          ON F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "       WHERE D2_DOC BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' AND SUBSTRING(D2_CF,2,3) <> '110' "
_cQuery += "             AND D2.D_E_L_E_T_ = ' ' AND D2_SERIE = '" + MV_PAR03 + "' "
_cQuery += "             AND F4_ISS <> 'S' "
_cQuery += "GROUP BY D2_DOC, F4_ISS "
_cQuery += "UNION ALL "

// Produto com zona franca de manaus (TIPO sera 1)
_cQuery += "SELECT DISTINCT D2_DOC, F4_ISS, COUNT(D2_DOC)+4 AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "          ON F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "       WHERE D2_DOC BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' AND SUBSTRING(D2_CF,2,3) = '110' "
_cQuery += "             AND D2.D_E_L_E_T_ = ' ' AND D2_SERIE = '" + MV_PAR03 + "' "
_cQuery += "             AND F4_ISS <> 'S' "
_cQuery += "GROUP BY D2_DOC, F4_ISS "
_cQuery += "UNION ALL "

// Produtos de Servicos (TIPO sera 2)
_cQuery += "SELECT DISTINCT D2_DOC, F4_ISS, COUNT(D2_DOC) AS QUANT "
_cQuery += "       FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "          ON F4_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "       WHERE D2_DOC BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "             AND D2.D_E_L_E_T_ = ' ' AND D2_SERIE = '" + MV_PAR03 + "' "
_cQuery += "             AND F4_ISS = 'S' "
_cQuery += "GROUP BY D2_DOC, F4_ISS "

_cQuery += "ORDER BY D2_DOC "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","QUANT","N",12,2)

QR1->(DbGotop())

Do While ! QR1->(Eof())
	_cDoc := QR1->D2_DOC
	_nNrNFProd	:= 0
	_nNrNFSrv	:= 0
	Do While ! QR1->(Eof())	.And. QR1->D2_DOC == _cDoc
		// quantidade de Nota Fiscal de Produto
		If QR1->F4_ISS <> 'S'
			_nTemp		:= QR1->QUANT / _nLimiteIt
			_nNrNFProd	+= iif(_nTemp <> Int(_nTemp),int(_nTemp)+1,_nTemp)
		Else	// quantidade de Nota Fiscal de Servico
			_nTemp		:= QR1->QUANT / _nLimItSrv
			_nNrNFSrv	+= iif(_nTemp <> Int(_nTemp),int(_nTemp)+1,_nTemp)
		EndIf
		
		QR1->(DbSkip())
	EndDo
	// soma o nr de notas fiscais do tipo que for maior (Servico ou Produtos).
	_nNrNotas += iif(_nNrNFSrv > _nNrNFProd, _nNrNFSrv, _nNrNFProd)
EndDo

QR1->(DbCloseArea())

ApMsgInfo(cUserName + ", serao impressos " + alltrim(Str(_nNrNotas,6,0)) + " formularios !!! ")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGrupo   บAutor  ณMicrosiga           บ Data ณ  22/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fGrupo()

_cGrEmb := " "

Do Case
	
	Case SB1->B1_AXGREMB == "A"
		_cGgrEmb := "Grupo   I"
	Case SB1->B1_AXGREMB == "B"
		_cGgrEmb := "Grupo  II"
	Case SB1->B1_AXGREMB == "C"
		_cGgrEmb := "Grupo III"
	Case SB1->B1_AXGREMB == "D"
		_cGgrEmb := " "
EndCase

Return(_cGrEmb)
