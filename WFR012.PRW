/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR012    บAutor  ณMicrosiga           บ Data ณ  13/05/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Workflow de envio de e-mail dos pedidos de vendas pendentesบฑฑ
ฑฑบ          ณ dos produtos tipo ISO / RBC                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "rwmake.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#Include "Topconn.ch"

User Function WFR012()

WfPrepEnv("01","01")

CHKFILE("SC5")
CHKFILE("SC6")
CHKFILE("SB1")
CHKFILE("SA1")  

_cQuery := "SELECT C6_NUM, C6_ITEM, B1_PNUMBER, B1_DESC, (C6_QTDVEN-C6_QTDENT) AS SALDO, A1_NREDUZ, C5_EMISSAO, C6_ENTREG, "
_cQuery += "       B1_MARCA "
_cQuery += "       FROM " + RetSqlName("SC6") + " C6 "
_cQuery += "            INNER JOIN " + RetSqlName("SC5") + " C5 "
_cQuery += "                       ON C6_NUM = C5_NUM "
_cQuery += "            INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "                       ON C6_CLI = A1_COD AND C6_LOJA = A1_LOJA "
_cQuery += "            INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                       ON C6_PRODUTO = B1_COD "
_cQuery += "            INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "                       ON C6_TES = F4_CODIGO "
_cQuery += "       WHERE C6.D_E_L_E_T_ = ' ' AND C5.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "             AND C6_QTDENT < C6_QTDVEN AND C6_AXCALIB = 'S' AND C6_LOCAL = 'SL' "
_cQuery += "             AND C5_TIPO = 'N' AND C6_BLQ <> 'R' AND F4_ESTOQUE = 'S' "
_cQuery += "ORDER BY C5_EMISSAO, C6_NUM, C6_ITEM "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","SALDO"		,"N",10,2)
TcSetField("QR1","C5_EMISSAO"	,"D",08,0)
TcSetField("QR1","C6_ENTREG"	,"D",08,0)

_cMail 		:= "luci@alpax.com.br;metrologia@alpax.com.br;elaine.neves@alpax.com.br" // ALTERADO EM 17/11/06 POR OCIMAR
_lPrimeiro	:= .t.

Do While ! QR1->(Eof())
	
	If _lPrimeiro
		oProcess:= TWFProcess():New( "000030", "Pedido de Vendas Mat.Calibrado" )
		oProcess:NewVersion(.T.)
		oProcess:NewTask( "Pedido de Vendas Mat.Calibrado", "\WORKFLOW\PRODUTO_ISO_RBC.HTM" )
		oProcess:cSubject := "Pedidos de Vendas em aberto Material Calibrado "
		oProcess:cTo  := _cMail
		oProcess:cCC  := ""
		oProcess:bReturn := ""
		oHtml   := oProcess:oHTML
		oHtml:ValByName( "DTREF"    	, DTOC(dDataBase)  )
		_lPrimeiro := .f.
	EndIf
	
	aAdd( (oHtml:ValByName( "IT.PD"  	  	)), QR1->C6_NUM									)
	aAdd( (oHtml:ValByName( "IT.PROD"    	)), " (" + QR1->B1_PNUMBER + ") " + QR1->B1_DESC + "( " + QR1->B1_MARCA + " )" 	)
	aAdd( (oHtml:ValByName( "IT.QT"			)), Transform(QR1->SALDO,"@e 999,999")			)
	aAdd( (oHtml:ValByName( "IT.CLI"    	)), QR1->A1_NREDUZ								)
	aAdd( (oHtml:ValByName( "IT.EM"	    	)), DTOC(QR1->C5_EMISSAO)    					)
	aAdd( (oHtml:ValByName( "IT.PRE"	   	)), DTOC(QR1->C6_ENTREG)    					)
	
	QR1->(DbSkip())
EndDo

If ! _lPrimeiro
	oProcess:Start()
EndIf

QR1->(DbCloseArea())

return
