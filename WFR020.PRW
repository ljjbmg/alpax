/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR020    ºAutor  ³Microsiga           º Data ³  24/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Workflow para gerar e-mail diario dos produtos de terceirosº±±
±±º          ³ em poder da Alpax.                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include "Topconn.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"

User Function WFR020()

WfPrepEnv("01","01")

CHKFILE("SA1")
CHKFILE("SA2")

_cQuery := "SELECT B6_DOC, B6_EMISSAO, B6_CLIFOR, B6_LOJA, B6_TPCF, B6_TES, B1_PNUMBER, B1_DESC, B6_SALDO, B6_LOCAL "
_cQuery += "FROM " + RetSqlName("SB6") + " B6 "                                                                                		
_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 " 
_cQuery += "               ON B6_PRODUTO = B1_COD AND B1_FILIAL = '" + xFilial("SB1") + "' AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "               ON B6_TES = F4_CODIGO AND F4_FILIAL = '" + XfILIAL("SF4") + "' "
_cQuery += "WHERE  B6_TIPO = 'D' AND  B6_SALDO > 0 AND B6.D_E_L_E_T_ = ' ' AND SUBSTRING(F4_CF,2,3) = '912' "
_cQuery += "ORDER BY B6_LOCAL, B6_EMISSAO "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B6_EMISSAO"	,"D",08,0)
TcSetField("QR1","B6_SALDO"		,"N",12,2)

_lPrimeiro := .t.

Do While ! QR1->(Eof())
	If _lPrimeiro 
		oProcess:= TWFProcess():New( "000017", "Produtos em Fornecedores" )
		oProcess:NewVersion(.T.)
		oProcess:NewTask( "produto de terceiros em nosso poder", "\WORKFLOW\PODER_DE_T.HTM" )
		oProcess:cSubject 	:= "Demonstracao de terceiros em nosso poder "
		oProcess:cTo  		:= "luci.masumoto@alpax.com.br"
		oProcess:cCC	    := "luciano.pereira@alpax.com.br"
		oProcess:bReturn := ""
		oHtml   := oProcess:oHTML
		oHtml:ValByName( "DTREF"    	, DTOC(dDataBase)    )
		oHtml:ValByName( "TIPO"     	, "DEMONSTRACAO"     )		
		_lPrimeiro := .f.
	EndIf                                                                              

	If QR1->B6_TPCF = "C"
		SA1->(DbSeek(xFilial("SA1")+QR1->B6_CLIFOR+QR1->B6_LOJA))
		_cCF := "C-"+SA1->A1_COD+"/"+SA1->A1_LOJA+"-"+SA1->A1_NOME
	Else
		SA2->(DbSeek(xFilial("SA2")+QR1->B6_CLIFOR+QR1->B6_LOJA))
		_cCF := "F-"+SA2->A2_COD+"/"+SA2->A2_LOJA+"-"+SA2->A2_NOME
	EndIf
	                
	aAdd( (oHtml:ValByName( "IT.NF"    		)), QR1->B6_DOC								)
	aAdd( (oHtml:ValByName( "IT.EM"    		)), Dtoc(QR1->B6_EMISSAO)					)	
	aAdd( (oHtml:ValByName( "IT.CF"    		)), _cCF									)
	aAdd( (oHtml:ValByName( "IT.TES"   		)), QR1->B6_TES 							)	
	aAdd( (oHtml:ValByName( "IT.PROD"  		)), QR1->B1_PNUMBER+" - "+QR1->B1_DESC		)
	aAdd( (oHtml:ValByName( "IT.LOC"   		)), QR1->B6_LOCAL 							)			
	aAdd( (oHtml:ValByName( "IT.SLD"  		)), Transform(QR1->B6_SALDO,"@e 999,999.99"))
	
	QR1->(DbSkip())
EndDo             

If ! _lPrimeiro
	oProcess:Start()	
EndIf

QR1->(DbCloseArea())

Return
