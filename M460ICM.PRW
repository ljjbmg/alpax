#INCLUDE "PROTHEUS.CH"

USER FUNCTION M460ICM()   
                 
//Local _nPCod :=  Ascan(aHeader, { |x| AllTrim(x[2]) == 'C6_PRODUTO' } )
//LOcal _nPTES :=  Ascan(aHeader, { |x| AllTrim(x[2]) == 'C6_TES' } ) 

LOcal _cAlias := IIF( !ALLTRIM(SC5->C5_TIPO) $ "DB" ,"SA1" , "SA2"  )
Local _cCli   := SC5->C5_CLIENTE	
LOcal _cLoj   := SC5->C5_LOJACLI
Local _cCod   := SC6->C6_PRODUTO //acols[n,_nPCod]
Local _nAICM  := _ALIQICM
lOCAL _cTIPO  := SC5->C5_TIPO  
Local _nTRB   := U_alqicm4("NFS",_cAlias,_cCli,_cLoj,_cCod,_nAICM,_cTIPO)  
IF _cTipo <> 'I'                                                                         
if _nTRB <> _ALIQICM
	_ALIQICM := _nTRB
	_VALICM  := _BASEICM*(_ALIQICM/100) 
endif
ENDIF


RETURN(.T.)