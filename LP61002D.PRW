/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP61002D ºAutor  ³Ocimar              º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de DEBITO 610-002                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP61002D()

LOCAL _cRet := ""

Do Case
	Case SUBSTR(SD2->D2_CF,1,4) $ "5102/6102/5403/6403/5123/6123/6404/6405/5405" // VENDA MERCADO INTERNO
		_cRet := "312010007"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5101/6101/5401/6401/6109/5118/6118"                     // VENDA MERCADO INTERNO PRODUCAO
		_cRet := "312030006"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5202/6202/5411/6411"                          // DEVOLUCAO COMPRAS REV.
		_cRet := "114010027"      
	Case SUBSTR(SD2->D2_CF,1,4) $ "5201/6201"                                    // DEVOLUCAO COMPRAS INDUST.
		_cRet := "114010052"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5556/6556"                                    // DEV. MAT. CONSUMO
		_cRet := "613010007"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5911/6911"                                    // AMOSTRA GRATIS / DOACAO / BONIFICACAO / BRINDE
		_cRet := "512070001"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5912/6912"                                    // REMESSA PARA DEMONSTRACAO
		_cRet := "113030011"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5913/6913"                                    // RETORNO DE DEMONSTRACAO
		_cRet := "113030011"
	Case SUBSTR(SD2->D2_CF,1,4) $ "6108"                                         // VENDA A NAO CONTRIBUINTE REV.
		_cRet := "312010007"				
	Case SUBSTR(SD2->D2_CF,1,4) $ "6107"                                         // VENDA A NAO CONTRIBUINTE INDUST.
		_cRet := "312030006"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5117/6117"                                    // SIMPLES REMESSA EMPENHO REV.
		_cRet := "312010007"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5116/6116"                                    // SIMPLES REMESSA EMPENHO INDUST.
		_cRet := "312030006"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5914/6914"                                    // REMESSA PARA EXPOSICAO OU FEIRA
		_cRet := "113030011"   
	Case SUBSTR(SD2->D2_CF,1,4) $ "5551/6551"                                    // VENDA ATIVO IMOB.
		_cRet := "613010007"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5119/6119/5120/6120"                                    // VENDA A ORDEM REVENDA
		_cRet := "312010007"				
	Case SUBSTR(SD2->D2_CF,1,4) $ "5910/6910/5949/6949"                          // SIMPLES REMESSA COM IMPOSTO
		_cRet := "512070001"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5110/6110"                                    // VENDA PARA ZONA FRANCA DE MANAUS
		_cRet := "312010007" 
	Case SUBSTR(SD2->D2_CF,1,4) $ "5918/6918"                                    // VENDA PARA ZONA FRANCA DE MANAUS
		_cRet := "114050004"				
EndCase

Return(_cRet)