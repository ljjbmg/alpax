#INCLUDE "PROTHEUS.ch"
#INCLUDE "TBICONN.ch"

// IMPORTACAO
User Function IMPTABFM()

Local cTpArq    := "Delimitado (*.csv)|*.CSV|"
Local cFile     := cGetFile(cTpArq, , 0, "SERVIDOR\", .T., GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE)

//Private nheader := FT_FUSE("D:\TEMP\TES.CSV")
Private nheader := FT_FUSE(cFile)
Private aDBF := {}

if select("SX6") == 0
	PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01" MODULO "FAT"                             
ENDIF

AADD(aDBF,{"TPOPER"  ,"C",02,00})
AADD(aDBF,{"TES"     ,"C",03,00})
AADD(aDBF,{"CLI"     ,"C",03,00})
AADD(aDBF,{"PROD"    ,"C",04,00})
AADD(aDBF,{"EST"     ,"C",02,00})
AADD(aDBF,{"NCM"     ,"C",08,00})
AADD(aDBF,{"TIPOCLI" ,"C",01,00})
TCDELFILE("IMPTABFM")
DBCREATE("IMPTABFM",aDBF,"TOPCONN")
DBUSEAREA(.T.,"TOPCONN","IMPTABFM","TABFM",.T.,.f.)
dbselectarea("TABFM")

if nHeader < 0
	MsgAlert("Falha de abertura:C:\TEMP\IMPTABFM.CSV")
	return
endif

FT_FGOTOP()

while !FT_FEOF()
	
	nLin := FT_FRECNO()
	cLin := FT_FREADLN()
	aLin := SEPARA(cLin,";",.t.)
/*	
	IF nLin == 1 //TPOPER;TES;CLI;PROD;EST;NCM;TIPOCLI
		FT_FSKIP()
		LOOP
	ENDIF
*/	
	/*
	aLin[4] := STRTRAN(aLin[4],"R$","")// TIRANDO R$
	aLin[4] := STRTRAN(aLin[4],".","")// TIRANDO PONTO
	aLin[4] := STRTRAN(aLin[4],",",".")// TIRANDO VIRGULA, COLOCA PONTO
	
	aLin[5] := STRTRAN(aLin[5],"R$","")// TIRANDO R$
	aLin[5] := STRTRAN(aLin[5],".","")// TIRANDO PONTO
	aLin[5] := STRTRAN(aLin[5],",",".")// TIRANDO VIRGULA, COLOCA PONTO
	*/
	
	_cTpOper  := alltrim(aLin[1])
	_cTs      := alltrim(aLin[2])
	_cCli     := alltrim(aLin[3])
	_cProd    := alltrim(aLin[4])
	_cEst     := alltrim(aLin[5])
	_cNcm     := alltrim(aLin[6])
	_cTipocli := alltrim(aLin[7])
	
	
	DBSELECTAREA("TABFM")
	RECLOCK("TABFM",.T.)
	TABFM->TPOPER  := _cTpOper
	TABFM->TES      := _cTs
	TABFM->CLI     := _cCli
	TABFM->PROD    := _cProd
	TABFM->EST     := _cEst
	TABFM->NCM     := _cNcm
	TABFM->TIPOCLI := _cTipocli
	MSUNLOCK()
	COMMIT
	
	CONOUT("LINHA:"+STRZERO(nLin,3))
	
	// tratar
	FT_FSKIP()
ENDDO


BEGINSQL ALIAS "TRB"
	/*
	COLUMN PICM AS NUMERIC(17,2)
	COLUMN NBST AS NUMERIC(17,2)
	COLUMN NBICM AS NUMERIC(17,2)
	COLUMN NSALDO AS NUMERIC(17,2)
	*/
	
	SELECT I.*//, CASE WHEN  ISNULL(B1_PICM,18) = 0 THEN  18 ELSE  ISNULL(B1_PICM,18) END PICM
	FROM IMPTABFM I
	
ENDSQL
x := 2

DBSELECTAREA("TRB")
DBGOTOP()
WHILE TRB->(!EOF())
	DBSELECTAREA("SFM")
	dbOrderNickName("IMPTABFM")  //FM_FILIAL+FM_TIPO+FM_GRTRIB+FM_GRPROD+FM_EST+FM_POSIPI
	If dbSeek(xFilial("SFM") + TRB->TPOPER + PADR(TRB->CLI,3) + PADR(TRB->PROD,6) + TRB->EST + TRB->NCM)
	//If (SFM->FM_TIPO+SFM->FM_TS+SFM->FM_GRTRIB+SFM->FM_GRPROD+SFM->FM_EST+SFM->FM_POSIPI+SFM->FM_TIPOCLI) <> (TRB->TPOPER+TRB->TES+TRB->CLI+TRB->PROD+TRB->EST+TRB->NCM+TRB->TIPOCLI)
		RECLOCK("SFM",.F.)
		SFM->FM_FILIAL  := XFILIAL("SFM")
		SFM->FM_TIPO    := TRB->TPOPER
		SFM->FM_TS      := TRB->TES
		SFM->FM_GRTRIB  := TRB->CLI
		SFM->FM_GRPROD  := TRB->PROD
		SFM->FM_EST     := TRB->EST
		SFM->FM_POSIPI  := TRB->NCM
		SFM->FM_TIPOCLI := TRB->TIPOCLI
		msunlock()
	Else
		RECLOCK("SFM",.T.)
		SFM->FM_FILIAL  := XFILIAL("SFM")
		SFM->FM_TIPO    := TRB->TPOPER
		SFM->FM_TS      := TRB->TES
		SFM->FM_GRTRIB  := TRB->CLI
		SFM->FM_GRPROD  := TRB->PROD
		SFM->FM_EST     := TRB->EST
		SFM->FM_POSIPI  := TRB->NCM
		SFM->FM_TIPOCLI := TRB->TIPOCLI
		msunlock()
	
	EndIf
	commit
	DBSELECTAREA("TRB")
	TRB->(dbskip())
enddo

TRB->(dbcloseArea())
TABFM->(dbcloseArea())

MEMOWRIT("D:\TEMP\LOGTES.TXT",TIME())

Alert("Fim do Processamento!!")

Return