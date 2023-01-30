#include "protheus.ch"
/*
==========================================================================================
FONTE       : ICMSD1()
OBJETIVO    : ALTERACAO DA ALIQUOTA DE ICMS CONFORME REGRA DEFINIDA PELA EMPRESA
PARA CONTEMPLAR A LEI DE PADRONIZACAO DE ICMS ENTRE OS ESTADOS NOS PRODUTOS
IMPOSTADOS
AUTOR       : EDUARDO NAKAMATU
PARAMETROS  : NAO TEM
=========================================================================================
NOTA
1) ESTA ROTINA EH CHAMADA EM 3 FRENTES
GATILHO NA TES U_ICMSD1("G")
MT100LOK()
MT100TOK()

2) UTILIZANDO PARAMETROS
MV_ORIGSD1 = RELACIONADO AS ORIGENS DE PRODUTOS TRATADOS NAS NOTAS DE ENTRADA
MV_ORIGSD2 = RELACIONADO AS ORIGENS DE PRODUTOS TRATADOS NAS NOTAS DE SAIDA
MV_ESTADO  = ESTADO/UF DA OPERACAO DA EMPRESA
MV_TIPONFE = TIPO DE DOCUMENTO TRATADO NAS NOTAS DE ENTRADA
MV_TIPONFS = TIPO DE DOCUEMNTO TRATADO NAS NOTAS DE SAIDA
MV_DTICM4P = DATA INICIO DO ICMS 4 PORCENTO
MV_ICM4CLI = TIPOS DE CLIENTES QUE SERAO TRATADOS COM ICMS 4%

=========================================================================================
------------------------------------------------------------------------------------------
17.12.12 : IMPLANTACAO, TESTES E HOMOLOGACAO
19.12.12 : EDUARDO
ALTERADO TRATAMENTO PARA ANALISAR SE EH CLIENTE/FORNECEDOR INTERNACIONAL.
REALIZANDO TRATAMENTO PARA CHAMADA VA EXECAUTO NAS ROTINAS DE RETORNO DAS NOTAS DE SAIDA
20.12.12 : CRIADO PARAMETRO MV_ICM4CLI, se T trata A1_CONTRIB = "1", se F passa todos clientes

------------------------------------------------------------------------------------------
*/

USER FUNCTION ICMSD1(_xParam)


//-----|| VERIFICANDO POSICAO DOS CAMPOS DENTRO DO ACOLS CONFORME AHEADER
Local _nPCod :=  Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_COD' } )
LOcal _nPTES :=  Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_TES' } )
LOcal _nPTIPO := Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_TIPO' } )
Local _nPBICM := Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_BASEICM' } )
Local _nPAICM := Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_PICM' } )
Local _nPVICM := Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_VALICM' } )

Local _nPNFORI   := Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_NFORI' } )
Local _nPSERIORI := Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_SERIORI' } )
Local _nPITEMORI := Ascan(aHeader, { |x| AllTrim(x[2]) == 'D1_ITEMORI' } )


//-----|| PEGANDO CONTEUDO DOS CAMPOS NO ACOLS
Local _cCod := aCols[n,_nPCod]     // PRODUTO
Local _cDoc := CNFISCAL            // NF
Local _cSer := CSERIE              // SERIE
LOcal _cFOR := CA100FOR           // FORNECEDOR
LOcal _cLOJ := CLOJA                // LOJA
LOcal _cTES := aCols[n,_nPTES]     // TES
LOcal _cTIPO := cTipo           // TIPO DOC
Local _nBICM := aCols[n,_nPBICM]    // BASE ICMS
Local _nAICM := aCols[n,_nPAICM]   // ALIQUOTA ICMS
Local _nVICM := aCols[n,_nPVICM]   // VALOR ICMS
Local _cNFORI  := aCols[n,_nPNFORI]
loCAL _cSerOri := aCols[n,_nPSERIORI]
loCAL _cITEMORI := aCols[n,_nPITEMORI]

//-----|| variaveis para operacao
LOcal _cAlias := IIF(_cTIPO$"DB","SA1","SA2")  // VERIFICANDO SE EH CLIENTE OU FORNECEDOR
Local _nAlqICM := 0                            // CALCULANDO A ALIQUOTA
Private _xForma := _xParam



DO CASE
	
	CASE UPPER(ALLTRIM(_xForma)) == "GDB"
		
		_aArea1 := GetArea()
		DBSELECTAREA("SD2")
		_aArea2 := GetArea()
		dbsetorder(3)
		dbgotop()
		//		INDICE 3 	D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_
		IF DBSEEK(XFILIAL("SD2")+_cNFORI+_cSerOri+_cFOR+_cLoj+_cCod+_cITEMORI)
			_nAlqICM := SD2->D2_PICM
			acols[n,_nPAICM] := _nAlqICM
			M->D1_PICM       := _nAlqICM
			MaFisRef("IT_ALIQICM","MT100",M->D1_PICM)
			RESTAREA(_aArea2)
			RESTAREA(_aArea1)
		ELSE
			_nAlqICM := 0//QSD2->D2_PICM
			acols[n,_nPAICM] := _nAlqICM
			M->D1_PICM       := _nAlqICM
			MaFisRef("IT_ALIQICM","MT100",M->D1_PICM)
			RESTAREA(_aArea2)
			RESTAREA(_aArea1)
			
		ENDIF
		
	CASE  UPPER(ALLTRIM(_xForma)) == "L"
		
		IF alltrim(procname( 6 )) == "MSGETDAUTO"   // 19.12.12 - EDUARDO BIALE tratamento para retorno que usa execauto
			_aArea1 := GetArea()
			DBSELECTAREA("SD2")
			_aArea2 := GetArea()
			dbsetorder(3)
			dbgotop()
			//		INDICE 3 	D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_
			IF DBSEEK(XFILIAL("SD2")+_cNFORI+_cSerOri+_cFOR+_cLoj+_cCod+_cITEMORI)
				_nAlqICM := SD2->D2_PICM
				acols[n,_nPAICM] := _nAlqICM
				M->D1_PICM       := _nAlqICM
				MaFisRef("IT_ALIQICM","MT100",M->D1_PICM)
				RESTAREA(_aArea2)
				RESTAREA(_aArea1)
			ENDIF
			
		ELSE
			_nAlqICM := U_alqicm4("NFE",_cAlias,_cFor,_cLoj,_cCod,_nAICM,_cTIPO)
			if _nAlqICM <> 0 // se retornou zero eh porque nao deve calcular
				acols[n,_nPAICM] := _nAlqICM
				M->D1_PICM       := _nAlqICM
				MaFisRef("IT_ALIQICM","MT100",M->D1_PICM)
			ENDIF
		endif
		
	CASE  UPPER(ALLTRIM(_xForma)) == "G"
		
		IF alltrim(procname( 2 )) <> "MSGETDAUTO"   // 19.12.12 - EDUARDO BIALE tratamento para retorno que usa execauto
			_nAlqICM := U_alqicm4("NFE",_cAlias,_cFor,_cLoj,_cCod,_nAICM,_cTIPO)
			if _nAlqICM <> 0 // se retornou zero eh porque nao deve calcular
				acols[n,_nPAICM] := _nAlqICM
				M->D1_PICM       := _nAlqICM
				MaFisRef("IT_ALIQICM","MT100",M->D1_PICM)
			ENDIF
		endif
		
	CASE  UPPER(ALLTRIM(_xForma)) = "T"
		
		IF alltrim(procname( 6 )) == "MSGETDAUTO"   // TRATAMENTO DE RETORNO DA NF DE SAIDA QUE USA EXECAUTO
			N_OLD := N
			FOR X := 1 TO LEN(ACOLS)
				// VARIAVEIS DE AMVBIENTE PARA CALCULO TOTAL
				N := X
				M->D1_COD      := aCols[n,_nPCOD]
				M->D1_TES      := aCols[n,_nPTES]
				M->D1_BASEICM  := aCols[n,_nPBICM]
				M->D1_PICM     := aCols[n,_nPAICM]
				M->D1_VALICM   := aCols[n,_nPVICM]
				M->D1_NFORI    := aCols[n,_nPNFORI]
				M->D1_SERORI   := aCols[n,_nPSERIORI]
				M->D1_ITEMORI  := aCols[n,_nPITEMORI]
				
				_aArea1 := GetArea()
				DBSELECTAREA("SD2")
				_aArea2 := GetArea()
				dbsetorder(3)
				dbgotop()
				//		INDICE 3 	D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_
				IF DBSEEK(XFILIAL("SD2")+M->D1_NFORI+M->D1_SERORI+_cFOR+_cLoj+M->D1_COD+_cITEMORI+M->D1_ITEMORI)
					_nAlqICM := SD2->D2_PICM
					acols[n,_nPAICM] := _nAlqICM
					M->D1_PICM       := _nAlqICM
					MaFisRef("IT_ALIQICM","MT100",M->D1_PICM)
					RESTAREA(_aArea2)
					RESTAREA(_aArea1)
				ENDIF
				
			NEXT
			N := N_OLD
			
		ELSE
			N_OLD := N
			FOR X := 1 TO LEN(ACOLS)
				// VARIAVEIS DE AMVBIENTE PARA CALCULO TOTAL
				N := X
				M->D1_COD      := aCols[n,_nPCOD]
				M->D1_TES      := aCols[n,_nPTES]
				M->D1_BASEICM  := aCols[n,_nPBICM]
				M->D1_PICM     := aCols[n,_nPAICM]
				M->D1_VALICM   := aCols[n,_nPVICM]
				_nAlqICM := U_alqicm4("NFE",_cAlias,_cFor,_cLoj,M->D1_COD,aCols[n,_nPAICM],_cTIPO)
				acols[n,_nPAICM] := _nAlqICM
				M->D1_PICM       := _nAlqICM
				MaFisRef("IT_ALIQICM","MT100",M->D1_PICM)
			NEXT
			N := N_OLD
		ENDIF
		
	OTHERWISE
		FINAL("ERRO NO CALCULO DO ICMS 4%")
ENDCASE


return(_nAlqICM)



/*
==========================================================================================
FONTE       : ALQICM4()
OBJETIVO    : DEFINE ALIQUOTA DE ICMS DE 4% PARA AS OPERACOES CONFORME PARAMETROS
AUTOR       : EDUARDO NAKAMATU
PARAMETROS  : _nNF    = se "NFE" ou "NFS" (ENTRADA OU SAIDA)
_cAlias = se "SA1" ou "SA2"
_cCod   = Codigo do cliente ou fornecedor
_cLoj   = LOJA do Cliente ou fornecedor
_cProd  = Codigo do Cliente
_nPICM_S = ICMS Padrao
_cTpDoc  = Tipo do Documento de entrada ou saida

EMPRESA     : BUNZL - PROTCAP
KEYUSER     : BRUNO / FISCAL
=========================================================================================
NOTA
1) UTILIZANDO PARAMETROS
MV_ORIGNFE = RELACIONADO AS ORIGENS DE PRODUTOS TRATADOS NAS NOTAS DE ENTRADA
MV_ORIGNFS = RELACIONADO AS ORIGENS DE PRODUTOS TRATADOS NAS NOTAS DE SAIDA
MV_ESTADO  = ESTADO/UF DA OPERACAO DA EMPRESA
MV_TIPONFE = TIPO DE DOCUMENTO TRATADO NAS NOTAS DE ENTRADA
MV_TIPONFS = TIPO DE DOCUEMNTO TRATADO NAS NOTAS DE SAIDA

------------------------------------------------------------------------------------------
17.12.12 : IMPLANTACAO, TESTES E HOMOLOGACAO

------------------------------------------------------------------------------------------
*/


USER FUNCTION ALQICM4(_cNF,_cAlias,_cCod,_cLoja,_cProd,_nPICM_S,_cTpDoc)

// DEFINICAO DE VARIAVEIS DE MEMORIA
Local _nIcm    := 0                          // ALIQUOTA DE ICMS QUE SERA CRIADA
LOcal _cOriSD1 := getmv("MV_ORIGNFE")        // ORIGENS DE PRODUTOS PARA NOTAS DE ENTRADA
Local _cOriSD2 := getmv("MV_ORIGNFS")        // ORIGEMS DE PRODUTOS PARA NOTAS DE SAIDA
Local _cTIPONFE  := GETMV("MV_TIPONFE")         // TIPOS DE DOCUMENTOS TRATADOS NAS NOTAS DE ENTRADA
Local _cTIPONFS  := GETMV("MV_TIPONFS")         // TIPOS DE DOCUMENTOS TRATADOS NAS NOTAS DE SAIDA
DEFAULT _nPICM_S := GETMV("MV_ICMPAD")       // ICMS PADRAO


IF ddatabase < GETMV("MV_DTICM4P")
	return(_nPICM_S) // nao calcula
	RETURN
ENDIF

IF _cNF == "NFE"
	IF !_cTpDoc $ _cTIPONFE
		return(_nPICM_S)
	ENDIF
	
ELSEIF _cNF == "NFS"
	IF !_cTpDoc $ _cTIPONFS
		return(_nPICM_S)
	ENDIF
ELSE
	FINAL("FALHA NO CALCULO ICMS4 PROTCAP!")
ENDIF


//----------------------------------------------------------------
// ANALISANDO NA SB1 - FERIFICANDO ORIGEM
//----------------------------------------------------------------

dbselectarea("SB1")
dbsetorder(1)
DBGOTOP()
IF DBSEEK(XFILIAL("SB1")+ALLTRIM(_CPROD))
	_cOrigem := ALLTRIM(SB1->B1_ORIGEM)
ELSE
	_cOrigem = "X"
ENDIF

*
//----------------------------------------------------------------
// ANALISANDO NA SA1/SA2 CONFORME OPERACAO
//----------------------------------------------------------------

DO CASE
	CASE ALLTRIM(_cAlias) == "SA1"
		dbselectarea("SA1")
		dbsetorder(1)
		dbgotop()
		
		CONOUT(_CPROD)
		if dbseek(XFILIAL("SA1")+_cCod+_cLoja)
			if _cOrigem $ _cOriSD2 .and. IIF(GETMV("MV_ICM4CLI"),SA1->A1_CONTRIB == "1",.T.)
				IF !ALLTRIM(SA1->A1_EST) $ (ALLTRIM(GETMV("MV_ESTADO")))
					_nIcm := 4
				ELSE
					_nIcm := _nPICM_S
				ENDIF
			else
				_nIcm := _nPICM_S
			endif
		else
			_nIcm := _nPICM_S
		endif
		
	CASE ALLTRIM(_cAlias) == "SA2"
		dbselectarea("SA2")
		dbsetorder(1)
		dbgotop()
		if dbseek(XFILIAL("SA2")+_cCod+_cLoja)
			if _cOrigem $ _cOriSD2
				IF !ALLTRIM(SA2->A2_EST) $ (ALLTRIM(GETMV("MV_ESTADO"))+"EX")
					_nIcm := 4
				ELSE                           
					_nIcm := _nPICM_S
				ENDIF
			else
				_nIcm := _nPICM_S
			endif
		else
			_nIcm := _nPICM_S
		endif
	OTHERWISE
		_nIcm := _nPICM_S
		
ENDCASE


return(_nIcm)
