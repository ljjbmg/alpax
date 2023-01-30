#INCLUDE "PROTHEUS.CH"

/*
AUTOR	: ANDERSON BIALE
DATA	: 03/08/12
DESC	: TELA MBROWSE MODELO2 PARA ENDERECAMENTO DOS PRODUTOS QUE UTILIZAM D1_SERIE=1(SIM) 
*/

USER FUNCTION ENDSER()							//U_ENDSER()

PRIVATE cAlias 	  := "ZBB"                                                  
PRIVATE cCadastro := "Pedido de compras"
PRIVATE aRotina   := {}

PRIVATE aGrid     := {040,005,900,1500}		// Array com coordenadas da GetDados no modelo2 - Padrao: {44,5,118,315}               

AADD(aRotina,{"Pesquisar"	,"AxPesqui"   	,0,1})	//PESQUISAR
AADD(aRotina,{"Visualizar"	,"AxVisual"		,0,2})	//VISUALIZAR
AADD(aRotina,{"Incluir"		,"AxInclui"		,0,3}) 	//INCLUIR
AADD(aRotina,{"Endereçar"	,"U_ENDERECA"	,0,4})	//ENDERECAMENTO
AADD(aRotina,{"Excluir"		,"AxExclui"		,0,5}) 	//EXCLUI

DBSELECTAREA(cAlias)
DBSETORDER(1)
SET FILTER TO ZBB->ZBB_FILIAL = xFILIAL("ZBB") .AND. ALLTRIM(ZBB->ZBB_STATUS) == ""		//FILTRO PARA TODOS OS ITENS DA NOTA FISCAL QUE CONTROLAM SERIE
DBFILTER()        															   				//EXECUTANDO FILTRO


MBROWSE( , , , ,cAlias)

RETURN

********************************************************************************************************************************************************************
USER FUNCTION ENDERECA(cAlias,nReg,nOpc)
********************************************************************************************************************************************************************
LOCAL cTitulo	:= "Endereçamento dos Produtos por série."
LOCAL aCAB      := {}     
LOCAL aRoda     := {}
Local nColuna	:= 0                    // Identifica a quantidade de colunas
Local nLinha	:= 0                    // Identifica a quantidade de linhas
Local cLinhaOk	:= "U_SERREP()" 		// Validacoes na linha da GetDados da Modelo 2
Local cTudoOk	:= "U_SERVAZ()" 		// Validacao geral da GetDados da Modelo 2 // Botao Ok Verde
Local lRetMod2 := .F. 					// Retorno da função Modelo2 - .T. Confirmou / .F. Cancelou

LOCAL aENDCAB := {}                 	//ARRAY PARA ARMAZENAR CABEÇALHO DO ENDEREÇAMENTO
LOCAL aENDITE := {}                   	//ARRAY PARA ARMAZENAR ITENS DO ENDEREÇAMENTO 
LOCAL aENDIT1 := {}                    	//ARRAY TEMPORÁRIO PARA ARMAZENAR ITENS DO ENDEREÇAMENTO 

PRIVATE lMsErroAuto := .F. 				//ERRO EXECAUTO

// Criacao da variavel com tamanho e tipo do campo ZBB_NUM
// .T. verifica se tem instrucao no INICIALIZADOR PADRAO
PRIVATE nITEM		:= 0
PRIVATE cDOC   	  	:= ZBB->ZBB_DOC
PRIVATE cSERIE		:= ZBB->ZBB_SERIE
PRIVATE cFORNECE  	:= ZBB->ZBB_FORNEC
PRIVATE cLOJA     	:= ZBB->ZBB_LOJA
PRIVATE cITEM		:= ZBB_ITEM
PRIVATE cCOD		:= ZBB_COD
PRIVATE cLOCAL		:= ZBB_LOCAL
PRIVATE nQUANT		:= ZBB_QUANT
PRIVATE cLOTE		:= ZBB_LOTE
PRIVATE dDTVALID	:= ZBB_DTVAL
PRIVATE cSERIAL		:= ZBB_SERIAL
PRIVATE nRECNO		:= RECNO()
PRIVATE cLOCALIZ 	:= ""  //LOCALIZ ENDERECO
                                            
PRIVATE aHeader := {}
PRIVATE aLINHA	:= {}
PRIVATE aCOLS   := {}
PRIVATE lSERIAL := .T.


//---------------Montagem do array de cabeçalho
//	AADD(aCab,{"Variável"	,{L,C}     	,"Título"     	,"Picture"	,"Valid"	,"F3" 	,lEnable})
	AADD(aCab,{"cDOC" 		,{015,010} 	,"Documento"	,"@!"  		,       	,     	,.F.})
	AADD(aCab,{"cSERIE"		,{015,100} 	,"Serie"     	,"@!"  		,       	,		,.F.})
	AADD(aCab,{"cFORNECE"  	,{015,140} 	,"Fornecedor" 	,"@!"  		,       	,     	,.F.}) 
	AADD(aCab,{"cLOJA"   	,{015,210} 	,"Loja"   	 	,"@!" 		,       	,     	,.F.})
	AADD(aCab,{"nQUANT"   	,{015,240} 	,"Qtde" 		,"@!" 		,       	,     	,.F.})


//MONTAGEM DO AHEADER -----------------------------------------------------------------------------------
DBSELECTAREA("SX3")	//DICIONARIO
DBSETORDER(2) 		//X3_CAMPO

IF DBSEEK("ZBB_ITEM")																//CAMPO 1 ITEM
	AAdd(aHEADER, {Trim(SX3->X3_Titulo),;      	// Titulo (label) do campo
						SX3->X3_Campo       ,; 	// Nome do campo
						SX3->X3_Picture     ,; 	// Mascara, exemplo 99.999,99
						SX3->X3_Tamanho     ,; 	// Tamanho do campo
						SX3->X3_Decimal     ,; 	// Casas decimais
						SX3->X3_Valid       ,; 	// Validacao de usuario
						SX3->X3_Usado       ,; 	// Se usado
						SX3->X3_Tipo        ,; 	// C N L D 
						SX3->X3_Arquivo     ,; 	// Consulta padrao
						SX3->X3_Context})      	// Real ou Virtual	
ENDIF

IF DBSEEK("ZBB_COD")                                              					//CAMPO 2 PRODUTO
	AAdd(aHEADER, {Trim(SX3->X3_Titulo),;      	// Titulo (label) do campo
						SX3->X3_Campo       ,; 	// Nome do campo
						SX3->X3_Picture     ,; 	// Mascara, exemplo 99.999,99
						SX3->X3_Tamanho     ,; 	// Tamanho do campo
						SX3->X3_Decimal     ,; 	// Casas decimais
						SX3->X3_Valid       ,; 	// Validacao de usuario
						SX3->X3_Usado       ,; 	// Se usado
						SX3->X3_Tipo        ,; 	// C N L D 
						SX3->X3_Arquivo     ,; 	// Consulta padrao
						SX3->X3_Context})      	// Real ou Virtual	
ENDIF

IF DBSEEK("ZBB_SERIAL")                                              				//CAMPO 3 SERIAL
	AAdd(aHEADER, {Trim(SX3->X3_Titulo),;      	// Titulo (label) do campo
						SX3->X3_Campo       ,; 	// Nome do campo
						SX3->X3_Picture     ,; 	// Mascara, exemplo 99.999,99
						SX3->X3_Tamanho     ,; 	// Tamanho do campo
						SX3->X3_Decimal     ,; 	// Casas decimais
						SX3->X3_Valid       ,; 	// Validacao de usuario
						SX3->X3_Usado       ,; 	// Se usado
						SX3->X3_Tipo        ,; 	// C N L D 
						SX3->X3_Arquivo     ,; 	// Consulta padrao
						SX3->X3_Context})      	// Real ou Virtual
ENDIF

//FIM AHEADER -------------------------------------------------------------------------------------------
                        
//INSERINDO NOS ITENS UM PRODUTO POR QUANTIDADE
FOR nLINHA :=1 TO nQUANT				//LENDO TODAS AS QUANTIDADES
	aLINHA := {}                       	//LIMPA LINHA
	AADD(aLINHA,STRZERO(nLINHA,4)	)	//1	ITEM
	AADD(aLINHA,cCOD				)	//2	PRODUTO		
	AADD(aLINHA,cSERIAL				)	//3	SERIAL
	AADD(aLINHA,.F.					)	//4	DELETADO SIM NAO
	AADD(ACOLS,aLINHA)               	//ADICIONA LINHA NOS ITENS	
NEXT                                   	//PROX
                      
lRetMod2 := MODELO2(cTitulo,aCab,aRoda,aGrid,nOpc,cLinhaOk,cTudoOk,,,,99999,,.T.,.T.)	//CHAMA MODELO 2

IF lRetMod2 = .T.											//RETORNO MODELO 2
    
	//QUERY PARA POSICIONAR NO REGISTRO A SER ENDERECADO --------------------
	cQRY := " SELECT * "												+CRLF 
	cQRY += " FROM "+RETSQLNAME("SDA")+" SDA "							+CRLF
	cQRY += " WHERE SDA.D_E_L_E_T_ = '' "								+CRLF 		 		
	cQRY += "      AND SDA.DA_DOC = '"+ALLTRIM(cDOC)+"'	 "				+CRLF 
	cQRY += "      AND SDA.DA_SERIE  = '"+ALLTRIM(cSERIE)+"' "			+CRLF  
	cQRY += "      AND SDA.DA_CLIFOR = '"+ALLTRIM(cFORNECE)+"' "		+CRLF  
	cQRY += "      AND SDA.DA_LOJA = '"+ALLTRIM(cLOJA)+"'" 				+CRLF
  	cQRY += "      AND SDA.DA_PRODUTO = '"+ALLTRIM(cCOD)+"' "			+CRLF
  	cQRY += "      AND SDA.DA_QTDORI = "+cVALTOCHAR(nQUANT)+" "			+CRLF
  	cQRY += "      AND SDA.DA_LOTECTL = '"+ALLTRIM(cLOTE)+"' "			+CRLF
  	cQRY += "      AND SDA.DA_ORIGEM = 'SD1' " 							+CRLF  
	cQRY += "      AND SDA.DA_FILIAL = '" +xFilial("SDA")+ "' "			+CRLF  
	cQRY += " ORDER BY SDA.DA_FILIAL, SDA.DA_DOC, SDA.DA_SERIE " 		+CRLF
	IF SELECT("LOC") > 0		//SE ALIAS ABERTO	
		DBSELECTAREA("LOC")    	//SELECIONA 	
		LOC->(DBCLOSEAREA())   	//FECHA
	ENDIF                     	//FIM
	DBUSEAREA(.T.,"TOPCONN",TcGenqry(,,cQRY),"LOC",.F.,.T.)
	LOC->(DBGOTOP())											//PRIMEIRO REGISTRO
    
    //EXECAUTO DE ENDERECAMENTO --------------------------------------------------------------------------------------------------
	//RESETA ARRAYS
	aENDCAB := {}	//CABECALHO	   
	aENDIT1 := {} 	//ITEM TEMPORARIO
	aENDITE := {} 	//ITEM ACUMULADOS         
	//CABECALHO ---------------------------------------------------
	AADD(aEndCab,{"DA_FILIAL" ,xFILIAL("SDA")   			,NIL} )
	AADD(aEndCab,{"DA_PRODUTO",ALLTRIM(LOC->DA_PRODUTO)		,NIL} )
	AADD(aEndCab,{"DA_QTDORI" ,LOC->DA_QTDORI	  			,NIL} )
	AADD(aEndCab,{"DA_SALDO"  ,LOC->DA_SALDO	   			,NIL} )
	AADD(aEndCab,{"DA_DATA"   ,STOD(LOC->DA_DATA)  			,NIL} )			
	AADD(aEndCab,{"DA_LOTECTL",ALLTRIM(LOC->DA_LOTECTL)		,NIL} )
	AADD(aEndCab,{"DA_LOCAL"  ,ALLTRIM(LOC->DA_LOCAL)  		,NIL} )	
	AADD(aEndCab,{"DA_DOC"    ,ALLTRIM(LOC->DA_DOC)	  		,NIL} )	
	AADD(aEndCab,{"DA_SERIE"  ,ALLTRIM(LOC->DA_SERIE)		,NIL} )		 
	AADD(aEndCab,{"DA_CLIFOR" ,ALLTRIM(LOC->DA_CLIFOR)		,NIL} )		
	AADD(aEndCab,{"DA_LOJA"   ,ALLTRIM(LOC->DA_LOJA)		,NIL} )				
	AADD(aEndCab,{"DA_TIPONF" ,ALLTRIM(LOC->DA_TIPONF)		,NIL} )							
	AADD(aEndCab,{"DA_ORIGEM" ,ALLTRIM(LOC->DA_ORIGEM)		,NIL} )									 
	AADD(aEndCab,{"DA_NUMSEQ" ,ALLTRIM(LOC->DA_NUMSEQ)		,NIL} )
	
	IF SELECT("LOC") > 0		//SE ALIAS ABERTO	
		DBSELECTAREA("LOC")    	//SELECIONA 	
		LOC->(DBCLOSEAREA())   	//FECHA
	ENDIF                     	//FIM
    
    aENDITE := {}
    
    //QUERY PARA POSICIONAR NO ULTIMO ITEM ESTORNADO SE TIVER ----------------------------------------------------------------------------------------------------------------------
	cQRY2:=" SELECT MAX(DB_ITEM) DB_ITEM "						+CRLF  
	cQRY2+=" FROM "+RETSQLNAME("SDB")+" "                     	+CRLF
	cQRY2+=" WHERE "+RETSQLNAME("SDB")+".D_E_L_E_T_ = '' "    	+CRLF
	cQRY2+=" 		AND DB_FILIAL = '"+xFILIAL("SDB")+"' "     	+CRLF
	cQRY2+=" 		AND DB_DOC = '"+ALLTRIM(cDOC)+"' "        	+CRLF
	cQRY2+="       	AND DB_SERIE  = '"+ALLTRIM(cSERIE)+"' "   	+CRLF
	cQRY2+="       	AND DB_CLIFOR = '"+ALLTRIM(cFORNECE)+"' " 	+CRLF
	cQRY2+="       	AND DB_LOJA = '"+ALLTRIM(cLOJA)+"' "     	+CRLF
	cQRY2+="       	AND DB_PRODUTO = '"+ALLTRIM(cCOD)+"' "    	+CRLF
	cQRY2+="       	AND DB_LOTECTL = '"+ALLTRIM(cLOTE)+"' "   	+CRLF
	cQRY2+="      	AND DB_ESTORNO = 'S' "                    	+CRLF
	IF SELECT("ITE") > 0		//SE ALIAS ABERTO	
		DBSELECTAREA("ITE")    	//SELECIONA 	
		ITE->(DBCLOSEAREA())   	//FECHA
	ENDIF                     	//FIM
	DBUSEAREA(.T.,"TOPCONN",TcGenqry(,,cQRY2),"ITE",.F.,.T.)
	ITE->(DBGOTOP())					//PRIMEIRO REGISTRO
	IF EMPTY(ITE->DB_ITEM)   			//SE NAO HOUVER REGISTROS ESTORNADOS
		nITEM := 1         			 	//ITEM 1 	
	ELSE	                           	//SE NAO
		nITEM := VAL(ITE->DB_ITEM)+1  	//ITEM ESTORNADO + 1
	ENDIF		                      	//FIM
	IF SELECT("ITE") > 0		//SE ALIAS ABERTO	
		DBSELECTAREA("ITE")    	//SELECIONA 	
		ITE->(DBCLOSEAREA())   	//FECHA
	ENDIF                     	//FIM ----------------------------------------------------------------------------------------------------------------------------------------------
    
    FOR nLINHA:=1 TO LEN(aCOLS)								//LENDO TODOS OS ITENS
		
		RECLOCK("ZBB",.T.)									//TRAVA ENDERECAMENTO POR SERIE PARA INCLUSAO
		ZBB->ZBB_DOC		:= ALLTRIM(cDOC)       			//DOCUMENTO 	
		ZBB->ZBB_SERIE		:= ALLTRIM(cSERIE)	   			//SERIE
		ZBB->ZBB_FORNEC		:= ALLTRIM(cFORNECE)   			//FORNECEDOR
		ZBB->ZBB_LOJA		:= ALLTRIM(cLOJA)      			//LOJA
		ZBB->ZBB_ITEM		:= ALLTRIM(STRZERO(nITEM,4)) 	//ITEM
		ZBB->ZBB_COD		:= ALLTRIM(aCOLS[nLINHA,2]) 	//PRODUTO
		ZBB->ZBB_LOCAL		:= ALLTRIM(cLOCAL)     			//LOCAL
		ZBB->ZBB_QUANT		:= 1           					//QUANTIDADE
		ZBB->ZBB_LOTE		:= ALLTRIM(cLOTE)      			//LOTE
		
		//SE LOTE VAZIO, INFORMA DATA BASE NA DATA DA VALIDAD DO LOTE
		IF EMPTY(ALLTRIM(cLOTE))
			dDTVALID := dDATABASE
		ENDIF
		
		ZBB->ZBB_DTVAL		:= dDTVALID						//DT VALIDADE LOTE
		ZBB->ZBB_SERIAL		:= ALLTRIM(aCOLS[nLINHA,3]) 	//SERIAL
		ZBB->ZBB_STATUS		:= "1"							//STATUS	
		ZBB->(MSUNLOCK())                					//DESTRAVA
		
		cLOCALIZ := GETADVFVAL("SBE","BE_LOCALIZ",xFILIAL("SBE")+ALLTRIM(cLOCAL),1)	//LOCAL DE DESTINO
				 
		//ITENS -------------------------------------------------------
		aEndIt1 := {}									         
		AADD(aEndIt1,{"DB_FILIAL" ,xFILIAL("SDB")				,NIL} )
		AADD(aEndIt1,{"DB_ITEM"   ,ALLTRIM(STRZERO(nITEM,4))	,NIL} )
		AADD(aEndIt1,{"DB_LOCALIZ",ALLTRIM(cLOCALIZ)			,NIL} )		 
		AADD(aEndIt1,{"DB_QUANT"  ,1							,NIL} )				 
		AADD(aEndIt1,{"DB_DATA"   ,dDTVALID			   			,NIL} )			
		AADD(aEndIt1,{"DB_NUMSERI",ALLTRIM(aCOLS[nLINHA,3])	   	,NIL} )
		nITEM++		        
		AADD(aENDITE,ACLONE(aENDIT1))
	
	NEXT	                               				//PROXIMO ITEM
	
	lMSErroAuto := .F.									//VALIDACAO EXECAUTO
	MSEXECAUTO({|x,y|mata265(x,y)},aEndCab,aEndIte,3) 	//EXECUTA EXECAUTO ENDERECAMENTO
	
	IF lMsErroAuto		//SE VALIDACAO 					
		MostraErro()   	//MOSTRA ERRO	
	ELSE
		//DELETANDO REGISTRO 
		cUPD := " UPDATE	"+RETSQLNAME("ZBB")+" SET "+RETSQLNAME("ZBB")+".D_E_L_E_T_ = '*' 	"+CRLF	//DELETANDO REGISTRO
		cUPD += " WHERE		"+RETSQLNAME("ZBB")+".R_E_C_N_O_ = '"+cVALTOCHAR(nRECNO)+"'			"+CRLF 	//REGISTRO IGUAL AO RECNO
		TCSQLEXEC(cUPD)
	ENDIF             	//FIM  	
	
	
ENDIF
                                                                                                                     
RETURN

********************************************************************************************************************************************************************
USER FUNCTION SERVAZ()
********************************************************************************************************************************************************************

LOCAL lSERIAL := .T.
LOCAL nLINHA  := 0

//VALIDACAO PARA SERIAL DOS PRODUTOS
FOR nLINHA:=1 TO LEN(aCOLS)    			//LEITURA DE TODO ACOLS
	IF EMPTY(ALLTRIM(aCOLS[nLINHA,3]))	//SE SERIAL VAZIO
		lSERIAL := .F.	  				//RECEBE FALSO		
	ENDIF               				//FIM
NEXT                       				//PROX

IF !(lSERIAL)							  				//SE .F.
	MSGALERT("PREENCHA TODOS OS SERIAIS","ENDSER.PRW LINE:289") 	//ALERTA
ENDIF                                          			//FIM

RETURN lSERIAL

********************************************************************************************************************************************************************
USER FUNCTION SERREP()
********************************************************************************************************************************************************************
      
LOCAL lSERREP	:= .T.
LOCAL cSERREP	:= ""
LOCAL nASCAN	:= 0             
              
LOCAL cSERREP := aCOLS[N,3]
LOCAL nASCAN  := aSCAN( aCOLS,{ |X| AllTrim( X[3] ) == ALLTRIM(cSERREP) } )  

IF N > 1
	IF nASCAN > 0 .and. nASCAN <> N
		MSGALERT("SERIAL JA CADASTRADO","ENDSER.PRW LINE:307")
		lSERREP := .F.
	ENDIF
ENDIF

//QUERY PARA POSICIONAR NO ULTIMO ITEM ESTORNADO SE TIVER ----------------------------------------------------------------------------------------------------------------------
cQRY3:=" SELECT BF_NUMSERI "	 							+CRLF  
cQRY3+=" FROM "+RETSQLNAME("SBF")+" "                     	+CRLF
cQRY3+=" WHERE "+RETSQLNAME("SBF")+".D_E_L_E_T_ = '' "    	+CRLF
cQRY3+=" 		AND BF_FILIAL = '"+xFILIAL("SBF")+"' "     	+CRLF
cQRY3+=" 		AND BF_NUMSERI = '"+ALLTRIM(cSERREP)+"' " 	+CRLF
IF SELECT("REP") > 0		//SE ALIAS ABERTO	
	DBSELECTAREA("REP")    	//SELECIONA 	
	REP->(DBCLOSEAREA())   	//FECHA
ENDIF                     	//FIM
DBUSEAREA(.T.,"TOPCONN",TcGenqry(,,cQRY3),"REP",.F.,.T.)
REP->(DBGOTOP())			//PRIMEIRO REGISTRO
IF !EMPTY(REP->BF_NUMSERI)	//SE JA EXISTE A SERIE
	lSERREP := .F.			//RETORNA FALSO	
	MSGALERT("SERIAL JA CADASTRADO","ENDSER.PRW LINE:326")
ENDIF
IF SELECT("REP") > 0		//SE ALIAS ABERTO	
	DBSELECTAREA("REP")    	//SELECIONA 	
	REP->(DBCLOSEAREA())   	//FECHA
ENDIF                     	//FIM                                                 
                    
RETURN lSERREP