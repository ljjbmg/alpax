#INCLUDE "PROTHEUS.CH"


USER FUNCTION GERASB7()
Private lRet := .t.
Private aDados := {}
Private lMsErroAuto  := .f.             // FLAG EXECAUTO
Private lMSHelpAuto  := .f.
Private nOper := 3
Private nRegs := 0
Private cPerg := "GERASB7001"


VALIDPERG()


if !PERGUNTE(cPerg,.t.,"Geracao de inventario zerado(lote/sem lote)")
	msgalert("processo cancelado!")
	return(nil)
else
	xMV_PAR01 := ALLTRIM(MV_PAR01)
	xMV_PAR02 := (MV_PAR02)
	xMV_PAR03 := ALLTRIM(MV_PAR03)
	xMV_PAR04 := ALLTRIM(MV_PAR04)
	xMV_PAR05 := ALLTRIM(MV_PAR05)
	xMV_PAR06 := ALLTRIM(MV_PAR06)
	xMV_PAR07 := ALLTRIM(MV_PAR07)
	xMV_PAR08 := ALLTRIM(MV_PAR08)
	xMV_PAR09 := ALLTRIM(MV_PAR09)
	xMV_PAR10 := ALLTRIM(MV_PAR10)
	
endif

IF SELECT("TMP") <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA("TMP")
ENDIF


BEGINSQL ALIAS "TMP"
	COLUMN SALDO AS NUMERIC(17,2)
	
	SELECT SB1.B1_COD,SB1.B1_DESC,SB1.B1_PNUMBER, SB1.B1_RASTRO, SB8.B8_SALDO SALDO, SB8.B8_LOTECTL LOTE,SB1.B1_TIPO, SB1.B1_UM, SB8.B8_LOCAL XLOCAL
	FROM %table:SB1% SB1 (NOLOCK)
	LEFT JOIN %table:SB8% SB8 (NOLOCK) ON SB8.%Notdel% AND SB8.B8_PRODUTO = SB1.B1_COD AND SB8.B8_LOCAL = %exp:xMV_PAR01%
	WHERE SB1.%Notdel%
	AND SB1.B1_RASTRO IN ('L')
	AND SB8.B8_SALDO > 0
	AND SB1.B1_COD BETWEEN %EXP:xMV_PAR03%  AND %EXP:xMV_PAR04%
	AND SB1.B1_PNUMBER BETWEEN %EXP:xMV_PAR05%  AND %EXP:xMV_PAR06%
	AND SB1.B1_MARCA BETWEEN %EXP:xMV_PAR07%  AND %EXP:xMV_PAR08%
	AND SB1.B1_AXLINHA BETWEEN %EXP:xMV_PAR09%  AND %EXP:xMV_PAR10%
	AND SB1.B1_MSBLQL <> '1'
	
	UNION ALL
	
	SELECT SB1.B1_COD,SB1.B1_DESC,SB1.B1_PNUMBER, SB1.B1_RASTRO, SB2.B2_QATU SALDO, 'ZZZZZZ' LOTE,SB1.B1_TIPO, SB1.B1_UM, SB2.B2_LOCAL XLOCAL
	FROM %table:SB1% SB1 (NOLOCK)
	LEFT JOIN %table:SB2% SB2 (NOLOCK) ON SB2.%Notdel% AND SB2.B2_COD = SB1.B1_COD AND SB2.B2_LOCAL = %EXP:xMV_PAR01%
	WHERE SB1.%Notdel%
	AND SB1.B1_RASTRO IN (' ','N')
	AND SB2.B2_QATU > 0
	AND SB1.B1_COD BETWEEN %EXP:xMV_PAR03%  AND %EXP:xMV_PAR04%
	AND SB1.B1_PNUMBER BETWEEN %EXP:xMV_PAR05%  AND %EXP:xMV_PAR06%
	AND SB1.B1_MARCA BETWEEN %EXP:xMV_PAR07%  AND %EXP:xMV_PAR08%
	AND SB1.B1_AXLINHA BETWEEN %EXP:xMV_PAR09%  AND %EXP:xMV_PAR10%
	AND SB1.B1_MSBLQL <> '1'
	
ENDSQL

DBSELECTAREA("TMP")
DBGOTOP()
WHILE TMP->(!EOF())
	nRegs++                                        
	SLEEP(1000)
	aDados := {}
	AADD(aDados,{"B7_COD"    ,TMP->B1_COD   ,NIL})
	AADD(aDados,{"B7_LOCAL"  ,TMP->XLOCAL ,NIL})
	AADD(aDados,{"B7_TIPO"   ,TMP->B1_TIPO,NIL})
	AADD(aDados,{"B7_DOC"    ,"INV"+SUBSTR(DTOS(DATE()),3),NIL})
	AADD(aDados,{"B7_QUANT"  ,0,NIL})
	AADD(aDados,{"B7_DATA"   ,xMV_PAR02,NIL})
	IF TMP->B1_RASTRO $ "L/S"
	   AADD(aDados,{"B7_LOTECTL",ALLTRIM(TMP->LOTE),NIL})  
	   AADD(aDados,{"B7_DTVALID",(DATE()+365),NIL})
	ENDIF
	AADD(aDados,{"B7_LOCALIZ"   ,"LOCAL",NIL})
	Z := 1
	MSExecAuto({|x,y| MATA270(x,y)},aDados,3)
	
	If lMsErroAuto
		Mostraerro()
		lRet := .F.
		Return(lRet)
	else
		lRet := .T.
	EndIf
	
	TMP->(DBSKIP())
ENDDO
                                

msgalert("terminei")
//msgalert("terminei")
//msgalert("terminei")

RETURN



/*
Funcao para criacao da pergunta, caso a mesma nao exista
*/
Static Function ValidPerg()

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
//cPerg := PADR(cPerg,6)

// Grupo/Ordem/Pergunta                      /Pergunta Espanhol/Pergunta Ingles/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AAdd(aRegs,{cPerg,"01","Almoxarifado"               ,"Almoxarifado"                ,"Almoxarifado"               ,"mv_ch1" ,"C",02,0,0,"G",""   ,"mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"02","Data Inventario    "        ,"Data Inventario    "         ,"Data Inventario    "        ,"mv_ch2" ,"D",08,0,0,"G",""   ,"mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"03","Produto de         "        ,"Produto de         "         ,"Produto de         "        ,"mv_ch3" ,"C",15,0,0,"G",""   ,"mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"04","Produto ate        "        ,"Produto ate        "         ,"Produto ate        "        ,"mv_ch4" ,"C",15,0,0,"G",""   ,"mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"05","PNumber de         "        ,"PNumber de         "         ,"PNumber de         "        ,"mv_ch5" ,"C",20,0,0,"G",""   ,"mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"06","PNumber ate        "        ,"PNumber ate        "         ,"PNumber ate        "        ,"mv_ch6" ,"C",20,0,0,"G",""   ,"mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"07","Marca de           "        ,"Marca de           "         ,"Marca de           "        ,"mv_ch7" ,"C",15,0,0,"G","SZ2","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"08","MArca ate          "        ,"MArca ate          "         ,"MArca ate          "        ,"mv_ch8" ,"C",15,0,0,"G","SZ2","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"09","Linha de           "        ,"Linha de           "         ,"Linha de           "        ,"mv_ch9" ,"C",15,0,0,"G","SZ1","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AAdd(aRegs,{cPerg,"10","Linha ate          "        ,"Linha ate          "         ,"Linha ate          "        ,"mv_ch10","C",15,0,0,"G","SZ1","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+space(len(SX1->X1_GRUPO)-LEN(cPerg))+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return
