/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP65005C ºAutor  ³Ocimar              º Data ³   22/03/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de CREDITO 650-005                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP65005C()

LOCAL _cRet := ""

_aArea 		:= GetArea()
Do Case
	Case SUBSTR(SD1->D1_CF,1,4) $ "1101/1116/2116/2101/1122/2122/1401/2401/1403/2403/1122/2122"     	 	// COMPRA P/ INDUSTRIALIZACAO / ENTRADA INDUST. POR TERCEIROS
		_cRet := "114010061"		
	Case SUBSTR(SD1->D1_CF,1,4) $ "3101/1117/2117"	              			// COMPRA IMPORTACAO
		_cRet := "114010040"  
	Case SUBSTR(SD1->D1_CF,1,4) $ "1201/2201/1410/2410"			  			// DEVOLUCAO VENDAS PRODUCAO
		_cRet := "312030009"		
	Case SUBSTR(SD1->D1_CF,1,4) $ "1202/2202"			  			// DEVOLUCAO VENDAS REVENDA
		_cRet := "312010002"				
	Case SUBSTR(SD1->D1_CF,1,4) $ "1913/2913"			  			// RETORNO DE DEMONSTRACAO
		_cRet := "113030001"				 
	Case SUBSTR(SD1->D1_CF,1,4) $ "1914/2914/1912/2912"			    // RETORNO DE EXPOSICAO OU FEIRA/ remessa para demonstracao
		_cRet := "113030001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1949/2949/3949"				// ENTRADA SIMPLES REMESSA 
		_cRet := "512080002"		
	Case SUBSTR(SD1->D1_CF,1,4) $ "3556"				// ENTRADA INDUST. POR TERCEIROS 
		_cRet := "612010015"				                                             
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353" .AND. SD1->D1_COD $ "120487454117002/120487454117EDB/120487454117ACZ/120487454117B27" // FRETE COMPRAS  	
		_cRet := "41101030009"								
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353" .AND. SD1->D1_COD $ "120487453117002/120487453117ACZ/120487453117B27/120487453117B45/120487453117CS5/120487453117GXZ"	// FRETE VENDAS
		_cRet := "612010013"   				
	Case SUBSTR(SD1->D1_CF,1,4) $ "3102"			  			// IMPORTACAO COM IPI
		_cRet := "114010015"  
	Case SUBSTR(SD1->D1_CF,1,4) $ "1912/2912"			  			// ENTRADA PARA EMONSTRACAO
		_cRet := "113030001"				
		
EndCase

RestArea(_aArea)

Return(_cRet)
