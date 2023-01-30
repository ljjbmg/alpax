/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM010   บAutor  ณOcimar Rolli        บ Data ณ  08/01/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Programa para gravar tabela ZBA010 do inventario paralelo. บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿   
*/

#Include "Protheus.ch"
#Include "TopConn.ch"

User Function ESTM010() 


cPerg := "ESTM10"

PutSx1(cPerg,"01","Valor do Inventario","Valor do Inventario","Valor do Inventario","mv_ch1","N",13,2,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Data do Inventario ","Data do Inventario ","Data do Inventario ","mv_ch2","D",08,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",,,)

Pergunte(cPerg,.t.)

	If Empty(MV_PAR01) .or. Empty(MV_PAR02)
				ApMsgStop("Algum parametro esta em branco ","Aviso")
		Else
		Processa({|| fGrava()})
	EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGrava    บAutor  ณ Ocimar Rolli       บ Data ณ  08/01/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   

Static Function fGrava()

Local _nTotiInv := 0
Local _cQuery   := " "

_cQuery := "SELECT SB1.B1_POSIPI AS NCM "
_cQuery += ",      SB1.B1_COD AS COD "
_cQuery += ",      SB1.B1_DESC AS DESCR "
_cQuery += ",      SB1.B1_UM AS UNID "
_cQuery += ",      SB2.B2_QATU AS QUANT "
_cQuery += ",      SB2.B2_CM1 AS UNIT "
_cQuery += ",      (SB2.B2_QATU*SB2.B2_CM1) AS PARCIAL "
_cQuery += ",      SB2.B2_LOCAL AS LOCALI "
_cQuery += ",      SB1.B1_TIPO AS TIPO "
_cQuery += "FROM " + RetSqlName("SB1") + " SB1 "
_cQuery += "INNER JOIN " + RetSqlName("SB2") + " SB2 "
_cQuery += "ON SB1.B1_COD = SB2.B2_COD "
_cQuery += "WHERE SB1.B1_TIPO IN ('ME','MP') "
_cQuery += "AND SB1.B1_MSBLQL <> '1' "
_cQuery += "AND SB1.D_E_L_E_T_ = ' ' "
_cQuery += "AND SB2.D_E_L_E_T_ = ' ' "
_cQuery += "AND SB2.B2_QATU > 0 "
_cQuery += "AND SB2.B2_CM1 > 0 "
_cQuery += "ORDER BY SB1.B1_COD "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","NCM"	        ,"C",10,0)
TcSetField("QR1","COD"          ,"C",15,0) 
TcSetField("QR1","DESCR"     	,"C",35,0)
TcSetField("QR1","UNID"	        ,"C",02,0)
TcSetField("QR1","QUANT"        ,"N",13,2)
TcSetField("QR1","UNIT"      	,"N",13,4)
TcSetField("QR1","PARCIAL"    	,"N",13,2)
TcSetField("QR1","LOCALI"    	,"C",02,0)
TcSetField("QR1","TIPO"     	,"C",02,0)

QR1->(DbGoTop())

Do While ! QR1->(Eof()) .And. _nTotiInv <= MV_PAR01
	If ! ZBA->(DbSeek(xfilial("ZBA")+DtoS(MV_PAR02)+QR1->COD+QR1->LOCALI))
		RecLock("ZBA",.t.)
	Else
		RecLock("ZBA",.f.)
	EndIf
	   		ZBA->ZBA_NCM     := QR1->NCM
	   		ZBA->ZBA_COD     := QR1->COD
			ZBA->ZBA_DESC    := QR1->DESCR
			ZBA->ZBA_UNID    := QR1->UNID
			ZBA->ZBA_QUANT   := QR1->QUANT
			ZBA->ZBA_UNITAR  := QR1->UNIT
			ZBA->ZBA_PARCIA  := QR1->PARCIAL	   		
	   		ZBA->ZBA_DTINV   := MV_PAR02
	   		ZBA->ZBA_LOCALI  := QR1->LOCALI
	   		ZBA->ZBA_TIPO    := QR1->TIPO
		ZBA->(MsUnLock())
		_nTotiInv += QR1->PARCIAL
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
