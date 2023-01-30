/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP61004D ºAutor  ³Ocimar              º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de DEBITO 610-004                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP61004D()

LOCAL _cRet := ""

Do Case
	Case SUBSTR(SD2->D2_CF,1,4) $ "5102/6102/6108/5403/5405/6404/6403/5123/6123/5120/6120"             // VENDA / NAO CONTRIBUINTE REV. / VENDA SUBST. TRIB.
		_cRet := "312010009"
	Case SUBSTR(SD2->D2_CF,1,4) $ "6107"                       // VENDA NAO CONTRIBUINTE INDUST.
		_cRet := "312030008"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5101/6101/5401/6401/5118/6118"  		   			    // VENDA PRODUCAO
		_cRet := "312030008"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5202/6202/5411/6411"                       // DEVOLUCAO COMPRAS REV.
		_cRet := "114010027"   
	Case SUBSTR(SD2->D2_CF,1,4) $ "5201/6201/5410/6410"                       // DEVOLUCAO COMPRAS INDUST.
		_cRet := "114010052"		
	Case SUBSTR(SD2->D2_CF,1,4) $ "5124/6124"  					    // INDUSTRIALIZACAO
		_cRet := "312020003"  
	Case SUBSTR(SD2->D2_CF,1,4) $ "5922/6922/5117/6117"  		   			    // VENDA EMPENHO REV.
	     Posicione("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_MARCA")
		_cRet := iif(SB1->B1_MARCA == "LOGEN","312040004","312010009")
	Case SUBSTR(SD2->D2_CF,1,4) $ "5933/6933"  		   			    // SERVICO
		_cRet := "312020003"						
	Case SUBSTR(SD2->D2_CF,1,4) $ "5119/6119"  		   			    // SIMPLES REMESA EMPENHO INDUST.
		_cRet := "312010009"						
EndCase

Return(_cRet)