#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

User Function BIAA032()
                          

Processa({||U_BIAA032A()},"Gerando Relatorio de Fornecedores")
Processa({||U_BIAA032B()},"Gerando Relatorio de Clientes")
Processa({||U_BIAA032C()},"Gerando Relatorio de Transportadoras")


Return

User Function BIAA032A()

Local cQry 			:= ''
Local cRecnoCGC	:= ''
Local cRecnoIE		:= ''
Local	aCabec		:= {}
Local aResult		:= {}
Local nCont 		:= 1 
Local nContIE		:= 1

DbSelectArea("SA2")
SA2->(DbGoTop())

while SA2->(!EOF())

		IF !CGC(SA2->A2_CGC,,.f.) 
			if nCont == 1
				cRecnoCGC := cvaltochar(SA2->(Recno()))
				nCont++
			Else
				cRecnoCGC += ", " + cvaltochar(SA2->(Recno()))
				nCont++
			Endif
		EndIf		
		
		
		IF !IE(SA2->A2_INSCR,SA2->A2_EST,.F.)
			if nContIE == 1
				cRecnoIE := cvaltochar(SA2->(Recno()))
				nContIE++
			Else
				cRecnoIE += ", " + cvaltochar(SA2->(Recno()))
				nContIE++
			Endif
		EndIf		        

		SA2->(DbSkip())
EndDo
IF !EMPTY(cRecnoCGC) 

	cqry += " SELECT	'CNPJ ERRADO' TIPO, A2_COD, A2_LOJA, A2_NREDUZ, A2_END, A2_BAIRRO, A2_MUN, A2_EST, A2_CEP  "+CRLF
	cqry += " FROM	SA2010   (nolock) "+CRLF
	cqry += " WHERE	R_E_C_N_O_ IN("+cRecnoCGC+ ")"+CRLF
Endif
	
IF !EMPTY(cRecnoIE)
	IF !EMPTY(cRecnoCGC) 
		cqry += " UNION ALL " + CRLF                    
    Endif

	cqry += " SELECT	'IE ERRADO' TIPO, A2_COD, A2_LOJA, A2_NREDUZ, A2_END, A2_BAIRRO, A2_MUN, A2_EST, A2_CEP " +CRLF
	cqry += " FROM	SA2010 (nolock)  "+CRLF
	cqry += " WHERE	R_E_C_N_O_ IN("+cRecnoIE+ ")" + CRLF
	cqry += " ORDER BY A2_COD " + CRLF               
Endif
	
memowrite("c:\temp\BIAA032.SQL",cqry)
     
DbUseArea( .T., "TOPCONN", TcGenqry( , , cQry), "TRB", .F., .F. )
	
		while TRB->(!EOF())
			aadd(aResult,{TRB->TIPO, TRB->A2_COD, TRB->A2_LOJA, TRB->A2_NREDUZ, TRB->A2_END, TRB->A2_BAIRRO, TRB->A2_MUN, TRB->A2_EST, TRB->A2_CEP})
		TRB->(dbSkip())
		EndDo
TRB->(DbCloseArea())

	                               
	 aCabec := {'TIPO','CODIGO','FILIAL','NOME','ENDERECO','BAIRRO','MUNICIPIO','UF','CEP','USUARIO'}
	 DlgToExcel({{"ARRAY","Tabela de Fornecedores Com ERROS",aCabec,aResult}})
	
Return                                                                                                                                                                       
                                          

User Function BIAA032B()

Local cQry 			:= ''
Local cRecnoCGC	:= ''
Local cRecnoIE		:= ''
Local	aCabec		:= {}
Local aResult		:= {}
Local nCont			:= 1
Local nContIE		:= 1
 
DbSelectArea("SA1")
SA1->(DbGoTop())

while SA1->(!EOF())

		IF !CGC(SA1->A1_CGC,,.f.) 
			if nCont == 1
				cRecnoCGC := cvaltochar(SA1->(Recno()))
				nCont++
			Else
				cRecnoCGC += ", "+ cvaltochar(SA1->(Recno()))
				nCont++
			Endif
		EndIf		
		
		
		IF !IE(SA1->A1_INSCR,SA1->A1_EST,.F.)
			if nContIE == 1
				cRecnoIE := cvaltochar(SA1->(Recno()))
				nContIE++
			Else
				cRecnoIE += ", "+ cvaltochar(SA1->(Recno()))
				nContIE++
			Endif
		EndIf		        

		SA1->(DbSkip())
EndDo
IF !EMPTY(cRecnoCGC) 
	cqry += " SELECT	'CNPJ ERRADO' TIPO, A1_COD, A1_LOJA, A1_NREDUZ, A1_END, A1_BAIRRO, A1_MUN, A1_EST, A1_CEP " + CRLF
	cqry += " FROM	SA1010   " + CRLF
	cqry += " WHERE	R_E_C_N_O_ IN("+cRecnoCGC+ ")" + CRLF
Endif	

IF !EMPTY(cRecnoIE)
	IF !EMPTY(cRecnoCGC) 
		cqry += " UNION ALL " + CRLF                    
    Endif
	cqry += " SELECT	'IE ERRADO' TIPO, A1_COD, A1_LOJA, A1_NREDUZ, A1_END, A1_BAIRRO, A1_MUN, A1_EST, A1_CEP " + CRLF
	cqry += " FROM	SA1010   " + CRLF
	cqry += " WHERE	R_E_C_N_O_ IN("+cRecnoIE+ ")" + CRLF
	cqry += " ORDER BY A1_COD " + CRLF                
Endif	

memowrite("c:\temp\BIAA032B.SQL",cqry)     

DbUseArea( .T., "TOPCONN", TcGenqry( , , cQry), "TRB", .F., .F. )
	
		while TRB->(!EOF())
			aadd(aResult,{TRB->TIPO, TRB->A1_COD, TRB->A1_LOJA, TRB->A1_NREDUZ, TRB->A1_END, TRB->A1_BAIRRO, TRB->A1_MUN, TRB->A1_EST, TRB->A1_CEP})
		TRB->(dbSkip())
		EndDo
TRB->(DbCloseArea())

	                                             
	 aCabec := {'TIPO','CODIGO','FILIAL','NOME','ENDERECO','BAIRRO','MUNICIPIO','UF','CEP','USUARIO'}
	 DlgToExcel({{"ARRAY","Tabela de Clientes Com ERROS",aCabec,aResult}})
	
Return                                                                                                                                                                       

User Function BIAA032C()

Local cQry 			:= ''
Local cRecnoCGC	:= ''
Local cRecnoIE		:= ''
Local	aCabec		:= {}
Local aResult		:= {}
Local nCont			:= 1
Local nContIE		:= 1
 
DbSelectArea("SA4")
SA1->(DbGoTop())

while SA4->(!EOF())

		IF !CGC(SA4->A4_CGC,,.f.) 
			if nCont == 1
				cRecnoCGC := cvaltochar(SA4->(Recno()))
				nCont++
			Else
				cRecnoCGC += ", "+ cvaltochar(SA4->(Recno()))
				nCont++
			Endif
		EndIf		
		
		
		IF !IE(SA4->A4_INSEST,SA4->A4_EST,.F.)
			if nContIE == 1
				cRecnoIE := cvaltochar(SA4->(Recno()))
				nContIE++
			Else
				cRecnoIE += ", "+ cvaltochar(SA4->(Recno()))
				nContIE++
			Endif
		EndIf		        

		SA4->(DbSkip())
EndDo

IF !EMPTY(cRecnoCGC)
	cqry += " SELECT	'CNPJ ERRADO' TIPO, A4_COD,  A4_NREDUZ, A4_END, A4_BAIRRO, A4_MUN, A4_EST, A4_CEP " + CRLF
	cqry += " FROM	SA4010   " + CRLF
	cqry += " WHERE	R_E_C_N_O_ IN("+cRecnoCGC+ ")" + CRLF
Endif

IF !EMPTY(cRecnoIE)
	IF !EMPTY(cRecnoCGC) 
		cqry += " UNION ALL " + CRLF                    
    Endif
	cqry += " SELECT	'IE ERRADO' TIPO, A4_COD, A4_NREDUZ, A4_END, A4_BAIRRO, A4_MUN, A4_EST, A4_CEP " + CRLF 
	cqry += " FROM	SA4010   " + CRLF
	cqry += " WHERE	R_E_C_N_O_ IN("+cRecnoIE+ ")" + CRLF
	cqry += " ORDER BY A4_COD " + CRLF                
Endif	
memowrite("c:\temp\BIAA032C.SQL",cqry)     

DbUseArea( .T., "TOPCONN", TcGenqry( , , cQry), "TRB", .F., .F. )
	
		while TRB->(!EOF())
			aadd(aResult,{TRB->TIPO, TRB->A4_COD, TRB->A4_NREDUZ, TRB->A4_END, TRB->A4_BAIRRO, TRB->A4_MUN, TRB->A4_EST, TRB->A4_CEP})
		TRB->(dbSkip())
		EndDo
TRB->(DbCloseArea())

	                                             
	 aCabec := {'TIPO','CODIGO','NOME','ENDERECO','BAIRRO','MUNICIPIO','UF','CEP','USUARIO'}
	 DlgToExcel({{"ARRAY","Tabela de Clientes Com ERROS",aCabec,aResult}})
	
Return                                                                                                                                                                       
