#Include 'Protheus.ch'
#Include "TOTVS.ch"

user function F811MAILTO()

local cEmail := SUPERGETMV("MV_XMAILFI", .T., "financeiro@alpax.com.br") 
local cRet := ''
Local aArea := GetArea()

if !empty(cEmail)
      cRet := SA1->A1_EMAIL+ ";" +cEmail 
else
      cRet := SA1->A1_EMAIL
endIf

RestArea(aArea)
return cRet

