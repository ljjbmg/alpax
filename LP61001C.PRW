/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP61001C ºAutor  ³Ocimar              º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de CREDITO 610-001                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP61001C()

LOCAL _cRet := ""

_aArea 		:= GetArea()
_aAreaB1	:= SB1->(GetArea())

Do Case
	Case SUBSTR(SD2->D2_CF,1,4) $ "5102/6102/5405/6404/5403/6403/5123/6123/5117/6117/5118/6118"             // VENDA MERCADO INTERNO / VENDA SUBST. TRIB.
		_cRet := "311010001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5101/6101/5401/6401"             // VENDA MERCADO INTERNO PRODUCAO
		_cRet := "311030001"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5933/6933/7933/9999"   // VENDA SERVICO INTERNO
		_cRet := "311020001"
	Case SUBSTR(SD2->D2_CF,1,4) == "7102"  			      // VENDA EXPORTACAO
		_cRet := "311010011"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5124/6124"  		      // INDUSTRIALIZACAO POR ENCOMENDA
		_cRet := "311020003"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5202/6202/5411/6411"			  // DEVOLUCAO COMPRAS REV.
		_cRet := "114010027" 		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5201/6201/5410/6410"			  // DEVOLUCAO COMPRAS INDUST.
		_cRet := "114010052"  
	Case SUBSTR(SD2->D2_CF,1,4) $ "5556/6556/5413/6413"			  // DEVOLUCAO COMPRAS MAT. CONSUMO(CESTA BASICA)
		_cRet := "114060001"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5553/6553"			  // DEVOLUCAO COMPRAS ATIVO IMOBILIZADO
		_cRet := "117020003"						
	Case SUBSTR(SD2->D2_CF,1,4) $ "5911/6911"		      // AMOSTRA GRATIS
		_cRet := "114010018"				
	Case SUBSTR(SD2->D2_CF,1,4) $ "5912/6912/5908/6908"   		  // REMESSA PARA DEMONSTRACAO
		_cRet := "114010017"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5913/6913"			  // RETORNO DE DEMONSTRACAO
		_cRet := "114050002"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5927" 			  // REMESSA PARA CONSERTO
		_cRet := "114010066"
//	Case SUBSTR(SD2->D2_CF,1,4) $ "5901/6901"             // REMESSA PARA INDUSTRIALIZACAO
//		_cRet := "114010020"				
	Case SUBSTR(SD2->D2_CF,1,4) $ "5922/6922"  		   			    // VENDA EMPENHO REV.
//	     Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_MARCA")
//		_cRet := iif(SB1->B1_MARCA == "LOGEN","311030001","311010001")
		_cRet := "112010003"
	Case SUBSTR(SD2->D2_CF,1,4) $ "6108"             // VENDA A NAO CONTRIBUINTE REV.
		_cRet := "311010001" 
	Case SUBSTR(SD2->D2_CF,1,4) $ "6107/5116/6116"             // VENDA A NAO CONTRIBUINTE INDUST.
		_cRet := "311030001"						
	Case SUBSTR(SD2->D2_CF,1,4) $ "5110/6110"             // VENDA A AREA DE LIVRE COMERCIO REV.
		_cRet := "311010013"
	Case SUBSTR(SD2->D2_CF,1,4) $ "5109/6109"             // VENDA A AREA DE LIVRE COMERCIO INDUST.
		_cRet := "311030004"						
	Case SUBSTR(SD2->D2_CF,1,4) $ "5910/6910"             // BONIFICACAO, DOACAO OU BRINDE
		_cRet := "114010018"				
//	Case SUBSTR(SD2->D2_CF,1,4) $ "5914/6914"             // REMESSA PARA EXPOSICAO OU FEIRA
//		_cRet := "114010028"
//	Case SUBSTR(SD2->D2_CF,1,4) $ "5909/6909/5918/6918"   // RETORNO COMODATO
//		_cRet := "114050003"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5119/6119/5120/6120"             // VENDA A ORDEM REVENDA
		_cRet := "311010001"	
	Case SUBSTR(SD2->D2_CF,1,4) $ "5551/6551"             // VENDA ATIVO IMOBILIZADO
		_cRet := "512080003"			
EndCase

RestArea(_aAreaB1)
RestArea(_aArea)

Return(_cRet)