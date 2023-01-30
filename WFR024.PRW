/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR024    ºAutor  ³Ocimar              º Data ³  25/10/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Workflow para gerar e-mail diario dos produtos que entraramº±±
±±º          ³ na empresa no armazem 02 (laboratorio) nos ultimos 7 dias  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include "Topconn.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"

User Function WFR024()

WfPrepEnv("01","01")

//CHKFILE("SA2")


_cQuery := "SELECT D1_DOC, D1_DTDIGIT, A2_NREDUZ, B1_PNUMBER, B1_DESC, B1_CAPACID, D1_QUANT, B1_MARCA "
_cQuery += "FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "       INNER JOIN " + RetSqlNAme("SA2") + " A2 "
_cQuery += "               ON D1_FORNECE = A2_COD "
_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "               ON D1_COD = B1_COD "
_cQuery += "WHERE D1_LOCAL = '02' AND D1_DTDIGIT BETWEEN (GETDATE()-7) AND GETDATE() " 
_cQuery += "                      AND SUBSTRING(D1_CF,2,3) = '102' AND D1.D_E_L_E_T_ = ' ' "
_cQuery += "ORDER BY D1_DTDIGIT "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D1_DTDIGIT"	,"D",08,0)
TcSetField("QR1","D1_QUANT"		,"N",12,2)

_lPrimeiro := .t.

Do While ! QR1->(Eof())
	If _lPrimeiro
		oProcess:= TWFProcess():New( "0000024", "Compras para laboratorio" )
		oProcess:NewVersion(.T.)
		oProcess:NewTask( "Compras para laboratorio", "\WORKFLOW\COMPRAS_LAB.HTM" )
		oProcess:cSubject 	:= "Compras para laboratorio "
		oProcess:cTo  		:= ""
		oProcess:cCC	    := "luci@alpax.com.br"
		oProcess:bReturn := ""
		oHtml   := oProcess:oHTML
		oHtml:ValByName( "DTREF"    	, DTOC(dDataBase)  )

		_lPrimeiro := .f.
	EndIf                                                                              
   
	_cProd := QR1->B1_PNUMBER+" - "+QR1->B1_DESC+" - "+QR1->B1_CAPACID+"("+AllTrim(QR1->B1_MARCA)+")"
	
	aAdd( (oHtml:ValByName( "IT.NF"  	)), QR1->D1_DOC										 								)
	aAdd( (oHtml:ValByName( "IT.ENT" 	)), Dtoc(QR1->D1_DTDIGIT)															)	
	aAdd( (oHtml:ValByName( "IT.FOR" 	)), QR1->A2_NREDUZ 																	)	
	aAdd( (oHtml:ValByName( "IT.PROD"	)), _cProd	)	
	aAdd( (oHtml:ValByName( "IT.QUANT"	)), Transform(QR1->D1_QUANT,"@e 999,999.99")										)
	
	QR1->(DbSkip())
EndDo             

If ! _lPrimeiro
	oProcess:Start()	
EndIf

QR1->(DbCloseArea())

Return
