#INCLUDE "PROTHEUS.CH"

USER FUNCTION RESFOLHA()

Local cData := DTOC(DATE())+" - "+TIME()
Local cMsg  := "CONFIRMA INICIO RESTORE DE BACKUP FOLHA, STATUS: "+cDATA+" ???"
Local bExec := {|| MYPROC()}

if !MSGYESNO("PROCESSANDO RESTAURE DE BACKUP, PODE LEVAR ARGUNS MINUTOS!","Restaure de Backup Folha[em SQLSERVER]")
	alert("Processo cancelado!")
	return(nil)
endif

if ALLTRIM(TcGetDb()) <> "MSSQL"
	alert("Rotina exclusiva para servidores MSSSQL!")
	return
ENDIF

Processa( bExec, "Restore Backup Folha" ,"Processando restore de backup folha...",.f.)

RETURN
//=====================================================================
//=====================================================================
//=====================================================================

static function myproc()

local na 

Private  cQry1          := ""         
Private  cTMP           := "" 
Private  cNames         := ""
Private  cFolMes        := ""
Private  cCpy           := ""
Private  cAlias         := ""
Private  cRC            := "RC"+iif(SM0->M0_CODIGO=="99","01",SM0->M0_CODIGO)+"%"
Private  cGP            := "GP"+iif(SM0->M0_CODIGO=="99","01",SM0->M0_CODIGO)+"%"
Private  cLogBK         := ""
Private  cDirBKP        := cGetFile("Diretório com os arquivos Backup DBF (*.DBF) |*.dbf|","",1, 'C:\', .F., GETF_RETDIRECTORY ,.T., .T. )
Private  aDirTmp        := STRTOKARR(cDirBKP,"\BACKUP") 
Private  aFilesRC    	:= DIRECTORY(cDirBKP+"RC*.DBF") 
Private  aFilesGP    	:= DIRECTORY(cDirBKP+"GP*.DBF")
Private  aFiles         := {}

MontaDIR(cDirBKP)

cDirBKP := "\BACKUP\"+aDirTmp[2]

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
	cTMP := RetSqlName(SX2->X2_CHAVE)
	cCpy := cDirBKP+"\"+LOWER(alltriM(SX2->X2_ARQUIVO))
	cLogBK += cCpy +CRLF
	ConOut(cCpy)
	fOpen(cCpy,2) 
	IncProc("Processando: "+SX2->X2_CHAVE+" AGUARDE...")	          
	cQry1 := " DROP TABLE "+cTMP+" " +CRLF
	if tcSQLexec(cQry1) < 0   //para verificar se a query funciona
		Conout("****************************************************") 
		Conout("ROTINA DE RESTORE DE FOLHA QUERY DE EXCLUSÃO DA TABELA "+SX2->X2_CHAVE+" ERRO NO SQL")
		Conout("ROTINA ABORTADA SEM REALIZAR EXCLUSÃO DA MESMA***") 
		Conout("****************************************************") 
		msginfo("Erro na consulta ao Banco de Dados Acione o suporte da TI")
		SX2->(DBSKIP())
		loop                                                         
    Else  
		cAlias := "TMP"    
		IF SELECT(cAlias) >0
			dbSelectArea(cAlias)
			dbCloseArea()
		Endif
		dbUseArea(.T.,"DBFCDX", cCpy , cAlias, .T., .F.)     //dbUseArea(.T.,"DBFCDX", "sigamat.emp" , cAlias, .T., .t.) 
		dbgotop()
		dbSelectArea(cAlias)
		copy to &cTMP VIA "TOPCONN"
		Conout("****************************************************") 
		Conout("ROTINA DE REABERTURA DE FOLHA RESTAURAÇÃO DA TABELA BACKUP "+SX2->X2_CHAVE+" REALIZADA")
		Conout("****************************************************")
		SX2->(DBSKIP())
	ENDIF	
ENDDO

//====================================================================
// PROCESSANDO ARQUUIVOS SP?
//====================================================================

DBSELECTAREA("SX2")
DBSETORDER(1)
DBGOTOP()
DBSEEK("SP")

WHILE SX2->(!EOF()) .AND. SUBSTR(SX2->X2_CHAVE,1,2) == "SP"
	cTMP := RetSqlName(SX2->X2_CHAVE)
	cCpy := cDirBKP+"\"+LOWER(alltriM(SX2->X2_ARQUIVO))
	cLogBK += cCpy +CRLF
	ConOut(cCpy)
	IncProc("Processando: "+SX2->X2_CHAVE+" AGUARDE...")	          
	cQry1 := " DROP TABLE "+cTMP+" " +CRLF
	if tcSQLexec(cQry1) < 0   //para verificar se a query funciona
		Conout("****************************************************") 
		Conout("ROTINA DE RESTORE DE FOLHA QUERY DE EXCLUSÃO DA TABELA "+SX2->X2_CHAVE+" ERRO NO SQL")
		Conout("ROTINA ABORTADA SEM REALIZAR EXCLUSÃO DA MESMA***") 
		Conout("****************************************************") 
		msginfo("Erro na consulta ao Banco de Dados Acione o suporte da TI")
		SX2->(DBSKIP())
		loop                                                         
    Else  
		cAlias := "TMP"    
		IF SELECT(cAlias) >0
			dbSelectArea(cAlias)
			dbCloseArea()
		Endif
		dbUseArea(.T.,"DBFCDX", cCpy , cAlias, .T., .F.)     //dbUseArea(.T.,"DBFCDX", "sigamat.emp" , cAlias, .T., .t.) 
		dbgotop()
		dbSelectArea(cAlias)
		copy to &cTMP VIA "TOPCONN"
		Conout("****************************************************") 
		Conout("ROTINA DE REABERTURA DE FOLHA RESTAURAÇÃO DA TABELA BACKUP "+SX2->X2_CHAVE+" REALIZADA")
		Conout("****************************************************")
		IF SELECT(cAlias) >0
			dbSelectArea(cAlias)
			dbCloseArea()
		Endif		
		SX2->(DBSKIP())
	ENDIF
ENDDO

//====================================================================
// PROCESSANDO ARQUUIVOS RC+EMPRESA?
//====================================================================
IF SELECT(cAlias) <> 0
	DBSELECTAREA(cAlias)
	DBCLOSEAREA()
ENDIF

cNames := ""

FOR nA := 1 to len(aFilesRC)
	cAlias  := "TMP"      
	aFiles  := STRTOKARR(aFilesRC[nA][1],".DBF")               
	cCpy    := cDirBKP+"\"+LOWER(aFiles[1])
	cTmp    := LOWER(aFiles[1])
	cLogBK  += cCpy +CRLF
	cNames  += "'"+UPPER(aFiles[1])+"',"
	ConOut(cCpy)
	IncProc("Processando: "+UPPER(aFiles[1])+" AGUARDE...")	
	cQry1 := " DROP TABLE "+UPPER(aFiles[1])+" " +CRLF
	if tcSQLexec(cQry1) < 0   //para verificar se a query funciona
		Conout("****************************************************") 
		Conout("ROTINA DE RESTORE DE FOLHA QUERY DE EXCLUSÃO DA TABELA "+UPPER(aFiles[1])+" ERRO NO SQL")
		Conout("ROTINA ABORTADA SEM REALIZAR EXCLUSÃO DA MESMA***") 
		Conout("****************************************************") 
		msginfo("Erro na consulta ao Banco de Dados Acione o suporte da TI")
		loop                                                         
    Else
		IF SELECT(cAlias) >0
			dbSelectArea(cAlias)
			dbCloseArea()
		Endif
		dbUseArea(.T.,"DBFCDX",cCpy , cAlias, .T., .F.)    
		dbgotop()
		dbSelectArea(cAlias)
		copy to &cTmp VIA "TOPCONN"
		Conout("****************************************************") 
		Conout("ROTINA DE REABERTURA DE FOLHA RESTAURAÇÃO DA TABELA BACKUP "+UPPER(aFiles[1])+" REALIZADA")
		Conout("****************************************************")
		IF SELECT(cAlias) >0
			dbSelectArea(cAlias)
			dbCloseArea()
		Endif
	Endif	
Next nA

FOR nA := 1 to len(aFilesGP)
	cAlias  := "TMP"      
	aFiles  := STRTOKARR(aFilesGP[nA][1],".DBF")               
	cCpy    := cDirBKP+"\"+LOWER(aFiles[1])
	cTmp    := LOWER(aFiles[1])
	cLogBK  += cCpy +CRLF 
	cNames  += "'"+UPPER(aFiles[1])+"',"
	ConOut(cCpy)
	IncProc("Processando: "+UPPER(aFiles[1])+" AGUARDE...")	
	cQry1 := " DROP TABLE "+UPPER(aFiles[1])+" " +CRLF
	if tcSQLexec(cQry1) < 0   //para verificar se a query funciona
		Conout("****************************************************") 
		Conout("ROTINA DE RESTORE DE FOLHA QUERY DE EXCLUSÃO DA TABELA "+UPPER(aFiles[1])+" ERRO NO SQL")
		Conout("ROTINA ABORTADA SEM REALIZAR EXCLUSÃO DA MESMA***") 
		Conout("****************************************************") 
		msginfo("Erro na consulta ao Banco de Dados Acione o suporte da TI")
		loop                                                         
    Else
		IF SELECT(cAlias) >0
			dbSelectArea(cAlias)
			dbCloseArea()
		Endif
		dbUseArea(.T.,"DBFCDX",cCpy , cAlias, .T., .F.)    
		dbgotop()
		dbSelectArea(cAlias)
		copy to &cTmp VIA "TOPCONN"
		Conout("****************************************************") 
		Conout("ROTINA DE REABERTURA DE FOLHA RESTAURAÇÃO DA TABELA BACKUP "+UPPER(aFiles[1])+" REALIZADA")
		Conout("****************************************************")
		IF SELECT(cAlias) >0
			dbSelectArea(cAlias)
			dbCloseArea()
		Endif
	Endif
Next nA

cNames := substr(cNames,1,len(cNames)-1)

cQry1 := " SELECT name AS 'FILE_NAME'  "+CRLF 
cQry1 += " FROM sysobjects "+CRLF 
cQry1 += " WHERE (name like '"+cRC+"%' or name like '"+cGP+"%' )and xtype = 'U' "+CRLF 
cQry1 += "       AND name NOT IN ("+cNames+") "+CRLF 
cQry1 += " ORDER BY name " +CRLF 

Conout(cQry1)

dbUseArea(.T., "TOPCONN",TCGENQRY(,,cQry1),cAlias,.F.,.T.)

dbSelectArea(cAlias)  
(cAlias)->(dbGotop())
If (cAlias)->(!EOF())
	Do While (cAlias)->(!EOF())
		cQry1 := " DROP TABLE "+(cAlias)->FILE_NAME+" " +CRLF
		if tcSQLexec(cQry1) < 0   //para verificar se a query funciona
			Conout("****************************************************") 
			Conout("ROTINA DE RESTORE DE FOLHA QUERY DE EXCLUSÃO DA TABELA "+(cAlias)->FILE_NAME+" ERRO NO SQL")
			Conout("****************************************************") 
			msginfo("Erro na consulta ao Banco de Dados Acione o suporte da TI")
		Endif                                                         
		(cAlias)->(dbSkip())
	Enddo
Endif
		
IF SELECT(cAlias) >0
	dbSelectArea(cAlias)
	dbCloseArea()
Endif
                                         
cFolMes := cValtoChar(YEAR(DATE())) + STRZERO(month(date())-1, 2)
PUTMV("MV_FOLMES",cFolMes) 
		
cLogBK += "PROCESSAMENTO FINALIZADO EM "+DTOC(DATE())+" - "+TIME()
MEMOWRIT(cDirBKP+"\Retorno_backup.log",cLogBK)

IF SELECT(cAlias) >0
	dbSelectArea(cAlias)
	dbCloseArea()
Endif

return
