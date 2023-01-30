/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP65001D ºAutor  ³Ocimar              º Data ³  21/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de DEBITO 650-001                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP65001D()

LOCAL _cRet := ""
_aArea 		:= GetArea()
_aAreaB1 	:= SB1->(GetArea())
_aAreaD1    := SD1->(GetArea())
DbSelectArea("SB1")
DbSeek(xFilial("SB1")+SD1->D1_COD)
Do Case
	Case SUBSTR(SD1->D1_CF,1,4) $ "1403/2403/1102/2102/1403/2403"	  			// COMPRA MERCADORIA
		If SB1->B1_TIPO == 'EM'
			_cRet := "114010003"
		Else
			_cRet := "114010012"
		EndIf
	Case SUBSTR(SD1->D1_CF,1,4) $ "1101/2101/1401/2401/1122/2122/1116/2116"	    // COMPRA P/ INDUSTRIALIZACAO / RET. INDUSTR.
		_cRet := "114010061"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1925/2925" 					                // COMPRA P/ INDUSTRIALIZACAO / RET. INDUSTR.
		_cRet := "114010020"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1122/2122"                       		    // ENTRADA DE INDUSTRIALIZACAO / RET. INDUSTR.
		_cRet := "114010061"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1922/2922"           		                // COMPRA PARA ENTREGA FUTURA
		_cRet := "114020001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1933/2933/3933"                  			// SERVICO
		_cRet := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_CONTA")	    //  VERIFICAR COM ADRIANO (FORN.  000874)
	Case SUBSTR(SD1->D1_CF,1,4) $ "3102/3949"	              		        	// COMPRA IMPORTACAO P/ REVENDA
		_cRet := "114010015"
	Case SUBSTR(SD1->D1_CF,1,4) == "3101"	                        			// COMPRA IMPORTACAO P/ INDUSTRIALIZACAO
		_cRet := "114010040"
	Case SUBSTR(SD1->D1_CF,1,4) == "3949"	              	            		// SIMPLES REMESSA IMPORTACAO P/ INDUSTRIALIZACAO
		_cRet := "41101020010"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1125/2125/1124/2124"	   		            	// INDUSTR. POR ENCOMENDA
		_cRet := "41101020004"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1202/2202/2204/1411/2411"		 			// DEVOLUCAO VENDAS REV.
		_cRet := "312010001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1201/2201/1410/2410"			  			    // DEVOLUCAO VENDAS INDUST.
		_cRet := "312030001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1653/2653"   	             	  			// COMPRA DE COMBUSTIVEL
		_cRet := "411010033"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1913/2913/1909/2909"			 		                // RETORNO DE DEMONSTRACAO
		_cRet := "114010017"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1902/2902" 		             	 		    // RETORNO DE INDUSTRIALIZACAO
		_cRet := "114010020"
		//	Case SUBSTR(SD1->D1_CF,1,4) $ "1916/2916"                       			// RETORNO DE CONSERTO
		//		_cRet := "114010033"
		//	Case SUBSTR(SD1->D1_CF,1,4) $ "1914/2914"             		            	// RETORNO DE EXPOSICAO OU FEIRA
		//		_cRet := "114010028"
	Case SUBSTR(SD1->D1_CF,1,4) == "1253"                            			// CONTA DE ENERGIA ELETRICA
		_cRet := "512040019"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1303/2303"                           	    // CONTA TELEFONICA
		_cRet := "511010025"
	Case SUBSTR(SD1->D1_CF,1,4) == "1928"                                	    // AGUA
		_cRet := "512040017"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1407/2407/1556/2556/3556" 	            	// MATERIAL USO E CONSUMO
		If SD1->D1_COD == "12048AETA117002"
			_cRet := "511010052"
		Else
			_cRet := "114060001"
		EndIf
	Case SUBSTR(SD1->D1_CF,1,4) == "1553"                               	    // DEVOLUCAO VENDA ATIVO
		_cRet := "612010008"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1917/2917"                                   // ENTRADA POR COMODATO
		_cRet := "114050003"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1912/2912"                                   // ENTRADA POR COMODATO
		_cRet := "114050002"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353"   	             	        	// MATERIAL USO E CONSUMO FRETE
		_cRet := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_CONTA")
	Case SUBSTR(SD1->D1_CF,1,4) $ "1922/2922" 			  		            	// MATERIAL USO E CONSUMO FRETE
		_cRet := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_CONTA")
	Case SUBSTR(SD1->D1_CF,1,4) $ "1551/2551/1406/2406"			    			// ATIVO FIXO
		If SD1->D1_VUNIT < 326.26
			_cRet := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_CONTA")   // IMOBILIZADO DE PEQUENO PORTE
		Else
			_cRet := "117020003"
		EndIf
		
EndCase

RestArea(_aAreaB1)
RestArea(_aAreaD1)
RestArea(_aArea)

Return(_cRet)
