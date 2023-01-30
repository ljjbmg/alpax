#INCLUDE "PROTHEUS.CH"

USER FUNCTION INCSDB1() 	//U_INCSDB1()
	
/*
AUTOR	: ANDERSON BIALE
DATA	: 22/11/12
DESC	: FUNCAO PARA GRAVAR SDB ROTINA DE "CRIA ENDERECOS", CUSTOMIZADO COM BASE NA FUNCAO PADRAO DO SIGA DEVIDO AO NAO EXISTIR RECLOCK PARA FUNCAO  
OBS		: PARA PRODUTOS QUE NAO CONTROLAM LOTE E NEM SиRIE
*/

LOCAL cNumSeq:=ProxNum(),i
LOCAL cCounter	:=	StrZero(0,TamSx3('DB_ITEM')[1])
LOCAL cDOC		:= ""
LOCAL nDOC		:= 0


cCounter := Soma1(cCounter)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁCria registro de movimentacao por Localizacao (SDB)           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

//PRODUTOS <> LOTE <> EQUIPAMENTOS COM SALDO EM ESTOQUE --------------------------
cQRY:=" SELECT B1_COD, B1_DESC, B2_LOCAL, B2_QATU, B1_AXLINHA, B1_RASTRO   "	+CRLF
cQRY+=" FROM "+RETSQLNAME("SB1")+" AS B1 (NOLOCK) "                            	+CRLF	
cQRY+=" LEFT JOIN "+RETSQLNAME("SB2")+" AS B2 (NOLOCK) ON B1_COD = B2_COD "		+CRLF
cQRY+=" WHERE B1.D_E_L_E_T_ = '' AND B2.D_E_L_E_T_ = '' "                    	+CRLF   	
cQRY+=" AND B1_FILIAL = '"+xFILIAL("SB1")+"' "                             		+CRLF
cQRY+=" AND B2_FILIAL = '"+xFILIAL("SB2")+"' "									+CRLF                                	
cQRY+=" AND B1_AXLINHA <> 'EQUIPAMENTOS' "                                   	+CRLF 	
cQRY+=" AND B1_RASTRO <> 'L' "                                            		+CRLF
cQRY+=" AND B2_QATU > 0 "                                                  		+CRLF
//cQRY+=" AND B1_COD = '130243759349628' "                                      	+CRLF
//cQRY+=" AND B2_LOCAL = '01' "                                                  	+CRLF

IF SELECT("INC") > 0											//SE ALIAS ESTIVER ABERTO
	DBSELECTAREA("INC")    										//SELECIONA ALIAS
	INC->(DBCLOSEAREA()) 										//FECHA ALIAS
ENDIF                        									//FIM
DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"INC",.T.,.T.)

AUTOGRLOG("DOCUMENTO"+";SERIE"+";PRODUTO"+";LOCAL"+";QUANT")	//LOG DE GRAVACAO

INC->(DBGOTOP())
nDOC := 4608
WHILE INC->(!EOF())
	
	
	cDOC := "INV"+STRZERO(nDOC,6)											//NUM DOC EX:"INV000001"		
	DBSELECTAREA("SDB")               										//MOVIMENTOS DE DISTRIBUICAO
	DBSETORDER(2)															//FILIAL + PRODUTO + LOCAL + LOTECTL
	IF !DBSEEK(xFILIAL("SDB")+ALLTRIM(INC->B1_COD)+ALLTRIM(INC->B2_LOCAL))	//SE NAO EXISTIR 
	   
		AUTOGRLOG(cDOC+";1;"+ALLTRIM(INC->B1_COD)+";"+ALLTRIM(INC->B2_LOCAL)+";"+cVALTOCHAR(INC->B2_QATU))  //LOG DE GRAVACAO
	
		CriaSDB(ALLTRIM(INC->B1_COD)	,;	// Produto
				ALLTRIM(INC->B2_LOCAL)	,;	// Armazem
				INC->B2_QATU			,;	// Quantidade
				"LOCAL"					,;	// Localizacao
				""						,;	// Numero de Serie
				cDOC					,;	// Doc
				"1"						,;	// Serie
				""						,;	// Cliente / Fornecedor
				""						,;	// Loja
				""						,;	// Tipo NF
				"ACE"					,;	// Origem do Movimento
				dDataBase				,;	// Data
				""						,;	// Lote
				""						,; 	// Sub-Lote
				cNumSeq					,;	// Numero Sequencial
				"499"					,;	// Tipo do Movimento
				"M"						,;	// Tipo do Movimento (Distribuicao/Movimento)
		   		cCounter				,;	// Item
		   		.F.						,;	// Flag que indica se e' mov. estorno
		   		0						,;	// Quantidade empenhado
		   		0						)	// Quantidade segunda UM
		GravaSBF("SDB")
		nDOC ++                           	//PROXIMO NUMERO DOCUMENTO
	
	ELSE
	 	//NAO GRAVA PQ JA EXISTE NO SDB
	ENDIF	
	
	INC->(DBSKIP())
ENDDO

IF SELECT("INC") > 0											//SE ALIAS ESTIVER ABERTO
	DBSELECTAREA("INC")    										//SELECIONA ALIAS
	INC->(DBCLOSEAREA()) 										//FECHA ALIAS
ENDIF                        									//FIM

MOSTRAERRO()		
	
RETURN(NIL)