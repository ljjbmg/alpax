#Include "Protheus.ch"

//STATIC aColunas // Utilizada na Funcao ColF3
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³FUNCAO    ³ MATR930  ³ Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³DESCRICAO ³ Imprime Registro de Entadas P1 P1A e Saidas P2 P2A           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Marcos Simidu³14/09/98³09795A³ Considerar data de emissao na impressao  ³±±
±±³              ³14/09/98³09795A³ de NF entrada no livro de saida.         ³±±
±±³ Marcos Simidu³23/09/98³XXXXXX³ Acertos NF form prop nos livros de saida.³±±
±±³ Marcos Simidu³11/11/98³XXXXXX³ Impressao dos parametros de data nos     ³±±
±±³              ³11/11/98³XXXXXX³ termos de abertura/encerramento.         ³±±
±±³ Andreia      ³27/01/99³18598A³ Tratamento do no. de registros impressos ³±±
±±³              ³        ³      ³ quando for nota de servico.              ³±±
±±³ Andreia      ³11/03/99³xxxxxx³Tratamento da especie das notas fiscais   ³±±
±±³              ³        ³      ³canceladas atraves do parametro MV_ESPECIE³±±
±±³ Andreia      ³15/06/99³xxxxxx³Acertos Protheus.                         ³±±
±±³ Andreia      ³09/08/99³22553A³ Criacao de pergunta para escolher se o im³±±
±±³              ³        ³      ³ posto retido sera impresso na coluna "OB-³±±
±±³              ³        ³      ³ SERVACAO" ou na coluna "Tributado"       ³±±
±±³              ³        ³      ³ (mv_par21).              			    ³±±
±±³ Andreia      ³04/10/99³23914A³ Funcao EXISTNF() - Acerto na verificacao ³±±
±±³              ³        ³      ³ de notas fiscais canceladas.             ³±±
±±³ Andreia      ³08/10/99³xxxxxx³ Tratamento da variavel nColuna na funcao ³±±
±±³              ³        ³      ³ LivrArrayObs, quando e emitido o relato- ³±±
±±³              ³        ³      ³ rio MATR920.                             ³±±
±±³ Edilaine     ³01/06/00³003880³ Tratamento de variavel CTIPO. Funcao     ³±±
±±³              ³        ³      ³ LivrAcumula()                            ³±±
±±³ Andre Veiga  ³05/05/01³008831³ Escrituracao do Mapa Resumo ECF (Portaria³±±
±±³              ³        ³      ³ CAT 55/98, Conv.ICMS 50/00)              ³±±
±±³ Denis Martins³20/09/01³Melhor³ Tratamento de Filiais(Exc/Comp.)-F3_MSFIL³±±
±±³ Machima      ³09/06/06³100780³ Implementacao do decreto 22.928/02 art.1 ³±±
±±³ Danilo Calil ³18/08/07³108982³ Realizado tratamento para apresentacao do³±±
±±³              ³        ³      ³ livro fiscal de saida, de acordo com a   ³±±
±±³              ³        ³      ³ nova geracao do SF3 no modulo do SIGALOJA³±±
±±³              ³        ³      ³ Criada as funcoes Mtr930Resumo e         ³±±
±±³              ³        ³      ³ Mtr930PerAliq para tratamento dos registr³±±
±±³              ³        ³      ³ de Mapa Resumo.                          ³±±
±±³ Danilo Calil ³12/09/07³131472³ Executa as funcoes genericas do fonte    ³±±
±±³              ³        ³      ³ MATXRMP para apresentacao das informacoes³±±
±±³              ³        ³      ³ do Mapa Resumo, quando a pergunta "Impri-³±±
±±³              ³        ³      ³ me Mapa Resumo" igual a "Sim" e o para-  ³±±
±±³              ³        ³      ³ metro MV_LJLVFIS = 2.                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RFIS001()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnRel	  :="MATR930"
Titulo    :="Regime de Processamento de Dados"
cDesc1    :="Emiss„o dos Registros de Entradas modelos P1 e P1A e Registros de Saidas"
cDesc2    :="modelos P2 e P2A."
cDesc3    :="Ir  imprimir os lan‡amentos fiscais conforme os parƒmetros informados."
aReturn   :={ "Zebrado", 1,"Administra‡„o", 2, 2, 1, "",1 }
nomeprog  :="RFIS001"
cPerg	  :="MTR930"
cString	  :="SF3"
nPagina	  :=0
nLin	  :=3
nLargMax  :=220
Tamanho	  :="G"
cArqTemp  :=""
dbSelectArea("SF3")
dbSetOrder(1)
aSvArea	  :={Alias(),IndexOrd(),Recno()}
nPosObs	  :=0
aOrd	  :={"Data de Entrada+Série+Número da NFE","Data de Entrada+Número da NFE+Série"}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas no cabecalho     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aMeses	  :={"JANEIRO","FEVEREIRO","MARCO","ABRIL","MAIO","JUNHO","JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}
cNome 	  :=SM0->M0_NOMECOM
cInscr	  :=InscrEst()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o campo "CGC" nao esta sendo utilizado para armazenar outro tipo de informacao.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SM0->M0_TPINSC == 2 .Or. SM0->M0_TPINSC == 0
	cCGC  :=TRANSFORM(SM0->M0_CGC,"@R 99.999.999/9999-99")
Else
	cCGC  :=""	
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa grupo de perguntas.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()
Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLastKey  :=0
wnrel	  :=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)
If nLastKey==27
	dbClearFilter()
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey==27
	dbClearFilter()
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa relatorio                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RptStatus({|lEnd| R930Imp(@lEnd,wnRel,cString,Tamanho)},titulo)

If aReturn[5]==1
	Set Printer To
	ourspool(wnrel)
Endif
MS_FLUSH()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R930Imp  ³ Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Relatorio                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R930Imp(lEnd,wnRel,cString,Tamanho)

LOCAL 	lMatr931:=(existblock("MATR931"))
LOCAL 	lMatr932:=(existblock("MATR932"))
Local	cIndxSF3	:=""
Local	cChave		:=""
Local	aRegSF3     :={}
Local	cIndxSF3b	:=""
Private cArqSF3		:=""
PRIVATE lAbortPrint:=.F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Parametros utilizados pelo Programa                          ³
//³ mv_par01 - A partir da Data                                  ³
//³ mv_par02 - Ate a Data                                        ³
//³ mv_par03 - Imprime Modelo                                    ³
//³ mv_par04 - Imprime  (1) Livros (2) Termos (3) Livros e Termos³
//³ mv_par05 - Numero do Livro                                   ³
//³ mv_par06 - Numero da Pagina Inicial                          ³
//³ mv_par07 - Qtd. Paginas do Feixe                             ³
//³ mv_par08 - Reinicia Paginas                                  ³
//³ mv_par09 - Considera lacuna                                  ³
//³ mv_par10 - Apuracao de ICMS                                  ³
//³ mv_par11 - Apuracao de IPI                                   ³
//³ mv_par12 - Livro Selecionado                                 ³
//³ mv_par13 - Destaca NFs. de Servicos                          ³
//³ mv_par14 - Destaca descontos                                 ³
//³ mv_par15 - Imprime Linhas sem valor                          ³
//³ mv_par16 - Imprime Total Mensal                              ³
//³ mv_par17 - Imprime NF. de Entrada                            ³
//³ mv_par18 - Aglutina NF                                       ³
//³ mv_par19 - Totaliza por dia - Sim X Nao                      ³
//³ mv_par20 - Estado Origem no Resumo - Sim X Nao               ³  
//³ mv_par25 - Totalizar resumo estado ? Sim X Nao               ³
//³ mv_par29 - Resumo do Produtor Rural no P1A                   ³
//³ mv_par30 - Cupom Fiscal? Sim X Nao                           ³
//³ mv_par31 - Processa filiais                                  ³
//³ mv_par32 - Filial de                                         ³
//³ mv_par33 - Filial ate                                        ³
//³ mv_par35 - Taxa UFIR                                         ³
//³ mv_par36 - "Operações a imprimir?"                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE dDtIni		:= mv_par01
PRIVATE dDtFim		:= mv_par02
PRIVATE cMV_ESTADO  := GetMv("MV_ESTADO")
PRIVATE nModelo  	:= mv_par03
PRIVATE nImpTerm 	:= mv_par04
PRIVATE cLivro		:= mv_par05
PRIVATE nPagIni     := mv_par06
PRIVATE nPagAnt	    := IIf(nImpTerm<>2,mv_par06,1)
PRIVATE nQtFeixe	:= mv_par07
PRIVATE lReiniPg	:= (mv_par08==1)
PRIVATE lLacuna 	:= (mv_par09==1 .Or. mv_par09==3)
PRIVATE nApurICM	:= mv_par10
PRIVATE nApurIPI	:= mv_par11
PRIVATE cNrLivro	:= mv_par12
PRIVATE lServico	:= (mv_par13==1)
PRIVATE lDesconto	:= (mv_par14==1)
PRIVATE lImpZer		:= (mv_par15==1)
PRIVATE lImpMes   	:= (mv_par16==1)
PRIVATE lEntrada	:= (mv_par17==1)
PRIVATE lAglutina	:= (mv_par18==1)
PRIVATE lTotalDia	:= (mv_par19==1)
PRIVATE lLisEstOri 	:= (mv_par20==1)
PRIVATE nPagina		:= IIf(nPagIni>0,nPagIni-1,1)
PRIVATE cFilterUser := aReturn[7]
PRIVATE nTipoMov	:= If(nModelo==1.or.nModelo==2.or.(nmodelo==5 .And. AllTrim(cMV_ESTADO) == "SP"),1,2)
PRIVATE nColuna 	:= mv_par21
PRIVATE lLisIsenta  := (mv_par22==1)
PRIVATE lEmiteCiap  := (mv_par23==1)
PRIVATE lColCiap    := (mv_par24==1)
PRIVATE lListaNFO   := (mv_par28==1)
PRIVATE lProdutor	:= (mv_par29==1)
PRIVATE lLeiECF		:= (mv_par30==1)
PRIVATE lConsUF		:= (mv_par34==1)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recebe parametros ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE lCat21		 :=GetNewPar("MV_CAT21",.F.)
PRIVATE cContaContab :=NIL
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Limite da pagina em linhas³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nLin	     :=80
PRIVATE	nLimPag	     :=58
PRIVATE	nLinNec	     :=0

nQtFeixe	:=IIf(nQtFeixe>3,nQtFeixe,500)

If nPagAnt==0
	nPagina:=0
Endif

If nTipoMov==1
	cContaContab:=Alltrim(GetMV("MV_CTALFE"))
	// Retira ref. ao Alias SF3 //
	cContaContab	:=	StrTran(cContaContab,"SF3->",)
Else
	cContaContab:=Alltrim(GetMV("MV_CTALFS"))
	// Retira ref. ao Alias SF3 //
	cContaContab	:=	StrTran(cContaContab,"SF3->",)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena maior tamanho das notas (em linhas)³
//³ [1]=Maior Nota da Pagina                    ³
//³ [2]=Maior Totalizacao de Transporte         ³
//³ [3]=Maior Totalizacao do Dia                ³
//³ [4]=Maior Totalizacao de Periodo ICM        ³
//³ [5]=Maior Totalizacao de Periodo IPI        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE nTamNota	:=0
PRIVATE nTamTransp	:=0
PRIVATE nTamPerICM	:=0
PRIVATE nTamPerIPI	:=0 
PRIVATE aTamNotas	:={0,0,0,0,0}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Especifico para os legislacao Fomentar de Goias ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cTitLivro :=AvalFomentar()
cTitLivro         :=If(Empty(cTitLivro)," ",cTitLivro)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Totalizadores ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aTotDia 	:=	NIL	// Totalizador diario
PRIVATE aTotPerICM  :=	NIL	// Totalizador de periodos de apuracao de ICMS
PRIVATE aTotPerIPI  :=	NIL	// Totalizador de periodos de apuracao de IPI
PRIVATE aTransp	    :=	NIL	// Totalizador de transporte de pagina
PRIVATE aTotMes	    :=	NIL	// Totalizador Mensal
PRIVATE aResumo	    :=	NIL	// Totalizador para resumo final
PRIVATE aResCFO	    :=	NIL	// Totalizador para resumo por CFO
PRIVATE nTotIcmDeb  :=  0  // Totalizador de ICMS NORMAL+ICMS ST 
PRIVATE LNFINUTIL   := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo Temporario para Controle de Contribuintes e Nao Contribuintes ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aRegSF3,{"CHAVE"	,"C",100,0})
AADD(aRegSF3,{"CONTR"	,"C",01,0})
AADD(aRegSF3,{"FILIAL"	,"C",02,0})
AADD(aRegSF3,{"MES"		,"C",02,0})
AADD(aRegSF3,{"ANO"		,"C",04,0})
cArqSF3  :=CriaTrab(aRegSF3)
dbUseArea(.T.,,cArqSF3,cArqSF3,.T.,.F.)
cIndxSF3 :=Substr(CriaTrab(NIL,.F.),1,7)+"A"
cChave:="CONTR+CHAVE"
IndRegua(cArqSF3,cIndxSF3,cChave,,,"Criando Controles") 
dbClearIndex()
cIndxSF3b := CriaTrab(Nil,.F.)
IndRegua(cArqSF3,cIndxSF3b,"CONTR+MES+ANO")
dbClearIndex()
dbSetIndex(cIndxSF3+OrdBagExt())
dbSetIndex(cIndxSF3b+OrdBagExt())
                                                          

If nModelo==1 .or. nModelo==3 .or. nModelo==5
	If lMatr931
		ExecBlock("MATR931",.F.,.F.)
	Else
		Matr931()
	Endif
Else           
	U_RMATR932()
	/*
	If lMatr932
		ExecBlock("MATR932",.F.,.F.)
	Else
		Matr932()
	Endif
	*/
Endif

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                              ³
//³           FUNCOES GENERICAS DOS LIVROS FISCAIS               ³
//³                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³EmiteLivro³ Autor ³ Juan Jose Pereira             ³ Data ³ 13/12/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo temporario com lancamentos do SF3 que deverao ser      ³±±
±±³          ³ser lancados nos registros de entradas e saidas                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³cArqTemp:=EmiteLivro(cMov,cDtIni,dDtFim,lLacuna,lServico,cNrLivro,  ³±±
±±³          ³          cFiltroUser)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³parametros³cArqTemp:=Alias/Nome do Arquivo gerado                              ³±±
±±³          ³cMov:="E"ntradas / "S"aidas                                         ³±±
±±³          ³dDtIni:=Data de Inicio dos Lancamentos                              ³±±
±±³          ³dDtFim:=Data de Fim dos Lancamentos                                 ³±±
±±³          ³lLacuna:=Lanca notas canceladas/nao lancadas/excluidas              ³±±
±±³          ³lServico:=Lanca notas de Servico                                    ³±±
±±³          ³cNrLivro:=Numero do Livro lancado , (*) Todos - FOMENTAR            ³±±
±±³          ³cFiltroUser:=Filtro criado pelo usuario para o SF3                  ³±±
±±³          ³cArqCiap:=Arquivo Ciap                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function EmiteLivro(	cMov	,	dDtIni	,	dDtFim	,	lLacuna	,	;
						lServico,lDesconto	,cNrLivro	,cFilterUser,	;
						cArqCiap,nTotIcmsEnt,nLacuna	,nProcFil	,	;
						cFilDe	,cFilAte	,nSubDiv	,cChamOrig		)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aCampos     :={}
Local aLivro      :={}
Local aFixos      :=MatXAfixos()
Local aSeries     :={}
Local cCliente    :=""
Local cLoja       :=""
Local cFiltro     :=""
Local cChave	  :=""
Local cArqIndxF3  :=""
Local cIndxTemp1  :=""
Local cIndxTemp2  :=""
Local cLivros     :=""
Local cLivrEP     :=GetMV("MV_LIVRESP")
Local cNFIni      :=""
Local cNFFim      :=""
Local cEst        :=""
Local cEsp        :=""
Local i           :=0
Local j           :=0
Local nPos        :=0
Local nI          :=0
Local nx          :=0
Local nReg        :=0
Local dDtCanc     :=""
Local dDtCan1     :=""
Local lCanc       :=.F.
Local nAliq       :=0
Local cSer		  :=""	
Local cCFO        :=""
Local cFormula	  :=""
Local lExist      :=.T.
Local aProdutor	  := {}
Local nSf3			:=	0
Local aStruSf3		:=	{}
Local cCampos		:=	""
Local	cAliasSf3	:=	"SF3"
Local	nF3FCount	:=	0
Local aProcessa		:= {}
Local nMesIni		:= 0
Local nAnoIni		:= 0
Local nMesFim		:= 0
Local nAnoFim		:= 0       
Local nPosi			:= 0
Local nMesAux		:= 0
Local aAreaSM0	 	:= SM0->(GetArea())
Local nProc			:= 0
Local aArea			:= {}
Local cFilProc		:= ""

Local lMapResumo:= .F.									// Se trabalha com Mapa Resumo
Local aMapaResumo	:= 	{}								// Informacoes do Mapa Resumo
Local aGravaMapRes	:= 	{}								// Registros a serem informados no Mapa Resumo
Local aCposTemp		:=	{}								// Campos temporarios 
Local lFisLivro		:= .F.								// Conteudo do parametro MV_LJLVFIS
Local lImpEcf 		:= .T.								// Se trabalha com lei ECF

Private cArqTemp  	:=	""
//
Default nLacuna		:=	2
Default	nTotIcmsEnt	:=	2
Default nProcFil	:= 2       
Default cFilDe		:= cFilAnt
Default cFilAte		:= cFilAnt
Default nSubDiv		:= 1
Default cChamOrig	:= ""

lExist      :=	IIF(SF3->F3_OBSSOL>0,.T.,.F.)
aStruSf3	:=	SF3->(DbStruct ())
nF3FCount	:=	SF3->(FCount ())

If SuperGetMV("MV_LJLVFIS",,1) == 2
	If FindFunction("MaxRVerFunc")
		If MaxRVerFunc(cChamOrig)
			lFisLivro	:= .T.
		EndIf
    EndIf
EndIf

If lFisLivro
	If Alltrim(cChamOrig) == "MATR930"
		lMapResumo	:= IIF(mv_par37 == 1,.T.,.F.)
	ElseIf Alltrim(cChamOrig) == "MATR921"
		lMapResumo	:= IIF(mv_par14 == 1,.T.,.F.)		
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo CIAP Temporario                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lEmiteCiap
   If ( cArqCiap != NIL ) .And. Select("SF9") > 0
      cArqCiap := CriaTrab({{"SF3","N",14,0},{"SF9","N",14,0}})
	  dbUseArea(.T.,,cArqCiap,"CIAP",.T.,.F.)
	  IndRegua("CIAP",cArqCiap,"SF3")
   EndIf
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Arquivo Temporario                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX3")
dbSetOrder(1)
dbSeek(cAliasSf3)
While SX3->X3_ARQUIVO==cAliasSf3 .and.!Eof()
	AADD(aCampos,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL})
	dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Campo auxiliar para corrigir numeracao nas lacunas           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"NUMNOTA","C",TamSX3("F2_DOC")[1],0})
AADD(aCampos,{"FILCORR","C",2,0})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Para inserir os periodos sem movimento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"SEMMOV" ,"L",1,0})
cArqTemp:=CriaTrab(aCampos)
dbUseArea(.T.,,cArqTemp,cArqTemp,.T.,.F.)
If cMov == "S"
	cIndxTemp1:=Substr(CriaTrab(NIL,.F.),1,7)+"A"
	cIndxTemp2:=Substr(CriaTrab(NIL,.F.),1,7)+"B"
	cIndxTemp3:=Substr(CriaTrab(NIL,.F.),1,7)+"C"

	cChave:="F3_FILIAL+F3_SERIE+NUMNOTA+STR(F3_ALIQICM,5,2)+F3_CFO+F3_FORMULA"
	IndRegua(cArqTemp,cIndxTemp1,cChave,,,"Buscando Nts.Canceladas...") //
	cChave:="F3_SERIE+F3_TIPO+F3_DOCOR+F3_FILIAL"
	IndRegua(cArqTemp,cIndxTemp2,cChave,,,"Buscando Nts.Canceladas...") //
	cChave:="F3_SERIE+NUMNOTA+F3_FILIAL"
	IndRegua(cArqTemp,cIndxTemp3,cChave,,,"Buscando Nts.Canceladas...") //

	dbClearIndex()

	DbSetIndex(cIndxTemp1+OrdBagExt())
	DbSetIndex(cIndxTemp2+OrdBagExt())
	DbSetIndex(cIndxTemp3+OrdBagExt())	

	dbSetOrder(1)
Endif



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o processamento e centralizado, imprimindo mais de uma filial³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nProcFil <> 1
	cFilDe 	:= cFilAnt
	cFilAte	:= cFilAnt
Endif      

SM0->(dbSeek(cEmpAnt+cFilDe,.T.))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Imprime atraves das filiais selecionadas para o processamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do While !SM0->(Eof()) .And. SM0->M0_CODIGO+SM0->M0_CODFIL <= cEmpAnt+cFilAte

	cFilAnt	:= SM0->M0_CODFIL                              
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Atendimento ao Art. 121 do ANEXO 5 do RICMS/SC. O mesmo determina que todo prestador de                    ³
	//³  serviço de transporte deve apresentar as obrigações acessórias de forma consolidada pelo estabelecimento ³
	//³  matriz, e esta consolidação deverá abranger somente as empresas que estiverem domiciliadas no mesmo      ³
	//³  estado do estabelecimento consolidador.                                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lConsUF .And. (SM0->M0_ESTENT<>cMV_ESTADO)
		SM0->(DbSkip ())
		Loop
	EndIf
	
	// Sera verificada a configuracao do parametro para cada uma das filiais
	cLivrEP := GetMV("MV_LIVRESP")

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Prepara SF3 para extracao de dados                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cAliasSf3 := "SF3"
	dbSelectArea (cAliasSf3) 	
	//
	#IFDEF TOP
		cAliasSf3	:=	"EmiteLivro"
		cCampos		:=	" * "
		//
		cQuery		:=	"SELECT "
		cQuery		+=	cCampos+" FROM "+RetSqlName ("SF3")+" SF3 WHERE SF3.F3_FILIAL='"+xFilial ("SF3")+"' AND "
		IF (GetNewPar("MV_LFMD2DT",.F.)) .And. cMov == "S"
			cQuery  += "SF3.F3_EMISSAO>='"+DTOS (dDtIni)+"' AND SF3.F3_EMISSAO<='"+DTOS (dDtFim)+"' AND "
		Else
			cQuery  += "SF3.F3_ENTRADA>='"+DTOS (dDtIni)+"' AND SF3.F3_ENTRADA<='"+DTOS (dDtFim)+"' AND "		
		EndIf
		cQuery      += "SF3.D_E_L_E_T_=' ' "
		//
		If (cMov=="E")
			If nSubDiv == 1
				cQuery	+=	" AND SUBSTRING(SF3.F3_CFO,1,1)<'5' "
			ElseIf nSubDiv == 2                                 
				cQuery	+=	" AND SUBSTRING(SF3.F3_CFO,1,1)='1' "
			ElseIf nSubDiv == 3
				cQuery	+=	" AND SUBSTRING(SF3.F3_CFO,1,1) IN ('2','3') "
			Endif
		    //
			If !(lServico)
				cQuery	+=	" AND SF3.F3_TIPO<>'S' "
			Endif
			//
			If (cNrLivro!="*")
				cQuery	+=	" AND SF3.F3_NRLIVRO='"+cNrLivro+"' "
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Filtra notas de Entrada de Ativo p/ Ceara "MV_LIVRESP"       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cQuery	+=	" AND SF3.F3_NRLIVRO<>'"+cLivrEP+"' "
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Desconsidera notas canceladas quando considerar lacuna.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !(lLacuna)
				cQuery	+=	" AND NOT (SF3.F3_DTCANC<>'' AND SF3.F3_FORMUL='S') "
			Endif
		Else
			If !(lEntrada)
				If nSubDiv == 1
					cQuery	+=	" AND SUBSTRING(SF3.F3_CFO,1,1)>='5' "
				ElseIf nSubDiv == 2                                 
					cQuery	+=	" AND SUBSTRING(SF3.F3_CFO,1,1)='5' "
				ElseIf nSubDiv == 3
					cQuery	+=	" AND SUBSTRING(SF3.F3_CFO,1,1) IN ('6','7') "
				Endif
			Else
				If nSubDiv == 1
					cQuery	+=	" AND (SUBSTRING(SF3.F3_CFO,1,1)>='5' OR SF3.F3_FORMUL='S') "
				ElseIf nSubDiv == 2                                 
					cQuery	+=	" AND (SUBSTRING(SF3.F3_CFO,1,1)='5' OR (SF3.F3_FORMUL='S' AND SUBSTRING(SF3.F3_CFO,1,1)='1')) "
				ElseIf nSubDiv == 3
					cQuery	+=	" AND (SUBSTRING(SF3.F3_CFO,1,1) IN ('6','7') OR (SF3.F3_FORMUL='S' AND SUBSTRING(SF3.F3_CFO,1,1) IN ('2','3'))) "
				Endif
			Endif
			//
			If !(lServico)
				cQuery	+=	" AND SF3.F3_TIPO<>'S' "
			Endif
			//
			If lMapResumo .AND. !lAglutina
				cQuery	+=	" AND SF3.F3_ESPECIE <> 'CF' "			
			EndIf
			
			If (cNrLivro!="*")
				cQuery	+=	" AND SF3.F3_NRLIVRO='"+cNrLivro+"' "
			Endif
		Endif
        //
		cQuery	+=	" ORDER BY SF3.F3_FILIAL, SF3.F3_ENTRADA, SF3.F3_SERIE, SF3.F3_NFISCAL, SF3.F3_CFO "
		//
		cQuery 	:= 	ChangeQuery (cQuery)
	    	//
		DbUseArea (.T., "TOPCONN", TcGenQry (,,cQuery), cAliasSf3, .T., .T.)
		//
		For nSF3 := 1 To (Len (aStruSF3))
			If (aStruSF3[nSF3][2]<>"C") .And. (FieldPos (aStruSF3[nSF3][1])>0)
				TcSetField (cAliasSf3, aStruSF3[nSF3][1], aStruSF3[nSF3][2], aStruSF3[nSF3][3], aStruSF3[nSF3][4])
			EndIf
		Next (nSF3)
	#ELSE
		If cMov=="E"
			cFiltro:="F3_FILIAL=='"+xFilial()+"'.AND.DTOS(F3_ENTRADA)>='"+DTOS(dDtIni)+"'.AND.DTOS(F3_ENTRADA)<='"+DTOS(dDtFim)+"' "	
			If nSubDiv == 1
			    cFiltro +=  ".AND. F3_CFO<'500"+SPACE(LEN(F3_CFO)-3)+"' "
			ElseIf nSubDiv == 2                                          
				cFiltro +=  ".AND. SUBSTR(F3_CFO,1,1) == '1' "
			ElseIf nSubDiv == 3
				cFiltro +=  ".AND. SUBSTR(F3_CFO,1,1) $ '23' "
			Endif
			If !lServico
				cFiltro	+=	".AND.F3_TIPO!='S' "
			Endif
			If cNrLivro!="*"
				cFiltro	+=	".AND.F3_NRLIVRO=='"+cNrLivro+"' "
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Filtra notas de Entrada de Ativo p/ Ceara "MV_LIVRESP"       ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cFiltro	+=	".AND.F3_NRLIVRO<>'"+cLivrEP+"' "
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Desconsidera notas canceladas quando considerar lacuna.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !(lLacuna)
				cFiltro	+=	".AND. !(!Empty (F3_DTCANC) .AND. F3_FORMUL=='S') "
			Endif
		Else
			IF !(GetNewPar("MV_LFMD2DT",.F.))
				cFiltro:="F3_FILIAL=='"+xFilial()+"'.AND.DTOS(F3_ENTRADA)>='"+DTOS(dDtIni)+"'.AND.DTOS(F3_ENTRADA)<='"+DTOS(dDtFim)+"' "	
			Else
				cFiltro:="F3_FILIAL=='"+xFilial()+"'.AND.DTOS(F3_EMISSAO)>='"+DTOS(dDtIni)+"'.AND.DTOS(F3_EMISSAO)<='"+DTOS(dDtFim)+"' "	
			EndIf	
			If !lEntrada
				If nSubDiv == 1
			        cFiltro +=  ".AND. F3_CFO>='500"+SPACE(LEN(F3_CFO)-3)+"' "
			 	ElseIf nSubDiv == 2
			 		cFiltro +=  ".AND. SUBSTR(F3_CFO,1,1) == '5' "
			 	ElseIf nSubDiv == 3                           
			 		cFiltro +=  ".AND. SUBSTR(F3_CFO,1,1) $ '67' "
			 	Endif
			Else     
				If nSubDiv == 1
			        cFiltro +=  ".AND.(F3_CFO>='500"+SPACE(LEN(F3_CFO)-3)+"' .OR.F3_FORMUL=='S') "
			 	ElseIf nSubDiv == 2                                                               
			 		cFiltro +=  ".AND.(SUBSTR(F3_CFO,1,1)=='5' .OR. (SUBSTR(F3_CFO,1,1)=='1' .AND. F3_FORMUL=='S')) "
			 	ElseIf nSubDiv == 3                                                                              
			 		cFiltro +=  ".AND.(SUBSTR(F3_CFO,1,1) $ '67' .OR. (SUBSTR(F3_CFO,1,1)$'23' .AND. F3_FORMUL=='S')) "
			 	Endif
			Endif
			If !lServico
				cFiltro	+=	".AND.F3_TIPO!='S'"
			Endif
			If cNrLivro!="*"
				cFiltro	+=	".AND.F3_NRLIVRO=='"+cNrLivro+"'"
			Endif		
		Endif
		cChave		:=	"F3_FILIAL+DTOS(F3_ENTRADA)+F3_SERIE+F3_NFISCAL+F3_CFO"
		cArqIndxF3	:=	CriaTrab(NIL,.F.)
		IndRegua ("SF3", cArqIndxF3, cChave,, cFiltro, "Filtrando registros...") //
		//
		dbClearIndex ()
		dbSetIndex (cArqIndxF3+OrdBagExt ())
	#ENDIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica os meses a processar. Caso seja necessario imprimir mais de um mes                     ³
	//³e entre os meses exista algum sem movimento, devera ser impressa a descricao de "SEM MOVIMENTO".³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nMesIni	:= Month(dDtIni)
	nAnoIni	:= Year(dDtIni)
	nMesFim	:= Month(dDtFim)
	nAnoFim	:= Year(dDtFim)
	nMesAux := nMesFim
	
	For nPosi := nAnoIni to nAnoFim
		If nPosi <> nAnoFim
			nMesFim := 12
		Else             
			nMesFim := nMesAux
		Endif
		Do While nMesIni <= nMesFim
			nProc := aScan(aProcessa,{|x| x[1]==nMesIni .And. x[2]==nPosi})

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Somente adiciona se a referencia nao existir. No processamento³
			//³consolidado, essa rotina sera processada mais que uma vez.    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If nProc == 0
				Aadd(aProcessa,{nMesIni,nPosi,.F.})
			Endif
		
			If nMesIni == 12
				nMesIni	:= 1
				Exit
			Else
				nMesIni += 1
			Endif
		Enddo	
	Next 
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta arquivo temporario                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea (cAliasSf3)
	SetRegua(LastRec())
	dbGotop()
	While !(cAliasSf3)->(eof())
		IncRegua()
		If Interrupcao(@lAbortPrint)
			Exit
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Considera filtro do usuario                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !Empty(cFilterUser).and.!(&cFilterUser)
			dbSkip()
			Loop
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Armazena os numeros de livros lancados             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !(F3_NRLIVRO$cLivros)
			cLivros	+=	F3_NRLIVRO+"/"
		Endif
	    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Para armazenar os períodos com movimento³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	    nPosi := aScan(aProcessa,{|x| x[1]==Month((cAliasSf3)->F3_ENTRADA) .And. x[2]==Year((cAliasSf3)->F3_ENTRADA)})
	    aProcessa[nPosi][3] := .T.
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se os lancamentos serao aglutinados                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nTipomov==1 .or. !lAglutina
			dbSelectArea(cArqTemp)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Desconsidera item de entrada c/ formul. proprio nos livros   ³
			//³ de saida qdo ja foi gravado um item do lancto.               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cMov=="S".And.lEntrada.And.Val(substr((cAliasSf3)->F3_CFO,1,1))<5.And.(cAliasSf3)->F3_FORMUL=="S".And. ;
				dbSeek((cAliasSf3)->F3_FILIAL+(cAliasSf3)->F3_SERIE+StrZero(Val((cAliasSf3)->F3_NFISCAL)),.F.)
				dbSelectArea (cAliasSf3)
				dbSkip()
				Loop
			Endif
			
			If cMov=="S"
				dbSeek((cAliasSf3)->F3_FILIAL+(cAliasSf3)->F3_SERIE+(cAliasSf3)->F3_NFISCAL+STR((cAliasSf3)->F3_ALIQICM,5,2)+(cAliasSf3)->F3_CFO,.F.)
			endif
			If !eof() .and. F3_TIPO =="S"
			    If lServico .AND. lEntrada
	               RecLock(cArqTemp,.T.)
			  	Else
			  	   RecLock(cArqTemp,.F.)
			  	EndIf   
			Else
				RecLock(cArqTemp,.T.)
			EndIf
			For i	:=	1 to FCount()
				nx	:= FieldPos ((cAliasSf3)->(FieldName(i)))
				if nx>0
					FieldPut (nx,(cAliasSf3)->(FieldGet(i)))
				endif
			Next i
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Corrige numeracao da Nota                                    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cMov=="S"
				(cArqTemp)->NUMNOTA := STRZERO(VAL((cAliasSf3)->F3_NFISCAL),TamSX3("F2_DOC")[1])
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Zera valor de desconto para nao ser escriturado              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !lDesconto
				(cArqTemp)->F3_VALOBSE := 0
			Endif                                                             
			
		   	dbSelectArea(cArqSF3)
		    RecLock(cArqSF3,.T.)
	        (cArqSF3)->CHAVE 	:= (cAliasSf3)->F3_FILIAL+DTOS((cAliasSf3)->F3_ENTRADA)+(cAliasSf3)->F3_NFISCAL+(cAliasSf3)->F3_SERIE+(cAliasSf3)->F3_CLIEFOR+(cAliasSf3)->F3_LOJA+(cAliasSf3)->F3_CFO+STR((cAliasSf3)->F3_ALIQICM,5,2)
	        (cArqSF3)->FILIAL 	:= cFilAnt
	        (cArqSF3)->MES 		:= StrZero(Month((cAliasSf3)->F3_ENTRADA),2)
	        (cArqSF3)->ANO 		:= StrZero(Year((cAliasSf3)->F3_ENTRADA),4)
			(cArqSF3)->(MsUnLock())
			dbSelectArea(cArqTemp)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Altera registro de notas de Formulario Proprio na Saida e    ³
			//³ Notas fiscais de Servico                                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If cMov=="S".and.((cAliasSf3)->F3_FORMUL=="S".or.(cAliasSf3)->F3_TIPO=="S") .or. !empty((cAliasSf3)->F3_DTCANC)
				For i:=1 to FCount()
					If Valtype(FieldGet(i))=="N"
						FieldPut(i,0)
					Endif
				Next
				If F3_FORMUL=="S" .and. empty(F3_DTCANC)
					(cArqTemp)->F3_OBSERV := "NT.FISCAL DE ENTRADA" 
				Elseif F3_FORMUL=="S" .AND.!empty(F3_DTCANC)
					If Empty((cArqTemp)->F3_OBSERV)
					   (cArqTemp)->F3_OBSERV := "CANCELADA"    //
					EndIf
				ElseIf !empty(F3_DTCANC	)
					If Empty((cArqTemp)->F3_OBSERV)
						(cArqTemp)->F3_OBSERV := "CANCELADA"    //
					EndIf
				Else
					(cArqTemp)->F3_OBSERV := "NT.FISCAL DE SERVICO"+" "+(cArqTemp)->F3_OBSERV  //
				EndIf
				if	empty(F3_DTCANC)	
					(cArqTemp)->F3_CFO	:= "999"
				EndIf		
				If F3_FORMUL<>"S" .Or. (cMov=="S".and.GetNewPar("MV_LFMD2DT",.F.))
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Considera Dt.emissao NF entrada na emissao livro de saidas.  ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					(cArqTemp)->F3_ENTRADA := F3_EMISSAO
				Endif
			Endif                                      
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Grava a filial corrente no momento do processamento³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			(cArqTemp)->FILCORR := cFilAnt
			
			MsUnLock()
            //
	        If lEmiteCiap
			   If ( Select("CIAP") != 0 )
				  dbSelectArea("SF9")
				  dbSetOrder(2)
				  If ( dbSeek(F3Filial("SF9")+Dtos((cAliasSf3)->F3_ENTRADA)+(cAliasSf3)->F3_NFISCAL+;
					 (cAliasSf3)->F3_SERIE+(cAliasSf3)->F3_CLIEFOR+(cAliasSf3)->F3_LOJA+(cAliasSf3)->F3_CFO+;
					 STR((cAliasSf3)->F3_ALIQICM,5,2)) )
					 While ( !Eof() .And. F3Filial("SF9")==SF9->F9_FILIAL .And.;
						   (cAliasSf3)->F3_ENTRADA==SF9->F9_DTENTNE 	.And. ;
					 	   (cAliasSf3)->F3_NFISCAL==SF9->F9_DOCNFE 	.And.	;
						   (cAliasSf3)->F3_SERIE	==	SF9->F9_SERNFE 	.And.;
						   (cAliasSf3)->F3_CLIEFOR==SF9->F9_FORNECE .And.;
						   (cAliasSf3)->F3_LOJA	==SF9->F9_LOJAFOR .And.;
						   (cAliasSf3)->F3_CFO 	== SF9->F9_CFOENT .And.;
						   (cAliasSf3)->F3_ALIQICM==SF9->F9_PICM )
						   RecLock("CIAP",.T.)
						   CIAP->SF3 := &(cArqTemp)->(Recno())
						   CIAP->SF9 := SF9->(Recno())
						   MsUnlock()
						   dbSelectArea("SF9")
						   dbSkip()
					 EndDo
				  EndIf
				  dbSelectArea("SF9")
				  dbSetOrder(1)
			   EndIf
			Endif
			dbSelectArea(cAliasSf3)
			dbSkip()
		Else
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Aglutina lancamentos de mesma Data+Serie+CFO                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			cNFIni	  := F3_NFISCAL
			cNFFim	  := F3_NFISCAL
			dData	  := F3_ENTRADA
			cEst	  := F3_ESTADO
			cEsp	  := F3_ESPECIE 
			dDtCan1   := F3_DTCANC 
		    cCliente  := F3_CLIEFOR
		    cLoja     := F3_LOJA
	        nAliq     := F3_ALIQICM         
		    cSer 	  := F3_SERIE        
		    cFormula  := F3_FORMULA
			cTipo	  := F3_TIPO     
			cFilProc  := F3_FILIAL
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa array de aglutinacao.            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aLivro := Array(Len(aFixos))
			For i:=1 To Len(aFixos)
				aLivro[i] := aFixos[i][2]
			Next
			
			cSeek:=F3_FILIAL+dTos(F3_ENTRADA)+F3_SERIE+F3_CFO+Str(F3_ALIQICM,5,2)+cEst+cEsp+cFormula+cTipo
			While !Eof().And.cSeek==F3_FILIAL+dTos(F3_ENTRADA)+F3_SERIE+F3_CFO+Str(F3_ALIQICM,5,2)+F3_ESTADO+F3_ESPECIE+F3_FORMULA	+F3_TIPO
	
		        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Considera Nf's de Entrada                ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !lEntrada .and. Val(substr(F3_CFO,1,1))<5
					dbSkip()
					Loop
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Considera filtro do usuario                                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty(cFilterUser).and.!(&cFilterUser)
					dbSkip()
					Loop
				Endif
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Acumula valores.             ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ 
				if empty(F3_DTCANC)
					For i:=1 To Len(aFixos)
						If (cAliasSf3)->(FieldPos(aFixos[i][1])) > 0
							cCampo:=&(aFixos[i,1])
							If ValType(cCampo)$"CD".Or.aFixos[i,1]=="F3_ALIQICM"
								aLivro[i]:=cCampo
							Else
								aLivro[i]+=cCampo
							Endif 
						Endif	
					Next				
	 			    RecLock(cArqSF3,.T.)
	  	            (cArqSF3)->CHAVE 	:= (cAliasSf3)->F3_FILIAL+DTOS((cAliasSf3)->F3_ENTRADA)+(cAliasSf3)->F3_NFISCAL+(cAliasSf3)->F3_SERIE+(cAliasSf3)->F3_CLIEFOR+(cAliasSf3)->F3_LOJA+(cAliasSf3)->F3_CFO+STR((cAliasSf3)->F3_ALIQICM,5,2)
	  	            (cArqSF3)->FILIAL 	:= cFilAnt
			        (cArqSF3)->MES 		:= StrZero(Month((cAliasSf3)->F3_ENTRADA),2)
			        (cArqSF3)->ANO 		:= StrZero(Year((cAliasSf3)->F3_ENTRADA),4)
					MsUnLock()	
					cNFFim   :=(cAliasSf3)->F3_NFISCAL
					cSer 	 :=(cAliasSf3)->F3_SERIE
					cCFO     :=(cAliasSf3)->F3_CFO
		  		    cFormula :=(cAliasSf3)->F3_FORMULA				
		  		    cFilProc :=(cAliasSf3)->F3_FILIAL
					
					If !lMapResumo
						GravaTemp(cNFIni,cNFFim,aFixos,aLivro,dData,cEst,cEsp,cCliente,cLoja,dDtCan1,cMov,lDesconto,nAliq,cSer,cCFO,cFormula,,cFilProc)
	            	Else
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Caso utilize Mapa Resumo, somente gera o temporario para NF. ³
						//³Pois os registros de Mapa Resumo (SFI) serao de acordo com a ³
						//³funcao Mtr930Resumo                                          ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	            		If Alltrim((cAliasSf3)->F3_ESPECIE) <> "CF"
							GravaTemp(cNFIni,cNFFim,aFixos,aLivro,dData,cEst,cEsp,cCliente,cLoja,dDtCan1,cMov,lDesconto,nAliq,cSer,cCFO,cFormula,,cFilProc)
						EndIf	            	
	            	EndIf    
	            
	            Else
	               lCanc :=.T.
	               exit 
				EndIf
				dbSelectArea(cAliasSf3)
	            dbSkip()
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se proxima nota nao esta cancelada.                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If (Val(cNFFim)+1) <> Val(F3_NFISCAL)
					Exit
				Endif
			EndDo
			if lCanc
	           //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			   //³ Inicializa array de aglutinacao.            ³
			   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			   aLivro := Array(Len(aFixos))
			   For i:=1 To Len(aFixos)
				   aLivro[i] := aFixos[i][2]
			   Next
			   cNFIni	 := (cAliasSf3)->F3_NFISCAL
			   cNFFim	 := (cAliasSf3)->F3_NFISCAL
			   dData	 := (cAliasSf3)->F3_ENTRADA
			   cEst	     := (cAliasSf3)->F3_ESTADO
			   cEsp	     := (cAliasSf3)->F3_ESPECIE 
			   dDtCan1   := (cAliasSf3)->F3_DTCANC 
			   cCliente  := (cAliasSf3)->F3_CLIEFOR
			   cLoja     := (cAliasSf3)->F3_LOJA
			   cFilProc  := (cAliasSf3)->F3_FILIAL
			   lCanc     :=.F.
               
			   If !lMapResumo
	           		GravaTemp(cNFIni,cNFFim,aFixos,aLivro,dData,cEst,cEsp,cCliente,cLoja,dDtCan1,cMov,lDesconto,nAliq,cSer,cCFO,,,cFilProc)
			   Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Caso utilize Mapa Resumo, somente gera o temporario para NF. ³
					//³Pois os registros de Mapa Resumo (SFI) serao de acordo com a ³
					//³funcao Mtr930Resumo                                          ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			   		If Alltrim((cAliasSf3)->F3_ESPECIE) <> "CF"
						GravaTemp(cNFIni,cNFFim,aFixos,aLivro,dData,cEst,cEsp,cCliente,cLoja,dDtCan1,cMov,lDesconto,nAliq,cSer,cCFO,,,cFilProc)			        
			   		EndIf
			   EndIf               

			   dbSelectArea(cAliasSf3)
	           dbSkip()		
			endif
			dbSelectArea(cAliasSf3)
		Endif
	End
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Adiciona um registro no temporario para imprimir o periodo sem movimento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nPosi := 1 To Len(aProcessa)
		If ! aProcessa[nPosi][3]
			cNFIni		:= ""
			cNFFim		:= ""
			cSer		:= ""
			nAliq		:= 0
			cFormula	:= ""
			dData		:= cToD("01/" + StrZero(aProcessa[nPosi][1],2) + "/" + StrZero(aProcessa[nPosi][2],4))
			cEst		:= ""
			cEsp		:= ""
			dDtCan1		:= cTod("  /  /  ")
			cCliente	:= ""
			cLoja		:= ""
			lCanc		:= .F.
			cFilProc  	:= xFilial("SF3")
	        GravaTemp(cNFIni,cNFFim,aFixos,aLivro,dData,cEst,cEsp,cCliente,cLoja,dDtCan1,cMov,lDesconto,nAliq,cSer,cCFO,cFormula,.T.,cFilProc)
		Endif
	Next
	
	#IFDEF TOP
		(cAliasSf3)->(DbCloseArea ())
	#ENDIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Reposiciona SF3                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SF3")
	dbClearFilter()
	RetIndex("SF3")
	dbSetOrder(1)
	#IFNDEF TOP
		Ferase(cArqIndxF3+OrdBagExt())
	#ENDIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Acumula Valores do ICMS Normal + Retido - Instr. Normativa n. 564/02-GSF - Goias ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTotIcmsEnt == 1 .And. cMov=="S" .And. lExist
		dbSelectArea("SF3")
		#IFDEF TOP
			cQuery := "SELECT SUM (SF3.F3_OBSICM) F3_OBSICM, SUM (SF3.F3_OBSSOL) F3_OBSSOL "
			cQuery += "FROM "+RetSqlName("SF3")+" SF3 "
			cQuery += "WHERE SF3.F3_FILIAL='"+xFilial("SF3")+"' AND "
			cQuery += "SUBSTRING(SF3.F3_CFO,1,1)<'5' AND "
			cQuery += "SF3.F3_ENTRADA>='"+DTOS(dDtIni)+"' AND SF3.F3_ENTRADA<='"+DTOS(dDtFim)+"' AND "
			cQuery += "SF3.D_E_L_E_T_=' ' "
	
			If !(lServico)
				cQuery	+=	" AND SF3.F3_TIPO<>'S' "
			EndIf
			
			If (cNrLivro!="*")
				cQuery	+=	" AND SF3.F3_NRLIVRO='"+cNrLivro+"' "
			EndIf
			
			cQuery := ChangeQuery(cQuery)
	
			dbUseArea (.T.,"TOPCONN",TcGenQry (,,cQuery),"QUERY")
	
			nTotIcmDeb := QUERY->F3_OBSICM+QUERY->F3_OBSSOL
	
			QUERY->(dbCloseArea ())
		#ELSE
			cFiltro:="F3_FILIAL=='"+xFilial()+"'.AND.DTOS(F3_ENTRADA)>='"+DTOS(dDtIni)+"'.AND.DTOS(F3_ENTRADA)<='"+DTOS(dDtFim)+"'"
			cFiltro +=  ".AND. F3_CFO<'500"+SPACE(LEN(F3_CFO)-3)+"'"
			If !lServico
				cFiltro	+=	".AND.F3_TIPO!='S'"
			Endif
			If cNrLivro!="*"
				cFiltro	+=	".AND.F3_NRLIVRO=='"+cNrLivro+"'"
			Endif
			cChave		:=	"F3_FILIAL+DTOS(F3_ENTRADA)+F3_SERIE+F3_NFISCAL+F3_CFO"
			cArqIndxF3	:=	CriaTrab(NIL,.F.)
			IndRegua("SF3",cArqIndxF3,cChave,,cFiltro,"Filtrando registros...") //
			//
			dbClearIndex()
			dbSetIndex(cArqIndxF3+OrdBagExt())
			//
			SetRegua(LastRec())
			dbGotop()
			While !SF3->(eof())
				IncRegua()
				If Interrupcao(@lAbortPrint)
					Exit
				Endif
				nTotIcmDeb += F3_OBSICM+F3_OBSSOL
				dbSkip()		
			EndDo
			//
			dbSelectArea("SF3")
			dbClearFilter()
			RetIndex("SF3")
			dbSetOrder(1)
			Ferase(cArqIndxF3+OrdBagExt())
		#ENDIF
		//
		dbSelectArea("SF3")
		dbSetOrder(1)
	Endif

	If lMapResumo .AND. cMov=="S"

		If Type("lLeiEcf") <> "U" 
			If Type("lLeiEcf") == "L" 
				lImpEcf := lLeiECF
			EndIf            
        EndIf

		If lImpEcf
        
			aMapaResumo		:= 	MaxRMapRes(dDtIni,dDtFim)
			aGravaMapRes	:= 	MaXRAgrupF3(cFilAnt,aMapaResumo,cChamOrig)
			cArqTemp		:=	MaXRAddArq(2,cArqTemp,/*cAlias*/,aCampos,aGravaMapRes)

		EndIf        

	EndIf

	SM0->(dbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a filial e area corrente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aArea := GetArea()
RestArea(aAreaSM0)
cFilAnt	:= SM0->M0_CODFIL
RestArea(aArea)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca notas Fiscais Canceladas/Nao Lancadas/Nf.Servico       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cMov=="S".and.lLacuna.and.!lAbortPrint
	dbSelectArea(cArqTemp)
	dbSetOrder(1)
	dbGotop()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Busca series lancadas                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aSeries:={}
	SetRegua(LastRec())
	While !eof()
		IncRegua()
		If Interrupcao(@lAbortPrint)
			Exit
		Endif
		If !SEMMOV 
			nPos:=Ascan(aSeries,{|x|x[1]==F3_NRLIVRO.and.x[2]==F3_SERIE.and.x[5]==F3_FILIAL})
			If nPos==0
				AADD(aSeries,{F3_NRLIVRO,F3_SERIE,Val(NUMNOTA),0,F3_FILIAL,FILCORR})
				nPos:=Len(aSeries)
			Endif              
			
			aSeries[nPos,4]:=Max(Max(Val(NUMNOTA),Val(F3_DOCOR)),aSeries[nPos,4])
		Endif
		dbSkip()
	End         
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica Series Lancadas                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dDtCanc	:=	dDtFim
	For i:=1 to Len(aSeries)
		SetRegua(aSeries[i,4]-aSeries[i,3])
		For j:=aSeries[i,3] to aSeries[i,4]
			
			IncRegua()
			If Interrupcao(@lAbortPrint)
				Exit
			Endif
			
			cSeek:=aSeries[i,2]+StrZero(j,TamSX3("F2_DOC")[1])+aSeries[i,5]
			dbSetOrder(3)
			If dbSeek(cSeek,.F.)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Nao considera notas de Lote na sequencia ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If F3_TIPO=="L".And.!Empty(F3_DOCOR)
					j:=Val(F3_DOCOR)
					dbSkip()
					While ( !Eof() .And. J==Val(NUMNOTA) )
						j:=Val(F3_DOCOR)
						dbSkip()
					EndDo
					If j>=aSeries[i,4]
						Exit
					Endif
				Endif
				dDtCanc:=F3_ENTRADA
				Loop
			Else
				dbSetOrder(2)
				cSeek:=aSeries[i,2]+"C"+StrZero(j,TamSX3("F2_DOC")[1])+aSeries[i,5]
				If !dbSeek(cSeek)
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Verifica se a nota existe em outro livro ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					If !ExistNF(StrZero(j,TamSX3("F2_DOC")[1]),aSeries[i,2],aSeries[i,1],cLivros,aSeries[i,6]) 
                       If nLacuna==1
						   RecLock(cArqTemp,.T.)                                              
                           //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                           //³Posiciona na filial em que foi processado o registro ³
                           //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
                           Mtr930Fil(aAreaSM0,aSeries[i,6],1)
						   (cArqTemp)->F3_FILIAL 	:= xFilial("SF3")
						   (cArqTemp)->F3_TIPO		:= "C"
						   (cArqTemp)->F3_NFISCAL := StrZero(j,TamSX3("F2_DOC")[1])
						   (cArqTemp)->F3_DOCOR	:= StrZero(j,TamSX3("F2_DOC")[1])
						   (cArqTemp)->NUMNOTA		:= StrZero(j,TamSX3("F2_DOC")[1])
						   (cArqTemp)->F3_NRLIVRO := aSeries[i,1]
						   (cArqTemp)->F3_SERIE	:= aSeries[i,2]
						   (cArqTemp)->F3_EMISSAO	:= dDtCanc
						   (cArqTemp)->F3_ENTRADA := dDtCanc
						   (cArqTemp)->F3_CFO		:= "999"
						   (cArqTemp)->F3_OBSERV	:= "CANCELADA"
						   MsUnLock()
   					       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 	 				       //³Restaura a filial e area corrente ³
					       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						   Mtr930Fil(aAreaSM0,aSeries[i,6],2)
						Endif   
					Else
						If !dbSeek(cSeek,.F.)
          		            //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                     		//³Posiciona na filial em que foi processado o registro	³
                     		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							Mtr930Fil(aAreaSM0,aSeries[i,6],1)
							dbSelectArea("SF3")
							dbSetOrder(5)
							If cMov=="S".And.lEntrada.And.dbSeek(xFilial()+aSeries[i,2]+StrZero(j,TamSX3("F2_DOC")[1]),.F.).And.Val(substr(SF3->F3_CFO,1,1))<5.And.(SF3->F3_FORMUL=="S") ;
								.And.(SF3->F3_EMISSAO>=dDtIni.And.SF3->F3_EMISSAO<=dDtFim)
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Altera registro de notas de Formulario Proprio na Saida e    ³
								//³ Notas fiscais de Servico                                     ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								If SF3->(EOF())
								RecLock(cArqTemp,.T.)
								(cArqTemp)->F3_FILIAL 	:= xFilial("SF3")
								(cArqTemp)->F3_NFISCAL :=	StrZero(j,TamSX3("F2_DOC")[1])
								(cArqTemp)->F3_DOCOR	:=	StrZero(j,TamSX3("F2_DOC")[1])
								(cArqTemp)->NUMNOTA		:= StrZero(j,TamSX3("F2_DOC")[1])
								(cArqTemp)->F3_NRLIVRO	:= aSeries[i,1]
								(cArqTemp)->F3_SERIE	:= aSeries[i,2]
								(cArqTemp)->F3_OBSERV	:= "NT.FISCAL DE ENTRADA"
								(cArqTemp)->F3_CFO		:= "999"
								(cArqTemp)->F3_ENTRADA := SF3->F3_EMISSAO
								For nI:=1 to FCount()
									If Valtype(FieldGet(nI))=="N"
										FieldPut(nI,0)
									Endif
								Next
								//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
								//³ Considera Dt.emissao NF entrada na emissao livro de saidas.  ³
								//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
								MsUnLock()
							Endif
							//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
							//³Restaura a filial e area corrente ³
							//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
							Mtr930Fil(aAreaSM0,aSeries[i,6],2)
						Endif
						Endif
				        dDtCanc:=F3_ENTRADA
						dbSelectArea(cArqTemp)
					Endif
				Else
 				   dDtCanc:=F3_ENTRADA
					RecLock(cArqTemp,.F.)
					If J>Val(F3_DOCOR)
						(cArqTemp)->F3_DOCOR 	:= StrZero(j,TamSX3("F2_DOC")[1])
					Endif
					MsUnLock()
				Endif
			Endif
		Next j
		If lAbortPrint
			Exit
		Endif
	Next i
Endif
dbSelectArea(cArqTemp)
If cMov=="S"
	dbClearIndex()
	Ferase(cIndxTemp1+OrdBagExt())
	Ferase(cIndxTemp2+OrdBagExt())

Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Indice principal de impressao                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !lAbortPrint
	if aReturn[8]==1
		cChave	:=	"DTOS(F3_ENTRADA)+F3_SERIE+F3_NFISCAL+F3_CFO+F3_FORMULA+F3_FILIAL"	
	else
		cChave	:=	"DTOS(F3_ENTRADA)+F3_NFISCAL+F3_SERIE+F3_CFO+F3_FORMULA+F3_FILIAL"
	endif
	IndRegua(cArqTemp,cArqTemp,cChave,,,"Ordenando Notas...") //
	dbGoTop()
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa array aColunas statico com colunas do SF3         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ColF3()

Return (cArqTemp)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LivrAcumula()³Autor ³ Juan Jose Pereira    ³Data³ 17/02/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Acumulador de valores fiscais para o ModP1,ModP1A          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION LivrAcumula(	cArqTemp,;
aTotDia,;
aTotPerICM,;
aTotPerIPI,;
aTotMes,;
aTransp,;
aResumo,;
aResCFO,;
cArqSF3)

LOCAL aSF3		:= {}
Local i
Local cSvAlias	:= Alias()
Local nPos
Local nPosCFO
LOCAL cMens		:= ""
Local cCaption	:= " ATENCAO "
LOCAL cClieFor
LOCAL cInscr
LOCAL cTipo
Local lExist 	:= IIF(SF3->F3_OBSSOL >0,.T.,.F.)
Local aAreaSM0 	:= SM0->(GetArea())
Local cFilProc	:= ""
Local lCredST	:= SF3->(FieldPos("F3_CREDST")) > 0
Local lProcST	:= .T.
Local dAuxData	:= cTod("//")

Private oDlgAviso  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se foi passada a filial pelo cArqSF3 (Matr920)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cArqSF3 <> Nil
	cFilProc := (cArqSF3)->FILIAL
Else
	cFilProc := cFilAnt
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se CFO das NFs sao validos.             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If (Empty(F3_CFO) .Or. ValType(Val(F3_CFO))!="N") .And. FieldPos ("SEMMOV")>0 .And. !SEMMOV
	cMens:="NF "+F3_SERIE+" "+F3_NFISCAL+" possui CFO incorreto ! "
	
	DEFINE MSDIALOG oDlgAviso TITLE OemtoAnsi(cCaption) FROM  165,190 TO 300,440 PIXEL OF oMainWnd
	@ 03, 10 TO 43, 118 LABEL "" OF oDlgAviso  PIXEL
	@ 20, 15 SAY OemToAnsi(cMens) SIZE 100, 8 OF oDlgAviso PIXEL
	DEFINE SBUTTON FROM 50  ,80  TYPE 1 ACTION (oDlgAviso:End()) ENABLE OF oDlgAviso
	ACTIVATE MSDIALOG oDlgAviso
	Return
Endif

If aResCFO==NIL
	aResCFO:={}
Endif
If aResumo==NIL
	aResumo:={}
Endif

dbSelectArea(cArqTemp)

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

For i:=1 to FCount()
	If ValType(FieldGet(i))=="N"
		// Quando o ICMS ST nao deve ser apresentado como Retido - ST Transportes
	  	If (Alltrim(FieldName(i)) == "F3_ICMSRET" .Or. AllTrim(FieldName(i)) == "F3_BASERET" .Or. AllTrim(FieldName(i)) == "F3_OBSSOL") .And. !lProcST
			AADD(aSF3,0)
	  	Else
			AADD(aSF3,FieldGet(i))
		Endif
	Else 
		AADD(aSF3,"NULL")
	Endif
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o registro nao e do Mapa Resumo do ECF              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If substr(F3_CFO,1,3)=="999" .And. (Alltrim(F3_ESPECIE)<>"CF")
	For i:=1 to Len(aSF3)
		aSF3[i]:=If(Valtype(aSF3[i])=="N",0,aSF3[i])
	Next
Endif

If aTotDia==NIL
	aTotDia		:=	Aclone(aSF3)
	aTotPerICM	:=	Aclone(aSF3)
	aTotPerIPI	:=	Aclone(aSF3)
	aTotMes		:=	Aclone(aSF3)
	aTransp		:=	Aclone(aSF3)
Else
	For i:=1 to Len(aSF3)
		If Valtype(aSF3[i])=="N"
			nValor:=aSF3[i]
			aTotDia[i]		+=nValor
			aTotPerICM[i]	+=nValor
			aTotPerIPI[i]	+=nValor
			aTotMes[i] 		+=nValor
			aTransp[i]		+=nValor
		Endif
	Next i
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumula valores por CFOS                                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPosCFO:=ColF3("F3_CFO")
If !(Subs(F3_CFO,1,3) $ "999#000") .And. Empty(F3_DTCANC) // nao imprimi resumo por CFOP para transferencias/Canceladas
	nPos:=Ascan(aResCFO,{|x|x[nPosCFO]==F3_CFO})
	If nPos==0
		AADD(aResCFO,AClone(aSF3))
		nPos:=Len(aResCFO)
		aResCFO[nPos,nPosCFO]:=F3_CFO
	Else
		For i:=1 to Len(aSF3)
			If ValType(aSF3[i])=="N"
				aResCFO[nPos,i]+=aSF3[i]
			Endif
		Next i
	Endif
	nPos:=Ascan(aResCFO,{|x|x[nPosCFO]==Substr(F3_CFO,1,1)+"TT"})
	If nPos==0
		AADD(aResCFO,AClone(aSF3))
		nPos:=Len(aResCFO)
		aResCFO[nPos,nPosCFO]:=Substr(F3_CFO,1,1)+"TT"
	Else
		For i:=1 to Len(aSF3)
			If ValType(aSF3[i])=="N"
				aResCFO[nPos,i]+=aSF3[i]
			Endif
		Next i
	Endif
	nPos:=Ascan(aResCFO,{|x|x[nPosCFO]=="TTT"})
	If nPos==0
		AADD(aResCFO,AClone(aSF3))
		nPos:=Len(aResCFO)
		aResCFO[nPos,nPosCFO]:="TTT"
	Else
		For i:=1 to Len(aSF3)
			If ValType(aSF3[i])=="N"
				aResCFO[nPos,i]+=aSF3[i]
			Endif
		Next i
	Endif
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acumula valores de operacoes interestaduais                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dAuxData := F3_ENTRADA
IF Empty(F3_DTCANC) //Nao gera resumo para notas fiscais canceladas 
	IF lAglutina .And. nTipomov <> 1
	   cAliasSF3 :=ALIAS()
	   dbSelectArea("SF3")
	   dbsetorder(1)                

	   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³Verifica se o mes/ano da chave e o mesmo do mes que esta sendo processado³
	   //³para nao aglutinar varios meses em um resumo somente.                    ³
	   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   (cArqSF3)->(dbSetOrder(2))
	   (cArqSF3)->(dbGoTop())
	   (cArqSF3)->(dbseek(" " + StrZero(Month(dAuxData),2) + StrZero(Year(dAuxData),4)))
	   While !(cArqSF3)->(EOF()) .And. ;
		   StrZero(Month(dAuxData),2) == (cArqSF3)->MES .And. ;
		   StrZero(Year(dAuxData),4) == (cArqSF3)->ANO
		   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		   //³Posiciona na filial em que foi processado o registro	³
   		   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
           Mtr930Fil(aAreaSM0,(cArqSF3)->FILIAL,1)

           //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		   //³Verifica o valor do ICMS Retido de acordo com a configuracao da TES     ³
		   //³Quando o campo F3_CREST existir e estiver configurado como "4",         ³
		   //³o valor do ICMS retido nao deve ser apresentado na coluna de observacoes³
		   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
           lProcST := .T.
		   If lCredST
		       If F3_CREDST == "4"
                   lProcST := .F.
               Endif
           Endif

	       IF (cArqSF3)->CONTR!="*" 
	          dbseek((cArqSF3)->CHAVE)
	          If .T. //F3_ESTADO!="EX"
					If F3_FORMUL<>"S"
	 	            cClieFor	:=	F3_CLIEFOR+F3_LOJA
		            If nTipoMov==1
		               If(F3_TIPO$"DB",dbSelectArea("SA1"),dbSelectArea("SA2"))
		            Else
		               If(F3_TIPO$"DB",dbSelectArea("SA2"),dbSelectArea("SA1"))
		            Endif   
		            dbSeek(F3Filial(Alias())+cClieFor) //xFilial()
		            dbSelectArea("SF3")                                                
		
		            If nTipoMov==1
			           cInscr	:= If( F3_TIPO$"DB",SA1->A1_INSCR,SA2->A2_INSCR)
			           cTipo   	:= If( F3_TIPO$"DB",SA1->A1_TIPO,SA2->A2_TIPO)
	                else
			           cInscr	:= If( F3_TIPO$"DB",SA2->A2_INSCR,SA1->A1_INSCR)
	 		           cTipo 	:= If( F3_TIPO$"DB",SA2->A2_TIPO,SA1->A1_TIPO)
	                EndIf   
					If (ALLTRIM(F3_CFO)$"618/619/545/645/553/653/751/563/663") .Or. (ALLTRIM(F3_CFO)$"6107/6108/5258/6258/5307/6307/5357/6357") .or. "ISENT" $Upper(cInscr) .or. (empty(cInscr) .and. cTipo != "L")
	                   cContrib := "NC"
		            Else          
			           cContrib :=	"CO"
		            EndIf
		            if nTipoMov==1
			           cContrib :=	"CO"
		            EndIf	
		            nPos:=Ascan(aResumo,{|x|x[1]==cContrib.and.x[2]==F3_ESTADO})
		            If (Subs(F3_CFO,1,3) $ "999#000") // nao imprimi demonstrativo para transferencias	
		               If nPos==0
			              AADD(aResumo,{	cContrib,;					// [1] Flag de Contribuinte
			              F3_ESTADO,;					// [2] Estado
			              0.00,;	// [3] Valor Contabil
			              0.00,;	// [4] Base de Calculo
			              0.00,;	// [5] ICMS Outras
			              0.00,;	// [6] ICMS Retido
			              0.00,;	// [7] ICMS Isento
			           	  0.00,;	// [08] Valor do ICMS 
			           	  0.00,;	// [09] Base de Calculo IPI
			           	  0.00,;	// [10] Valor do IPI  
			           	  0.00,;	// [11] IPI Isento    
                          0.00,;   // [12] IPI Outras 
					      0.00,;  // [13] ICMS NORMAL
					      0.00,;  // [14] ICMS ST. INT.
					      0.00,; 	// [15] CRED PRES ST
					      GetMv("MV_ESTADO")})  // [16] UF onde esta localizada a Matriz/Filial
		               Endif
		            Else
		               If nPos==0
						If F3_TIPO<>"S"                   
			              AADD(aResumo,{	cContrib,;					// [1] Flag de Contribuinte
			              F3_ESTADO,;					// [2] Estado
			              F3_VALCONT,;	// [3] Valor Contabil
			              F3_BASEICM,;	// [4] Base de Calculo
			              F3_OUTRICM,;	// [5] ICMS Outras             
						  Iif(lProcST,F3_ICMSRET-IIF(lExist,F3_OBSSOL,0),0),;	// [6] ICMS Retido
					   	  F3_ISENICM,;	// [7] ICMS Isento
			           	  F3_VALICM,;	// [08] Valor do ICMS 
			           	  F3_BASEIPI,;	// [09] Base de Calculo IPI
			           	  F3_VALIPI,;	// [10] Valor do IPI  
			           	  F3_ISENIPI,;	// [11] IPI Isento    
			           	  F3_OUTRIPI,; // [12] IPI Outras 
			           	  IIF(lExist,F3_OBSICM,0),;  // [13] ICMS NORMAL  
			           	  IIF(lExist,F3_OBSSOL,0),;  // [14] ICMS ST. INT.	
			           	  IIF(FieldPos ("F3_CRPRST")>0, F3_CRPRST, 0),; //[15] CRED PRES ST
			           	  GetMv("MV_ESTADO")})  // [16] UF onde esta localizada a Matriz/Filial
			        	Endif
		               Else 
						If F3_TIPO<>"S"
			              aResumo[nPos,3]+=F3_VALCONT
			              aResumo[nPos,4]+=F3_BASEICM
			              aResumo[nPos,5]+=F3_OUTRICM
			              aResumo[nPos,6]+=Iif(lProcST,F3_ICMSRET-IIF(lExist,F3_OBSSOL,0),0)
			              aResumo[nPos,7]+=F3_ISENICM
	           		      aResumo[nPos,08]+=F3_VALICM
			           	  aResumo[nPos,09]+=F3_BASEIPI
			           	  aResumo[nPos,10]+=F3_VALIPI
			           	  aResumo[nPos,11]+=F3_ISENIPI
			           	  aResumo[nPos,12]+=F3_OUTRIPI		              
			           	  aResumo[nPos,13]+=IIF(lExist,F3_OBSICM,0)
			           	  aResumo[nPos,14]+=IIF(lExist,F3_OBSSOL,0)
			           	  aResumo[nPos,15]+=IIF(FieldPos ("F3_CRPRST")>0, F3_CRPRST,0)
			   			Endif
		               Endif
		            Endif   
	             Endif     
	          Endif   
	 		  RecLock(cArqSF3,.F.)
	          (cArqSF3)->CONTR :="*"
	          (cArqSF3)->(MsUnLock())
	       Endif   
	       (cArqSF3)->(dbSkip())
	       dbSelectArea("SF3")
	       Mtr930Fil(aAreaSM0,(cArqSF3)->FILIAL,2)
	   Enddo
	   (cArqSF3)->(dbSetOrder(1))
	   dbselectarea(cAliasSF3)
	Else                                           
  	   Mtr930Fil(aAreaSM0,cFilProc,1)
	   If .T. //F3_ESTADO!="EX"
		  cClieFor	:=	F3_CLIEFOR+F3_LOJA
		  If nTipoMov==1
		     If(F3_TIPO$"DB",dbSelectArea("SA1"),dbSelectArea("SA2"))
		  Else
		     If(F3_TIPO$"DB",dbSelectArea("SA2"),dbSelectArea("SA1"))
		  Endif   
		  dbSeek(F3Filial(Alias())+cClieFor)   //xFilial()
		  dbSelectArea(cArqTemp)                                                
		
          //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		  //³Verifica o valor do ICMS Retido de acordo com a configuracao da TES     ³
		  //³Quando o campo F3_CREST existir e estiver configurado como "4",         ³
		  //³o valor do ICMS retido nao deve ser apresentado na coluna de observacoes³
		  //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          lProcST := .T.
		  If lCredST
		      If F3_CREDST == "4"
                  lProcST := .F.
              Endif
          Endif

		  If nTipoMov==1
			 cInscr	:= If( F3_TIPO$"DB",SA1->A1_INSCR,SA2->A2_INSCR)
			 cTipo   	:= If( F3_TIPO$"DB",SA1->A1_TIPO,SA2->A2_TIPO)
	      else
			 cInscr	:= If( F3_TIPO$"DB",SA2->A2_INSCR,SA1->A1_INSCR)
	 		 cTipo 	:= If( F3_TIPO$"DB",SA2->A2_TIPO,SA1->A1_TIPO)
	      EndIf   
		  If (ALLTRIM(F3_CFO)$"618/619/545/645/553/653/751/563/663") .Or. (ALLTRIM(F3_CFO)$"6107/6108/5258/6258/5307/6307/5357/6357") .or. "ISENT" $Upper(cInscr) .or. (empty(cInscr) .and. cTipo != "L")
	         cContrib := "NC"
		  Else          
			 cContrib :=	"CO"
		  EndIf
		  if nTipoMov==1
			 cContrib :=	"CO"
		  EndIf	
		  nPos:=Ascan(aResumo,{|x|x[1]==cContrib.and.x[2]==F3_ESTADO})
	      If (Subs(F3_CFO,1,3) $ "999#000") // nao imprimi demonstrativo para transferencias	
		     If nPos==0
			    AADD(aResumo,{	cContrib,;					// [1] Flag de Contribuinte
	  		    F3_ESTADO,;					// [2] Estado
			    0.00,;	// [3] Valor Contabil
			    0.00,;	// [4] Base de Calculo
			    0.00,;	// [5] ICMS Outras
			    0.00,;	// [6] ICMS Retido
	           	0.00,;	// [7] ICMS Isento
	   	    	0.00,;	// [08] Valor do ICMS 
		    	0.00,;	// [09] Base de Calculo IPI
		    	0.00,;	// [10] Valor do IPI  
		    	0.00,;	// [11] IPI Isento    
                0.00,;  // [12] IPI Outras 
			    0.00,;  // [13] ICMS NORMAL
		        0.00,;  // [14] ICMS ST. INT.
		        0.00,;  // [15] CRED PRES ST 
		        GetMv("MV_ESTADO")})  // [16] UF onde esta localizada a Matriz/Filial
	         Endif
	      Else
		     If nPos==0
			    AADD(aResumo,{	cContrib,;					// [1] Flag de Contribuinte
	  		    F3_ESTADO,;					// [2] Estado
			    aSF3[ColF3("F3_VALCONT")],;	// [3] Valor Contabil
			    aSF3[ColF3("F3_BASEICM")],;	// [4] Base de Calculo
			    aSF3[ColF3("F3_OUTRICM")],;	// [5] ICMS Outras
			    Iif(lProcST,aSF3[ColF3("F3_ICMSRET")]-IIF(lExist,aSF3[ColF3("F3_OBSSOL")],0),0),;	// [6] ICMS Retido
			    aSF3[ColF3("F3_ISENICM")],;			// [7] ICMS Isento
			    aSF3[ColF3("F3_VALICM")],;			// [08] Valor do ICMS 
			    aSF3[ColF3("F3_BASEIPI")],;			// [09] Base de Calculo IPI
			    aSF3[ColF3("F3_VALIPI")],;			// [10] Valor do IPI  
			    aSF3[ColF3("F3_ISENIPI")],;			// [11] IPI Isento    
			    aSF3[ColF3("F3_OUTRIPI")],;			// [12] IPI Outras 
			    IIF(lExist,aSF3[ColF3("F3_OBSICM")],0),;	// [13] ICMS NORMAL   
			    IIF(lExist,aSF3[ColF3("F3_OBSSOL")],0),;	// [14] ICMS ST. INT.
            	IIF(FieldPos ("F3_CRPRST")>0, aSF3[ColF3("F3_CRPRST")], 0),;//[15] CRED PRES ST
            	GetMv("MV_ESTADO")})  // [16] UF onde esta localizada a Matriz/Filial
		     Else 
			    aResumo[nPos,03]+=aSF3[ColF3("F3_VALCONT")]
			    aResumo[nPos,04]+=aSF3[ColF3("F3_BASEICM")]
			    aResumo[nPos,05]+=aSF3[ColF3("F3_OUTRICM")]
			    aResumo[nPos,06]+=Iif(lProcST,(aSF3[ColF3("F3_ICMSRET")]-IIF(lExist,aSF3[ColF3("F3_OBSSOL")],0)),0)
			    aResumo[nPos,07]+=aSF3[ColF3("F3_ISENICM")]
			    aResumo[nPos,08]+=aSF3[ColF3("F3_VALICM")]
			    aResumo[nPos,09]+=aSF3[ColF3("F3_BASEIPI")]
			    aResumo[nPos,10]+=aSF3[ColF3("F3_VALIPI")]
			    aResumo[nPos,11]+=aSF3[ColF3("F3_ISENIPI")]
			    aResumo[nPos,12]+=aSF3[ColF3("F3_OUTRIPI")]
			    aResumo[nPos,13]+=IIF(lExist,aSF3[ColF3("F3_OBSICM")],0)
			    aResumo[nPos,14]+=IIF(lExist,aSF3[ColF3("F3_OBSSOL")],0)
			    aResumo[nPos,15]+=IIF(FieldPos ("F3_CRPRST")>0,aSF3[ColF3("F3_CRPRST")],0)
		     Endif
		  Endif   
	   Endif
	   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	   //³Restaura a filial e area corrente ³
	   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   Mtr930Fil(aAreaSM0,cFilProc,2)
	Endif
Endif
dbSelectArea(cSvAlias)

RETURN
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ LivrArrayObs ³Autor ³ Juan Jose Pereira    ³Data³ 17/02/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria array com mensagens da coluna de observacoes          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION LivrArrayObs(nTamObs,aArray, lListaNFO)

Local aSF3 		:= SF3->(GetArea())
Local aColObs	:= {}, lArray:=(aArray==NIL), xx:=0, cMensagem := ""
Local aSave		:= {Alias(),IndexOrd(),Recno()}
Local lExist 	:= IIF(SF3->F3_OBSSOL>0,.T.,.F.)
Local aArea 	:= {}
Local aAreaSM0 	:= SM0->(GetArea())
Local lCredST	:= SF3->(FieldPos("F3_CREDST")) > 0
Local lProcST	:= .F.                               
// Verifica se o valor do ICMS do frete autonomo devera ser apresentado nas observacoes do livro
Local lIcmAuto	:= GetNewPar("MV_FAUT930",.T.)

Default lListaNFO	:=	.F.

if type( "nColuna" ) =="U"
	nColuna := 1
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona na filial em que foi processado o registro	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Este posicionamento se faz necessario quando da utilizacao dos campos do SF3 na formula ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SF3->(dbSelectArea("SF3"))
SF3->(dbSetOrder(4))
SF3->(dbSeek(xFilial("SF3")+(cArqTemp)->F3_CLIEFOR+(cArqTemp)->F3_LOJA+(cArqTemp)->F3_NFISCAL+(cArqTemp)->F3_SERIE))

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

If lArray
   If !Empty(F3_OBSERV)
	   	aArea := GetArea ()
	   	//
   		If nModelo==1 .Or. nModelo==2
	   	   	If (lListaNFO) .And. ("N.F.ORIG.: DIVERSAS"$F3_OBSERV)
		   		cMensagem := Substr (F3_OBSERV, 1, At(":", F3_OBSERV)+1)
	   		    //
   	   			SD1->(DbSetOrder (1), MsSeek (xFilial ("SD1")+(cArqTemp)->F3_NFISCAL+(cArqTemp)->F3_SERIE+(cArqTemp)->F3_CLIEFOR+(cArqTemp)->F3_LOJA))
	   	   		//
   		   		Do While !SD1->(Eof ()) .And. xFilial ("SD1")==SD1->D1_FILIAL .And. (cArqTemp)->F3_NFISCAL==SD1->D1_DOC .And.;
   		   			(cArqTemp)->F3_SERIE==SD1->D1_SERIE .And. (cArqTemp)->F3_CLIEFOR==SD1->D1_FORNECE .And. (cArqTemp)->F3_LOJA==SD1->D1_LOJA
   		   			//
   	   				If !(AllTrim (SD1->D1_NFORI+"/"+SD1->D1_SERIORI)$cMensagem)
	   	   				cMensagem += AllTrim (SD1->D1_NFORI+"/"+SD1->D1_SERIORI)+", "
	   	   			EndIf
	   	   			SD1->(DbSkip ())
   		   		EndDo
   		   		//
		   		cMensagem := SubStr (cMensagem, 1, Len (cMensagem)-2)
		   	Else
				cMensagem := Trim(F3_OBSERV)
		    EndIf
   	  	Else
	   	   	If (lListaNFO) .And. (("Dev. terc. N.F.ORIG.: DIVERSAS"$F3_OBSERV) .Or. ("N.F.ORIG.: DIVERSAS"$F3_OBSERV))
		   		cMensagem := Substr (F3_OBSERV, 1, At(":", F3_OBSERV)+1)
	   		    //
   	   			SD2->(DbSetOrder (3), MsSeek (xFilial ("SD2")+(cArqTemp)->F3_NFISCAL+(cArqTemp)->F3_SERIE+(cArqTemp)->F3_CLIEFOR+(cArqTemp)->F3_LOJA))
	   	   		//
   		   		Do While !SD2->(Eof ()) .And. xFilial ("SD2")==SD2->D2_FILIAL .And. (cArqTemp)->F3_NFISCAL==SD2->D2_DOC .And.;
   		   			(cArqTemp)->F3_SERIE==SD2->D2_SERIE .And. (cArqTemp)->F3_CLIEFOR==SD2->D2_CLIENTE .And. (cArqTemp)->F3_LOJA==SD2->D2_LOJA
   		   			//
   	   				If !(AllTrim (SD2->D2_NFORI+"/"+SD2->D2_SERIORI)$cMensagem)
	   	   				cMensagem += AllTrim (SD2->D2_NFORI+"/"+SD2->D2_SERIORI)+", "
	   	   			EndIf
	   	   			SD2->(DbSkip ())
   		   		EndDo
   		   		//
		   		cMensagem := SubStr (cMensagem, 1, Len (cMensagem)-2)
		   	Else
				cMensagem := Trim(F3_OBSERV)
		    EndIf
   	  	EndIf
   	  	//
  		RestArea (aArea)
   		//
	   For xx:=1 to MlCount(cMensagem,nTamObs)
	  	   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If !Empty(F3_FORMULA) .And. !(OemToAnsi("CANCELADA")$F3_OBSERV)	//
	   cMensagem:=Formula(F3_FORMULA)
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If F3_VALOBSE>0 .And. F3_VALCONT>0
      If FieldPos("F3_DESCZFR")>0 .And. F3_DESCZFR>0
         cMensagem:="DESCONTO.....: "+Alltrim(TransForm(F3_VALOBSE,PesqPict("SF3","F3_VALOBSE")))+" ,SENDO "+Alltrim(TransForm(F3_DESCZFR,PesqPict("SF3","F3_DESCZFR")))+" DESCONTO ZFM"
	  Else                                                                                                    
	     cMensagem:="DESCONTO.....: "+Alltrim(TransForm(F3_VALOBSE,PesqPict("SF3","F3_VALOBSE"))) //"DESCONTO.....: "
	  Endif
	  //	   
	  For xx:=1 to MlCount(cMensagem,nTamObs)
	  	AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
  	  Next xx
   Endif 
   //
   If F3_IPIOBS>0
	   cMensagem:="IPI..........: "+Alltrim(TransForm(F3_IPIOBS,PesqPict("SF3","F3_IPIOBS"))) 
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If Empty(cTitLivro) .and. F3_ICMSRET-IIF(lExist,F3_OBSSOL,0) >0  .and. nColuna ==1 .And. lProcST
	   If !lExist
		   cMensagem:="IPI..........: "+Alltrim(TransForm(F3_BASERET,PesqPict("SF3","F3_BASERET"))) //
		   For xx:=1 to MlCount(cMensagem,nTamObs)
		   	   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
		   Next xx
   	   Endif    
	   cMensagem:="ICMS RETIDO..: "+Alltrim(TransForm(F3_ICMSRET-IIF(lExist,F3_OBSSOL,0),PesqPict("SF3","F3_ICMSRET"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
	   If FieldPos("F3_CRPRST")>0 .And. F3_CRPRST>0
   		cMensagem	:=	"CRED. PRES. ST: "+Alltrim (TransForm (F3_CRPRST, PesqPict ("SF3", "F3_CRPRST"))) //
	   	For xx:=1 to MlCount (cMensagem, nTamObs)
		   AADD (aColObs, {MemoLine (cMensagem, nTamObs, xx), .T.})
	   	Next xx
	   EndIf
   Endif
   If F3_ICMSCOM>0
	   cMensagem:="ICMS DIF.ALIQ: "+Alltrim(TransForm(F3_ICMSCOM,PesqPict("SF3","F3_ICMSCOM"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If F3_ICMAUTO>0 .And. lIcmAuto
	   cMensagem:="ICMS FRET.AUT: "+Alltrim(TransForm(F3_ICMAUTO,PesqPict("SF3","F3_ICMAUTO"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If SF3->(FieldPos("F3_VALTST")) > 0 .And. F3_VALTST>0 .And. lIcmAuto
	   cMensagem:="ICMSST FR.AUT: "+Alltrim(TransForm(F3_VALTST,PesqPict("SF3","F3_VALTST"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If F3_OBSICM>0
	   cMensagem:="ICMS NORMAL: "+Alltrim(TransForm(F3_OBSICM,PesqPict("SF3","F3_OBSICM"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If lExist .and. F3_OBSSOL>0 .And. lProcST
	   cMensagem:="ICMS ST. INT.: "+Alltrim(TransForm(F3_OBSSOL,PesqPict("SF3","F3_OBSSOL"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif   
Else
	dbSelectArea(cArqTemp)
   If (aArray[FieldPos("F3_VALOBSE")]>0 .And. aArray[FieldPos("F3_VALCONT")]>0) .And. ((F3_VALOBSE>0 .And. F3_VALCONT>0) .Or. (cArqTemp)->(EOF()))
      cMensagem:="DESCONTO.....: "+Alltrim(TransForm(aArray[FieldPos("F3_VALOBSE")],PesqPict("SF3","F3_VALOBSE"))) //
	  //
	  For xx:=1 to MlCount(cMensagem,nTamObs)
	  	 AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	  Next xx
   Endif
   If aArray[FieldPos("F3_IPIOBS")]>0
	   cMensagem:="IPI..........: "+Alltrim(TransForm(aArray[FieldPos("F3_IPIOBS")],PesqPict("SF3","F3_IPIOBS"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If Empty(cTitLivro).and.aArray[FieldPos("F3_ICMSRET")]-IIF(lExist,aArray[FieldPos("F3_OBSSOL")],0) >0  .and. nColuna ==1 .And. lProcST
	   If !lExist
		   cMensagem:="BASE ICMS RET: "+Alltrim(TransForm(aArray[FieldPos("F3_BASERET")],PesqPict("SF3","F3_BASERET"))) //
		   For xx:=1 to MlCount(cMensagem,nTamObs)
		  	   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	 	   Next xx
	   Endif	  
	   cMensagem:="ICMS RETIDO..: "+Alltrim(TransForm(aArray[FieldPos("F3_ICMSRET")]-IIF(lExist,aArray[FieldPos("F3_OBSSOL")],0),PesqPict("SF3","F3_ICMSRET"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
	 	  AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
  	   Next xx
   	   If FieldPos("F3_CRPRST")>0 .And. aArray[FieldPos("F3_CRPRST")]>0
	   		cMensagem	:=	"CRED. PRES. ST: "+Alltrim (TransForm (aArray[FieldPos("F3_CRPRST")], PesqPict ("SF3", "F3_CRPRST"))) //
		   	For xx:=1 to MlCount (cMensagem, nTamObs)
			   AADD (aColObs, {MemoLine (cMensagem, nTamObs, xx), .T.})
		   	Next xx
	   EndIf
   Endif
   If aArray[FieldPos("F3_ICMSCOM")]>0
	   cMensagem:="ICMS DIF.ALIQ: "+Alltrim(TransForm(aArray[FieldPos("F3_ICMSCOM")],PesqPict("SF3","F3_ICMSCOM"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
 	   Next xx
   Endif
   If aArray[FieldPos("F3_ICMAUTO")]>0 .And. lIcmAuto
	   cMensagem:="ICMS FRET.AUT: "+Alltrim(TransForm(aArray[FieldPos("F3_ICMAUTO")],PesqPict("SF3","F3_ICMAUTO"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If SF3->(FieldPos("F3_VALTST")) > 0 .And. aArray[FieldPos("F3_VALTST")]>0 .And. lIcmAuto
	   cMensagem:="ICMSST FR.AUT: "+Alltrim(TransForm(aArray[FieldPos("F3_VALTST")],PesqPict("SF3","F3_VALTST"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif
   If aArray[FieldPos("F3_OBSICM")]>0
	   cMensagem:="ICMS NORMAL: "+Alltrim(TransForm(aArray[FieldPos("F3_OBSICM")],PesqPict("SF3","F3_OBSICM"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif   
   If lExist .and. aArray[FieldPos("F3_OBSSOL")]>0 .And. lProcST
	   cMensagem:="ICMS ST. INT.: "+Alltrim(TransForm(aArray[FieldPos("F3_OBSSOL")],PesqPict("SF3","F3_OBSSOL"))) //
	   For xx:=1 to MlCount(cMensagem,nTamObs)
		   AADD(aColObs,{MemoLine(cMensagem,nTamObs,xx),.T.})
	   Next xx
   Endif   
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a filial e area corrente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Mtr930Fil(aAreaSM0,(cArqTemp)->FILCORR,2)

RestArea(aSF3)
dbSelectArea(aSave[1])
dbSetOrder(aSave[2])
dbGoto(aSave[3])

Return (aColObs)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ DefPeriodo   ³Autor ³ Juan Jose Pereira    ³Data³ 17/02/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Define Periodo de Apuracao                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION DefPeriodo(dData,nApuracao)

Local nPeriodo
Local nMes	:=	Month(dData)
Local nAno	:=	Year(dData)
Local dIniMes
Local dFimMes
Local aPeriodos:={}

dIniMes :=  CTOD("01/"+StrZero(nMes,2)+"/"+Substr(StrZero(nAno,4),3),"ddmmyy")
dFimMes	:=	UltimoDia(dIniMes)
Do Case
	Case nApuracao==1 // Decendial
		AADD(aPeriodos,{dIniMes,dIniMes+9})
		AADD(aPeriodos,{dIniMes+10,dIniMes+19})
		AADD(aPeriodos,{dIniMes+20,dFimMes})
	Case nApuracao==2 // Quinzenal
		AADD(aPeriodos,{dIniMes,dIniMes+14})
		AADD(aPeriodos,{dIniMes+15,dFimMes})
	Otherwise // Mensal
		AADD(aPeriodos,{dIniMes,dFimMes})
EndCase
If dData==CTOD("  /  /  ")
	nPeriodo:=0
Else
	nPeriodo:=Ascan(aPeriodos,{|x|x[1]<=dData.and.x[2]>=dData})
Endif

Return (nPeriodo)
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ColSF3       ³Autor ³ Juan Jose Pereira    ³Data³ 17/02/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Armazena e devolve colunas do SF3                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION ColF3(cColuna)

Local i:=0

If cColuna==NIL
	aColunas:={}
	For i:=1 to FCount()
		AADD(aColunas,FieldName(i))
	Next i
Else
	i:=Ascan(aColunas,Trim(cColuna))
Endif

Return(i)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CtrlPg() ³ Autor ³ Juan Jose Pereira     ³ Data ³02/02/1996³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Controla numeracao de paginas dos livros fiscais           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION CtrlPg(nPagina,nQtdPag,lReiniPg)

Local lFeixe:=.f.
Local aPaginas:={0,0}

lReiniPg	:=	IIF(lReiniPg==NIL,.f.,lReiniPg)
nQtdPag	:=	IIf(Empty(nQtdPag) .or. nQtdPag<=0,500,nQtdPag)

If nPagAnt <> 0
	nPagina	:=	If(nPagina==1,0,nPagina)
Endif
If (nPagina%nQtdPag==0)
	If lReiniPg
		nPagina:=0
	Endif
	aPaginas[1]:=nPagina
	aPaginas[2]:=nPagina+1
	nPagina:=nPagina+IIf(nPagAnt<>0,2,1)
	lFeixe:=.t.
Else
	nPagina++
	If (nPagina%nQtdPag==0)
		If lReiniPg
			nPagina:=0
		Endif
		aPaginas[1]:=nPagina
		aPaginas[2]:=nPagina+1
		nPagina:=nPagina+IIf(nPagAnt<>0,2,1)
		lFeixe:=.t.
	Endif
Endif
Return(aPaginas)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ImprimeTermo³Autor³ Juan Jose Pereira     ³ Data ³02/02/1996³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Imprime termos de abertura e encerramento dos livros fiscais³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION ImprimeTermo(nPagina,nPagIni,nQuebra,cArqTerm,nLargMax,cPerg)

Local	cSvAlias	:=	Alias()
Local	i
Local	aVariaveis:={}
Local w
Local j
Local cCaracter
Local cLinha
Local nPosAcento
Local	cAcentos:="€ú\‡ú\ú\ú\…ú\†ú\„ú\ ú\ú\ˆú\Šú\‚ú\¡ú\“ú\”ú\•ú\¢ú\£ú"
Local cAcSubst:="C,\c,\A~\A'\a`\a~\a~\a'\E'\e^\e`\e'\i'\o^\o~\o`\o'\U'"
Local aLayOut:={}
Local cTexto
Local uConteudo
Local cConteudo

If nPagina==0.or.!File(cArqTerm)
	Return
Endif
aadd(aVariaveis,{"VAR_IXB",VAR_IXB})
dbSelectArea("SM0")
For i:=1 to FCount()
	If FieldName(i)=="M0_CGC"
		AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R 99.999.999/9999-99")})
	ElseIf FieldName(i)=="M0_INSC"
		AADD(aVariaveis,{FieldName(i),InscrEst()})
	Else
		If FieldName(i)=="M0_NOME"
			Loop
		Endif
		AADD(aVariaveis,{FieldName(i),FieldGet(i)})
	Endif
Next

If AliasIndic( "CVB" )
	dbSelectArea( "CVB" )
	CVB->(dbSeek( xFilial( "CVB" ) ))
	For i:=1 to FCount()
		If FieldName(i)=="CVB_CGC"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R 99.999.999/9999-99")})
		ElseIf FieldName(i)=="CVB_CPF"
			AADD(aVariaveis,{FieldName(i),Transform(FieldGet(i),"@R 999.999.999-99")})
		Else
			AADD(aVariaveis,{FieldName(i),FieldGet(i)})
		Endif
	Next
EndIf

dbSelectArea("SX1")
dbSeek(cPerg+"01")
While SX1->X1_GRUPO==cPerg
	uConteudo	:=	&(X1_VAR01)
	If Valtype(uConteudo)=="N"
		cConteudo	:=	Alltrim(Str(uConteudo))
	Elseif Valtype(uConteudo)=="D"
		cConteudo	:=	Alltrim(dToc(uConteudo))
	Else
		cConteudo	:=	Alltrim(uConteudo)
	Endif
	AADD(aVariaveis,{Rtrim(Upper(X1_VAR01)),cConteudo})
	dbSkip()
End
                        
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ordena os arrays colocando primeiro a variavel de tamanho    ³
//³ maior para que a rotina nao pegue uma variavel menor         ³
//³ primeiro ( exemplo M0_TEL e M0_TEL_IMP )                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ASort( aVariaveis,,, { |x,y| Len( x[1] ) > Len( y[1] ) } ) 

AADD(aVariaveis,{"__PAGINAINICIAL",Transform(StrZero(nPagIni,6),"@R 999.999")})
AADD(aVariaveis,{"__PAGINAFINAL",Transform(StrZero(nPagina,6),"@R 999.999")})
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inclusao de variaveis especificas                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aVariaveis,{"M_DIA",StrZero(Day(dDataBase),2)})
AADD(aVariaveis,{"M_MES",MesExtenso()})
AADD(aVariaveis,{"M_ANO",StrZero(Year(dDataBase),4)})

cTexto:=MemoRead(cArqTerm)
For w:=1 to len(aVariaveis)
	cTexto	:=	StrTran(cTexto,aVariaveis[w,1],if(valtype(aVariaveis[w,2])<>"C" .and. valtype(aVariaveis[w,2])<>"U",if(valtype(avariaveis[w,2])="D",dtoc(aVariaveis[w,2]),str(aVariaveis[w,2])),aVariaveis[w,2]))
Next
@ 0,0 PSAY AvalImp(nLargMax)

For i:=1 to Mlcount(cTexto,nLargMax)
	
	SysRefresh()
	If Interrupcao(@lAbortPrint)
		Exit
	Endif
	cLinha	:=	MemoLine(cTexto,nLargMax,i)
	cLinha	:=	Strtran(cLinha,chr(13)+chr(10))
	For j:=1 to Len(cLinha)
		cCaracter	:=	Substr(cLinha,j,1)
		nPosAcento	:=	Rat(cAcentos,cCaracter)
		If nPosAcento>0
			cCaracter:=Substr(AcSubst,nPosAcento,2)
			@ i,j PSAY Substr(cCaracter,1,1)
			@ i,j PSAY Substr(cCaracter,2,1)
		Else
			@ i,j PSAY cCaracter
		Endif
	Next j
Next i

dbSelectArea(cSvAlias)

Return (nPagina)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R930CFOTra ³Autor³    Marcos Simidu      ³ Data ³23/04/1997³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Analisa CFO de Servicos de Transporte.                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION R930CFOTra(cCFO,cSerie)

Local cAllCFO := "161/162/163/164/165/261/262/263/264/351/352/353/354/561/562/563/661/662/663/1351/1352/1353/1354/1355/1356/2351/2352/2353/2354/3351/3352/3353/3354/5351/5352/5357/6351/6352/6357"
Local cEspecie:= If( At(cCFO,cAllCFO) > 0, "CT" , "NF" )

If ( substr(cCFO,1,3) == "999" ) //Notas Canceladas
	cEspecie := a460Especie(cSerie)
EndIf

Return(cEspecie)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  ExistNF   ³Autor³    Marcos Simidu      ³ Data ³09/12/1997³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se existe NF em outro livro.                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ExistNF(cNota,cSerNF,cNumero,cLivros,cFilCorr)
Local lRet	:=.F.
Local cAlias:=Alias()                                  
Local aAreaSM0	:= SM0->(GetArea())

Default cFilCorr := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona na filial em que foi processado o registro	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Mtr930Fil(aAreaSM0,cFilCorr,1)

dbSelectArea("SF3")
dbSetOrder(5)
SF3->(dbSeek(xFilial()+cSerNF+cNota,.F.) .And. cNumero$cLivros)

while !eof() .and. xFilial("SF3")+SF3->F3_SERIE+SF3->F3_NFISCAL == xFilial("SF3")+cSerNF+cNota
	If Val(substr(F3_CFO,1,1))<5 .and. F3_FORMUL =="S"
		lRet:= .T.
		Exit
	ElseIf Val(substr(F3_CFO,1,1))>=5 
		lRet:= .T.
		Exit      
	EndIf
	dbSkip()
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Restaura a filial e area corrente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Mtr930Fil(aAreaSM0,cFilCorr,2)

dbSelectArea(cAlias)

Return(lRet)


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³  GravaTemp   ³Autor ³  Edstron             ³Data³ 06/04/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava Registro no Arquivo Temporario                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravaTemp(cNFIni,cNFFim,aFixos,aLivro,dData,cEst,cEsp,cCliente,cLoja,dDtCan1,cMov,lDesconto,nAliq,cSer,cCFO,cFormula,lSemMov,cFilProc)
Local i:=0
Default cFormula	:=SPACE(03)
Default lSemMov		:=.F.
Default cFilProc	:= xFilial("SF3")

If !lSemMov
	dbSelectArea(cArqTemp)
	dbSeek(cFilProc+cSer+STRZERO(VAL(cNFIni),TamSX3("F2_DOC")[1])+Str(nAliq,5,2)+Iif ("S"$F3_TIPO, "999 ", cCFO)+cFormula,.F.)
	If !eof() 
		RecLock(cArqTemp,.F.)
		For i:=1 To Len(aFixos)
		    If aFixos[i,1]<>"XXX"
		       If ValType(aFixos[i,2])$"CD".Or.aFixos[i,1]=="F3_ALIQICM"
			      Replace &(aFixos[i,1]) With aLivro[i]
			   Else
	              If lAglutina .And. nTipomov <> 1
			         Replace &(aFixos[i,1]) With aLivro[i]
	              Else
			         Replace &(aFixos[i,1]) With &(aFixos[i,1])+aLivro[i]
			      Endif   
			   Endif   
			Endif   
		Next
	Else
	   RecLock(cArqTemp,.T.)
	   For i:=1 To Len(aFixos)
		   Replace &(aFixos[i,1]) With aLivro[i]
	   Next
	   (cArqTemp)->F3_FILIAL 	:= cFilProc
	   (cArqTemp)->F3_ENTRADA	:= dData
	   (cArqTemp)->F3_EMISSAO	:= dData
	   (cArqTemp)->F3_NFISCAL	:= cNFIni
	   (cArqTemp)->F3_SERIE  	:= cSer
	   (cArqTemp)->F3_ESTADO	:= cEst
	   (cArqTemp)->F3_ESPECIE	:= cEsp
	   (cArqTemp)->F3_CLIEFOR	:= cCliente
	   (cArqTemp)->F3_LOJA  	:= cLoja
	Endif
	(cArqTemp)->F3_DOCOR	:= If(Empty(SF3->F3_DOCOR),cNFFim,SF3->F3_DOCOR)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Corrige numeracao da Nota                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If cMov=="S"		//.and.lLacuna
	   (cArqTemp)->NUMNOTA := STRZERO(VAL(cNFIni),TamSX3("F2_DOC")[1])
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Zera valor de desconto para nao ser escriturado              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !lDesconto
	   (cArqTemp)->F3_VALOBSE := 0
	Endif
	
	IF !EMPTY(dDtCan1)
	   (cArqTemp)->F3_DTCANC := dDtCan1
	ENDIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Altera registro de notas de Formulario Proprio na Saida e    ³
	//³ Notas fiscais de Servico                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If F3_FORMUL=="S" .or. F3_TIPO=="S" .or. !Empty(F3_DTCANC)
	   For i:=1 to FCount()
	       If Valtype(FieldGet(i))=="N"
		  	  FieldPut(i,0)
		   Endif
	   Next   
	   If F3_FORMUL=="S" .AND. Empty(F3_DTCANC)		
	 	 (cArqTemp)->F3_OBSERV := "NT.FISCAL DE ENTRADA" //
	   ElseIf F3_FORMUL=="S" .AND. !Empty(F3_DTCANC)
		 (cArqTemp)->F3_OBSERV := "CANCELADA" //
	   ElseIf !Empty(F3_DTCANC)
		 (cArqTemp)->F3_OBSERV := "CANCELADA" //
	   Else
		 (cArqTemp)->F3_OBSERV := "NT.FISCAL DE SERVICO" + " " + (cArqTemp)->F3_OBSERV //
	   EndIf
	   (cArqTemp)->F3_CFO	:= "999"
	   (cArqTemp)->F3_TIPO	:= SF3->F3_TIPO
	Endif                              
	(cArqTemp)->FILCORR := cFilAnt	                                                              	
	MsUnlock()		
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Grava o registro para impressão dos periodos sem movimento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	RecLock(cArqTemp,.T.)
	(cArqTemp)->F3_FILIAL 	:= cFilProc
	(cArqTemp)->F3_ENTRADA	:= dData
	(cArqTemp)->F3_EMISSAO	:= dData
	(cArqTemp)->F3_NFISCAL	:= cNFIni
	(cArqTemp)->F3_SERIE  	:= cSer
	(cArqTemp)->F3_ESTADO	:= cEst
	(cArqTemp)->F3_ESPECIE	:= cEsp
	(cArqTemp)->F3_CLIEFOR	:= cCliente
	(cArqTemp)->F3_LOJA  	:= cLoja
	(cArqTemp)->SEMMOV 		:= .T.
	(cArqTemp)->FILCORR		:= cFilAnt	                                                              
	MsUnLock()
Endif
RETURN(.t.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTR930ApurºAutor  ³Mary C. Hergert     º Data ³ 23/09/2004  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica os dados da Apuracao de ICMS para impressao        º±±
±±º          ³do Resumo do Produtor Rural                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Matr930                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Mtr930Apur(nApurICM,nAno,nMes,cNrLivro)

	Local aArqApur	:= {}
	Local aCampos	:= {}                  
	Local aProdutor	:= {}
	Local nPeriodo	:= 0       
	Local nX		:= 0
	Local cArqApur	:= ""

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Valores adquiridos na apuracao (aProdutor):³
	//³001 - Estorno de Credito                   ³
	//³002 - Saldo Credor do Periodo Anterior     ³
	//³003 - Transferência de Crédito             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	AADD(aProdutor,{0,0,0,0})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tipos de Apuracao (nApurICM):³
	//³ 1 - Decendial                ³
	//³ 2 - Quinzenal                ³
	//³ 3 - Mensal                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
	Case nApurICM == 1 
		AADD(aArqApur,NmArqApur("IC",nAno,nMes,1,1,cNrLivro))
		AADD(aArqApur,NmArqApur("IC",nAno,nMes,1,2,cNrLivro))
		AADD(aArqApur,NmArqApur("IC",nAno,nMes,1,3,cNrLivro))
		AADD(aArqApur,NmArqApur("IC",nAno,nMes,1,4,cNrLivro))
	Case nApurICM == 2
		AADD(aArqApur,NmArqApur("IC",nAno,nMes,1,1,cNrLivro))
		AADD(aArqApur,NmArqApur("IC",nAno,nMes,1,2,cNrLivro))
	Case nApurICM == 3
		AADD(aArqApur,NmArqApur("IC",nAno,nMes,1,0,cNrLivro))
	EndCase
	
	For nX := 1 to Len(aArqApur)

		nPeriodo := nX
		cArqApur := aArqApur[nX]
	
		If (File(cArqApur))
			FT_FUse(cArqApur)
			FT_FGotop()
			aCampos		:=	{.f.,.f.,.f.,.f.,.f.}
			While (!FT_FEof()) 
				cLinha	:= AllTrim(FT_FReadLN())
                Do Case
                Case SubStr(cLinha,86,6) == "003.00" // Estorno de Credito
                	aProdutor[01][01] += Val(StrTran(StrTran(SubStr(cLinha,52,18),".",""),",","."))
                Case SubStr(cLinha,1,3) == "009" // Saldo Credor do Periodo Anterior
                	aProdutor[01][02] += Val(StrTran(StrTran(SubStr(cLinha,52,18),".",""),",","."))
                Case SubStr(cLinha,1,3) == "021" // Transferencia de Credito
	                aProdutor[01][03] += Val(StrTran(StrTran(SubStr(cLinha,52,18),".",""),",","."))
                Case SubStr(cLinha,1,3) == "001" // Por saidas com debito de imposto
	                aProdutor[01][04] += Val(StrTran(StrTran(SubStr(cLinha,52,18),".",""),",","."))
                EndCase
				FT_FSkip()
			Enddo
		EndIf
	Next
	FT_FUse()                   
	
	Return(aProdutor)
	
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjustaSX1 ºAutor  ³Mary C. Hergert     º Data ³ 23/09/2004  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ajusta grupo de perguntas                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       |MATR930                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AjustaSX1()    

	Local aHelpP  := {}
	Local aHelpE  := {}
	Local aHelpS  := {}  
	Local cKey    := ""                  // Chave para atualizar o help da pergunte
	
	// mv_par29 - Imprime o Resumo de Produtor Rural no Livro P1A
	Aadd( aHelpP, "Imprime o Resumo Mensal de Produtor     " )
	Aadd( aHelpP, "Rural no modelo de Entrada P1A?         " )
	Aadd( aHelpP, "                                        " ) 
	
	Aadd( aHelpE, "Imprime o Resumo Mensal de Produtor     " )
	Aadd( aHelpE, "Rural no modelo de Entrada P1A?         " )
	Aadd( aHelpE, "                                        " ) 
	
	Aadd( aHelpS, "Imprime o Resumo Mensal de Produtor     " )
	Aadd( aHelpS, "Rural no modelo de Entrada P1A?         " )
	Aadd( aHelpS, "                                        " ) 
	PutSx1("MTR930","29","Resumo Produtor?","Resumo Produtor?","Resumo Produtor?","mv_cht","N",01,0,2,"C","","","","","mv_par29","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",aHelpP,aHelpE,aHelpS)

    _cPg := "MTR930    "
	
	dbSelectArea("SX1")
	//MsSeek("MTR93003")
	DbSeek(_cPg+"03")
	RecLock("SX1",.F.)
	SX1->X1_DEF05   := "Simples"
	SX1->X1_DEFSPA5 := "Simples"
	SX1->X1_DEFENG5 := "Simples"
	MsUnLock()

	aHelpP  := {}
	aHelpE  := {}
	aHelpS  := {}
	
	Aadd( aHelpP, "Imprime para equipamento de emissor     " )
	Aadd( aHelpP, "de cupom fiscal - ECF                   " )

	Aadd( aHelpE, "Imprime para equipamento de emissor     " )
	Aadd( aHelpE, "de cupom fiscal - ECF                   " )

	Aadd( aHelpS, "Imprime para equipamento de emissor     " )
	Aadd( aHelpS, "de cupom fiscal - ECF                   " )
    
	If !(MsSeek("MTR930" + "30" ))
	   PutSx1("MTR930","30","Cupom Fiscal?","Comprobante Fiscal?","Fiscal Voucher?","mv_chu","N",01,0,2,"C","","","","","mv_par30","Sim","Si","Yes","","Nao","No","No","","","","","","","","","",aHelpP,aHelpE,aHelpS)
	Else
		RecLock("SX1",.F.)
        SX1->X1_PERGUNT:= "Cupom Fiscal?"
		SX1->X1_PERSPA := "Comprobante Fiscal?"
		SX1->X1_PERENG := "Fiscal Voucher?"

		SX1->X1_DEF01   := "Sim"
		SX1->X1_DEFSPA1 := "Si"
		SX1->X1_DEFENG1 := "Yes"

		SX1->X1_DEF02   := "Nao"
		SX1->X1_DEFSPA2 := "No"
		SX1->X1_DEFENG2 := "No"
		
		cKey  := "P.MTR93030."		
		PutSX1Help(cKey,aHelpP,aHelpE,aHelpS)
		
		MsUnLock()	       
	Endif   
	
	aHelpP  := {}
	aHelpE  := {}
	aHelpS  := {}
	Aadd( aHelpP, "Informe se deseja processar mais de uma " )
	Aadd( aHelpP, "filial na emissao do relatorio. Serao   " )
	Aadd( aHelpP, "apresentadas todas as notas fiscais do  " )
	Aadd( aHelpP, "periodo das filiais selecionadas.       " )
	
	Aadd( aHelpE, "Informe se deseja processar mais de uma " )
	Aadd( aHelpE, "filial na emissao do relatorio. Serao   " )
	Aadd( aHelpE, "apresentadas todas as notas fiscais do  " )
	Aadd( aHelpE, "periodo das filiais selecionadas.       " )
	
	Aadd( aHelpS, "Informe se deseja processar mais de uma " )
	Aadd( aHelpS, "filial na emissao do relatorio. Serao   " )
	Aadd( aHelpS, "apresentadas todas as notas fiscais do  " )
	Aadd( aHelpS, "periodo das filiais selecionadas.       " )
	
	PutSx1("MTR930","31","Processa Filiais ?","Processa Filiais ?","Processa Filiais ?","mv_chv","N",01,0,2,"C","","","","","mv_par31","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",aHelpP,aHelpE,aHelpS)
	
	aHelpP  := {}
	aHelpE  := {}
	aHelpS  := {}
	Aadd( aHelpP, "Informe a filial inicial para o         " )
	Aadd( aHelpP, "processamento centralizado do relatório." )
	Aadd( aHelpP, "Caso o processamento não seja           " )
	Aadd( aHelpP, "centralizado, deixar esta pergunta em   " )
	Aadd( aHelpP, "branco.                                 " )
	
	Aadd( aHelpE, "Informe a filial inicial para o         " )
	Aadd( aHelpE, "processamento centralizado do relatório." )
	Aadd( aHelpE, "Caso o processamento não seja           " )
	Aadd( aHelpE, "centralizado, deixar esta pergunta em   " )
	Aadd( aHelpE, "branco.                                 " )
	
	Aadd( aHelpS, "Informe a filial inicial para o         " )
	Aadd( aHelpS, "processamento centralizado do relatório." )
	Aadd( aHelpS, "Caso o processamento não seja           " )
	Aadd( aHelpS, "centralizado, deixar esta pergunta em   " )
	Aadd( aHelpS, "branco.                                 " )
	
	PutSx1("MTR930","32","Filial de ?","Filial de ?","Filial de ?","mv_chx","C",2,0,0,"G","","","","","mv_par32","","","","","","","","","","","","","","","","",aHelpP,aHelpE,aHelpS)
	
	aHelpP  := {}
	aHelpE  := {}
	aHelpS  := {}
	Aadd( aHelpP, "Informe a filial final para o           " )
	Aadd( aHelpP, "processamento centralizado do relatório." )
	Aadd( aHelpP, "Caso o processamento não seja           " )
	Aadd( aHelpP, "centralizado, deixar esta pergunta em   " )
	Aadd( aHelpP, "branco.                                 " )
	
	Aadd( aHelpE, "Informe a filial final para o           " )
	Aadd( aHelpE, "processamento centralizado do relatório." )
	Aadd( aHelpE, "Caso o processamento não seja           " )
	Aadd( aHelpE, "centralizado, deixar esta pergunta em   " )
	Aadd( aHelpE, "branco.                                 " )
	
	Aadd( aHelpS, "Informe a filial final para o           " )
	Aadd( aHelpS, "processamento centralizado do relatório." )
	Aadd( aHelpS, "Caso o processamento não seja           " )
	Aadd( aHelpS, "centralizado, deixar esta pergunta em   " )
	Aadd( aHelpS, "branco.                                 " )
	
	PutSx1("MTR930","33","Filial ate ?","Filial ate ?","Filial ate ?","mv_chz","C",2,0,0,"G","","","","","mv_par33","","","","","","","","","","","","","","","","",aHelpP,aHelpE,aHelpS)

/*
Correção do help para pergunta 03 "IMPRIME MODELO"
	Escolha o modelo de impressão do relatório.
	Opções:
	1)Entradas P1 - O livro Registro de Entradas, modelo P1, destina-se à escrituração da entrada, a qualquer título, de mercadoria no estabelecimento ou de serviço por este tomado que caracterize a apuração de valores relativos ao ICMS e IPI. 
	2)Entradas P1A - O livro Registro de Entradas, modelo P1A, destina-se à escrituração da entrada, a qualquer título, de mercadoria no estabelecimento ou de serviço por este tomado que caracterize a apuração de valores relativos somente ao ICMS.
	3)Saídas P2 - O livro Registro de Saídas, modelo P2, destina-se à escrituração da saída de mercadoria, a qualquer título, ou da prestação de serviço que caracterize a apuração de valores relativos ao ICMS e IPI. 
	4)Saídas P2A - O livro Registro de Saídas, modelo P2, destina-se à escrituração da saída de mercadoria, a qualquer título, ou da prestação de serviço que caracterize a apuração de valores relativos somente ao ICMS.
	5)Simples - Trata-se de um regime tributário simplificado, concedido às microempresas e empresas de pequeno porte do estado de São Paulo que atenderem as disposições previstas na Lei
*/
//PORTUGUÊS
aHelpP  := {}
AADD(aHelpP,"Escolha o modelo de impressão do")
AADD(aHelpP,"relatório.")
AADD(aHelpP,"Opções:")
AADD(aHelpP,"1)Entradas P1 - O livro Registro de")
AADD(aHelpP,"Entradas, modelo P1, destina-se à")
AADD(aHelpP,"escrituração da entrada, a qualquer")
AADD(aHelpP,"título, de mercadoria no estabelecimento")
AADD(aHelpP,"ou de serviço por este tomado que ")
AADD(aHelpP,"caracterize a apuração de valores ")
AADD(aHelpP,"relativos ao ICMS e IPI.")
AADD(aHelpP,"2)Entradas P1A - O livro Registro de")
AADD(aHelpP,"Entradas, modelo P1A, destina-se à ")
AADD(aHelpP,"escrituração da entrada, a qualquer ")
AADD(aHelpP,"título, de mercadoria no estabelecimento")
AADD(aHelpP,"ou de serviço por este tomado que")
AADD(aHelpP,"caracterize a apuração de valores ")
AADD(aHelpP,"relativos somente ao ICMS.")
AADD(aHelpP,"3)Saídas P2 - O livro Registro de")
AADD(aHelpP,"Saídas, modelo P2, destina-se à ")
AADD(aHelpP,"escrituração da saída de mercadoria, à ")
AADD(aHelpP,"qualquer título, ou da prestação de")
AADD(aHelpP,"serviço que caracterize a apuração ")
AADD(aHelpP,"de valores relativos ao ICMS e IPI.")
AADD(aHelpP,"4)Saídas P2A - O livro Registro de ")
AADD(aHelpP,"Saídas, modelo P2, destina-se à")
AADD(aHelpP,"escrituração da saída de mercadoria, a")
AADD(aHelpP,"qualquer título, ou da prestação de ")
AADD(aHelpP,"serviço que caracterize a apuração de")
AADD(aHelpP,"valores relativos somente ao ICMS.")
AADD(aHelpP,"5)Simples - Trata-se de um regime ")
AADD(aHelpP,"tributário simplificado, concedido")
AADD(aHelpP,"às microempresas e empresas de pequeno")
AADD(aHelpP,"porte do estado de São Paulo que ")
AADD(aHelpP,"atenderem as disposições previstas ")
AADD(aHelpP,"na Lei.")
//INGLÊS
aHelpE:={}
AADD(aHelpE,"Choose the report printing model")
AADD(aHelpE,"Options:")
AADD(aHelpE,"1)Inflows P1 – The Inflow Registration ")
AADD(aHelpE,"book, model P1, is aimed at registering")
AADD(aHelpE,"the inflow, of any kind, of goods in the ")
AADD(aHelpE,"establishment or of services taken by")
AADD(aHelpE,"which may result in calculations of")
AADD(aHelpE,"values related to ICMS and IPI.")
AADD(aHelpE,"2)Inflows P1A - The Inflow Registration")
AADD(aHelpE,"book,model P1A, is aimed at registering")
AADD(aHelpE,"the inflow, of any kind, of goods in the ")
AADD(aHelpE,"establishment or of services rendered ")
AADD(aHelpE,"which may result in calculations of ")
AADD(aHelpE,"values related only to ICMS.  ")
AADD(aHelpE,"3)Outflows P2 - The Outflow Registration")
AADD(aHelpE,"book, model P2, is aimed at registering ")
AADD(aHelpE,"the outflow of goods, of any kind, or of")
AADD(aHelpE,"services rendered which may result in ")
AADD(aHelpE,"calculations of values related to ICMS ")
AADD(aHelpE,"and IPI.  ")
AADD(aHelpE,"4)Outflows P2A - The Outflow Registration ")
AADD(aHelpE,"book, model P2, is aimed at registering")
AADD(aHelpE," the outflow of goods, of any kind, or ")
AADD(aHelpE,"of services rendered which may result ")
AADD(aHelpE,"in calculations of values related only ")
AADD(aHelpE,"to ICMS.")
AADD(aHelpE,"5) Simple – It is about a simplified tax")
AADD(aHelpE,"system granted to micro and small-sized")
AADD(aHelpE,"companies of the State of Sao Paulo ")
AADD(aHelpE,"which meet the dispositions set forth in")
AADD(aHelpE,"the Law.")

//ESPANHOL
aHelpS:={}
AADD(aHelpS,"Elija el modelo de impresión del")
AADD(aHelpS,"informe.")
AADD(aHelpS,"Opciones:")
AADD(aHelpS,"1) Entradas P1 – El libro Registro de")
AADD(aHelpS,"Entradas, modelo P1 se destina al")
AADD(aHelpS,"registro de la entrada, a cualquier ")
AADD(aHelpS,"título, de mercadería en el ")
AADD(aHelpS,"establecimiento o de servicio tomado por")
AADD(aHelpS,"éste que caracterice el cálculo de ")
AADD(aHelpS,"valores relativos al ICMS y al IPI. ")
AADD(aHelpS,"2) Entradas P1A – El libro Registro de ")
AADD(aHelpS,"Entradas, modelo P1A se destina al ")
AADD(aHelpS,"registro de la entrada, a cualquier ")
AADD(aHelpS,"título, de mercadería en el ")
AADD(aHelpS,"establecimiento o de servicio tomado por")
AADD(aHelpS,"éste que caracterice el cálculo de")
AADD(aHelpS,"valores relativos únicamente al ICMS.")
AADD(aHelpS,"3) Entradas P2 – El libro Registro de ")
AADD(aHelpS,"Salidas, modelo P2 se destina al ")
AADD(aHelpS,"registro de la salida de mercadería, a")
AADD(aHelpS,"cualquier título, o de la cuota de")
AADD(aHelpS,"servicio que caracterice el cálculo ")
AADD(aHelpS,"de valores relativos al ICMS y al IPI. ")
AADD(aHelpS,"4) Salidas P2A – El libro Registro de")
AADD(aHelpS,"Salidas, modelo P2 se destina al")
AADD(aHelpS,"registro de la salida de mercadería, a")
AADD(aHelpS,"cualquier título, o de la cuota de ")
AADD(aHelpS,"servicio que caracterice el cálculo")
AADD(aHelpS,"de valores relativos únicamente al ICMS.")
AADD(aHelpS,"5) Simples - Se trata de un régimen")
AADD(aHelpS,"tributario simplificado, concedido")
AADD(aHelpS,"a microempresas y empresas de pequeño")
AADD(aHelpS,"porte del estado de São Paulo que")
AADD(aHelpS,"cumplen las disposiciones previstas ")
AADD(aHelpS,"en la ley.")
PutSX1Help("P.MTR93003.",aHelpP,aHelpE,aHelpS)

aHelpP	:=	{}
aHelpE	:=	{}
aHelpS	:=	{}
Aadd (aHelpP, "Atendimento ao Art. 121 do ANEXO 5 do   ")	//
Aadd (aHelpP, "RICMS/SC. O mesmo determina que todo    ")	//
Aadd (aHelpP, "prestador de serviço de transporte deve ")	//
Aadd (aHelpP, "apresentar as obrigações acessórias de  ")	//
Aadd (aHelpP, "forma consolidada pelo estabelecimento  ")	//
Aadd (aHelpP, "matriz, e esta consolidação deverá      ")	//
Aadd (aHelpP, "abranger somente as empresas que estive-")	//
Aadd (aHelpP, "rem domiciliadas no mesmo estado do es- ")	//
Aadd (aHelpP, "tabelecimento consolidador.             ")	//

Aadd (aHelpE, "Atendimento ao Art. 121 do ANEXO 5 do   ")	//
Aadd (aHelpE, "RICMS/SC. O mesmo determina que todo    ")	//
Aadd (aHelpE, "prestador de serviço de transporte deve ")	//
Aadd (aHelpE, "apresentar as obrigações acessórias de  ")	//
Aadd (aHelpE, "forma consolidada pelo estabelecimento  ")	//
Aadd (aHelpE, "matriz, e esta consolidação deverá      ")	//
Aadd (aHelpE, "abranger somente as empresas que estive-")	//
Aadd (aHelpE, "rem domiciliadas no mesmo estado do es- ")	//
Aadd (aHelpE, "tabelecimento consolidador.             ")	//

Aadd (aHelpS, "Atendimento ao Art. 121 do ANEXO 5 do   ")	//
Aadd (aHelpS, "RICMS/SC. O mesmo determina que todo    ")	//
Aadd (aHelpS, "prestador de serviço de transporte deve ")	//
Aadd (aHelpS, "apresentar as obrigações acessórias de  ")	//
Aadd (aHelpS, "forma consolidada pelo estabelecimento  ")	//
Aadd (aHelpS, "matriz, e esta consolidação deverá      ")	//
Aadd (aHelpS, "abranger somente as empresas que estive-")	//
Aadd (aHelpS, "rem domiciliadas no mesmo estado do es- ")	//
Aadd (aHelpS, "tabelecimento consolidador.             ")	//

PutSx1("MTR930","34","Consolidação na mesma UF","Consolidação na mesma UF","Consolidação na mesma UF","mv_chw","N",1,0,2,"C","","","","","mv_par34","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",aHelpP,aHelpE,aHelpS)	//######

aHelpP  := {}
aHelpE  := {}
aHelpS  := {}

Aadd( aHelpP, "Informe a taxa de conversão de UFIR para ") //
Aadd( aHelpP, "o Simples do Estado do Rio de Janeiro ") //
Aadd( aHelpE, "Informe a taxa de conversão de UFIR para ") //
Aadd( aHelpE, "o Simples do Estado do Rio de Janeiro ") //
Aadd( aHelpS, "Informe a taxa de conversão de UFIR para ") //
Aadd( aHelpS, "o Simples do Estado do Rio de Janeiro ") //

PutSx1("MTR930","35","Taxa UFIR?","Taxa UFIR?","Taxa UFIR?","mv_chy","N",10,4,0,"G","","","","","mv_par35","","","","","","","","","","","","","","","","",aHelpP,aHelpE,aHelpS) //

aHelpP  := {}
aHelpE  := {}
aHelpS  := {}

Aadd( aHelpP, "Informe se a impressão do livro deverá ") // 
Aadd( aHelpP, "ser subdividida, ou seja, deverão ser  " ) // 
Aadd( aHelpP, "impressas: 1-Totalidade das operações  ") // 
Aadd( aHelpP, "2-Operações estaduais ou 3 - Operações ") //  
Aadd( aHelpP, "interestaduais. No caso das operações  ") //  
Aadd( aHelpP, "estaduais ou interestaduaais, o livro  ") // 
Aadd( aHelpP, "será impresso apenas com os movimentos ") // 
Aadd( aHelpP, "estaduais ou interestaduais, sendo que ") // 
Aadd( aHelpP, "o título do livro irá indicar o tipo de") // 
Aadd( aHelpP, "operação apresentada. Caso selecione a ") // 
Aadd( aHelpP, "opção 1 (totalidade) o livro irá gerar ") //  
Aadd( aHelpP, "todas as informações (estaduais e      ") //  
Aadd( aHelpP, "interestaduais) juntas, ordenadas por  ") //  
Aadd( aHelpP, "data e número de documento.            ") //  

aHelpE := aHelpS := aHelpP
PutSx1("MTR930","36","Operações a imprimir?","Operações a imprimir?","Operações a imprimir?","mv_chz","N",1,0,1,"C","","","","","mv_par36","Estaduais","Estaduais","Estaduais","","Interestaduais","Interestaduais","Interestaduais","Totalidade","Totalidade","Totalidade","","","","","","",aHelpP,aHelpE,aHelpS)

aHelpP  := {}
aHelpE  := {}
aHelpS  := {}

//ÚÄÄÄÄÄÄÄÄÄ¿
//³Portugues³
//ÀÄÄÄÄÄÄÄÄÄÙ
Aadd( aHelpP, "Na obrigação da escrituracão do livro ")
Aadd( aHelpP, "de acordo com o Mapa Resumo.  ")
Aadd( aHelpP, "Somente tem validade esta pergunta, se  ")
Aadd( aHelpP, "o parâmetro MV_LJLVFIS for igual a 2. ")

//ÚÄÄÄÄÄÄÄÄ¿
//³Espanhol³
//ÀÄÄÄÄÄÄÄÄÙ
Aadd( aHelpS, "En la obrigación de la escrituración del libro ")
Aadd( aHelpS, "de acuerdo con el Mapa Resumo.  ") 
Aadd( aHelpS, "Solamente tienda validad la pregunta,  ") 
Aadd( aHelpS, "con el parametro MV_LJLVFIS iqual a 2. ") 

//ÚÄÄÄÄÄÄ¿
//³Ingles³
//ÀÄÄÄÄÄÄÙ
Aadd( aHelpE, "In the obligation of the bookkeeping of the book ") 
Aadd( aHelpE, "in accordance with the Map Summary. ") 
Aadd( aHelpE, "This question only has validity, if ") 
Aadd( aHelpE, "equal parameter MV_LJLVFIS the 2. ") 


PutSx1("MTR930","37","Imprime Mapa Resumo ?","Emite Mapa Resumo ?","Printed Map Summary ?","mv_chz","N",01,0,2,"C","MatxRValPer(mv_par37)","","","","mv_par37","Sim","Si","Yes","","Nao","No","No","","","","","","","","","",aHelpP,aHelpE,aHelpS)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Mtr930Fil ºAutor  ³Mary C. Hergert     º Data ³ 08/03/2006  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Posiciona a filial que esta sendo processada na filial      º±±
±±º          ³corrente do momento da gravacao do registro                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³aAreaSM0 = Area do SM0 posicionada no processamento         º±±
±±º          ³cFilCorr = Filial armazenada na gravacao do registro        º±±
±±º          ³nTipo    = 1 - posiciona filial, 2 = retorna na filial      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Matr930                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Mtr930Fil(aAreaSM0,cFilCorr,nTipo)
							
Local aArea := GetArea()

If !Empty(cFilCorr)
	If nTipo == 1
		SM0->(dbSeek(cEmpAnt+cFilCorr,.T.))
		cFilAnt	:= SM0->M0_CODFIL
	Else
		RestArea(aAreaSM0)
		cFilAnt	:= SM0->M0_CODFIL
	Endif
Endif          

RestArea(aArea)

Return
