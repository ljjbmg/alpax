#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

/*
AUTOR	: ANDERSON BIALE
DATA	: 17/07/12
DESC   	: PONTO DE ENTRADA APOS GRAVACAO DE TODOS OS REGSITROS DA NOTA FISCAL DE ENTRADA.
          FAZ O ENDEREÇAMENTO AUTOMÁTICO APOS INCLUSAO DA NOTA ENTRADA, SE B1_CTRSER(CONTROLE DE SERIE), GERA ZBB(ENDERECAMENTO POR SERIE) SE NAO FAZ O ENDEREÇAMENTO AUTOMATICO PARA O ENDERECO RC(RECEBINENTO)
*/

USER FUNCTION GQREENTR()
           
LOCAL aSF1Are := GetArea()

LOCAL cLOCAL  := "RC"									//RECEBIMENTO		
LOCAL aEndCab := {}                                   	//ARRAY PARA ARMAZENAR CABEÇALHO DO ENDEREÇAMENTO
LOCAL aEndIte := {}                                   	//ARRAY PARA ARMAZENAR ITENS DO ENDEREÇAMENTO 
LOCAL aEndIt1 := {}                                   	//ARRAY TEMPORÁRIO PARA ARMAZENAR ITENS DO ENDEREÇAMENTO 
LOCAL cQry1   := "" 
LOCAL cArq1   := Criatrab(Nil, .F.) 

PRIVATE lMsErroAuto := .F. 

DBSELECTAREA("SBE") 									//ENDERECOS         
SBE->(dbSetOrder(1)) 									//BE_FILIAL+BE_LOCAL+BE_LOCALIZ
IF !(SBE->(dbSeek(xFilial("SBE")+ALLTRIM(cLOCAL))))	//SE NAO EXISTIR O ENDERECO 
	RECLOCK("SBE",.T.)                                 	//INCLUI O ENDERECO
		BE_FILIAL  := xFilial("SBE")                   	//FILIAL CORRENTE
		BE_LOCAL   := ALLTRIM(cLOCAL)	               	//ARMAZEM
		BE_LOCALIZ := "LOCAL"					   	//LOCALIZACAO
		BE_DESCRIC := "LOCAL"						//DESCRICAO
	MSUNLOCK()
Endif
DBSELECTAREA("SBE")		//ENDERECOS          
DBCLOSEAREA()         	//FECHANDO ENDERECOS
DBSELECTAREA("SF1") 	//CABEC NF DE ENTRADA

cQry1 := " SELECT * "								  								+CRLF 
cQry1 += " FROM "+RETSQLNAME("SDA")+" AS DA (NOLOCK)"								+CRLF
cQry1 += " LEFT JOIN "+RETSQLNAME("SD1")+" AS D1 (NOLOCK) ON DA_DOC = D1_DOC " 	   	+CRLF
cQry1 += " 					 AND DA_SERIE	= D1_SERIE "           			    	+CRLF	
cQry1 += " 					 AND DA_CLIFOR  = D1_FORNECE "             				+CRLF	
cQry1 += " 					 AND DA_LOJA    = D1_LOJA "                				+CRLF
cQry1 += " 					 AND DA_PRODUTO = D1_COD "                 				+CRLF
cQry1 += " 					 AND DA_LOCAL   = D1_LOCAL "               				+CRLF
cQry1 += " 					 AND DA_QTDORI  = D1_QUANT "               				+CRLF
cQry1 += " 					 AND DA_NUMSEQ  = D1_NUMSEQ "               			+CRLF

cQry1 += "                   AND D1.D_E_L_E_T_ = '' "    							+CRLF  
cQry1 += "                   AND D1_FILIAL = '" +xFilial("SD1")+ "' "				+CRLF
cQry1 += " LEFT JOIN "+RETSQLNAME("SB1")+" AS B1 (NOLOCK) ON D1_COD = B1_COD "		+CRLF
cQry1 += "                   AND B1.D_E_L_E_T_ = '' "								+CRLF  
cQry1 += "                   AND B1_FILIAL = '" +xFilial("SB1")+ "' "				+CRLF
cQry1 += " WHERE DA.D_E_L_E_T_ = '' "												+CRLF 		
cQry1 += "      AND DA_FILIAL = '" +xFilial("SDA")+ "' "				   			+CRLF  
cQry1 += "      AND DA_DOC = '"+ALLTRIM(SF1->F1_DOC)+"'	 "					    	+CRLF 
cQry1 += "      AND DA_SERIE  = '"+ALLTRIM(SF1->F1_SERIE)+"' "						+CRLF  
cQry1 += "      AND DA_CLIFOR = '"+ALLTRIM(SF1->F1_FORNECE)+"' "					+CRLF  
cQry1 += "      AND DA_LOJA = '"+ALLTRIM(SF1->F1_LOJA)+"'" 				   		    +CRLF  
cQry1 += "      AND DA_ORIGEM = 'SD1' " 								   			+CRLF  
cQry1 += " ORDER BY DA_FILIAL, DA_DOC, DA_SERIE " 									+CRLF     



If Select(cArq1) > 0
	dbSelectArea(cArq1)
	dbCloseArea()
Endif 

MEMOWRITE("_CGREENTR.SQL",cQry1) 

DBUSEAREA( .T.,"TOPCONN", TcGenqry( , , cQry1 ), cArq1, .F., .T. )		

(cArq1)->(DBGOTOP())			//PRIMEIRO REGISTRO	
DO WHILE (cArq1)->(!EOF())		//LENDO TODOS OS REGISTROS
	
	IF (cArq1)->B1_CTRSER <> "S"	//SE NAO UTILIZA SERIE
	
		DBSELECTAREA("SDA")  		//SALDOS A DISTRIBUIR	
		SDA->(dbSetOrder(1)) 		//DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_NUMSEQ+DA_DOC+DA_SERIE+DA_CLIFOR+DA_LOJA
		IF SDA->(dbSeek( (cArq1)->(DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_NUMSEQ+DA_DOC+DA_SERIE+DA_CLIFOR+DA_LOJA) ))
			IF SDA->DA_LOCAL <> "RC"	//SE ARMAZEM DIFERENTE DE RECEBIMENTO
				(cArq1)->(dbSkip())   	//PROX REGISTRO
				LOOP                	//VOLTA COMECO WHILE 	
			ENDIF                     	//FIM
			//RESETA ARRAYS
			aEndCab := {}   
			aEndIt1 := {}
			aEndIte := {}
	               
			//CONSTROI ARRAY DE CABEÇALHO DO ENDEREÇAMENTO
			AADD(aEndCab,{"DA_FILIAL" ,SDA->DA_FILIAL   			,NIL} )
			AADD(aEndCab,{"DA_PRODUTO",SDA->DA_PRODUTO   			,NIL} )
			AADD(aEndCab,{"DA_QTDORI" ,SDA->DA_QTDORI	  			,NIL} )
			AADD(aEndCab,{"DA_SALDO"  ,SDA->DA_SALDO	   			,NIL} )
			AADD(aEndCab,{"DA_DATA"   ,SDA->DA_DATA	   	   			,NIL} )			
			AADD(aEndCab,{"DA_LOTECTL",SDA->DA_LOTECTL  			,NIL} )
			AADD(aEndCab,{"DA_LOCAL"  ,ALLTRIM(cLOCAL) 		 		,NIL} )	
			AADD(aEndCab,{"DA_DOC"    ,SDA->DA_DOC         			,NIL} )	
			AADD(aEndCab,{"DA_SERIE"  ,SDA->DA_SERIE  	   			,NIL} )		 
			AADD(aEndCab,{"DA_CLIFOR" ,SDA->DA_CLIFOR 	   			,NIL} )		
			AADD(aEndCab,{"DA_LOJA"   ,SDA->DA_LOJA 	   			,NIL} )				
			AADD(aEndCab,{"DA_TIPONF" ,SDA->DA_TIPONF   			,NIL} )							
			AADD(aEndCab,{"DA_ORIGEM" ,SDA->DA_ORIGEM  	   			,NIL} )									 
			AADD(aEndCab,{"DA_NUMSEQ" ,SDA->DA_NUMSEQ  				,NIL} )		 
							
			//CONSTROI ARRAY TEMPORÁRIO DE ITENS DO ENDEREÇAMENTO
			aEndIt1 := {}									         
			cItem   := "0001"
			AADD(aEndIt1,{"DB_ITEM"   ,cItem        				,NIL} )
			AADD(aEndIt1,{"DB_LOCALIZ",SB1->B1_ENDER				,NIL} )		 
			AADD(aEndIt1,{"DB_QUANT"  ,SDA->DA_QTDORI				,NIL} )				 
			AADD(aEndIt1,{"DB_DATA"   ,SDA->DA_DATA		   			,NIL} )			
			AADD(aEndIt1,{"DB_LOTECTL",SDA->DA_LOTECTL	   			,NIL} )		        
			aEndIte := {}
			//CONSTROI ARRAY DE ITEM DO ENDEREÇAMENTO        
			AADD(aEndIte,Aclone(aEndIt1))
		 
	  	    lMSErroAuto := .F.
			//EXECUTA EXECAUTO DE ENDEREÇAMENTO DE PRODUTO  				
			MSEXECAUTO({|x,y|mata265(x,y)},aEndCab,aEndIte,3)
	
			IF lMsErroAuto					
				MostraErro()
			ENDIF
		ENDIF
	
	ELSE	//SE UTILIZA SERIE B1_CTRSER == 'S' //SIM
		
			DBSELECTAREA("ZBB")	//ENDERECAMENTO POR SERIE
			DBSETORDER(1)		//FILIAL + DOC + SERIE + FORNEC + LOJA
			RECLOCK("ZBB",.T.)	//TRAVA PARA INCLUSAO
			
			ZBB->ZBB_FILIAL		:= xFILIAL("ZBB") 				//FILIAL
			ZBB->ZBB_DOC		:= (cArq1)->D1_DOC   			//DOC
			ZBB->ZBB_SERIE    	:= (cArq1)->D1_SERIE       		//SERIE
			ZBB->ZBB_FORNEC    	:= (cArq1)->D1_FORNECE   		//FORNECEDOR
			ZBB->ZBB_LOJA      	:= (cArq1)->D1_LOJA      		//LOJA
			ZBB->ZBB_ITEM      	:= (cArq1)->D1_ITEM      		//ITEM
			ZBB->ZBB_COD   		:= (cArq1)->D1_COD        		//PRODUTO
			ZBB->ZBB_LOCAL     	:= (cArq1)->D1_LOCAL     		//LOCAL
			ZBB->ZBB_QUANT     	:= (cArq1)->D1_QUANT     		//QUANTIDADE
			ZBB->ZBB_LOTE      	:= (cArq1)->D1_LOTECTL     		//LOTE
			ZBB->ZBB_DTVAL		:= STOD((cArq1)->D1_DTVALID)	//DT VALIDACAO LOTE
			ZBB->(MSUNLOCK())	//DESTRAVA REGISTRO	
	ENDIF
	
	(cArq1)->(dbSkip())
ENDDO
		
If SELECT(cArq1) > 0
	DBSELECTAREA(cArq1)
	dbCloseArea()
Endif       
				
RestArea(aSF1Are)

RETURN