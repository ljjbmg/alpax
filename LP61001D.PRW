/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP61001D ºAutor  ³Ocimar              º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de DEBITO 610-001                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP61001D()

LOCAL _cRet := ""

Do Case
	Case SUBSTR(SD2->D2_CF,1,4) $ "5102/6102/5101/6101/5551/6551/5405/5110/6110/6404/5401/6401/5403/6403/5123/6123"  // VENDA MERCADO INTERNO / ATIVO IMOB. / VENDA SUBST. TRIB.
		_cRet := "112010001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5933/6933/9999/7933/5124/6124"       // SERVICO MERCADO INTERNO
		_cRet := "112010001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "7102/7933"		                    // VENDA/SERVICO EXPORTACAO
		_cRet := "112010005"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5202/6202/5201/6201/5556/6556/5553/6553/5410/6410/5411/6411/5413/6413"	    // DEVOLUCAO COMPRAS
		_cRet := "211010001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5911/6911"              		        // AMOSTRA GRATIS
		_cRet := "511010045"	
	Case SUBSTR(SD2->D2_CF,1,4) $ "5117/6117"              		        // SIMPLES REMESSA FAT. P/ ENTREGA FUTURA
		_cRet := "112010003"					
	Case SUBSTR(SD2->D2_CF,1,4) $ "5912/6912/5908/6908"               		    // REMESSA PARA DEMONSTRACAO
		_cRet := "114040003"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5119/6119/6118/6120/5118/5120"	    // VENDA A ORDEM DE REVENDA
		_cRet := "112010001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5927" 	                		    // REMESSA PARA CONSERTO
		_cRet := "512070007"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5913/6913"                           // RETORNO DE DEMONSTRAÇÃO
		_cRet := "216040005"				
	Case SUBSTR(SD2->D2_CF,1,4) $ "5922/6922" 			                // VENDA EMPENHO
		_cRet := "112010001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "6108/6107"         			        // VENDA A NAO CONTRIBUINTE REV. OU INDUST.
		_cRet := "112010001"	   					
	Case SUBSTR(SD2->D2_CF,1,4) $ "5110/6110/5109/6109"                 // VENDA A AREA DE LIVRE COMERCIO
		_cRet := "112010001"				
	Case SUBSTR(SD2->D2_CF,1,4) $ "5910/6910"                           // BONIFICACAO, DOACAO OU BRINDE
		_cRet := "511010045"
EndCase

Return(_cRet)
