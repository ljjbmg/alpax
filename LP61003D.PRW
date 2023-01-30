/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP61003D ºAutor  ³Ocimar              º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de DEBITO 610-003                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP61003D()

LOCAL _cRet := ""

Do Case
	Case SUBSTR(SD2->D2_CF,1,4) $ "5102/6102/6108/5403/5405/6404/6403/6110/5123/6123"             // VENDA / VENDA NAO CONT. REV. / VENDA SUBST. TRIB.
		_cRet := "312010008"
	Case SUBSTR(SD2->D2_CF,1,4) $ "6107"                       // VENDA NAO CONT. INDUST.
		_cRet := "312030008"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5101/6101/5401/6401/5118/6118"  		   			    // VENDA PRODUCAO
		_cRet := "312030007"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5202/6202/5411/6411"  		   			    // DEVOLUCAO COMPRAS REV.
		_cRet := "114010027"   
	Case SUBSTR(SD2->D2_CF,1,4) $ "5201/6201/5410/6410"  		   			    // DEVOLUCAO COMPRAS INDUST.
		_cRet := "114010052"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5124/6124"			  		    // INDUSTRIALIZACAO
		_cRet := "312020002" 
	Case SUBSTR(SD2->D2_CF,1,4) $ "5922/6922/5117/6117"  		   			    // VENDA EMPENHO REV./ SIMPLES REMESSA EMPENHO
	     Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_MARCA")
		_cRet := iif(SB1->B1_MARCA == "LOGEN","312040003","312010008")
	Case SUBSTR(SD2->D2_CF,1,4) $ "5933/6933"                       // SERVICO
		_cRet := "312020002"							
	Case SUBSTR(SD2->D2_CF,1,4) $ "5119/6119/5120/6120"                       // VENDA A ORDEM REVENDA
		_cRet := "312010008"									
EndCase

Return(_cRet)