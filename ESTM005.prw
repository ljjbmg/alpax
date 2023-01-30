/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM005   บAutor  ณOcimar Rolli        บ Data ณ  11/10/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Programa para atualizar o cadastro de produtos nos precos บฑฑ
ฑฑบ          ณ  de compra e custo                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"                 '
#Include "Protheus.ch"

User Function ESTM005()

Private _nCusto    := 0
Private _nAliqIpi  := 0
Private _nAliqSt   := 0
Private _nValor    := 0
Private _nValIpi   := 0
Private _nValSt    := 0
Private _nVlIcmN   := 0
Private _nLinha    := 0
Private _cMarca	  := GetNewPar("MV_AXMARCA")

_cQuery := "SELECT B1_COD, B1_UPRC, Z2_INDICE, Z2_INDPRV, B1_AXINDIC, Z2_INDPRVI, Z2_INIMPMI, Z2_INDPRDM, Z2_INDPRDV "
_cQuery += "       FROM " + RetSqlName("SB1") + " B1 "
_cQuery += "       INNER JOIN " + RetSqlName("SZ2") + " Z2 "
_cQuery += "               ON Z2_FILIAL = '" + xFilial("SZ2") + "' AND Z2_DESCR = B1_MARCA "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '               ' AND 'ZZZZZZZZZZZZZZZ' "
_cQuery += "             AND B1_AXLINHA BETWEEN '               ' AND 'ZZZZZZZZZZZZZZZ' "
_cQuery += "             AND B1_MARCA BETWEEN '               ' AND 'ZZZZZZZZZZZZZZZ' "
_cQuery += "             AND B1_AXCUS < B1_UPRC "
_cQuery += "             AND Z2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_UPRC"	    ,"N",12,2)
TcSetField("QR1","B1_AXINDIC"	,"N",12,2)
TcSetField("QR1","Z2_INDICE"	,"N",12,3)
TcSetField("QR1","Z2_INDPRV"	,"N",12,3)
TcSetField("QR1","B1_AXCUS"  	,"N",12,3)
TcSetField("QR1","Z2_INDPRVI"	,"N",12,3)
TcSetField("QR1","Z2_INIMPMI"	,"N",12,3)
TcSetField("QR1","Z2_INDPRDM"	,"N",12,3)
TcSetField("QR1","Z2_INDPRDV"	,"N",12,3)

Do While ! QR1->(Eof())
	If SB1->(DbSeek(xFilial("SB1")+QR1->B1_COD))
		RecLock("SB1",.f.)
		_nCusto    := SB1->B1_UPRC
		_nAliqIpi  := SB1->B1_IPI/100
		_nAliqSt   := SB1->B1_PICMENT/100
		_nValor    := 0
		_nValIpi   := (_nCusto*_nAliqIpi)
		_nValSt    := (((_nCusto+(_nCusto*(_nAliqIpi)))*(1+_nAliqST))*0.18)
		_nVlIcmN   := (_nCusto*0.18)
		Do Case
			Case _nAliqIpi==0 .And. _nAliqST==0
				_nValor := _nCusto
			Case _nAliqIpi<>0 .And. _nAliqST==0
				_nValor := (_nCusto+_nValIpi)
			Case _nAliqIpi==0 .And. _nAliqST<>0
				_nValor := (_nCusto+(_nValST-_nVlIcmN))
			Case _nAliqIpi<>0 .And. _nAliqST<>0
				_nValor := (_nCusto+_nValIpi+(_nValST-_nVlIcmN))
		EndCase
		SB1->B1_AXCUS := _nValor
		If Alltrim(SB1->B1_MARCA) $ _cMarca
			If SB1->B1_XSITPRO == "I"		// Importado comprado
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INIMPMI)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRVI)))
			ElseIf SB1->B1_XSITPRO == "N" 	// Nacional Comprado
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INDICE)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRV)))
			Else	// Produzido
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INDPRDM)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRDV)))
			EndIf
		Else
			If SB1->B1_ORIGEM $ "1/6"
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INIMPMI)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(QR1->B1_AXINDIC > 0,QR1->B1_AXINDIC,QR1->Z2_INDPRVI)))
			Else
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INDICE)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(QR1->B1_AXINDIC > 0,QR1->B1_AXINDIC,QR1->Z2_INDPRV)))
			EndIf
		EndIf
		SB1->B1_PRV1 	:= _nPrcVen
		SB1->B1_AXPRMIN	:= _nPrcMin
		SB1->(MsUnLock())
		AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco venda produto " + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcVen,"@E 9,999,999.99"))
		_nLinha++
		AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco minimo produto" + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcMin,"@E 9,999,999.99"))
		_nLinha++
	EndIf
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return()
