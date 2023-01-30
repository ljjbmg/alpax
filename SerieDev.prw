
User Function SerieDev

Local cRet := ""

Local _nPosSerOri	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "D1_SERIORI" })
Local _nPosSerial	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "D1_SERIAL" })
Local _nPosProd	    := Ascan(aHeader,{|x| Alltrim(x[2]) == "D1_COD" })                                       

If !l103Auto
	
	If CTIPO == 'D'
		
		cQry := " SELECT DB_NUMSERI FROM " +RETSQLNAME("SDB")+" "
		cQry += " WHERE D_E_L_E_T_ = ''"
		cQry += " AND  DB_PRODUTO = '"+ACOLS[N,_nPosProd]+"'"
		cQry += " AND DB_DOC = '"+M->D1_NFORI+"'"
		cQry += " AND DB_SERIE = '"+ACOLS[N,_nPosSerOri] +"' "
		cQry += " AND DB_CLIFOR = '"+CA100FOR+"'"
		cQry += " AND DB_LOJA = '"+CLOJA+"' "
		cQry += " AND DB_ORIGEM = 'SC6' "
		
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"TMP",.T.,.T.)
		
		DBSELECTAREA("TMP")
		
		IF TMP->(!EOF())
			cRet := TMP->DB_NUMSERI
			ACOLS[N,_nPosSerial] := TMP->DB_NUMSERI
		Endif
		
		TMP->(dbcloseArea())
	Endif
EndIf

Return cRet	
