/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?FATV006   ?Autor  ?Ocimar Rolli        ? Data ?  20/02/19   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ?Funcao para validacao da altera??o da comiss?o do vendedor  ???
???          ?no or?amento de vendas                                      ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP - ALPAX.                                                ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/
User Function FATV006()

_lRet := .t.

If ! upper(Alltrim(cUserName)) $ "LUCI"
		ApMsgStop("Voce nao tem permissao para alterar o percentual de comissao") 
		_lRet := .f.
EndIf

Return(_lRet)
