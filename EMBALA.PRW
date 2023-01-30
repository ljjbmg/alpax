#INCLUDE "PROTHEUS.CH" 

USER FUNCTION EMBALA()	//U_EMBALA()

/*
AUTOR	: ANDERSON BIALE
DATA	: 25/07/12
DESC	: TELA PARA VALIDACAO NA SEPARACAO DO PEDIDO DE VENDAS.
*/
    
	PRIVATE oFontCab   := TFont():New("MS Sans Serif",,018,, .T. ,,,,, .F. , .F. )
	PRIVATE oFontItens := TFont():New("MS Sans Serif",,016,, .T. ,,,,, .F. , .F. )
	PRIVATE oDlg
	PRIVATE oPanel1
	PRIVATE oLblProd
	PRIVATE oCAIXAS
	PRIVATE nCAIXA		:= 0	
	PRIVATE cCodProd   := ""
	PRIVATE oLblDescProd
	PRIVATE cDescProd  := ""
	PRIVATE oLblLote
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
	PRIVATE oLstProd
	PRIVATE aLstProd   := {}	//Array( 1, 12 )
	PRIVATE aTamCamp   := {}
	PRIVATE lRetProd   := .F.
	PRIVATE lRetLote   := .F.
	PRIVATE lRETSERIAL := .F.
	PRIVATE lAltProds  := .F.
	PRIVATE cARMTRA	   := ""		//ARMAZEM DE TRANSFERENCIA
	PRIVATE cENDTRA	   := ""		//ENDERECO DE TRANSFERENCIA		
	PRIVATE cPERG	   := "EMBALA"	//PARAMETROS
	
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
	
	cCODBAR := ALLTRIM(MV_PAR01)	//CODIGO DE BARRAS

	//QUERY PARA SEPARACAO ------------------------------------------------------------------------------------------------------------------------------------------------------
	//QUERY PARA SEPARACAO ------------------------------------------------------------------------------------------------------------------------------------------------------
	cQRY:= " SELECT C9_PRODUTO, B1_DESC, B1_UM, C9_QTDLIB, C9_LOCAL, C9_ENDPAD, C9_LOTECTL, C9_DTVALID, B1_LOCALIZ, C6_ENTREG  "											+CRLF
	cQRY+= " 	, ISNULL(X5_DESCRI,'SIMPLES') AS DESCRICAO , C9_CLIENTE, C9_LOJA, C9_PEDIDO, C9_ITEM,  B1_MARCA, B1_CAPACID, B1_PNUMBER, B1_UM, B1_AXRISCO, C9_CXNUM, C9_CXEND, C9.R_E_C_N_O_ "	+CRLF                     	+CRLF
	cQRY+= " FROM "+RETSQLNAME("SC9")+" C9 (NOLOCK) "                                                                                                  	+CRLF
	cQRY+= " 	INNER JOIN "+RETSQLNAME("SC6")+" C6 (NOLOCK)  "                                                                                        	+CRLF
	cQRY+= " 		ON C6_FILIAL = '"+xFILIAL("SC6")+"' AND C6_NUM = C9_PEDIDO AND C6_ITEM = C9_ITEM "                                                	+CRLF
	cQRY+= " 	INNER JOIN "+RETSQLNAME("SB1")+" B1 (NOLOCK) "                                                                                        	+CRLF
	cQRY+= " 		ON B1_FILIAL = '"+xFILIAL("SB1")+"' AND B1_COD = C9_PRODUTO "                                                                     	+CRLF
	cQRY+= " 	INNER JOIN "+RETSQLNAME("SF4")+" F4 (NOLOCK) "                                                                                         	+CRLF
	cQRY+= " 		ON F4_FILIAL = '"+xFILIAL("SF4")+"' AND F4_CODIGO = C6_TES "                          	                                        	+CRLF
	cQRY+= " 	LEFT JOIN "+RETSQLNAME("SX5")+" X5 (NOLOCK) "																							+CRLF	 
	cQRY+= " 		ON X5_TABELA  = 'Z1' AND X5.D_E_L_E_T_ <> '*' AND B1_AXRISCO = X5_CHAVE "                                                         	+CRLF
	cQRY+= " 	WHERE  C9_FILIAL = '"+xFILIAL("SC9")+"' "            																					+CRLF
	cQRY+= " 		   AND C9_SERIENF = ' ' AND C9_NFISCAL = ' ' AND C9_BLEST = ' ' AND C9_BLCRED = ' ' "												+CRLF
	cQRY+= " 	       AND C9_CODBAR = '"+ALLTRIM(MV_PAR01)+"' AND F4_ESTOQUE = 'S' " 																	+CRLF
	//cQRY+= " 	       AND C9_PEDIDO BETWEEN '"+ALLTRIM(MV_PAR01)+"' AND '"+ALLTRIM(MV_PAR02)+"' AND C9_XSEPARA = '' AND F4_ESTOQUE = 'S' "           	+CRLF
	cQRY+= " 	       AND C9.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' "						       	+CRLF
	cQRY+= " 	ORDER BY B1_MARCA, B1_PNUMBER "
	IF SELECT("SEP") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("SEP")    										//SELECIONA ALIAS
		SEP->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM
	DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"SEP",.T.,.T.)		//ABRINDO ALIAS    
	
	SEP->(DBGOTOP())
	nCAIXA	:= SEP->C9_CXNUM	//CAIXAS  
	cLOCAL	:= SEP->C9_CXEND  	//LOCAL
	WHILE SEP->(!EOF())                              				//LENDO TODA QUERY DE SEPARACAO
		IF ALLTRIM(SEP->B1_LOCALIZ) == "S" 							//SE CONTROLA ENDERECAMENTO
	   		//QUERY PARA PRODUTOS QUE POSSUEM NUM DE SERIE
			cQRY2:=" SELECT DC_PRODUTO, DC_QUANT, DC_LOCAL, DC_PEDIDO, DC_LOTECTL, DC_NUMSERI "	+CRLF  
			cQRY2+=" FROM "+RETSQLNAME("SDC")+" "                                 	+CRLF
			cQRY2+=" WHERE "+RETSQLNAME("SDC")+".D_E_L_E_T_ = '' "            		+CRLF
			cQRY2+=" 	AND DC_FILIAL = '"+xFILIAL("SDC")+"' "                     	+CRLF
			cQRY2+=" 	AND DC_PEDIDO = '"+ALLTRIM(SEP->C9_PEDIDO)+"' " 			+CRLF
			cQRY2+=" 	AND DC_PRODUTO = '"+ALLTRIM(SEP->C9_PRODUTO)+"' "    		+CRLF
			cQRY2+=" 	AND DC_LOCAL = '"+ALLTRIM(SEP->C9_LOCAL)+"' "     			+CRLF
			cQRY2+=" 	AND DC_LOTECTL = '"+ALLTRIM(SEP->C9_LOTECTL)+"' "    		+CRLF
			IF SELECT("SER") > 0											//SE ALIAS ESTIVER ABERTO
				DBSELECTAREA("SER")    										//SELECIONA ALIAS
				SER->(DBCLOSEAREA()) 										//FECHA ALIAS
			ENDIF                        									//FIM
			DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY2),"SER",.T.,.T.)
			SER->(DBGOTOP())
			
			IF !EMPTY(SER->DC_PRODUTO)									//SE RETORNOU PRODUTO
				WHILE SER->(!EOF())
					AADD( aLstProd,{ALLTRIM(SEP->C9_PRODUTO)	,;         	//PRODUTO
								ALLTRIM(SEP->B1_PNUMBER)	,;           	//PNUMBER
								ALLTRIM(SEP->B1_DESC)		,;          	//DESCRICAO
								ALLTRIM(SEP->B1_MARCA)		,;         		//MARCA
								ALLTRIM(SEP->B1_CAPACID)	,;        		//CAPACIDADE
								ALLTRIM(SEP->B1_UM)			,;        		//UNIDADE DE MEDIDA
								cVALTOCHAR(SER->DC_QUANT)	,;       		//QUANRIDADE
								ALLTRIM(SEP->C9_LOCAL)		,;          	//LOCAL
								ALLTRIM(SEP->C9_PEDIDO)		,;            	//PEDIDO
								ALLTRIM(SEP->C9_LOTECTL)	,;            	//LOTE
								DTOC(STOD(SEP->C9_DTVALID))	,;           	//VALIDADE LOTE
								ALLTRIM(SER->DC_NUMSERI)	} )         	//NUM DE SERIE	
					SER->(DBSKIP())
				ENDDO
			ENDIF
			IF SELECT("SER") > 0											//SE ALIAS ESTIVER ABERTO
				DBSELECTAREA("SER")    										//SELECIONA ALIAS
				SER->(DBCLOSEAREA()) 										//FECHA ALIAS
			ENDIF                        									//FIM
					
		ELSE                                                                     
		
			
			AADD( aLstProd,{ALLTRIM(SEP->C9_PRODUTO)	,;         		//PRODUTO
							ALLTRIM(SEP->B1_PNUMBER)	,;           	//PNUMBER
							ALLTRIM(SEP->B1_DESC)		,;          	//DESCRICAO
							ALLTRIM(SEP->B1_MARCA)		,;         		//MARCA
							ALLTRIM(SEP->B1_CAPACID)	,;        		//CAPACIDADE
							ALLTRIM(SEP->B1_UM)			,;        		//UNIDADE DE MEDIDA
							cVALTOCHAR(SEP->C9_QTDLIB)	,;       		//QUANRIDADE
							ALLTRIM(SEP->C9_LOCAL)		,;          	//LOCAL
							ALLTRIM(SEP->C9_PEDIDO)		,;            	//PEDIDO
							ALLTRIM(SEP->C9_LOTECTL)	,;            	//LOTE
							DTOC(STOD(SEP->C9_DTVALID))	,;           	//VALIDADE LOTE
							""							} )         	//NUM DE SERIE
		ENDIF				
		AADD(aRECNO,ALLTRIM(cVALTOCHAR(SEP->R_E_C_N_O_)))	//GRAVANDO RECNOS 
       	
       	SEP->(DBSKIP())
    ENDDO
    
    IF SELECT("SEP") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("SEP")    										//SELECIONA ALIAS
		SEP->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM
    
  	//DEFININDO TELA ----------------------------------------------------------------------------------------------------------------------------------------------------------------
	DEFINE MSDIALOG oDlg TITLE "Separa豫o de Pedido" FROM 000,000 TO 600,1200 COLORS 0,16777215 PIXEL
		@ 003,003 SAY "Separa豫o: "+ALLTRIM(MV_PAR01) 	SIZE 115,010 OF oDlg FONT oFontCab COLORS CLR_BLACK PIXEL
		@ 022,002 SAY "Caixas"                 			SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 021,040 MSGET oCAIXAS VAR nCAIXA 				SIZE 085,010 OF oDlg VALID VALCAIXA() COLORS CLR_BLACK PIXEL
		@ 022,148 SAY "Local"	                      	SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 021,190 MSGET oLOCAL VAR cLOCAL               SIZE 085,010 OF oDlg VALID VALLOCAL() COLORS CLR_BLACK PIXEL
		@ 270,005 BUTTON oBtnOK PROMPT "&Ok"          	SIZE 037,012 OF oDlg ACTION (GravaItens(),oDlg:End()) PIXEL
		@ 270,050 BUTTON oBtnLimpar PROMPT "&Limpar"  	SIZE 037,012 OF oDlg ACTION LimpCampo() PIXEL
		@ 270,095 BUTTON oBtnFechar PROMPT "&Fechar"  	SIZE 037,012 OF oDlg ACTION oDlg:End() PIXEL
		@ 042,002 SAY "Itens da Separa豫o:" SIZE 124,007 OF oDlg FONT oFontCab COLORS CLR_BLACK PIXEL
		@ 052,002 LISTBOX oLstProd Fields HEADER "Produto","PNumber","Descricao","Marca","Capacid","UM","QT","AR","Pedido","Lote","Valid","Serie" SIZE 600,200 OF oDlg PIXEL
		
		oLstProd:SetArray( aLstProd )
		oLstProd:bLine := { || { aLstProd[oLstProd:nAt,1], aLstProd[oLstProd:nAt,2], aLstProd[oLstProd:nAt,3], aLstProd[oLstProd:nAt,4], aLstProd[oLstProd:nAt,5], aLstProd[oLstProd:nAt,6], aLstProd[oLstProd:nAt,7], aLstProd[oLstProd:nAt,8], aLstProd[oLstProd:nAt,9], aLstProd[oLstProd:nAt,10], aLstProd[oLstProd:nAt,11], aLstProd[oLstProd:nAt,12] } }
	
	IF LEN(aLstProd) > 1 
		ACTIVATE MSDIALOG oDlg CENTERED
	ELSE
		MSGALERT("N� DE SEPARA플O N홒 ENCONTRADO OU J� GERADO NOTA FISCAL!","EMBALA.PRW LINE:175")
	ENDIF
	
RETURN
      
*********************************************************************************************************************************************************************

STATIC FUNCTION GRAVAITENS()	//GRACVA NUMERO DE CAIXAS E LOCAL A SEREM ARMAZENADOS

	FOR X:=1 TO LEN(aRECNO)		//LENDO TODOS OS RECNOS DA QUERY
		//GRAVACAO DOS CAMPOS CAIXA E LOCAL A SER ARMAZENADO
		cUPD := " UPDATE	"+RETSQLNAME("SC9")+" SET C9_CXNUM = "+cVALTOCHAR(nCAIXA)+" , C9_CXEND = '"+ALLTRIM(cLOCAL)+"'   	"+CRLF	//CAIXA E LOCAL
		cUPD += " WHERE		"+RETSQLNAME("SC9")+".R_E_C_N_O_ = "+ALLTRIM(aRECNO[X])+"											"+CRLF 	//REGISTRO IGUAL AO RECNO
		TCSQLEXEC(cUPD)                                                                                   		
	NEXT

MSGINFO("FIM DA GRAVA플O")

RETURN


*********************************************************************************************************************************************************************

STATIC FUNCTION INICAMPO()		//INICIALIZA O TAMANHO DOS CAMPOS

	aTAMCAMPO 	:= TAMSX3("C9_CXNUM")
	nCAIXA  	:= SPACE( aTAMCAMPO[1] )

	aTAMCAMPO 	:= TAMSX3("C9_CXEND")
	cLOCAL 		:= SPACE( aTAMCAMPO[1] )

RETURN


*********************************************************************************************************************************************************************

STATIC FUNCTION FechaTela()		//FECHAR

	IF Len( aLstProd ) > 0
		If aLstProd[1, 1] <> NIL
			If MsgYesNo( "Deseja salvar os itens?" )
				GravaItens()
			EndIf
		EndIf
	EndIf
	Close( oDlg )

RETURN

*********************************************************************************************************************************************************************

STATIC FUNCTION LimpCampo()		//LIMPA OS CAMPOS

	IniCampo()

	oCAIXAS:Enable()
	oCAIXAS:Refresh()
	oCAIXAS:SetFocus()
	oLOCAL:Enable()
	oLOCAL:Refresh()
	
RETURN

*********************************************************************************************************************************************************************

STATIC FUNCTION VALCAIXA()	//VALIDACAO CAIXA

LOCAL _lRET := .F. 			//RETORNO DA FUNCAO		
		
IF EMPTY(nCAIXA)			//SE CAIXA VAZIO
	_lRET := .F.
	MSGALERT("PREENCHA O NUMERO DE CAIXAS A SER USADO!","EMBALA.PRW LINE:246")	
ELSE					    
	_lRET    	:= .T.     	//RETORNO STATIC
	oCAIXAS:Refresh()   	//ATUALIZA OBJETO PRODUTO
	oCAIXAS:Disable()   	//DESABILITA OBJETO PRODUTO
ENDIF
			
RETURN( _lRET )

*********************************************************************************************************************************************************************

STATIC FUNCTION VALLOCAL()

LOCAL 	_lRET 	:= .F.	//RETORNO FUNCAO
	
IF EMPTY(cLOCAL)
	_lRET := .F.                               						//RETORNA .F.
	MSGALERT("PREENCHA O LOCAL A SEREM ARMAZENADAS AS CAIXAS!","EMBALA.PRW LINE263")	  	//ALERTA
ELSE					                           					//SE NAO
	_lRET    := .T.            										//RETORNO FUNCAO .T.
	oLOCAL:Refresh()												//ATUALIZA CAMPO LOTE
	oLOCAL:Disable()            									//DESABILITA CAMPO LOTE
ENDIF

RETURN( _lRET )

*********************************************************************************************************************************************************************

STATIC FUNCTION CRIASX1()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿘V_PAR01 = Separacao                      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

PutSx1(cPerg,"01","Separa豫o?"			,"Separa豫o?"			,"Separa豫o?"		,"mv_ch1","C",12,0,0,"G","",""		,"","","MV_PAR01","","","","","","","","","","","","","","","","",,,)

RETURN