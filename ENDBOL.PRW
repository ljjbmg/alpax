#INCLUDE "PROTHEUS.CH"
/*
DEFININDO CAMPOS DO BOLETO, ENDERECO COBRANCA
_nEnd 1=sa1;2=su5  -- DESATIVADO OCIMAR
_cDoc=nota fiscal
_cSerie=serie da nota fiscal
_cCampo=ENDERECO/BAIRRO;MUNICIPIO/ESTADO/CEP
*/

USER FUNCTION ENDBOL(_cDoc,_cSerie,_cCampo)

LOcal _cRet := ""
                                         
//-----------------------------------------------
IF SA1->A1_XENDBOL <> "2" // cliente
	do case
		case upper(_cCampo) == "ENDERECO"
			_cRet := SA1->A1_ENDCOB
			
		case upper(_cCampo) == "BAIRRO"
			_cRet := SA1->A1_BAIRROC
			
		case upper(_cCampo) == "MUNICIPIO"
			_cRet := SA1->A1_MUN
			
		case upper(_cCampo) == "ESTADO"
			_cRet := SA1->A1_ESTC
			
		case upper(_cCampo) == "CEP"
			_cRet := SA1->A1_CEPC
		
	endcase

//---------------------------------------	
else // contato
	IF SELECT("TEND")<> 0;DBSELECTAREA("TEND");TEND->(DBCLOSEAREA());ENDIF
	
	BEGINSQL ALIAS "TEND"
		
		SELECT C6_NOTA, C6_NUMORC, CJ.CJ_AXCTATO, ISNULL(U5_END,'') U5_END, ISNULL(U5_BAIRRO,'') U5_BAIRRO
		, ISNULL(U5_MUN,'') U5_MUN , ISNULL(U5_EST,'') U5_EST, ISNULL(U5_CEP,'') U5_CEP
		FROM %TABLE:SC6% C6 (NOLOCK)
		LEFT JOIN %TABLE:SCJ% CJ ON CJ.%NOTDEL% AND CJ_FILIAL = %XFILIAL:SCJ% AND CJ.CJ_NUM = SUBSTRING(C6_NUMORC,1,6)
		LEFT JOIN %TABLE:SU5% U5 ON U5.%NOTDEL% AND U5_FILIAL = %XFILIAL:SU5% AND U5_CODCONT = CJ.CJ_AXCTATO
		WHERE C6.%NOTDEL% AND C6_FILIAL = %XFILIAL:SC6%
		AND C6_NOTA = %EXP:_cDoc%
		AND C6_SERIE = %EXP:_cSerie%		
		
	ENDSQL
	
	IF TEND->(!EOF())
		do case
			case upper(_cCampo) == "ENDERECO"
				_cRet := TEND->U5_END
				
			case upper(_cCampo) == "BAIRRO"
				_cRet := TEND->U5_BAIRRO
				
			case upper(_cCampo) == "MUNICIPIO"
				_cRet := TEND->U5_MUN
				
			case upper(_cCampo) == "ESTADO"
				_cRet := TEND->U5_EST
				
			case upper(_cCampo) == "CEP"
				_cRet := TEND->U5_CEP
		endcase                                                        
	ENDIF
endif


RETURN(_cRet)

