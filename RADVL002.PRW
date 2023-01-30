#INCLUDE "PROTHEUS.CH"

/*
FUNCAOLIB: RADVL002
OBJETIVO : ROTINA AUTOMATICA PARA CADASTRO DE EMPENHOS
AUTOR    : FABRICA DE SOFTWARE ADVPL  (advpl@advpl.com.br)
PROJETO  : ALPAX
DATA     : 12.11.2009

-------------------------------------------------------------------------- 
PARAMETROS
01) VETOR COM CONTEUDO DOS CAMPOS A SEREM UTILIZADOS
02) OPCAO DA ROTINA

-------------------------------------------------------------------------- 
RETORNO
.T. PARA PROCESSAMENTO CONFIRMADO
.F. PARA FALHA NO PROCESSAMENTO

--------------------------------------------------------------------------
12.11.09 : IMPLEMENTADO CODIGO PADRAO
13.11.09 : BASE TESTE

*/

USER FUNCTION RADVL002(aParam,lInclui)

Local aDados      := {}
Local MD4_COD     := aParam[1]  // EMPENHO CODIGO PRODUTO
Local MD4_LOCAL   := aParam[2]  // EMPENHO LOCAL A RETIRAR
Local MD4_OP      := aParam[3]  // EMPENHO OP UTILIZAR
Local MD4_DATA    := aParam[4]  // EMPENHO DATA
Local MD4_QTDEORI := aParam[5]  // EMPENHO QUANTIDADE OPERACAO
Local MD4_QUANT   := aParam[6]  // EMPENHO QUANTIDADE OPERACAO
Local MD4_LOTECTL := aParam[7]  // EMPENHO LOTE
Local MD4_NUMLOTE := aParam[8]  // EMPENHO SUBLOTE
Local _lRet       := .T.                // RETORNO
Local nOper       := IIF(lInclui,3,5)   // OPERACAO, 3 INCLUIR, 5 EXCLUIR
Private lMsErroAuto  := .f.             // FLAG EXECAUTO                                 
                                                  
       
DBSELECTAREA("SB2")
aBk := Getarea()
        
DBSETORDER(2)
DBGOTOP()
IF !DBSEEK(XFILIAL("SB2")+MD4_LOCAL+MD4_COD )
	Reclock("SB2",.t.)
	SB2->B2_FILIAL  := xFilial("SB2")
	SB2->B2_COD     := MD4_COD 
	SB2->B2_LOCAL   := MD4_LOCAL
	Msunlock()
	commit
ENDIF       

restarea(aBk)
SB2->(dbgotop())
/*        
AADD(aDados,{"D4_FILIAL"  ,XFILIAL("SD4") ,NIL})    
AADD(aDados,{"COP"      ,MD4_OP         ,NIL})  
AADD(aDados,{"D4_COD"     ,MD4_COD        ,NIL})  
AADD(aDados,{"D4_LOCAL"   ,ALLTRIM(MD4_LOCAL)     ,NIL})  
AADD(aDados,{"D4_OP"      ,MD4_OP         ,NIL})  
AADD(aDados,{"D4_DATA"    ,MD4_DATA       ,NIL})  
AADD(aDados,{"D4_QTDEORI" ,MD4_QTDEORI    ,NIL}) 
AADD(aDados,{"D4_QUANT"   ,MD4_QUANT      ,NIL})
 
If (MD4_LOTECTL <> nil)
	AADD(aDados,{"D4_LOTECTL" ,MD4_LOTECTL    ,NIL}) 
	AADD(aDados,{"D4_NUMLOTE" ,MD4_NUMLOTE    ,NIL})                                                  
Endif
*/
Begin Transaction
   	dbSelectArea("SD4")
	IF nOper == 3
		RecLock("SD4",.T.)
			D4_FILIAL  := XFILIAL("SD4") 
			D4_COD     := MD4_COD
			D4_LOCAL   := ALLTRIM(MD4_LOCAL)
			D4_OP      := MD4_OP     
			D4_DATA    := MD4_DATA
			D4_QTDEORI := MD4_QTDEORI 
			D4_QUANT   := MD4_QUANT
			AJUSTSB2(MD4_COD, ALLTRIM(MD4_LOCAL), MD4_QUANT)
			IF (MD4_LOTECTL <> nil)
            	D4_LOTECTL := MD4_LOTECTL
            	D4_NUMLOTE := MD4_NUMLOTE
            	AJUSTSB8(MD4_COD, ALLTRIM(MD4_LOCAL), MD4_LOTECTL, MD4_QUANT)
            ENDIF             	
            _lRet       := .T.
		SD4->(MsUnlock())
    ELSE
    	cQry := "SELECT * FROM "+RetSqlName("SD4")+" WHERE D_E_L_E_T_ = '' "
    	cQry += "AND D4_FILIAL = '"+xFilial("SD4")+"' AND D4_COD = '"+MD4_COD+"' "
    	cQry += "AND D4_OP = '"+MD4_OP+"' AND D4_LOCAL = '"+ALLTRIM(MD4_LOCAL)+"' "
    	cQry := ChangeQuery(cQry)         
    	IF SELECT("RADVL002") > 0
    		dbSelectArea("RADVL002")
    		dbCloseArea()
    	ENDIF	
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"RADVL002",.T.,.T.)
		IF RADVL002->(!eof())
			dbSelectArea("SD4")
			dbGoto(RADVL002->R_E_C_N_O_)
			RecLock("SD4",.F.)
				D4_FILIAL  := XFILIAL("SD4") 
				D4_COD     := MD4_COD
				D4_LOCAL   := ALLTRIM(MD4_LOCAL)
				D4_OP      := MD4_OP     
				D4_DATA    := MD4_DATA
				D4_QTDEORI := MD4_QTDEORI 
				D4_QUANT   := MD4_QUANT  
				IF RADVL002->D4_QUANT > MD4_QUANT 
					 AJUSTSB2(MD4_COD, ALLTRIM(MD4_LOCAL), RADVL002->D4_QUANT - MD4_QUANT)
				ELSEIF  RADVL002->D4_QUANT > MD4_QUANT 
					 AJUSTSB2(MD4_COD, ALLTRIM(MD4_LOCAL), MD4_QUANT - RADVL002->D4_QUANT)
				ENDIF	 
				IF (MD4_LOTECTL <> nil)
	            	D4_LOTECTL := MD4_LOTECTL
	            	D4_NUMLOTE := MD4_NUMLOTE                                    
	            	IF RADVL002->D4_QUANT > MD4_QUANT 
		            	AJUSTSB8(MD4_COD, ALLTRIM(MD4_LOCAL), MD4_LOTECTL, RADVL002->D4_QUANT - MD4_QUANT)
		            ELSEIF  RADVL002->D4_QUANT > MD4_QUANT 
		            	AJUSTSB8(MD4_COD, ALLTRIM(MD4_LOCAL), MD4_LOTECTL, MD4_QUANT - RADVL002->D4_QUANT)
					ENDIF	
	            ENDIF	
	            _lRet       := .T.
			SD4->(MsUnlock())			
		ELSE
			_lRet       := .F.	
		ENDIF
    ENDIF
/*    MSExecAuto({|x,y| mata380(x,y)},aDados,nOper) 
	If lMsErroAuto
    	DisarmTransaction()
    	Mostraerro()
		_lRet := .F.
		Return(_lRet)
	else
		_lRet := .T.
	EndIf
*/

End Transaction

Return(_lRet)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AJUSTSB2  ºAutor  ³Microsiga           º Data ³  09/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ROTINA AUXILIAR PARA RETIRAR EMPENHO DA TABELA SB2          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ALPAX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION AJUSTSB2(cProd, cLocal, nQt)

dbSelectArea("SB2")
SB2->(dbSetOrder(1)) //B2_FILIAL+B2_COD+B2_LOCAL
IF SB2->(dbSeek(xFilial("SB2")+cProd+cLocal ) ) 
	RecLock("SB2",.F.)		
		SB2->B2_QEMP := SB2->B2_QEMP + nQt
	SB2->(Msunlock())
ENDIF

RETURN 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AJUSTSB8  ºAutor  ³Microsiga           º Data ³  09/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ROTINA AUXILIAR PARA RETIRAR EMPENHO DA TABELA SB8          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ALPAX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION AJUSTSB8(cProd, cLocal, clote, nQt)

Local aRecno         := {}
Local cQry 			 := ""
Local cAliasD8  	 := GetNextAlias() 
Local cAliasBF  	 := GetNextAlias()
local ni 

IF SELECT(cAliasD8) > 0
	dbSelectArea(cAliasD8)
	dbCloseArea()
ENDIF

IF SELECT(cAliasBF) > 0
	dbSelectArea(cAliasBF)
	dbCloseArea()
ENDIF

dbSelectArea(cAliasD8)
SB8->(dbSetOrder(3) ) //B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+B8_NUMLOTE+DTOS(B8_DTVALID)
IF (SB8)->(dbSeek( xFilial("SB8")+cProd+cLocal+clote ) )
	DO CASE
   		CASE SB8->B8_SALDO >= nQt .AND. SB8->B8_EMPENHO >= nQt
			AADD(aRecno,{SB8->(RECNO()), nQt} )
		CASE SB8->B8_SALDO < nQt 
			AADD(aRecno,{SB8->(RECNO()), SB8->B8_SALDO} ) 
			nQt := nQt - SB8->B8_SALDO
	ENDCASE		
ENDIF   	

IF LEN(aRecno) > 0   	   	
	dbSelectArea("SB8")
	SB8->(dbSetOrder(1)) //B8_FILIAL+B8_PRODUTO+B8_LOCAL+DTOS(B8_DTVALID)+B8_LOTECTL+B8_NUMLOTE
	FOR nI := 1 to len(aRecno)
		IF SB8->(dbGoto(aRecno[nI][01]) ) 
			RecLock("SB8",.F.)
				SB8->B8_EMPENHO := SB8->B8_EMPENHO + aRecno[nI][02]
			SB8->(Msunlock())
			IF POSICIONE("SB1",1,xFilial("SB1")+SD4->D4_COD,"B1_LOCALIZ") $ "S"    		
				IF SELECT(cAliasBF) > 0
					dbSelectArea(cAliasBF)
					dbCloseArea()
				ENDIF
				cQry := "SELECT * "
				cQry += "FROM "+retSqlName("SBF") +" " 
				cQry += "WHERE D_E_L_E_T_     = '' "
                cQry += "	  AND BF_PRODUTO = '"+cProd+"' "
       			cQry += "	  AND BF_LOCAL   = '"+cLocal+"' "
      			cQry += "	  AND BF_LOTECTL = '"+SB8->B8_LOTECTL+"' "
      			cQry += "	  AND BF_QUANT   > 0  "
      			cQry += "	  AND BF_EMPENHO > 0  "
				cQry += "ORDER BY BF_QUANT, BF_EMPENHO "       
				DBUSEAREA(.T., "TOPCONN", TCGENQRY(,,cQry ), cAliasBF, .F.,.T.)
				dbSelectArea(cAliasBF)
				IF (cAliasBF)->(!EOF())
   					DO WHILE (cAliasBF)->(!EOF())            
   						DO CASE
	   						CASE (cAliasBF)->BF_QUANT >= aRecno[nI][02] .AND. (cAliasBF)->BF_EMPENHO >= aRecno[nI][02] 
	   							dbSelectArea("SBF")
	   							SBF->(dbGoTo((cAliasBF)->R_E_C_N_O_ ) )
	   							RecLock("SBF",.F.)	
	   								SBF->BF_EMPENHO := SBF->BF_EMPENHO + aRecno[nI][02]
	   							SBF->(Msunlock())
	   						CASE (cAliasBF)->BF_QUANT < aRecno[nI][02] 
	   							dbSelectArea("SBF")
	   							SBF->(dbGoTo((cAliasBF)->R_E_C_N_O_ ) )
	   							RecLock("SBF",.F.)	
	   								SBF->BF_EMPENHO := SBF->BF_EMPENHO + (aRecno[nI][02] - SBF->BF_QUANT)
	   							SBF->(Msunlock())	   							   					
	   					ENDCASE
	   					(cAliasBF)->(dbSkip())
	   				ENDDO
	   			ENDIF
				IF SELECT(cAliasBF) > 0
					dbSelectArea(cAliasBF)
					dbCloseArea()
				ENDIF	   						
			ENDIF
		ENDIF                                                               
		dbSelectArea("SB8")
	Next nI                                                                 	
ENDIF	

IF SELECT(cAliasBF) > 0
	dbSelectArea(cAliasBF)
	dbCloseArea()
ENDIF

IF SELECT(cAliasD8) > 0
	dbSelectArea(cAliasD8)
	dbCloseArea()
ENDIF

RETURN
