#include "PROTHEUS.CH"
USER FUNCTION M460MOED()

Local aArea   := GetArea()
Local aAreaB1 := SB1->(getArea())
Local cQry    := ""
Local cAlias  := GetNextAlias()
Local cRet    := ""
Local cParam  := Paramixb
Local cFCIBkp := ""
Local cFCI    := ""
Local cOriBkp := ""
Local cOri    := ""

cRet := cParam

/*
IF !(POSICIONE("SB1",1,xFilial("SB1")+SC9->C9_PRODUTO,"B1_RASTRO") $ "L|S")  //   ALTERADO PARA PEGAR PRODUTOS SEM LOTE E COM FCI
RestArea(aAreaB1)
RestArea(aArea)
RETURN(cRet)
ENDIF
*/

RestArea(aAreaB1)
RestArea(aArea)

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

cQry    := "SELECT TOP 1 D1_FCICOD, D1_CLASFIS "
cQry    += "FROM "+retSqlName("SD1")+" SD1 "
cQry    += "INNER JOIN "+RetSqlName("SF1")+" SF1 "                                                                // ALTERADO POR OCIMAR 27/05/2015
cQry    += "ON SD1.D1_DOC = SF1.F1_DOC AND SD1.D1_SERIE = SF1.F1_SERIE AND SD1.D1_FORNECE = SF1.F1_FORNECE "     // PARA PEGAR SOMENTE AS NOTAS CLASSIFICADAS
cQry    += "WHERE SD1.D_E_L_E_T_     = '' "
cQry    += "      AND D1_COD         = '"+SC9->C9_PRODUTO+"' "
cQry    += "	  AND D1_LOTECTL     = '"+SC9->C9_LOTECTL+"' "
cQry    += "	  AND D1_NUMLOTE     = '"+SC9->C9_NUMLOTE+"'
cQry    += "	  AND D1_DTDIGIT    <= '"+DTOS(dDataBase)+"' "
cQry    += "      AND D1_TIPO IN ('N','D') "                                                                      // FILTRO PARA EXCLUIR NOTAS DE BENEFICIAMENTO
cQry    += "      AND F1_STATUS = 'A' "                                                                           // FILTRO PARA PEGAR SOMENTE CLASSIFICADAS
cQry    += "ORDER BY D1_DTDIGIT DESC "

DBUSEAREA(.T., "TOPCONN", TCGENQRY(,,cQry ), cAlias, .F.,.T.)

cFCIBkp := SC6->C6_FCICOD                                                   

cOriBkp := SC6->C6_CLASFIS
IF (cAlias)->(!EOF())
	cFCI    := ALLTRIM( (cAlias)->D1_FCICOD )
	IF !EMPTY(cFCI)
		cOri    := substr( (cAlias)->D1_CLASFIS, 1,1 ) + substr( cOriBkp, 2,2 )
	ENDIF
ENDIF

if Empty(cFCI)
	cFCI := cFCIBkp
endif

if Empty(cOri)
	cOri := cOriBkp
endif

//If SC6->C6_LOCAL == '01'                   -  RETIRADO PARA PEGAR DE TODOS ARMAZENS
	Reclock("SC6",.F.)
	C6_FCICOD  := cFCI
	C6_CLASFIS := cOri
	SC6->(msunlock())
//EndIf                                      -  RETIRADO PARA PEGAR DE TODOS ARMAZENS

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

RestArea(aAreaB1)
RestArea(aArea)

RETURN(cRet)     
