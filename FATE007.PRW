/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?FATE007   ?Autor  ?Microsiga           ? Data ?  02/07/05   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ?Execblock para trazer automaticamente o endereco de entrega ???
???          ?no browse do SF2                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP - Alpax                                                 ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/                       
User Function FATE007()

_cRet := ""

If SA1->(DbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA))
	If Empty(SA1->A1_ENDENT)
		_cRet := Alltrim(SA1->A1_END) + "-" + Alltrim(SA1->A1_BAIRRO) + "-" + Alltrim(SA1->A1_MUN) + "-" + Alltrim(SA1->A1_EST) + "-CEP:" + Transform(SA1->A1_CEP,"@R 99999-999")
	Else
		_cRet := Alltrim(SA1->A1_ENDENT) + "-" + Alltrim(SA1->A1_BAIRROE) + "-" + Alltrim(SA1->A1_MUNE) + "-" + Alltrim(SA1->A1_ESTE) + "-CEP:" + Transform(SA1->A1_CEPE,"@R 99999-999")
	EndIf
EndIf

Return(_cRet)