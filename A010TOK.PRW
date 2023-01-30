#include "protheus.ch"

user function A010TOK()

if ALTERA
   nValAtu := SB1->B1_UPRC
   nValNew := M->B1_UPRC  
   IF nValAtu <> nValNew
        DBSELECTAREA("SZ0") 
        RECLOCK("SZ0",.T.) 
        SZ0->Z0_FILIAL = XFILIAL("SZ0")
        SZ0->Z0_ALIAS  := "SB1"
        SZ0->Z0_DATA   := DATE()
        SZ0->Z0_HORA   := TIME()
        SZ0->Z0_CAMPO  := "B1_UPRC"
        SZ0->Z0_DADOORI:= TRANSFORM(nValAtu,"@E 999,999.99")
        SZ0->Z0_DADOGRV:= TRANSFORM(nValNew,"@E 999,999.99") 
        SZ0->Z0_USUARIO:= CUSERNAME
        SZ0->Z0_IPRMT  := GetClientIP()
        SZ0->Z0_OBS    := "Gravacao via ponto de entrada  A010TOK"

        MSUNLOCK()
        COMMIT
   ENDIF
ENDIF


return(.T.)