#INCLUDE "PROTHEUS.CH"

/*
AUTOR	: ANDERSON BIALE
DARA	: 07/08/12
DESC	: RELATORIO DE SEPARACAO DE PEDIDOS DA ALPAX
*/
USER FUNCTION RELCONF()		//U_RELCONF()

LOCAL 	cQRY		:= ""
LOCAL	cPROD		:= "XXXXXXXXXXXXXXX"
PRIVATE	cCODBAR 	:= STRZERO(VAL(SUBSTRING(DTOS(DATE()),7,2)+ SUBSTRING(DTOS(DATE()),5,2)+SUBSTRING(DTOS(DATE()),3,2)+SUBSTR(TIME(), 1, 2)+ SUBSTR(TIME(), 4, 2) + SUBSTR(TIME(), 7, 2)),12,0)
PRIVATE cChavePick 	:= ''
PRIVATE cAcesso 	:= Repl(" ",10)
PRIVATE oFont1 		:= TFont():New("Arial",7,7,.T.)
PRIVATE oFont2		:= TFont():New("Arial",10,10,.T.,.T.,5,.T.,5,.T.,.F.)
PRIVATE oFont20N	:= TFont():New("Arial",18,20,.T.,.T.,5,.T.,5,.T.,.F.)
PRIVATE X 			:= 0
PRIVATE nLINPRO		:= 3.7
PRIVATE nQTDITE     := 0     //Quantidade de itens da pagina
PRIVATE nQTDTOT     := 0     //Quantidade de itens total
PRIVATE lPrimeiro   := .t.   //Primeiro registro da ordem
PRIVATE GREMB       := " "   //Grupo de embalagem

PRIVATE cPerg		:= "RELCONF"
//CRIASX1()
IF !(PERGUNTE(cPERG))  											//CHAMA PERGUNTAS
	RETURN                 										//SE CANCELOU FINALIZA, SE OK CONTINUA FUNCAO
ENDIF															//FIM

cAGLUT := '1' 	//SIM AGLUTINA
GERAREL()      	//GERA RELATORIO

cCODBAR := STRZERO((VAL(cCODBAR)+1),12)

cAGLUT := '2'  	//NAO AGLUTINA
GERAREL()      	//GERA RELATORIO


RETURN

STATIC FUNCTION GERAREL()

//QUERY PARA SEPARACAO ------------------------------------------------------------------------------------------------------------------------------------------------------
cQRY:= " 	SELECT C9_PRODUTO, B1_DESC, B1_UM, C9_QTDLIB, C9_LOCAL, C9_ENDPAD, C9_LOTECTL, C9_DTVALID, B1_LOCALIZ, C6_ENTREG, C5_TRANSP, C5_VEND1"								  	+CRLF
cQry+= "	, Isnull(CASE    WHEN B1_XREFRIG = '1' THEN 'Geladeira' WHEN B1_XREFRIG = '2' THEN 'Refrigerado' End,'') as REFRIG "													+CRLF
cQRY+= " 	, (CASE C5_TPFRETE WHEN 'C' THEN 'CIF' ELSE CASE C5_TPFRETE WHEN 'F' THEN 'FOB' ELSE '' END END) AS C5_TPFRETE, C6_NUMSERI "                                          	+CRLF
cQRY+= " 	, ISNULL(X5_DESCRI,'SIMPLES') AS DESCRICAO , C9_CLIENTE, C9_LOJA, C9_PEDIDO, C5_CONDPAG, C9_ITEM,  B1_MARCA, B1_CAPACID, B1_PNUMBER, B1_UM, B1_AXRISCO, A1_AGLUTPV, C5_AXATEND, C9_NUMSERI, B1_CTRSER, C5_TIPO, C9.R_E_C_N_O_, C9_AGREG, B1_AXNONU, B1_AXGREMB "	+CRLF
cQRY+= " FROM "+RETSQLNAME("SC9")+" C9 (NOLOCK) "                                                                                                  	+CRLF
cQRY+= " 	INNER JOIN "+RETSQLNAME("SC6")+" C6 (NOLOCK)  "                                                                                        	+CRLF
cQRY+= " 		ON C6_FILIAL = '"+xFILIAL("SC6")+"' AND C6_NUM = C9_PEDIDO AND C6_ITEM = C9_ITEM "                                                	+CRLF
cQRY+= " 	INNER JOIN "+RETSQLNAME("SC5")+" C5 (NOLOCK)
cQRY+= " 	 		ON C5_FILIAL = '"+xFILIAL("SC5")+"' AND C5_NUM = C9_PEDIDO
cQRY+= " 	INNER JOIN "+RETSQLNAME("SB1")+" B1 (NOLOCK) "                                                                                        	+CRLF
cQRY+= " 		ON B1_FILIAL = '"+xFILIAL("SB1")+"' AND B1_COD = C9_PRODUTO "                                                                     	+CRLF
cQRY+= " 	INNER JOIN "+RETSQLNAME("SF4")+" F4 (NOLOCK) "                                                                                         	+CRLF
cQRY+= " 		ON F4_FILIAL = '"+xFILIAL("SF4")+"' AND F4_CODIGO = C6_TES "                          	                                        	+CRLF
cQRY+= " 	LEFT JOIN "+RETSQLNAME("SX5")+" X5 (NOLOCK) "																							+CRLF
cQRY+= " 		ON X5_TABELA  = 'Z1' AND X5.D_E_L_E_T_ <> '*' AND B1_AXRISCO = X5_CHAVE "                                                         	+CRLF
cQRY+= " 	LEFT JOIN "+RETSQLNAME("SA1")+" A1 (NOLOCK)
cQRY+= " 		ON C9_CLIENTE = A1_COD AND C9_LOJA = A1_LOJA
cQRY+= " 	WHERE  C9_FILIAL = '"+xFILIAL("SC9")+"' AND C9_SERIENF = ' ' AND C9_NFISCAL = ' ' AND C9_BLEST = ' ' AND C9_BLCRED = ' ' "            	+CRLF
cQRY+= " 	       AND C9_PEDIDO BETWEEN '"+ALLTRIM(MV_PAR01)+"' AND '"+ALLTRIM(MV_PAR02)+"'  "		   												+CRLF
cQRY+= " 	       AND C5_CLIENTE BETWEEN '"+ALLTRIM(MV_PAR03)+"' AND '"+ALLTRIM(MV_PAR04)+"' "														+CRLF
cQRY+= " 	       AND C5_TRANSP BETWEEN '"+ALLTRIM(MV_PAR05)+"' AND '"+ALLTRIM(MV_PAR06)+"' "														+CRLF
cQRY+= " 	       AND C6_ENTREG BETWEEN '"+DTOS(MV_PAR07)+"' AND '"+DTOS(MV_PAR08)+"'"																+CRLF
cQRY+= " 	       AND C9_XSEPARA <> '1' " +CRLF
cQRY+= " 	       AND F4_ESTOQUE = 'S' " +CRLF
cQRY+= " 	       AND Isnull(A1_AGLUTPV,'2') = '"+ALLTRIM(cAGLUT)+"' "+CRLF
cQRY+= " 	       AND C9_PEDIDO BETWEEN '"+ALLTRIM(MV_PAR01)+"' AND '"+ALLTRIM(MV_PAR02)+"' AND C9_XSEPARA = '' AND F4_ESTOQUE = 'S' "           	+CRLF
cQRY+= " 	       AND C9.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' AND C5.D_E_L_E_T_ = ' ' "	   	+CRLF
cQRY+= " 	       AND F4_ESTOQUE = 'S' "																								   			+CRLF

IF cAGLUT = '1'		//SIM SE AGLUTINA
	cQRY+= " 	ORDER BY C5_TPFRETE, C9_CLIENTE, C9_LOJA, C5_TRANSP, C5_CONDPAG, C9_AGREG, C9_PEDIDO, A1_AGLUTPV "
ELSE
	cQRY+= " 	ORDER BY C5_TPFRETE, C9_CLIENTE, C9_LOJA, C5_TRANSP, C5_CONDPAG, C9_PEDIDO, C9_AGREG, A1_AGLUTPV "
ENDIF

MEMOWRIT("\queries\RELCONF.SQL",cQry)


IF SELECT("SEP") > 0											//SE ALIAS ESTIVER ABERTO  158004
	DBSELECTAREA("SEP")    										//SELECIONA ALIAS
	SEP->(DBCLOSEAREA()) 										//FECHA ALIAS
ENDIF                        									//FIM
DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"SEP",.T.,.T.)



IF EMPTY(SEP->C9_PEDIDO)                                           	//SE JA IMPRIMIU SEPARACAO
	IF SELECT("SEP") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("SEP")    										//SELECIONA ALIAS
		SEP->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM
	//IF ALLTRIM(cAGLUT) = '1'
	MSGALERT("NÃO HÁ ORDENS A SEREM GERADAS!","RELCONF.PRW LINE: 69")     	//ALERTA
	//ENDIF
	
ELSE	                                                       	//FIM DA FUNCAO
	
	
	oPrint 	:= TMSPrinter():New("RELATORIO DE SEPARACAO")	//TITULO JANELA
	oPrint:Setup()                                    		//CONFIGURACAO IMPRESSORA
	oPrint:SetLANDSCAPE()
	LCABEC 	:= .T.											//CABECALHO
	SEP->(DBGOTOP())                                   		//PRIMEIRO REGISTRO QUERY
	
	RELCAB()					//IMPRIME CABECALHO
	
	cCLIENTE:= SEP->C9_CLIENTE 	//CLIENTE
	cLOJA	:= SEP->C9_LOJA    	//LOJA
	cTRANSP	:= SEP->C5_TRANSP  	//TRANSPORTADORA
	cCONDPAG:= SEP->C5_CONDPAG	//COND PAGAMENTO
	cRISCO	:= SEP->B1_AXRISCO 	//RISCO
	cPEDIDO	:= SEP->C9_PEDIDO	//PEDIDO
	cTPFRETE:= SEP->C5_TPFRETE  //TIPO DE FRETE
	cAGREG  := SEP->C9_AGREG    //AGREGADOR
	
	DO WHILE !SEP->(EOF())											//LEITURA TODA QUERY
		
		IF cCLIENTE 			<> SEP->C9_CLIENTE	;					//CLIENTE
			.OR. cLOJA	 	<> SEP->C9_LOJA    	;					//LOJA
			.OR. cTRANSP	<> SEP->C5_TRANSP  	;					//TRANSPORTADORA
			.OR. cCONDPAG 	<> SEP->C5_CONDPAG	;					//COND PAGAMENTO
			.OR. cRISCO		<> SEP->B1_AXRISCO  ;					//RISCO
			.OR. (cAGLUT <> "1" .AND. cPEDIDO <> SEP->C9_PEDIDO);  	//SE NAO AGLUTINA, FILTRA MAIS O PEDIDO
			.OR. cTPFRETE <> SEP->C5_TPFRETE   	                    //TIPO DE FRETE (CIF / FOB) (Incluído por Fagner em 19/08/2013)
			
			cCODBAR := STRZERO((VAL(cCODBAR)+1),12 ) 	//CODBAR + 1
			
			lPrimeiro := .t.
			
			RELROD()
			
			//SEP->(DBSKIP())
			
			RELCAB()								//IMPRIMI CABECALHO
			
			cCLIENTE:= SEP->C9_CLIENTE 	//CLIENTE
			cLOJA	:= SEP->C9_LOJA    	//LOJA
			cTRANSP	:= SEP->C5_TRANSP  	//TRANSPORTADORA
			cCONDPAG:= SEP->C5_CONDPAG	//COND PAGAMENTO
			cRISCO	:= SEP->B1_AXRISCO 	//RISCO
			cPEDIDO	:= SEP->C9_PEDIDO	//PEDIDO
			cTPFRETE:= SEP->C5_TPFRETE  //TIPO DE FRETE (CIF / FOB)
		ELSE
			If lPrimeiro == .t.
				CONTAREG()
			endif
			RELITE()
			SEP->(DBSKIP())
			
		ENDIF
		
	ENDDO
	
	//RODAPE ---------------------------------------------------------------------------------------
	oPrint:Say(2150 ,50,"Separado por :" ,oFont1,1400,CLR_BLACK)
	oPrint:Say(2150 ,1700,"Conferido por :" ,oFont1,1400,CLR_BLACK)
	oPrint:Line(2200 ,10,2200,3400)
	oPrint:Say(2300 ,50,"Observacoes" ,oFont1,1400,CLR_BLACK)
	oPrint:Line( 2350,10,2350,3400)
	oPrint:Say(2300 ,3000,"Qtd itens : " + STRZERO(nQTDITE,4) + " / " + STRZERO(nQTDTOT,4),oFont1,1400,CLR_BLACK)     //Incluido por Ocimar
	nQTDITE := 0
	oPrint:EndPage()
	oPrint:Preview()
	IF SELECT("SEP") > 0											//SE ALIAS ESTIVER ABERTO
		DBSELECTAREA("SEP")    										//SELECIONA ALIAS
		SEP->(DBCLOSEAREA()) 										//FECHA ALIAS
	ENDIF                        									//FIM -------------------
	
ENDIF
RETURN

********************************************************************************************************************************************************************

STATIC FUNCTION RELITE()

IF X > 1900
	RELROD()    //IMPRIME RODAPE
	RELCAB()	//IMPRIME CABECALHO
ENDIF

//VERIFICANDO SE JA EXISTE O CODIGO DE BARRAS NO C9 ------ OCIMAR 25/07/2018--------------------------------------------------------------

DBSELECTAREA("SC9")
//SC9->(DBSetOrder(C))
IF SC9->(DBSEEK(XFILIAL("SC9")+cCODBAR))	//POSICIONANDO REG
	cCODBAR := STRZERO((VAL(cCODBAR)+10),12 ) 	//CODBAR + 10
ENDIF
SC9->(DBCLOSEAREA())

//GRAVANDO CODIGO DE BARRAS NOS ITENS LIBERADOS -----------------------------------------------------------------------------------------

DBSELECTAREA("SC9")																			//PEDIDOS LIBERADOS
SC9->(DBSetOrder(2))   																		//FILIAL + CLIENT + LOJA + PEDIDO + ITEM
IF SC9->(DBSEEK(XFILIAL("SC9")+SEP->C9_CLIENTE+SEP->C9_LOJA+SEP->C9_PEDIDO+SEP->C9_ITEM))	//POSICIONANDO REG
	RECLOCK("SC9",.F.)                                                                		//TRAVA P/ ALTERACAO
	SC9->C9_CODBAR  := cCODBAR                                                           	//CODIGO BARRAS
	SC9->C9_AGREG	:= SUBSTRING(cCODBAR,9,4)
	SC9->C9_XSEPARA	:= "1"																	//FLAG DE IMPRESSAO
	SC9->(MSUNLOCK())                                                                      	//DESTRAVANDO REG
ENDIF	                                                                                   	//FIM ---------------------------------------


//GRAVA CODBAR NO C9, PREENCHE XSEPARA PARA NAO SER SEPARADO NOVAMENTE
cUPD:=" UPDATE "+RETSQLNAME("SC9")+" SET C9_CODBAR = '"+STRZERO(VAL(ALLTRIM(cCODBAR)),12)+"',  C9_AGREG =  '"+SUBSTRING(STRZERO(VAL(cCODBAR),12),9,4)+"', C9_XSEPARA = '1', C9_AXDTIMP = '"+DTOS(DDATABASE)+"', C9_AXHRIMP = '"+Transform(Time(),"99:99:99")+"' , C9_AXUSSEP = '" + alltrim(cUsername) + "' "+CRLF
cUPD+=" FROM "+RETSQLNAME("SC9")+" "                      		+CRLF
cUPD+=" WHERE "+RETSQLNAME("SC9")+".D_E_L_E_T_ = '' " 			+CRLF
cUPD+=" 	AND C9_FILIAL 	= '"+xFILIAL("SC9")+"' "     		+CRLF
cUPD+="		AND C9_PEDIDO 	= '"+ALLTRIM(SEP->C9_PEDIDO)+"' "	+CRLF
cUPD+="		AND C9_ITEM 	= '"+ALLTRIM(SEP->C9_ITEM)+"' "		+CRLF
cUPD+="		AND C9_PRODUTO 	= '"+ALLTRIM(SEP->C9_PRODUTO)+"' "	+CRLF
cUPD+="		AND C9_CLIENTE 	= '"+ALLTRIM(SEP->C9_CLIENTE)+"' "	+CRLF
cUPD+="		AND C9_LOJA 	= '"+ALLTRIM(SEP->C9_LOJA)+"' "		+CRLF
cUPD+="		AND C9_NFISCAL 	= '' "								+CRLF
TCSQLEXEC(cUPD)

//ITENS
cQRY2:=" SELECT DC_PRODUTO, DC_QUANT, DC_LOCAL, DC_PEDIDO, DC_LOTECTL, DC_NUMSERI "
cQRY2+=" FROM "+RETSQLNAME("SDC")+" AS DC (NOLOCK) "
cQRY2+=" WHERE DC.D_E_L_E_T_ = '' "
cQRY2+=" AND DC_FILIAL = '"+xFILIAL("SDC")+"' "
cQRY2+=" AND DC_PEDIDO = '"+ALLTRIM(SEP->C9_PEDIDO)+"' "
cQRY2+=" AND DC_ITEM = '"+ALLTRIM(SEP->C9_ITEM)+"' "
cQRY2+=" AND DC_PRODUTO = '"+ALLTRIM(SEP->C9_PRODUTO)+"' "
cQRY2+=" AND DC_LOCAL = '"+ALLTRIM(SEP->C9_LOCAL)+"' "
cQRY2+=" AND DC_LOTECTL = '"+ALLTRIM(SEP->C9_LOTECTL)+"'  "

IF SELECT("SER") > 0											//SE ALIAS ESTIVER ABERTO
	DBSELECTAREA("SER")    										//SELECIONA ALIAS
	SER->(DBCLOSEAREA()) 										//FECHA ALIAS
ENDIF                        									//FIM
DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY2),"SER",.T.,.T.)
SER->(DBGOTOP())

oPrint:Say( X+=35,50  	,ALLTRIM(SEP->C9_PRODUTO)   	,oFont1,1400,CLR_BLACK)		//PRODUTO
oPrint:Say( X,330		,ALLTRIM(SEP->B1_PNUMBER) 		,oFont1,1400,CLR_BLACK)		//PNUMBER
oPrint:Say( X,530		,ALLTRIM(SEP->B1_DESC) + IIF(Empty(SEP->REFRIG),"","-"+SEP->REFRIG)	,oFont1,1400,CLR_BLACK)		//DESCRICAO
oPrint:Say( X,1500		,ALLTRIM(SEP->B1_MARCA)			,oFont1,1400,CLR_BLACK)		//MARCA
oPrint:Say( X,1800		,ALLTRIM(SEP->B1_CAPACID)		,oFont1,1400,CLR_BLACK)		//CAPACIDADE
oPrint:Say( X,2000		,ALLTRIM(SEP->B1_UM)			,oFont1,1400,CLR_BLACK)		//UNIDADE MEDIDA

//IMPRESSAO DO N. ONU E DO GRUPO DE EMBALAGEM
IF !EMPTY(SEP->B1_AXNONU)
	
	DO CASE
		CASE SEP->B1_AXGREMB == "A"
			GREMB := "GRUPO I"
		CASE SEP->B1_AXGREMB == "B"
			GREMB := "GRUPO II"
		CASE SEP->B1_AXGREMB == "C"
			GREMB := "GRUPO III"
	ENDCASE
	
	oPrint:Say( X+=35,1500	,"N. ONU : "+cVALTOCHAR(SEP->B1_AXNONU)         	,oFont1,1400,CLR_BLACK)	//N. ONU
	oPrint:Say( X,1800		,"GRP. EMBALAGEM : "+ALLTRIM(GREMB)         		,oFont1,1400,CLR_BLACK)	//GRP EMBALAGEM
	_cEmbala := " "
	X-=35
ENDIF


//IMPRESSAO DOS CODIGOS DE BARRA ----------------------------------------------------------------------------------
X+=83
//PRODUTO 	//CODIGO DE BARRAS
MSBAR3("CODE128",nLINPRO,1 ,ALLTRIM(SEP->C9_PRODUTO),oPrint,NIL,NIL,NIL,0.03,0.4,NIL,NIL,NIL,.F.)

//LOTE    	//CODIGO DE BARRAS
IF !EMPTY(SER->DC_LOTECTL)
	MSBAR3("CODE128",nLINPRO,20,ALLTRIM(SER->DC_LOTECTL),oPrint,NIL,NIL,NIL,0.03,0.4,NIL,NIL,NIL,.F.)
ENDIF
nLINPRO+=1.0 //----------------------------------------------------------------------------------------------------

X-=35
X-=83
nLINPRO-=1.0

WHILE SER->(!EOF())
	
	IF X > 2000
		RELROD()    //IMPRIME RODAPE
		RELCAB()	//IMPRIME CABECALHO
	ENDIF
	/*
	oPrint:Say( X+=35,1950	,cVALTOCHAR(SER->DC_QUANT)		,oFont1,1400,CLR_BLACK)	//QUANTIDADE
	oPrint:Say( X,2000		,ALLTRIM(SEP->C9_LOCAL) 		,oFont1,1400,CLR_BLACK)	//LOCAL
	oPrint:Say( X,2050 		,ALLTRIM(SEP->C9_LOTECTL) 		,oFont1,1400,CLR_BLACK)	//LOTE
	oPrint:Say( X,2300 		,DTOC(STOD(SEP->C9_DTVALID))	,oFont1,1400,CLR_BLACK)	//VALIDADE
	oPrint:Say( X,2450		,ALLTRIM(SER->DC_NUMSERI) 		,oFont1,1400,CLR_BLACK)	//SERIE
	oPrint:Say( X,2650		,ALLTRIM(SEP->B1_AXRISCO) 		,oFont1,1400,CLR_BLACK)	//RISCO
	oPrint:Say( X,2950		,ALLTRIM(SEP->C9_PEDIDO)  		,oFont1,1400,CLR_BLACK)	//PEDIDO
	*/
	oPrint:Say( X+=35,2050 	,cVALTOCHAR(SER->DC_QUANT)		,oFont1,1400,CLR_BLACK)	//QUANTIDADE
	oPrint:Say( X,2150		,ALLTRIM(SEP->C9_LOCAL) 		,oFont1,1400,CLR_BLACK)	//LOCAL
	oPrint:Say( X,2200 		,ALLTRIM(SEP->C9_LOTECTL) 		,oFont1,1400,CLR_BLACK)	//LOTE
	oPrint:Say( X,2400 		,DTOC(STOD(SEP->C9_DTVALID))	,oFont1,1400,CLR_BLACK)	//VALIDADE
	oPrint:Say( X,2550		,ALLTRIM(SER->DC_NUMSERI) 		,oFont1,1400,CLR_BLACK)	//SERIE
	oPrint:Say( X,2750		,ALLTRIM(SEP->B1_AXRISCO) 		,oFont1,1400,CLR_BLACK)	//RISCO
	oPrint:Say( X,2950		,ALLTRIM(SEP->C9_PEDIDO)  		,oFont1,1400,CLR_BLACK)	//PEDIDO
	
	nQTDITE ++
	
	//IMPRESSAO DOS CODIGOS DE BARRA ----------------------------------------------------------------------------------
	X+=83
	
	//SERIE 	//CODIGO DE BARRAS
	IF !EMPTY(SER->DC_NUMSERI)
		MSBAR3("CODE128",nLINPRO,10,ALLTRIM(SER->DC_NUMSERI),oPrint,NIL,NIL,NIL,0.03,0.4,NIL,NIL,NIL,.F.)
	ENDIF
	
	nLINPRO+=1.0 //----------------------------------------------------------------------------------------------------
	
	
	SER->(DBSKIP())
ENDDO

IF SELECT("SER") > 0											//SE ALIAS ESTIVER ABERTO
	DBSELECTAREA("SER")    										//SELECIONA ALIAS
	SER->(DBCLOSEAREA()) 										//FECHA ALIAS
ENDIF                        									//FIM

cPROD := ALLTRIM(SEP->C9_PRODUTO)	//ATUALIZA PRODUTO

RETURN

********************************************************************************************************************************************************************

STATIC FUNCTION RELROD()

//IMPRIMI RODAPE ----------------------------------------------
oPrint:Say(2150 ,50,"Separado por :" ,oFont1,1400,CLR_BLACK)
oPrint:Say(2150 ,1700,"Conferido por :" ,oFont1,1400,CLR_BLACK)
oPrint:Line(2200 ,10,2200,3400)
oPrint:Say(2300 ,50,"Observacoes" ,oFont1,1400,CLR_BLACK)
oPrint:Line( 2350,10,2350,3400)
oPrint:Say(2300 ,3000,"Qtd itens : " + STRZERO(nQTDITE,4) + " / " + STRZERO(nQTDTOT,4),oFont1,1400,CLR_BLACK)     //Incluido por Ocimar
nQTDITE := 0
oPrint:EndPage() //--------------------------------------------

RETURN

********************************************************************************************************************************************************************

STATIC FUNCTION RELCAB()

LOCAL cCLIFOR := ""	//CLIENTE OU FORNECEDOR

X		:=50
Y		:=2.2
nLINPRO	:= 3.7

oPrint:StartPage()
oPrint:Say( X,50		,"ALPAX. COM.PROD.PARA LABS. LTDA.",oFont20N,1400,CLR_BLACK)
oPrint:Say( X+=100,50	,"PICK LIST DE SEPARAÇÃO E CONFERÊNCIA    "+DTOC(DDATABASE)+"    "+TIME()+SPACE(125)+STRZERO(VAL(ALLTRIM(cCODBAR)),12) ,oFont2,1400,CLR_BLACK)

//VALIDACAO CLIENTE OU FORNECEDOR
IF ALLTRIM(SEP->C5_TIPO) $ "D;B"
	DBSELECTAREA("SA2")
	cCLIFOR := ALLTRIM( GETADVFVAL("SA2","A2_NOME",xFILIAL("SA2")+ALLTRIM(SEP->C9_CLIENTE)+ALLTRIM(SEP->C9_LOJA),1) )
ELSE
	DBSELECTAREA("SA1")
	cCLIFOR := ALLTRIM( GETADVFVAL("SA1","A1_NOME",xFILIAL("SA1")+ALLTRIM(SEP->C9_CLIENTE)+ALLTRIM(SEP->C9_LOJA),1) )
ENDIF

oPrint:Say( X+=50,50	,"CLIENTE: "+ALLTRIM(SEP->C9_CLIENTE)+"/"+ALLTRIM(SEP->C9_LOJA)+" - "+ALLTRIM(cCLIFOR) ,oFont2,1400,CLR_BLACK)
oPrint:Say( X+=50,50	,"TRANSP.: "+ALLTRIM(SEP->C5_TRANSP)+" - "+ALLTRIM( GETADVFVAL("SA4","A4_NOME",xFILIAL("SA4")+ALLTRIM(SEP->C5_TRANSP),1) )+"    TIPO FRETE: "+ALLTRIM(SEP->C5_TPFRETE)+"    VENDEDOR: "+ALLTRIM(SEP->C5_AXATEND),oFont2,1400,CLR_BLACK) //C5_AXTEND

//CABECALHO 1 -----------------------------------------------------------------------
oPrint:Say( X+=100,50	,"PRODUTO" 		,oFont1,1400,CLR_BLACK)
oPrint:Line( X,10,X,3400)
oPrint:Say( X,330		,"PNUMBER" 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,530		,"DESCRICAO"	,oFont1,1400,CLR_BLACK)
oPrint:Say( X,1500		,"MARCA"		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,1800		,"CAPACID." 	,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2000		,"UM"		 	,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2050		,"QT"	 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2150		,"AR"			,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2200		,"LOTE" 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2400		,"VALID"  		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2550		,"SERIE" 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2750		,"CLASSE" 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2950		,"PEDIDO"		,oFont1,1400,CLR_BLACK)	//SERIE
/*oPrint:Say( X,2000		,"AR"			,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2050		,"LOTE" 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2300		,"VALID"  		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2450		,"SERIE" 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2650		,"CLASSE" 		,oFont1,1400,CLR_BLACK)
oPrint:Say( X,2950		,"PEDIDO"		,oFont1,1400,CLR_BLACK)	//SERIE
*/
oPrint:Line( X+=25,10,X,3400)

//CODIGO DE BARRAS ------------------------------------------------------------
MSBAR3("CODE128",0.3,15 ,cCODBAR,oPrint,NIL,NIL,NIL,0.06,0.6,NIL,NIL,NIL,.F.)
//oPrint:Say(X+9,1150," CLASSE "+SEP->B1_AXRISCO+SEP->DESCRICAO ,oFont1,1400,CLR_BLACK)
//dbselectarea("SC5")
//DBSETORDER(1)
//DBSEEK(XFILIAL("SC5")+SEP->C9_PEDIDO)
//dbselectarea("SA3")
//DBSETORDER(1)
//DBSEEK(XFILIAL("SA3")+SC5->C5_VEND1)
//oPrint:Say(X+9,2100," VENDEDOR: "+SA3->A3_NOME ,oFont1,1400,CLR_BLACK)
RETURN

********************************************************************************************************************************************************************

//STATIC FUNCTION CRIASX1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Da Pedido                      ³
//³MV_PAR02 = Ate Pedido                     ³
//³MV_PAR03 = Cliente de                     ³
//³MV_PAR04 = Cliente ate                    ³
//³MV_PAR05 = Transportadora de              ³
//³MV_PAR06 = Transportadora ate             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//PutSx1(cPerg,"01","Do Pedido"			,"Do Pedido"			,"Da Nota Fiscal"		,"mv_ch1","C",06,0,0,"G","",""		,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
//PutSx1(cPerg,"02","Ate Pedido"			,"Ate Pedido"			,"Ate Pedido"			,"mv_ch2","C",06,0,0,"G","",""		,"","","mv_par02","","","","","","","","","","","","","","","","",,,)
//PutSx1(cPerg,"03","Cliente de "			,"Cliente de "			,"Cliente de "			,"mv_ch3","C",06,0,0,"G","",""		,"","","mv_par03","","","","","","","","","","","","","","","","",,,)
//PutSx1(cPerg,"04","Cliente ate "		,"Cliente ate "			,"Cliente ate "			,"mv_ch4","C",06,0,0,"G","",""		,"","","mv_par04","","","","","","","","","","","","","","","","",,,)
//PutSx1(cPerg,"05","Transportadora de "	,"Transportadora de "	,"Transportadora de "	,"mv_ch5","C",06,0,0,"G","","SA4"	,"","","mv_par05","","","","","","","","","","","","","","","","",,,)
//PutSx1(cPerg,"06","Transportadora ate"	,"Transportadora ate"	,"Transportadora ate"	,"mv_ch6","C",06,0,0,"G","","SA4"	,"","","mv_par06","","","","","","","","","","","","","","","","",,,)
//PutSx1(cPerg,"07","Data de"				,"Data de"				,"Data de" 				,"mv_ch7","D",08,0,0,"G","",""		,"","","mv_par07","","","","","","","","","","","","","","","","",,,)
//PutSx1(cPerg,"08","Data Ate"			,"Data Ate"				,"Data Ate"				,"mv_ch8","D",08,0,0,"G","",""		,"","","mv_par08","","","","","","","","","","","","","","","","",,,)

//RETURN

**********************************************************************************************************************************************************************************************************

STATIC FUNCTION CONTAREG()

//CONTAGEM DE REGISTROS

cqry:=" SELECT COUNT(*) AS TOTAL "	+CRLF
cqry+=" FROM "+RETSQLNAME("SC9")+" "                      	    //+CRLF
cqry+=" WHERE "+RETSQLNAME("SC9")+".D_E_L_E_T_ = '' " 			//+CRLF
cqry+=" 	AND C9_FILIAL 	= '"+xFILIAL("SC9")+"' "     		//+CRLF
cqry+="		AND C9_AGREG 	= '"+ALLTRIM(SEP->C9_AGREG)+"' "	//+CRLF
cqry+="		AND C9_CLIENTE 	= '"+ALLTRIM(SEP->C9_CLIENTE)+"' "	//+CRLF
cqry+="		AND C9_LOJA 	= '"+ALLTRIM(SEP->C9_LOJA)+"' "		//+CRLF
cqry+="		AND C9_BLEST    <> '02' "                           //+CRLF
cqry+="		AND C9_NFISCAL 	= '' "								//+CRLF

IF SELECT("CON") > 0
	DBSELECTAREA("CON")
	CON->(DBCLOSEAREA())
ENDIF

DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cqry),"CON",.T.,.T.)

TcSetField("CON","TOTAL","N",04,0)

nQTDTOT := CON->TOTAL

lPrimeiro := .f.

RETURN
