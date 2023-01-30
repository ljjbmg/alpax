#INCLUDE "protheus.ch"

/*
CADASTRO DE PRECOS LABORATORIO

EDUARDO NAKAMATU

*/

User Function radvm03()


Private cCadastro := "Cadastro de Precos Laboratorio  
Private bInc := {|| FNINC() }
Private bAlt := {|| FNALT() }

Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
             {"Visualizar","AxVisual",0,2} ,;
             {"Incluir","eval(bInc)",0,3} ,;
             {"Alterar","eval(bAlt)",0,4} ,;
             {"Excluir","axexclui",0,5} }


dbSelectArea("ZA3")
dbgotop()
mBrowse( 6,1,22,75,"ZA3")

Return        
             
static function FNINC()

IF AXINCLUI("ZA3",ZA3->(RECNO()),3) == 1
	RECLOCK("ZA3",.F.)
	ZA3->ZA3_CHAVE := ZA3->(ZA3_NOME+ZA3_FXINI+ZA3_FXFIM)
	MSUNLOCK()
    COMMIT
ENDIF

RETURN

static function FNALT()

IF AXALTERA("ZA3",ZA3->(RECNO()),4) == 1
	RECLOCK("ZA3",.F.)
	ZA3->ZA3_CHAVE := ZA3->(ZA3_NOME+ZA3_FXINI+ZA3_FXFIM)
	MSUNLOCK()
    COMMIT
ENDIF

RETURN





