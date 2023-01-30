#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"
#DEFINE SIMPLES Char( 39 )
#DEFINE DUPLAS  Char( 34 )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ALPA001   ºAutor  ³ Biale              º Data ³  04/19/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ALLPAX                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION ALPA010
private cPerg	  := "ALPA10000"

PRIVATE oProcess  := NIL
PRIVATE cCFO := ""
PRIVATE aCFO := {}
PRIVATE FCFO

cPerg := PADR(cPerg,10)

DBSELECTAREA("ZB0")
DBSELECTAREA("ZB1")
IF !SX6->(DBSEEK(SPACE(2)+"MV_STCFSAI"))
     DBSELECTAREA("SX6")
     RECLOCK("SX6",.T.)
		SX6->X6_FIL     := ""
		SX6->X6_VAR     := 'MV_STCFSAI'
		SX6->X6_TIPO    := 'C'
		SX6->X6_DESCRIC := 'RELACAO DE CFOS DE ANALISE DE NOTAS DE ST(SUBSTR(CFO,2,3)) - SAIDA'
		SX6->X6_DSCSPA  := SX6->X6_DESCRIC
		SX6->X6_DSCENG  := SX6->X6_DESCRIC
		SX6->X6_CONTEUD := '401/403'
		SX6->X6_CONTSPA := SX6->X6_CONTEUD
		SX6->X6_CONTENG := SX6->X6_CONTEUD
		SX6->X6_PROPRI  := 'U'
     MSUNLOCK()
     COMMIT
ENDIF

cCFO := ALLTRIM(GETMV("MV_STCFSAI"))
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

/*
==========================================================================
*/

STATIC FUNCTION ALPAPROC
LOCAL cAlias1 := GetNextAlias() // Tabela de Saldo das NFEs (ZB0)
LOCAL cAlias2 := GetNextAlias() // Tabela de Apropriação das NFEs (ZB1)
LOCAL cAlias3 := GetNextAlias() // Tabela SD2
//LOCAL cPerg	  := "ALPA10"
LOCAL lZeraSal := .F.
LOCAL lRestSal := .F.
LOCAL lAloc100 := .F.
LOCAL cQtdNApr := 0
LOCAL cQtdApr  := 0

//cPerg := PADR(cPerg,10)

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
//AJUSTASX1()
//If Pergunte(cPerg,.T.)

//Trecho alterado por Jesus -> Biale 14/06/2011
cQry := "  SELECT SD2.D2_EMISSAO, SD2.D2_COD, SD2.D2_DOC, SD2.D2_SERIE, SD2.D2_ITEM, SD2.D2_QUANT, SD2.D2_PRCVEN, SD2.D2_VALICM  "+CRLF
cQry += "  FROM "+RETSQLNAME("SD2")+"  SD2 (NOLOCK) "+CRLF
CQry += " WHERE  SD2.D_E_L_E_T_ = ''  "+CRLF
cQry += "   AND	 SD2.D2_FILIAL  = '"+XFILIAL("SD2")+"'  "+CRLF
cQry += "   AND  SD2.D2_DOC+SD2.D2_SERIE+SD2.D2_ITEM NOT IN (  	SELECT 	ZB1.ZB1_NFSNUM+ZB1.ZB1_NFSSER+ZB1.ZB1_NFSITM   " +CRLF
cQry += "  	  													  FROM 	"+RETSQLNAME("ZB1")+" ZB1 (NOLOCK) "+CRLF
cQry += "  	  													  WHERE 	ZB1.ZB1_FILIAL  = '"+XFILIAL("ZB1")+"'   "+CRLF
cQry += "  	  													    AND  ZB1.D_E_L_E_T_ = ''	) "+CRLF
cQry += "  	AND  SD2.D2_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' 	AND '"+DTOS(MV_PAR02)+"' 	  "+CRLF
cQry += "  	AND  SD2.D2_COD     BETWEEN '"+MV_PAR03+"'          AND '"+MV_PAR04+"'   "+CRLF
cqry += "   AND  SUBSTRING(SD2.D2_CF,2,3) IN ("+FCFO+")   "+CRLF
cqry += "   ORDER BY SD2.D2_EMISSAO DESC  "+CRLF
MEMOWRIT("C:\A\ALPAX010A.SQL",CQRY)
DBUSEAREA(.T.,"TOPCONN",TCGENQRY(,,CQRY),cAlias3,.T.,.F.)

	oProcess:SetRegua1( (cAlias3)->(RecCount()) )
	//			 SD2.D2_COD = '010131879018970' AND

	WHILE  &(cAlias3)->(!EOF())

		oProcess:IncRegua1( 'Atualizando NF Saida: ' + &(cAlias3+"->D2_DOC")+ ' Serie:' +&(cAlias3+"->D2_SERIE")+ ' Item:' +&(cAlias3+"->D2_ITEM")+ ' ...' )

		BEGINSQL Alias cAlias2 //Posiciono na  ultima entrada com data inferior a da saida atual que não foi apropriada
			COLUMN  ZB0_EMISSA   AS DATE
			SELECT	ZB0.ZB0_EMISSA, ZB0.ZB0_PRODUT, ZB0.ZB0_NFENUM, ZB0.ZB0_NFESER, ZB0.ZB0_NFEITM,
					ZB0.ZB0_NFEQTD, ZB0.ZB0_NFEVUN, ZB0.ZB0_NFESAL, ZB0.ZB0_ICMSRE,    ZB0.ZB0_EST,
					ZB0.ZB0_FORNEC,   ZB0.ZB0_LOJA, ZB0.ZB0_TIPO
			FROM	%Table:ZB0% ZB0
			WHERE	ZB0.ZB0_FILIAL  =   %xFilial:ZB0% 					AND
					ZB0.ZB0_PRODUT 	= 	%Exp:&(cAlias3+"->D2_COD")% 	AND
					ZB0.ZB0_EMISSA 	<=  %Exp:&(cAlias3+"->D2_EMISSAO")% AND
					ZB0.%notDel%
			ORDER BY ZB0.ZB0_EMISSA DESC
		ENDSQL

		lZeraSal := .F.
		lRestSal := .F.
		lAloc100 := .F.
		cQtdNApr := &(cAlias3+"->D2_QUANT")
		cQtdApr  := 0
		oProcess:SetRegua2( (cAlias2)->(RecCount()) )

		WHILE !&(cAlias2)->(EOF()) .AND. !lAloc100 .AND. &(cAlias2+"->ZB0_NFESAL") > 0//Até o Fim do Arquivo e Alocação 100% da NFE

		        // Atualiza a Sequencia
				cSeq := ALPA10SEQ( &(cAlias2+"->ZB0_NFENUM"), &(cAlias2+"->ZB0_NFESER"), &(cAlias2+"->ZB0_NFEITM"))

				// Verifico se a Nota foi processada
				oProcess:IncRegua2( 'Analisando NF Entrada: ' + &(cAlias2+"->ZB0_NFENUM")+ ' Serie:' +&(cAlias2+"->ZB0_NFESER")+ ' ...' )

				// Aproprio a Quantidade da Nota
				RecLock("ZB1",.T.)
				Replace ZB1_EMISSA With &(cAlias2+"->ZB0_EMISSA")					// NFe Emissão
				Replace ZB1_PRODUT With &(cAlias2+"->ZB0_PRODUT")					// NFe Produto
				Replace ZB1_NFENUM With &(cAlias2+"->ZB0_NFENUM")					// NFe Numero da Nota
				Replace ZB1_NFESER With &(cAlias2+"->ZB0_NFESER")					// NFe Serie
				Replace ZB1_NFEITM With &(cAlias2+"->ZB0_NFEITM")					// NFe Item

				If 	&(cAlias2+"->ZB0_NFESAL") = cQtdNApr							// Quantidade da NFs a apropriar igual a da NFe
					Replace ZB1_NFEQTD  With cQtdNApr			  					// NFe Quantidade Apropriada
					nSAtu 	 := 0
					lZeraSal := .T.
					lRestSal := .F.
					lAloc100 := .T.
					cQtdApr  := cQtdNApr
					cQtdNApr := 0
				ElseIf	&(cAlias2+"->ZB0_NFESAL") > cQtdNApr						// Quantidade da NFe maior que a da NFs a apropriar
					Replace ZB1_NFEQTD  With cQtdNApr								// NFe Quantidade Apropriada
					nSAtu := &(cAlias2+"->ZB0_NFESAL") - cQtdNApr
					lZeraSal := .F.
					lRestSal := .T.
					lAloc100 := .T.
					cQtdApr  := cQtdNApr
					cQtdNApr := 0
	            Else 																// Quantidade da NFe menor que a da NFs a apropriar
					Replace ZB1_NFEQTD  With &(cAlias2+"->ZB0_NFESAL")				// NFe Quantidade Apropriada
					nSAtu 	 := 0
					lZeraSal := .T.
					lRestSal := .F.
					lAloc100 := .F.
					cQtdApr  := &(cAlias2+"->ZB0_NFESAL")
					cQtdNApr := cQtdNApr - &(cAlias2+"->ZB0_NFESAL")
	            EndIf
	            
				Replace ZB1_NFEVUN With	&(cAlias2+"->ZB0_NFEVUN")					// NFe Valor Unitário

				//Trecho alterado por Jesus -> Biale 14/06/2011
				Replace ZB1_ICMSRE With (&(cAlias2+"->ZB0_ICMSRE")/&(cAlias2+"->ZB0_NFEQTD")*ZB1_NFEQTD)

				Replace ZB1_NFESEQ With cSeq		 								// NFe Sequencia Apropriação
				Replace ZB1_NFSNUM With &(cAlias3+"->D2_DOC")	 					// NFs Nota de Saida que Apropriou
				Replace ZB1_NFSSER With &(cAlias3+"->D2_SERIE") 					// NFs Serie
				Replace ZB1_NFSITM With &(cAlias3+"->D2_ITEM")						// NFs Item
				Replace ZB1_NFSQTD With &(cAlias3+"->D2_QUANT") 					// NFs Quantidade
				Replace ZB1_NFSVAL With &(cAlias3+"->D2_PRCVEN") 					// NFs Valor Saida

				//Trecho alterado por Jesus -> Biale 14/06/2011
				Replace ZB1_ICMSRS With &(cAlias3+"->D2_VALICM")
				MsUnlock()

			If lZeraSal // NFE Alocada necessito verificar a existencia de outras sequencias
			    ZB0->(DBSetOrder(2))
	   		    ZB0->(DBGoTop())
			    If ZB0->(DBSeek(xFilial('ZB0')+&(cAlias2+"->ZB0_NFENUM")+&(cAlias2+"->ZB0_NFESER")+DTOS(&(cAlias2+"->ZB0_EMISSA"))+&(cAlias2+"->ZB0_NFEITM")+&(cAlias2+"->ZB0_PRODUT")))
					RecLock("ZB0",.F.)
			       	Replace ZB0_NFESAL With 0
					MsUnlock()
			    EndIf
			Else
			    ZB0->(DBSetOrder(2))
			    ZB0->(DBGoTop())
			    If ZB0->(DBSeek(xFilial('ZB0')+&(cAlias2+"->ZB0_NFENUM")+&(cAlias2+"->ZB0_NFESER")+DTOS(&(cAlias2+"->ZB0_EMISSA"))+&(cAlias2+"->ZB0_NFEITM")+&(cAlias2+"->ZB0_PRODUT")))
					RecLock("ZB0",.F.)
			       	Replace ZB0_NFESAL With nSAtu
					MsUnlock()
			    EndIf
			EndIf
			// Flag de Utilização em ambos os registro da  tabela

			&(cAlias2)->(DBSKIP())
		ENDDO

		//&(cAlias2)->(DBClearInd())
		//FErase(cAlias2+OrdBagExt())
		(cAlias2)->(dbCloseArea())

		&(cAlias3)->(DBSKIP())
	ENDDO

	//&(cAlias3)->(DBClearInd())
	//FErase(cAlias3+OrdBagExt())
	(cAlias3)->(dbCloseArea())
//EndIf

RETURN NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ALPA001  ºAutor  ³ Biale              º Data ³  05/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Obtem o numero sequencial da apropriação de uma NFe        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ALPAX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

STATIC FUNCTION ALPA10SEQ(cNota, cSerie, cItem)
LOCAL cSeq   := '001'
LOCAL cAlias := GetNextAlias()

BEGINSQL Alias cAlias
	SELECT 	COUNT(*) AS TOTAL
	FROM 	%Table:ZB1% ZB1
	WHERE 	ZB1.ZB1_FILIAL  = %xFilial:ZB1% AND
		ZB1.ZB1_NFSNUM 	= %Exp:cNota% 	AND
		ZB1.ZB1_NFSSER	= %Exp:cSerie% 	AND
		ZB1.ZB1_NFSITM	= %Exp:cItem% 	AND
		ZB1.%notDel%
	GROUP BY ZB1.ZB1_NFENUM, ZB1.ZB1_NFESER, ZB1.ZB1_NFEITM
ENDSQL

IF !&(cAlias)->(EOF())
	cSeq := &(cAlias+"->TOTAL")
ENDIF

DBClearInd()
FErase(cAlias+OrdBagExt())
DBCloseArea(cAlias)

Return cSeq

//------------------------------------------------------------------------------------------------------------------------------------------

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
//Local cPerg		 := "ALPA10"

cPerg := PADR(cPerg,10)

Aadd(aPerguntas,{cPerg,"01","Emissao De            :","Emissao De            :","Emissao De            :","mv_ch1","D", 					   8,0,"G","mv_par01","","","","","","","","","",      "","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPerguntas,{cPerg,"02","Emissao Ate           :","Emissao Ate           :","Emissao Ate           :","mv_ch2","D", 					   8,0,"G","mv_par02","","","","","","","","","",      "","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPerguntas,{cPerg,"03","Produto de            :","Produto de            :","Produto de            :","mv_ch3","C",      TamSx3("B1_COD")[1],0,"G","mv_par03","","","","","","","","","",      "","","","","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})
Aadd(aPerguntas,{cPerg,"04","Produto Ate           :","Produto Ate           :","Produto Ate           :","mv_ch4","C",      TamSx3("B1_COD")[1],0,"G","mv_par04","","","","","","","","","",      "","","","","","","","","","","","","","","","","","","","","","","","","","","","","SB1"})

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