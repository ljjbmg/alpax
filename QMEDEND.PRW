#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQMEDEND   บAutor  ณMicrosiga           บ Data ณ  10/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA PARA ENDEREวAMENTO AUTOMมTICO DOS PRODUTOS           บฑฑ
ฑฑบ          ณDO ARMAZษM CADASTRADO NO PARยMETRO MV_QMEDEND PARA O        บฑฑ 
ฑฑบ          ณENDEREวO CADASTRADO NO PARยMETRO MV_QMEDEND SOMENTE QUANDO Aบฑฑ
ฑฑบ          ณTES MOVIMENTAR ESTOQUE                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณQMED/GALDERMA                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION QMEDEND()	//U_QMEDEND()

Local aSF1Are := GetArea()

//Local cEnder  := SUPERGETMV("MV_QMEDEND",.F.,"01QMED",)  //ARMAZENA LOCAL E ENDEREวO PARA PRODUTOS DA QMED
Local cEnder  := "RC"									 //RECEBIMENTO		
Local aEndCab := {}                                      //ARRAY PARA ARMAZENAR CABEวALHO DO ENDEREวAMENTO
Local aEndIte := {}                                      //ARRAY PARA ARMAZENAR ITENS DO ENDEREวAMENTO 
Local aEndIt1 := {}                                      //ARRAY TEMPORมRIO PARA ARMAZENAR ITENS DO ENDEREวAMENTO 
Local cPerg   := "QMEDEND"
Local cQry1   := "" 
Local cArq1   := Criatrab(Nil, .F.) 

PRIVATE lMsErroAuto := .F. 

dbSelectArea("SBE")          
SBE->(dbSetOrder(1)) 									//BE_FILIAL+BE_LOCAL+BE_LOCALIZ
IF !(SBE->(dbSeek(xFilial("SBE")+ALLTRIM(cEnder))))	    //SE NรO EXISTIR O ENDEREวO 
	reclock("SBE",.T.)                                  //INSERE O ENDEREวO
		BE_FILIAL  := xFilial("SBE")                    //FILIAL CORRENTE
		BE_LOCAL   := ALLTRIM(cENDER)	                //ARMAZษM DO PARยMETRO
		BE_LOCALIZ := "LOCAL"						    //ENDEREวO DO PARยMETRO
		BE_DESCRIC := "LOCAL"							//DESCRICAO
	MSunLock()
Endif
dbSelectArea("SBE")          
dbCloseArea()

VALIDSX1(cPerg)
If !Pergunte(cPerg,.T.)
	MsgAlert ("Opera็ใo Cancelada pelo usuแrio!")
    Return
Endif

cQry1 := "SELECT * " +CRLF 
cQry1 += "FROM " +Retsqlname("SDA")+ " SDA " +CRLF
cQry1 += "WHERE SDA.D_E_L_E_T_ = '' AND  " +CRLF 		
cQry1 += "      SDA.DA_DOC    BETWEEN '" +MV_PAR01+ "' AND '"+MV_PAR02+"' AND " +CRLF 
cQry1 += "      SDA.DA_SERIE  BETWEEN '" +MV_PAR03+ "' AND '"+MV_PAR04+"' AND " +CRLF  
cQry1 += "      SDA.DA_CLIFOR BETWEEN '" +MV_PAR05+ "' AND '"+MV_PAR07+"' AND " +CRLF  
cQry1 += "      SDA.DA_LOJA   BETWEEN '" +MV_PAR06+ "' AND '"+MV_PAR08+"' AND " +CRLF  
cQry1 += "      SDA.DA_ORIGEM = 'SD1' AND " +CRLF  
cQry1 += "      SDA.DA_FILIAL =  '" +xFilial("SDA")+ "' " +CRLF  
cQry1 += "ORDER BY SDA.DA_FILIAL, SDA.DA_DOC, SDA.DA_SERIE " +CRLF 
memowrit("d:\QMEDEND01.sql",cQry1)
If Select(cArq1) > 0
	dbSelectArea(cArq1)
	dbCloseArea()
Endif 
DbUseArea( .T., "TOPCONN", TcGenqry( , , cQry1 ), cArq1, .F., .T. )		

(cArq1)->(dbGoTop())
Do While (cArq1)->(!EOF())

	dbSelectArea("SDA")
	SDA->(dbSetOrder(1)) //DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_NUMSEQ+DA_DOC+DA_SERIE+DA_CLIFOR+DA_LOJA
	IF SDA->(dbSeek( (cArq1)->(DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_NUMSEQ+DA_DOC+DA_SERIE+DA_CLIFOR+DA_LOJA) ))
		IF SDA->DA_LOCAL <> "RC"
			(cArq1)->(dbSkip()) 
			LOOP
		ENDIF
		//RESETA ARRAYS
		aEndCab := {}   
		aEndIt1 := {}
		aEndIte := {}
               
		//CONSTROI ARRAY DE CABEวALHO DO ENDEREวAMENTO
		AADD(aEndCab,{"DA_FILIAL" ,SDA->DA_FILIAL   			,NIL} )
		AADD(aEndCab,{"DA_PRODUTO",SDA->DA_PRODUTO   			,NIL} )
		AADD(aEndCab,{"DA_QTDORI" ,SDA->DA_QTDORI	  			,NIL} )
		AADD(aEndCab,{"DA_SALDO"  ,SDA->DA_SALDO	   			,NIL} )
		AADD(aEndCab,{"DA_DATA"   ,SDA->DA_DATA	   	   			,NIL} )			
		AADD(aEndCab,{"DA_LOTECTL",SDA->DA_LOTECTL  			,NIL} )
		AADD(aEndCab,{"DA_LOCAL"  ,Substr(cEnder,1,2)  			,NIL} )	
		AADD(aEndCab,{"DA_DOC"    ,SDA->DA_DOC         			,NIL} )	
		AADD(aEndCab,{"DA_SERIE"  ,SDA->DA_SERIE  	   			,NIL} )		 
		AADD(aEndCab,{"DA_CLIFOR" ,SDA->DA_CLIFOR 	   			,NIL} )		
		AADD(aEndCab,{"DA_LOJA"   ,SDA->DA_LOJA 	   			,NIL} )				
		AADD(aEndCab,{"DA_TIPONF" ,SDA->DA_TIPONF   			,NIL} )							
		AADD(aEndCab,{"DA_ORIGEM" ,SDA->DA_ORIGEM  	   			,NIL} )									 
		AADD(aEndCab,{"DA_NUMSEQ" ,SDA->DA_NUMSEQ  				,NIL} )		 
						

		//CONSTROI ARRAY TEMPORมRIO DE ITENS DO ENDEREวAMENTO
		aEndIt1 := {}									         
		cItem   := "0001"
		AADD(aEndIt1,{"DB_ITEM"   ,cItem        				,NIL} )
		AADD(aEndIt1,{"DB_LOCALIZ","LOCAL"						,NIL} )		 
		AADD(aEndIt1,{"DB_QUANT"  ,SDA->DA_QTDORI				,NIL} )				 
		AADD(aEndIt1,{"DB_DATA"   ,SDA->DA_DATA		   			,NIL} )			
		AADD(aEndIt1,{"DB_LOTECTL",SDA->DA_LOTECTL	   			,NIL} )		        
		aEndIte := {}
		//CONSTROI ARRAY DE ITEM DO ENDEREวAMENTO        
		AADD(aEndIte,Aclone(aEndIt1))
	 
  	    lMSErroAuto := .F.
		//EXECUTA EXECAUTO DE ENDEREวAMENTO DE PRODUTO  				
		msExecAuto({|x,y|mata265(x,y)},aEndCab,aEndIte,3)

		If lMsErroAuto					
			MostraErro()
		Endif
	Endif
	(cArq1)->(dbSkip())
Enddo
		
If Select(cArq1) > 0
	dbSelectArea(cArq1)
	dbCloseArea()
Endif 
				
RestArea(aSF1Are)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  VALIDSX1   บAutor  ณMicrosiga           บ Data ณ  16/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA PARA CRIAR A PERGUNTA                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณGALDERMA/QMED                                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC FUNCTION VALIDSX1(cPerg)

Local aHelp := {}

// PARA REALIZAR AJUSTES FINOS

	dbselectarea("SX1")
	dbsetOrder(1)
	
	PutSx1(cPerg, "01","Nota de            ?"," "," ","mv_ch01","C",09,0,0,"G","     ","   ","","","mv_par01","","","","","","","","","","","","","","","","")
	PutSx1(cPerg, "02","Nota at้           ?"," "," ","mv_ch02","C",09,0,0,"G","     ","   ","","","mv_par02","","","","","","","","","","","","","","","","")
	PutSx1(cPerg, "03","S้rie de           ?"," "," ","mv_ch03","C",03,0,0,"G","     ","   ","","","mv_par03","","","","","","","","","","","","","","","","")
	PutSx1(cPerg, "04","S้rie at้          ?"," "," ","mv_ch04","C",03,0,0,"G","     ","   ","","","mv_par04","","","","","","","","","","","","","","","","")  
	PutSx1(cPerg, "05","Fornecedor de      ?"," "," ","mv_ch05","C",06,0,0,"G","     ","SA2","","","mv_par05","","","","","","","","","","","","","","","","")
	PutSx1(cPerg, "06","Loja de            ?"," "," ","mv_ch06","C",02,0,0,"G","     ","   ","","","mv_par06","","","","","","","","","","","","","","","","")
	PutSx1(cPerg, "07","Fornecedor at้     ?"," "," ","mv_ch07","C",06,0,0,"G","     ","SA2","","","mv_par07","","","","","","","","","","","","","","","","") 
	PutSx1(cPerg, "08","Loja at้           ?"," "," ","mv_ch08","C",02,0,0,"G","     ","   ","","","mv_par08","","","","","","","","","","","","","","","","") 		

RETURN(NIL)