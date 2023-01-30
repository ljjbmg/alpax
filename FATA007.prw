/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA007   ºAutor  ³Microsiga           º Data ³  19/08/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Consulta posicao do pedido de vendas.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Rwmake.ch"

User Function FATA007()

Private _cArqTmp := ""

// Monta query e atualiza arquivo temporario com os dados da consulta.
MsgRun("Aguarde, consultando !!!",,{|| fCons007() })

fMostra007()

// Fecha arquivo temporario e deleta.
TMP->(DbCloseArea())

Ferase(_cArqTmp+".DTC")
Ferase(_cArqTmp+OrdBagExt())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCons007  ºAutor  ³Microsiga           º Data ³  19/08/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query e atualizacao do arquivo temporario a ser utilizado.  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCons007()
/*
_cQuery := "SELECT C9_PEDIDO, C9_ITEM, B1_PNUMBER, B1_DESC, B1_MARCA, B1_CAPACID, C6_QTDVEN, C9_QTDLIB, C9_SEQUEN, "
//_cQuery += "C6_QTDENT, C9_NFISCAL, C9_SERIENF, F2_EMISSAO, C9_LOTECTL,C9_DTVALID, C9_BLEST, C9_BLCRED , C9_DATALIB, C9_AXHRLIB "
_cQuery += "C6_QTDENT, C9_NFISCAL, C9_SERIENF, F2_EMISSAO, C9_LOTECTL,C9_DTVALID, C9_BLEST, C9_BLCRED , C9_AXDTLIB, C9_AXHRLIB "
_cQuery += "FROM " + RetSqlName("SC9")+ " C9, " + RetSqlName("SB1") + " B1, " + RetSqlName("SF2") + " F2, "
_cQuery +=           RetSqlName("SC6") + " C6 "
_cQuery += "WHERE C9_FILIAL = '" + xFilial("SC9") +"' AND B1_FILIAL = '" + xFilial("SB1")+"' AND "
_cQuery += "      F2_FILIAL = '" + xFilial("SF2") + "' AND C6_FILIAL = '" + xFilial("SC6") + "' AND "
_cQuery += "      C9.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND "
_cQuery += "      C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM AND C9_PRODUTO = B1_COD AND C9_NFISCAL = F2_DOC AND "
_cQuery += "      C9_SERIENF = F2_SERIE AND C9_PEDIDO = '" + M->C5_NUM + "' "
_cQuery += "ORDER BY C9_PEDIDO, C9_ITEM, C9_SEQUEN" 
*/

_cQuery := "SELECT C9_PEDIDO, C9_ITEM, B1_PNUMBER, B1_DESC, B1_MARCA, B1_CAPACID, C6_QTDVEN, C9_QTDLIB, C9_SEQUEN, "
_cQuery += "C6_QTDENT, C9_NFISCAL, C9_SERIENF, F2_EMISSAO, C9_LOTECTL,C9_DTVALID, C9_BLEST, C9_BLCRED , C9_AXDTLIB, C9_AXHRLIB "
_cQuery += "FROM " + RetSqlName("SC9") + " C9 "
_cQuery += "inner join " + RetSqlName ("SB1") + " B1 "
_cQuery += "on C9_PRODUTO = B1_COD "
_cQuery += "left join " + RetSqlName ("SF2") + " F2 "
_cQuery += "on C9_NFISCAL = F2_DOC AND C9_SERIENF = F2_SERIE AND F2.D_E_L_E_T_ = ' '"
_cQuery += "inner join " + RetSqlName ("SC6") + " C6 "
_cQuery += "on C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM "
_cQuery += "WHERE C9_FILIAL = '" + xFilial("SC9") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND C6_FILIAL = '" + xFilial("SC6") + "' AND "
_cQuery += "      C9.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "      AND C6.D_E_L_E_T_ = ' ' AND "
_cQuery += "      C9_PEDIDO = '" + M->C5_NUM + "' "
_cQuery += "ORDER BY C9_PEDIDO, C9_ITEM, C9_SEQUEN "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","C6_QTDVEN","N"	,12,2)
TcSetField("QR1","C9_QTDLIB","N"	,12,2)
TcSetField("QR1","C6_QTDENT","N"	,12,2)
TcSetField("QR1","F2_EMISSAO","D"	,08,2)
TcSetField("QR1","C9_DTVALID","D"	,08,2)
TcSetField("QR1","C9_AXDTLIB","D"	,08,2)

_aCampos := QR1->(dbStruct())
aAdd(_aCampos,{ "SITUACAO"	,"C"	,20	,0 } )

_cArqTmp := Criatrab(_aCampos,.t.)
DbUseArea(.t.,,_cArqTmp,"TMP",.f.)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	RecLock("TMP",.t.)
	For _nY :=1 To Len(_aCampos)
		_cCampo := _aCampos[_nY,1]
		If _cCampo <> "SITUACAO"
			TMP->(&_cCampo) := QR1->(&_cCampo)
		Else
			if QR1->C9_BLEST == '10'
				TMP->SITUACAO := "FATURADO"
			ElseIf ! Empty(QR1->C9_BLCRED)
				TMP->SITUACAO := "BLOQUEADO CREDITO"
			ElseIf ! Empty(QR1->C9_BLEST)          
				TMP->SITUACAO := "BLOQUEADO ESTOQUE"
			Else
				TMP->SITUACAO := "LIBERADO"
			EndIf
		EndIf
	Next _nY
	TMP->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fMostra007ºAutor  ³Microsiga           º Data ³  19/08/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fMostra007()

Local oDlg,oGrp1,oSBtn2

_aBrowse := {}

aAdd(_aBrowse,	{ 'C9_PEDIDO'		,, 'Pedido'			, '' 				} )
aAdd(_aBrowse,	{ 'C9_ITEM'			,, 'Item'			, '' 				} )
aAdd(_aBrowse,	{ 'B1_PNUMBER'		,, 'Referencia'		, '' 				} )
aAdd(_aBrowse,	{ 'B1_DESC'			,, 'Descricao'		, '' 				} )
aAdd(_aBrowse,	{ 'B1_MARCA'		,, 'Marca'			, '' 				} )
aAdd(_aBrowse,	{ 'B1_CAPACID'		,, 'Capacidade'		, '' 				} )
aAdd(_aBrowse,	{ 'C6_QTDVEN'		,, 'Qt.Vendida'		, '@e 999,999.99' 	} )
aAdd(_aBrowse,	{ 'SITUACAO'		,, 'Situacao'		, '' 				} )
aAdd(_aBrowse,	{ 'C9_QTDLIB'		,, 'Qt.Liberada'	, '@e 999,999.99' 	} )
aAdd(_aBrowse,	{ 'C9_SEQUEN'		,, 'Sequ.'			, '' 				} )
aAdd(_aBrowse,	{ 'C6_QTDENT'		,, 'Qt.Entregue'	, '@e 999,999.99'	} )
aAdd(_aBrowse,	{ 'C9_NFISCAL'		,, 'Nota Fiscal'	, ''				} )
aAdd(_aBrowse,	{ 'C9_SERIENF'		,, 'Serie'			, ''				} )
aAdd(_aBrowse,	{ 'F2_EMISSAO'		,, 'Emissao'		, ''				} )
aAdd(_aBrowse,	{ 'C9_LOTECTL'		,, 'Nr.Lote'		, ''				} )
aAdd(_aBrowse,	{ 'C9_DTVALID'		,, 'Validade'		, ''				} )
aAdd(_aBrowse,	{ 'C9_AXDTLIB'		,, 'Data Liberacao'	, ''				} )
aAdd(_aBrowse,	{ 'C9_AXHRLIB'		,, 'Hora Liberacao'	, ''				} )

TMP->(DbGoTop())

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Consulta posicao do pedido de Vendas"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 804
oDlg:nHeight := 407
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oGrp1 := TGROUP():Create(oDlg)
oGrp1:cName := "oGrp1"
oGrp1:nLeft := 17
oGrp1:nTop := 16
oGrp1:nWidth := 756
oGrp1:nHeight := 300
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oMark:= MsSelect():New("TMP",,,_aBrowse,.F.,"",{16,17,150,378})

oSBtn2 := SBUTTON():Create(oDlg)
oSBtn2:cName := "oSBtn2"
oSBtn2:cCaption := "OK"
oSBtn2:nLeft := 638
oSBtn2:nTop := 334
oSBtn2:nWidth := 52
oSBtn2:nHeight := 22
oSBtn2:lShowHint := .F.
oSBtn2:lReadOnly := .F.
oSBtn2:Align := 0
oSBtn2:lVisibleControl := .T.
oSBtn2:nType := 1
oSBtn2:bAction := {|| oDlg:End() }

oDlg:Activate()

Return
