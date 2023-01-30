#INCLUDE "PROTHEUS.CH" 

USER FUNCTION CONFNFS()	//U_CONFNFS()

/*
AUTOR	: ANDERSON BIALE
DATA	: 10/10/12
DESC	: TELA PARA CONFERENCIA DE NFS X SEPARACAO
*/
    
	PRIVATE oFontCab   := TFont():New("MS Sans Serif",,018,, .T. ,,,,, .F. , .F. )
	PRIVATE oFontItens := TFont():New("MS Sans Serif",,016,, .T. ,,,,, .F. , .F. )
	PRIVATE oDlg
	PRIVATE oPanel1
	PRIVATE oLblProd
	PRIVATE oNOTA
	PRIVATE cNOTA		:= ""	
	PRIVATE cCodProd   	:= ""
	PRIVATE oLblDescProd
	PRIVATE cDescProd  	:= ""
	PRIVATE oLblLote
	PRIVATE oSEPARA
	PRIVATE cSEPARA     := ""
	PRIVATE oCAIXA
	PRIVATE nCAIXA      := 0
	PRIVATE oCOUNT	
	PRIVATE nCOUNT		:= 0
	PRIVATE oLOCAL
	PRIVATE cLOCAL      := ""
	PRIVATE oLblSerie
	PRIVATE oSerie
	PRIVATE cSERIAL     := ""
	PRIVATE oBtnFechar
	PRIVATE oBtnLimpar
	PRIVATE oBtnOK
	PRIVATE oLblLerProdSer
	PRIVATE oPanel2
	PRIVATE oGravProdLoteSerie
	PRIVATE cSERIE 		:= ""
	
	PRIVATE oNFS
	PRIVATE aNFS   := {}	//Array( 1,4 )
	
	PRIVATE oSEP
	PRIVATE aSEP   := Array( 1,6 )
	
	PRIVATE oARM
	PRIVATE aARM   := {}	//Array( 1,2 )
		
	PRIVATE aTamCamp   := {}
	PRIVATE lRetProd   := .F.
	PRIVATE lRetLote   := .F.
	PRIVATE lRETSERIAL := .F.
	PRIVATE lAltProds  := .F.
	PRIVATE cARMTRA	   := ""		//ARMAZEM DE TRANSFERENCIA
	PRIVATE cENDTRA	   := ""		//ENDERECO DE TRANSFERENCIA		
	PRIVATE cPERG	   := "CONFNFS2"//PARAMETROS
	
	PRIVATE	cCODBAR	   	:= "" 		//CODIGO BARRAS DE CONTROLE
	PRIVATE cPEDIDO		:= ""     	//NUM PEDIDO
	PRIVATE cITEM		:= ""     	//ITEM
	PRIVATE cPRODUTO	:= ""     	//COD PRODUTO
	PRIVATE cPRODESC 	:= ""		//DESC PRODUTO
	PRIVATE nQUANT	   	:= 0		//QUANTIDADE
	PRIVATE nSOMA		:= 0		//SOMAR QTDE DO ITEM NO ARRAY 
	PRIVATE aRECNO		:= {}		//RECEBE RECNOS DA SEPARACAO DO SC9
	
	//CRIANDO PARAMETROS
	CRIASX1()
	IF !(PERGUNTE(cPERG))  											//CHAMA PERGUNTAS
		RETURN                 										//SE CANCELOU FINALIZA, SE OK CONTINUA FUNCAO
	ENDIF															//FIM
	INICAMPO()	//INICIALIZANDO O TAMANHO DOS CAMPOS
	
	//QUERY NOTA SAIDA ------------------------------------------------------------------------------------------------------------------------------------------------------
	cQRY:=" SELECT F2_DOC, F2_SERIE, D2_PEDIDO, D2_CODBAR, D2_COD, B1_DESC, SUM(D2_QUANT) AS D2_QUANT "	+CRLF
	cQRY+=" FROM "+RETSQLNAME("SD2")+" AS D2 (NOLOCK) "                            						+CRLF
	cQRY+=" LEFT JOIN "+RETSQLNAME("SF2")+" AS F2 (NOLOCK) ON D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE "	+CRLF  
	cQRY+=" LEFT JOIN "+RETSQLNAME("SB1")+" AS B1 (NOLOCK) ON D2_COD = B1_COD "    						+CRLF
	cQRY+=" WHERE D2.D_E_L_E_T_ = '' AND D2_FILIAL = '"+xFILIAL("SD2")+"' "       						+CRLF
	cQRY+=" 	AND B1.D_E_L_E_T_ = '' AND B1_FILIAL = '"+xFILIAL("SB1")+"' "    						+CRLF
	cQRY+="		AND F2_CHVNFE = '"+ALLTRIM(MV_PAR01)+"' "												+CRLF
	//cQRY+=" 	AND D2_DOC = '"+ALLTRIM(MV_PAR01)+"' "                             						+CRLF
	//cQRY+=" 	AND D2_SERIE = '"+ALLTRIM(MV_PAR02)+"' "                           						+CRLF
	cQRY+=" GROUP BY F2_DOC, F2_SERIE, D2_PEDIDO, D2_CODBAR, D2_COD, B1_DESC "							+CRLF											
	IF SELECT("NFS") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("NFS")    										//SELECIONA ALIAS
		NFS->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM
	DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"NFS",.T.,.T.)		//ABRINDO ALIAS    
	
	NFS->(DBGOTOP())
	WHILE NFS->(!EOF())
		IF !EMPTY(NFS->D2_COD)							 					//SE ACHOU PRODUTO
			AADD( aNFS,{ALLTRIM(NFS->D2_PEDIDO)			,;					//PEDIDO
					ALLTRIM(NFS->D2_CODBAR)				,; 					//COD SEPARACAO
					ALLTRIM(NFS->D2_COD)				,; 					//COD PRODUTO
					ALLTRIM(NFS->B1_DESC)				,;  				//DESC PRODUTO
					ALLTRIM(cVALTOCHAR(NFS->D2_QUANT))	} ) 				//QUANTIDADE				
			cNOTA 	:= NFS->F2_DOC
			cSERIE  := NFS->F2_SERIE
			cCODBAR := ALLTRIM(NFS->D2_CODBAR) 
		ELSE                                                              	//SE NAO ACHOU       
			MSGALERT("NOTA FISCAL NÃO ENCONTRADA!","CONFNFS.PRW LINE:100")	//ALERTA
		ENDIF				       	                                    	//FIM
  		NFS->(DBSKIP())
    ENDDO
    
    IF SELECT("NFS") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("NFS")    										//SELECIONA ALIAS
		NFS->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM
    
    //ARMAZENAMENTO --------------------------------------------------------------------------
    cQRY:=" SELECT ZBC_CODSEP, ZBC_CAIXA, ZBC_LOCAL, ZBC_STATUS  "		+CRLF
	cQRY+=" FROM "+RETSQLNAME("ZBC")+" AS ZBC (NOLOCK) " 				+CRLF                 	
	cQRY+=" WHERE ZBC.D_E_L_E_T_ = '' "                   				+CRLF
	cQRY+=" 	AND ZBC_FILIAL = '"+xFILIAL("ZBC")+"' "   				+CRLF
	cQRY+=" 	AND ZBC_NOTA = '"+ALLTRIM(cNOTA)+"' " 	 				+CRLF
	cQRY+=" 	AND ZBC_SERIE = '"+ALLTRIM(cSERIE)+"' " 				+CRLF
	cQRY+=" 	AND ZBC_CODSEP = '"+ALLTRIM(cCODBAR)+"' "				+CRLF	
	cQRY+=" GROUP BY ZBC_CODSEP, ZBC_CAIXA, ZBC_LOCAL, ZBC_STATUS "   	+CRLF
	IF SELECT("ARM") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("ARM")    										//SELECIONA ALIAS
		ARM->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM
	DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"ARM",.T.,.T.)		//ABRINDO ALIAS
	ARM->(DBGOTOP())
	IF !EMPTY(ARM->ZBC_LOCAL)
		WHILE ARM->(!EOF())
			//VALIDACAO PARA VERIFICAR SE JA FOI EXPEDIDO
			IF ARM->ZBC_STATUS <> "1" 
				MSGALERT("NOTA FISCAL JÁ FOI EXPEDIDA OU AINDA NÃO FOI SEPARADA!","CONFNFS.PRW LINE:128")
				RETURN	
			ENDIF
			
			//PREENCHE ARRAY ARMAZENAMENTO --------------------------------
			AADD( aARM,{ALLTRIM(ARM->ZBC_CODSEP)			,;			//CODIGO SEPARACAO
						STRZERO(ARM->ZBC_CAIXA,3)			,;			//CAIXA
						ALLTRIM(cVALTOCHAR(ARM->ZBC_LOCAL))	} ) 		//LOCAL
			
			//PREENCHE NUMERO DE CAIXAS -----------------------------------
			IF nCAIXA < ARM->ZBC_CAIXA
				nCAIXA := ARM->ZBC_CAIXA
			ENDIF
			
			ARM->(DBSKIP())
		ENDDO
	ENDIF
	IF SELECT("ARM") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("ARM")    										//SELECIONA ALIAS
		ARM->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM

  	//DEFININDO TELA ----------------------------------------------------------------------------------------------------------------------------------------------------------------
	DEFINE MSDIALOG oDlg TITLE "CONFERÊNCIA DA SEPARAÇÃO" FROM 000,000 TO 600,1200 COLORS 0,16777215 PIXEL
		
		//SEPARACAO --------------------------------------------------------------------------------------------------------------------------
		@ 007,002 SAY "SEPARACAO:" 	               	SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 006,040 MSGET oSEPARA VAR cSEPARA			SIZE 085,010 OF oDlg VALID VALSEP() COLORS CLR_BLACK PIXEL
		
		@ 007,132 SAY "CAIXA(S): "					SIZE 050,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 007,170 SAY STRZERO(nCAIXA,3)				SIZE 085,010 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		
		@ 007,262 SAY "COUNT "						SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 006,300 MSGET oCOUNT VAR nCOUNT			SIZE 085,010 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		   
		//NOTA FISCAL SAIDA ------------------------------------------------------------------------------------------------------------------
		@ 028,002 SAY "NOTA:"	SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 028,040 SAY cNOTA 	SIZE 085,010 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 028,132 SAY "SÉRIE:"	SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 028,170 SAY cSERIE   	SIZE 085,010 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 035,002 LISTBOX oNFS Fields HEADER "Pedido","Separação","Produto","Descricao","Quant" SIZE 600,080 OF oDlg PIXEL
	    IF LEN(aNFS) > 0 
			oNFS:SetArray( aNFS )
			oNFS:bLine := { || { aNFS[oNFS:nAt,1], aNFS[oNFS:nAt,2], aNFS[oNFS:nAt,3], aNFS[oNFS:nAt,4],aNFS[oNFS:nAt,5] } }
		ENDIF
		
		//CAIXAS ------------------------------------------------------------------------------------------------------------------
		@ 118,002 SAY "ARMAZENAMENTO"	SIZE 100,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 125,002 LISTBOX oARM Fields HEADER "Separação","Caixa","Local" SIZE 600,050 OF oDlg PIXEL
	    IF LEN(aARM) > 0 
			oARM:SetArray( aARM )
			oARM:bLine := { || { aARM[oARM:nAt,1], aARM[oARM:nAt,2], aARM[oARM:nAt,3] } }
		ENDIF
		
		//SEPARACAO ----------------------------------------------------------------------------------------------------------------
		@ 178,002 SAY "EXPEDIÇÃO"	SIZE 100,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 185,002 LISTBOX oSEP Fields HEADER "Produto","Descrição","Quant.","Caixa","Local","Separação" SIZE 600,080 OF oDlg PIXEL
	    IF aSEP[1,1] = NIL 
			oSEP:SetArray( aSEP )
			oSEP:bLine := { || { aSEP[oSEP:nAt,1], aSEP[oSEP:nAt,2], aSEP[oSEP:nAt,3], aSEP[oSEP:nAt,4],aSEP[oSEP:nAt,5],aSEP[oSEP:nAt,6] } }
		ENDIF
				
		//BOTOES ------------------------------------------------------------------------------------------------------------------
		@ 270,005 BUTTON oBtnOK PROMPT "&Ok"          	SIZE 037,012 OF oDlg ACTION VALOK() 	PIXEL
		@ 270,050 BUTTON oBtnFechar PROMPT "&Fechar"  	SIZE 037,012 OF oDlg ACTION VALFE() 	PIXEL
	    
	ACTIVATE MSDIALOG oDlg CENTERED
	
RETURN

*********************************************************************************************************************************************************************
STATIC FUNCTION VALSEP()	//VALIDACAO DO CAMPO SEPARACAO
                               
LOCAL lERRO		:= .F.	//ERRO
LOCAL nDIF		:= 0	//DIFERENCA DE QUANTIDADE DA SEPARACAO X NOTA SAIDA
LOCAL lRET		:= .T.	//RETORNO DA FUNCAO
LOCAL lVAL		:= .T.	//VALIDACAO
LOCAL cSEPUPD	:= ""	//CODIGO DA SEPARACAO NO UPDATE	

IF aSEP[1,1] = NIL 
	aSEP := {}
ELSE
	//VALIDACAO PARA VER SE JA PASSOU A CAIXA -----------------------------
	FOR X:= 1 TO LEN(aSEP)	             			//TODA SEPARACAO
		IF ALLTRIM(aSEP[X,6]) == ALLTRIM(cSEPARA) 	//SE JA PASSOU CAIXA
			lVAL := .F.                           	//RETORNA FALSO
		ENDIF                                     	//FIM
	NEXT X                                    		//FIM -----------------	                                                                      
ENDIF

IF lVAL
	AUTOGRLOG("PRODUTOS FALTANTES NA SEPARAÇÃO:")
	
	//QUERY PARA VALIDAR SEPARACAO ------------------------------------------------------------------------------
	cQRY2:=" SELECT ZBC_CODPRO, B1_DESC, RIGHT('000'+RTRIM( LTRIM( ZBC_CAIXA ) ),3) ZBC_CAIXA, ZBC_LOCAL, SUM(ZBC_QUANT) ZBC_QUANT "	+CRLF
	cQRY2+=" FROM "+RETSQLNAME("ZBC")+" AS ZBC (NOLOCK) "                                                 	+CRLF
	cQRY2+=" LEFT JOIN "+RETSQLNAME("SB1")+" AS B1 (NOLOCK) ON ZBC_CODPRO = B1_COD "						+CRLF
	cQRY2+=" WHERE ZBC.D_E_L_E_T_ = '' "                                                                  	+CRLF
	cQRY2+=" 	AND ZBC_FILIAL = '"+xFILIAL("ZBC")+"' "                                                   	+CRLF
	cQRY2+=" 	AND B1_FILIAL = '"+xFILIAL("SB1")+"' "                                                   	+CRLF
	cQRY2+="	AND ZBC_NOTA = '"+ALLTRIM(cNOTA)+"' "                                                 	+CRLF
	cQRY2+=" 	AND ZBC_SERIE = '"+ALLTRIM(cSERIE)+"' "                                                	+CRLF
	cQRY2+=" 	AND ZBC_CODSEP + RIGHT('000'+RTRIM( LTRIM( ZBC_CAIXA ) ),3) = '"+ALLTRIM(cSEPARA)+"' "   	+CRLF
	cQRY2+=" GROUP BY ZBC_CODPRO, B1_DESC, ZBC_CAIXA, ZBC_LOCAL "                                          	+CRLF
	IF SELECT("SEP") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("SEP")    										//SELECIONA ALIAS
		SEP->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM
	DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY2),"SEP",.T.,.T.)
	SEP->(DBGOTOP())
		
	IF !EMPTY(SEP->ZBC_CODPRO)										//
		WHILE SEP->(!EOF())                                       	//
			AADD( aSEP,{ALLTRIM(SEP->ZBC_CODPRO)			,;		//PRODUTO
						ALLTRIM(SEP->B1_DESC)				,; 		//DESCRICAO
						ALLTRIM(cVALTOCHAR(SEP->ZBC_QUANT))	,; 		//QUANTIDADE
						ALLTRIM(SEP->ZBC_CAIXA)				,;  	//CAIXA
						ALLTRIM(cVALTOCHAR(SEP->ZBC_LOCAL))	,; 		//LOCAL
						ALLTRIM(cSEPARA)					} ) 	//COD CAIXA		
			SEP->(DBSKIP())
		ENDDO
		//IF LEN(aSEP) > 0 
			oSEP:SetArray( aSEP )
			oSEP:bLine := { || { aSEP[oSEP:nAt,1], aSEP[oSEP:nAt,2], aSEP[oSEP:nAt,3], aSEP[oSEP:nAt,4],aSEP[oSEP:nAt,5],aSEP[oSEP:nAt,6] } }
			oSEP:Refresh()
		//ENDIF
	ELSE
		lERRO := .T.
		IF LEN(aSEP) == 0
			aSEP := ARRAY(1,6)
			oSEP:SetArray( aSEP )
			oSEP:bLine := { || { aSEP[oSEP:nAt,1], aSEP[oSEP:nAt,2], aSEP[oSEP:nAt,3], aSEP[oSEP:nAt,4],aSEP[oSEP:nAt,5],aSEP[oSEP:nAt,6] } }
			oSEP:Refresh()
		ENDIF
		IF !EMPTY(ALLTRIM(cSEPARA))	
			AUTOGRLOG( "SEPARAÇÃO: "+ALLTRIM(cSEPARA) +"; "+ /*GETADVFVAL("SB1","B1_DESC",xFILIAL("SB1")+ALLTRIM(aNFS[X,3]),1) +";"+*/ "NÃO ENCONTRADA!" )
		ENDIF
	ENDIF
	
	IF SELECT("SEP") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("SEP")    										//SELECIONA ALIAS
		SEP->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM 
		
	IF lERRO
		IF !EMPTY(ALLTRIM(cSEPARA))	
			MOSTRAERRO()
			cSEPARA	:= SPACE(60)
			oSEPARA:SETFOCUS()
		ENDIF
	ELSE
	      
	    do case
	       case nCOUNT == nCAIXA
			MSGALERT("TODAS AS CAIXAS JÁ FORAM ADICIONADAS!","CONSFNFS.PRW LINE:281")
		   //case nCOUNT > nCAIXA                                                                      
		   //  Alert("Qt Contagem superior a caixas! Erro!")
		   //lRET := .F.
		       
		   otherwise
			nCOUNT++
			oCOUNT:DISABLE()
			oCOUNT:Refresh()
			cSEPUPD := cSEPARA
			cSEPARA	:= SPACE(60)
			oSEPARA:Refresh()
			lRET := .F.
			MSGALERT("INCLUÍDA CAIXA "+cVALTOCHAR(nCOUNT)+"!","CONFNFS.PRW LINE:290")
		ENDCASE                                                                         
		
		//GRAVANDO STATUS EXPEDIDO PARA ZBC(SEPARACAO X CAIXA)
		//DELETANDO SEPARACAO CANCELADA NO BOTAO FECHAR -----------------
		cUPD:=" UPDATE "+RETSQLNAME("ZBC")+" SET ZBC_STATUS = '2' "	+CRLF	//2=EXPEDIDO
		cUPD+=" FROM "+RETSQLNAME("ZBC")+" "                      	+CRLF
		cUPD+=" WHERE "+RETSQLNAME("ZBC")+".D_E_L_E_T_ = '' " 		+CRLF      	
		cUPD+=" 	AND ZBC_FILIAL = '"+xFILIAL("ZBC")+"' "     	+CRLF
		cUPD+="		AND ZBC_CODSEP + RIGHT('000'+RTRIM( LTRIM( ZBC_CAIXA ) ),3) = '"+ALLTRIM(cSEPUPD)+"' "	+CRLF
		TCSQLEXEC(cUPD)	
		
	ENDIF
ELSE
	cSEPARA	:= SPACE(60)
	oSEPARA:Refresh()
	lRET := .F.
	MSGALERT("CAIXA JÁ INCLUÍDA NA SEPARAÇÃO!","CONFNFS.PRW LINE:290")
ENDIF	

INICAMPO()
	
RETURN lRET     

*********************************************************************************************************************************************************************
STATIC FUNCTION VALOK()	//VALIDACAO DO BOTAO OK

LOCAL nNFS	:= 0
LOCAL nSEP  := 0
LOCAL lRET	:= .T.
LOCAL lVAL	:= .T.
//aNFS//"Pedido","Separação","Produto","Descricao","Quant"
//aSEP//"Produto","Descrição","Quant.","Caixa","Local"

IF nCOUNT == nCAIXA 
    
    //COMPARANDO QUANTIDADE DOS ITENS DA NOTA FISCAL X SEPARACAO ------------------------------------------- 
    FOR X:=1 TO LEN(aNFS)									//TODOS OS ITENS DA NOTA
    	nNFS := VAL(aNFS[X,5])                             	//QUANTIDADE ITEM NOTA
    	FOR Y:=1 TO LEN(aSEP) 								//TODOS ITENS SEPARACAO
    		IF ALLTRIM(aNFS[X,3]) == ALLTRIM(aSEP[Y,1])  	//SE FOR O MESMO PRODUTO
    			nSEP += VAL(aSEP[Y,3]) 		                //SOMA ATRIBUINDO QUANTIDADE DA SEPARACAO
    		ENDIF                                         	//FIM
    	NEXT Y                                           	//FIM   	
    	IF nNFS <> nSEP                               		//SE NAO BATER
    		lVAL := .F.                              		//RETORNA FALSO
    	ENDIF                                          		//FIM
    	nNFS := 0 											//ZERANDO VARIAVEIS
    	nSEP := 0                                         	//ZERANDO VARIAVEIS
    NEXT X                                                 	//FIM ------------------------------------------
    
    IF lVAL
		MSGALERT("PROCESSO FINALIZADO COM SUCESSO!","CONFNFS.PRW LINE:342") 
		//CLOSE(oDlg)
		oDlg:End()
	ELSE
		MSGALERT("AINDA FALTAM ITENS!","CONFNFS.PRW LINE:346")
	ENDIF

ELSE 
	cSEPARA	:= SPACE(60)
	//oSEPARA:Refresh()
	//oSEPARA:Enable()
	oSEPARA:SETFOCUS()
	lRET := .T.
	MSGALERT("AINDA FALTA(M) "+cVALTOCHAR(nCAIXA-nCOUNT)+" CAIXA(S)!","CONFNFS.PRW LINE:355")	
ENDIF

RETURN lRET

*********************************************************************************************************************************************************************
STATIC FUNCTION VALFE()		//VALIDACAO PARA FECHAR
              
//VOLTA STATUS PARA SEPARADO ---------------------------------------------------
cUPD:=" UPDATE "+RETSQLNAME("ZBC")+" SET ZBC_STATUS = '1' "	+CRLF	//1=SEPARADO
cUPD+=" FROM "+RETSQLNAME("ZBC")+" "                      	+CRLF
cUPD+=" WHERE "+RETSQLNAME("ZBC")+".D_E_L_E_T_ = '' " 		+CRLF      	
cUPD+=" 	AND ZBC_FILIAL = '"+xFILIAL("ZBC")+"' "     	+CRLF
cUPD+="		AND ZBC_NOTA = '"+ALLTRIM(cNOTA)+"' "		+CRLF
cUPD+="		AND ZBC_SERIE = '"+ALLTRIM(cSERIE)+"' "		+CRLF
TCSQLEXEC(cUPD)

oDlg:End()

RETURN
*********************************************************************************************************************************************************************
STATIC FUNCTION INICAMPO()		//INICIALIZA O TAMANHO DOS CAMPOS

	//aTAMCAMPO 	:= TAMSX3("D2_DOC")
	//cNOTA  		:= SPACE( aTAMCAMPO[1] )

	//aTAMCAMPO 	:= TAMSX3("D2_SERIE")
	//cSERIE 		:= SPACE( aTAMCAMPO[1] )
		
	aTAMCAMPO 	:= TAMSX3("ZBC_LOCAL")
	cLOCAL 		:= SPACE( aTAMCAMPO[1] )
	
	cSEPARA		:= ""
	cSEPARA		:= SPACE(60)

RETURN

*********************************************************************************************************************************************************************
STATIC FUNCTION CRIASX1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Separacao                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

PutSx1(cPerg,"01","Chave NFE?"	,"Chave NFE?"	,"Chave NFE?"	,"mv_ch1","C",44,0,0,"G","",""		,"","","MV_PAR01","","","","","","","","","","","","","","","","",,,)

RETURN