/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR002   ºAutor  ³Adriano Luis Brandaoº Data ³  09/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao da Nota Fiscal de Saida.                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Rwmake.ch"

User Function FATR002()

Local cDesc1		:= "Este programa tem como objetivo imprimir Nota "
Local cDesc2   		:= "Fiscal de saida."
Local cDesc3        := ""
Local cPict         := ""
Local titulo       	:= "Imprime Nota Fiscal Saida"
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
Private nomeprog    := "FATR002"
Private nTipo		:= 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private wnrel      	:= "FATR002"
Private _nLin		:= 1
Private _nTxPis		:= GetMv("MV_TXPIS")
pRIVATE _nTxCofin	:= GetMv("MV_TXCOFIN")

Private cString := "SF2"

cPerg := "FATR02"
//
// Criacao das perguntas do relatorio.
//

_fCriaSx1()
//
// chamada das perguntas do relatorio.
//
Pergunte(cPerg,.t.)

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

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprime ºAutor  ³Adriano Luis Brandaoº Data ³  10/08/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para imprimir a nota fiscal de saida.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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

	_cEndEntr	:= ""
	_cBairEnt	:= ""
	_cMunEnt	:= ""
	_cEstEnt	:= ""
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
		
		_fImprCab()		// Impressao do cabecalho da nota fiscal
		
		_fImprDet()		// Impressao dos itens da nota fiscal
		
		_fImprRoda()	// Impressao do rodape da nota fiscal
		
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
//³MV_PAR02 = Ate Nota Fiscal                ³
//³MV_PAR03 = Serie                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

PutSx1(cPerg,"01","Da Nota Fiscal"        ,"Da Nota Fiscal"        ,"Da Nota Fiscal"          ,"mv_ch1","C",09,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Ate Nota Fiscal"       ,"Ate Nota Fiscal"       ,"Ate Nota Fiscal"         ,"mv_ch2","C",09,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Serie ?"               ,"Serie ?"               ,"Serie ?"                 ,"mv_ch3","C",03,0,0,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",,,)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCarItem ºAutor  ³Adriano Luis Brandaoº Data ³  09/08/04   º±±
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

LocaL _nUnit := 0


SF4->(DbSeek(xFilial("SF4")+SD2->D2_TES))
SB1->(DbSeek(xFilial("SB1")+SD2->D2_COD))

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
	aAdd(_aItens,Array(14))
	_nLinha := Len(_aItens)
	_cPedCli := Left(Posicione("SC5",1,xFilial("SC5")+SD2->D2_PEDIDO,"C5_AXPEDCL"),12)
	_aItens[_nLinha,01] := IIF(Empty(SB1->B1_PNUMBER),SD2->D2_COD,SB1->B1_PNUMBER)	// Codigo do produto
	_aItens[_nLinha,02]	:= Left(SB1->B1_DESC,44)+"-(PC."+_cPedCli+")" 				// Descricao do produto
	_aItens[_nLinha,03] := SD2->D2_LOTECTL											// Numero do lote.
	_aItens[_nlinha,04] := SB1->B1_POSIPI											// NCM
	_aItens[_nLinha,05] := "000"													// S.T.
	_aItens[_nLinha,06] := SD2->D2_UM												// Unidade de medida
	_aItens[_nLinha,07] := SD2->D2_QUANT											// Quantidade N.F.
	If SD2->D2_DESCZFR > 0 .And. SA1->A1_CODMUN == "00255"		// Desconto zona franca de manaus tem que ser somado no valor unitario e total do item.
		_aItens[_nLinha,08] := SD2->D2_PRCVEN + (SD2->D2_DESCZFR/SD2->D2_QUANT)		// Valor Unitario
		_aItens[_nLinha,09] := SD2->D2_TOTAL + SD2->D2_DESCZFR						// Valor Total Produto
		_nValDesZF+= SD2->D2_DESCZFR
	else
		_aItens[_nLinha,08] := SD2->D2_PRCVEN										// Valor Unitario
		_aItens[_nLinha,09] := SD2->D2_TOTAL										// Valor Total Produto
	EndIf
	_aItens[_nLinha,10] := SD2->D2_PICM												// Percentual Icms
	_aItens[_nLinha,11] := SD2->D2_IPI												// Percentual Ipi
	_aItens[_nLinha,12] := SD2->D2_VALIPI											// Valor do IPI
	_aItens[_nLinha,13] := SB1->B1_MARCA											// Marca
	_aItens[_nLinha,14] := SB1->B1_CAPACID											// Embalagem
	
EndIf
If ! Alltrim(SD2->D2_CF) $ _cCFO
	_cCFO 		+= iif(! Empty(_cCFO),"/","") + Alltrim(SD2->D2_CF)
	_cNatureza	+= iif(! Empty(_cNatureza),"/","") +;
	               Alltrim(SF4->F4_TEXTO)
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

If ! SF2->F2_TIPO $ "DB"
	
	SA1->(DbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA))
	
	_cRazao		:= SA1->A1_NOME
	_cCGC		:= SA1->A1_CGC
	_dEmissao 	:= SF2->F2_EMISSAO
	_cEndereco	:= SA1->A1_END
	_cBairro	:= SA1->A1_BAIRRO
	_cCEP		:= SA1->A1_CEP
	_cMun		:= SA1->A1_MUN
	_cFone		:= SA1->A1_TEL
	_cEst		:= SA1->A1_EST
	_cIE		:= SA1->A1_INSCR
	_nValIss	:= SF2->F2_VALISS
	_cBox		:= SF2->F2_AXBOX
	_cEndEntr	:= SA1->A1_ENDENT
	_cBairEnt	:= SA1->A1_BAIRROE
	_cMunEnt	:= SA1->A1_MUNE
	_cEstEnt	:= SA1->A1_ESTE
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
_nBasIcms	:= SF2->F2_BASEICM
_nValIcms	:= SF2->F2_VALICM
_nValMerc	:= (SF2->F2_VALMERC - _nValTotSr)+_nValDesZF
_nValFrete	:= SF2->F2_FRETE
_nValSegur	:= SF2->F2_SEGURO
_nValDesp	:= SF2->F2_DESPESA
_nValIPI	:= SF2->F2_VALIPI
_nValTotNF	:= SF2->F2_VALBRUT
//
// Transportadora
//
SC5->(DbSeek(xFilial("SC5")+SUBSTR(_cPedido,1,6)))
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
@ _nLin,161 Psay "X"
@ _nLin,207 Psay SF2->F2_DOC
_nLin	+= 5
@ _nLin,000 Psay _cNatureza
@ _nLin,119 Psay _cCFO
_nLin	+= 3
@ _nLin,000 Psay _cRazao
@ _nLin,170 Psay _cCGC  		Picture "@R 99.999.999/9999-99"
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
//
// Impressao de produtos
//
For _nY := 1 to Len(_aItens)
	@ _nLin,000 Psay _aItens[_nY,01]									// Codigo do Produto
	@ _nLin,020 Psay _aItens[_nY,02]									// Descricao do produto
	@ _nLin,083 Psay _aItens[_nY,03]									// Numero do lote
	@ _nLin,097 Psay _aItens[_nY,13]									// Marca
	@ _nLin,112 Psay _aItens[_nY,14]									// Embalagem
	@ _nLin,134 Psay _aItens[_nY,04]	Picture "@R 9999.99.99"			// NCM
	@ _nLin,150 Psay _aItens[_nY,05]									// S.T.
	@ _nLin,154 Psay _aItens[_nY,06]									// Unidade de medida
	@ _nLin,162 Psay _aItens[_nY,07]	Picture "@e 9999"				// Quantidade N.F.
	@ _nLin,171 Psay _aItens[_nY,08]	Picture "@e 999,999.99"			// Valor Unitário
	@ _nLin,188 Psay _aItens[_nY,09]	Picture "@e 999,999,999.99"     // Valor Total Produto
	@ _nLin,205 Psay _aItens[_nY,10]	Picture "@e 99"					// Percentual do ICMS
	@ _nLin,209 Psay _aItens[_nY,11]	Picture "@e 99.99"				// Percentual do IPI
	@ _nLin,215 Psay _aItens[_nY,12]	Picture "@e 999,999.99"			// Valor do IPI
	_nLin++
next _nY

// se houver desconto zona franca Pis e Cofins, discrimina os impostos no corpo da NF.                         
If _nValDesZF > 0
	_nValPis 	:= _nValMerc * (_nTxPis/100)
	_nValCofin	:= _nValMerc * (_nTxCofin/100)
	@ _nLin,020 Psay "Desconto Pis ..........R$." + Transform(_nValPis,"@e 999,999.99")
	_nLin++
	@ _nLin,020	Psay "Desconto Cofins .......R$." + Transform(_nValCofin,"@e 999,999.99")
	_nLin++
	@ _nLin,020	Psay "Valor Liquido da NF ...R$." + Transform((_nValMerc-_nValPis-_nValCofin),"@e 999,999.99")
	_nLin++
EndIf

If ! Empty(_cEndEntr)
	_nLin++
	@ _nLin,020 Psay "Endereco Entrega:"  + Alltrim(_cEndEntr) + " - " + Alltrim(_cBairEnt) + " - " +;
				Alltrim(_cMunEnt) + " - " + Alltrim(_cEstEnt)
	_nLin++
EndIf
//
// Impressao dos servicos
//           
_nLin	:= 47
            
For _nY := 1 to Len(_aItServ)
	@ _nLin,002 Psay _aItServ[_nY,001] Picture "@e 9999" 		// Quantidade
	@ _nLin,009 Psay _aItServ[_nY,002]					    	// Descricao do produto
	@ _nLin,087 Psay "R$."
	@ _nLin,090 Psay _aItServ[_nY,003] Picture "@e 999,999.99"	// Total servico
	if _nY == 1
		@ _nLin,208 Psay _nValIss		Picture "@e 9,999,999.99"
	EndIf
	if _nY == 4
		@ _nLin,208 Psay _nValTotSr	Picture "@e 9,999,999.99"
	EndIf
	_nLin++
next _nY

If Len(_aItServ) < 4
	@ _nLin,208 Psay _nValTotSr	Picture "@e 9,999,999.99"
EndIf

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
@ _nLin,172 Psay _cEstTr		
 					                                    	// U.F. Transportadora
@ _nLin,180 Psay _cIETr										// Inscricao Estadual Transportadora.
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
//@ _nLin,051 Psay _cPedCli									// Numero do pedido do cliente.
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

_nLin+=6
@ _nLin,095 Psay SF2->F2_DOC								// Nr. da Nota fiscal no canhoto
@ _nLin,212 Psay SF2->F2_DOC								// Nr. da Nota fiscal no canhoto
_nLin+=4
@ _nLin,000 Psay "."
SetPrc(00,00)
SetPgEject(.f.)
Return