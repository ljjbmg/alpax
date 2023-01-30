#include "Rwmake.ch"
#include "TopConn.ch"
#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATG005   ºAutor  ³Wagner Gomes        º Data ³  28/06/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gatilho para alimentar dados da ultima compra do Cliente   º±±
±±º          ³ CK_PRODUTO -> CK_AXULDAT                                   º±±
±±º          ³            -> CK_AXULQTD                                   º±±
±±º          ³            -> CK_AXULPRE                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Alpax                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
17/08/2022 - ANDRE R ESTEVES - TOTALIT - MANUTENÇÃO
Retirados os gatilhos e colocada na Validação de usuário dos campos CK_PRODUTO
e C6_PRODUTO
*/
User Function FatG005(_nOpc)

	Local _cQuery  		:= ""
	Local _cCliente		:= ""
	Local _cLoja		:= ""
	Local _cProduto		:= ""
	Local _lret         := .T.
	Local _nPosEMIS     := ""
	Local _nPosQTDE     := ""
	Local _nPosUNIT     := ""
	Local _aArea        := GetArea()

	DEFAULT _nOpc       := 1

	If _nOpc == 1
		_cCliente	:= M->CJ_CLIENTE
		_cLoja		:= M->CJ_LOJA
		_cProduto	:= M->CK_PRODUTO
	Else
		_cCliente	:= M->C5_CLIENTE
		_cLoja		:= M->C5_LOJACLI
		_cProduto	:= M->C6_PRODUTO
	ENDIF

	_cQuery		:= "SELECT TOP 1 "
	_cQuery		+=		"SD2.D2_DOC NOTA, SD2.D2_EMISSAO EMISSAO, SD2.D2_QUANT QTDVEN, SD2.D2_PRCVEN PRCVEN "
	_cQuery		+= "FROM "
	_cQuery		+= 		RetSqlName("SD2")+" SD2 "
	_cQuery		+= "WHERE "
	_cQuery		+= 		"SD2.D_E_L_E_T_ = ' ' AND "
	_cQuery		+=		"SD2.D2_CLIENTE = '"+_cCliente+"' AND D2_LOJA='"+_cLoja+"' AND "
	_cQuery		+=		"SD2.D2_COD = '"+_cProduto+"' AND "
	_cQuery		+=		"SUBSTRING(SD2.D2_CF,2,1) IN ('1','4')"
	_cQuery 	+= "ORDER BY "
	_cQuery 	+=		"SD2.D2_EMISSAO DESC, SD2.D2_DOC DESC, SD2.D2_ITEM DESC, SD2.D2_CLIENTE, SD2.D2_LOJA"

	TCQUERY _cQuery NEW ALIAS "TRB"

	dbSelectArea("TRB")

	If TRB->(!EOF())
		If _nOpc == 1
			TMP1->CK_AXULDAT := Stod(TRB->EMISSAO)
			TMP1->CK_AXULQTD := TRB->QTDVEN
			TMP1->CK_AXULPRE := TRB->PRCVEN
		Else
			_nPosEMIS	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULDAT"})		// Data da ultima Nota
			_nPosQTDE	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULQTD"})		// Quantidade da ultima venda deste produto
			_nPosUNIT	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULPRE"})		// Valor Unitario da ultima venda deste produto

			aCols[n,_nPosEMIS]	:= Stod(TRB->EMISSAO)
			aCols[n,_nPosQTDE]	:= TRB->QTDVEN
			aCols[n,_nPosUNIT]	:= TRB->PRCVEN
			oGetDad:oBrowse:Refresh()
		EndIf

	Else
		Alert("Primeira Compra do produto '"+alltrim(_cProduto)+"' "+chr(13)+chr(10)+"Verifique o Cliente digitado"+chr(13)+chr(10)+_cCliente + " " + _cLoja)
	EndIf
	TRB->(dbCloseArea())

// Restaura o ambiente
	RestArea(_aArea)

Return(_lret)
