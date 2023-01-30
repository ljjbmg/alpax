#INCLUDE "PROTHEUS.CH"
/*
==========================================================================================
TRATAMENTO ICMS 4%
FAGNER / BIALE 
31.01.2013

*/

USER FUNCTION M415ICM()

Local _nPCod :=  Ascan(aHeader, { |x| AllTrim(x[2]) == 'CK_PRODUTO' } )
LOcal _nPTES :=  Ascan(aHeader, { |x| AllTrim(x[2]) == 'CK_TES' } )

LOcal _cAlias := "SA1"
Local _cCli   := SCJ->CJ_CLIENTE
LOcal _cLoj   := SCJ->CJ_LOJA
Local _cCod   := TMP1->CK_PRODUTO
Local _nAICM  := _ALIQICM
lOCAL _cTIPO  := "N"
Local _nTRB   := U_alqicm4("NFS",_cAlias,_cCli,_cLoj,_cCod,_nAICM,_cTIPO)


	
	if _nTRB <> _ALIQICM
		_ALIQICM := _nTRB
		_VALICM  := _BASEICM*(_ALIQICM/100)
	endif
	

RETURN(_ALIQICM )



