/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP65001C ºAutor  ³Ocimar              º Data ³  21/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de CREDITO 650-001                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP65001C()

LOCAL _cRet := ""
Do Case
	Case SUBSTR(SD1->D1_CF,1,4) $ "1102/2102/1101/2101/1122/2122/1401/2401/1922/2922/1403/2403/1122/2122"   // COMPRA MERCADORIA / COMPRA P/ INDUSTR. S/ TANS. ALPAX
		_cRet := "211010001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1933/2933/3933"     			    // SERVICO 
		_cRet := "213030007"
	Case SUBSTR(SD1->D1_CF,1,4) $ "3102/3101/3949"	       			    // COMPRA IMPORTACAO
		_cRet := "211020001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1202/2202/1201/2201/2204/1553/2553/1411/2411/1410/2410"	    // DEVOLUCAO VENDAS
		_cRet := "112010001"		
	Case SUBSTR(SD1->D1_CF,1,4) $ "1902/2902"   	     	 	    // RETORNO DE INDUSTRIALIZACAO
		_cRet := "114040001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1913/2913/1909/2909"		  		        // RETORNO DE DEMONSTRACAO
		_cRet := "114040003"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1653/2653" 		 		        // COMPRA DE COMBUSTIVEL
		_cRet := "211010001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1912/2912"            		    // ENTRADA PARA DEMONSTRACAO
		_cRet := "216040005"				
//	Case SUBSTR(SD1->D1_CF,1,4) $ "1914/2914"            		    // RETORNO DE EXPOSICAO OU FEIRA
//		_cRet := "114040004"
	Case SUBSTR(SD1->D1_CF,1,4) == "1253"           		        // CONTA DE ENERGIA ELETRICA
		_cRet := "213030002"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1303/2303"         			        // CONTA TELEFONICA
		_cRet := "213030001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353"        		        // CONTA TRANSPORTADORA
		_cRet := "213010003"				
	Case SUBSTR(SD1->D1_CF,1,4) $ "1407/2407/1556/2556/3556/1125/2125/1124/2124"   // MATERIAL USO CONSUMO / INDUSTR. POR ENCOMENDA
		If (SD1->D1_COD) == "080487660117002"
			_cRet := "213030007"
			else
			_cRet := "211010001"				                                     
		EndIf
	Case SUBSTR(SD1->D1_CF,1,4) $ "1929/1551/2551/1406/2406"				    // COMBUSTIVEIS
		_cRet := "211010001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1917/2917"        		        // ENTRADA POR COMODATO
		_cRet := "114050001" 
	Case SUBSTR(SD1->D1_CF,1,4) $ "1925/2925"	 		            // RET. INDUSTR.
		_cRet := "114040001"
//	Case SUBSTR(SD1->D1_CF,1,4) $ "1601"  			        	    // TRANSF. CRED. ICMS
//		_cRet := "112010001" 
	Case SUBSTR(SD1->D1_CF,1,4) $ "1928"  			        	    // SANED
		_cRet := "213030004"		
	Case SUBSTR(SD1->D1_CF,1,4) $ "1116/2116"  			        	    // ENTRADA DE FAT. P/ ENT. FUTURA
		_cRet := "114020001"		

EndCase

Return(_cRet)
