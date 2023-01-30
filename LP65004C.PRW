/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP65003C ºAutor  ³Ocimar              º Data ³   20/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de CREDITO 650-004                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP65004C()

LOCAL _cRet := ""

_aArea 		:= GetArea()

Do Case
	Case SUBSTR(SD1->D1_CF,1,4) $ "1102/2102/1403/2403" 					 	// COMPRA MERCADORIA 
		_cRet := "114010012"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1101/2101/1122/2122/1401/2401/1122/2122" 		 	// COMPRA P/ INDUSTRIALIZACAO
		_cRet := "114010061"		
	Case SUBSTR(SD1->D1_CF,1,4) $ "3102/3556"	       			// COMPRA IMPORTACAO
		_cRet := "114010015"
	Case SUBSTR(SD1->D1_CF,1,4) $ "3101/1922/2922"	       			// COMPRA IMPORTACAO
		_cRet := "114010040"		
	Case SUBSTR(SD1->D1_CF,1,4) $ "1202/2202/1204/2204/1411/2411"			  			// DEVOLUCAO VENDAS
		_cRet := "312010009"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1201/2201/1410/2410"			  			// DEVOLUCAO VENDAS PRODUCAO
		_cRet := "312030008"	 
	Case SUBSTR(SD1->D1_CF,1,4) $ "1933/2933"						// SERVICO
		_cRet := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_CONTA")
	Case SUBSTR(SD1->D1_CF,1,4) $ "1653/2653"						// COMBUSTIVEL 
		_cRet := "411010033"
//	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353"   			// FRETE
//		_cRet := Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_CONTA") 
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353" .AND.	SD1->D1_COD $ "120487454117002/120487454117EDB/120487454117ACZ/120487454117B27/120487454117CS5/120487454117GXZ/08048A5T6117002" // FRETE COMPRAS
		_cRet := "411010008"								
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353" .AND.	SD1->D1_COD $ "250487453117002/120487453117002/120487453117ACZ/120487453117B27/120487453117B45/120487453117CS5/120487453117GXZ/08048A5T6117002/250487453117002"	        // FRETE VENDAS
		_cRet := "511010061"				 
	Case SUBSTR(SD1->D1_CF,1,4) $ "1125/2125/1124/2124"				// ENTRADA INDUST. POR TERCEIROS
		_cRet := "41101020004" 
	Case SUBSTR(SD1->D1_CF,1,4) $ "1253/2253"						// ENERGIA ELETRICA
		_cRet := "512040019"		
	Case SUBSTR(SD1->D1_CF,1,4) == "3949"				// ENTRADA INDUST. POR TERCEIROS
		_cRet := "41101030007"					
		
EndCase

RestArea(_aArea)

Return(_cRet)