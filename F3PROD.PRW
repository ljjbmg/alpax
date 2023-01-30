#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWBROWSE.CH"

/*
PROJETO CRM SIMPLES ALPAX
*/

USER FUNCTION F3PRODX()
U_F3PROD(.T.)
RETURN


USER FUNCTION F3PROD(lOk)   
Local _nOpc:=1
Private oDlg, oBtnP, oBtnS, oCombo, nCombo := 1, oOrdem, oPanel, oGet1, cGet1 := space(100), oPesquisar,oBrw1
Private _lSair := .F.
Private _calias1 := GetNextAlias(), _cQuery := ""
Default lOk := .f.
pRIVATE _bClick :=  {|| GRVGRID() }
If ! lOk
	Private _cCpo := READVAR()
	
	cGet1 := &_cCpo + space(100)
	
	
	IF !_cCPO $ "M->CK_PRODUTO.M->C6_PRODUTO"
		RETURN
	ENDIF
ELSE
	Private _cCpo := " "
ENDIF                                           

DEFINE MSDIALOG oDlg TITLE "Selecionar Produtos Alpax" FROM 000, 000  TO 500, 1200  PIXEL
@ 015, 165 BUTTON oBtnP PROMPT "Selecionar" SIZE 050, 012 OF oDlg PIXEL ACTION  (_lSair := .T., eval(_bClick) , oDlg:End())
@ 015, 220 BUTTON oBtnS PROMPT "Sair" SIZE 050, 012 OF oDlg PIXEL action (_lSair := .T., oDlg:End())
@ 015, 040 MSCOMBOBOX oCombo VAR nCombo ITEMS {"PNUMBER","Codigo","Descricao"} SIZE 120, 010 OF oDlg COLORS 0, 16777215 PIXEL
@ 015, 015 SAY oOrdem PROMPT "Ordem" SIZE 025, 010 OF oDlg COLORS 0, 16777215 PIXEL
@ 045, 005 MSPANEL oPanel SIZE 590, 195 OF oDlg COLORS 0, 16777215 RAISED
@ 030, 040 MSGET oGet1 VAR cGet1  PICTURE "@!" SIZE 450, 010 OF oDlg COLORS 0, 16777215 PIXEL
@ 030, 015 SAY oPesquisar PROMPT "Pesquisar" SIZE 025, 010 OF oDlg COLORS 0, 16777215 PIXEL

GETQRY(1)

DEFINE FWBROWSE oBrw1 DATA QUERY ALIAS _cALias1 QUERY _cQuery OF oPanel
//-------------------------------------------------------------------
// Adiciona as colunas do Browse
//-------------------------------------------------------------------
ADD COLUMN oColumn DATA { ||  B1_COD      } TITLE "Codigo"    SIZE 15 OF oBrw1
ADD COLUMN oColumn DATA { ||  B1_PNUMBER  } TITLE "PNNumber"  SIZE 15 OF oBrw1
ADD COLUMN oColumn DATA { ||  B1_DESC     } TITLE "Desc"      SIZE 30 OF oBrw1
ADD COLUMN oColumn DATA { ||  B1_CAPACID  } TITLE "Capacid."  SIZE 15 OF oBrw1
ADD COLUMN oColumn DATA { ||  B1_MARCA    } TITLE "Marca"     SIZE 15 OF oBrw1
ADD COLUMN oColumn DATA { ||  alltrim(TRANSFORM(SALDO,"@E 999,999.99"))  } TITLE "Saldo"    SIZE 10 OF oBrw1
ADD COLUMN oColumn DATA { ||  IIF(PRECO < 0.2,"SOB CONSULTA",alltrim(TRANSFORM(PRECO,"@E 999,999.99")))} TITLE "Preco"    SIZE 10 OF oBrw1

GETQRY(2)
//-------------------------------------------------------------------
// Ativação do Browse
//-------------------------------------------------------------------
ACTIVATE FWBROWSE oBrw1

oGet1:bChange := {||GETQRY(1), GETQRY(2)}
oBrw1:BLDBLCLICK := _bClick

ACTIVATE MSDIALOG oDlg CENTERED VALID _lSair ON INIT oGet1:SETFOCUS()



RETURN



STATIC FUNCTION GETQRY(_nOpc)

local _nlin 
if _nOpc == 1
	
	_cLike := IIF(EMPTY(cGet1),"A;",cGet1)
	_cLike := STRTRAN(_cLike," ",";")
	_aLike := separa(_cLike,";",.f.)
	
	_cQuery := " SELECT top 2000 ISNULL(B2.B2_QATU-(B2.B2_QPEDVEN+B2.B2_RESERVA),'0') SALDO,B1.B1_PNUMBER,B1.B1_MARCA, B1_CAPACID, B1_DESC, B1_COD, B1.R_E_C_N_O_ B1REG, CASE WHEN (B1_PRV1 < 0.2) THEN 0 ELSE B1_PRV1 END PRECO  "+CHR(13)+CHR(10)
	_cQuery += " FROM "+RETSQLNAME("SB1")+" B1 (NOLOCK)  "+CHR(13)+CHR(10)
	_cQuery += " LEFT JOIN "+RETSQLNAME("SB2")+" B2 (NOLOCK) ON B2.D_E_L_E_T_ = '' AND B2.B2_FILIAL = '01' AND B2.B2_LOCAL = B1.B1_LOCPAD  AND B1_COD = B2_COD "+CHR(13)+CHR(10)
	_cQuery += " WHERE B1.D_E_L_E_T_ = ''  AND B1_MSBLQL <> '1' AND B1_TIPO = 'ME' AND B1_LOCPAD = '01' "+CHR(13)+CHR(10)
	_cQuery += " AND  "+CHR(13)+CHR(10)
	_cQuery += "   (  "+CHR(13)+CHR(10)
	
	FOR _nLin := 1 to len(_aLike)
		IF _nLin > 1
			_cQuery += " OR "
		ENDIF
		_cQuery += "   B1.B1_PNUMBER  LIKE '%"+_aLike[_nLin]+"%' OR B1.B1_MARCA  LIKE '%"+_aLike[_nLin]+"%' OR B1_CAPACID  LIKE '%"+_aLike[_nLin]+"%' OR B1_DESC  LIKE '%"+_aLike[_nLin]+"%' OR B1_COD  LIKE '%"+_aLike[_nLin]+"%' "+CHR(13)+CHR(10)
	Next
	_cQuery += "   )  "+CHR(13)+CHR(10)
	
	IF oCombo:nAt == 1
		_cQuery += "ORDER BY B1_PNUMBER "
		
	elseif  oCombo:nAt == 2
		_cQuery += "ORDER BY B1_COD "
		
	ELSEIF  oCombo:nAt == 3
		_cQuery += "ORDER BY B1_DESC "
		
	endif
	
ELSE
	
	MEMOWRIT("C:\TEMP\F3PROD.SQL",_cQuery)
	
	oBrw1:SetQuery(_cQuery)
	oBrw1:refresh()
	
ENDIF

RETURN


STATIC FUNCTION GRVGRID()


DBSELECTAREA("SB1")
DBGOTOP()
SET ORDER TO 12              
DBGOTO((_cAlias1)->B1REG)  
//if DBSEEK(xFilial()+B1PNUMBER)   

IF _cCPO == "M->CK_PRODUTO"
	M->CK_PRODUTO :=  (_cAlias1)->B1_COD
ELSE
	M->C6_PRODUTO :=  (_cAlias1)->B1_COD
ENDIF

//endif

RETURN
