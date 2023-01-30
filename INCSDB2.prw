#INCLUDE "PROTHEUS.CH"

USER FUNCTION INCSDB2() 	//U_INCSDB2()
	
/*
AUTOR	: ANDERSON BIALE
DATA	: 22/11/12
DESC	: FUNCAO PARA GRAVAR SDB ROTINA DE "CRIA ENDERECOS", CUSTOMIZADO COM BASE NA FUNCAO PADRAO DO SIGA DEVIDO AO NAO EXISTIR RECLOCK PARA FUNCAO  
OBS		: PARA PRODUTOS QUE CONTROLAM LOTE
*/

LOCAL cNumSeq:=ProxNum(),i
LOCAL cCounter	:=	StrZero(0,TamSx3('DB_ITEM')[1])
LOCAL cDOC		:= ""
LOCAL nDOC		:= 0

cCounter := Soma1(cCounter)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿎ria registro de movimentacao por Localizacao (SDB)           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//PRODUTOS <> LOTE <> EQUIPAMENTOS COM SALDO EM ESTOQUE --------------------------
cQRY:=" SELECT B8_PRODUTO, B8_LOCAL, B8_SALDO, B8_LOTECTL, B1_CONV, B1_TIPCONV, (B1_CONV*B8_SALDO) CONV "	+CRLF
cQRY+=" FROM "+RETSQLNAME("SB8")+" AS B8 (NOLOCK) "                                                       	+CRLF
cQRY+=" LEFT JOIN "+RETSQLNAME("SB1")+" AS B1 (NOLOCK) ON B1_COD = B8_PRODUTO "                           	+CRLF
cQRY+=" WHERE B8.D_E_L_E_T_ = '' AND B1.D_E_L_E_T_ = '' "                                                  	+CRLF
cQRY+=" AND B1_FILIAL = '"+xFILIAL("SB1")+"' "                             									+CRLF
cQRY+=" AND B8_FILIAL = '"+xFILIAL("SB8")+"' "																+CRLF                                	
cQRY+=" AND B8_SALDO > 0 "                                                                                	+CRLF
cQRY+=" AND B1_AXLINHA <> 'EQUIPAMENTOS' "                                                                	+CRLF
cQRY+=" AND B1_RASTRO = 'L' "                                                                             	+CRLF 
//cQRY+=" AND B8_PRODUTO = '011337866117EFI' "
//cQRY+=" AND B8_LOCAL = '01' "
IF SELECT("INC") > 0											//SE ALIAS ESTIVER ABERTO
	DBSELECTAREA("INC")    										//SELECIONA ALIAS
	INC->(DBCLOSEAREA()) 										//FECHA ALIAS
ENDIF                        									//FIM
DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQRY),"INC",.T.,.T.)

AUTOGRLOG("DOCUMENTO"+";SERIE"+";PRODUTO"+";LOCAL"+";QUANT"+";LOTE")	//LOG DE GRAVACAO

INC->(DBGOTOP())
nDOC := 6153
WHILE INC->(!EOF())
	
	cDOC := "INV"+STRZERO(nDOC,6)																		//NUM DOC EX:"INV000001"		
	DBSELECTAREA("SDB")               																	//MOVIMENTOS DE DISTRIBUICAO
	DBSETORDER(2)																						//FILIAL + PRODUTO + LOCAL + LOTECTL
	IF !DBSEEK(xFILIAL("SDB")+ALLTRIM(INC->B8_PRODUTO)+ALLTRIM(INC->B8_LOCAL)+ALLTRIM(INC->B8_LOTECTL))	//SE NAO EXISTIR 
	  	
	  	AUTOGRLOG(cDOC+";1;"+ALLTRIM(INC->B8_PRODUTO)+";"+ALLTRIM(INC->B8_LOCAL)+";"+cVALTOCHAR(INC->B8_SALDO)+";"+ALLTRIM(INC->B8_LOTECTL))  
		CriaSDB(ALLTRIM(INC->B8_PRODUTO),;	// Produto
				ALLTRIM(INC->B8_LOCAL)	,;	// Armazem                        		
				INC->B8_SALDO			,;	// Quantidade
				"LOCAL"					,;	// Localizacao
				""						,;	// Numero de Serie
				cDOC					,;	// Doc
				"1"						,;	// Serie
				""						,;	// Cliente / Fornecedor
				""						,;	// Loja
				""						,;	// Tipo NF
				"ACE"					,;	// Origem do Movimento
				dDataBase				,;	// Data
				ALLTRIM(INC->B8_LOTECTL),;	// Lote
				""						,; 	// Sub-Lote
				cNumSeq					,;	// Numero Sequencial
				"499"					,;	// Tipo do Movimento
				"M"						,;	// Tipo do Movimento (Distribuicao/Movimento)
		   		cCounter				,;	// Item
		   		.F.						,;	// Flag que indica se e' mov. estorno
		   		0						,;	// Quantidade empenhado
		   		INC->CONV				)	// Quantidade segunda UM
		GravaSBF("SDB")
	
		nDOC ++                           	//PROXIMO NUMERO DOCUMENTO
	
	ELSE
		//NAO GRAVA PQ JA EXISTE NO SDB
	ENDIF
	
	INC->(DBSKIP())
ENDDO
		
MOSTRAERRO()
	
RETURN(NIL)