/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR011    ºAutor  ³Microsiga           º Data ³  17/12/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Workflow para enviar e-mail dos produtos vencidos ou a ven  º±±
±±º          ³cer em 60 dias.                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "rwmake.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#Include "Topconn.ch"


User Function WFR011()

WfPrepEnv("01","01")

_cQuery := "SELECT B1_DESC, B1_CAPACID, B1_PNUMBER, B8_LOCAL, B8_DTVALID, B8_SALDO, B8_LOTECTL, B1_MARCA, B1_AXRISCO "
_cQuery += "FROM " + RetSqlName("SB8") + " B8, " + RetSqlName("SB1") + " B1 "
_cQuery += "WHERE B8.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' '  AND B8_FILIAL = '" + xFilial("SB8") + "' "
_cQuery += "      AND B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "      AND B8_PRODUTO = B1_COD AND B8_SALDO > 0 AND B8_DTVALID <= '" + Dtos(dDataBase + 60) + "' "
_cQuery += "ORDER BY B8_DTVALID "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B8_DTVALID"	,"D",08	,00)
TcSetField("QR1","B8_SALDO"		,"N",12	,00)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	oProcess:= TWFProcess():New( "000011", "Produtos a Vencer e vencidos" )
	oProcess:NewVersion(.T.)
	oProcess:NewTask( "Produtos a Vencer e vencidos", "\WORKFLOW\PRODVENC.HTM" )
	oProcess:cSubject 	:= "Produtos a Vencer e vencidos "
	oProcess:cTo  		:= "cleberson@alpax.com.br"
	oProcess:cCC	    := ""  //diego.cipa@alpax.com.br
	oProcess:bReturn := ""
	
	oHtml   := oProcess:oHTML
	
	oHtml:ValByName( "DTREF"    	, DTOC(dDataBase)  )
	Do While ! QR1->(Eof()) 
		aAdd( (oHtml:ValByName( "IT.REF"    	)), QR1->B1_PNUMBER											  		)
		aAdd( (oHtml:ValByName( "IT.DESC"    	)), QR1->B8_LOCAL + "-"+QR1->B1_DESC+"("+QR1->B1_AXRISCO+")"		)
		aAdd( (oHtml:ValByName( "IT.MARCA"    	)), QR1->B1_MARCA	 					 							)
		aAdd( (oHtml:ValByName( "IT.CAPACID"    )), QR1->B1_CAPACID  												)
		aAdd( (oHtml:ValByName( "IT.LOTE"    	)), QR1->B8_LOTECTL													)
		aAdd( (oHtml:ValByName( "IT.VALID"    	)), DTOC(QR1->B8_DTVALID)    										)              	
		aAdd( (oHtml:ValByName( "IT.SALDO"    	)), Transform(QR1->B8_SALDO,"@e999,999,999")						)
		
		QR1->(DbSkip())
	EndDo
	oProcess:Start()	
EndDo

QR1->(DbCloseArea())

Return
