#Include "PROTHEUS.CH"
#Include "RWMAKE.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma ³ALPA100 º Autor ADVPL Biale Treinamento e Consultoria LTDA   º±±
±±ºData ³  08/12/11                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Utilizado para transferencia do armazem padrão de entrada  º±±
±±º            para outro armazem                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Alpax                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

USER FUNCTION ALPA100() //U_ALPA100()

Private oFontCab   := TFont():New("MS Sans Serif",,018,, .T. ,,,,, .F. , .F. )
Private oFontItens := TFont():New("MS Sans Serif",,016,, .T. ,,,,, .F. , .F. )
Private oDlg
Private oPanel1
Private oLblProd
Private oCodProd
Private cCodProd   := ""

Private oLblDescProd
Private cDescProd  := ""

Private oLblLote
Private oLote
Private cLote      := ""
Private oLblSerie
Private oSerie
Private cSERIAL     := ""
Private cCTRSER		:= ""		//CONTROLE OU NAO DE SERIE DO PRODUTO
Private oBtnFechar
Private oBtnLimpar
Private oBtnOK
Private oLblLerProdSer
Private oPanel2
Private oGravProdLoteSerie
Private oLstProd
Private aLstProd   := Array( 1, 6 )
Private aTamCamp   := {}
Private lRetProd   := .F.
Private lRetLote   := .F.
Private lRETSERIAL := .F.
Private lAltProds  := .F.
PRIVATE nQUANT	   := 0			//QUANTIDADE DO SALDO POR LOTE A SER TRANSFERIDA
PRIVATE cNUMSERIE  := ""		//NUMERO DE SERIE
PRIVATE cARMTRA	   := ""		//ARMAZEM DE TRANSFERENCIA
PRIVATE cENDTRA	   := ""		//ENDERECO DE TRANSFERENCIA

PRIVATE cLOCORI    := SPACE(2)	//LOCAL DE TRANSFERENCIA 
PRIVATE oLOCORI

PRIVATE cLOCTRA    := SPACE(2)	//LOCAL DE TRANSFERENCIA 
PRIVATE oLOCTRA

PRIVATE cENDORI    := "LOCAL          " //SPACE(15)	//ENDERECO DE ORIGEN 
PRIVATE oENDORI

PRIVATE cENDTRA    := "LOCAL          " //SPACE(15)	//ENDERECO DE TRANSFERENCIA 
PRIVATE oENDTRA

PRIVATE cNOTA		:= ""		//NOTA
PRIVATE cSERIE 		:= ""    	//SERIE
PRIVATE cFORNECE	:= ""    	//FORNECEDOR
PRIVATE cLOJA		:= ""		//LOJA 
Private nPerImp		:= 0//TamSx3("D3_PERIMP")[1]				

IniCampo()  

	DEFINE MSDIALOG oDlg TITLE "Transferencia entre Armazens" FROM 000,000 TO 330,600 COLORS 0,16777215 PIXEL
		@ 003,003 SAY "Leitura de Produto/Lote/Serial" SIZE 115,010 OF oDlg FONT oFontCab COLORS CLR_BLACK PIXEL
		
		@ 022,002 SAY "Loc.Ori." 	                   	SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 021,040 MSGET oLOCORI VAR cLOCORI		 		SIZE 010,010 OF oDlg F3 "LT" VALID oLOCORI:DISABLE() COLORS CLR_BLACK PIXEL
		@ 021,070 MSGET oENDORI VAR cENDORI 			SIZE 075,010 OF oDlg F3 "SBE" VALID oENDORI:DISABLE() COLORS CLR_BLACK PIXEL
		
		@ 042,002 SAY "Loc.Tra." 	                   	SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 041,040 MSGET oLOCTRA VAR cLOCTRA		 		SIZE 010,010 OF oDlg F3 "LT" VALID oLOCTRA:DISABLE() COLORS CLR_BLACK PIXEL
		//@ 041,070 MSGET oENDTRA VAR cENDTRA SIZE 065,010 OF oDlg F3 "SBE" VALID oENDTRA:DISABLE() COLORS CLR_BLACK PIXEL
		
		@ 062,002 SAY "Produto"                       SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 061,040 MSGET oCodProd VAR cCodProd		 SIZE 085,010 OF oDlg VALID ValProd() COLORS CLR_BLACK PIXEL
		@ 085,040 SAY oLblDescProd PROMPT cDescProd SIZE 085,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		
		@ 092,002 SAY "Lote"                          SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 091,040 MSGET oLote VAR cLote               SIZE 085,010 OF oDlg VALID ValLote() COLORS CLR_BLACK PIXEL
		
		@ 110,002 SAY "Serial"                        SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 111,040 MSGET oSerie VAR cSERIAL             SIZE 085,010 OF oDlg VALID ValSerie() COLORS CLR_BLACK PIXEL
		
		@ 125,002 SAY "Per. Imp."                        SIZE 025,007 OF oDlg FONT oFontItens COLORS CLR_BLACK PIXEL
		@ 126,040 MSGET oPerimp VAR nPerImp   Picture "E@ 999.99"  when .f.        SIZE 085,010 OF oDlg  COLORS CLR_BLACK PIXEL
		
		@ 140,005 BUTTON oBtnOK PROMPT "&Ok"          SIZE 037,012 OF oDlg ACTION (GravaItens(),oDlg:End()) PIXEL
		@ 140,050 BUTTON oBtnLimpar PROMPT "&Limpar"  SIZE 037,012 OF oDlg ACTION LimpCampo() PIXEL
		@ 140,095 BUTTON oBtnFechar PROMPT "&Fechar"  SIZE 037,012 OF oDlg ACTION oDlg:End() PIXEL//FechaTela() PIXEL
		
		@ 003,148 SAY "Gravação de Produtos/Lote/Serial" SIZE 124,010 OF oDlg FONT oFontCab COLORS CLR_BLACK PIXEL
		@ 012,141 LISTBOX oLstProd Fields HEADER "Produto","Lote","Serial","Qtd","LocTra","EndTra" SIZE 158,129 OF oDlg PIXEL
			oLstProd:SetArray( aLstProd )
			oLstProd:bLine := { || { aLstProd[oLstProd:nAt,1], aLstProd[oLstProd:nAt,2], aLstProd[oLstProd:nAt,3], aLstProd[oLstProd:nAt,4], aLstProd[oLstProd:nAt,5], aLstProd[oLstProd:nAt,6] } }
	ACTIVATE MSDIALOG oDlg CENTERED
                    
RETURN

//--------------------------------------------------------------------------------------------------------------------------------------

STATIC FUNCTION FechaTela()

	IF Len( aLstProd ) > 0
		If aLstProd[1, 1] <> NIL
			If MsgYesNo( "Deseja salvar os itens?" )
				GravaItens()
			EndIf
		EndIf
	EndIf
	Close( oDlg )

Return

//--------------------------------------------------------------------------------------------------------------------------------------

Static Function IniCampo()

	aTamCampo := TamSX3("B1_COD")
	cCodProd  := Space( aTamCampo[1]*5 )

	aTamCampo := TamSx3("B1_DESC")
	cDescProd := Space( aTamCampo[1] )

	aTamCampo := TamSX3("B8_LOTECTL")
	cLote     := Space( aTamCampo[1]*5 )
	
	cSERIAL   := Space( 60 )

Return

//--------------------------------------------------------------------------------------------------------------------------------------

Static Function LimpCampo()

	IniCampo()

	oCodProd:Enable()
	oCodProd:Refresh()

	oLote:Enable()
	oLote:Refresh()

	oSerie:Enable()
	oLote:Refresh()

	oLblDescProd:Refresh()
   	oCodProd:SetFocus()

Return

//--------------------------------------------------------------------------------------------------------------------------------------

Static Function GravaItens()

	Local aAuto       := {}
	LOCAL aCAB		  := {}	
	Local aItens      := {}
	Local nI          := {}
	LOCAL aPARAM	  := {}	
	Local cArmPdr     := "RC"
	Local dDataVl     := CToD("//")
	Local cQuery      := ""
	Local cAlias      := GetNextAlias()
	Local lMsErroAuto := .F.
	Local cDOC		  := ""
	Local cProd       := ""
	Local cLote       := ""
	Local cSERIAL     := ""
	Local nQtd        := 0
	Local cDesc       := ""
	Local cUn         := ""
	LOCAL cEND		  := ""
	Local cSpaces     := ""

	lAltProds := .F.
	IF Len( aLstProd ) > 0
		If aLstProd[1, 1] <> NIL
			For nI := 1 to Len( aLstProd )

				cDOC 	:= GetSXENum("SD3", "D3_DOC")	//NUM DOC
				dDataVl := CToD("//")              		//DT VALID
				cProd  	:= AllTrim( aLstProd[nI, 1] )	//PRODUTO
				cLote  	:= AllTrim( aLstProd[nI, 2] )  	//LOTE
				cSERIAL	:= AllTrim( aLstProd[nI, 3] )  	//SERIAL
				
				
				If ! EmpTy( aLstProd[nI, 2] )
					If Select( cAlias ) > 0
						dbSelectArea( cAlias )
						cAlias->( dbCloseArea() )
					EndIf
					//QUERY PARA SALDOS POR LOTE ------------------------------------
					cQuery := "SELECT B8_DTVALID"								+CRLF
					cQuery += "FROM " + RETSQLNAME("SB8")						+CRLF
					cQuery += "WHERE R_E_C_N_O_ = (SELECT MAX(R_E_C_N_O_)"		+CRLF
					cQuery += "	FROM " + RETSQLNAME("SB8") + " B8"				+CRLF
					cQuery += "	WHERE B8_FILIAL = '"+xFILIAL("SB8")+"'"			+CRLF
					cQuery += "		AND B8_PRODUTO = '"+ALLTRIM(cPROD)+"'"		+CRLF
					cQuery += "		AND B8_LOCAL = '"+ALLTRIM(cLOCORI)+"'"		+CRLF
					cQuery += "		AND B8_LOTECTL = '"+ALLTRIM(cLote)+"'"		+CRLF
					cQuery += "		AND B8.D_E_L_E_T_ <> '*')"					+CRLF
					DBUSEAREA( .T. , "TOPCONN", TCGENQRY( ,,cQuery ) , cAlias, .F. , .F. )
					While &( cAlias )->( ! EOF() )
						dDataVl := SToD( ( cAlias )->B8_DTVALID )
						&( cAlias )->( DBSKIP() )
					EndDo
					&( cAlias )->( dbCloseArea() )
				EndIf

				nQtd   	:= aLstProd[nI, 4 ]                                                   	//QUANTIDADE
				cDesc  	:= Posicione("SB1", 1, xFilial("SB1") + aLstProd[nI, 1], "B1_DESC")   	//DESCRICAO
				cUn    	:= Posicione("SB1", 1, xFilial("SB1") + aLstProd[nI, 1], "B1_UM")     	//UNIDADE MEDIDA
			   	//cEND   	:= "LOCAL"	                                                   	//ENDERECO
                //cARMTRA	:= AllTrim( aLstProd[nI, 5] )                                      		//LOCAL TRANSF
                //cENDTRA	:= AllTrim( aLstProd[nI, 6] )                                        	//ENDERECO TRANSF
                
                //CHAMANDO FUNCAO PARA TRANSFERENCIA DE ESTOQUE --------------------------------------------------------
	   			aPARAM	:= {}         	 			//LIMPANDO aPARAM                                                  
	            AADD(aParam,aLstProd[nI,1]		) 	//01 Codigo do Produto Origem - Obrigatorio
				AADD(aParam,cLOCORI				)	//02 Almox Origem             - Obrigatorio
				AADD(aParam,aLstProd[nI,4]		) 	//03 Quantidade 1a UM         - Obrigatorio  
				AADD(aParam,cDOC				) 	//04 Documento                - Obrigatorio
				AADD(aParam,aLstProd[nI,2]		) 	//05 Lote                     - Obrigatorio se usa Rastro
				AADD(aParam,dDataVl	   			) 	//06 Validade                 - Obrigatorio se usa Rastro
				AADD(aParam,aLstProd[nI,3] 		)  	//07 Numero de Serie
				AADD(aParam,cENDORI	   			)  	//08 localização Origem
				AADD(aParam,aLstProd[nI,1]		)  	//09 Codigo do Produto Destino- Obrigatorio 
				AADD(aParam,cLOCTRA				) 	//10 Almox Destino            - Obrigatorio
				AADD(aParam,cENDTRA				) 	//11 Localização Destino
				AADD(aParam,""					) 	//12 Endereco Destino
				AADD(aParam,""  				) 	//13 Lote Destino da Transferencia
				U_RADVL001(aParam,.T.)				//TRANSFERENCIA DE ESTOQUE -----------------------------------------
  
			Next
		EndIf
	ELSE
		MsgInfo( "Não foi incluido nenhum produto" )
	EndIf
	
	MSGINFO("TRANSFER^NCIA EFETUADA COM SUCESSO!")

	IniCampo()
	aLstProd := Array( 1, 6 )
	oLstProd:SetArray( aLstProd )
	oLstProd:bLine := { || { aLstProd[oLstProd:nAt,1], aLstProd[oLstProd:nAt,2], aLstProd[oLstProd:nAt,3], aLstProd[oLstProd:nAt,4] ,aLstProd[oLstProd:nAt,5], aLstProd[oLstProd:nAt,6] } }

	oCodProd:SetFocus()

Return

//--------------------------------------------------------------------------------------------------------------------------------------

Static Function ValProd()

	Local _lRet := .F.
	LOCAL nQTLIS := 0
	Local X
	lRetProd    := .F.
	NB8SALDO 	:= 0

	If Empty( ALLTRIM( UPPER(cCodProd) ) )
		_lRet := .T.
	Else
		dbSelectArea("SB1")
		dbSetOrder( 1)

		If SB1->( ! dbSeek( xFilial("SB1") + AllTrim( UPPER(cCodProd) ) ) )
			MSGINFO("PRODUTO NAO ENCONTRADO!","ALPA100.PRW")
			_lRet := .F.
			LimpCampo()
		Else
			If AllTrim( UPPER(cCodProd) ) == AllTrim( UPPER(SB1->B1_COD) )
				
				//SE CONTROLA LOTE -----------------
				IF ALLTRIM( SB1->B1_RASTRO ) <> "L" 	//SE NAO CONTROLA LOTE
					oLote:Disable()                  	//DESABILITA CAMPO LOTE
					oLote:Refresh()                   	//ATUALIZA CAMPO
					lRetLote := .T.                  	//LOTE RECEBE .T.
					_lRet    := .T.
					nB8SALDO := 0        
				ENDIF
				
				//SE CONTROLA SERIAL
				IF ALLTRIM( SB1->B1_CTRSER ) <> "S"   	//SE NAO CONTROLA SERIE
					oSerie:Disable()                   	//DESABILITA CAMPO SERIE
					oSerie:Refresh()            		//ATUALIZA	
					lRETSERIAL:= .T.                  	//SERIE RECEBE .T.
					_lRet    := .T.
					nQUANT := 1     
				ENDIF
				
				//cARMTRA 	:= ALLTRIM(UPPER(cLOCTRA))	//ALLTRIM(SB1->B1_LOCPAD)	//LOCAL PADRAO
				cENDTRA 	:= ALLTRIM(SB1->B1_ENDER)  	//ENDERECO PADRAO 
				cDescProd 	:= AllTrim(SB1->B1_DESC)	//DESCRICAO
				cCTRSER		:= AllTrim(SB1->B1_CTRSER)	//CONTROLE DE SERIE
				oLblDescProd:Refresh()

				_lRet    := .T.
				lRetProd := .T.
				//oCodProd:Disable()
				//oCodProd:Refresh()
				
				//VALIDACAO NAO DEIXAR ADD ITENS A MAIS
				IF aLstProd[1,1] <> NIL 	
					DBSELECTAREA("SB2")	//SALDOS EM ESTOQUE
					DBSETORDER(1)		//FILIAL + COD + LOCAL
					IF DBSEEK(xFILIAL("SB2")+ALLTRIM(UPPER(cCodProd))+ALLTRIM(cLOCORI))
						FOR X:=1 TO LEN(aLstProd)	//LENDO TODA A LISTA
							IF ALLTRIM(UPPER(cCodProd)) == ALLTRIM(UPPER(aLstProd[X,1]))	//SE FOR MESMO PRODUTO
								nQTLIS++	//SOMA MAIS 1 	 
							ENDIF
						NEXT						
					ENDIF
					
					IF SB2->B2_QATU <= nQTLIS
						MSGALERT("PRODUTO SEM SALDO PARA TRANSFERÊNCIA!","ALPA100.PRW LINE:327")
						_lRET := .F.
						lRetProd := .F.
						LimpCampo()					
					ELSE
						//lEncont := .T.	
					ENDIF
					
					
				ELSE
					DBSELECTAREA("SB2")	//SALDOS EM ESTOQUE
					DBSETORDER(1)		//FILIAL + COD + LOCAL
					IF DBSEEK(xFILIAL("SB2")+ALLTRIM(UPPER(cCodProd))+ALLTRIM(cLOCORI))
						IF SB2->B2_QATU < 1
							MSGALERT("PRODUTO SEM SALDO PARA TRANSFERÊNCIA!","ALPA100.PRW LINE:341")
							nB8SALDO := 0
							_lRET := .F.
							lRetProd := .F.
							LimpCampo()		
						ELSE
							nB8SALDO := 1
							//lEncont := .T.	
						ENDIF	
					ENDIF
					//lEncont := .T.			
				ENDIF
				
			Else
				MSGALERT("PRODUTO NAO ENCONTRADO","ALPA100.PRW LINE:355")
				_lRet := .F.
				LimpCampo()
			EndIf
		EndIf

		SB1->( dbCloseArea() )

	EndIf                            
	
    
	If lRetProd
		IncProd()
	EndIf
	
RETURN( _lRET )

//--------------------------------------------------------------------------------------------------------------------------------------

//ANDERSON

STATIC FUNCTION VALLOTE()

	LOCAL 	_lRET 	:= .F.
	LOCAL	nQTLIS	:= 0	//QUANTIADE DA LISTA
	LOCAL 	lPERG	:= .F.	//PERGUNTA P/ TRANSFERIR	
	nB8SALDO := 0	//SALDO DA SB8
	lRETLOTE    	:= .F.
	

	IF EMPTY( ALLTRIM( UPPER(cLOTE) ) )		//SE LOTE BRANCO
		_lRet := .T.                     	//RETORNA VERDADEIRO
	ELSE                                	//SE NAO
		aTAMCAMPO := TAMSX3("B1_COD")		//TAMANHO CAMPO B1
		DBSELECTAREA("SB8")					//SALDOS POR LOTE		
		SB8->(DBSETORDER(3))				//FILIAL + PRODUTO + LOCAL + LOTE + DTVALID
		IF SB8->(!DBSEEK(xFILIAL("SB8") + SUBSTRING(ALLTRIM(UPPER(cCodProd))+SPACE(aTAMCAMPO[1]),1,aTAMCAMPO[1]) + ALLTRIM(cLOCORI) + ALLTRIM( UPPER(cLOTE) ) ) )
			_lRET := .T.
			MSGALERT("LOTE NAO ENCONTRADO","ALPA100.PRW LINE:392")
			nQUANT 		:= 0
			LimpCampo()
		ELSE 
			cNOTA		:= SB8->B8_DOC    		//DOC
			cSERIE		:= SB8->B8_SERIE    	//SERIE
			cFORNECE	:= SB8->B8_CLIFOR      	//FORNECEDOR
			cLOJA		:= SB8->B8_LOJA       	//LOJA
			
			IF SB8->B8_SALDO = 0
				_lRET := .T.
				nB8SALDO := 1
				MSGALERT("LOTE JA TRANSFERIDO!","ALPA100.PRW LINE:404")	 
			  	LimpCampo()
			ELSE
				nB8SALDO := SB8->B8_SALDO	
				lRetLote := .T.                              	//OK
				_lRet    := .T.
				oLote:Refresh()
				oLote:Disable()	
			ENDIF
		ENDIF
		SB8->( dbCloseArea() )
	ENDIF
    
    /*
	If cCTRSER == "S" 		//SE CONTROLA SERIAL DO PRODUTO
		//CONTINUA NORMAL	//CONTINUA
	Else                  	//SE NAO CONTROLA
		//VALIDACAO DO ARMAZEM DE TRANSFERENCIA X DE PARA PEDIDO DE COMPRAS-------------------------------------------------------------------------
		cQRY:=" SELECT C7_NUM, C7_ITEM, C7_AXFINAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, D1_LOTECTL "+CRLF
		cQRY+=" FROM "+RETSQLNAME("SC7")+" AS C7 (NOLOCK) "+CRLF
		cQRY+=" LEFT JOIN "+RETSQLNAME("SD1")+" AS D1 (NOLOCK) ON C7_NUM = D1_PEDIDO AND C7_ITEM = D1_ITEM "+CRLF
		cQRY+=" WHERE C7.D_E_L_E_T_ = '' AND D1.D_E_L_E_T_ = '' "+CRLF
		cQRY+=" 	AND D1_DOC = '"+ALLTRIM(cNOTA)+"' "+CRLF
	   	cQRY+=" 	AND D1_SERIE = '"+ALLTRIM(cSERIE)+"' "+CRLF 
		cQRY+=" 	AND D1_FORNECE = '"+ALLTRIM(cFORNECE)+"' "+CRLF
		cQRY+=" 	AND D1_LOJA = '"+ALLTRIM(cLOJA)+"' "+CRLF
		cQRY+=" 	AND D1_COD = '"+ALLTRIM(UPPER(cCodProd))+"' "+CRLF 
		cQRY+=" 	AND D1_LOTECTL = '"+ALLTRIM(UPPER(cLOTE))+"' "+CRLF	
		IF SELECT("PED") > 0												//SE ALIAS ESTIVER ABERTO
			DBSELECTAREA("PED")    											//SELECIONA ALIAS
			PED->(DBCLOSEAREA()) 											//FECHA ALIAS
		ENDIF                        										//FIM
		DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"PED",.T.,.T.)			//ABRINDO ALIAS  
		PED->(DBGOTOP())													//PRIMEIRO REGISTRO 
		IF !EMPTY(ALLTRIM(C7_NUM))                                         	//SE TIVER PEDIDO DE COMPRAS
			
			IF ALLTRIM(PED->C7_AXFINAL) <> ALLTRIM(UPPER(cLOCTRA))
				
				IF ALLTRIM(UPPER(GETMV("AD_USUTRA"))) $ ALLTRIM(UPPER(cUSERNAME)) 	//SE USUARIO AUTORIZADO	
					lPERG := MSGYESNO("ARMAZÉM SUGERIDO PARA TRANSFERÊNCIA NO PEDIDO DE COMPRAS: "+ALLTRIM(UPPER(PED->C7_AXFINAL))+"."+CRLF;
										+"DESEJA FAZER A TRANSFERÊNCIA PARA O ARMAZÉM "+ALLTRIM(UPPER(cLOCTRA))+"?","ALPA100.PRW LINE:360" )
					
					IF !lPERG				//SE NAO TRANSFERE						
						lRetLote := .F.		//FALSO
						_lRet    := .T.   	//FALSO
						LimpCampo()       	//LIMPA CAMPOS
					ENDIF
				ELSE                              									//SE NAO AUTORIZADO
					MSGALERT("ARMAZÉM SUGERIDO PARA TRANSFERÊNCIA NO PEDIDO DE COMPRAS: "+ALLTRIM(UPPER(PED->C7_AXFINAL))+".","ALPA100.PRW PARAMETRO: AD_USUTRA LINE: 372")	
					lRetLote := .F.		//FALSO
					_lRet    := .T.   	//FALSO
					LimpCampo()       	//LIMPA CAMPOS	
				ENDIF		
			ENDIF	                                                            	
		ELSE
			MSGALERT("NOTA FISCAL NÃO POSSUI PEDIDO DE COMPRAS!")
		ENDIF
		IF SELECT("PED") > 0												//SE ALIAS ESTIVER ABERTO
			DBSELECTAREA("PED")    											//SELECIONA ALIAS
			PED->(DBCLOSEAREA()) 											//FECHA ALIAS
		ENDIF                        										//FIM ------------------------------------------------------------------
			
		nQUANT := 1
		oSerie:Disable() 	//DESABILITA SERIE
		oSerie:Refresh() 	//ATUALIZA
		lRETSERIAL := .T.	//VAIDACAO SERIAL OK			
	EndIf                 	//FIM
 	*/   
 
	IF lRetLote
		IncProd()
	ENDIF

RETURN( _lRet )

//--------------------------------------------------------------------------------------------------------------------------------------

STATIC FUNCTION VALSERIE()

	LOCAL _lRet := .F.
	lRETSERIAL  := .F.
	
	IF EMPTY( AllTrim( UPPER(cSERIAL) ) )
		_lRet := .T.
	ELSE
		DBSELECTAREA("SBF")		//SALDOS POR ENDERECO
		DBSETORDER(1) 	 		//FILIAL + LOCAL + LOCALIZ + PRODUTO + NUMSERI + LOTECTL + NUMLOTE
		                                                   
		//QUERY PARA VALIDACAO DA SERIE -----------------------------------------------------------
		cQRY:=" SELECT BF_PRODUTO, BF_LOCAL, BF_LOTECTL, BF_NUMSERI, BF_QUANT " 	+CRLF 
		cQRY+=" FROM "+RETSQLNAME("SBF")+" (NOLOCK) "                 	+CRLF
		cQRY+=" WHERE "+RETSQLNAME("SBF")+".D_E_L_E_T_ = '' "         	+CRLF
		cQRY+=" 	AND BF_FILIAL = '"+xFILIAL("SBF")+"' "            	+CRLF
		cQRY+=" 	AND BF_PRODUTO = '"+ALLTRIM(UPPER(cCODPROD))+"' "	+CRLF
		cQRY+=" 	AND BF_LOCAL = '"+ALLTRIM(cLOCORI)+"'  "           	+CRLF
		cQRY+=" 	AND BF_NUMSERI = '"+ALLTRIM(UPPER(cSERIAL))+"' "  	+CRLF
		IF SELECT("SER") > 0											//SE ALIAS ESTIVER ABERTO
			DBSELECTAREA("SER")    										//SELECIONA ALIAS
			SER->(DBCLOSEAREA()) 										//FECHA ALIAS
		ENDIF                        									//FIM
		DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"SER",.T.,.T.)		//ABRINDO ALIAS    	
		SER->(DBGOTOP())		//PRIMEIRO REGISTRO
					
		IF EMPTY(SER->BF_PRODUTO)										//SE RETORNOU PRODUTO										
			_lRET := .T.                                              	//FALSO
			MSGALERT("LOTE NAO ENCONTRADO","ALPA100.PRW LINE:509")              	//ALERTA
			nQUANT := 0
			LimpCampo()
		ELSE                                                          	//SE NAO
			nQUANT	 	:= SER->BF_QUANT  								//RECEBE QUANTIDADE			
			cNUMSERIE	:= SER->BF_NUMSERI   	                      	//NUMERO DE SERIE
			oSerie:Disable()                                           	//DESABILITA CAMPO SERIAL
			oSerie:Refresh()                                           	//ATUALIZA
			_lRet     := .T.                                           	//RECEBE .T.
			lRETSERIAL:= .T.                                           	//RECEBE .T.
			INCPROD()  													//FUNCAO PARA PREENCHER TELA DE GRAVACAO DOS PRODUTOS
		ENDIF                                                          	//FIM                    
		                                                                       		
	ENDIF																//FIM -------------------------------------------------------------------
    
	/*
	IF lRETSERIAL	//SE SERIE
		
		//VALIDACAO DO ARMAZEM DE TRANSFERENCIA X DE PARA PEDIDO DE COMPRAS-------------------------------------------------------------------------
		cQRY:=" SELECT C7_NUM, C7_ITEM, C7_AXFINAL, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, D1_LOTECTL "+CRLF
		cQRY+=" FROM "+RETSQLNAME("SC7")+" AS C7 (NOLOCK) "+CRLF
		cQRY+=" LEFT JOIN "+RETSQLNAME("SD1")+" AS D1 (NOLOCK) ON C7_NUM = D1_PEDIDO AND C7_ITEM = D1_ITEM "+CRLF
		cQRY+=" WHERE C7.D_E_L_E_T_ = '' AND D1.D_E_L_E_T_ = '' "+CRLF
		cQRY+=" 	AND D1_DOC = '"+ALLTRIM(cNOTA)+"' "+CRLF
	   	cQRY+=" 	AND D1_SERIE = '"+ALLTRIM(cSERIE)+"' "+CRLF 
		cQRY+=" 	AND D1_FORNECE = '"+ALLTRIM(cFORNECE)+"' "+CRLF
		cQRY+=" 	AND D1_LOJA = '"+ALLTRIM(cLOJA)+"' "+CRLF
		cQRY+=" 	AND D1_COD = '"+ALLTRIM(UPPER(cCodProd))+"' "+CRLF 
		cQRY+=" 	AND D1_LOTECTL = '"+ALLTRIM(UPPER(cLOTE))+"' "+CRLF	
		IF SELECT("PED") > 0												//SE ALIAS ESTIVER ABERTO
			DBSELECTAREA("PED")    											//SELECIONA ALIAS
			PED->(DBCLOSEAREA()) 											//FECHA ALIAS
		ENDIF                        										//FIM
		DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"PED",.T.,.T.)			//ABRINDO ALIAS  
		PED->(DBGOTOP())													//PRIMEIRO REGISTRO 
		IF !EMPTY(ALLTRIM(C7_NUM))                                         	//SE TIVER PEDIDO DE COMPRAS
			
			IF ALLTRIM(PED->C7_AXFINAL) <> ALLTRIM(UPPER(cLOCTRA))
				                                   	
				IF ALLTRIM(UPPER(GETMV("AD_USUTRA"))) $ ALLTRIM(UPPER(cUSERNAME)) 	//SE USUARIO AUTORIZADO	
					lPERG := MSGYESNO("ARMAZÉM SUGERIDO PARA TRANSFERÊNCIA NO PEDIDO DE COMPRAS: "+ALLTRIM(UPPER(PED->C7_AXFINAL))+"."+CRLF;
										+"DESEJA FAZER A TRANSFERÊNCIA PARA O ARMAZÉM "+ALLTRIM(UPPER(cLOCTRA))+"?","ALPA100.PRW LINE:360" )
					
					IF !lPERG				//SE NAO TRANSFERE						
						lRETSERIAL 	:= .F.	//FALSO
						_lRet    	:= .T. 	//FALSO
						LimpCampo()       	//LIMPA CAMPOS
					ENDIF
				ELSE                              									//SE NAO AUTORIZADO
					MSGALERT("ARMAZÉM SUGERIDO PARA TRANSFERÊNCIA NO PEDIDO DE COMPRAS: "+ALLTRIM(UPPER(PED->C7_AXFINAL))+".","ALPA100.PRW PARAMETRO: AD_USUTRA LINE: 372")	
					lRETSERIAL 	:= .F.	//FALSO
					_lRet    	:= .T. 	//FALSO
					LimpCampo()       	//LIMPA CAMPOS	
				ENDIF
			ENDIF

		ELSE
			//MSGALERT("NÃO POSSUI PEDIDO DE COMPRAS!")
		ENDIF
		IF SELECT("PED") > 0												//SE ALIAS ESTIVER ABERTO
			DBSELECTAREA("PED")    											//SELECIONA ALIAS
			PED->(DBCLOSEAREA()) 											//FECHA ALIAS
		ENDIF                        										//FIM ------------------------------------------------------------------
				
		INCPROD()	//FUNCAO PARA PREENCHER TELA DE GRAVACAO DOS PRODUTOS
	ENDIF
    */
    
RETURN( _lRET )

//--------------------------------------------------------------------------------------------------------------------------------------

STATIC FUNCTION INCPROD()	//GRAVACAO DOS PRODUTOS NA TELA

	Local lEncont     := .F.
	Local nI          := 0
	LOCAL nQTLIS	  := 0	
	Local X	

	If lRetProd .and. lRetLote .and. lRETSERIAL
    
		DBSELECTAREA("SB1")		//PRODUTO
		DBSETORDER(1)      		//FILIAL + COD
		IF DBSEEK(xFILIAL("SB1")+ALLTRIM(UPPER(cCodProd)))
		    IF SB1->B1_CTRSER <> 'S' 		//SE NAO CONTROLA SERIAL
				//VALIDACAO NAO DEIXAR ADD ITENS A MAIS
				IF aLstProd[1,1] <> NIL 	
					FOR X:=1 TO LEN(aLstProd)	//LENDO TODA A LISTA
						IF ALLTRIM(UPPER(cCodProd)) == ALLTRIM(UPPER(aLstProd[X,1])) .AND. ALLTRIM(UPPER(cLOTE)) == ALLTRIM(UPPER(aLstProd[X,2]))	//SE FOR MESMO PRODUTO E LOTE
							nQTLIS := nQTLIS+1	//SOMA MAIS 1 	 
						ENDIF
					NEXT
					IF SB1->B1_RASTRO == 'L'					
						IF nB8SALDO = nQTLIS
							MSGALERT("PRODUTO JÁ ADICIONADO NA LISTA!","ALPA100.PRW LINE:602")
							lEncont := .T.					
						ELSE
							//lEncont := .T.	
						ENDIF 
					ENDIF
				ELSE
					//lEncont := .T.			
				ENDIF
			ENDIF
		ENDIF
	
		If lAltProds 
			For nI := 1 to Len( aLstProd )
				If aLstProd[nI, 1] == AllTrim( UPPER(cCodProd) )
					If aLstProd[nI, 2] == AllTrim( UPPER(cLOTE) )
						IF SB1->B1_CTRSER == 'S' 		//SE CONTROLA SERIAL
							If aLstProd[nI, 3] == AllTrim( UPPER(cSERIAL) )
								lEncont := .T.
								MSGALERT("PRODUTO JÁ ADICIONADO NA LISTA!","ALPA100.PRW LINE:621")
								nQUANT 		:= 0
								Exit
							EndIf
						ENDIF 
					EndIf
				EndIf
			Next
		Else
			aLstProd  := {}
			lAltProds := .T.
		EndIF
		If ! lEncont
			Aadd( aLstProd,{ AllTrim( UPPER(cCodProd) ) , AllTrim( UPPER(cLOTE) ) , AllTrim( UPPER(cSERIAL) ) , nQUANT, ALLTRIM(UPPER(cARMTRA)), ALLTRIM(UPPER(cENDTRA)) } )
		EndIf

		oLstProd:SetArray( aLstProd )
		oLstProd:bLine := { || { aLstProd[oLstProd:nAt, 1], aLstProd[oLstProd:nAt, 2], aLstProd[oLstProd:nAt, 3], aLstProd[oLstProd:nAt, 4] ,aLstProd[oLstProd:nAt, 5], aLstProd[oLstProd:nAt, 6] } }
		oLstProd:Refresh()

		lRetProd  	:= .F.
		lRetLote  	:= .F.
		lRETSERIAL	:= .F.
		nQUANT 		:= 0

		LimpCampo()
	Endif
RETURN 
