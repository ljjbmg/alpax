#INCLUDE "protheus.ch"
#INCLUDE "TOPCONN.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR025   º Autor ³OCIMAR              º Data ³  12/04/11   º±±
±±ºFinalidade³ Produtos a vencer nos proximos XXX dias                    º±±
±±ºUso       ³ ALPAX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function ESTR025()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "Relatório de Podutos vencidos no armazem "
Local cPict        := ""
Local titulo       := " "
Local nLin         := 80
//Local Cabec1     := "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
//Local Cabec1     := "         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19"
Local Cabec1       := "P.NUMBER            PRODUTO                                                             CONTROLE      CAPACIDADE     "
Local Cabec2       := "MARCA                 QTD.         LOTE           VALIDADE                               CLASSE  "
Local imprime      := .T.
Local aOrd 		   := {}
Private lEnd       := .F.
Private lAbortPrint:= .F.
Private CbTxt      := ""
Private limite     := 132
Private tamanho    := "p"
Private nomeprog   := "ESTR025" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo      := 18
Private aReturn    := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "ESTR025" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString    := ""
Private cProduto   := '         '

cPerg := "ESTR25"

PutSx1(cPerg,"01","ARMAZEM"    ,"ARMAZEM"    ,"ARMAZEM"    ,"mv_ch1","C",02,0,0,"G","",""   ,"","","mv_par01",""        ,""        ,""        ,""  ,""  ,""  ,""   ,""   ,""   ,""            ,""            ,""            ,""     ,""     ,""     ,"",,,)
PutSx1(cPerg,"02","MARCA DE : ","MARCA DE : ","MARCA DE : ","mv_ch2","C",15,0,0,"G","","SZ2","","","mv_par02",""        ,""        ,""        ,""  ,""  ,""  ,""   ,""   ,""   ,""            ,""            ,""            ,""     ,""     ,""     ,"",,,)
PutSx1(cPerg,"03","MARCA ATE: ","MARCA ATE: ","MARCA ATE: ","mv_ch3","C",15,0,0,"G","","SZ2","","","mv_par03",""        ,""        ,""        ,""  ,""  ,""  ,""   ,""   ,""   ,""            ,""            ,""            ,""     ,""     ,""     ,"",,,)
PutSx1(cPerg,"04","PRODUTOS "  ,"PRODUTOS "  ,"PRODUTOS "  ,"mv_ch4","N",01,0,0,"C","",""   ,"","","mv_par04","Exercito","Exercito","Exercito","PF","PF","PF","SSP","SSP","SSP","SEM CONTROLE","SEM CONTROLE","SEM CONTROLE","TODOS","TODOS","TODOS","",,,)

titulo := "Relatório de Produtos vencidos no armazem "

Pergunte(cPerg,.f.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

titulo := "Relatório de Produtos vencidos no armazem "+ MV_PAR01

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  28/12/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
local cQuery := ''

cQuery += " SELECT B1_PNUMBER, B1_DESC, B1_CAPACID, B1_MARCA, B8_SALDO, B8_LOTECTL, B1_AXCTSSP, B1_AXCTEXE, B1_AXCTPF, B1_AXRISCO "
cQuery += " , CONVERT(VARCHAR,(CAST(B8_DTVALID AS DATETIME)),103) AS VALIDADE "
cQuery += " FROM SB8010 SB8 "
cQuery += " INNER JOIN SB1010 SB1 "
cQuery += " ON SB8.B8_PRODUTO = SB1.B1_COD "
cQuery += " WHERE SB8.B8_SALDO > 0 "
If MV_PAR01 <> '**'
	cQuery += " AND SB8.B8_LOCAL = '" + MV_PAR01 + "' "
EndIf
cQuery += " AND SB8.B8_DTVALID < GETDATE() AND SB8.D_E_L_E_T_ = ' ' "
cQuery += " AND B1_MARCA BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR03 + "' "
If MV_PAR04 == 1 
	cQuery += " AND SB1.B1_AXCTEXE <> ' ' "
EndIf
If MV_PAR04 == 2
	cQuery += " AND SB1.B1_AXCTPF <> ' ' "
EndIf
If MV_PAR04 == 3
	cQuery += " AND SB1.B1_AXCTSSP <> ' ' "
EndIf
If MV_PAR04 == 4
	cQuery += " AND SB1.B1_AXCTEXE = ' ' AND SB1.B1_AXCTPF = ' ' AND SB1.B1_AXCTSSP = ' ' "
EndIf
cQuery += " ORDER BY B1_PNUMBER "

DbUseArea( .T., "TOPCONN", TcGenqry( , , cQuery), "TRB", .F., .F. )


SetRegua(RecCount())

While TRB->(!EOF())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se o produto e controlado                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If TRB->B1_AXCTPF <> ' '
		cProduto := 'P. FEDERAL'
	ElseIf TRB->B1_AXCTEXE <> ' '
		cProduto := 'EXERCITO'
	ElseIf TRB->B1_AXCTSSP <> ' '
		cProduto := 'SSP'
	EndIf              
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If nLin > 56 // Salto de Página. Neste caso o formulario tem 56 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 9
	Endif
	
	// Coloque aqui a logica da impressao do seu programa...
	// Utilize PSAY para saida na impressora. Por exemplo:
	@nLin,000 PSAY TRB->B1_PNUMBER                         // 20 CARAC
	@nLin,020 PSAY TRB->B1_DESC                            // 70 CARAC
	@nLin,091 PSAY cProduto                                // 10 CARAC
	@nLin,103 PSAY TRB->B1_CAPACID                         // 20 CARAC
	nLin := nLin + 1
	@nLin,000 PSAY TRB->B1_MARCA                           // 15
	@nLin,020 Psay Transform(TRB->B8_SALDO,"@e 9,999")     // 10
	@nLin,035 PSAY TRB->B8_LOTECTL                         // 10
	@nLin,050 PSAY TRB->VALIDADE                           // 10
	@nLin,092 PSAY TRB->B1_AXRISCO                         // 10
	nLin := nLin + 1 // Avanca a linha de impressao
	@nLin,000 Psay __PrtThinLine()                         // LINHA CONTINUA FINA
	//    @nLin,000 Psay __PrtFatLine()                        // LINHA CONTINUA GORDA
	//    @nLin,000 Psay Replicate("-",limite)                 // LINHA CONTINUA
	nLin := nLin + 1 // Avanca a linha de impressao
	cProduto := ' '
	
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo

TRB->(DbCloseArea())
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return
      
