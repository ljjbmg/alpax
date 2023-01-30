#Include "rwmake.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#Include "Topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR008    ºAutor  ³Microsiga           º Data ³  07/16/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PEDIDOS DE COMPRAS VENCIDOS.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function WFR008()

WfPrepEnv("01","01")
CHKFILE("SC7")
CHKFILE("SA2")
CHKFILE("SB1")

_cQuery := "SELECT C7_NUM+'/'+C7_ITEM AS PED, A2_COD + '/' + A2_LOJA + '-' + A2_NREDUZ AS RAZAO, A2_AXEMAIL,  "
_cQuery += "       RTRIM(B1_PNUMBER)+'-'+B1_DESC AS PRODUTO, C7_QUANT - C7_QUJE AS SALDO, C7_DATPRF , C7_USER "
_cQuery += "FROM " + RetSqlName("SC7") + " C7, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA2") + " A2     "
_cQuery += "WHERE C7.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' '    AND A2.D_E_L_E_T_ = ' '                      "
_cQuery += "      AND B1_FILIAL = '" + xFilial("SB1") + "' AND C7_FILIAL = '" + xFilial("SC7") + "'           "
_cQuery += "      AND (C7_QUANT - C7_QUJE) > 0 AND C7_RESIDUO = ' ' AND C7_DATPRF < '" + Dtos(dDataBase) + "' "
_cQuery += "      AND C7_PRODUTO = B1_COD AND C7_FORNECE = A2_COD AND C7_LOJA = A2_LOJA                       "
_cQuery += "ORDER BY RAZAO, C7_USER                                                                           "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"
TcSetField("QR1","SALDO"	,"N",12	,2)
TcSetField("QR1","C7_DATPRF","D",08	,0)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	_cComprador := QR1->C7_USER
	_cFornece	:= QR1->RAZAO
	_cMailFor	:= Alltrim(QR1->A2_AXEMAIL)

	If Empty(QR1->A2_AXEMAIL)
		Conout("Fornecedor com e-mail em branco !!!")
	EndIf
	oProcess:= TWFProcess():New( "000002", "Pedido de Compras vencidos" )
	oProcess:NewVersion(.T.)
	oProcess:NewTask( "Pedidos Compras Vencidos", "\WORKFLOW\PC_ATRSO.HTM" )
	oProcess:cSubject := "Pedidos de Compras Vencidos do Fornecedor " + QR1->RAZAO
	oProcess:cTo  := "rita.uno@alpax.com.br"
	oProcess:cCC  := UsrRetMail(QR1->C7_USER) + iif(! Empty(_cMailFor),";"+_cMailFor,"")
	oProcess:cBCC := ""
	oProcess:bReturn := ""
	
	oHtml   := oProcess:oHTML
	oHtml:ValByName( "DTA"    	, DTOC(dDataBase)  				)
	oHtml:ValByName( "HORA"    	, Transform(Time(),"99:99:99")	)  
	oHtml:ValByName( "COMPR"   	, UsrRetName(QR1->C7_USER)  	) 
	oHtml:ValByName( "A2_NOME"	, QR1->RAZAO					)
	
	Do While ! QR1->(Eof()) .And. _cComprador == QR1->C7_USER .And. _cFornece == QR1->RAZAO
		aAdd( (oHtml:ValByName( "IT.PED"    	)), QR1->PED									)
		aAdd( (oHtml:ValByName( "IT.PRODUTO"   	)), QR1->PRODUTO								)
		aAdd( (oHtml:ValByName( "IT.QT"		   	)), Transform(QR1->SALDO,"@e 999,999,999.99")	)
		aAdd( (oHtml:ValByName( "IT.DT"		   	)), DTOC(QR1->C7_DATPRF)						)
		QR1->(DbSkip())
	EndDo
	oProcess:Start()
EndDo	
ConOut("Termino envio de pedidos de compras vencidos ....")
QR1->(DbCloseArea())
	
Return
