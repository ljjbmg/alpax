#include "protheus.ch"
/*                                                                                       
=========================================================================================
FONTE       : ALPG001
AUTOR       : EDUARDO NAKAMATU / BIALE
DATA        : 31 DE DEZEMBRO DE 2010
OBJETIVO    : DETERMINAR COMISSAO A SER PAGA
ARQUITETURA : GATILHOS, SZQ, SB1, SA3, CAMPOS DE LINHA, FAMILIA, MARCA, COMISSAO
=========================================================================================
*/                           


USER FUNCTION ALPG001(cVend,cProd,nVend,nLista)

Local nRet := getadvfval("SA3","A3_COMIS",XFILIAL("SA3")+cVend,1)   // PEGA COMISSAO DO CADASTRO DO VENDEDOR
Local nPer := IIF(nVend>nLista,0,  ((1-nVend/nLista)*100)   )       // CARCULA MARGEM DE DESCONTO
Local cQry := ""                                                    // CRIACAO DE QUERY DE PESQUISA
Local aArea001 := getarea(), aAreaB1
Local cTab := criatrab(,.f.)                   
                                                                                                                         

// LIMPA AREA TEMPORARIA
IF SELECT("TTMP") <> 0
	DBSELECTAREA("TTMP")
	DBCLOSEAREA("TTMP")
ENDIF

// POSICIONA PRODUTO PARA BUSCA DE DADOS
dbselectarea("SB1") 
aAreaB1 := getarea() 
dbsetorder(1)
dbgotop()
IF !DBSEEK(XFILIAL("SB1")+ALLTRIM(cProd))
	Alert("Falha ao definir produto!")
	Return(0)
ENDIF                                   

                                              
// PESQUISA NA BASE DE DADOS
cQry := "   SELECT ZQ_VEND, ZQ_DSVEND, ZQ_LINHA, ZQ_FAMILIA, ZQ_MARCA, CAST(ZQ_PMINIMO AS NUMERIC(17,5)) ZQ_PMINIMO, CAST(ZQ_PMAXIMO  AS NUMERIC(17,5)) ZQ_PMAXIMO, CAST( ZQ_COMISSA  AS NUMERIC(17,5)) ZQ_COMISSA  "+CRLF
cQry += "      ,  SZQ.D_E_L_E_T_ , SZQ.R_E_C_N_O_   "+CRLF
cQry += "   FROM "+RETSQLNAME("SZQ")+" SZQ (NOLOCK)   "+CRLF
cQry += "   LEFT JOIN "+retsqlname("SZ1")+" SZ1 (NOLOCK) ON SZ1.D_E_L_E_T_ = '' AND SZ1.Z1_CODLIN = SZQ.ZQ_LINHA   "+CRLF
cQry += "   WHERE SZQ.D_E_L_E_T_ = ''   "+CRLF
cQry += "     AND SZQ.ZQ_VEND = '"+alltrim(cVend)+"'   "+CRLF
cQry += "     AND (SZ1.Z1_DESCR LIKE '"+ALLTRIM(SB1->B1_AXLINHA)+"') " // OR SZ1.Z1_DESCR = '')    "+CRLF
//=============
// DESATIVADO ATE CRIACAO - cQry += "     AND (SZQ.ZQ_FAMILIA LIKE '%%'    OR SZQ.ZQ_FAMILIA = '' )    "+CRLF
cQry += "     AND (SZQ.ZQ_MARCA LIKE '"+ALLTRIM(SB1->B1_MARCA)+"') " //    OR SZQ.ZQ_MARCA = '')    "+CRLF
cQry += "     AND "+alltrim(str(nPer))+" BETWEEN SZQ.ZQ_PMINIMO AND SZQ.ZQ_PMAXIMO   "+CRLF
cQry += "   ORDER BY  ZQ_VEND, ZQ_FAMILIA, ZQ_LINHA, ZQ_MARCA    "+CRLF
MEMOWRIT("D:\A\ALPG001.SQL",cQry) 
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry),"TTMP",.F.,.T.)
DBSELECTAREA("TTMP")
DBGOTOP()

IF TTMP->(!EOF()) 
	nRet := TTMP->ZQ_COMISSA
ENDIF

IF SELECT("TTMP") <> 0
	DBSELECTAREA("TTMP")
	DBCLOSEAREA("TTMP")
	//TCSQLEXEC("DROP TABLE "+cTab)
ENDIF
                    
restarea(aAreaB1)
restarea(aArea001)


return(nRet)

