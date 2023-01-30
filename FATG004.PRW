#include "Rwmake.ch"
#include "TopConn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATG004   บAutor  ณWagner Gomes        บ Data ณ  28/06/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gatilho para alimentar dados da ultima compra do Cliente   บฑฑ
ฑฑบ          ณ C6_PRODUTO -> C6_PRODUTO                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico Alpax                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FatG004()
Local _cQuery  		:= ""
Local _cQueryO 		:= ""
Local _cCliente		:= ""
Local _cLoja		:= ""
Local _cProduto		:= ""

Private _dEmissao	:= CtoD("//")
Private _nQtdVen	:= 0
Private _nPrcVen	:= 0

Private _aAmbiente := { {Alias()}}
SalvaAmbiente(_aAmbiente)

_cCliente	:= M->C5_CLIENTE
_cLoja		:= M->C5_LOJACLI
_cProduto	:= M->C6_PRODUTO

_cQuery		:= "SELECT TOP 1 "
_cQuery		+=		"SD2.D2_DOC NOTA, SD2.D2_EMISSAO EMISSAO, SD2.D2_QUANT QTDVEN, SD2.D2_PRCVEN PRCVEN "
_cQuery		+= "FROM "
_cQuery		+= 		RetSqlName("SD2")+" SD2 "
_cQuery		+= "WHERE "
_cQuery		+= 		"SD2.D_E_L_E_T_ = ' ' AND "
_cQuery		+=		"SD2.D2_CLIENTE = '"+_cCliente+"' AND D2_LOJA='"+_cLoja+"' AND "
_cQuery		+=		"SD2.D2_COD = '"+_cProduto+"' "
_cQueryO	:= "ORDER BY "
_cQueryO	+=		"SD2.D2_EMISSAO DESC, SD2.D2_DOC DESC, SD2.D2_ITEM DESC, SD2.D2_CLIENTE, SD2.D2_LOJA"

memowrite("FATG004.SQL",_cQuery+_cQueryO)
TCQUERY _cQuery+_cQueryO NEW ALIAS "TRB"

// Conta os registros da Query
TcQuery "SELECT COUNT(*) AS TOTALREG FROM (" + _cQuery + ") AS T" NEW ALIAS "QRYCONT"
QRYCONT->(dbgotop())
_nReg := QRYCONT->TOTALREG
QRYCONT->(dbclosearea())

dbSelectArea("TRB")
dbGoTop()

If _nReg > 0
	_nPosEMIS	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULDAT"})		// Data da ultima Nota
	_nPosQTDE	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULQTD"})		// Quantidade da ultima venda deste produto
	_nPosUNIT	:= aScan(aHeader,{|x| UPPER(AllTrim(x[2])) == "C6_AXULPRE"})		// Valor Unitario da ultima venda deste produto
	
	aCols[n,_nPosEMIS]	:= Stod(TRB->EMISSAO)
	aCols[n,_nPosQTDE]	:= TRB->QTDVEN
	aCols[n,_nPosUNIT]	:= TRB->PRCVEN
   oGetDad:oBrowse:Refresh()
Else
	Alert("Primeira Compra do produto '"+alltrim(_cProduto)+"' "+chr(13)+chr(10)+"Verifique o Cliente digitado"+chr(13)+chr(10)+_cCliente + " " + _cLoja)
EndIf
TRB->(dbCloseArea())

// Restaura o ambiente
RestAmbiente(_aAmbiente)

Return(_cProduto)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ  Salva o Ambiente                                                     บฑฑ
ฑฑศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SalvaAmbiente(_aAmbiente)
local _ni
for _ni := 1 to len(_aAmbiente)
	dbselectarea(_aAmbiente[_ni,1])
	AADD(_aAmbiente[_ni],indexord())
	AADD(_aAmbiente[_ni],recno())
next
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ  Restaura o Ambiente                                                  บฑฑ
ฑฑศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RestAmbiente(_aAmbiente)
local _ni
for _ni := len(_aAmbiente) to 1 step -1
	dbselectarea(_aAmbiente[_ni,1])
	dbsetorder(_aAmbiente[_ni,2])
	dbgoto(_aAmbiente[_ni,3])
next
Return
