/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP61005D ºAutor  ³Ocimar              º Data ³  30/08/06    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de DEBITO 610-005                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP61005D()

LOCAL _cRet := ""

Do Case
	Case SUBSTR(SD2->D2_CF,1,4) $ "5911/6911"  					                      // AMOSTRA GRATIS
		_cRet := "512070001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5912/6912"                                         // DEMONSTRACAO
		_cRet := "113030001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5910/6910"  		   			                      // BONIFICACAO, DOACAO OU BRINDE
		_cRet := "512070006" 		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5553/6553"  		   			                      // DEV. COMPRA ATIVO IMOBILIZADO
		_cRet := "613010008"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5116/6116"  		   			                      // REMESSA EMPENHO PRODUCAO
		_cRet := "312030009"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5101/6101/5401/6401/5403/6403/5108/5118/6118/6109" // VENDA PRODUCAO
		_cRet := "312030009"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5102/6102/6110/5123/6123/5119/6119/5922/6922/5117/6117/6108"	  // REVENDA
		_cRet := "312010002"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5201/6201"  		   		                          // DEVOLUCAO COMPRA PRODUCAO
		_cRet := "114010052"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5107/6107"  		   			                      // VENDA NAO CONTRIBUINTE PRODUCAO
		_cRet := "312030009"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5949/6949"  		   			                      // SIMPLES REMESSAO COM IMPOSTO
		_cRet := "512070006"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5914/6914"  		   			                      // REMESSA EXPOSICAO
		_cRet := "113030001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5918/6918"  		   			                      // RETORNO CONSIGNACAO
		_cRet := "114050013"	 
	Case SUBSTR(SD2->D2_CF,1,4) $ "5913/6913"  		   			                      // RETORNO DEMONSTRACAO
		_cRet := "113030001"																										 		
EndCase

Return(_cRet)
