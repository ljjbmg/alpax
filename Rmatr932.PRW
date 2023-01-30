#INCLUDE "Protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Matr932      ³Autor³ Juan Jose Pereira    ³ Data ³ 06.01.97   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime Registro de Entradas P1A e Saidas P2A                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Marcos Simidu³26/11/97³XXXXXX³Impressao de itens com Tes do livro ='Z'  ³±±
±±³ Marcos Simidu³27/11/97³13677A³Correcao de salto de pagina.              ³±±
±±³ Marcos Simidu³23/12/97³13855A³Correcao nas totalizacoes mes/periodos.   ³±±
±±³ Marcos Simidu³11/02/98³XXXXXX³Compatibilizacao com Emissor Cupom Fiscal ³±±
±±³ Marcos Simidu³24/03/98³14621A³Inclusao parametro Totaliza por dia.      ³±±
±±³ Rodrigo Sart.³25/03/98³10385A³Alteracao do parametro mv_par04  Lista:   ³±±
±±³              ³        ³      ³(1)Livros (2)Termos (3)Livros e Termos    ³±±
±±³ Rodrigo Sart.³27/03/98³14810A³ Tratamento do estado origem no Resumo    ³±±
±±³              ³        ³14810A³ variavel (lLisEstOri).                   ³±±
±±³ Marcos Simidu³02/04/98³15022A³Impressao de Termo Encerr. quando o perio-³±±
±±³              ³        ³15022A³do informado nao possuir movimento.       ³±±
±±³ Marcos Simidu³06/05/98³XXXXXX³Acertos na impressao do termo de encerra- ³±±
±±³              ³        ³      ³mento do livro de saidas.                 ³±±
±±³ Marcos Simidu³11/08/98³XXXXXX³Zerar array acumulador dos resumos.       ³±±
±±³ Marcos Simidu³22/10/98³18419A³Acertos no param.consid.UF no demonst.    ³±±
±±³              ³22/10/98³18419A³por estado de origem.                     ³±±
±±³ Marcos Simidu³03/11/98³XXXXXX³Acertos no ano com 4 bytes.               ³±±
±±³ Andreia      ³29/01/99³xxxxxx³Alteracao do lay-out devido ao aumento do ³±±
±±³              ³        ³      ³campo conta contabil.  	                ³±±
±±³ Andreia      ³11/03/99³xxxxxx³Tratamento da especie das notas fiscais   ³±±
±±³              ³        ³      ³canceladas atraves do parametro MV_ESPECIE³±±
±±³ Andreia      ³04/08/99³22553A³Tratamento do parametro MV_PAR21 que defi-³±±
±±³              ³        ³      ³ne em qual coluna sera impresso o imposto ³±±
±±³              ³        ³      ³retido.                                  	³±±
±±³ Andreia      ³05/11/99³24340A³Troca de CGC por CNPJ.                    ³±±
±±³ Andreia      ³14/12/99³19277A³No resumo por CFOP,trocar TOTAL por SUB-TOTAL³±±
±±³              ³        ³      ³e TOTAL GERAL por TOTAL(Portaria CAT 08/90).³±±
±±³ Guilherme    ³06/07/07³125854³Inclusao do numero da Reducao Z para os   ³±±
±±³ Santos       ³        ³      ³movimentos gerados para ECF's.            ³±±
±±³ Danilo       ³12/09/07³131472³Passado como parametro no EmiteLivro, uma ³±±
±±³ Calil        ³        ³      ³string indicando quem esta executando.    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User FUNCTION RMatr932()

Local cArqCiap		:= ""
LOCAL nSvApurICM 	:= 0
LOCAL nSvApurIPI 	:= 0
Private cIndxSF3  	:=""
Private nCredAtivo	:=0
                          
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Flag de Movimentacao            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lHouveMov:=.F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Largura do campo de observacoes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLargObs:=If(nTipoMov=1,42,46)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pictures de campos numericos ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPictVl:=If(nTipoMov==1,"@E 999,999,999,999.99","@E 999,999,999,999.99")	// Colunas Valores
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe layout do modelo escolhido ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aL:=NIL
R932LayOut()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ So trata arquivo quando for imprimir Livros ou Livros e Termos³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nImpTerm == 1 .Or. nImpTerm == 3
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria Arquivo a ser Impresso com um indice de mesmo nome            ³
	//³ Ordem (1) = F3_FILIAL+DTOS(F3_ENTRADA)+F3_SERIE+F3_NFISCAL+F3_CFO  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cArqTemp  :=EmiteLivro(If(nTipoMov==1,"E","S"),dDtIni,dDtFim,lLacuna,lServico,lDesconto,cNrLivro,cFilterUser,@cArqCiap,MV_PAR27,MV_PAR09,MV_PAR31,MV_PAR32,MV_PAR33,MV_PAR36,"MATR930")
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Salva periodos de Apuracao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nSvApurICM:=DefPeriodo(F3_ENTRADA,nApurICM)
	nSvApurIPI:=DefPeriodo(F3_ENTRADA,nApurIPI)
EndIf
If !lAbortPrint
	If nTipoMov==1
		R932RegEntradas(nSvApurIcm,nSvApurIpi)
	Else
		R932RegSaidas(nSvApurIcm,nSvApurIpi)
	Endif
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura area ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ So trata arquivo quando for imprimir Livros ou Livros e Termos³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nImpTerm == 1 .Or. nImpTerm == 3
	dbSelectArea(cArqTemp)
	dbCloseArea()
	Ferase(cArqTemp+GetDbExtension())
	Ferase(cArqTemp+OrdBagExt())
EndIf
If ( Select("CIAP")!=0 )
	dbSelectArea("CIAP")
	dbCloseArea()
	Ferase(cArqCiap+GetDbExtension())
	Ferase(cArqCiap+OrdBagExt())
EndIf
If ( Select(cArqSF3)!=0 )
	dbSelectArea(cArqSF3)
	dbCloseArea()
	Ferase(cArqSF3+GetDbExtension())
	Ferase(cIndxSF3+OrdBagExt())
EndIf
dbSelectArea(aSvArea[1])
dbSetOrder(aSvArea[2])
dbGoto(aSvArea[3])
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³R932RegEntradas³Autor³Juan Jose Pereira    ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³Imprime Registro de Entradas                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932RegEntradas(nSvApurIcm,nSvApurIpi)

Local nTotICMS	:= 0

Local aProdutor	:= {}
Local dDataProd	:= cToD("  /  /  ")
Local lApur 	:= .F.
Local aAreaSM0	:= SM0->(GetArea())
Local lCredST	:= SF3->(FieldPos("F3_CREDST")) > 0
Local lProcST	:= .T.

aGrade			:= NIL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ So trata arquivo quando for imprimir Livros ou Livros e Termos³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nImpTerm == 1 .Or. nImpTerm == 3
	dbSelectArea(cArqTemp)
	dDiaAnt:=F3_ENTRADA
	dDia:=dDiaAnt
	SetRegua(LastRec())
	While !Eof()
		lTotGrade:=.F.
		IncRegua()
		If Interrupcao(@lAbortPrint)
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If !(cArqTemp)->SEMMOV
		   If !Empty(cFilterUser).and.!(&cFilterUser)
			  dbSkip()
			  Loop
		   EndIf
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica o valor do ICMS Retido de acordo com a configuracao da TES     ³
		//³Quando o campo F3_CREST existir e estiver configurado como "4",         ³
		//³o valor do ICMS retido nao deve ser apresentado na coluna de observacoes³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lProcST := .T.
		If lCredST
			If (cArqTemp)->F3_CREDST == "4"
		       	lProcST := .F.
			Endif
		Endif
		   
		//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cabecalho ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin>nLimPag .And. !(cArqTemp)->SEMMOV
			R932Cabec(dDia)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Contador de Tamanho de nota ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTamNota:=nLin
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime os periodos sem movimento³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (cArqTemp)->SEMMOV
			dDia:=(cArqTemp)->F3_ENTRADA
			R932Cabec(dDia)
			cLinha:=FmtLin(Array(16),aL[17],,,nLin,.F.)
			R93xFillPage(cLinha,"*** NAO HOUVE MOVIMENTO ***",@nLin,nLimPag) //
			FmtLin(,aL[1],,,@nLin)
			R932TermEnc()
			(cArqTemp)->(dbSkip())     
			dDia:=(cArqTemp)->F3_ENTRADA          
			lHouveMov := .T.
			Loop     
		Endif    

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Salva o período de apuração³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !lApur
			lApur := .T.
			nSvApurICM:=DefPeriodo(F3_ENTRADA,nApurICM)
			nSvApurIPI:=DefPeriodo(F3_ENTRADA,nApurIPI)
		Endif                         
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona na filial em que foi processado o registro	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,1)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Conta contabil devera ser buscada no parametro MV_CTALFE de cada filial³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cContaContab := Alltrim(GetMV("MV_CTALFE"))
		cContaContab :=	StrTran(cContaContab,"SF3->",)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona nos cadastros de Clientes/Fornecedores³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cClieFor:=F3_CLIEFOR+F3_LOJA
		If(F3_TIPO$"DB",dbSelectArea("SA1"),dbSelectArea("SA2"))
		dbSeek(xFilial()+cClieFor)
		dbSelectArea(cArqTemp)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Restaura a filial e area corrente ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,2)
		//
		dbSelectArea(cArqTemp)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aObs:=LivrArrayObs(nLargObs,,lListaNFO)
		R932IniGrade()
		aGrade[1,2]:=F3_BASEICM
		aGrade[1,3]:=F3_VALICM
		aGrade[2,2]:=F3_ISENICM
		aGrade[3,2]:=F3_OUTRICM
		IF cMV_ESTADO != "SP" .OR. lCat21
			aGrade[4,2]:=F3_BASEIPI
			aGrade[4,3]:=F3_VALIPI
			aGrade[5,2]:=F3_ISENIPI
			aGrade[6,2]:=F3_OUTRIPI
        ENDIF
		aDados:=Array(16)
		aDados[1]:=DTOC(F3_ENTRADA)
		aDados[2] := IIf(Empty(F3_ESPECIE),R930CFOTra(F3_CFO,F3_SERIE),F3_ESPECIE)
		aDados[3]:=F3_SERIE
		aDados[4]:=F3_NFISCAL
		aDados[5]:=DTOC(F3_EMISSAO)
//		aDados[6]:=F3_CLIEFOR+"-"+F3_LOJA+Transform(iif(F3_TIPO$"BD",SA1->A1_CGC,SA2->A2_CGC),"@r 99.999.999/9999-99")
		aDados[6]:=Transform(iif(F3_TIPO$"BD",SA1->A1_CGC,SA2->A2_CGC),"@r 99.999.999/9999-99")
		aDados[7]:=F3_ESTADO
		aDados[8]:=F3_VALCONT
		aDados[9]:=EvalMacro(cContaContabil)
		aDados[10]:=If(substr(F3_CFO,1,3)$"999#000",,Transform(F3_CFO,PESQPICT("SF3","F3_CFO"))) 
		If nModelo != 5
			aDados[14]:=Iif(F3_ALIQICM > 0,Transform(F3_ALIQICM,"@E 99.99"),"")
		EndIf
		nTotICMS += F3_VALICM
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Linhas de detalhe              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R932ImpGrade()
		// Adicionado por Adriano para imprimir mais uma linha por titulo com o nome do cliente/fornecedor.
		If F3_TIPO$"BD"
			aDados[6] := Left(SA1->A1_NOME,22)
		Else
			aDados[6] := Left(SA2->A2_NOME,22)
		EndIf                                 
		 
		FmtLin(@aDados,aL[17],cPictVl,,@nLin)		

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[17],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para atender legislacao Fomentar de GO ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro).and.F3_ICMSRET-F3_OBSSOL>0  .And. lProcST
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=F3_BASERET
			If nColuna ==1
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(F3_ICMSRET-F3_OBSSOL,PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[15]:=F3_ICMSRET-F3_OBSSOL
			ElseIf nColuna == 3
				If F3_TIPO == "D"
					aDados[15]:=F3_ICMSRET-F3_OBSSOL
				Else
					aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(F3_ICMSRET-F3_OBSSOL,PESQPICT("SF3","F3_ICMSRET"))) //
				Endif
			EndIf
			FmtLin(@aDados,aL[17],cPictVl,,@nLin)
		Elseif nColuna ==2 .and. F3_ICMSRET-F3_OBSSOL>0  .And. lProcST
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=F3_BASERET 
			If nModelo != 5
				aDados[14]:=Iif(F3_ALIQICM > 0,Transform(F3_ALIQICM,"@E 99.99"),"")
			EndIf
			aDados[15]:=F3_ICMSRET-F3_OBSSOL
			FmtLin(@aDados,aL[17],cPictVl,,@nLin)
		Elseif nColuna ==3 .and.F3_ICMSRET-F3_OBSSOL>0  .And. lProcST
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=F3_BASERET
			If F3_TIPO == "D"
				aDados[15]:=F3_ICMSRET-F3_OBSSOL
			Else
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(F3_ICMSRET-F3_OBSSOL,PESQPICT("SF3","F3_ICMSRET"))) //
			Endif
			FmtLin(@aDados,aL[17],cPictVl,,@nLin)
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acumula valores ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLinNec:=nLin-nTamNota+If(lImpZer,3,0)
		aTamNotas[1]:=Max(aTamNotas[1],nLinNec)
		LivrAcumula(cArqTemp,@aTotDia,@aTotPerICM,@aTotPerIPI,@aTotMes,@aTransp,@aResumo,@aResCFO,cArqSF3)
		dDiaAnt:=F3_ENTRADA
		********************* CIAP **********************
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza a Manutencao do CIAP                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lEmiteCiap
			If Select("CIAP") > 0
				dbSelectArea("CIAP")
				If ( dbSeek(&(cArqTemp)->(Recno())) )
					While ( !Eof() .And. CIAP->SF3==&(cArqTemp)->(Recno()) )
						dbSelectArea("SF9")
						dbGoto(CIAP->SF9)
						Begin Transaction
							RecLock("SF9",.F.)
							SF9->F9_NLRE := Val(cLivro)
							SF9->F9_FLRE := nPagina
							MsUnlock()
						End Transaction
						dbSelectArea("CIAP")
						dbSkip()
					EndDo
				Endif
			EndIf
		Endif
		********************* CIAP **********************
		dbSelectArea(cArqTemp)
		dDataProd 	:= F3_ENTRADA		
		nMes 		:= Month(F3_ENTRADA)
		dbSkip()
		If !Eof()
			dDia:=F3_ENTRADA
		Else
			dDia:=UltimoDia(dDia)+1
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Totais e finaliza relatorio ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lTotGrade:=.T.
		lHouveMov:=.T.
		R932Totais(@nSvApurIcm,@nSvApurIpi)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime quadro de demonstrativo de Produtor Rural³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lProdutor .And. nModelo == 2 .And. Month(F3_ENTRADA) <> nMes
			nMes := Month(F3_ENTRADA)
			aProdutor := {}
			aProdutor := Mtr930Apur(nApurICM,Year(dDataProd),Month(dDataProd),cNrLivro)
			If Len(aProdutor) > 0
				R932Cabec(dDataProd,.F.)
				FmtLin(,aL[20],,,@nLin)
				FmtLin(,aL[21],,,@nLin)
				FmtLin(,aL[22],,,@nLin)
				FmtLin({aProdutor[01][02]},aL[23],,,@nLin)
				FmtLin(,aL[24],,,@nLin)
				FmtLin({nTotICMS},aL[25],,,@nLin)
				FmtLin(,aL[26],,,@nLin)
				FmtLin({aProdutor[01][03]+aProdutor[01][04]},aL[27],,,@nLin)
				FmtLin(,aL[28],,,@nLin)
				FmtLin({aProdutor[01][01]},aL[29],,,@nLin)
				FmtLin(,aL[30],,,@nLin)
				FmtLin(,aL[31],,,@nLin)
				FmtLin({(aProdutor[01][02]+nTotICMS)-(aProdutor[01][03]+aProdutor[01][01]+aProdutor[01][04])},aL[32],,,@nLin)
				FmtLin(,aL[33],,,@nLin)
				FmtLin(,aL[34],,,@nLin)
				nLin := 80
			Endif
	
		Endif
	End
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quando nao ha movimento                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lHouveMov
		dDia:=dDtIni
		R932Cabec(dDia)
		cLinha:=FmtLin(Array(16),aL[17],,,nLin,.F.)
		R93xFillPage(cLinha,"*** NAO HOUVE MOVIMENTO ***",@nLin,nLimPag) //
		FmtLin(,aL[1],,,@nLin)
		R932TermEnc()
	Endif
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Termo de Abertura    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932TermIni()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Termo de Encerramento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932TermEnc()
EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o   ³R932RegSaidas³Autor³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o³Imprime Registro de Saidas                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932RegSaidas(nSvApurIcm,nSvApurIpi)
Local lMV_ESTCLI 	:= GetNewPar ("MV_ESTCLI", .F.)	//Parametro para mudar a pesquisa do estado do cliente. F3_ESTADO pelo A1_EST ou A2_EST.
Local lEcfNotas 	:= GetNewPar ("MV_ECFNOTA", .F.)	//Parametro tem como objetivo imprimir o documento final mesmo sem a utilizacao de Aglutinar Notas Fiscais de Saida
Local lApur			:= .F.
Local aAreaSM0 		:= SM0->(GetArea())
Local lCredST		:= SF3->(FieldPos("F3_CREDST")) > 0
Local lProcST		:= .T.
Local lImpSemMov	:= .F.
Local lImpTot		:= .F.
PRIVATE aGrade:={}                                 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ So trata arquivo quando for imprimir Livros ou Livros e Termos³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nImpTerm == 1 .Or. nImpTerm == 3
	dbSelectArea(cArqTemp)
	dDiaAnt:=F3_ENTRADA
	dDia:=dDiaAnt
	SetRegua(LastRec())
	While !Eof()
		IncRegua()
		If Interrupcao(@lAbortPrint)
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        If !(cArqTemp)->SEMMOV
		   If !Empty(cFilterUser).and.!(&cFilterUser)
			  dbSkip()
			  Loop
		   EndIf
		Endif   
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica o valor do ICMS Retido de acordo com a configuracao da TES     ³
		//³Quando o campo F3_CREST existir e estiver configurado como "4",         ³
		//³o valor do ICMS retido nao deve ser apresentado na coluna de observacoes³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lProcST := .T.
		If lCredST
			If (cArqTemp)->F3_CREDST == "4"
		       	lProcST := .F.
			Endif
		Endif
		If (!lLacuna .AND. !Empty(F3_DTCANC))
			dbSelectArea(cArqTemp)
			dbSkip()
			If lHouveMov
				dDia:=F3_ENTRADA
			EndIf
			lImpTot := .F.
			loop
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cabecalho ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÙ
		If nLin>nLimPag .And. !(cArqTemp)->SEMMOV
			R932Cabec(dDia)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Imprime os periodos sem movimento³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (cArqTemp)->SEMMOV
			dDia:=(cArqTemp)->F3_ENTRADA
			R932Cabec(dDia)
			cLinha:=FmtLin(Array(14),aL[19],,,nLin,.F.)
			R93xFillPage(cLinha,"*** NAO HOUVE MOVIMENTO ***",@nLin,nLimPag) //"*** NAO HOUVE MOVIMENTO ***"
			FmtLin(,aL[1],,,@nLin)
			R932TermEnc()
			(cArqTemp)->(dbSkip())     
			dDia:=(cArqTemp)->F3_ENTRADA          
			lHouveMov := .F.
			lImpSemMov:= .T.
			Loop     
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Salva o período de apuração³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !lApur
			lApur := .T.
			nSvApurICM:=DefPeriodo(F3_ENTRADA,nApurICM)
			nSvApurIPI:=DefPeriodo(F3_ENTRADA,nApurIPI)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona na filial em que foi processado o registro	³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,1)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Conta contabil devera ser buscada no parametro MV_CTALFS de cada filial³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cContaContab := Alltrim(GetMV("MV_CTALFS"))
		cContaContab :=	StrTran(cContaContab,"SF3->",)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica o parametro para cada filial processada³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        lMV_ESTCLI 	:= GetNewPar ("MV_ESTCLI", .F.)	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona nos cadastros de Clientes/Fornecedores ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cClieFor:=F3_CLIEFOR+F3_LOJA
		If(F3_TIPO$"DB",dbSelectArea("SA2"),dbSelectArea("SA1"))
		dbSeek(xFilial()+cClieFor)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Restaura a filial e area corrente ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,2)
		//
		dbSelectArea(cArqTemp)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Contador de Tamanho de nota ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTamNota:=nLin
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aObs:=LivrArrayObs(nLargObs,,lListaNFO)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Linhas de Detalhe³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aDados:=ARRAY(14)
		aDados[1] := IIf(Empty(F3_ESPECIE),If(F3_SERIE=="ECF","CF",R930CFOTra(F3_CFO,F3_SERIE)),F3_ESPECIE)

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Layout de acordo com a lei 9.513 (lista o intervalo de cupons fiscais - ECF)³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !lLeiECF .Or. Empty(F3_PDV)
			aDados[2]:=F3_SERIE
		Else
			aDados[2] := Alltrim(F3_PDV)
		Endif

		IF lAglutina
			aDados[3]:=F3_NFISCAL+" A "+IF(!EMPTY(F3_DTCANC),F3_NFISCAL,F3_DOCOR)	 	
		ELSE
			aDados[3]:=F3_NFISCAL+" A "+IF((F3_TIPO$"LC".Or.F3_SERIE=="ECF") .And. !lEcfNotas ,F3_DOCOR,F3_NFISCAL)
		ENDIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Layout de acordo com a lei 9.513 (lista o intervalo de cupons fiscais - ECF)³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lLeiECF .AND. (SF3->(FieldPos("F3_NUMINI")) > 0 .AND. SF3->(FieldPos("F3_NUMFIM")) > 0) .AND. !Empty(F3_PDV)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Posiciona na filial em que foi processado o registro	³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	        Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,1)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Recupera a partir do SFI, o numero do ultimo documento emitido no ECF.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			dbSelectArea("SFI")
			dbSetOrder(1)		//FILIAL + DTMOVTO + PDV
			If DbSeek( xFilial("SFI") + DTOS( (cArqTemp)->F3_EMISSAO ) + (cArqTemp)->F3_PDV )
				aDados[3] := (cArqTemp)->F3_NUMINI + " A " + SFI->FI_COO
			EndIf
	
			dbSelectArea(cArqTemp)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Restaura a filial e area corrente ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,2)
		Endif

		aDados[4]:=StrZero(Day(F3_ENTRADA),2)
		//
		aDados[5]:=F3_ESTADO
		If (lMV_ESTCLI)
			aDados[5]:=Iif (F3_TIPO$"DB", SA2->A2_EST, SA1->A1_EST)
		EndIf
		//
		aDados[6]:=F3_VALCONT
		aDados[7]:=EvalMacro(cContaContabil)
		aDados[8]:=If(substr(F3_CFO,1,3)$"999#000",,Transform(F3_CFO,PESQPICT("SF3","F3_CFO")))
		aDados[9]:=F3_BASEICM        
		If nModelo != 5
			aDados[10]:=Iif(F3_ALIQICM > 0,Transform(F3_ALIQICM,"@E 99.99"),"")
		EndIf
		aDados[11]:=F3_VALICM
		aDados[12]:=F3_ISENICM
		aDados[13]:=F3_OUTRICM
		R932LoadObs()
		FmtLin(@aDados,aL[19],cPictVl,,@nLin)              
		
		// Adicionado por Adriano para imprimir mais uma linha por titulo com o nome do cliente/fornecedor.
		If ! F3_TIPO $ "DB"
			aDados[14] := Transform(SA1->A1_CGC,"@r 99.999.999/9999-99")+" "+Left(SA1->A1_NOME,22)
		Else
			aDados[14] := Transform(SA2->A2_CGC,"@r 99.999.999/9999-99")+" "+Left(SA2->A2_NOME,22)
		EndIf                                 
		 
		FmtLin(@aDados,aL[19],cPictVl,,@nLin)		
		
		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[19],cPictVl,,@nLin)
			Endif
		End


		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ! Empty(cTitLivro) .And. F3_ICMSRET-F3_OBSSOL>0  .And. lProcST
			aDados[8]:="ST"
			aDados[9]:=F3_BASERET
			If nColuna ==1
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(F3_ICMSRET-F3_OBSSOL,PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[11]:=F3_ICMSRET-F3_OBSSOL
			ElseIf nColuna == 3
				If F3_TIPO == "D"
					aDados[11]:=F3_ICMSRET-F3_OBSSOL
				Else
					aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(F3_ICMSRET-F3_OBSSOL,PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
			EndIF
			FmtLin(@aDados,aL[19],cPictVl,,@nLin)
		ElseIf nColuna ==2.and.F3_ICMSRET-F3_OBSSOL>0  .And. lProcST
			aDados[8]:="ST"
			aDados[9]:=F3_BASERET
			If nModelo != 5
				aDados[10]:=Iif(F3_ALIQICM > 0,Transform(F3_ALIQICM,"@E 99.99"),"")
			EndIf
			aDados[11]:=F3_ICMSRET-F3_OBSSOL
			FmtLin(@aDados,aL[19],cPictVl,,@nLin)
		ElseIf nColuna ==3.and.F3_ICMSRET-F3_OBSSOL>0  .And. lProcST
			aDados[8]:="ST"
			aDados[9]:=F3_BASERET
			If F3_TIPO == "D"
				aDados[11]:=F3_ICMSRET-F3_OBSSOL
			Else
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(F3_ICMSRET-F3_OBSSOL,PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif
			FmtLin(@aDados,aL[19],cPictVl,,@nLin)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acumula valores ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nLinNec:=nLin-nTamNota
		aTamNotas[1]:=Max(aTamNotas[1],nLinNec)
		LivrAcumula(cArqTemp,@aTotDia,@aTotPerICM,@aTotPerIPI,@aTotMes,@aTransp,@aResumo,@aResCFO,cArqSF3)
		dDiaAnt:=F3_ENTRADA
		dbSelectArea(cArqTemp)
		dbSkip()
		If !Eof()
			dDia:=F3_ENTRADA
		Else
			dDia:=UltimoDia(dDia)+1
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Totais e finaliza relatorio ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		lHouveMov	:= .T.
		lImpTot		:= .T.		
		R932Totais(@nSvApurIcm,@nSvApurIpi)
	End

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifico se a ultima nota eh cancelada para imprimir o Total ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lHouveMov .And. 	!lImpTot
    	R932Totais(@nSvApurIcm,@nSvApurIpi)
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Quando nao ha movimento                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lHouveMov .And. !lImpSemMov
		dDia:=dDtIni
		R932Cabec(dDia)
		cLinha:=FmtLin(Array(14),aL[19],,,nLin,.F.)
		R93xFillPage(cLinha,"*** NAO HOUVE MOVIMENTO ***",@nLin,nLimPag) //
		FmtLin(,aL[1],,,@nLin)
		R932TermEnc()
	Endif
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Termo de Abertura    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932TermIni()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Termo de Encerramento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932TermEnc()
EndIf
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932Cabec ³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao de Cabecalho                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932Cabec(dData,lImpDad)

Local lLFisOrd := GetNewPar("MV_LFISORD",.F.)

dData	:= IIf(dData==NIL,dDiaAnt,dData)
lImpDad := Iif(lImpDad==Nil,.T.,lImpDad)

cPeriodo:=aMeses[Month(dData)]+" / "+Str(Year(dData),4)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Termos de Abertura/Encerramento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aPagTerm:=CtrlPg(@nPagina,nQtFeixe,lReiniPg)
cPagina :=Transform(StrZero(nPagina,6),"@R 999.999")
If (nImpTerm == 2 .Or. nImpTerm == 3) .and.aPagTerm[1]+aPagTerm[2]>0
	If nTipoMov==1
		ImprimeTermo(aPagTerm[1],nPagIni,nQtFeixe,GetMv("MV_LENTEN"),nLargMax,cPerg)
		nPagIni:=ImprimeTermo(aPagTerm[2],nPagIni,nQtFeixe,GetMv("MV_LENTAB"),nLargMax,cPerg)
	Else
		ImprimeTermo(aPagTerm[1],nPagIni,nQtFeixe,GetMv("MV_LSAIEN"),nLargMax,cPerg)
		nPagIni:=ImprimeTermo(aPagTerm[2],nPagIni,nQtFeixe,GetMv("MV_LSAIAB"),nLargMax,cPerg)
	Endif
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Cabecalho  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLin:=3
FmtLin(,AvalImp(nLargMax),,,@nLin)
FmtLin(,aL[1],,,@nLin)
FmtLin({cTitLivro},aL[2],,,@nLin)
FmtLin(,aL[3],,,@nLin)
FmtLin({cNome},aL[4],,,@nLin)
FmtLin(,aL[5],,,@nLin)
FmtLin({cInscr,cCGC},aL[6],,,@nLin)
FmtLin(,aL[7],,,@nLin)
If !lLFisOrd
	FmtLin({cPagina,cPeriodo},aL[8],,,@nLin)	
Else
	FmtLin({cLivro,cPagina,cPeriodo},aL[8],,,@nLin)                                         
Endif
If lImpDad
	FmtLin(,{aL[9],aL[10],aL[11],aL[12],aL[13],aL[14],aL[15],aL[16]},,,@nLin)
	If nTipoMov==2
		FmtLin(,{aL[17],aL[18]},,,@nLin)
	Endif
Else                                                                             
	FmtLin(,{aL[9],aL[10],aL[11]},,,@nLin)
Endif
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932LayOut³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Layout dos modelos P1A e P2A                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932LayOut             

Local nSubDiv	:= mv_par36
Local lLFisOrd	:= GetNewPar("MV_LFISORD",.F.)
Local lImp  	:= GetNewPar("MV_IMPCABE",.F.)

If nTipoMov==1
	aL:=Array(34)
	aL[01]:="+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Para atender a Legislacao de Pernambuco                        ³
	//³O valor do ICMS ST nas entradas deve ser apresentado em coluna ³
	//³especifica - Contribuinte Substituido - ICMS na Fonte          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cMV_ESTADO == "PE"
		aL[02]:="|                                                                REGISTRO DE ENTRADAS #                                                               |                  (*) CODIGO DE VALORES FISCAIS                     |"
		aL[03]:="|                                                                                                                                                     |--------------------------------------------------------------------|"
		aL[04]:="| FIRMA: #############################                                                                                                                | 1  - OPERACOES COM CREDITO DO IMPOSTO                              |"
		aL[05]:="|                                                                                                                                                     | 2  - OPERACOES SEM CREDITO DO IMPOSTO - ISENTAS OU NAO TRIBUTADAS  |"
		aL[06]:="| INSC.EST: ###########           C.N.P.J.: ##############                                                                                            | 3  - OPERACOES SEM CREDITO DO IMPOSTO - OUTRAS                     |" 
		aL[07]:="|                                                                                                                                                     | ST - CONTRIBUINTE-SUBSTITUIDO - ICMS NA FONTE                      |"		
		aL[08]:="| FOLHA: #######                   MES OU PERIODO/ANO: #######                                                                                        |                                                                    |" 
		aL[09]:="|                                                                                                                                                     |                                                                    |"
		aL[10]:="|                                                                                                                                                     |                                                                    |"
	Else
		If nSubDiv == 1
			If lImp
				aL[02]:="|                                                                REGISTRO DE ENTRADAS # - P1A                                                         |                  (*) CODIGO DE VALORES FISCAIS                     |"
            Else
				aL[02]:="|                                                                REGISTRO DE ENTRADAS #                                                               |                  (*) CODIGO DE VALORES FISCAIS                     |"
            Endif
		ElseIf nSubDiv == 2
			If lImp
				aL[02]:= "|                                                        LIVRO REGISTRO DE ENTRADAS ESTADUAIS # - P1A                                                 |                  (*) CODIGO DE VALORES FISCAIS                     |"
			Else
				aL[02]:="|                                                        LIVRO REGISTRO DE ENTRADAS ESTADUAIS #                                                       |                  (*) CODIGO DE VALORES FISCAIS                     |"
		    Endif
		ElseIf nSubDiv == 3
			If lImp
				aL[02]:="|                                                      LIVRO REGISTRO DE ENTRADAS INTERESTADUAIS # - P1A                                              |                  (*) CODIGO DE VALORES FISCAIS                     |"
			Else
				aL[02]:="|                                                      LIVRO REGISTRO DE ENTRADAS INTERESTADUAIS #                                                    |                  (*) CODIGO DE VALORES FISCAIS                     |"
		    Endif
		Endif
		aL[03]:="|                                                                                                                                                     |--------------------------------------------------------------------|"
		aL[04]:="| FIRMA: #############################                                                                                                                |                                                                    |"
		aL[05]:="|                                                                                                                                                     | 1 - OPERACOES COM CREDITO DO IMPOSTO                               |"
		aL[06]:="| INSC.EST: ###########           C.N.P.J.: ##############                                                                                            |                                                                    |"
		aL[07]:="|                                                                                                                                                     | 2 - OPERACOES SEM CREDITO DO IMPOSTO - ISENTAS OU NAO TRIBUTADAS   |"
		If !lLFisOrd
			aL[08]:="| FOLHA: #######                   MES OU PERIODO/ANO: #######                                                                                        |                                                                    |"
		Else
			aL[08]:="| ORDEM/FOLHA: ###-E / #######     MES OU PERIODO/ANO: #######                                                                                                                                                             |"
		Endif
		aL[09]:="|                                                                                                                                                     | 3 - OPERACOES SEM CREDITO DO IMPOSTO - OUTRAS                      |"
		aL[10]:="|                                                                                                                                                     |                                                                    |"
	Endif
	aL[11]:="|==========================================================================================================================================================================================================================|"
	aL[12]:="|          |             DOCUMENTOS FISCAIS                                 |                  |      CODIFICACAO          |    |              VALORES FISCAIS                  |                                          |"
	aL[13]:="|          |----------------------------------------------------------------|                  |---------------------------|    |-----------------------------------------------|                                          |"
	aL[14]:="|DATA DE   |ESPE |  SERIE  |         |DATA      |CODIGO DO             | UF |                  |                    |      |ICMS|COD| BASE DE CALCULO  |     |      IMPOSTO     |                                          |"
	
	If ("SP"$cMV_ESTADO .OR. lCat21)
		aL[15]:="|ENTRADA   |CIE  |SUB-SERIE|NUMERO   |DOCUMENTO |EMITENTE              |ORIG|  VALOR CONTABIL  |    CONTABIL        |FISCAL|    |(*)|VALOR DA OPERACAO |ALIQ.|     CREDITADO    |                       OBSERVACOES        |"
	Else
		aL[15]:="|ENTRADA   |CIE  |SUB-SERIE|NUMERO   |DOCUMENTO |EMITENTE              |ORIG|  VALOR CONTABIL  |    CONTABIL        |FISCAL|IPI |(*)|VALOR DA OPERACAO |ALIQ.|     CREDITADO    |                       OBSERVACOES        |"
	EndIf
	
    aL[16]:="|==========|=====+=========+=========+==========+======================+====|==================|====================+======|====|===+==================+=====+==================|==========================================|"
	aL[17]:="|##########|#####|   ###   |#########|##########|######################| ## |##################|####################| #### |####| # |##################|#####|##################|##########################################|"
	aL[18]:="|# # # #   |# #########################################################| ## |##################|####################| #### |####| # |##################|#####|##################|##########################################|"
	aL[19]:="+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
	aL[20]:="|                                                                                        DEMONSTRATIVO DE CREDITOS - PRODUTOR RURAL                                                                                        |" 
	aL[21]:="+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
	aL[22]:="|                                                                                                                                                                                                                          |"
	aL[23]:="|                                                                      I   - SALDO CREDOR TRANSPORTADO DO MES ANTERIOR           ####################                                                                      |"
	aL[24]:="|                                                                                                                                                                                                                          |"	
	aL[25]:="|                                                                      II  - CREDITOS ESCRITURADOS NO MES                        ####################                                                                      |"
	aL[26]:="|                                                                                                                                                                                                                          |"
	aL[27]:="|                                                                      III - CREDITOS UTILIZADOS NO PERIODO                      ####################                                                                      |"
	aL[28]:="|                                                                                                                                                                                                                          |"
	aL[29]:="|                                                                      IV  - ESTORNOS DE CREDITOS EFETUADOS                      ####################                                                                      |" 
	aL[30]:="|                                                                                                                                                                                                                          |"
	aL[31]:="|                                                                                                                                                                                                                          |"
	aL[32]:="|                                                                      V   - SALDO DO PERIODO (I + II) - (III + IV)              ####################                                                                      |"
	aL[33]:="|                                                                                                                                                                                                                          |"
	aL[34]:="+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
Else             
	aL:=Array(20)
	aL[01]:="+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+"
	If nSubDiv == 1
		If lImp
			aL[02]:="|                                                                                                     REGISTRO DE SAIDAS # - P2A                                                                                           |"        
		Else
			aL[02]:="|                                                                                                     REGISTRO DE SAIDAS #                                                                                                 |"
	    Endif
	ElseIf nSubDiv == 2
		If lImp
			aL[02]:="|                                                                                             LIVRO REGISTRO DE SAIDAS ESTADUAIS # - P2A                                                                                   |"
		Else
			aL[02]:="|                                                                                             LIVRO REGISTRO DE SAIDAS ESTADUAIS #                                                                                         |"
	    Endif
	ElseIf nSubDiv == 3
		If lImp
			aL[02]:= "|                                                                                          LIVRO REGISTRO DE SAIDAS INTERESTADUAIS # - P2A                                                                                 |"
		Else
			aL[02]:="|                                                                                          LIVRO REGISTRO DE SAIDAS INTERESTADUAIS #                                                                                       |"
        Endif
	Endif
	aL[03]:="|                                                                                                                                                                                                                          |"
	aL[04]:="| FIRMA: #########################                                                                                                                                                                                         |"
	aL[05]:="|                                                                                                                                                                                                                          |"
	aL[06]:="| INSC.EST: #########             C.N.P.J.: ##############                                                                                                                                                                 |"
	aL[07]:="|                                                                                                                                                                                                                          |"
	If !lLFisOrd
		aL[08]:="| FOLHA: #######                   MES OU PERIODO/ANO: #######                                                                                                                                                             |"
	Else
		aL[08]:="| ORDEM/FOLHA: ###-E / #######     MES OU PERIODO/ANO: #######                                                                                                                                                             |"
	Endif
	aL[09]:="|                                                                                                                                                                                                                          |"
	aL[10]:="|                                                                                                                                                                                                                          |"
	aL[11]:="|==========================================================================================================================================================================================================================|"
	aL[12]:="|         DOCUMENTOS FISCAIS               |                  |      CODIFICACAO          |                                 VALORES FISCAIS                                 |                                              |"
	aL[13]:="|------------------------------------------|                  |---------------------------|---------------------------------------------------------------------------------|                                              |"
	aL[14]:="|     |     |                     |   |    |                  |                    |      |      OPERACOES COM DEBITO DO IMPOSTO      |   OPERACOES SEM DEBITO DO IMPOSTO   |                                              |"
	aL[15]:="|     |SERIE|                     |   |    |                  |                    |      |-------------------------------------------|-------------------------------------|                                              |"
	aL[16]:="|ESPE | SUB-|                     |   | UF |      VALOR       |                    |      |     BASE DE      |     |     IMPOSTO      |    ISENTAS OU    |                  |                                              |"
	aL[17]:="|CIE  |SERIE|    NUMERO           |DIA|DEST|     CONTABIL     |   CONTABIL         |FISCAL|     CALCULO      |ALIQ |     DEBITADO     |  NAO TRIBUTADAS  |      OUTRAS      |             OBSERVACOES                      |"
	aL[18]:="|=====+=====+=====================+===+====|==================|====================+======|==================+=====+==================|==================+==================|==============================================|"
	aL[19]:="|#####|#####|#####################| ##| ## |##################|####################| #### |##################|#####|##################|##################|##################|##############################################|"
	aL[20]:="|# #  |     |#####################| ##| ## |##################|####################| #### |##################|#####|##################|##################|##################|##############################################|"
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932Transp³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime linhas de transporte                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932Transp(lTotal)

Local nTamTransp := Len(LivrArrayObs(nLargObs,aTotMes))+Max(Len(aGrade),3)+2
lTotal :=If(lTotal==Nil,.F.,lTotal)
If lTotal
	nTamTransp*=2
EndIf
nMaior:=0
AEval(aTamNotas,{|x|nMaior:=Max(nMaior,x)})
aTamNotas[2]:=nMaior

nLinNec:=aTamNotas[2]
lTransp := nLimPag<=nLin+nTamTransp

If lTransp
	nTamTransp:=nLin
	If nTipoMov==1

		aObs:=LivrArrayObs(nLargObs,aTotMes)

		R932IniGrade()

		aGrade[1,2]:=aTransp[ColF3("F3_BASEICM")]
		aGrade[1,3]:=aTransp[ColF3("F3_VALICM")]
		aGrade[2,2]:=aTransp[ColF3("F3_ISENICM")]
		aGrade[3,2]:=aTransp[ColF3("F3_OUTRICM")]
		IF cMV_ESTADO != "SP" .OR. lCat21
			aGrade[4,2]:=aTransp[ColF3("F3_BASEIPI")]
			aGrade[4,3]:=aTransp[ColF3("F3_VALIPI")]
			aGrade[5,2]:=aTransp[ColF3("F3_ISENIPI")]
			aGrade[6,2]:=aTransp[ColF3("F3_OUTRIPI")]
	    ENDIF
		aDados:=ARRAY(16)
		FmtLin(@aDados,aL[18],,,@nLin)
		aDados[6]:="A TRANSPORTAR"
		aDados[8]:=aTransp[ColF3("F3_VALCONT")]

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Linhas de detalhe              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R932ImpGrade()

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para atender legislacao Fomentar de GO ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro).and.aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTransp[ColF3("F3_BASERET")]
			If nColuna ==1
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[15]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aTransp[ColF3("F3_TIPO")] == "D"
					aDados[15]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
				Else
					aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
			EndIf
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIf nColuna ==2 .and. aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")] >0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTransp[ColF3("F3_BASERET")]
			aDados[15]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIf nColuna ==3 .and. aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTransp[ColF3("F3_BASERET")]
			If aTransp[ColF3("F3_TIPO")] == "D"
				aDados[15]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
			Else
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		Endif
		nLinNec:=nLin-nTamTransp
		aTamNotas[2]:=Max(aTamNotas[2],nLinNec)

		R932Filler()
		R932Cabec()
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aObs:=LivrArrayObs(nLargObs,aTransp)
		aDados:=ARRAY(14)
		FmtLin(@aDados,aL[20],,,@nLin)
		aDados[3]:="A TRANSPORTAR" //
		aDados[6]:=aTransp[ColF3("F3_VALCONT")]
		aDados[9]:=aTransp[ColF3("F3_BASEICM")]
		aDados[11]:=aTransp[ColF3("F3_VALICM")]
		aDados[12]:=aTransp[ColF3("F3_ISENICM")]
		aDados[13]:=aTransp[ColF3("F3_OUTRICM")]
		R932LoadObs()
		FmtLin(@aDados,aL[20],cPictVl,,@nLin)

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[20],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro).and. aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTransp[ColF3("F3_BASERET")]
			If nColuna ==1
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[11]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aTransp[ColF3("F3_TIPO")] == "D"
					aDados[11]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
				Else
					aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
			EndIf
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Elseif nColuna==2 .and. aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTransp[ColF3("F3_BASERET")]
			aDados[11]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Elseif nColuna==3 .and. aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTransp[ColF3("F3_BASERET")]
			If aTransp[ColF3("F3_TIPO")] == "D"
				aDados[11]:=aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")]
			Else
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTransp[ColF3("F3_ICMSRET")]-aTransp[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Endif

		nLinNec:=nLin-nTamTransp
		aTamNotas[2]:=Max(aTamNotas[2],nLinNec)

		R932Filler()
		R932Cabec()
	Endif
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932Totdia³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime total do dia                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932TotDia
Local nX := 0
lTotDia:=(dDiaAnt!=dDia)

If lTotDia .And. !Empty(dDia)
	aTamNotas[3]:=Max(aTamNotas[3],nLinNec)
	nLinNec:=aTamNotas[3]
	If nLimPag<=nLin+((nLinNec+1)*2)
		R932Transp(.T.)
	Endif

	nTamTotDia:=nLin
	If nTipoMov==1

		aObs:=LivrArrayObs(nLargObs,aTotDia)

		R932IniGrade()

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta array com valores de ICMS        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aGrade[1,2]:=aTotDia[ColF3("F3_BASEICM")]
		aGrade[1,3]:=aTotDia[ColF3("F3_VALICM")]
		aGrade[2,2]:=aTotDia[ColF3("F3_ISENICM")]
		aGrade[3,2]:=aTotDia[ColF3("F3_OUTRICM")]
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Monta array com valores de IPI         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF cMV_ESTADO != "SP" .OR. lCat21
			aGrade[4,2]:=aTotDia[ColF3("F3_BASEIPI")]
			aGrade[4,3]:=aTotDia[ColF3("F3_VALIPI")]
			aGrade[5,2]:=aTotDia[ColF3("F3_ISENIPI")]
			aGrade[6,2]:=aTotDia[ColF3("F3_OUTRIPI")]
	    ENDIF
		aDados:=ARRAY(16)
		FmtLin(@aDados,aL[18],,,@nLin)
		aDados[6]:="TOTAL DO DIA "+StrZero(Day(dDiaAnt),2) //
		aDados[8]:=aTotDia[ColF3("F3_VALCONT")]

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Linhas de detalhe              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R932ImpGrade()

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro).and. aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTotDia[ColF3("F3_BASERET")]
			If nColuna == 1
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[15]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aTotDia[ColF3("F3_TIPO")] == "D"
					aDados[15]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
				Else
					aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
			Endif
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIf nColuna ==2.and. aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTotDia[ColF3("F3_BASERET")]
			aDados[15]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIf nColuna ==3.and. aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTotDia[ColF3("F3_BASERET")]
			If aTotDia[ColF3("F3_TIPO")] == "D"
				aDados[15]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
			Else
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		Endif
		FmtLin(@aDados,aL[18],,,@nLin)
		nLinNec:=nLin-nTamTotDia
		aTamNotas[3]:=Max(aTamNotas[3],nLinNec)
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aObs:=LivrArrayObs(nLargObs,aTotDia)
		aDados:=ARRAY(14)
		FmtLin(@aDados,aL[20],,,@nLin)
		aDados[3]:="TOTAL DO DIA "+StrZero(Day(dDiaAnt),2) //
		aDados[6]:=aTotDia[ColF3("F3_VALCONT")]
		aDados[9]:=aTotDia[ColF3("F3_BASEICM")]
		aDados[11]:=aTotDia[ColF3("F3_VALICM")]
		aDados[12]:=aTotDia[ColF3("F3_ISENICM")]
		aDados[13]:=aTotDia[ColF3("F3_OUTRICM")]
		R932LoadObs()
		FmtLin(@aDados,aL[20],cPictVl,,@nLin)

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[20],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro).and. aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTotDia[ColF3("F3_BASERET")]
			If nColuna ==1
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[11]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aTotDia[ColF3("F3_TIPO")] == "D"
					aDados[11]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
				Else
					aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
			Endif
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		ElseIf nColuna ==2 .and. aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTotDia[ColF3("F3_BASERET")]
			aDados[11]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		ElseIf nColuna ==3 .and. aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTotDia[ColF3("F3_BASERET")]
			If aTotDia[ColF3("F3_TIPO")] == "D"
				aDados[11]:=aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")]
			Else
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotDia[ColF3("F3_ICMSRET")]-aTotDia[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Endif
		FmtLin(@aDados,aL[20],,,@nLin)
		nLinNec:=nLin-nTamTotDia
		aTamNotas[3]:=Max(aTamNotas[3],nLinNec)
	Endif
Endif
If nLimPag<=nLin+nLinNec
	R932Transp()
Endif
If lTotDia
	For nX := 1 to Len(aTotDia)
	Do Case
		Case ValType(aTotDia[nX]) == "C"
			aTotDia[nX] := ""
		Case ValType(aTotDia[nX]) == "N"
			aTotDia[nX] := 0
		OtherWise
			aTotDia[nX] := Nil				
		End Case
	Next nX		
Endif   

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932TotMes³Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime total do Mes                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932TotMes
Local xx 		:= 1
Local nPosicao 	:= 0    
Local nProcFil	:= mv_par31
Local cFilDe	:= mv_par32
Local cFilAte	:= mv_par33
Local aArea		:= GetArea()
Local aAreaSm0 	:= SM0->(GetArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o processamento e centralizado, imprimindo mais de uma filial³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nProcFil <> 1
	cFilDe 	:= cFilAnt
	cFilAte	:= cFilAnt
Endif      

SM0->(dbSeek(cEmpAnt+cFilDe,.T.))

********************* CIAP **********************
If lEmiteCiap
	nPosicao :=Ascan((cArqTemp)->(dbstruct()),{ |x| ( "F3_VALICM" $ x[1] ) })
	if nTipoMov==1 .and. lTotMes
		If nLin>=nLimPag.and.lImpMes
			R932Transp()
		Endif

		dData := LastDay(MV_PAR01)
		SFA->(dbSetOrder(2))

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³Imprime atraves das filiais selecionadas para o processamento³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        Do While !SM0->(Eof()) .And. SM0->M0_CODIGO+SM0->M0_CODFIL <= cEmpAnt+cFilAte

			cFilAnt	:= SM0->M0_CODFIL
		
			If SFA->(dbSeek(xFilial("SFA")+dTos( dData )))
				While SFA->(!EOF()) .and. SFA->FA_FILIAL == xFilial("SFA") .and. Dtos(SFA->FA_DATA)== dTos(ddata)
					If ( SFA->FA_TIPO == "1" ) .and. (SFA->FA_CREDIT =="1")
						cMensagem:=Trim("Credito de ICMS relativo a entrada de Bem do Ativo ")+If(lColCiap,PADL(Transform(SFA->FA_VALOR,"@E 9,999,999.99"),58),"")
						For xx:=1 to MlCount(cMensagem,nLargObs)
							AADD(aObs,{MemoLine(cMensagem,nLargObs,xx),.T.})
						Next xx
	
						SF9->(dbSeek(xFilial()+SFA->FA_CODIGO))
						R932IniGrade()
						aGrade[1,1]:="1"
						If !lColCiap
							aGrade[1,3]:=SFA->FA_VALOR
						Endif
						nCredAtivo  +=SFA->FA_VALOR
	
						aDados:=Array(18)		
						If nLin>=nLimPag
							R932Filler()
							R932Cabec()
						EndIf
						FmtLin(@aDados,aL[18],,,@nLin)
						aDados[10]	:= SF9->F9_CFOENT
						R932ImpGrade()
						nPosObs:=Ascan(aObs,{|x|x[2]})
						While nPosObs>0
							R932LoadObs()
							If nPosObs>0
								If nLin>=nLimPag
									R932Filler()
									R932Cabec()
								EndIf
								FmtLin(@aDados,aL[17],cPictVl,,@nLin)
							Endif
						Enddo
					EndIf				
					SFA->(dBSkip())
				EndDo
			Endif	
			SM0->(dbSkip())
		Enddo
		aTotMes[nPosicao] +=nCredAtivo
	EndIf
Endif
******************* CIAP FIM *********************
If lTotMes.and.lImpMes
	If nLin>=nLimPag.and.lImpMes
		R932Transp()
	Endif
	If nTipoMov==1

		aObs:=LivrArrayObs(nLargObs,aTotMes)

		R932IniGrade()

		aGrade[1,2]:=aTotMes[ColF3("F3_BASEICM")]
		aGrade[1,3]:=aTotMes[ColF3("F3_VALICM")]
		aGrade[2,2]:=aTotMes[ColF3("F3_ISENICM")]
		aGrade[3,2]:=aTotMes[ColF3("F3_OUTRICM")]
		IF cMV_ESTADO != "SP" .OR. lCat21
			aGrade[4,2]:=aTotMes[ColF3("F3_BASEIPI")]
			aGrade[4,3]:=aTotMes[ColF3("F3_VALIPI")]
			aGrade[5,2]:=aTotMes[ColF3("F3_ISENIPI")]
			aGrade[6,2]:=aTotMes[ColF3("F3_OUTRIPI")]
	    ENDIF
		aDados:=ARRAY(16)
		FmtLin(@aDados,aL[18],,,@nLin)
		aDados[6]:="TOTAL DO MES"
		aDados[8]:=aTotMes[ColF3("F3_VALCONT")]

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Linhas de detalhe              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R932ImpGrade()

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro).and.aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTotMes[ColF3("F3_BASERET")]
			If nColuna ==1
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			ElseIf nColuna == 2
				aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aTotMes[ColF3("F3_TIPO")] == "D"
					aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
				Else
					aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
			Endif
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIf nColuna == 2 .and. aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTotMes[ColF3("F3_BASERET")]
			aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIf nColuna == 3 .and.aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aTotMes[ColF3("F3_BASERET")]
			If aTotMes[ColF3("F3_TIPO")] == "D"
				aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
			Else
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		Endif
		FmtLin(@aDados,aL[18],,,@nLin)
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aObs:=LivrArrayObs(nLargObs,aTotMes)
		aDados:=ARRAY(14)
		FmtLin(@aDados,aL[20],,,@nLin)
		aDados[3]:="TOTAL DO MES"
		aDados[6]:=aTotMes[ColF3("F3_VALCONT")]
		aDados[9]:=aTotMes[ColF3("F3_BASEICM")]
		aDados[11]:=aTotMes[ColF3("F3_VALICM")]
		aDados[12]:=aTotMes[ColF3("F3_ISENICM")]
		aDados[13]:=aTotMes[ColF3("F3_OUTRICM")]
		R932LoadObs()
		FmtLin(@aDados,aL[20],cPictVl,,@nLin)

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[20],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atender legislacao Fomentar de GO ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro).and. aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTotMes[ColF3("F3_BASERET")]
			If nColuna ==1
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			ElseIf nColuna == 2
				aDados[11]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aTotMes[ColF3("F3_TIPO")] == "D"
					aDados[11]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
				Else
					aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif			
			Endif
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Elseif nColuna ==2 .and. aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTotMes[ColF3("F3_BASERET")]
			aDados[11]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Elseif nColuna ==3 .and. aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aTotMes[ColF3("F3_BASERET")]
			If aTotMes[ColF3("F3_TIPO")] == "D"
				aDados[11]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
			Else
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif			
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Endif
		FmtLin(@aDados,aL[20],,,@nLin)
	Endif
	If !Eof()
		R932Filler()
	Endif
	
	For xx := 1 to Len(aTransp)
		If ValType(aTransp[xx]) == "N"
			aTransp[xx] := 0
		Else
			aTransp[xx] := "NULL"
		Endif
	Next

	For xx := 1 to Len(aTotMes)
		If ValType(aTotMes[xx]) == "N"
			aTotMes[xx] := 0
		Else
			aTotMes[xx] := "NULL"
		Endif
	Next

	For xx := 1 to Len(aTamNotas)
		If ValType(aTamNotas[xx]) == "N"
			aTamNotas[xx] := 0
		Else
			aTamNotas[xx] := "NULL"
		Endif
	Next
	
Endif    

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a filial e area corrente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RestArea(aAreaSm0)
cFilAnt	:= SM0->M0_CODFIL
RestArea(aArea)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932TotPer³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime total do periodo de apuracao                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932TotPer(nSvApurIcm,nSvApurIpi)
Local nCntFor	:=1
Local nX		:=0
nLinNec2:=0

If lTotPerICM
	aTamNotas[4]:=Max(aTamNotas[4],nLinNec)
	nLinNec2:=nLinNec2+aTamNotas[4]
Endif
If lTotPerIPI
	aTamNotas[5]:=Max(aTamNotas[5],nLinNec)
	nLinNec2:=nLinNec2+aTamNotas[5]
Endif

If lTotPerICM.or.lTotPerIPI
	nLinNec:=nLinNec2
	If nLimPag<=nLin+nLinNec
		R932Transp()
	Endif
	If nTipoMov==1

		aObs:={}

		R932IniGrade()

		If lTotPerICM
			aObs:=LivrArrayObs(nLargObs,aTotPerICM)
			aGrade[1,2]:=aTotPerICM[ColF3("F3_BASEICM")]
			aGrade[1,3]:=aTotPerICM[ColF3("F3_VALICM")]
			aGrade[2,2]:=aTotPerICM[ColF3("F3_ISENICM")]
			aGrade[3,2]:=aTotPerICM[ColF3("F3_OUTRICM")]
		Endif
		If lTotPerIPI
			IF cMV_ESTADO != "SP" .OR. lCat21
				aGrade[4,2]:=aTotPerIPI[ColF3("F3_BASEIPI")]
				aGrade[4,3]:=aTotPerIPI[ColF3("F3_VALIPI")]
				aGrade[5,2]:=aTotPerIPI[ColF3("F3_ISENIPI")]
				aGrade[6,2]:=aTotPerIPI[ColF3("F3_OUTRIPI")]
			ENDIF
		Endif
		aDados:=ARRAY(16)
		nTamTotPer:=nLin

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Linhas de detalhe              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cICM:="ICMS"
		cIPI:="IPI"
		nVlContICM:=aTotPerICM[ColF3("F3_VALCONT")]
		nVlContIPI:=aTotPerIPI[ColF3("F3_VALCONT")]

		lImprime:=.F.
		For nx:=1 to Len(aGrade)
			If !lImpZer.and.(aGrade[nx,2]+aGrade[nx,3])==0
				Loop
			Endif
			If nx<=3.and.!Empty(cICM)
				aDados[6]:="TOTAL DO PERIODO "
				aDados[8]:=nVlContICM
				aDados[11]:=cICM
				cICM:=NIL
				lImprime:=.T.
			Endif
			If nx>3.and.!Empty(cIPI)
				aDados[6]:="TOTAL DO PERIODO "
				aDados[8]:=nVlContIPI
				aDados[11]:=cIPI
				cIPI:=NIL
				lImprime:=.T.
			Endif
			aDados[12]:=aGrade[nx,1]
			aDados[13]:=aGrade[nx,2]
			aDados[15]:=If(aGrade[nx,3]>0,aGrade[nx,3],NIL)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Coluna de Observacoes ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lImprime
				R932LoadObs()
				FmtLin(@aDados,If(!lTotGrade,aL[17],aL[18]),cPictVl,,@nLin)
			Endif
		Next nx

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0.and.lTotPerICM
			R932LoadObs()
			If nPosObs>0
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			Endif
		End

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTotPerICM
			If !Empty(cTitLivro) .and. aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
				aDados[11]:="ICMS"
				aDados[12]:="ST"
				aDados[13]:=aTotMes[ColF3("F3_BASERET")]
				If nColuna ==1
					aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				ElseIf nColuna == 2
					aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
				ElseIf nColuna == 3
					If aTotMes[ColF3("F3_TIPO")] == "D"
						aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
					Else
						aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
					Endif
				EndIf
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			ElseIf nColuna ==2 .and. aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
				aDados[11]:="ICMS"
				aDados[12]:="ST"
				aDados[13]:=aTotMes[ColF3("F3_BASERET")]
				aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			ElseIf nColuna ==3 .and. aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]>0
				aDados[11]:="ICMS"
				aDados[12]:="ST"
				aDados[13]:=aTotMes[ColF3("F3_BASERET")]
				If aTotMes[ColF3("F3_TIPO")] == "D"
					aDados[15]:=aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")]
				Else
					aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aTotMes[ColF3("F3_ICMSRET")]-aTotMes[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			Endif
		Endif
		If lTotPerICM
			nLinNec:=nLin-nTamTotPer
			aTamNotas[4]:=Max(aTamNotas[4],nLinNec)
		Endif
		If lTotPerIPI
			nLinNec:=nLin-nTamTotPer
			aTamNotas[5]:=Max(aTamNotas[5],nLinNec)
		Endif
		FmtLin(@aDados,aL[18],,,@nLin)
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lTotPerIcm
			nTamTotPer:=nLin
			aObs:=LivrArrayObs(nLargObs,aTotPerICM)
			aDados:=ARRAY(14)
			aDados[3]:="TOTAL DO PERIODO"
			aDados[6]:=aTotPerICM[ColF3("F3_VALCONT")]
			aDados[9]:=aTotPerICM[ColF3("F3_BASEICM")]
			aDados[11]:=aTotPerICM[ColF3("F3_VALICM")]
			aDados[12]:=aTotPerICM[ColF3("F3_ISENICM")]
			aDados[13]:=aTotPerICM[ColF3("F3_OUTRICM")]

			R932LoadObs()
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)

			nPosObs:=Ascan(aObs,{|x|x[2]})
			While nPosObs>0
				R932LoadObs()
				If nPosObs>0
					FmtLin(@aDados,aL[20],cPictVl,,@nLin)
				Endif
			End
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Atender legislacao Fomentar de GO³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !Empty(cTitLivro) .and. aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")]>0
				aDados[8]:="ST"
				aDados[9]:=aTotPerICM[ColF3("F3_BASERET")]
				If nColuna ==1
					aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				ElseIf nColuna == 2
					aDados[11]:=aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")]
				ElseIf nColuna == 3
					If aTotPerICM[ColF3("F3_TIPO")] == "D"
						aDados[11]:=aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")]
					Else
						aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
					Endif
				EndIf
				FmtLin(@aDados,aL[20],cPictVl,,@nLin)
			Elseif nColuna==2 .and. aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")]>0
				aDados[8]:="ST"
				aDados[9]:=aTotPerICM[ColF3("F3_BASERET")]
				aDados[11]:=aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")]
				FmtLin(@aDados,aL[20],cPictVl,,@nLin)
			Elseif nColuna==3 .and. aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")]>0
				aDados[8]:="ST"
				aDados[9]:=aTotPerICM[ColF3("F3_BASERET")]
				If aTotPerICM[ColF3("F3_TIPO")] == "D"
					aDados[11]:=aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")]
				Else
					aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aTotPerICM[ColF3("F3_ICMSRET")]-aTotPerICM[ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
				FmtLin(@aDados,aL[20],cPictVl,,@nLin)
			EndIf
			FmtLin(@aDados,aL[20],,,@nLin)

			nLinNec:=nLin-nTamTotPer
			aTamNotas[4]:=Max(aTamNotas[4],nLinNec)
		Endif
	Endif
	If lTotPerICM.Or.!(Month(dDia)==Month(dDiaAnt))
		For nCntFor := 1 to Len(aTotPerICM)
			If ValType(aTransp[nCntFor]) == "N"
				aTotPerICM[nCntFor] := 0
			Else
				aTotPerICM[nCntFor] := "NULL"
			Endif
		Next
		nSvApurICM:=DefPeriodo(dDia,nApurICM)
	Endif
	If lTotPerIPI.Or.!(Month(dDia)==Month(dDiaAnt))
		For nCntFor := 1 to Len(aTotPerIPI)
			If ValType(aTotPerIPI[nCntFor]) == "N"
				aTotPerIPI[nCntFor] := 0
			Else
				aTotPerIPI[nCntFor] := "NULL"
			Endif
		Next
		nSvApurIPI:=DefPeriodo(dDia,nApurIPI)
	Endif
Endif
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932ResCfo³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo por CFO                                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932ResCfo
Local i	:=0

If (Len(aResCFO)==0 .Or. !(lTotPerIcm .Or. lTotPerIPI)) .And. !Eof()
   If nLin<nLimPag
      R932Filler()
   Endif
   Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena CFOs³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
aResCFO:=Asort(aResCFO,,,{|x,y|x[ColF3("F3_CFO")]<y[ColF3("F3_CFO")]})

aCFOS:={"1.00 ENTRADAS DO ESTADO",;
	"2.00 ENTRADAS DE FORA DO ESTADO",; 
	"3.00 ENTRADAS DO EXTERIOR",;
	"",;
	"5.00 SAIDAS PARA O ESTADO",;
	"6.00 SAIDAS PARA FORA DO ESTADO",;
	"7.00 SAIDAS PARA O EXTERIOR"}

cSvCFO:="X"
If nLin<nLimPag
	R932Filler()
Endif
nLin:=80
For i:=1 to Len(aResCFO)
	If nLin>nLimPag
		R932Cabec()
	EndIf
	aObs:=LivrArrayObs(nLargObs,aResCFO[i])
	cCFO:=Trim(aResCFO[i,ColF3("F3_CFO")])
	If nTipoMov==1

		If i==1
			FmtLin(@aDados,aL[18],,,@nLin)
			aDados[6]:="RESUMO DAS OPERACOES E PRESTACOES POR CODIGO FISCAL"
			FmtLin(@aDados,aL[18],,,@nLin)
			aDados[6]:="==================================================="
			FmtLin(@aDados,aL[18],,,@nLin)
		EndIf

		R932IniGrade()

		aGrade[1,2]:=aResCFO[i,ColF3("F3_BASEICM")]
		aGrade[1,3]:=aResCFO[i,ColF3("F3_VALICM")]
		aGrade[1,4]:=aResCFO[i,ColF3("F3_VALCONT")]
		aGrade[2,2]:=aResCFO[i,ColF3("F3_ISENICM")]
		aGrade[3,2]:=aResCFO[i,ColF3("F3_OUTRICM")]
		IF cMV_ESTADO != "SP" .OR. lCat21
			aGrade[4,2]:=aResCFO[i,ColF3("F3_BASEIPI")]
			aGrade[4,3]:=aResCFO[i,ColF3("F3_VALIPI")]
			aGrade[5,2]:=aResCFO[i,ColF3("F3_ISENIPI")]
			aGrade[6,2]:=aResCFO[i,ColF3("F3_OUTRIPI")]
		ENDIF
		aDados:=ARRAY(16)
		If !(Substr(cCFO,1,1)==cSvCFO).and.!(ALLTRIM(cCFO)$"TTT") .And. !Empty (cCfo)
			If (nLin+3)>nLimPag
				R932Filler()
				R932Cabec()
			EndIf
			FmtLin(@aDados,aL[18],,,@nLin)
			cSvCFO:=Substr(cCFO,1,1)
			aDados[6]:=If(cSvCFO="0",,aCFOS[Val(cSvCFO)])			
			FmtLin(@aDados,aL[18],,,@nLin)
			aDados[6]:=Replic("=",If(cSvCFO="0",3,Len(aCFOS[Val(cSvCFO)])))			
			FmtLin(@aDados,aL[18],,,@nLin)
		Endif
		If ("TT"$cCFO)
			If (nLin+1)>nLimPag
				R932Filler()
				R932Cabec()
			EndIf
			FmtLin(@aDados,aL[18],,,@nLin)
			aDados[6]:=If(ALLTRIM(cCFO)=="TTT","TOTAL","SUB-TOTAL") //###
		Else
			aDados[10]:=TransForm(cCFO,PESQPICT("SF3","F3_CFO"))
		Endif
		aDados[8]:=aResCFO[i,ColF3("F3_VALCONT")]

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Linhas de detalhe              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		R932ImpGrade()

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				If (nLin+1)>nLimPag
					R932Filler()
					R932Cabec()
				EndIf
				FmtLin(@aDados,aL[18],cPictVl,,@nLin)
			Endif
		End
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Para atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro) .and. aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aResCFO[i,ColF3("F3_BASERET")]
			If nColuna ==1
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[15]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aResCFO[i,ColF3("F3_TIPO")] == "D"
					aDados[15]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
				Else
					aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
				Endif
			Endif
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIF nColuna ==2 .and. aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aResCFO[i,ColF3("F3_BASERET")]
			aDados[15]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		ElseIF nColuna ==3 .and. aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]>0
			aDados[11]:="ICMS"
			aDados[12]:="ST"
			aDados[13]:=aResCFO[i,ColF3("F3_BASERET")]
			If aResCFO[i,ColF3("F3_TIPO")] == "D"
				aDados[15]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
			Else
				aDados[16]:="ICMS RETIDO: "+Alltrim(Transform(aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
			Endif
			FmtLin(@aDados,aL[18],cPictVl,,@nLin)
		Endif
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Controla a impressao de CFO's de Saida.³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Val(Substr(cCFO,1,1))<5 .AND. !(ALLTRIM(cCFO)=="TTT")
			Loop
		Endif
		If i==1
			If mv_par27 == 1 .And. nTotIcmDeb > 0
				FmtLin(@aDados,aL[20],,,@nLin)
				aDados[14]:= "ICMS A SER DEBITADO: "+Transform(nTotIcmDeb,PESQPICT("SF3","F3_ICMSRET")) //
				FmtLin(@aDados,aL[20],,,@nLin)
			Endif
			
			FmtLin(@aDados,aL[20],,,@nLin)
			aDados[3]:="RESUMO DAS OPERACOES E PRESTACOES POR CODIGO FISCAL"
			FmtLin(@aDados,aL[20],,,@nLin)
			aDados[3]:="==================================================="
			FmtLin(@aDados,aL[20],,,@nLin)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Cria Array com mensagens a serem impressas na coluna de Observacao³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aDados:=ARRAY(14)

		If !(Substr(cCFO,1,1)==cSvCFO).and.!(ALLTRIM(cCFO)=="TTT")
			If (nLin+3)>nLimPag
				R932Filler()
				R932Cabec()
			EndIf
			FmtLin(@aDados,aL[20],,,@nLin)
			cSvCFO:=Substr(cCFO,1,1)
			aDados[3]:=If(cSvCFO="0",,aCFOS[Val(cSvCFO)])			
			FmtLin(@aDados,aL[20],,,@nLin)
			aDados[3]:=Replic("=",If(cSvCFO="0",3,Len(aCFOS[Val(cSvCFO)])))
			FmtLin(@aDados,aL[20],,,@nLin)
		Endif
		If ("TT"$cCFO)
			If (nLin+1)>nLimPag
				R932Filler()
				R932Cabec()
			EndIf
			FmtLin(@aDados,aL[20],,,@nLin)
			aDados[3]:=If(ALLTRIM(cCFO)=="TTT","TOTAL","SUB-TOTAL") //###
		Else
			aDados[8]:=TransForm(cCFO,PESQPICT("SF3","F3_CFO"))
		Endif
		aDados[6]:=aResCFO[i,ColF3("F3_VALCONT")]
		aDados[9]:=aResCFO[i,ColF3("F3_BASEICM")]
		aDados[11]:=aResCFO[i,ColF3("F3_VALICM")]
		aDados[12]:=aResCFO[i,ColF3("F3_ISENICM")]
		aDados[13]:=aResCFO[i,ColF3("F3_OUTRICM")]
		R932LoadObs()
		If (nLin+1)>nLimPag
			R932Filler()
			R932Cabec()
		EndIf
		FmtLin(@aDados,aL[20],cPictVl,,@nLin)

		nPosObs:=Ascan(aObs,{|x|x[2]})
		While nPosObs>0
			R932LoadObs()
			If nPosObs>0
				If (nLin+1)>nLimPag
					R932Filler()
					R932Cabec()
				EndIf
				FmtLin(@aDados,aL[20],cPictVl,,@nLin)
			Endif
		End
		If (nLin+1)>nLimPag
			R932Filler()
			R932Cabec()
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atender legislacao Fomentar de GO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cTitLivro) .and. aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aResCFO[i,ColF3("F3_BASERET")]
			If nColuna ==1
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //
			ElseIf nColuna == 2
				aDados[11]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
			ElseIf nColuna == 3
				If aResCFO[i,ColF3("F3_TIPO")] == "D"
					aDados[11]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
				Else
					aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
				Endif
			Endif
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Elseif nColuna ==2 .and. aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aResCFO[i,ColF3("F3_BASERET")]
			aDados[11]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Elseif nColuna ==3 .and. aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]>0
			aDados[8]:="ST"
			aDados[9]:=aResCFO[i,ColF3("F3_BASERET")]
			If aResCFO[i,ColF3("F3_TIPO")] == "D"
				aDados[11]:=aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")]
			Else
				aDados[14]:="ICMS RETIDO: "+Alltrim(Transform(aResCFO[i,ColF3("F3_ICMSRET")]-aResCFO[i,ColF3("F3_OBSSOL")],PESQPICT("SF3","F3_ICMSRET"))) //"ICMS RETIDO: "
			Endif
			FmtLin(@aDados,aL[20],cPictVl,,@nLin)
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Completa preenchimento da folha ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If i==Len(aResCFO)
		If nTipoMov==1
			FmtLin(@aDados,aL[18],,,@nLin)
		Else
			FmtLin(@aDados,aL[20],,,@nLin)
		Endif
		aResCfo:={}
		R932Filler()
	ElseIf nLin+nLinNec>nLimPag
		R932Filler()
	Endif
Next i

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R932ResEst³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Resumo por Estado                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932ResEst

Local lFirstCO:=.T.
Local lFirstNC:=.T.
Local nTotvlrctb:=0
Local nTotvlrbsc:=0
Local nTotimpdeb	:=0
Local nTotisenta	:=0
Local nTotoutras	:=0
Local nTotIcmCre	:=0
Local nTotIPICre	:=0
Local nTotBasIPI	:=0
Local i				:=0
Local j				:=0

If (Len(aResumo)==0 .Or. !(lTotPerIcm .Or. lTotPerIPI)) .And. !Eof()
   Return
Endif

nLin:=80
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Arranja o resumo em ordem de CFO e Estado³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aResumo:=ASort(aResumo,,,{|x,y|x[1]+x[2]<y[1]+y[2]})
For i:=1 to Len(aResumo)
	If nLin>nLimPag
   		If nLin<>80
   			FmtLin({},aL[01],,,@nLin)
   		EndIf
		R932Cabec()
	Endif
	If nTipoMov==1
	   aDados:=ARRAY(17)
	   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³Verifica se deve listar ou nao o estado origem no resumo³
	   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   If (lLisEstOri.Or.(!lLisEstOri.And.cMV_Estado!=aResumo[i,2]))
		  If i==1
			 FmtLin(@aDados,aL[17],,,@nLin)
			 aDados[8]:="DEMONSTRATIVO POR ESTADO DE ORIGEM DA MERCADORIA OU DE INICIO DA PRESTACAO DE SERVICO"
			 FmtLin(@aDados,aL[17],,,@nLin)
			 aDados[8]:="====================================================================================="
			 FmtLin(@aDados,aL[17],,,@nLin)
			 FmtLin(@aDados,aL[17],,,@nLin)
		  Endif
		  aGrade:={}
          
          If mv_par26 == 1
 		     If aResumo[i,4]>0 //Base de Calculo
			    AADD(aGrade,{"1",aResumo[i,4]})
			 Endif
			 If aResumo[i,7]>0 .And. lLisIsenta //ICMS Isentas
			    AADD(aGrade,{"2",aResumo[i,7]})
			 Endif			
			 If aResumo[i,5]>0 //ICMS Outras
			    AADD(aGrade,{"3",aResumo[i,5]})
			 Endif
			 aDados[7]:=aResumo[i,2]  // Estado
			 aDados[8]:=aResumo[i,3]  //Valor Contabil
			 aDados[11]:="ICMS"

             If aResumo[i,8]>0          		//Valor Icms
			    aDados[15] :=aResumo[i,8]
             EndIf
             
             If nModelo == 1
                If aResumo[i,9]>0 				// Base de Calculo IPI
				   aDados[16] :=aResumo[i,9]
			    Endif
			 Endif   
		  Else
 		     If aResumo[i,4]>0 //Base de Calculo
			    AADD(aGrade,{"1",aResumo[i,4]})
			 Endif
			 If aResumo[i,7]>0 .And. lLisIsenta //ICMS Isentas
			    AADD(aGrade,{"2",aResumo[i,7]})
			 Endif			
			 If aResumo[i,5]>0 //ICMS Outras
			    AADD(aGrade,{"3",aResumo[i,5]})
			 Endif
			 aDados[7]:=aResumo[i,2]  // Estado
			 aDados[8]:=aResumo[i,3]  //Valor Contabil
			 aDados[11]:="ICMS"
		  Endif
			   
		  If aResumo[i,6]>0 .and. nColuna ==1  //ICMS Retido
			 aDados[16]:="Icms Retido "+Alltrim(Transform(aResumo[i,6],PESQPICT("SF3","F3_ICMSRET")))
		  Endif         
			
		  //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄX¿
          //³criar totalizador de resumo por estado. quando o parametro  mv_par24 for sim ³
          //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄXÙ

		  If MV_PAR25 == 1                
     		 nTotvlrctb:= nTotvlrctb + aResumo[i,3] //Valor Contabil
     		 
		     If aResumo[i,4]>0 //Base de Calculo
			 	nTotvlrbsc +=	aResumo[i,4]
		   	 Endif
             If aResumo[i,7]>0 .And. lLisIsenta //ICMS Isentas
                  nTotvlrbsc +=	aResumo[i,7]
             EndIf
             If aResumo[i,5]>0 //ICMS Outras
			 	 nTotvlrbsc +=	aResumo[i,5]
		     Endif
	    	 If mv_par26 == 1
			    nTotIcmCre	+=aResumo[i,08] //Total Icm Creditado
			    nTotIPICre	+=aResumo[i,10] //Total Ipi Creditado
			    nTotBasIPI	+=aResumo[i,09] //Base de Calculo IPI
	    	 Endif
	 	  Endif 
		  
		  if Len(aGrade)>0
			 For j:=1 to Len(aGrade)
				 aDados[12]:=aGrade[j,1]
				 aDados[13]:=aGrade[j,2]
				 FmtLin(@aDados,aL[17],cPictVl,,@nLin)
			 Next j
		  Else
			 FmtLin(@aDados,aL[17],cPictVl,,@nLin)
		  EndIf	
		  If aResumo[i,13]>0 .and. nColuna ==1   //ICMS NORMAL
			  aDados[16]:="ICMS NORMAL"+Alltrim(Transform(aResumo[i,13],PESQPICT("SF3","F3_OBSICM")))
			  FmtLin(@aDados,aL[17],cPictVl,,@nLin)
		  Endif			
		  If aResumo[i,14]>0 .and. nColuna ==1   //ICMS ST. INT.
			  aDados[16]:="ICMS ST. INT."+Alltrim(Transform(aResumo[i,14],PESQPICT("SF3","F3_OBSSOL")))
			  FmtLin(@aDados,aL[17],cPictVl,,@nLin)
		  EndIf	
		  If aResumo[i,15]>0 .and. nColuna ==1   //CRED. PRES. ST
			aDados[16]:="CRED. PRES. ST "+Alltrim (Transform (aResumo[i,15], PESQPICT("SF3","F3_CRPRST")))
			FmtLin(@aDados,aL[17],cPictVl,,@nLin)
		  Endif
	   Endif
	Else
	   aDados:=ARRAY(14)
	   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³Verifica se deve listar ou nao o estado origem no resumo³
	   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   If (lLisEstOri.Or.(!lLisEstOri.And.cMV_Estado!=aResumo[i,2]))
		  If i==1
			 FmtLin(@aDados,aL[19],,,@nLin)
			 aDados[7]:="DEMONSTRATIVO POR ESTADO DE DESTINO DA MERCADORIA OU DA PRESTACAO DE SERVICO"
			 FmtLin(@aDados,aL[19],,,@nLin)
			 aDados[7]:="============================================================================"
			 FmtLin(@aDados,aL[19],,,@nLin)
			 FmtLin(@aDados,aL[19],,,@nLin)
		  Endif
		  If lFirstCO.and.aResumo[i,1]=="CO"
			 lFirstCO:=.F.
			 aDados[9]:="OPERACOES REALIZADAS COM CONTRIBUINTES"
			 FmtLin(@aDados,aL[19],,,@nLin)
			 aDados[9]:="======================================"
			 FmtLin(@aDados,aL[19],,,@nLin)
		  Endif
		  If lFirstNC.and.aResumo[i,1]=="NC"
			 lFirstNC:=.F.
			 aDados[9]:="OPERACOES REALIZADAS COM NAO CONTRIBUINTES"
			 FmtLin(@aDados,aL[19],,,@nLin)
			 aDados[9]:="=========================================="
			 FmtLin(@aDados,aL[19],,,@nLin)
		  Endif
		  If mv_par26 == 1
		     aDados[05]:=aResumo[i,2]
		     aDados[06]:=aResumo[i,3]
		     aDados[09]:=aResumo[i,4]            
		     aDados[11]:=aResumo[i,8]
		     aDados[12]:=aResumo[i,7]
		     aDados[13]:=aResumo[i,5]            
		  Else
		     aDados[5]:=aResumo[i,2]
		     aDados[6]:=aResumo[i,3]
			 aDados[9]:=aResumo[i,4]            
		  Endif   

		  If aResumo[i,6]>0 .and. nColuna ==1
		     aDados[14]:="Icms Retido "+Alltrim(Transform(aResumo[i,6],PESQPICT("SF3","F3_ICMSRET"))	)
		  Endif
			
          If mv_par25 == 1                
   	 	     nTotvlrctb +=aResumo[i,3] //Valor Contabil
	         nTotvlrbsc +=aResumo[i,4] //Base de Calculo
             If mv_par26 == 1
   	 	        nTotimpdeb +=aResumo[i,8] //Imposto Debitado
	            nTotisenta +=aResumo[i,7] //Coluna Isentas
   	 	        nTotoutras +=aResumo[i,5] //Coluna Outras
   	 	     Endif   
     	  Endif 
			FmtLin(@aDados,aL[19],cPictVl,,@nLin)
		Endif
		If aResumo[i,13]>0 .and. nColuna ==1   //ICMS NORMAL
			aDados[14]:="ICMS NORMAL "+Alltrim(Transform(aResumo[i,13],PESQPICT("SF3","F3_OBSICM")))
			FmtLin(@aDados,aL[19],cPictVl,,@nLin)
		Endif			
		If aResumo[i,14]>0 .and. nColuna ==1   //ICMS ST. INT.
		    aDados[14]:="ICMS ST. INT."+Alltrim(Transform(aResumo[i,14],PESQPICT("SF3","F3_OBSSOL")))
		    FmtLin(@aDados,aL[19],cPictVl,,@nLin)
	   Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Completa preenchimento da folha ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If i==Len(aResumo)

	   IF nTipoMov == 2  .AND. MV_PAR25 == 1
          aDados[03]:="TOTAL"
          aDados[06]:=nTotvlrctb		//TOTAL Valor Contabil
          aDados[09]:=nTotvlrbsc		//TOTAL Base de Calculo
          If mv_par26 == 1
	         aDados[11]:=nTotimpdeb		//Imposto Debitado
		     aDados[12]:=nTotisenta		//Coluna Isentas
			 aDados[13]:=nTotoutras		//Coluna Outras
		  Endif   
          FmtLin(@aDados,aL[19],cPictVl,,@nLin)
       ELSE 
          IF nTipoMov==1 .AND. MV_PAR25 == 1
             aDados[5]		:="TOTAL"
             aDados[8]		:=	 nTotvlrctb //TOTAL Valor Contabil
             aDados[13]	:=	 nTotvlrbsc //TOTAL Base de Calculo
         	 If mv_par26 == 1
	   	        aDados[15]	:= nTotIcmCre
	   	     	If nModelo == 1
		     	   aDados[16]	:= nTotIPICre
		     	Endif   
		   	 Endif   

             FmtLin(@aDados,aL[17],cPictVl,,@nLin)
          ENDIF
       ENDIF                    
	   R932Filler()
	Endif
Next i
aResumo:={}
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R932LoadObs³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Carrega observacao para ser impressa                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932LoadObs

nPosObs:=Ascan(aObs,{|x|x[2]})
If nPosObs>0
	aDados[If(nTipoMov==1,16,14)]:=aObs[nPosObs,1]
	aObs[nPosObs,2]:=.F.
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R932Totais ³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Aciona funcoes de totalizacao                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932Totais(nSvApurIcm,nSvApurIpi)
R932Transp()
If lTotalDia
	R932TotDia()
Endif

lTotPerICM:=(nSvApurICM!=DefPeriodo(dDia,nApurICM)) .Or. IIf(nApurIcm==3,Month(dDia)!=Month(dDiaAnt),.F.)
lTotPerIPI:=(nSvApurIPI!=DefPeriodo(dDia,nApurIPI)) .Or. IIf(nApurIpi==3,Month(dDia)!=Month(dDiaAnt),.F.)
lTotMes:=(Month(dDiaAnt)!=Month(dDia))

R932TotPer(@nSvApurIcm,@nSvApurIpi)
R932TotMes()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lTotMes
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resumo por CFO ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932ResCfo()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Resumo por Estado ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932ResEst()
Endif                   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Termo de Encerramento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
R932TermEnc()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R932TermIni³Autor ³ Rodrigo de A. Sartorio³ Data ³ 25.03.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime termo de abertura no caso de so listar termos      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932TermIni()
nPagina:=1
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime Termos de Abertura/Encerramento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aPagTerm:=CtrlPg(@nPagina,nQtFeixe,lReiniPg)
cPagina :=Transform(StrZero(nPagina,6),"@R 999.999")
If (nImpTerm == 2 .Or. nImpTerm == 3).and.aPagTerm[1]+aPagTerm[2]>0
	If nTipoMov==1
		ImprimeTermo(aPagTerm[1],nPagIni,nQtFeixe,GetMv("MV_LENTEN"),nLargMax,cPerg)
		nPagIni:=ImprimeTermo(aPagTerm[2],nPagIni,nQtFeixe,GetMv("MV_LENTAB"),nLargMax,cPerg)
	Else
		ImprimeTermo(aPagTerm[1],nPagIni,nQtFeixe,GetMv("MV_LSAIEN"),nLargMax,cPerg)
		nPagIni:=ImprimeTermo(aPagTerm[2],nPagIni,nQtFeixe,GetMv("MV_LSAIAB"),nLargMax,cPerg)
	Endif
Endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R932TermEnc³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime termo de encerramento no fim do relatorio          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932TermEnc
If ((Eof().Or.!lHouveMov).and. nImpTerm == 3) .Or. (nImpTerm == 2)
	If nTipoMov==1
		ImprimeTermo(nPagina,nPagIni,nQtFeixe,GetMv("MV_LENTEN"),nLargMax,cPerg)
	Else
		ImprimeTermo(nPagina,nPagIni,nQtFeixe,GetMv("MV_LSAIEN"),nLargMax,cPerg)
	Endif
Endif
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R932Filler ³Autor ³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Preenche folha com linha vazias                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932Filler
IF nLin<67
    While nLin<=nLimPag
	    FmtLin(@aDados,If(nTipoMov==1,aL[17],aL[19]),,,@nLin)
    End                       
    If nLin>=nLimPag
        FmtLin(@aDados,aL[1],,,@nLin)
    ENdif   
ENDIF
Return
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R932IniGrade³Autor³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Inicializa array aGrade do registro de entradas            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932IniGrade
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta grade de impressao            ³
//³ [1]=Codigo de Operacao de ICMS/IPI  ³
//³ [2]=Base de Calculo/Isentas/ Outras ³
//³ [3]=Valor do ICMS / IPI             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF cMV_ESTADO == "SP" .And. !lCat21
	aGrade:={{"1",0,0,0},{"2",0,0,0},{"3",0,0,0}}   	// ICMS
ELSE
	aGrade:={{"1",0,0,0},{"2",0,0,0},{"3",0,0,0},;   	// ICMS
			{"1",0,0,0},{"2",0,0,0},{"3",0,0,0}}	  	// IPI
ENDIF
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³R932ImpGrade³Autor³ Juan Jose Pereira     ³ Data ³ 23.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime aGrade do registro de entradas                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R932ImpGrade
Local lImprimiu :=.F.
Local nX		:=0
cICMS:="ICMS"
cIPI :="IPI"
For nx:=1 to Len(aGrade)
	If !lImpZer.and.((aGrade[nx,2]+aGrade[nx,3]+aGrade[nx,4])==0 .Or. (aGrade[nx,2]+aGrade[nx,3]+aGrade[nx,4])==aGrade[nx,4])
		Loop
	Endif
	lImprimiu:=.T.
	If nx<=3
		aDados[11]:=cICMS
		cICMS:=NIL
	Else
		aDados[11]:=cIPI
		cIPI:=NIL
	Endif
	aDados[12]:=aGrade[nx,1]
	aDados[13]:=aGrade[nx,2]
	aDados[15]:=If(aGrade[nx,3]>0,aGrade[nx,3],NIL)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Coluna de Observacoes ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932LoadObs()
	FmtLin(@aDados,If(!lTotGrade,aL[17],aL[18]),cPictVl,,@nLin)
Next nx

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime itens com lancamento no livro fiscal zerado   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lImprimiu .And. !Empty(aDados[1]) .And. F3_VALCONT>0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Coluna de ICMS        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aDados[11]:=cICMS
	cICMS:=NIL

	aDados[12]:="1"
	aDados[13]:=0
	aDados[15]:=0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Coluna de Observacoes ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932LoadObs()
	FmtLin(@aDados,If(!lTotGrade,aL[17],aL[18]),cPictVl,,@nLin)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Coluna de IPI         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aDados[11]:=cIPI
	cIPI:=NIL

	aDados[12]:="1"
	aDados[13]:=0
	aDados[15]:=0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Coluna de Observacoes ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	R932LoadObs()
	FmtLin(@aDados,If(!lTotGrade,aL[17],aL[18]),cPictVl,,@nLin)
Endif

Return
