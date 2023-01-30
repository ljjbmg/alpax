/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTA001   ºAutor  ³Adriano Luis Brandaoº Data ³  28/05/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para atualizar o codigo e descricao do cadastro de   º±±
±±º          ³produtos.                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ESTA001(_cCampo)


//
// Grava as areas que serao utilizadas na rotina.
//
_aArea		:= GetArea()
_aAreaZ3    := SZ3->(GetArea())
_aAreaZ4    := SZ4->(GetArea())
_aAreaZ6    := SZ6->(GetArea())
_cRet 		:= .t.


//
// Verifica o codigo anterior relacionado se e permitido ou nao utilizar o codigo selecionado de acordo com o modelo abaixo:
//                                                                                
//    Validacao geral :   	Marca 		-> Linha
//							Nome		-> Marca
//							Farmacopeia	-> Nome
//							Capacidade	-> Nome
//							Dif			-> Nome
//
//    alterado 06/08 para:
//
//    Validacao geral :   	Marca 		-> Linha
//							Nome		-> Linha
//							Farmacopeia	-> Nome
//							Capacidade	-> Nome
//							Dif			-> Nome
//    alterado 22/09 para:
//
//    Validacao geral :   	Marca 		-> Linha
//							Nome		-> Linha
//							Capacidade	-> Nome
//							Dif			-> Nome
//      					Observacao : Farmacopeia nao existe mais.

/*
		eliminada esta validacao por solicitacao do Ocimar
Do Case
	Case _cCampo == "MARCA"
		If SZ2->Z2_LINHA <> Left(M->B1_COD,1)
			ApMsgStop("Nao aceita Marca para a linha selecionada")
			_cRet := .f.
		EndIf
		
	Case _cCampo == "NOME"
		If SZ3->Z3_LINHA <> Left(M->B1_COD,1)
			ApMsgStop("Nao aceita este Nome para a linha selecionada")
			_cRet := .f.
		EndIf
		
	Case _cCampo == "FARMAC"
		If SZ4->Z4_NOME <> Substr(M->B1_COD,5, 4)
			ApMsgStop("Nao aceita esta Farmacopeia para o nome selecionado")
			_cRet := .f.
		EndIf
		
	Case _cCampo == "CAPAC"
		If SZ5->Z5_NOME <> Substr(M->B1_COD,5,4)
			ApMsgStop("Nao aceita esta capacidade para o nome selecionado")
			_cRet := .f.
		EndIf
		
	Case _cCampo == "DIF"
		If SZ6->Z6_NOME <> Substr(M->B1_COD,5,4)
			ApMsgStop("Nao aceita este diferencial para o nome selecionado")
			_cRet := .f.
		EndIf
		
EndCase

*/
//
// Atualiza o codigo e descricao dos produtos se o retorno for positivo.
//

If _cRet
	_cCod := M->B1_COD
	Do Case
		Case _cCampo == "LINHA"
			M->B1_COD  		:= SZ1->Z1_CODLIN
			M->B1_MARCA		:= Space(Len(M->B1_MARCA))
			M->B1_NOME		:= Space(Len(M->B1_NOME))
//			M->B1_AXFARMA	:= Space(Len(M->B1_AXFARMA))
			M->B1_CAPACIDAD	:= Space(Len(M->B1_CAPACIDAD))
			M->B1_AXDIF		:= Space(Len(M->B1_AXDIF))
		Case _cCampo == "MARCA"
			M->B1_COD 		:= Left(_cCod,02) + SZ2->Z2_CODMARC + Space(10)
			M->B1_NOME		:= Space(Len(M->B1_NOME))
//			M->B1_AXFARMA	:= Space(Len(M->B1_AXFARMA))
			M->B1_CAPACIDAD	:= Space(Len(M->B1_CAPACIDAD))
			M->B1_AXDIF		:= Space(Len(M->B1_AXDIF))
		Case _cCampo == "NOME"
			M->B1_COD := Left(_cCod,05) + SZ3->Z3_CODNOME + Space(06)
//			M->B1_AXFARMA	:= Space(Len(M->B1_AXFARMA))
			M->B1_CAPACIDAD	:= Space(Len(M->B1_CAPACIDAD))
			M->B1_AXDIF		:= Space(Len(M->B1_AXDIF))
/*		Case _cCampo == "FARMAC"
			M->B1_COD := Left(_cCod,08) + SZ4->Z4_CODFARM + Space(05)
			M->B1_CAPACIDAD	:= Space(Len(M->B1_CAPACIDAD))
			M->B1_AXDIF		:= Space(Len(M->B1_AXDIF))
*/			
		Case _cCampo == "CAPAC"
			M->B1_COD 		:= Left(_cCod,09) + SZ5->Z5_CODCAPA + Space(03)
			M->B1_AXDIF		:= Space(Len(M->B1_AXDIF))
		Case _cCampo == "DIF"
			M->B1_COD 		:= Left(_cCod,12) + SZ6->Z6_CODDIFE
	EndCase
	
	If _cCampo <> "LINHA"
		M->B1_DESC := Alltrim(Posicione("SZ3",1,xFilial("SZ3")+Substr(M->B1_COD,6,04),"Z3_DESCPRO"))
//	farmacopeia nao tem mais	M->B1_DESC += " " + Alltrim(Posicione("SZ4",1,xFilial("SZ4")+Substr(M->B1_COD,9,02),"Z4_DESCPRO"))
		M->B1_DESC += " " + Alltrim(Posicione("SZ6",1,xFilial("SZ6")+Right(M->B1_COD,03),"Z6_DESCPRO"))
	EndIf
	
EndIf

RestArea(_aAreaZ3)
RestArea(_aAreaZ4)
RestArea(_aAreaZ6)
RestArea(_aArea)

Return(_cRet)