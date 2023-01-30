#include "Rwmake.ch"
#include "TopConn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATG006   ºAutor  ³Wagner Gomes        º Data ³  28/06/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gatilho para alimentar dados da ultima compra do Cliente   º±±
±±º          ³ C5_CLIENTE -> C5_CLIENTE                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Alpax                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
17/08/2022 - ANDRE R ESTEVES - TOTALIT - MANUTENÇÃO
*/
User Function FatG006()
Local _cQuery  		:= ""
Local _cCliente		:= ""
Local _cLoja		:= ""
Local _cProduto		:= ""
Local _i            := 0
Local _aArea        := GetArea()

Private _dEmissao	:= CtoD("//")
Private _nQtdVen	:= 0
Private _nPrcVen	:= 0

_cCliente	:= M->C5_CLIENTE
_cLoja		:= M->C5_LOJACLI

For _i:= 1 to len(aCols)
	
	_nPosPROD	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_PRODUTO"})		// Produtos
	_nPosEMIS	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULDAT"})		// Data da ultima Nota
	_nPosQTDE	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULQTD"})		// Quantidade da ultima venda deste produto
	_nPosUNIT	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULPRE"})		// Valor Unitario da ultima venda deste produto
	
	_cProduto	:= aCols[_i,_nPosPROD]

	aCols[_i,_nPosEMIS]	:= CtoD("//")
	aCols[_i,_nPosQTDE]	:= 0
	aCols[_i,_nPosUNIT]	:= 0
    
    oGetDad:oBrowse:Refresh()
	
	If !Empty(_cProduto)
	
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
			
			aCols[_i,_nPosEMIS]	:= Stod(TRB->EMISSAO)
			aCols[_i,_nPosQTDE]	:= TRB->QTDVEN
			aCols[_i,_nPosUNIT]	:= TRB->PRCVEN
		
		Else
		
			Alert("Primeira Compra do produto '"+alltrim(_cProduto)+"' "+chr(13)+chr(10)+"Verifique o Cliente digitado"+chr(13)+chr(10)+_cCliente + " " + _cLoja)
		
		EndIf
		
		TRB->(dbCloseArea())

	EndIf
	
Next _i

// Restaura o ambiente
RestArea(_aArea)

Return(_cCliente)
