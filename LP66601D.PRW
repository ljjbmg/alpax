
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP66601D  ºAutor  ³OCIMAR              º Data ³  20/04/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar numero da conta contabil no           º±±
±±º          ³ lancamento padrao de DEBITO 660-001                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function LP66601D()

LOCAL _cRet := ""

Do Case
	Case SF5->F5_CODIGO == "501"                                    // REQUISICAO DE CONSUMO
		_cRet := "412020039"
	Case SF5->F5_CODIGO == "502"                                    // REQUISICAO DE PERDA
		_cRet := "411010003" 
	Case SF5->F5_CODIGO $ "503/504"                                 // REQUISICAO DE BRINDE/AMOSTRA
		_cRet := "411010001" 				
	Case SF5->F5_CODIGO == "505"                                    // REQUISICAO PARA PRODUCAO
		_cRet := "41101020007"				
	Case SF5->F5_CODIGO == "507"                                    // REQUISICAO MATL. ESCRITORIO
		_cRet := "512040002"						
	Case SF5->F5_CODIGO == "508"                                    // REQUISICAO MATL. BENFEITORIA PREDIAL
		_cRet := "512040011"	 
	Case SF5->F5_CODIGO == "509"                                    // REQUISICAO MATL. EMBALAGEM PRODUCAO
		_cRet := "41101020008"							
	Case SF5->F5_CODIGO == "510"                                    // REQUISICAO MATL. EMBALAGEM COMERCIO
		_cRet := "411010032"
	Case SF5->F5_CODIGO == "511"                                    // REQUISICAO DE MATERIAL DE LIMPEZA
		_cRet := "512040004" 
	Case SF5->F5_CODIGO == "512"                                    // REQUISICAO DE FICHA/ENVELOPE EMERG.
		_cRet := "411010031" 
	Case SF5->F5_CODIGO == "513"                                    // REQUISICAO DE MATERIAIS DE SEGURANCA
		_cRet := "412020012" 
	Case SF5->F5_CODIGO == "514"                                    // REQUISICAO DE FORMULARIOS/IMPRESSOS VENDAS
		_cRet := "511010047"
	Case SF5->F5_CODIGO == "515"                                    // REQUISICAO DE MATERIAIS DE PROPAGANDA/MARKETING
		_cRet := "511020006"       
	Case SF5->F5_CODIGO == "516"                                    // REQUISICAO DE MATERIAIS DE MANUTENCAO DE VEICULOS
		_cRet := "511010035" 		
	Case SF5->F5_CODIGO == "517"                                    // REQUISICAO DE MATERIAIS DE COPA E COZINHA
		_cRet := "512040005"																					
	Case SF5->F5_CODIGO == "518"                                    // REQUISICAO DE BENS DE NATUREZA PERMANENTE
		_cRet := "512040035" 
	Case SF5->F5_CODIGO == "523"                                    // REQUISICAO DE ETIQUETAS E CERTIFICADOS
		_cRet := "411010034"
	Case SF5->F5_CODIGO == "524"                                    // REQUISICAO DE MATERIAIS CONSUMIVEIS LABORATORIO
		_cRet := "412200017"
	Case SF5->F5_CODIGO == "525"                                    // REQUISICAO DE MATERIAL DE INFORMATICA
		_cRet := "512040015"						
EndCase

Return(_cRet)