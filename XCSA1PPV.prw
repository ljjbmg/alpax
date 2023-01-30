#Include "Protheus.ch"        
           
STATIC _xCodcli := Space(len(SA1->A1_COD))
STATIC _xLojcli := Space(len(SA1->A1_LOJA))
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณXCSA1PPV  บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCONSULTA ESPECIFICA DE CADASTRO DE CLIENTE                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function XCSA1PPV()

Local OLIST
Local nSldEst := 0  
Local nOpca   := 0
Local cQry    := ""    
Local cCod    := ""
Local aTmp    := {}
Local cAlias  := GetNextAlias()

Private _oDlg
Private nLista 
Private aLista := {}

cCod := POSICIONE("ZBD",1,xFilial("ZBD")+M->ZBH_CODUSR,"ZBD_CLIENT" )

aTmp    := SEPARA(cCod,"|")
cCod := ""

FOR nI := 1 to len(aTmp)  
	IF !EMPTY(aTmp[nI])
		cCod += "'"+aTmp[nI]+"',"
	ENDIF	
Next nI
cCod := SUBSTR(cCod,1,LEN(cCod)-1)

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

cQry := "SELECT * "
cQry += "FROM "+ retSqlName("SA1") +" SA1 "                           
cQry += "WHERE SA1.D_E_L_E_T_ = '' AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' AND A1_COD+A1_LOJA IN ("+cCod+") "
cQry += "ORDER BY A1_COD, A1_LOJA "

MEMOWRITE("D:\SESTQA01.SQL",cQry) //GRAVA A QUERY EM ALGUM LUGAR DO HD 

if tcSQLexec(cQry) < 0   //para verificar se a query funciona
	msginfo("Erro na consulta ao Banco de Dados Favor entrar em contato com Depto TI")
	return
Endif

dbUseArea(.T., "TOPCONN",TCGENQRY(,,cQry),cAlias,.F.,.T.)

DO WHILE (cAlias)->(!EOF())                 
	AADD(aLista, { (cAlias)->A1_COD, (cAlias)->A1_LOJA, ALLTRIM((cAlias)->A1_NOME), (cAlias)->A1_CGC, alltrim((cAlias)->A1_END), Alltrim((cAlias)->A1_MUN), (cAlias)->A1_EST  } )
	(cAlias)->(dbSkip())
Enddo	
					
DEFINE MSDIALOG _oDlg TITLE "Consulta Saldo" FROM (0),(0) TO 300, 800  PIXEL

	@ 05,05 LISTBOX oList VAR nLista FIELDS HEADER "C๓digo", "Loja", "Nome", "CGC/CPF", "Endere็o", "Municipio", "Estado" PIXEL SIZE  390, 120 of _oDlg 
	oList:SetArray( aLista )
	oList:bLine := {|| {   aLista[oList:nAt,1],;
					       aLista[oList:nAt,2],;
					       aLista[oList:nAt,3],;
					       aLista[oList:nAt,4],;
					       aLista[oList:nAt,5],;
					       aLista[oList:nAt,6],;
					       aLista[oList:nAt,7] } }

DEFINE SBUTTON FROM 130,5  TYPE 1 ACTION XVSA1PPV(oList:nAt) ENABLE OF _oDlg
DEFINE SBUTTON FROM 130,40 TYPE 2 ACTION _oDlg:End()         ENABLE OF _oDlg

ACTIVATE MSDIALOG _oDlg CENTERED

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

Return(.T.)             
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณXVSA1PPV  บAutor  ณMicrosiga           บ Data ณ  26/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFUNวรO AUXILIAR PARA VALIDAวรO DA CONSULTA                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                       
STATIC FUNCTION XVSA1PPV(_nPos)                    

M->ZBH_CLIENT := aLista[_nPos,1]
M->ZBH_LOJA   := aLista[_nPos,2]

_oDlg:End()

RETURN()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณXCSA1PP1  บAutor  ณMicrosiga           บ Data ณ  26/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFUNวรO AUXILIAR PARA RETORNO DA CONSULTA                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION XCSA1PP1()
RETURN