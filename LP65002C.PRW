/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP65002C ºAutor  ³Ocimar              º Data ³  21/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de CREDITO 650-002                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP65002C()

LOCAL _cRet := ""

Do Case
	Case SUBSTR(SD1->D1_CF,1,4) $ "1102/2102/1117/2117"  								// COMPRA MERCADORIA
		_cRet := "114010012"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1101/2101/1116/2116/1401/2401/1122/2122" 							// COMPRA P/ INDUSTRIALIZACAO
		_cRet := "114010061"
	Case SUBSTR(SD1->D1_CF,1,4) $ "3102/3949"  			       										// COMPRA IMPORTACAO P/ REV.
		_cRet := "114010015"
	Case SUBSTR(SD1->D1_CF,1,4) == "3101"	              										// COMPRA IMPORTACAO P/ INDUST.
		_cRet := "114010040"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1202/2202/1411/2411/2204"			  										// DEVOLUCAO VENDAS REV.
		_cRet := "312010007"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1201/2201/1410/2410"			  										// DEVOLUCAO VENDAS INDUST.
		_cRet := "312030006"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1556/2556" .AND. SD1->D1_COD $ "08048A3IL117002/08048A3L3009002/08048A3IN117002/08048A3IM117002"
		_cRet := "41101030010"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1556/2556/3556"
		_cRet := "512080013"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1653/2653"   											    // COMPRA DE COMBUSTIVEL
		_cRet := "411010033"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1912/2912"   											    // REMESSA PARA DEMONSTRACAO
    	_cRet := "113030001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1913/2913"			 									    // RETORNO DE DEMONSTRACAO
		_cRet := "113030011"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1914/2914"             										// RETORNO DE EXPOSICAO OU FEIRA
		_cRet := "113030011"
		//	Case SUBSTR(SD1->D1_CF,1,4) $ "1910/2910"             										// ENTRADA DE BONIFICACAO, DOACAO OU BRINDE
		//		_cRet := "512080017"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353" .AND. SD1->D1_COD $ "120487454117002/120487454117EDB/120487454117ACZ/120487454117B27/120487454117CS5/120487454117GXZ" // FRETE COMPRAS
		_cRet := "411010008"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1353/2353" .And. SD1->D1_COD $ "120487453117002/120487453117ACZ/120487453117B27/120487453117B45/120487453117CS5/250487453117002"	        // FRETE VENDAS
		_cRet := "511010061"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1553/2553"												// DEVOLUCAO ATIVO
		_cRet := "612010014"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1253"													// ENERGIA ELETRICA
		_cRet := "512040019"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1303"														// CONTA TELEFONICA
		_cRet := "512080011"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1929/2929"													// COMBUSTIVEL
		_cRet := "41101030001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1122/2122"													// COMPRA P/ INDUSTR. S/ TRANS. ALPAX
		_cRet := "411050001"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1551/2551"													// COMPRA P/ ATIVO IMOB.
		_cRet := "512080012"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1124/2124" 													// INDUST. C/ ICMS
		_cRet := "41101020004"
	Case SUBSTR(SD1->D1_CF,1,4) $ "1949/2949"	       										// SIMPLES REMESSA C/ ICMS
		If SD1->D1_TIPO == 'D'
			_cRet := "312010007"
		Else
			_cRet := "41101030002"
		EndIf
	Case SUBSTR(SD1->D1_CF,1,4) $ "1601/2601"													// TRANSF. CRED. ICMS
		_cRet := "112010001"
EndCase

Return(_cRet)
