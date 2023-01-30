/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR017    บAutor  ณMicrosiga           บ Data ณ  09/12/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para gerar um workflow agendado, de pedidos de vendasบฑฑ
ฑฑบ          ณliberados porem nao faturados apos 5 dias.                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - alpax.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

#include "Rwmake.ch"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "tbiConn.ch"
#INCLUDE "TOPCONN.CH"

User Function WFR017()

WfPrepEnv("01","01")

Private _cCC		:= ""
Private _aDetalhe	:= {}
Private _cEmail 	:= ""
Private _lPrimeiro	:= .t.
Private _dDataIni	:= (dDataBase-5)


_cQuery := "SELECT C9_PEDIDO, C9_ITEM, C9_PRODUTO, C9_QTDLIB, B1_PNUMBER, B1_DESC, B1_CAPACID, C9_DATALIB "
_cQuery += "       FROM " + RetSqlName("SC9") + " C9 "
_cQuery += "           INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                   ON B1_FILIAL = '" + xFilial("SB1") + "' AND C9_PRODUTO = B1_COD  AND  B1.D_E_L_E_T_ = ' ' "
_cQuery += "       WHERE C9_FILIAL = '" + xFilial("SC9") + "' AND C9.D_E_L_E_T_ = ' ' "
_cQuery += "             AND C9_BLEST = ' ' AND C9_BLCRED = ' ' AND C9_DATALIB < '" + Dtos(_dDataIni) + "' "
_cQuery += "       ORDER BY C9_PEDIDO, C9_ITEM "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","C9_QTDLIB"	,"N",12,2)
TcSetField("QR1","C9_DATALIB"	,"D",08,0)                     


QR1->(DbGoTop())

_cEmail 	:= "luci@alpax.com.br"
_lPrimeiro	:= .t.
Do While ! QR1->(Eof())
	If _lPrimeiro
		_lPrimeiro := .f.
		oProcess := TWFProcess():New( "WFR017", "Pedidos de vendas liberado e nao faturado" )
		
		// Cria-se uma nova tarefa para o processo.
		oProcess:NewTask( "Orcamento", "\WORKFLOW\PV_LIB_NAO_FATURADOS.HTM" )
		oProcess:cSubject := "Pedidos de vendas liberado e nao faturado"
		oProcess:cTo  := _cEmail
		oProcess:cCC  := _cCC
		oProcess:cBCC := ""
		oProcess:bReturn := ""
		
		// Faz uso do objeto ohtml que pertence ao processo
		oHtml := oProcess :oHtml	
	  	oHtml:ValByName( "DTREF"    	, DTOC(dDataBase)  )
	EndIf
	
	AAdd( (oHtml:ValByName( "IT.PED"	))	,QR1->C9_PEDIDO+"/"+QR1->C9_ITEM												)
	AAdd( (oHtml:ValByName( "IT.PRODUTO"))	,Alltrim(QR1->B1_PNUMBER)+"-"+Alltrim(QR1->B1_DESC)+"-"+Alltrim(QR1->B1_CAPACID))
	AAdd( (oHtml:ValByName( "IT.QUANT"	))	,Transform(QR1->C9_QTDLIB,"@ 9,999,999.99")										)
	AAdd( (oHtml:ValByName( "IT.DIAS"	))	,Transform((dDataBase-QR1->C9_DATALIB),"@e9,999")								)
	QR1->(DbSkip())	
	
EndDo

If ! _lPrimeiro
	oProcess:Start()
EndIf

QR1->(DbCloseArea())

Return
