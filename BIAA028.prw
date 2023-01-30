#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BIAA028   ºAutor  ³Fagner S. Pinto     º Data ³  16/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ROTINA CRIADA PARA FORMATAR O CAMPO DE ENDEREÇO DA TABELA   º±±
±±º          ³DE CLIENTES DE ACORDO COM AS ESPECIFICAÇÕES DO SPED.        º±±
±±º          ³ESTA FUNÇÃO É DISPARADA POR GATILHOS DENTRO DOS CAMPOS:     º±±
±±º          ³A1_XTP_LOG, A1_XEND, A1_XNUM, A1_XCOMPL                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10 - ALPAX                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
USER FUNCTION BIAA028()

Local lRet := .t.
Local cEnd := ''
Local nTpLogradouro := '' 
lOCAL aArea := GetArea()                                   

           
DbSelectArea("SX5")
DbSetOrder(1)
DbGoTop()

if DbSeek(xfilial("SX5")+'ZA',.T.)
	While SX5->(!EOF()) .and. SX5->X5_TABELA == 'ZA'
	   If ALLTRIM(SX5->X5_CHAVE) == alltrim(M->A1_XTP_LOG) 
			nTpLogradouro := ALLTRIM(SX5->X5_CHAVE)
	   EndIf
	   SX5->(DbSkip())
	Enddo
Endif
RestArea(aArea)


cEnd := nTpLogradouro + ' '+ ALLTRIM(M->A1_XEND) + ', ' + ALLTRIM(M->A1_XNUM)

If len(cEnd) > 40 .and. empty(M->A1_XCOMPL)
	Alert('O campo Logradouro deve ser abreviado !')
	cEnd := ''
	Return cEnd                                                                                                         
Endif

Return cEnd   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BIAA028B  ºAutor  ³Fagner S. Pinto     º Data ³  16/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ROTINA CRIADA PARA FORMATAR O CAMPO DE ENDEREÇO DA TABELA   º±±
±±º          ³DE FORNECEDORES DE ACORDO COM AS ESPECIFICAÇÕES DO SPED.    º±±
±±º          ³ESTA FUNÇÃO É DISPARADA POR GATILHOS DENTRO DOS CAMPOS:     º±±
±±º          ³A2_XTP_LOG, A2_XEND, A2_XNUM, A2_XCOMPL                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10 - ALPAX                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
USER FUNCTION BIAA028B()

Local lRet := .t.
Local cEnd := ''
Local nTpLogradouro := ''                                  
lOCAL aArea := GetArea()                                   
          
DbSelectArea("SX5")
DbSetOrder(1)
DbGoTop()

if DbSeek(xfilial("SX5")+'ZA',.T.)
	While SX5->(!EOF()) .and. SX5->X5_TABELA == 'ZA'
	   If ALLTRIM(SX5->X5_CHAVE) == alltrim(M->A2_XTP_LOG) 
			nTpLogradouro := ALLTRIM(SX5->X5_CHAVE)
	   EndIf
	   SX5->(DbSkip())
	Enddo
Endif

RestArea(aArea)

cEnd := nTpLogradouro + ' '+ ALLTRIM(M->A2_XEND) + ', ' + ALLTRIM(M->A2_XNUM)

If len(cEnd) > 40 
	Alert('O campo Logradouro deve ser abreviado !')
	cEnd := ''
	Return cEnd                                                                                                         
Endif

Return cEnd 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BIAA028C  ºAutor  ³Fagner S. Pinto     º Data ³  16/07/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ROTINA CRIADA PARA FORMATAR O CAMPO DE ENDEREÇO DA TABELA   º±±
±±º          ³DE FORNECEDORES DE ACORDO COM AS ESPECIFICAÇÕES DO SPED.    º±±
±±º          ³ESTA FUNÇÃO É DISPARADA POR GATILHOS DENTRO DOS CAMPOS:     º±±
±±º          ³A4_XTP_LOG, A4_XEND, A4_XNUM, A4_XCOMPL                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10 - ALPAX                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
USER FUNCTION BIAA028C()

Local lRet := .t.
Local cEnd := ''
Local nTpLogradouro := ''                                  
lOCAL aArea := GetArea()                                   
          
DbSelectArea("SX5")
DbSetOrder(1)
DbGoTop()

if DbSeek(xfilial("SX5")+'ZA',.T.)
	While SX5->(!EOF()) .and. SX5->X5_TABELA == 'ZA'
	   If ALLTRIM(SX5->X5_CHAVE) == alltrim(M->A4_XTP_LOG) 
			nTpLogradouro := ALLTRIM(SX5->X5_CHAVE)
	   EndIf
	   SX5->(DbSkip())
	Enddo
Endif

RestArea(aArea)

cEnd := nTpLogradouro + ' '+ ALLTRIM(M->A4_XEND) + ', ' + ALLTRIM(M->A4_XNUM)

If len(cEnd) > 40 
	Alert('O campo Logradouro deve ser abreviado !')
	cEnd := ''
	Return cEnd                                                                                                         
Endif


Return cEnd