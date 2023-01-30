#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

#DEFINE CRLF 	CHR(13)+CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ALPA001   ºAutor  ³ Biale              º Data ³  04/19/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Colhe as Notas Aptas a serem Apropriadas                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ALLPAX                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION ALPA020
PRIVATE cPerg	  := "ALPA20000"                                      

PRIVATE oProcess  := NIL   
PRIVATE cCFO := ""
PRIVATE aCFO := {}      
PRIVATE FCFO

cPerg := PADR(cPerg,10)

DBSELECTAREA("ZB0")
DBSELECTAREA("ZB1")

IF !SX6->(DBSEEK(SPACE(2)+"MV_STCFENT"))
     DBSELECTAREA("SX6")
     RECLOCK("SX6",.T.)
		SX6->X6_FIL     := ""
		SX6->X6_VAR     := 'MV_STCFENT'
		SX6->X6_TIPO    := 'C'
		SX6->X6_DESCRIC := 'RELACAO DE CFOS DE ANALISE DE NOTAS DE ST(SUBSTR(CFO,2,3) - ENTRADA)'
		SX6->X6_DSCSPA  := SX6->X6_DESCRIC
		SX6->X6_DSCENG  := SX6->X6_DESCRIC
		SX6->X6_CONTEUD := '102/108/107'
		SX6->X6_CONTSPA := SX6->X6_CONTEUD
		SX6->X6_CONTENG := SX6->X6_CONTEUD
		SX6->X6_PROPRI  := 'U'
     MSUNLOCK()
     COMMIT
ENDIF

cCFO := ALLTRIM(GETMV("MV_STCFENT"))
aCFO := SEPARA(cCFO,"/")
FCFO := ""
FOR F := 1 TO LEN(aCFO)
     FCFO += ",'"+aCFO[F]+"'"
NEXT

FCFO := SUBSTR(FCFO,2)

/* SALDO DAS NFEs 
( ZB0_EMISSAO ) - NFe Emissão, 
( ZB0_PRODUTO ) - NFe Produto, 
( ZB0_NFENUM  ) - NFe Numero da Nota, 
( ZB0_NFESER  ) - NFe Serie, 
( ZB0_NFEITEM ) - NFe Item, 
( ZB0_NFEQTD  ) - NFe Quantidade, 
( ZB0_NFEVUNI ) - NFe Valor Unitário, 
( ZB0_NFESAL  ) - NFe Saldo 
*/
    	
/* TABELA DE APROPRIAÇÃO 
( ZB1_EMISSA ) - NFe Emissão, 
( ZB1_PRODUT ) - NFe Produto, 
( ZB1_NFENUM  ) - NFe Numero da Nota, 
( ZB1_NFESER  ) - NFe Serie, 
( ZB1_NFEITM ) - NFe Item, 
( ZB1_NFEQTD  ) - NFe Quantidade, 
( ZB1_NFEVUN ) - NFe Valor Unitário, 
( ZB1_NFESEQ  ) - NFe Sequencia Apropriação, 
( ZB1_NFSNUM  ) - NFs Nota de Saida que Apropriou,
( ZB1_NFSQTD  ) - NFs Quantidade,
( ZB1_NFSVAL  ) - NFs Valor Saida
*/

//Crio os Parametros
AJUSTASX1()
If Pergunte(cPerg,.T.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros Range em expressao SQL                            ³	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr(cPerg)

	oProcess := MsNewProcess():New( { | lEnd | AlpaProc() }, 'Atualizando', 'Aguarde, atualizando ...', .F. )
	oProcess:Activate()

EndIf

RETURN NIL

//--------------------------------------------------------------------------------------------------------------------------------------------------

// Analisa NFes de Entrada para compor o ZB0
STATIC FUNCTION ALPAPROC             
LOCAL cAlias1 := GetNextAlias() // Tabela de Saldo das NFEs (ZB0)
//LOCAL cAlias2 := GetNextAlias() // Tabela de Apropriação das NFEs

// Verifica se o Periodo indicado já  foi processado
BEGINSQL Alias cAlias1
	SELECT  COUNT(*) AS CONTADOR
	FROM	%Table:ZB0% ZB0, %Table:ZB1% ZB1
	WHERE	ZB0.ZB0_NFENUM = ZB1.ZB1_NFENUM AND
		ZB0.ZB0_NFESER = ZB1.ZB1_NFESER AND
		ZB0.ZB0_NFEITM = ZB1.ZB1_NFEITM AND
		ZB0.ZB0_EMISSA BETWEEN  %Exp:DTOS(MV_PAR01)% 	AND %Exp:DTOS(MV_PAR02)%  	AND
		ZB0.ZB0_PRODUT BETWEEN  %Exp:MV_PAR03%          AND %Exp:MV_PAR04%          AND	
		ZB0.%notDel% AND
		ZB1.%notDel%
ENDSQL

oProcess:SetRegua1( 5 )
If !&(cAlias1)->(EOF()) .AND. &(cAlias1+"->CONTADOR") == 0

	oProcess:IncRegua1( 'Excluindo Notas não Apropriadas ...' )

	// Deleto o Periodo solicitado
	cQuery := "DELETE	"+RetSqlName("ZB0")+""+CRLF 
	cQuery += "WHERE	"+RetSqlName("ZB0")+".R_E_C_N_O_ IN ( "+CRLF
	cQuery += "SELECT 	ZB0I.R_E_C_N_O_ "+CRLF
	cQuery += "FROM	  "+RetSqlName("ZB0")+" ZB0I "+CRLF
	cQuery += "WHERE   ZB0I.ZB0_EMISSA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' AND "+CRLF
	cQuery += "		   ZB0I.ZB0_PRODUT BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' AND "+CRLF	
	cQuery += "		ZB0I.R_E_C_N_O_ NOT IN ( "+CRLF
	cQuery += "			SELECT  ZB0.R_E_C_N_O_ "+CRLF
	cQuery += "			FROM	"+RetSqlName("ZB0")+" ZB0, "+RetSqlName("ZB1")+" ZB1 "+CRLF
	cQuery += "			WHERE	ZB0.ZB0_NFENUM = ZB1.ZB1_NFENUM AND "+CRLF
	cQuery += "					ZB0.ZB0_NFESER = ZB1.ZB1_NFESER AND "+CRLF
	cQuery += "					ZB0.ZB0_NFEITM = ZB1.ZB1_NFEITM AND "+CRLF
	cQuery += "					ZB0.ZB0_EMISSA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'  AND "+CRLF
	cQuery += "		   			ZB0.ZB0_PRODUT BETWEEN '"+MV_PAR03+"' 	    AND '"+MV_PAR04+"'        AND "+CRLF
	cQuery += "					ZB0.D_E_L_E_T_ = ' ' AND "+CRLF
	cQuery += "					ZB1.D_E_L_E_T_ = ' ') AND "+CRLF
	cQuery += "		ZB0I.D_E_L_E_T_ = ' ' ) "+CRLF									
	TcSqlExec(cQuery)
	
	oProcess:IncRegua1( 'Gerando ZB0 - Notas de Entrada a Apropriar ...' )
			
	// Gera ZB0
	cQuery := "INSERT "+RetSqlName("ZB0")
	cQuery += "           (ZB0_NFENUM, ZB0_NFESER, ZB0_EMISSA, ZB0_NFEITM, ZB0_PRODUT, ZB0_NFEQTD, ZB0_NFEVUN, ZB0_ICMSRE, ZB0_TIPO, ZB0_FORNEC, ZB0_LOJA, ZB0_EST, R_E_C_N_O_) "+CRLF
//Trecho alterado por Jesus -> Biale 14/06/2011
 	cQuery += "	SELECT	   SD1.D1_DOC, SD1.D1_SERIE, SD1.D1_EMISSAO, SD1.D1_ITEM, SD1.D1_COD, SD1.D1_QUANT, SD1.D1_VUNIT, SD1.D1_VALICM, SD1.D1_TIPO, SA2.A2_COD, SA2.A2_LOJA, SA2.A2_EST, SD1.R_E_C_N_O_ "+CRLF 
	cQuery += "	FROM		"+RetSqlName("SD1")+" SD1 "+CRLF
	cQuery += "	LEFT JOIN	"+RetSqlName("SA2")+" SA2 ON "+CRLF
	cQuery += "				SA2.A2_FILIAL		= '"+xFilial("SA2")+"'	AND "+CRLF
	cQuery += "				SA2.A2_COD 			= SD1.D1_FORNECE		AND "+CRLF
	cQuery += "				SA2.A2_LOJA 		= SD1.D1_LOJA			AND "+CRLF
	cQuery += "				SA2.D_E_L_E_T_		= ' ' "+CRLF
	cQuery += "	WHERE		SD1.D1_FILIAL		= '"+xFilial("SD1")+"'	AND "+CRLF
    cQuery += "             SUBSTRING(SD1.D1_CF,2,3) IN ("+FCFO+")      AND "+CRLF 
    cQuery += "				SD1.D_E_L_E_T_		= ' '					AND "+CRLF
	cQuery += "	SD1.D1_TIPO NOT IN ('B','D') AND "+CRLF
	cQuery += "	SD1.R_E_C_N_O_ NOT IN ( "+CRLF
	cQuery += "			SELECT  ZB0.R_E_C_N_O_ "+CRLF
	cQuery += "			FROM	"+RetSqlName("ZB0")+" ZB0, "+RetSqlName("ZB1")+" ZB1 "+CRLF
	cQuery += "			WHERE	ZB0.ZB0_NFENUM = ZB1.ZB1_NFENUM AND "+CRLF
	cQuery += "					ZB0.ZB0_NFESER = ZB1.ZB1_NFESER AND "+CRLF
	cQuery += "					ZB0.ZB0_NFEITM = ZB1.ZB1_NFEITM AND "+CRLF
	cQuery += "					ZB0.ZB0_EMISSA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' AND "+CRLF 
	cQuery += "		   			ZB0.ZB0_PRODUT BETWEEN '"+MV_PAR03+"' 	    AND '"+MV_PAR04+"'        AND "+CRLF
	cQuery += "					ZB0.D_E_L_E_T_ = ' ' AND "+CRLF
	cQuery += "					ZB1.D_E_L_E_T_ = ' ') AND "+CRLF
	cQuery += "	SD1.D1_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' AND "+CRLF
	cQuery += "	SD1.D1_COD     BETWEEN '"+MV_PAR03+"' 	    AND '"+MV_PAR04+"' "+CRLF
    cQuery += " AND SUBSTRING(SD1.D1_CF,2,3) IN ("+FCFO+") "+CRLF
	TcSqlExec(cQuery)                   
	MEMOWRIT("C:\A\1POPULA.SQL",cQuery)
                                                
	oProcess:IncRegua1( 'Analisando Saldo das Notas de Entrada ...' )
	
	// Popula o campo Saldo
	cQuery := " UPDATE "+RetSqlName("ZB0")
 	cQuery += " SET "+RetSqlName("ZB0")+".ZB0_NFESAL = (SELECT ZB0_NFEQTD FROM "+RetSqlName("SD1")+" SD1 WHERE "+RetSqlName("ZB0")+".R_E_C_N_O_ = SD1.R_E_C_N_O_) "+CRLF	
	cQuery += " WHERE 	"+RetSqlName("ZB0")+".R_E_C_N_O_ NOT IN ( "+CRLF
	cQuery += "			SELECT  ZB0.R_E_C_N_O_ "+CRLF
	cQuery += "			FROM	"+RetSqlName("ZB0")+" ZB0, "+RetSqlName("ZB1")+" ZB1 "+CRLF
	cQuery += "			WHERE	ZB0.ZB0_NFENUM = ZB1.ZB1_NFENUM AND "+CRLF
	cQuery += "					ZB0.ZB0_NFESER = ZB1.ZB1_NFESER AND "+CRLF
	cQuery += "					ZB0.ZB0_NFEITM = ZB1.ZB1_NFEITM AND "+CRLF
	cQuery += "					ZB0.ZB0_EMISSA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' AND "+CRLF 
	cQuery += "		   			ZB0.ZB0_PRODUT BETWEEN '"+MV_PAR03+"' 	    AND '"+MV_PAR04+"'       AND "+CRLF
	cQuery += "					ZB0.D_E_L_E_T_ = ' ' AND "+CRLF
	cQuery += "					ZB1.D_E_L_E_T_ = ' ') AND "+CRLF
	cQuery += "		   	"+RetSqlName("ZB0")+".ZB0_PRODUT BETWEEN '"+MV_PAR03+"' 	  AND '"+MV_PAR04+"'       AND "+CRLF
	cQuery += "			"+RetSqlName("ZB0")+".ZB0_EMISSA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'     "+CRLF
	TcSqlExec(cQuery)
	MEMOWRIT("C:\A\2ANALISA.SQL",cQuery)

	oProcess:IncRegua1( 'Calculando a Alicota de ICMS...' )
	
	//Trecho alterado por Jesus -> Biale 14/06/2011
	/*
	// Popula Alicota ICMS
	cQuery := "UPDATE "+RetSqlName("ZB0")+" SET ZB0_ICMSRE = (SELECT	 MAX ( CASE WHEN	SB1.B1_PICMENT = 0   "+CRLF
	cQuery += "														THEN  "+CRLF
	cQuery += "														   CASE WHEN SF7.F7_EST = 'SP'  "+CRLF
	cQuery += "														        THEN SF7.F7_ALIQINT  "+CRLF
	cQuery += "															    ELSE "+CRLF
	cQuery += "											   						 CASE WHEN SF7.F7_EST = ZB0.ZB0_EST OR SF7.F7_EST = '**'  "+CRLF
	cQuery += "																		  THEN SF7.F7_ALIQEXT  "+CRLF
	cQuery += "																          ELSE 0  "+CRLF
	cQuery += "																		  END  "+CRLF
	cQuery += "															    END  "+CRLF
	cQuery += "													    ELSE "+CRLF
	cQuery += "															SB1.B1_PICMENT "+CRLF
	cQuery += "												   END) AS TESTE "+CRLF
	cQuery += "								   FROM	 "+RetSqlName("ZB0")+" ZB0, "+RetSqlName("SF7")+" SF7, "+RetSqlName("SB1")+" SB1, "+RetSqlName("SD1")+" SD1 "+CRLF
	cQuery += "								   WHERE	 ZB0.ZB0_FILIAL			= '  '								AND "+CRLF
	cQuery += "											 SD1.D1_FILIAL			= '01'								AND "+CRLF
	cQuery += "											 SD1.D1_DOC				= ZB0.ZB0_NFENUM					AND "+CRLF
	cQuery += "											 SD1.D1_SERIE			= ZB0.ZB0_NFESER					AND "+CRLF
	cQuery += "											 SD1.D1_ITEM			= ZB0.ZB0_NFEITM					AND "+CRLF
	cQuery += "											 SB1.B1_FILIAL			= ZB0.ZB0_FILIAL					AND "+CRLF
	cQuery += "		 									 SB1.B1_COD				= ZB0.ZB0_PRODUT					AND "+CRLF
	cQuery += "		 									 SF7.F7_FILIAL			= ZB0.ZB0_FILIAL					AND "+CRLF
	cQuery += "		 									 SB1.B1_GRTRIB			= SF7.F7_GRTRIB						AND "+CRLF
	cQuery += "		 									 ( SF7.F7_EST = ZB0.ZB0_EST OR SF7.F7_EST = '**')			AND	"+CRLF
	cQuery += "		 									 ZB0.R_E_C_N_O_  = ZB0990.R_E_C_N_O_  						AND "+CRLF
	cQuery += "		 									 SD1.D_E_L_E_T_  = ' '										AND "+CRLF
	cQuery += "		 									 SF7.D_E_L_E_T_  = ' '										AND "+CRLF
	cQuery += "		 									 SB1.D_E_L_E_T_  = ' '										AND "+CRLF
	cQuery += "		 									 ZB0.D_E_L_E_T_  = ' ') "+CRLF
	cQuery += "WHERE (SELECT	 MAX ( CASE WHEN	SB1.B1_PICMENT = 0   "+CRLF
	cQuery += "				THEN  "+CRLF
	cQuery += "				   CASE WHEN SF7.F7_EST = 'SP'  "+CRLF
	cQuery += "				        THEN SF7.F7_ALIQINT  "+CRLF
	cQuery += "					    ELSE "+CRLF
	cQuery += "							 CASE WHEN SF7.F7_EST = ZB0.ZB0_EST OR SF7.F7_EST = '**'  "+CRLF
	cQuery += "								  THEN SF7.F7_ALIQEXT  "+CRLF
	cQuery += "						          ELSE 0  "+CRLF
	cQuery += "								  END  "+CRLF
	cQuery += "					    END  "+CRLF
	cQuery += "			  ELSE "+CRLF
	cQuery += "					SB1.B1_PICMENT "+CRLF
	cQuery += "			  END) AS TESTE "+CRLF
	cQuery += "FROM	 "+RetSqlName("ZB0")+" ZB0, "+RetSqlName("SF7")+" SF7, "+RetSqlName("SB1")+" SB1, "+RetSqlName("SD1")+" SD1 "+CRLF
	cQuery += "WHERE ZB0.ZB0_FILIAL			= '  '								AND "+CRLF
	cQuery += "		 SD1.D1_FILIAL			= '01'								AND "+CRLF
	cQuery += "		 SD1.D1_DOC				= ZB0.ZB0_NFENUM					AND "+CRLF
	cQuery += "		 SD1.D1_SERIE			= ZB0.ZB0_NFESER					AND "+CRLF
	cQuery += "		 SD1.D1_ITEM			= ZB0.ZB0_NFEITM					AND "+CRLF
	cQuery += "		 SB1.B1_FILIAL			= ZB0.ZB0_FILIAL					AND "+CRLF
	cQuery += "		 SB1.B1_COD				= ZB0.ZB0_PRODUT					AND "+CRLF
	cQuery += "		 SF7.F7_FILIAL			= ZB0.ZB0_FILIAL					AND "+CRLF
	cQuery += "		 SB1.B1_GRTRIB			= SF7.F7_GRTRIB						AND "+CRLF
	cQuery += "		 ( SF7.F7_EST = ZB0.ZB0_EST OR SF7.F7_EST = '**')			AND	 "+CRLF
	cQuery += "		 ZB0.R_E_C_N_O_  = "+RetSqlName("ZB0")+".R_E_C_N_O_  		AND "+CRLF
	cQuery += "		 SD1.D_E_L_E_T_  = ' '										AND "+CRLF
	cQuery += "		 SF7.D_E_L_E_T_  = ' '										AND "+CRLF
	cQuery += "		 SB1.D_E_L_E_T_  = ' '										AND "+CRLF
	cQuery += "		 ZB0.D_E_L_E_T_  = ' ') IS NOT NULL "+CRLF
	TcSqlExec(cQuery)
	MEMOWRIT("C:\A\3TRATA.SQL",cQuery)
	*/
                     
	oProcess:IncRegua1( 'Finalizando' )
Else
	Alert("Existem movimentações de apropriação nas notas de entrada deste periodo. Não é possivel compor o saldo!")
EndIf

Return NIL

//--------------------------------------------------------------------------------------------------------------------------------------------------

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AJUSTASX1 ºAutor  ³ Cicero Cruz        º Data ³  21/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cria as perguntas no SX1                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ALGR001                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

STATIC FUNCTION AJUSTASX1
Local aPerguntas := {}   //Array com as perguntas
                       
cPerg := PADR(cPerg,10)

Aadd(aPerguntas,{cPerg,"01","Emissao De            :","Emissao De            :","Emissao De            :","mv_ch1","D", 					   8,0,"G","mv_par01","","","","","","","","","",          "","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPerguntas,{cPerg,"02","Emissao Ate           :","Emissao Ate           :","Emissao Ate           :","mv_ch2","D", 					   8,0,"G","mv_par02","","","","","","","","","",          "","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPerguntas,{cPerg,"03","Produto de            :","Produto de            :","Produto de            :","mv_ch3","C",      TamSx3("B1_COD")[1],0,"G","mv_par03","","","","","","","","","",          "","","","","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
Aadd(aPerguntas,{cPerg,"04","Produto Ate           :","Produto Ate           :","Produto Ate           :","mv_ch4","C",      TamSx3("B1_COD")[1],0,"G","mv_par04","","","","","","","","","",          "","","","","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
//Aadd(aPerguntas,{cPerg,"05","CFOP(s) Doc. Entrada  :","CFOP(s) Doc. Entrada  :","CFOP(s) Doc. Entrada  :","mv_ch5","C",                       99,0,"R","mv_par05","","","","","","","","","",     "D1_CF","","","","","","","","","","","","","","","","","","","","","","","","","","","","13"})

For nX := 1 to Len(aPerguntas)

	SX1->(dbSetOrder(1))
	If SX1->(!dbSeek(aPerguntas[nX,1]+aPerguntas[nX,2]))
		RecLock("SX1",.T.)
		SX1->X1_GRUPO   := aPerguntas[nX,01]
		SX1->X1_ORDEM   := aPerguntas[nX,02]
		SX1->X1_PERGUNT := aPerguntas[nX,03]
		SX1->X1_PERSPA  := aPerguntas[nX,04]
		SX1->X1_PERENG  := aPerguntas[nX,05]
		SX1->X1_VARIAVL := aPerguntas[nX,06]
		SX1->X1_TIPO    := aPerguntas[nX,07]
		SX1->X1_TAMANHO := aPerguntas[nX,08]
		SX1->X1_DECIMAL := aPerguntas[nX,09]
		SX1->X1_GSC     := aPerguntas[nX,10]
		SX1->X1_VAR01   := aPerguntas[nX,11]
		SX1->X1_DEF01   := aPerguntas[nX,12]
		SX1->X1_DEFSPA1 := aPerguntas[nX,13]
		SX1->X1_DEFENG1 := aPerguntas[nX,14]
		SX1->X1_DEF02   := aPerguntas[nX,15]
		SX1->X1_DEFSPA2 := aPerguntas[nX,16]
		SX1->X1_DEFENG2 := aPerguntas[nX,17]
		SX1->X1_DEF03   := aPerguntas[nX,18]
		SX1->X1_DEFSPA3 := aPerguntas[nX,19]
		SX1->X1_DEFENG3 := aPerguntas[nX,20]
		SX1->X1_CNT01   := aPerguntas[nX,21]
		SX1->X1_F3	 	:= aPerguntas[nX,Len(aPerguntas[nX])]
		MsUnlock()       
	EndIf		
Next nX 

RETURN Nil