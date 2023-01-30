/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณestv002    บAutor  ณOcimar             บ Data ณ  19/10/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Programa para MANUTENCAO DO B1_PNUMBER do cadastro de      บฑฑ
ฑฑบ          ณ produtos.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#include "Topconn.ch"
#Include "rwmake.ch"

User Function estv002()

_cQuery := "SELECT B1_COD, B1_PNUMBER "
_cQuery += "FROM " + RetSqlName("SB1") + " B1 "
_cQuery += "WHERE  B1_MARCA = 'WHATMAN' AND B1.D_E_L_E_T_ = ' ' AND B1_MSBLQL <> 1 "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_COD"	  ,"C",15,0)
TcSetField("QR1","B1_PNUMBER" ,"C",20,0)

Do While ! QR1->(Eof())
	_cCodigo   := QR1->B1_COD 

	// DIVIDE O PART NUMBER  
	
	_cVarRef1 := SubsTr(QR1->B1_PNUMBER,1,1)
	_cVarRef2 := SubsTr(QR1->B1_PNUMBER,2,1)
	_cVarRef3 := SubsTr(QR1->B1_PNUMBER,3,1)
	_cVarRef4 := SubsTr(QR1->B1_PNUMBER,4,1)
	_cVarRef5 := SubsTr(QR1->B1_PNUMBER,5,1)				
	_cVarRef6 := SubsTr(QR1->B1_PNUMBER,6,1)
	_cVarRef7 := SubsTr(QR1->B1_PNUMBER,7,1)
	_cVarRef8 := SubsTr(QR1->B1_PNUMBER,8,1)
	_cVarRef9 := SubsTr(QR1->B1_PNUMBER,9,1)
	_cVarRef10 := SubsTr(QR1->B1_PNUMBER,10,1)
	_cVarRef11 := SubsTr(QR1->B1_PNUMBER,11,1)
	_cVarRef12 := SubsTr(QR1->B1_PNUMBER,12,1)
	_cVarRef13 := SubsTr(QR1->B1_PNUMBER,13,1)
	_cVarRef14 := SubsTr(QR1->B1_PNUMBER,14,1)
	_cVarRef15 := SubsTr(QR1->B1_PNUMBER,15,1)	
	_cVarRef16 := SubsTr(QR1->B1_PNUMBER,16,1)
	_cVarRef17 := SubsTr(QR1->B1_PNUMBER,17,1)
	_cVarRef18 := SubsTr(QR1->B1_PNUMBER,18,1)
	_cVarRef19 := SubsTr(QR1->B1_PNUMBER,19,1)
	_cVarRef20 := SubsTr(QR1->B1_PNUMBER,20,1)
		
	// GRAVA O NOVO PART NUMBER
	
	If _cVarRef1 <> " "
		_cNewRef := _cVarRef1
	EndIf
	If _cVarRef2 <> " "
		_cNewRef += _cVarRef2
	EndIf
	_cNewRef += "AT"
	If _cVarRef3 <> " "
		_cNewRef += _cVarRef3
	EndIf
	If _cVarRef4 <> " "
		_cNewRef += _cVarRef4
	EndIf
	If _cVarRef5 <> " "
		_cNewRef += _cVarRef5
	EndIf
	If _cVarRef6 <> " "
		_cNewRef += _cVarRef6
	EndIf
	If _cVarRef7 <> " "
		_cNewRef += _cVarRef7
	EndIf
	If _cVarRef8 <> " "
		_cNewRef += _cVarRef8
	EndIf
	If _cVarRef9 <> " "
		_cNewRef += _cVarRef9
	EndIf
	If _cVarRef10 <> " "
		_cNewRef += _cVarRef10
	EndIf
	If _cVarRef11 <> " "
		_cNewRef += _cVarRef11
	EndIf
	If _cVarRef12 <> " "
		_cNewRef += _cVarRef12
	EndIf
	If _cVarRef13 <> " "
		_cNewRef += _cVarRef13
	EndIf
	If _cVarRef14 <> " "
		_cNewRef += _cVarRef14
	EndIf
	If _cVarRef15 <> " "
		_cNewRef += _cVarRef15
	EndIf
	If _cVarRef16 <> " "
		_cNewRef += _cVarRef16
	EndIf
	If _cVarRef17 <> " "
		_cNewRef += _cVarRef17
	EndIf
	If _cVarRef18 <> " "
		_cNewRef += _cVarRef18
	EndIf
	If _cVarRef19 <> " "
		_cNewRef += _cVarRef19
	EndIf
	If _cVarRef20 <> " "
		_cNewRef += _cVarRef20
	EndIf
	
	SB1->(DbSetOrder(1))
	SB1->(DbSeek(xFilial("SB1")+_cCodigo))
	RecLock("SB1",.f.)
	SB1->B1_PNUMBER := _cNewRef
	SB1->(MsUnlock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
