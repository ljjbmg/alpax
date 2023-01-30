#INCLUDE "PROTHEUS.CH"

/*
AUTOR	: ANDERSON BIALE
DATA	: 01/08/12
DESC	: PONTO DE ENTRADA NA GRAVACAO DOS ITENS DA NF DE SAIDA, USADO PARA GRAVAR O CODIGO DE BARRAS DE SEPARACAO DA SC9(PEDIDOS LIBERADOS) PARA SD2(ITENS DA NF DE SAIDA)
*/

USER FUNCTION MSD2460()

LOCAL nPESO		:= 0
LOCAL nCAIXA  	:= 0
   
//**** TRATANDO COMISSAO
SD2->D2_COMIS1 := SC6->C6_COMIS1




SD2->D2_CODBAR := ALLTRIM(SC9->C9_CODBAR)	//RECEBE CODIGO DE BARRAS DE SEPARACAO
SF2->F2_IDENT  := ALLTRIM(SC9->C9_CODBAR)   //ALLTRIM(SC9->C9_IDENT) 	// Por Fagner em 12/03/2013

cQRY:=" SELECT DISTINCT(ZBC_CAIXA) , ZBC_PESO, ZBC_LOCAL  " 
cQRY+=" FROM "+RETSQLNAME("ZBC")+" AS ZBC (NOLOCK) "
cQRY+=" WHERE ZBC.D_E_L_E_T_ = '' "
cQRY+=" AND ZBC_CODSEP = '"+ALLTRIM(SC9->C9_CODBAR)+"' "
IF SELECT("PES") > 0                                            	//SE ALIAS ABERTO
	DBSELECTAREA("PES")                                           	//SELECIONA ALIAS
	PES->(DBCLOSEAREA())                                          	//FECHA
ENDIF                                                              	//FIM         
DBUSEAREA(.T.,"TOPCONN",TCGENQRY(,,cQRY),"PES",.F.,.F.)			//ABRINDO ALIAS SOM ---------------
                                             
PES->(DBGOTOP())
_cLocal := ""
WHILE PES->(!EOF())
	
	nPESO 	+=  PES->ZBC_PESO
	nCAIXA	:=	PES->ZBC_CAIXA

    if !alltrim(PES->ZBC_LOCAL) $ _cLocal
    	_cLocal += alltrim(PES->ZBC_LOCAL) + " | "
    ENDIF

	PES->(DBSKIP())
ENDDO         

//nPESO	:= VAL(STRTRAN(nPESO,",","."))        

_cLocal := substr(_cLocal,1,len(_cLocal)-3) 

SF2->F2_VOLUME1 := nCAIXA
SF2->F2_ESPECI1	:= "VOLUME(S)"
SF2->F2_PLIQUI	:= nPESO
SF2->F2_PBRUTO	:= nPESO    
SF2->F2_AXBOX   := _cLocal

//UPDATE PARA GRAVAR O NUM DA NF NA TABELA AUXILIAR ZBC(SEPARACAO X CAIXA) ----------------------------------------------------------
cUPD:=" UPDATE "+RETSQLNAME("ZBC")+" SET ZBC_NOTA = '"+ALLTRIM(SD2->D2_DOC)+"', ZBC_SERIE = '"+ALLTRIM(SD2->D2_SERIE)+"' "	+CRLF  
cUPD+=" FROM "+RETSQLNAME("ZBC")+" "                      																		+CRLF
cUPD+=" WHERE "+RETSQLNAME("ZBC")+".D_E_L_E_T_ = '' " 																			+CRLF      	
cUPD+=" 	AND ZBC_FILIAL = '"+xFILIAL("ZBC")+"' "     																		+CRLF
cUPD+="		AND ZBC_CODSEP = '"+ALLTRIM(SC9->C9_CODBAR)+"' "    																+CRLF
TCSQLEXEC(cUPD)

RETURN 