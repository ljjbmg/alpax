#include "protheus.ch"
#include "topconn.ch"

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё*************************************************************************Ё
//ЁRELATORIO DE DISPONIBILIDADES                                             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды


USER FUNCTION RADVR001()



//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Declaracao de Variaveis                                             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := ""
Local cPict          := ""
Local titulo       := "Disponibilidades Para Laboratorio"
Local nLin         := 80
                  //   0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
                  //             1         2         3         4         5         6         7         8         9        10        11        12        13
Local Cabec1       := " PNUMBER             DESCRICAO                                             MARCA       PV    QTD_PV    QTD_REC      SALDO   ENTREGAR"
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 132
Private tamanho          := "M"
Private nomeprog         := "RADVR001" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RADVR001" // Coloque aqui o nome do arquivo usado para impressao em disco




//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta a interface padrao com o usuario...                           Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

wnrel := SetPrint("SA1",NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,"SA'")

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Processamento. RPTSTATUS monta janela com a regua de processamento. Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Fun┤└o    ЁRUNREPORT ╨ Autor Ё AP6 IDE            ╨ Data Ё  09/03/10   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Descri┤└o Ё Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ╨╠╠
╠╠╨          Ё monta a janela com a regua de processamento.               ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё Programa principal                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)


BeginSql alias "TMP"
	
	COLUMN ZA1_QPV  AS NUMERIC(17,4)
	COLUMN ZA1_QREC AS NUMERIC(17,4)
	COLUMN ENTREGAR AS NUMERIC(17,4)
	COLUMN B2_QATU AS NUMERIC(17,4)
	
    SELECT ZA1.ZA1_PNUMBE
	,ZA1.ZA1_PV
	,ZA1.ZA1_QPV
	,ZA1.ZA1_QREC
    ,B2_QATU
	,ZA1_DESC
	,ZA1_MARCA
	,CASE WHEN (ZA1_QPV-ZA1_QREC) > B2_QATU THEN B2_QATU ELSE (ZA1_QPV-ZA1_QREC) END ENTREGAR
	
	FROM %table:ZA1% ZA1
	INNER JOIN %table:SB2% B2 ON B2.%NotDel% AND B2.B2_COD = ZA1.ZA1_COD
	WHERE ZA1.%NotDel%
	AND ((ZA1_QPV-ZA1_QREC)>0)
	AND B2_LOCAL = '01'
	AND B2_QATU > 0
	ORDER BY ZA1.ZA1_PNUMBE
	
EndSql
             
dbselectarea("TMP")
dbgotop()


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё SETREGUA -> Indica quantos registros serao processados para a regua Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

SetRegua(RecCount())

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Posicionamento do primeiro registro e loop principal. Pode-se criar Ё
//Ё a logica da seguinte maneira: Posiciona-se na filial corrente e pro Ё
//Ё cessa enquanto a filial do registro for a filial corrente. Por exem Ё
//Ё plo, substitua o dbGoTop() e o While !EOF() abaixo pela sintaxe:    Ё
//Ё                                                                     Ё
//Ё dbSeek(xFilial())                                                   Ё
//Ё While !EOF() .And. xFilial() == A1_FILIAL                           Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

While !EOF()
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica o cancelamento pelo usuario...                             Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Impressao do cabecalho do relatorio. . .                            Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	If nLin > 61 // Salto de PАgina. Neste caso o formulario tem 61 linhas...
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif                                             

	@nLin,001 PSAY TMP->ZA1_PNUMBE
	@nLin,021 PSAY TMP->ZA1_DESC
	@nLin,075 PSAY TMP->ZA1_MARCA	
	@nLin,086 PSAY TMP->ZA1_PV
	@nlin,092 PSAY TMP->ZA1_QPV  PICTURE "@E 9,999.99"
	@nLin,103 PSAY TMP->ZA1_QREC  PICTURE "@E 9,999.99"
	@nLin,114 PSAY TMP->B2_QATU  PICTURE "@E 9,999.99"
	@nLin,125 PSAY TMP->ENTREGAR PICTURE "@E 9,999.99"	
	nLin := nLin + 2 // Avanca a linha de impressao pulando uma linha   
	
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo
                     
DBSELECTAREA("TMP")
dbclosearea()
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Finaliza a execucao do relatorio...                                 Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

SET DEVICE TO SCREEN

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Se impressao em disco, chama o gerenciador de impressao...          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return