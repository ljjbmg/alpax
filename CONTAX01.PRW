#INCLUDE "protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO2     บ Autor ณ AP6 IDE            บ Data ณ  15/07/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
                      

User Function CONTAX01()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "X1"
Local cPict          := ""
Local titulo       := "MODELO 3"
Local nLin         := 80

Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 220
Private tamanho          := "G"
Private nomeprog         := "CONTAX01" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cPerg       := "PERGUN"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "CONTAX01" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "ZB1"

dbSelectArea("ZB1")
dbSetOrder(1)

cPerg := "CONTAX01"
PutSx1(cPerg,"01","Produto de?"    ,""    ,""    ,"mv_ch1","C",15,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","",""   )
PutSx1(cPerg,"02","Produto ate"    ,""    ,""    ,"mv_ch2","C",15,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","",""   )
PutSx1(cPerg,"03","Ano Mes"    ,""    ,""    ,"mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","",""   )

pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. RPTSTATUS monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP6 IDE            บ Data ณ  15/07/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Private aCabx := {}

processa({||MONTABASE()} , "MONTANDO BASE...")
TRB1->(dbGoTop())

WHILE TRB1->(!EOF())
	_aSaldos := {}
	_aSaldos := BUSCASALDO(TRB1->ZB1_PRODUT)
	
	MONTALISTA(TRB1->ZB1_PRODUT)
	
	nLin := 100
	_nSaldo := _aSaldos[1]
	_nValor := _aSaldos[2]
	_lsaldoI := .t.
	
	While TRB3->(!EOF())
		If nLin > 55 // Salto de Pแgina. Neste caso o formulario tem 55 linhas...
			Cabec(Titulo  ,Cabec1,Cabec2 ,NomeProg,Tamanho ,nTipo)
			nLin := 2
			aCabx := {}
			aadd(aCabx,"-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			aadd(aCabx,"                                                                   CONTROLE DE ESTOQUE = MERCADORIAS ENQUADRADAS NA SUBSTITUICAO TRIBUTARIA")
			aadd(aCabx,"                                                                          (CRITERIO DE AVALIACAO: VALOR MEDIO PODERADO MOVEL)")
			aadd(aCabx,"                                                          CONTRIBUINTE: ALPAX COMERCIODE PRODUTOS PARA LABORATORIO LTDA   INSC EST:286100047111")
			aadd(aCabx,"-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			aadd(aCabx,"ANO-MES REFERENCIA:"+MV_PAR01+"    MERCADORIA:"+TRB1->ZB1_PRODUT+"  "+TRB1->B1_DESC+"                            UNIDADE:"+TRB1->B1_UM+"                     ALIQUOTA:18%                                                 ")
			aadd(aCabx,"-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			aadd(aCabx,"          |Entrada                            |Saida                                                                                                                                                                     ")
			aadd(aCabx,"          |-----------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			aadd(aCabx,"          |Doc Fiscal   |          |          |Doc Fiscal   |            |Base Calculo da Retencao                                                     |Valor Confronto          |            |                   Saldos ")
			aadd(aCabx,"          |-------------|          |     Valor|-------------|            |       Valor        Saida        Fator        Saida        Saida        Saida|Base Efetiva|Base Efetiva|            |                          ")
			aadd(aCabx,"Data      |Nota      Ser|Quantidade|Total Base|Nota      Ser|  Quantidade|    Unitario   Consumidor      Gerador      Isencao        Outro       Comerc|       Saida|      Demais|  Quantidade|    Unitario|       Total ")
			aadd(aCabx,"-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
			
			For nC := 1 to len(aCabx)
				@nLin++,001 Psay aCabx[nC]
			Next
			if _lSaldoI
				@nLin,001 psay "S A L D O..."
				@nLin,179 PSAY _aSaldos[1]   PICTURE "@E 9,999,999.99"
				@nLin,192 PSAY _aSaldos[2]/_aSaldos[1]  PICTURE "@E 9,999,999.99"
				@nLin,205 PSAY _aSaldos[2]  PICTURE "@E 9,999,999.99"
				nLin++
				_lSaldoI := .f.
			endif
		Endif
		
		@nLin,001 psay DTOC(STOD(TRB3->DATA_MOV))
		@nLin,012 PSAY TRB3->NFE_NUM
		@nLin,022 PSAY TRB3->NFE_SERIE   
		
		IF TRB3->NFE_QTDE > 0
			@nLin,026 PSAY TRB3->NFE_QTDE PICTURE "@E 999,999.99"
			//@nLin,037 PSAY TRB3->NFE_VLUNI  PICTURE "@E 999,999.99"
			@nLin,037 PSAY TRB3->(BASEICMR/NFE_QTDE)  PICTURE "@E 999,999.99"
			
			_nSaldo += TRB3->NFE_QTDE
			_NVALOR += TRB3->BASEICMR
			
		ENDIF
		
		@nLin,048 PSAY TRB3->NFS_NUM
		@nLin,058 PSAY TRB3->NFS_SERIE
		IF TRB3->NFS_QTDE > 0
			@nLin,062 PSAY TRB3->NFS_QTDE PICTURE "@E 999,999.99"
			@nLin,075 PSAY TRB3->(BASEICMR/NFS_QTDE)  PICTURE "@E 999,999.99"  //09
			//@nLin,075 PSAY TRB3->NFS_VLUNI  PICTURE "@E 999,999.99"
			_nSaldo -= TRB3->NFE_QTDE
			_NVALOR -= TRB3->BASEICMR
/*

Data       Nota      Ser
XX/XX/XXXX NNNNNNNNN NNN 999.999,99 999.999,99 NNNNNNNNN NNN 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99 9.999.999,99
1          12        22  26         37         48        58  62           75           88           101          114          127          140          153          166          179          192          205


*/
			
			@nLin,088 PSAY IIF(TRB3->CFOP$"6107.6107",TRB3->BASEICMR,0)  PICTURE "@E 9,999,999.99"   //10
			@nLin,101 PSAY 0  PICTURE "@E 9,999,999.99"   //11
			@nLin,114 PSAY 0  PICTURE "@E 9,999,999.99"   //12
			@nLin,127 PSAY 0  PICTURE "@E 9,999,999.99"   //13
			@nLin,140 PSAY IIF(!TRB3->CFOP$"6107.6107",TRB3->BASEICMR,0)  PICTURE "@E 9,999,999.99"   //14
			
		ENDIF

       IF TRB3->NFS_QTDE > 0
			@NLIN,153 PSAY TRB3->BASEICMR  PICTURE "@E 9,999,999.99"   //15 SAIDA
       ELSE			
			@NLIN,166 PSAY TRB3->BASEICMR  PICTURE "@E 9,999,999.99"   //16 ENTRADA
       ENDIF
		
		// UTILIZADO A SOMA NA COLUNAS DE IMPRESSAO
		//_nSaldo := _nSaldo + TRB3->QMOV
		//_nValor := _nValor + TRB3->VMOV
		
		@nLin,179 PSAY _nSaldo  PICTURE "@E 9,999,999.99"          //17
		@nLin,192 PSAY _nValor/_nSaldo  PICTURE "@E 9,999,999.99"  //18
		@nLin,205 PSAY _nValor  PICTURE "@E 9,999,999.99"          //19
		
		nLin := nLin + 1 // Avanca a linha de impressao
		
		TRB3->(dbSkip()) // Avanca o ponteiro do registro no arquivo
	EndDo
	
	TRB1->(DBSKIP())
ENDDO

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///  TABELA TRB1 PARA INICIO DE PROCESSO  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
STATIC FUNCTION MONTABASE()

PROCREGUA(0)
INCPROC("MONTANDO TABELA PAI...")

IF SELECT("TRB1")<> 0  ; DBSELECTAREA("TRB1") ; TRB1->(DBCLOSEAREA()) ; endif
/// BASE DE ONDE SAI OS PRODUTOS A LISTAR
BEGINSQL ALIAS "TRB1"
	
	SELECT ZB1_PRODUT, B1_DESC, B1_UM
	FROM %TABLE:ZB1% ZB1
	LEFT JOIN SB1010 B1 ON B1.%NOTDEL% AND B1_COD = ZB1_PRODUT
	WHERE ZB1.%NOTDEL%
	AND ZB1_PRODUT BETWEEN %EXP:MV_PAR01%  AND %EXP:MV_PAR02%
	AND SUBSTRING(ZB1_EMISSA,1,6) =  %EXP:MV_PAR03%
	GROUP BY ZB1_PRODUT , B1_DESC    , B1_UM
	ORDER  by ZB1_PRODUT
	
ENDSQL

memowrit("C:\TEMP\MONTABASE.SQL",GETLASTQUERY()[2])

RETURN


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///  VETOR SALDOS  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
STATIC FUNCTION BUSCASALDO(_cProd)

Local _aRet := {}
IF SELECT("TRB2")<> 0  ; DBSELECTAREA("TRB2") ; TRB2->(DBCLOSEAREA()) ; endif


BEGINSQL ALIAS "TRB2"
	
	SELECT SUM(QMOV) QMOV, SUM(VMOV) VMOV, SUM(BASEICM)
	FROM
	(
	SELECT '01' TIPO,'SALDO' DESCR,B9_COD PROD,B1_DESC PROD_DESCR, 'SALDO' DATA_MOV ,'' NUMSEQ,  '' NFE_NUM,'' NFE_SERIE, '' NFE_QTDE , 0 NFE_VL_TOT
	,'' NFS_NUM, '' NFS_SERIE, 0 NFS_QTDE, 0 NFS_VLUNI, 0 NFS_CONSUMI, 0 NFS_FATOG, 0 NFS_ISENT, 0 NFS_OUT,0 NFS_COMER, 0 NFS_BASE, 0 NFS_EFET
	,B9_QINI SLD_QTDE, B9_CM1 SLD_VLUNI, B9_QINI * B9_CM1 SLD_VLTOT
	, B9_QINI QMOV , B9_QINI * B9_CM1 VMOV             
	, 0 BASEICM, 0 TQDE , 0 SALDOB9
	FROM %TABLE:SB9% B9
	LEFT JOIN %TABLE:SB1% B1 ON B1.%NOTDEL% AND B1.B1_COD = B9.B9_COD
	WHERE B9.%NOTDEL% AND B9.B9_FILIAL = %XFILIAL:SB9%
	AND B9.B9_DATA = '20091231' AND B9_LOCAL = '01'
	AND B9.B9_COD = %EXP:_cProd%
	
	UNION ALL
	
	SELECT '02' TIPO, 'ENTRADA' DESCR ,ZB0_PRODUT PROD, B1_DESC PROD_DESCR, ZB0_EMISSA DATA_MOV ,D1_NUMSEQ NUMSEQ,  D1_DOC NFE_NUM,D1_SERIE NFE_SERIE, D1_QUANT NFE_QTDE , D1_CUSTO NFE_VL_TOT
	,'' NFS_NUM, '' NFS_SERIE, 0 NFS_QTDE, 0 NFS_VLUNI, 0 NFS_CONSUMI, 0 NFS_FATOG, 0 NFS_ISENT, 0 NFS_OUT,0 NFS_COMER, 0 NFS_BASE, 0 NFS_EFET
	,0 SLD_QTDE, 0 SLD_VLUNI, 0 SLD_VLTOT
	, D1_QUANT QMOV, D1_CUSTO VMOV
	, D1_BASEICM BASEICM, D1_QUANT TQDE , 0 SALDOB9
	FROM ZB0990 ZB0
	LEFT JOIN SB1010 B1 ON B1.%NOTDEL% AND B1.B1_COD = ZB0.ZB0_PRODUT
	LEFT JOIN SD1010 D1 ON D1.%NOTDEL% AND D1.D1_DOC = ZB0.ZB0_NFENUM AND D1.D1_SERIE = ZB0.ZB0_NFESER AND D1.D1_ITEM = ZB0.ZB0_NFEITM AND D1.D1_COD = ZB0.ZB0_PRODUT
	WHERE ZB0.%NOTDEL% AND ZB0_FILIAL = %XFILIAL:ZB0% AND ZB0_PRODUT = %EXP:_cProd%
	AND SUBSTRING(ZB0.ZB0_EMISSA,1,6) < %EXP:MV_PAR03%
	
	UNION ALL
	
	SELECT '03' TIPO, 'SAIDA' DESCR ,ZB1.ZB1_PRODUT PROD, B1_DESC PROD_DESCR, D2_EMISSAO DATA_MOV ,D2_NUMSEQ NUMSEQ,  '' NFE_NUM,'' NFE_SERIE, '' NFE_QTDE , 0 NFE_VL_TOT
	,D2_DOC NFS_NUM, D2_SERIE NFS_SERIE, D2_QUANT NFS_QTDE, D2_CUSTO1/D2_QUANT NFS_VLUNI, 0 NFS_CONSUMI, 0 NFS_FATOG, 0 NFS_ISENT, 0 NFS_OUT,0 NFS_COMER, 0 NFS_BASE, 0 NFS_EFET
	,0 SLD_QTDE, 0 SLD_VLUNI, 0 SLD_VLTOT
	,D2_QUANT*-1 QMOV, D2_CUSTO1* -1 VMOV
	, D2_BASEICM * -1 BASEICM, D2_QUANT * -1 TQDE , 0 SALDOB9
	FROM ZB1990 ZB1                       

	LEFT JOIN SB1010 B1 ON B1.%NOTDEL%  AND B1.B1_COD = ZB1.ZB1_PRODUT
	LEFT JOIN SD2010 D2 ON D2.%NOTDEL%  AND D2.D2_DOC = ZB1.ZB1_NFSNUM AND D2.D2_SERIE = ZB1.ZB1_NFSSER AND D2.D2_ITEM = ZB1.ZB1_NFSITM AND D2.D2_COD = ZB1.ZB1_PRODUT
	WHERE ZB1.%NOTDEL%  AND ZB1.ZB1_FILIAL = %XFILIAL:ZB1%
	AND ZB1.ZB1_PRODUT = %EXP:_cProd%
	and SUBSTRING(ZB1.ZB1_EMISSA,1,6) < %EXP:MV_PAR03%
	
	)  AS T
	
ENDSQL
memowrit("C:\TEMP\BUSCASALDO.SQL",GETLASTQUERY()[2])

AADD(_aRet,TRB2->QMOV)
AADD(_aRet,TRB2->VMOV)

Return(_aRet)





/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///  LISTA  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
STATIC FUNCTION MONTALISTA(_cProd)

Local _aRet := {}
IF SELECT("TRB3")<> 0  ; DBSELECTAREA("TRB3") ; TRB3->(DBCLOSEAREA()) ; endif

BEGINSQL ALIAS "TRB3"
	SELECT '02' TIPO, 'ENTRADA' DESCR ,ZB0_PRODUT PROD, B1_DESC PROD_DESCR, ZB0_EMISSA DATA_MOV ,D1_NUMSEQ NUMSEQ,  D1_DOC NFE_NUM,D1_SERIE NFE_SERIE, D1_QUANT NFE_QTDE , D1_CUSTO NFE_VL_TOT
	,'' NFS_NUM, '' NFS_SERIE, 0 NFS_QTDE, 0 NFS_VLUNI, 0 NFS_CONSUMI, 0 NFS_FATOG, 0 NFS_ISENT, 0 NFS_OUT,0 NFS_COMER, 0 NFS_BASE, 0 NFS_EFET
	,0 SLD_QTDE, 0 SLD_VLUNI, 0 SLD_VLTOT
	, D1_QUANT QMOV, D1_CUSTO VMOV
	, D1_BRICMS BASEICMR, D1_CF CFOP
	FROM ZB0990 ZB0
	LEFT JOIN SB1010 B1 ON B1.%NOTDEL% AND B1.B1_COD = ZB0.ZB0_PRODUT
	LEFT JOIN SD1010 D1 ON D1.%NOTDEL% AND D1.D1_DOC = ZB0.ZB0_NFENUM AND D1.D1_SERIE = ZB0.ZB0_NFESER AND D1.D1_ITEM = ZB0.ZB0_NFEITM AND D1.D1_COD = ZB0.ZB0_PRODUT
	WHERE ZB0.%NOTDEL% AND ZB0_FILIAL = %XFILIAL:ZB0% AND ZB0_PRODUT = %EXP:_cProd%
	AND SUBSTRING(ZB0.ZB0_EMISSA,1,6) = %EXP:MV_PAR03%
	
	UNION ALL
	
	SELECT '03' TIPO, 'SAIDA' DESCR ,ZB1.ZB1_PRODUT PROD, B1_DESC PROD_DESCR, D2_EMISSAO DATA_MOV ,D2_NUMSEQ NUMSEQ,  '' NFE_NUM,'' NFE_SERIE, '' NFE_QTDE , 0 NFE_VL_TOT
	,D2_DOC NFS_NUM, D2_SERIE NFS_SERIE, D2_QUANT NFS_QTDE, D2_CUSTO1/D2_QUANT NFS_VLUNI, 0 NFS_CONSUMI, 0 NFS_FATOG, 0 NFS_ISENT, 0 NFS_OUT,0 NFS_COMER, 0 NFS_BASE, 0 NFS_EFET
	,0 SLD_QTDE, 0 SLD_VLUNI, 0 SLD_VLTOT
	,D2_QUANT*-1 QMOV, D2_CUSTO1* -1 VMOV
	, D2_BASEICM BASEICMR, D2_CF CFOP
	FROM ZB1990 ZB1
	LEFT JOIN SB1010 B1 ON B1.%NOTDEL%  AND B1.B1_COD = ZB1.ZB1_PRODUT
	LEFT JOIN SD2010 D2 ON D2.%NOTDEL%  AND D2.D2_DOC = ZB1.ZB1_NFSNUM AND D2.D2_SERIE = ZB1.ZB1_NFSSER AND D2.D2_ITEM = ZB1.ZB1_NFSITM AND D2.D2_COD = ZB1.ZB1_PRODUT
	WHERE ZB1.%NOTDEL%  AND ZB1.ZB1_FILIAL = %XFILIAL:ZB1%
	AND ZB1.ZB1_PRODUT = %EXP:_cProd%
	and SUBSTRING(ZB1.ZB1_EMISSA,1,6) = %EXP:MV_PAR03%
	ORDER BY 6
	
ENDSQL

memowrit("C:\TEMP\MONTALISTA.SQL",GETLASTQUERY()[2])


Return(_aRet)

