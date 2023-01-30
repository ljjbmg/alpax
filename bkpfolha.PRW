#INCLUDE "PROTHEUS.CH"

USER FUNCTION BKPFOLHA()

Local cData := DTOC(DATE())+" - "+TIME()
Local cMsg  := "CONFIRMA INICIO BACKUP FOLHA, STATUS: "+cDATA+" ???"
Local bExec := {|| MYPROC()}

//if !MSGYESNO(cMsg,"Backup Folha[em SQLSERVER]")
//	alert("Processo cancelado!")
//	return(nil)
//endif


ALERT("PROCESSANDO BACKUP, PODE LEVAR ARGUNS MINUTOS!")

if ALLTRIM(TcGetDb()) <> "MSSQL"
	alert("Rotina exclusiva para servidores MSSSQL!")
	return
ENDIF

Processa( bExec, "Backup Folha" ,"Processando backup folha...",.f.)

RETURN
//=====================================================================
//=====================================================================
//=====================================================================

static function myproc()

Private  cDia := STRZERO(DAY(DATE()),2)
Private  cMes := STRZERO(MONTH(DATE()),2)
Private  cAno := SUBSTR(STRZERO(YEAR(DATE()),2),3,2)
Private  cCpy := ""
Private  cRC  := "RC"+iif(SM0->M0_CODIGO=="99","01",SM0->M0_CODIGO)+"%"
Private  cGP  := "GP"+iif(SM0->M0_CODIGO=="99","01",SM0->M0_CODIGO)+"%"
Private  cLogBK := ""
Private  cDirBKP := "\BACKUP\BK"+cAno+cMes+cDia+strtran(time(),":","")

MontaDIR(cDirBKP)

ProcRegua(0)

//====================================================================
// PROCESSANDO ARQUUIVOS SR?
//====================================================================

cLogBK += "PROCESSAMENTO INICIADO EM "+DTOC(DATE())+" - "+TIME()+CRLF
conOut("PROCESSAMENTO INICIADO EM "+DTOC(DATE())+" - "+TIME())

DBSELECTAREA("SX2")
DBSETORDER(1)
DBGOTOP()
DBSEEK("SR")

WHILE SX2->(!EOF()) .AND. SUBSTR(SX2->X2_CHAVE,1,2) == "SR"
	cCpy := cDirBKP+"\"+alltriM(SX2->X2_ARQUIVO)
	cLogBK += cCpy +CRLF
	ConOut(cCpy)
	IncProc("Processando: "+SX2->X2_CHAVE+" AGUARDE...")
	dbselectarea(SX2->X2_CHAVE)
	dbgotop()
	copy to &cCpy VIA "DBFCDX"
	
	SX2->(DBSKIP())
ENDDO

//====================================================================
// PROCESSANDO ARQUUIVOS SP?
//====================================================================

DBSELECTAREA("SX2")
DBSETORDER(1)
DBGOTOP()
DBSEEK("SP")

WHILE SX2->(!EOF()) .AND. SUBSTR(SX2->X2_CHAVE,1,2) == "SP"
	cCpy := cDirBKP+"\"+alltrim(SX2->X2_ARQUIVO)
	ConOut(cCpy)
	cLogBK += cCpy +CRLF
	IncProc("Processando: "+SX2->X2_CHAVE+" AGUARDE...")
	dbselectarea(SX2->X2_CHAVE)
	dbgotop()
	copy to &cCpy VIA "DBFCDX"
	
	SX2->(DBSKIP())
ENDDO

//====================================================================
// PROCESSANDO ARQUUIVOS RC+EMPRESA?
//====================================================================
IF SELECT("TMP") <> 0
	TMP->(DBSELECTAREA("TMP"))
	TMP->(DBCLOSEAREA())
ENDIF

cQry := "	SELECT name FILENAME FROM sysobjects WHERE (name like '"+cRC+"%' or name like '"+cGP+"%' )and xtype = 'U'   "
dbUseArea(.T., "TOPCONN",TCGENQRY(,,cQry),"TMP",.F.,.T.)
MEMOWRIT("c:\a\sql.sql",cQry)



if select("TMP") == 0
	ALERT("FALHA DO BACKUP RC, AVISE O DEPTO DE TI!!")
	ALERT("FALHA DO BACKUP RC, AVISE O DEPTO DE TI!!")
	ALERT("FALHA DO BACKUP RC, AVISE O DEPTO DE TI!!")
	cAlert := "nao foi possivel salvar arquivos rc..."+date()+" - "+time()
	MEMOWRIT(cDirBKP+"\errobkp.log",cAlert)
	RETURN
ENDIF


dbselectarea("TMP")
DBGOTOP()
WHILE TMP->(!EOF())
	IF SELECT("T_RC") <> 0
		T_RC->(DBSELECTAREA("T_RC"))
		T_RC->(DBCLOSEAREA())
	ENDIF
	
	IncProc("Processando: "+TMP->FILENAME+" AGUARDE...")
	cCpy := cDirBKP+"\"+alltrim(TMP->FILENAME)
	ConOut(cCpy)
	cLogBK += cCpy +CRLF
	dbusearea(.t.,"TOPCONN",TMP->FILENAME,"T_RC",.T.,.F.)
	dbselectarea("T_RC")
	DBGOTOP()
	COPY TO &cCpy VIA "DBFCDX"
	
	T_RC->(DBSELECTAREA("T_RC"))
	T_RC->(DBCLOSEAREA())
	
	
	TMP->(DBSKIP())
ENDDO

cLogBK += "PROCESSAMENTO FINALIZADO EM "+DTOC(DATE())+" - "+TIME()
MEMOWRIT(cDirBKP+"\backup.log",cLogBK)

IF SELECT("TMP") <> 0
	TMP->(DBSELECTAREA("TMP"))
	TMP->(DBCLOSEAREA())
ENDIF

return

  /*
USER FUNCTION RESFOLHA()
                               
Private cMsg, cPath, aDir

cMsg := "Retorno do backup conforme definicao do diretorio"
if !MSGNOYES(cMsg,"Restaura Backup Folha?[em SQLSERVER]")
	alert("Processo cancelado!")
	return(nil)
endif

MsgInfo("Informe diretorio a recuperar...")

cPath := ALLTRIM(cGetFile("Codebase|*.dbf|Ctree|*.dtc|Todos|*.*","Diretorio?",1,"\backup",.f.,GETF_RETDIRECTORY))
cPath := alltrim(cpath)

aDir := Directory(cPath+"*.DBF")


Processa({||RESBKP()}, "Retorno Folha" ,"Retorno backup folha...",.f.)

return


static function RESBKP()


ProcRegua(0)


For x := 1 to len(aDir)
	cTopFile := UPPER(alltrim(aDir[x,1]))
	cTopFile := ALLTRIM(strtran(cTopFile,".DBF",""))
	cBkpfile := cPath+UPPER(alltrim(aDir[x,1]))
	IF !MsFile(cTopFile,,"TOPCONN")
		LOOP
	ENDIF
	
	//dbusearea(.T.,"DBFCDX",cBkpfile,"ORI",.T.,.F.)
	dbusearea(.T.,"TOPCONN",cTopFile,"DES",.F.,.F.) 
	DBSELECTAREA("DES")
	DES->(__DBZAP())  
	CONOUT("Proc: "+cBkpfile) 
	APPEND FROM &cBkpfile
	
	
	
	DES->(dbclosearea())
	
Next


RETURN
*/

