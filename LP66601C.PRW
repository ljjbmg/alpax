
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP66601C  ºAutor  ³OCIMAR              º Data ³  20/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de CREDITO 660-001                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP66601C()

LOCAL _cRet := ""

Do Case
	Case SF5->F5_CODIGO $ "501/523/524/525"                         // REQUISICAO DE CONSUMO
		_cRet := "114060001"
	Case SF5->F5_CODIGO == "502"                                    // REQUISICAO DE PERDA
		_cRet := "114010066"
	Case SF5->F5_CODIGO $ "503/504"                                 // REQUISICAO DE BRINDE/AMOSTRA
		_cRet := "114060001" 				
	Case SF5->F5_CODIGO == "505"                                    // REQUISICAO PARA PRODUCAO
		_cRet := "114010065" 
	Case SF5->F5_CODIGO $ "507/508/513"                             // REQUISICAO MATL. ESCRITORIO/BENF. PREDIO/MATL SEGURANCA
		_cRet := "114060001"				
	Case SF5->F5_CODIGO $ "509/510"                                 // REQUISICAO MATL. EMBALAGEM PRODUCAO/COMERCIO
		_cRet := "114010025"
	Case SF5->F5_CODIGO == "511"                                    // REQUISICAO MATERIAL DE LIMPEZA
		_cRet := "114060001"
	Case SF5->F5_CODIGO $ "512/514/515/517/516/518"                 // REQUISICAO FICHA/MATERIAL EMERGENCIA , BENS DE NATUREZA PERMANENTE
		_cRet := "114060001"						    	 	    // REQUISICAO FORMULARIO/IMPRESSO VENDAS
								                                    // REQUISICAO PROPAGANDA/MARKETING
																    // REQUISICAO COPA E COZINHA / MANUTENCAO DE VEICULOS							
EndCase

Return(_cRet)