#include "protheus.ch"
/*
PROJETO CRM SIMPLES ALPAX


*/
user function M410FSQL()

Private _cFiltrox := ""
Public  _cFilSA3  := ""

DBSELECTAREA("ZBD")
DBSETORDER(1)
DBGOTOP()
IF DBSEEK(XFILIAL("ZBD")+__cUserID)  
     _cFilSA3 := ALLTRIM(ZBD->ZBD_CODVEN)
else
     _cFilSA3 := "XXXXXX"

endif


If alltrim(UPPER(GETENVSERVER())) $ "CRM-PRODUCAO"  //APENAS EM AMBIENTE CRM-PRODUCAO
	
	PROCESSA({||_cFiltrox := MONTASQL()},"Gerando Filtro...","Gerando filtro...")
	 
	SetKey(VK_F8,{||U_F3PROD()})
ENDIF

return(_cFiltrox)


//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
STATIC FUNCTION MONTASQL()

Local _cRet := ""
Local _cIn  := ""
Private _cAlias1 := GetNextAlias()
Private _cAlias2 := GetNextAlias()
Public __AlpaxCli := ""   // VARIAVEL UTILIZADA PARA FIILTRAR CLIENTES NO F3

procregua(0)
incproc(time()+"  Filtrando...aguarde...")
               

BEGINSQL ALIAS _cAlias1
	
	SELECT TOP 250  A1_COD CLIENTE
	FROM %TABLE:SA1% A1 (NOLOCK)
	WHERE A1.%NOTDEL%
	AND A1.A1_FILIAL = %XFILIAL:SA1%
	AND A1.A1_VEND IN (
	SELECT A3_COD
	FROM %TABLE:SA3% A3 (NOLOCK)
	WHERE A3.%NOTDEL%
	AND A3.A3_FILIAL =   %XFILIAL:SA3%
	AND ( A3.A3_CODUSR = %EXP:__cUserId% OR A3.A3_SUPER = %EXP:__cUserId% OR A3.A3_GEREN = %EXP:__cUserId%)  )
	
ENDSQL

dbselectarea(_cAlias1)
dbgotop()
_cIn +="'"               

WHILE (_cAlias1)->(!eof())
	incproc(time()+"  Filtrando...aguarde...")    
	

	_cIn += AllTrim((_cAlias1)->CLIENTE) + "/"

 	(_cAlias1)->(dbskip())  
 	
ENDDO

_cRet += "  C5_CLIENT $ "+_cIn+"'"

MEMOWRIT("C:\TEMP\MATA410_SQL.SQL",_cRet)
      

BEGINSQL ALIAS _calias2

    SELECT A3_COD
	FROM %TABLE:SA3% A3 (NOLOCK)
	WHERE A3.%NOTDEL%
	AND A3.A3_FILIAL =   %XFILIAL:SA3%
	AND ( A3.A3_CODUSR = %EXP:__cUserId% OR A3.A3_SUPER = %EXP:__cUserId% OR A3.A3_GEREN = %EXP:__cUserId%)  

endsql

DBSELECTAREA(_calias2)
DBGOTOP()

WHILE (_calias2)->(!EOF())
	__AlpaxCli += "."+(_cAlias2)->A3_COD    //CLIENTES DO VENDEDOR

	 (_calias2)->(DBSKIP())
enddo	 

_cRet := AllTrim(_cRet) 

RETURN(_cRet)


