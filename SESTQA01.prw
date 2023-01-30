#Include "Protheus.ch"        
#INCLUDE "FWBROWSE.CH"
           

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SESTQA01  ºAutor  ³Microsiga           º Data ³  26/01/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³CONSULTA ESPECIFICA DE SALDO DE PRODUTO                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ALPAX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/            

user function  SESTQA01()
Local oColumn
Local oDlg
Local cQuery := ""
Local aIndex := {}
Local aSeek  := {}
Local _nPos		:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "ZBI_CODPRO"})

Local cTipo   := SuperGetMV("AX_TPPRODC", , "ME|")
Local cLocal  := SuperGetMV("AX_LCPRODC", , "01|")
Local aTmp    := SEPARA(cTipo,"|")
Local aTmp    := SEPARA(cTipo,"|")
Private oBrowse
Private _xSair := .F.
_xCodPro := Space(len(SB1->B1_COD)) 


cTipo := ""
FOR nI := 1 to len(aTmp)  
	IF !EMPTY(aTmp[nI])
		cTipo += "'"+aTmp[nI]+"',"
	ENDIF	
Next nI
cTipo := SUBSTR(cTipo,1,LEN(cTipo)-1)

aTmp    := SEPARA(cLocal,"|")
cLocal := ""
FOR nI := 1 to len(aTmp)  
	IF !EMPTY(aTmp[nI])
		cLocal += "'"+aTmp[nI]+"',"
	ENDIF	
Next nI
cLocal := SUBSTR(cLocal,1,LEN(cLocal)-1)

//-------------------------------------------------------------------
// Abertura da tabela
//-------------------------------------------------------------------
cQry := " SELECT (B2_QATU - B2_QEMP - B2_RESERVA - B2_QPEDVEN) SALDO, B1_COD, B1_PNUMBER, B1_DESC, B1_MARCA, B1_CAPACID, B2_LOCAL "
cQry += " FROM "+ retSqlName("SB2") +" SB2 (NOLOCK)  "                           
cQry += " INNER JOIN "+ retSqlName("SB1") +" SB1 (NOLOCK) ON SB1.D_E_L_E_T_ = '' AND B1_COD = B2_COD AND B1_TIPO IN ("+cTipo+") AND B1_FILIAL = '"+xFilial("SB1")+"' "
cQry += " WHERE SB2.D_E_L_E_T_ = '' AND SB2.B2_FILIAL = '"+xFilial("SB2")+"' AND B2_LOCAL IN ("+cLocal+") "
cQry += "   AND (B2_QATU - B2_QEMP - B2_RESERVA - B2_QPEDVEN) > 0
cQry += " ORDER BY B2_COD, B2_LOCAL "
                                                               
cQuery := cQry

MEMOWRITE("D:\TEMP\SESTQA01.SQL",cQry) //GRAVA A QUERY EM ALGUM LUGAR DO HD 

//-------------------------------------------------------------------
// Indica os índices da tabela temporária
//-------------------------------------------------------------------
Aadd( aIndex, "B1_COD"  )
Aadd( aIndex, "B1_PNUMBER" )
Aadd( aIndex, "B1_DESC" )

//-------------------------------------------------------------------
// Indica as chaves de Pesquisa
//-------------------------------------------------------------------
Aadd( aSeek, { "Código"    , {{"","C",15,0,"Código"   ,,}} } )
Aadd( aSeek, { "PartNumber", {{"","C",20,0,"PartNumber",,}} } )
Aadd( aSeek, { "Descrição" , {{"","C",75,0,"Descrição",,}} } )

Private oPanel1
  DEFINE MSDIALOG oDlg TITLE "Estoque Especifico" FROM 000, 000  TO 300, 1000 COLORS 0, 16777215 PIXEL
    @ 005, 005 MSPANEL oPanel1 PROMPT "oPanel" SIZE 490, 120 OF oDlg  RAISED


	//-------------------------------------------------------------------
	// Define o Browse
	//-------------------------------------------------------------------
	DEFINE FWBROWSE oBrowse DATA QUERY ALIAS "TRB" QUERY cQuery FILTER SEEK ORDER aSeek INDEXQUERY aIndex OF oPanel1
		//-------------------------------------------------------------------
		// Adiciona as colunas do Browse
		//-------------------------------------------------------------------
		ADD COLUMN oColumn DATA { ||  B1_COD       } TITLE "Código"      SIZE 15 OF oBrowse
		ADD COLUMN oColumn DATA { ||  B1_PNUMBER   } TITLE "P.Number"    SIZE 20 OF oBrowse
		ADD COLUMN oColumn DATA { ||  B1_DESC      } TITLE "Descrição"   SIZE 75 OF oBrowse
		ADD COLUMN oColumn DATA { ||  B2_LOCAL     } TITLE "Arm."        SIZE  4 OF oBrowse

		ADD COLUMN oColumn DATA { ||  B1_MARCA    } TITLE "Marca"        SIZE 20 OF oBrowse
		ADD COLUMN oColumn DATA { ||  B1_CAPACID   } TITLE "Capacidade"  SIZE 20 OF oBrowse
		ADD COLUMN oColumn DATA { ||  SALDO   } TITLE "Saldo"            PICTURE "@E 999,999.99" SIZE 20 OF oBrowse						
		//-------------------------------------------------------------------    
	// Ativação do Browse
	//-------------------------------------------------------------------
	ACTIVATE FWBROWSE oBrowse
//-------------------------------------------------------------------
// Ativação do janela
//-------------------------------------------------------------------


    DEFINE SBUTTON oSButton1 FROM 130, 005 TYPE 01 OF oDlg ENABLE ACTION (_xCodPro := TRB->B1_COD,_xSair := .T. ,  oDlg:End())
    DEFINE SBUTTON oSButton2 FROM 130, 040 TYPE 02 OF oDlg ENABLE ACTION (_xCodPro := SLACE(15),_xSair := .T. ,  oDlg:End())


ACTIVATE MSDIALOG oDlg CENTERED valid _xSair


ACOLS[n,_nPos] := _xCodPro
M->ZBI_CODPRO  :=  _xCodPro

Return

USER FUNCTION SESTQAB1()

Local _nPos		:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "ZBI_CODPRO"})

ACOLS[n,_nPos] := _xCodPro
M->ZBI_CODPRO  :=  _xCodPro

RETURN(_xCodPro)

/*
User Function SESTQA01()

Local nSldEst := 0  
Local nOpca   := 0
Local cQry    := ""
Local cAlias  := GetNextAlias()
Local cTipo   := SuperGetMV("AX_TPPRODC", , "ME|")
Local cLocal  := SuperGetMV("AX_LCPRODC", , "01|")
Local aTmp    := SEPARA(cTipo,"|")

Private OLIST
Private _oDlg
Private nLista := 0
Private aLista := {}

cTipo := ""
FOR nI := 1 to len(aTmp)  
	IF !EMPTY(aTmp[nI])
		cTipo += "'"+aTmp[nI]+"',"
	ENDIF	
Next nI
cTipo := SUBSTR(cTipo,1,LEN(cTipo)-1)

aTmp    := SEPARA(cLocal,"|")
cLocal := ""
FOR nI := 1 to len(aTmp)  
	IF !EMPTY(aTmp[nI])
		cLocal += "'"+aTmp[nI]+"',"
	ENDIF	
Next nI
cLocal := SUBSTR(cLocal,1,LEN(cLocal)-1)

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

cQry := " SELECT (B2_QATU - B2_QEMP - B2_RESERVA - B2_QPEDVEN) SALDO, * "
cQry += " FROM "+ retSqlName("SB2") +" SB2 (NOLOCK)  "                           
cQry += " INNER JOIN "+ retSqlName("SB1") +" SB1 (NOLOCK) ON SB1.D_E_L_E_T_ = '' AND B1_COD = B2_COD AND B1_TIPO IN ("+cTipo+") AND B1_FILIAL = '"+xFilial("SB1")+"' "
cQry += " WHERE SB2.D_E_L_E_T_ = '' AND SB2.B2_FILIAL = '"+xFilial("SB2")+"' AND B2_LOCAL IN ("+cLocal+") "
cQry += "   AND (B2_QATU - B2_QEMP - B2_RESERVA - B2_QPEDVEN) > 0
cQry += " ORDER BY B2_COD, B2_LOCAL "

MEMOWRITE("D:\TEMP\SESTQA01.SQL",cQry) //GRAVA A QUERY EM ALGUM LUGAR DO HD 

if tcSQLexec(cQry) < 0   //para verificar se a query funciona
	msginfo("Erro na consulta ao Banco de Dados Favor entrar em contato com Depto TI")
	return
Endif

dbUseArea(.T., "TOPCONN",TCGENQRY(,,cQry),cAlias,.F.,.T.)

PROCESSA({||aLista := CARGAEST(cAlias,aLista)}, "Analise Estoque")
					
DEFINE MSDIALOG _oDlg TITLE "Consulta Saldo" FROM (0),(0) TO (630),(1000) PIXEL
	
	@ 05,05 LISTBOX oList FIELDS HEADER "Código", "PNumber", "Descrição", "Armazém", "Capacidade", "Marca", "Saldo" PIXEL SIZE 500,280 of _oDlg 
	oList:SetArray( aLista )
  	oList:bLine := {|| {   aLista[oList:nAt,1],;
					       aLista[oList:nAt,2],;
					       aLista[oList:nAt,3],;
					       aLista[oList:nAt,4],;
					       aLista[oList:nAt,5],;
					       aLista[oList:nAt,6],;
					       aLista[oList:nAt,7] } }      					       
DEFINE SBUTTON FROM 290,5  TYPE 1 ACTION SESTQAVD(oList:nAt) ENABLE OF _oDlg
DEFINE SBUTTON FROM 290,40 TYPE 2 ACTION _oDlg:End()         ENABLE OF _oDlg

ACTIVATE MSDIALOG _oDlg CENTERED

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

Return(.T.)             



STATIC FUNCTION SESTQAVD(_nPos)                    

_xCodPro := aLista[_nPos,1] 
_oDlg:End()

RETURN






STATIC FUNCTION CARGAEST(cAlias,aLista)
                                
procregua(0)


DO WHILE (cAlias)->(!EOF())                 
    incproc(TIme()+" Carga Saldo Produto: "+(cAlias)->B1_PNUMBER)
    
	nSldEst :=  (cAlias)->SALDO  //SldAtuEst((cAlias)->B2_COD, (cAlias)->B2_LOCAL,99999,,,,, ,nil,nil,nil,nil,)
	AADD(aLista, {(cAlias)->B2_COD, (cAlias)->B1_PNUMBER, ALLTRIM((cAlias)->B1_DESC), (cAlias)->B2_LOCAL, (cAlias)->B1_CAPACID, (cAlias)->B1_MARCA, nSldEst  } )
	(cAlias)->(dbSkip()) 
	
Enddo	

RETURN(aLista)


*/