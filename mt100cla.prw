#Include "Rwmake.ch"
#Include "TopConn.ch"


User Function MT100CLA()

Local cAliasSd1 := GetNextAlias()
Local nCont  := 0
Local aAreaAtu	:= GetArea()
Local aReta		:= {}
Local aRetSd1	:= {}
Local nRegAtu	:= 0
Local x			:= 0
Local nx        := 0
Local cDoc      :=  CNFISCAL
Local cSer      :=  CSERIE
Local cFornece  :=  CA100FOR
Local cLoja     :=  CLOJA
Local cTipo     :=  CTIPO


    BeginSql Alias cAliasSd1
    
        SELECT
        PRODUTO	= D1_COD,
        PNUMBER	= B1_PNUMBER,
		DESCRI	= B1_DESC,
        CONTROL = Controlado

        FROM ( SELECT
                D1_COD,
                B1_PNUMBER,
                B1_DESC,
              Isnull(Case When B1_AXFEDER = 'S' THEN 'Controlado PF'
                    When B1_AXEXERC = 'S' THEN 'Controlado Exercito'
                    When B1_AXSUBS = '1' THEN 'Substancia Controlada PF'
                    End,'Nao Controlado') As Controlado
            FROM %Table:SD1% SD1 (NOLOCK)
                        INNER JOIN %Table:SB1% SB1 (NOLOCK)
                            ON D1_COD = B1_COD 
                            AND SB1.%NotDel% 
            WHERE D1_DOC =  %exp:cDoc% AND SD1.%NotDel% AND D1_SERIE = %exp:cSer%
                    AND D1_FORNECE = %exp:cFornece% AND D1_LOJA = %exp:cLoja%
                    AND D1_TIPO =  %exp:cTipo%
                    AND (B1_AXFEDER = 'S' Or B1_AXEXERC = 'S' Or B1_AXSUBS = '1' )
        ) F
        ORDER BY PRODUTO 
   EndSql

   aSql := GetLastQuery()
   cSql := aSql[2]
   MemoWrite("\queries\mt100cla.sql",cSql)

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Definicao da primeira regua				     �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	(cAliasSd1)->(dbEval({|| nCont++},,{|| !EOF()}))

    If nCont = 0
        Return
    End

	ProcRegua(nCont)

	(cAliasSd1)->(dbGoTop())	
	aRetSd1	:= Array(fCount())
	nRegAtu	:= 1

	AADD(aRetSd1,.F.)   	

	While (cAliasSd1)->(!Eof())
		IncProc("Lendo Registros..."+Alltrim(str(nRegAtu))+"/"+Alltrim(str(nCont)) )
		For x:=1 to fCount()
			aRetSd1[x] := FieldGet(x)
		Next

		AADD(aReta,aclone(aRetSd1))
		(cAliasSd1)->(DbSkip())
		nRegAtu += 1
	Enddo

	(cAliasSd1)->(dbCloseArea())
	RestArea(aAreaAtu)

    For nx=1 to Len(aReta)
        If nx == 1
            _cMen := "Existe Produtos Controlados nessa NF - " + cDoc + CHR(13)+CHR(10)
            _cMen += CHR(13)+CHR(10)
        End _cMen 
        _cMen += "PRODUTO: "+ Padr(aReta[nx][1],20) + " - " + Padr(aReta[nx][4],20)+ CHR(13)+CHR(10)
    Next nx
    Alert(_cMen)
Return Nil 


