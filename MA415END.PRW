#INCLUDE "PROTHEUS.CH"
/*/{Protheus.doc} MA415END
description
@type function
@version  
@author 
@since 23/06/2021
@return return_type, return_description
/*/
User Function MA415END()

Local cMensagem := ''
Local cAliasOrc := GetNextAlias()
Local cNumOrc   := SCJ->CJ_NUM
Local aAreaAtu  := GetArea()

BeginSql Alias cAliasOrc

Select CK_PRODUTO, B1_NOME,
CASE    WHEN B1_XREFRIG = '1' THEN 'Geladeira  '
        WHEN B1_XREFRIG = '2' THEN 'Refrigerado'
        End as REFRIG
FROM  %Table:SCK% SCK (NOLOCK) INNER JOIN  %Table:SCJ% SCJ (NOLOCK)
                            ON CJ_FILIAL = CK_FILIAL AND CJ_NUM = CK_NUM
                            INNER JOIN %Table:SB1% SB1 (NOLOCK) ON CK_PRODUTO = B1_COD 
WHERE CJ_NUM = %exp:cNumOrc% AND  SB1.%NotDel% AND SCJ.%NotDel% AND SCK.%NotDel% 
		AND B1_XREFRIG IN ('1','2')

EndSql

aSql := GetLastQuery()
cSql := aSql[2]
MemoWrite("\queries\orc_refrig.sql",cSql)

	While (cAliasOrc)->(!Eof())
		
		cMensagem += PADR((cAliasOrc)->REFRIG,20) + "-" + (cAliasOrc)->CK_PRODUTO +CHR(10)+CHR(13)
		(cAliasOrc)->(DbSkip())
		
	Enddo
	If !Empty(cMensagem)
	    cCab := "Esse Orcamento contem produtos refrigerados, lista:" +CHR(10)+CHR(13)
		ApMsgAlert(cCab + cMensagem,"Produto(s) Refrigerado(s)")
	End
	(cAliasOrc)->(dbCloseArea())
	RestArea(aAreaAtu)

Return


//cMensagem:= STR0412+CHR(10)+CHR(13) // "Não é possível excluir esse documento pois "
//				cMensagem+= STR0413+CHR(10)+CHR(13) // "sua origem ocorreu no Módulo de Veículos. "
//				cMensagem+= STR0414+CHR(10)+CHR(13) // "Portanto seu Cancelamento só será possível no módulo de Veículos."
//				Help(" ",1,"NAOEXCNFS","NAOEXCNFS",cMensagem,1,0)					
