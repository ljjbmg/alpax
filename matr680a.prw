//#INCLUDE "MATR680.CH"
#INCLUDE "PROTHEUS.CH"
#Include "Topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ MATR680	³ Autor ³ Alexandre Inacio Lemes³ Data ³ 15.03.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Pedidos nao entregues							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL. 					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³	MOTIVO DA ALTERACAO					  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Matr680a()

LOCAL titulo    := OemToAnsi("Relacao de Pedidos nao entregues")
LOCAL cDesc1    := OemToAnsi("Este programa ira emitir a relacao dos Pedidos Pendentes,")
LOCAL cDesc2    := OemToAnsi("imprimindo o numero do Pedido, Cliente, Data da Entrega, ")
LOCAL cDesc3    := OemToAnsi("Qtde pedida, Qtde ja entregue,Saldo do Produto e atraso.")
LOCAL cString   := "SC6"
LOCAL tamanho   := "G"
LOCAL wnrel     := "MATR680A"

PRIVATE aReturn := { "Zebrado", 1,"Administracao", 1, 2, 1, "", 1 }
PRIVATE nTamRef := Val(Substr(GetMv("MV_MASCGRD"),1,2))
PRIVATE nomeprog:= "MATR680A"
PRIVATE cPerg	 :=	IIf(cPaisLoc == "BRA","MTR680","MR680A")
PRIVATE cArqTrab:= ""
PRIVATE cFilTrab:= ""
PRIVATE nLastKey:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inclusao da nova opcao para considerar somente os pedidos com³
//³ eliminacao de residuo                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX1")
If MsSeek("MTR68013")
	If Empty(SX1->X1_DEF03)
		RecLock("SX1",.F.)
		SX1->X1_DEF03 := "Somente"
		MsUnlock()
	Endif
Endif

_fCriaSx1()

pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros		    			 ³
//³ mv_par01				// Do Pedido	                     ³
//³ mv_par02				// Ate o Pedido	                     ³
//³ mv_par03				// Do Produto				         ³
//³ mv_par04				// Ate o Produto					 ³
//³ mv_par05				// Do Cliente						 ³
//³ mv_par06				// Ate o cliente					 ³
//³ mv_par07				// Da data de entrega	    		 ³
//³ mv_par08				// Ate a data de entrega			 ³
//³ mv_par09				// Em Aberto , Todos 				 ³
//³ mv_par10				// C/Fatur.,S/Fatur.,Todos 			 ³
//³ mv_par11				// Mascara							 ³
//³ mv_par12				// Aglutina itens grade 			 ³
//³ mv_par13				// Considera Residuos (Sim/Nao)		 ³
//³ mv_par14				// Lista Tot.Faturados(Sim/Nao)		 ³
//³ mv_par15				// Salta pagina na Quebra(Sim/Nao)	     ³
//³ mv_par16				// Do vendedor                 		 ³
//³ mv_par17				// Ate o vendedor                    |
//³ mv_par18				// Qual a moeda                      |
//³ As proximas pertencem ao grupo MR680A que eh so para         |
//³ Localizacoes...                                     	     ³
//³ mv_par18				// Movimenta stock    (Sim/Nao)	     ³
//³ mv_par19		 // Gen. Doc (Factura/Remito/Ent. Fut/Todos) ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT 					     ³
//| aOrd = Ordems Por Pedido/Produto/Cliente/Dt.Entrega/Vendedor |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aOrd :={"Ordems Por Pedido","Produto","Cliente","Dt.Entrega","Vendedor"}
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey==27
	dbClearFilter()
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey==27
	dbClearFilter()
	Return
Endif

RptStatus({|lEnd| C680Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ C680IMP	³ Autor ³ Alexandre Incaio Lemes³ Data ³ 15.03.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio 									  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATR680													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function C680Imp(lEnd,WnRel,cString)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis   										     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL titulo    := OemToAnsi("Relacao de Pedidos nao entregues")
LOCAL dData     := CtoD("  /  /  ")
LOCAL cTotPed   := "NUM = cNum"
LOCAL CbTxt     := ""
LOCAL cabec1    := ""
LOCAL cabec2    := ""
LOCAL tamanho   := "G"
LOCAL cNumPed   := ""
LOCAL cNumCli   := ""
LOCAL limite    := 220
LOCAL CbCont    := 0
LOCAL nOrdem    := 0
LOCAL nTotVen   := 0
LOCAL nTotEnt   := 0
LOCAL nTotSal   := 0
LOCAL nTotItem  := 0
LOCAL nFirst    := 0
LOCAL nSaldo    := 0
LOCAL nValor    := 0
LOCAL nCont     := 0
LOCAL lImpTot   := .F.
LOCAL lContinua := .T.
LOCAL nMoeda    := IIF(cPaisLoc == "BRA",MV_PAR18,1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cbtxt   := SPACE(10)
cbcont  := 0
m_pag   := 1
li 	    := 80

nTipo   := IIF(aReturn[4]==1,15,18)
nOrdem  := aReturn[8]

Processa({|lEnd| C680Trb(@lEnd,wnRel,"TRB")},Titulo)

//                   999999 99/99/9999 999999xxxxxxxxxxxxxx/XXXXXXXX XX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX 99/99/9999 999999999999 999999999999 999999999999
//                             1         2         3         4         5         6         7         8         9        10        11        12        13
//                   012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
SD2->(DbSetOrder(8))
dbSelectArea("TRB")

Do Case
	Case nOrdem = 1
		cQuebra := "NUM = cNum"
		titulo  := titulo +" - "+ "Por Pedido"
		cabec1  := "NUMERO  DATA DE   CODIGO LOJA /NOME DO CLIENTE                       IT CODIGO DO       DESCRICAO DO                    DATA DE        QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL  PARTNUMBER   EST      PEDIDO"
		cabec2  := "PEDIDO  EMISSAO                                                         PRODUTO         MATERIAL                        ENTREGA        PEDIDA       ENTREGUE     PENDENTE        SALDO ITEM                         CLIENTE"
	Case nOrdem = 2
		cQuebra := "PRODUTO = cProduto"
		titulo  := titulo + " - "+"Por Produto"
		cabec1  := "CODIGO DO       DESCRICAO DO                   NUMERO IT DATA DE      DATA DE      CODIGO LOJA /NOME DO CLIENTE                        QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL  PARTNUMBER   EST      PEDIDO"
		cabec2  := "PRODUTO         MATERIAL                       PEDIDO    EMISSAO      ENTREGA                                                          PEDIDA       ENTREGUE     PENDENTE        SALDO ITEM                         CLIENTE"
	Case nOrdem = 3
		cQuebra := "CLIENTE+LOJA = cCli"
		titulo  := titulo + " - "+"Por Cliente"
		cabec1  := "CODIGO-LOJA/NOME DO CLIENTE                        NUMERO IT  DATA DE      CODIGO DO       DESCRICAO DO                   DATA DE      QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL  PARTNUMBER   EST      PEDIDO"
		cabec2  := "                                                   PEDIDO     EMISSAO      PRODUTO         MATERIAL                       ENTREGA      PEDIDA       ENTREGUE     PENDENTE        SALDO ITEM                         CLIENTE"
	Case nOrdem = 4
		cQuebra := "DATENTR = dEntreg"
		titulo  := titulo + " - Por Data de Entrega"
		cabec1  := " DATA DE      NUMERO DATA DE      CODIGO LOJA /NOME DO CLIENTE                       IT CODIGO DO       DESCRICAO DO                   QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL  PARTNUMBER   EST      PEDIDO"
		cabec2  := " ENTREGA      PEDIDO EMISSAO                                                            PRODUTO         MATERIAL                       PEDIDA       ENTREGUE     PENDENTE        SALDO ITEM                         CLIENTE"
		
	Case nOrdem = 5
		cQuebra := "VENDEDOR = cVde"
		titulo  := titulo + " - Por Vendedor"
		cabec1  := "CODIGO VENDEDOR                                 NUMERO IT  DATA DE      CODIGO DO       DESCRICAO DO                   DATA DE         QUANTIDADE   QUANTIDADE   QUANTIDADE      VALOR TOTAL  PARTNUMBER   EST      PEDIDO"
		cabec2  := "                                                PEDIDO     EMISSAO      PRODUTO         MATERIAL                       ENTREGA         PEDIDA       ENTREGUE     PENDENTE        SALDO ITEM                         CLIENTE"
EndCase

titulo += " - " + GetMv("MV_MOEDA"+STR(nMoeda,1))		//" MOEDA "
dbSelectArea("TRB")
dbGoTop()
SetRegua(RecCount())                    	// TOTAL DE ELEMENTOS DA REGUA

nFirst := 0
_nTotGeral := 0

While !Eof() .And. lContinua
	
	IF lEnd
		@PROW()+1,001 Psay "CANCELADO PELO OPERADOR"
		Exit
	Endif
	
	IF li > 57 .Or.( MV_PAR15 = 1 .And.!&cQuebra)
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	EndIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica campo para quebra									 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cNum	:= NUM
	cProduto:= PRODUTO
	cCli	:= CLIENTE+LOJA
	dEntreg := DATENTR
	cVde    := VENDEDOR
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis Totalizadoras     		    					 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nSaldo  := QUANTIDADE-ENTREGUE
	nTotSal += nSaldo
	nTotVen += QUANTIDADE
	nTotEnt += ENTREGUE
	nValor  := xMoeda(VALOR,MOEDA,nMoeda,EMISSAO)
	
	If !(TRB->GRADE == "S" .And. MV_PAR12 == 1)
		nTotItem+= nValor
	EndIf
	
	If nTotVen > QUANTIDADE .Or. nTotEnt > ENTREGUE
		lImpTot := .T.
	Else
		lImpTot := .F.
	EndIf
	
	IF (nFirst = 0 .And. nOrdem != 4).Or. nOrdem == 4
		
		li++
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime o cabecalho da linha		    					 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Do Case
			Case nOrdem = 1
				@li,  0 Psay NUM
				@li,  7 Psay TRB->EMISSAO
				@li, 18 Psay Left(CLIENTE+"-"+LOJA+"/"+TRB->NOMECLI, 50)
			Case nOrdem = 2
				@li,  0 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamref),PRODUTO)
				@li, 16 Psay Left(TRB->DESCRICAO, 30)
			Case nOrdem = 3
				@li,  0 Psay Left(CLIENTE+"-"+LOJA+"/"+NOMECLI, 50)
			Case nOrdem = 4
				If cNumPed+cNumCli+DtoS(dData) != NUM+CLIENTE+DtoS(DATENTR)
					@li,  1 Psay DATENTR
					@li, 14 Psay NUM
					@li, 21 Psay EMISSAO
					@li, 34 Psay Left(CLIENTE+"-"+LOJA+"/"+NOMECLI, 50)
					cNumPed := NUM
					cNumCli := CLIENTE
				Else
					li--
				EndIf
				dData := DATENTR
			Case nOrdem = 5
				@li,  0 Psay Left(TRB->VENDEDOR+" "+NOMEVEN, 47)
		EndCase
		
		IF nFirst = 0 .And. nOrdem != 4
			nFirst := 1
		Endif
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Agrutina os produtos da grade conforme o parametro MV_PAR12  |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF TRB->GRADE == "S" .And. MV_PAR12 == 1
		
		cProdRef:= Substr(TRB->PRODUTO,1,nTamRef)
		
		If nOrdem = 2
			cAgrutina := "cProdRef == Substr(PRODUTO,1,nTamRef)"
		Else
			cAgrutina := cQuebra
		Endif
		
		nSaldo  := 0
		nTotVen := 0
		nTotEnt := 0
		nTotSal := 0
		nValor  := 0
		nReg    := 0
		
		While !Eof() .And.xFilial("SC6") == TRB->FILIAL .And. cProdRef == Substr(PRODUTO,1,nTamRef);
			.And. TRB->GRADE == "S" .And. &cAgrutina
			
			nReg	 := Recno()
			
			nTotVen += QUANTIDADE
			nTotEnt += ENTREGUE
			nSaldo  += QUANTIDADE-ENTREGUE
			nValor  += xMoeda(VALOR,MOEDA,nMoeda,EMISSAO)
			
			dbSelectArea("TRB")
			IncRegua()
			dbSkip()
			
			lImpTot := .T.
			
		End
		
		nTotSal += nSaldo
		nTotItem+= nValor
		If nReg > 0
			dbGoto(nReg)
			nReg :=0
		Endif
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a linha Conforme a ordem selecionada na setprint	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case nOrdem = 1
			@li, 69 Psay ITEM
			@li, 72 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamref),PRODUTO)
			@li, 88 Psay Left(TRB->DESCRICAO, 30)
			@li,119 Psay DATENTR
		Case nOrdem = 2
			@li, 47 Psay NUM
			@li, 54 Psay ITEM
			@li, 57 Psay EMISSAO
			@li, 70 Psay DATENTR
			@li, 83 Psay Left(TRB->CLIENTE+"-"+LOJA+"/"+TRB->NOMECLI,50)
		Case nOrdem = 3
			@li, 51 Psay NUM
			@li, 58 Psay ITEM
			@li, 61 Psay EMISSAO
			@li, 74 Psay IIF(GRADE == "S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamref),PRODUTO)
			@li, 91 Psay Left(TRB->DESCRICAO,30)
			@li,122 Psay DATENTR
		Case nOrdem = 4
			@li, 85 Psay ITEM
			@li, 88 Psay IIF(GRADE == "S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamRef),PRODUTO)
			@li,104 Psay Left(TRB->DESCRICAO, 30)
		OtherWise
			@li, 48 Psay NUM
			@li, 55 Psay ITEM
			@li, 59 Psay EMISSAO
			@li, 72 Psay IIF(GRADE == "S" .And. MV_PAR12 == 1,Substr(PRODUTO,1,nTamref),PRODUTO)
			@li, 88 Psay Left(TRB->DESCRICAO,30)
			@li,119 Psay DATENTR
	EndCase
	
	@li,136 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,nTotVen,QUANTIDADE)	PICTURE PesqPictQt("C6_QTDVEN",12)
	@li,149 Psay IIF(GRADE=="S" .And. MV_PAR12 == 1,nTotEnt,ENTREGUE)	PICTURE PesqPictQt("C6_QTDENT",12)
	@li,162 Psay nSaldo	PICTURE PesqPictQt("C6_QTDVEN",12)
	@li,176 Psay nValor	PICTURE PesqPict("SC6","C6_VALOR",10)
	@li,190 Psay PNUMBER
	@li,205 Psay ESTOQ	
	@li,212 Psay PEDCLI
	
	nCont++
	li++
	If nOrdem == 3
		IF li > 57
			cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		EndIF
		
		@ li,091 Psay TRB->DESCRI2
		@ li,pcol()+1 Psay "Marca:" + TRB->MARCA
		@ li,pcol()+2 Psay "Capacidade:" + TRB->CAPACID
		li++
		SD2->(DbSeek(xFilial("SD2")+TRB->NUM+TRB->ITEM))
		Do While ! SD2->(Eof()) .And. xFilial("SD2") == SD2->D2_FILIAL .And. (SD2->D2_PEDIDO+SD2->D2_ITEMPV) ==;
			(TRB->NUM+TRB->ITEM)
			If (SD2->D2_QUANT - SD2->D2_QTDEDEV) > 0
				IF li > 57
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				EndIF
				
				@ li,091 Psay "NF." + SD2->D2_DOC
				@ li,pcol()+2 Psay "Data Emissao:" + Dtoc(SD2->D2_EMISSAO)
				@ li,149 Psay Transform(SD2->D2_QUANT - SD2->D2_QTDEDEV,PesqPictQt("C6_QTDVEN",12))
				li++
			EndIf
			
			SD2->(DbSkip())
		EndDo
		
		
	EndIf
	
	dbSelectArea("TRB")
	IncRegua()
	dbSkip()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Total do Pedido                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !&cTotPed
		If nOrdem = 1 .Or. nOrdem = 3 .Or.  nOrdem = 4
			@Li,000 Psay "TOTAL ---->"
			@Li,171 Psay nTotItem PICTURE PesqPict("SC6","C6_VALOR",15)
			_nTotGeral += nTotItem
			If nOrdem = 3
				li+=2
			Else
				li++
			ENdif
			nTotitem:= 0
		EndIf
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime o Total ou linha divisora conforme a quebra		     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !&cQuebra
		
		If (MV_PAR15 = 1 .And. nOrdem = 2) .Or. MV_PAR15 = 2
			
			If nOrdem = 2
				@Li,000 Psay "TOTAL ---->"
				@Li,136 Psay nTotVen PICTURE PesqPictQt("C6_QTDVEN",12)
				@Li,149 Psay nTotEnt PICTURE PesqPictQt("C6_QTDENT",12)
				@Li,162 Psay nTotSal PICTURE PesqPictQt("C6_QTDVEN",12)
				li++
			Endif
			
			If nTotVen > 0 .And. nOrdem != 1
				@li,  0 Psay __PrtThinLine()
				li++
			Endif
			
		Endif
		
		nTotVen := 0
		nTotEnt := 0
		nTotSal := 0
		nCont   := 0
		nFirst  := 0
		
	Endif
	
End

If _nTotGeral > 0
	@ li,000 Psay __PrtFatLine()
	li++
	@ li,000 Psay "T O T A L  G E R A L -------------> "
	@ li,172 Psay _nTotGeral	Picture "@e 999,999,999.99"
	li++
	@ li,000 Psay __PrtFatLine()
	li++	
Endif

If li != 80
	Roda(cbcont,cbtxt)
Endif

dbSelectArea("TRB")
dbCloseArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Deleta arquivos de trabalho.                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Ferase(cArqTrab+GetDBExtension())
Ferase(cArqTrab+OrdBagExt())
Ferase(cFilTrab+OrdBagExt())

If aReturn[5] = 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ C680TRB	³ Autor ³ Alexandre Inacio Lemes³ Data ³ 15.03.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria Arquivo de Trabalho                             	  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ MATR660													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function C680TRB(nOrdem)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL aCampos   := {}
LOCAL aTam      := ""
LOCAL cKey      := ""
LOCAL cCondicao := ""
LOCAL cVend     := ""
LOCAL cVendedor := ""
LOCAL cAliasSC6 := "SC6"
LOCAL cPedIni   := MV_PAR01
LOCAL cPedFim   := MV_PAR02
LOCAL cProIni   := MV_PAR03
LOCAL cProFim   := MV_PAR04
LOCAL cCliIni   := MV_PAR05
LOCAL cCliFim   := MV_PAR06
LOCAL cDatIni   := MV_PAR07
LOCAL cDatFim   := MV_PAR08
LOCAL nSaldo    := 0
LOCAL nX        := 0
LOCAL nQtdVend  := FA440CntVen() // Retorna a quantidade maxima de Vendedores

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define array para arquivo de trabalho                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("C6_FILIAL")
AADD(aCampos,{ "FILIAL"    ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_NUM")
AADD(aCampos,{ "NUM"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_EMISSAO")
AADD(aCampos,{ "EMISSAO"   ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_CLI")
AADD(aCampos,{ "CLIENTE"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "NOMECLI"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_LOJA")
AADD(aCampos,{ "LOJA"      ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_VEND1")
AADD(aCampos,{ "VENDEDOR"  ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A3_NOME")
AADD(aCampos,{ "NOMEVEN"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ENTREG")
AADD(aCampos,{ "DATENTR"   ,"D",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ITEM")
AADD(aCampos,{ "ITEM"      ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_PRODUTO")
AADD(aCampos,{ "PRODUTO"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_DESCRI")
AADD(aCampos,{ "DESCRICAO" ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_QTDVEN")
AADD(aCampos,{ "QUANTIDADE","N",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_QTDENT")
AADD(aCampos,{ "ENTREGUE"  ,"N",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_GRADE")
AADD(aCampos,{ "GRADE"     ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_ITEMGRD")
AADD(aCampos,{ "ITEMGRD"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_TES")
AADD(aCampos,{ "TES"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_BLQ")
AADD(aCampos,{ "BLQ"       ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_BLOQUEI")
AADD(aCampos,{ "BLOQUEI"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("C6_VALOR")
AADD(aCampos,{ "VALOR"   ,"N",aTam[1],aTam[2] } )
aTam:=TamSX3("C5_MOEDA")
AADD(aCampos,{ "MOEDA"   ,"N",aTam[1],aTam[2] } )
AADD(aCampos,{"PNUMBER"	 	,"C",20,0})
AADD(aCampos,{"PEDCLI"		,"C",9,0})
AADD(aCampos,{"MARCA"		,"C",15,0})
AADD(aCampos,{"CAPACID"		,"C",15,0})
AADD(aCampos,{"DESCRI2"		,"C",40,0})
AADD(aCampos,{"ESTOQ"		,"N",09,0})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de Trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArqTrab := CriaTrab(aCampos,.T.)
dbUseArea(.T.,,cArqTrab,"TRB",.T.,.F.)

nOrdem  := aReturn[8]

dbSelectArea("TRB")
Do Case
	Case nOrdem = 1
		IndRegua("TRB",cArqTrab,"FILIAL+NUM+ITEM+PRODUTO",,,"Selecionando Registros...")
	Case nOrdem = 2
		IndRegua("TRB",cArqTrab,"FILIAL+PRODUTO+NUM+ITEM",,,"Selecionando Registros...")
	Case nOrdem = 3
		IndRegua("TRB",cArqTrab,"FILIAL+CLIENTE+LOJA+NUM+ITEM",,,"Selecionando Registros...")
	Case nOrdem = 4
		IndRegua("TRB",cArqTrab,"FILIAL+DTOS(DATENTR)+NUM+ITEM",,,"Selecionando Registros...")
	Case nOrdem = 5
		IndRegua("TRB",cArqTrab,"FILIAL+VENDEDOR+NUM+ITEM",,,"Selecionando Registros...")
EndCase

dbSelectArea("TRB")
dbSetOrder(1)
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o Filtro                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC6")
dbSetOrder(1)

#IFDEF TOP
	
	cAliasSC6 := "MR680Trab"
	aStruSC6  := SC6->(dbStruct())
	/*
	cQuery    := "SELECT * "
	cQuery += "FROM "+RetSqlName("SC6")+" "
	cQuery += "WHERE C6_FILIAL = '"+xFilial("SC6")+"' AND "
	cQuery += "C6_NUM >= '"+cPedIni+"' AND "
	cQuery += "C6_NUM <= '"+cPedFim+"' AND "
	cQuery += "C6_PRODUTO >= '"+cProIni+"' AND "
	cQuery += "C6_PRODUTO <= '"+cProFim+"' AND "
	cQuery += "C6_CLI >= '"+cCliIni+"' AND "
	cQuery += "C6_CLI <= '"+cCliFim+"' AND "
	cQuery += "C6_ENTREG >= '"+Dtos(cDatIni)+"' AND "
	cQuery += "C6_ENTREG <= '"+Dtos(cDatFim)+"' AND  "
	*/
	cQuery    := "SELECT C6.*, B2_QATU "
	cQuery += "FROM "+RetSqlName("SC6")+" C6," + RetSqlName("SC5") + " C5, " + RetSqlName("SB2") + " B2 "
	cQuery += "WHERE C6_FILIAL = '"+xFilial("SC6")+"' AND "
	cQuery += "C6_NUM >= '"+cPedIni+"' AND "
	cQuery += "C6_NUM <= '"+cPedFim+"' AND "
	cQuery += "C6_PRODUTO >= '"+cProIni+"' AND "
	cQuery += "C6_PRODUTO <= '"+cProFim+"' AND "
	cQuery += "C6_CLI >= '"+cCliIni+"' AND "
	cQuery += "C6_CLI <= '"+cCliFim+"' AND "
	cQuery += "C6_ENTREG >= '"+Dtos(cDatIni)+"' AND "
	cQuery += "C6_ENTREG <= '"+Dtos(cDatFim)+"' AND  "
	cQuery += "C6_NUM = C5_NUM AND "
	cQuery += "C6_PRODUTO = B2_COD AND B2_LOCAL = '01' AND "	
//	cQuery += "C5_FILIAL = '" + xFilial("SC5") + "' AND C6_FILIAL = '" + xFilial("SC6") + "' AND "
	
	
	If mv_par13 == 3
		cQuery += "C6_BLQ = 'R ' AND "
	Endif
	
	cQuery += "C6.D_E_L_E_T_ = ' ' AND C5.D_E_L_E_T_ = ' ' AND "
	cQuery += "C5_AXATEN1 BETWEEN '" + MV_PAR20 + "' AND '" + MV_PAR21 + "' "
	cQuery += "ORDER BY "+SqlOrder(IndexKey())
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSC6,.T.,.T.)
	
	For nX := 1 To Len(aStruSC6)
		If ( aStruSC6[nX][2] <> "C" )
			TcSetField(cAliasSC6,aStruSC6[nX][1],aStruSC6[nX][2],aStruSC6[nX][3],aStruSC6[nX][4])
		EndIf
	Next nX
	
	dbSelectArea(cAliasSC6)
	
#ELSE
	
	cFilTrab   := CriaTrab("",.F.)
	cCondicao  := "C6_FILIAL=='"+xFilial("SC6")+"'.And."
	cCondicao  += "C6_NUM>='"+MV_PAR01+"'.And.C6_NUM<='"+MV_PAR02+"'.And."
	cCondicao  += "C6_PRODUTO>='"+MV_PAR03+"'.And.C6_PRODUTO<='"+MV_PAR04+"'.And."
	cCondicao  += "C6_CLI>='"+MV_PAR05+"'.And.C6_CLI<='"+MV_PAR06+"'.And."
	cCondicao  += "Dtos(C6_ENTREG)>='"+Dtos(MV_PAR07)+"'.And.Dtos(C6_ENTREG)<='"+Dtos(MV_PAR08)+"'"
	If mv_par13 == 3
		cCondicao += " .And. C6_BLQ == 'R ' "
	Endif
	
	dbSelectArea("SC6")
	dbSetOrder(1)
	IndRegua("SC6",cFilTrab,IndexKey(),,cCondicao,"Selecionando Registros...")
	dbGoTop()
	
#ENDIF

ProcRegua(RecCount())                                         // Total de Elementos da Regua

While !Eof() .And. (cAliasSC6)->C6_FILIAL == xFilial("SC6")
	
	If ( Empty(aReturn[7]) .Or. &(aReturn[7]) )
		
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek( xFilial()+ (cAliasSC6)->C6_CLI + (cAliasSC6)->C6_LOJA )
		
		dbSelectArea("SF4")
		dbSetOrder(1)
		dbSeek( xFilial(("SF4"))+(cAliasSC6)->C6_TES )
		
		dbSelectArea("SC5")
		dbSetOrder(1)
		dbSeek( xFilial(("SC5"))+(cAliasSC6)->C6_NUM )
		
		dbSelectArea(cAliasSC6)
		
		If cPaisLoc <> "BRA"
			If ( SF4->F4_ESTOQUE == "S" .And. mv_par18 == 2 ) .Or. ( SF4->F4_ESTOQUE!= "S" .And. mv_par18 == 1 )
				dbSkip()
				Loop
			Endif
			If mv_par19 <> 4 .And. SC5->(FIELDPOS("C5_DOCGER")) > 0
				If (mv_par19 == 1 .And. SC5->C5_DOCGER <> '1' ) .Or.;//Gera nota
					(mv_par19 == 2 .And. SC5->C5_DOCGER <> '2' ) .Or.;//Gera REMITO
					(mv_par19 == 3 .And. SC5->C5_DOCGER <> '3' ) //Entrega futura
					dbSkip()
					Loop
				Endif
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se esta dentro dos parametros						 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lRet:=ValidMasc((cAliasSC6)->C6_PRODUTO,MV_PAR11)
		
		If Alltrim((cAliasSC6)->C6_BLQ) == "R" .and. mv_par13 == 2 // Se Foi Eliminado Residuos
			nSaldo  := 0
		Else
			nSaldo  := C6_QTDVEN-C6_QTDENT
		Endif
		
		If ((C6_QTDENT < C6_QTDVEN .And. MV_PAR09 == 1) .Or. (MV_PAR09 == 2)).And.;
			((nSaldo == 0 .And. MV_PAR14 == 1.And.Alltrim((cAliasSC6)->C6_BLQ)<>"R").Or. nSaldo <> 0).And.;
			((SF4->F4_DUPLIC == "S" .And. MV_PAR10 == 1) .Or. (SF4->F4_DUPLIC == "N";
			.And. MV_PAR10 == 2).Or.(MV_PAR10 == 3));
			.And. At(SC5->C5_TIPO,"DB") = 0 .And.lRet
			
			If nOrdem = 5
				
				cVend := "1"
				
				For nX := 1 to nQtdVend
					
					cVendedor := SC5->(FieldGet(FieldPos("C5_VEND"+cVend)))
					
					If !EMPTY(cVendedor) .And. (cVendedor >= MV_PAR16 .And. cVendedor <= MV_PAR17 )
						
						dbSelectArea("SA3")
						dbSetOrder(1)
						dbSeek( xFilial()+cVendedor)
						
						SB1->(DbSeek(xFilial("SB1")+(cAliasSC6)->C6_PRODUTO))
                        nEst := POSICIONE("SB2",1,XFILIAL("SB2")+(cAliasSC6)->C6_PRODUTO+"01","B2_QATU")						
						
						dbSelectArea("TRB")
						RecLock("TRB",.T.)
						
						REPLACE VENDEDOR   	WITH cVendedor
						REPLACE NOMEVEN    	WITH SA3->A3_NOME
						REPLACE FILIAL     	WITH (cAliasSC6)->C6_FILIAL
						REPLACE NUM        	WITH (cAliasSC6)->C6_NUM
						REPLACE EMISSAO    	WITH SC5->C5_EMISSAO
						REPLACE CLIENTE    	WITH (cAliasSC6)->C6_CLI
						REPLACE NOMECLI    	WITH SA1->A1_NOME
						REPLACE LOJA       	WITH (cAliasSC6)->C6_LOJA
						REPLACE DATENTR    	WITH (cAliasSC6)->C6_ENTREG
						REPLACE ITEM       	WITH (cAliasSC6)->C6_ITEM
						REPLACE PRODUTO    	WITH (cAliasSC6)->C6_PRODUTO
						REPLACE DESCRICAO  	WITH (cAliasSC6)->C6_DESCRI
						REPLACE QUANTIDADE 	WITH (cAliasSC6)->C6_QTDVEN
						REPLACE ENTREGUE   	WITH (cAliasSC6)->C6_QTDENT
						REPLACE GRADE      	WITH (cAliasSC6)->C6_GRADE
						REPLACE ITEMGRD    	WITH (cAliasSC6)->C6_ITEMGRD
						REPLACE TES        	WITH (cAliasSC6)->C6_TES
						REPLACE BLQ        	WITH (cAliasSC6)->C6_BLQ
						REPLACE BLOQUEI    	WITH (cAliasSC6)->C6_BLOQUEI
//						REPLACE VALOR      	WITH (cAliasSC6)->C6_VALOR
						REPLACE VALOR		WITH (cAliasSC6)->C6_PRCVEN * ((cAliasSC6)->C6_QTDVEN - (cAliasSC6)->C6_QTDENT)
						REPLACE MOEDA      	WITH SC5->C5_MOEDA
						REPLACE PNUMBER	   	WITH SB1->B1_PNUMBER
						REPLACE PEDCLI     	WITH iif(Empty((cAliasSC6)->C6_PEDCLI),SC5->C5_AXPEDCL,(cAliasSC6)->C6_PEDCLI)
						REPLACE DESCRI2	   	WITH SUBSTR((cAliasSC6)->C6_DESCRI,31,40)
						REPLACE CAPACID		WITH SB1->B1_CAPACID
						REPLACE MARCA		WITH SB1->B1_MARCA 
						REPLACE ESTOQ       WITH nEst
						
						MsUnLock()
						
					Endif
					
					cVend := Soma1(cVend,1)
					
					dbSelectArea("SC5")
					dbSetOrder(1)
					
				Next nX
				
			Else
				
				lVend := .F.
				cVend := "1"
				
				For nX := 1 to nQtdVend
					cVendedor := SC5->(FieldGet(FieldPos("C5_VEND"+cVend)))
					If (cVendedor >= MV_PAR16 .And. cVendedor <= MV_PAR17 )
						lVend :=.T.
						Exit
					Endif
					cVend := Soma1(cVend,1)
				Next nX
				
				If lVend
					
					SB1->(DbSeek(xFilial("SB1")+(cAliasSC6)->C6_PRODUTO))
                    nEst := POSICIONE("SB2",1,XFILIAL("SB2")+(cAliasSC6)->C6_PRODUTO+"01","B2_QATU")					
					
					dbSelectArea("TRB")
					RecLock("TRB",.T.)
					
					REPLACE FILIAL     	WITH (cAliasSC6)->C6_FILIAL
					REPLACE NUM        	WITH (cAliasSC6)->C6_NUM
					REPLACE EMISSAO    	WITH SC5->C5_EMISSAO
					REPLACE CLIENTE    	WITH (cAliasSC6)->C6_CLI
					REPLACE NOMECLI    	WITH SA1->A1_NOME
					REPLACE LOJA       	WITH (cAliasSC6)->C6_LOJA
					REPLACE DATENTR    	WITH (cAliasSC6)->C6_ENTREG
					REPLACE ITEM       	WITH (cAliasSC6)->C6_ITEM
					REPLACE PRODUTO    	WITH (cAliasSC6)->C6_PRODUTO
					REPLACE DESCRICAO  	WITH (cAliasSC6)->C6_DESCRI
					REPLACE QUANTIDADE 	WITH (cAliasSC6)->C6_QTDVEN
					REPLACE ENTREGUE   	WITH (cAliasSC6)->C6_QTDENT
					REPLACE GRADE      	WITH (cAliasSC6)->C6_GRADE
					REPLACE ITEMGRD    	WITH (cAliasSC6)->C6_ITEMGRD
					REPLACE TES        	WITH (cAliasSC6)->C6_TES
					REPLACE BLQ        	WITH (cAliasSC6)->C6_BLQ
					REPLACE BLOQUEI    	WITH (cAliasSC6)->C6_BLOQUEI
//					REPLACE VALOR      	WITH (cAliasSC6)->C6_VALOR
					REPLACE VALOR		WITH (cAliasSC6)->C6_PRCVEN * ((cAliasSC6)->C6_QTDVEN - (cAliasSC6)->C6_QTDENT)
					REPLACE MOEDA      	WITH SC5->C5_MOEDA
					REPLACE PNUMBER	   	WITH SB1->B1_PNUMBER
					REPLACE PEDCLI     	WITH iif(Empty((cAliasSC6)->C6_PEDCLI),SC5->C5_AXPEDCL,(cAliasSC6)->C6_PEDCLI)
					REPLACE DESCRI2	   	WITH SUBSTR((cAliasSC6)->C6_DESCRI,31,40)
					REPLACE CAPACID		WITH SB1->B1_CAPACID
					REPLACE MARCA		WITH SB1->B1_MARCA
					REPLACE ESTOQ       WITH nEst
					
					lVend := .F.
					
					MsUnLock()
					
				Endif
				
			Endif
			
		Endif
		
	Endif
	
	dbSelectArea(cAliasSC6)
	IncProc()
	dbSkip()
	
End

#IFDEF TOP
	dbSelectArea(cAliasSC6)
	dbClosearea()
	dbSelectArea("SC6")
#ELSE
	dbSelectArea("SC6")
	RetIndex("SC6")
#ENDIF

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MATR680A  ºAutor  ³Microsiga           º Data ³  06/04/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Criacao de perguntas adicionais                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fCriaSx1()

PutSx1(cPerg,"20","Do Atendente ?"  ,"Do Atendente ?"  ,"Do Atendente ?"  ,"mv_chj","C",06,0,0,"G","","USR","","","mv_par20","","","","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"21","Ate Atendente ?" ,"Ate Atendente ?" ,"Ate Atendente ?" ,"mv_chk","C",06,0,0,"G","","USR","","","mv_par21","","","","","","","","","","","","","","","","","","",""	)

Return
