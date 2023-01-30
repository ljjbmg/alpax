#include "protheus.ch"
#include "tbiconn.ch"

user function tstsefaz()

Private _cEmp := "01" // empresa
Private _cFil  := "01" // FILIAL

Private cAmbiente := "1"
Private cVersao := "3.10"
Private cAliasSF3 := GetNextAlias()

Private _cNF := "000183397"
Private cSerie := "1"
Private cNotaIni :=  cNotaFim := _cNF

Private aNotas := {}
Private aNotasOri := {}
Private aMotivoCont := {}


IF SELECT("SX6") == 0
	PREPARE ENVIRONMENT EMPRESA _cEmp FILIAL _cFil MODULO "FAT"
ENDIF

_cQry := retQuery( .F., cNotaIni, cNotaFim, cSerie )
_cQry := ChangeQuery( _cQry )
dbUseArea( .T., "TOPCONN", TCGenQry(,,_cQry), cAliasSF3, .F., .T.)
TcSetField(cAliasSF3,"F3_ENTRADA","D",08,0)
TcSetField(cAliasSF3,"F3_DTCANC","D",08,0)


// NF SAIDA

IF (cAliasSF3)->(!EOF())
	aadd(aNotas,{})
	nX := Len(aNotas)
	aadd(aNotas[nX],IIF((cAliasSF3)->F3_CFO<"5","0","1"))
	aadd(aNotas[nX],(cAliasSF3)->F3_ENTRADA)
	aadd(aNotas[nX],(cAliasSF3)->F3_SERIE)
	aadd(aNotas[nX],(cAliasSF3)->F3_NFISCAL)
	aadd(aNotas[nX],(cAliasSF3)->F3_CLIEFOR)
	aadd(aNotas[nX],(cAliasSF3)->F3_LOJA)
	aadd(aNotas[nX],aMotivoCont)
	aadd(aNotasOri,{})
	nX := Len(aNotasOri)
	aadd(aNotasOri[nX],(cAliasSF3)->F3_NFISCAL)
	aadd(aNotasOri[nX],(cAliasSF3)->F3_SERIE)
	
	ExecBlock("XmlNFeSef",.F.,.F.,{aNotas[nX],cVersao,cAmbiente,{"",""}})
ENDIF
                                  



FINAL("FIM DO TSTSEFAZ!")

return(.t.)





static Function retQuery( lAutoNFe, cNotaIni, cNotaFim, cSerie, cModelo )

local nDias 		:= 60 // Tratamento para performance da query, monitorar apenas 60 dias antes da data-base
Local cQuery		:= ""
Local cEspecie		:= ""
local cBanco 			:= Alltrim(Upper(TCGetDb()))
local dDatabase	:= Date()
local dDatafil	:= SToD ("  /  /  ")

Default lAutoNFe	:= .F.
Default cModelo		:= "55"

dDatafil := (dDataBase-nDias)

//-- Montagem da query
cQuery := "SELECT F3_FILIAL, F3_ENTRADA, F3_NFeLETR, F3_CFO, F3_FORMUL, F3_NFISCAL, F3_SERIE, F3_CLIEFOR, "
cQuery += "F3_LOJA, F3_ESPECIE, F3_DTCANC, F3_OBSERV, F3_CHVNFE, F3_CODNFE "
cQuery += "FROM " + RetSqlName("SF3") + " "
cQuery += "WHERE F3_FILIAL = '" + xFilial("SF3") + "' AND "
If SubStr(cBanco,1,6) == "ORACLE"
	cQuery += "((SUBSTR(F3_CFO,1,1) < '5' AND F3_FORMUL = 'S') OR (SUBSTR(F3_CFO,1,1) >= '5')) AND "
Else
	cQuery += "((SUBSTRING(F3_CFO,1,1) < '5' AND F3_FORMUL = 'S') OR (SUBSTRING(F3_CFO,1,1) >= '5')) AND "
EndIf
cQuery += "F3_SERIE = '" + cSerie + "' AND "

If lAutoNFe
	
	If cModelo == "55"
		cEspecie := "SPED"
	Else
		cEspecie := "CTE"
	Endif
	
	cQuery += "F3_ESPECIE = '" + cEspecie + "' AND "
	
	If SF3->(FieldPos("F3_CODRET")) > 0
		If SubStr(cBanco,1,6) == "ORACLE"
			cQuery += "F3_CODRET = ' ' AND "
		Else
			cQuery += "F3_CODRET = '' AND "
		EndIf
	Endif
	
	If SF3->(FieldPos("F3_CODRSEF")) > 0
		If SubStr(cBanco,1,6) == "ORACLE"
			cQuery += "F3_CODRSEF = ' ' AND "
		Else
			cQuery += "F3_CODRSEF = '' AND "
		EndIf
	Endif
	
	cQuery += "F3_ENTRADA >= '" + Dtos(dDatafil) + "' AND
	cQuery += "F3_DTCANC = '" + Space(8) + "' AND "
	If SubStr(cBanco,1,6) == "ORACLE"
		cQuery += "D_E_L_E_T_ = ' ' "
	Else
		cQuery += "D_E_L_E_T_ = '' "
	EndIf
	cQuery += "ORDER BY F3_NFISCAL"
	
Else
	
	cQuery += "F3_NFISCAL >= '" + cNotaIni + "' AND "
	cQuery += "F3_NFISCAL <= '" + cNotaFim + "' AND "
	cQuery += "F3_DTCANC = '" + Space(8) + "' AND "
	If SubStr(cBanco,1,6) == "ORACLE"
		cQuery += "D_E_L_E_T_ = ' '"
	Else
		cQuery += "D_E_L_E_T_ = ''"
	EndIf
	
Endif

return( cQuery )
