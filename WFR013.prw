/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WFR013    �Autor  �Microsiga           � Data �  24/06/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Workflow para gerar e-mail diario dos produtos que estao   ���
���          � em poder de terceiros.                                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#include "Topconn.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"

User Function WFR013()

WfPrepEnv("01","01")

CHKFILE("SA1")
CHKFILE("SA2")

_cQuery := "SELECT B6_DOC, B6_EMISSAO, B6_CLIFOR, B6_LOJA, B6_TPCF, B6_TES, B1_PNUMBER, B1_DESC, B6_SALDO "
_cQuery += ", (RTRIM(Z7_USUARIO)+' - '+RTRIM(Z7_EQUIPE)) AS ATEND "
_cQuery += "FROM " + RetSqlName("SB6") + " B6 " 
_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 " 
_cQuery += "               ON B6_PRODUTO = B1_COD AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "       INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "               ON B6_TES = F4_CODIGO "
_cQuery += "       INNER JOIN " + RetSqlName("SD2") + " D2 "
_cQuery += "			   ON B6_DOC = D2_DOC AND B6_SERIE = D2_SERIE AND B6_CLIFOR = D2_CLIENTE "
_cQuery += "			   AND D2.D_E_L_E_T_ = ' ' AND D2_COD = B6_PRODUTO "
_cQuery += "	   INNER JOIN " + RetSqlName("SC5") + " C5 "
_cQuery += "			   ON D2_PEDIDO = C5_NUM "
_cQuery += "	   INNER JOIN " + RetSqlName("SZ7") + " Z7 "
_cQuery += "			   ON C5_AXATEN1 = Z7_CODUSR "
_cQuery += "WHERE  B6_TIPO = 'E' AND  B6_SALDO > 0 AND B6.D_E_L_E_T_ = ' ' AND SUBSTRING(F4_CF,2,3) = '949' "
_cQuery += "ORDER BY B6_EMISSAO "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B6_EMISSAO"	,"D",08,0)
TcSetField("QR1","B6_SALDO"		,"N",12,2)

_lPrimeiro := .t.

Do While ! QR1->(Eof())
	If _lPrimeiro
		oProcess:= TWFProcess():New( "000013", "Produtos em clientes" )
		oProcess:NewVersion(.T.)
		oProcess:NewTask( "Produtos em Poder de clientes", "\WORKFLOW\PODER_EM_T.HTM" )
		oProcess:cSubject 	:= "Simples remessa em Poder de Terceiros "
		oProcess:cTo  		:= "luci@alpax.com.br"
		oProcess:cCC	    := "manutencao@alpax.com.br;beth.masumoto@alpax.com.br;beatriz.fernandes@alpax.com.br "
		oProcess:bReturn := ""
		oHtml   := oProcess:oHTML
		oHtml:ValByName( "DTREF"    	, DTOC(dDataBase)  )
		oHtml:ValByName( "TIPO"     	, "SIMPLES REMESSA")		
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
	aAdd( (oHtml:ValByName( "IT.SLD"  		)), Transform(QR1->B6_SALDO,"@e 999,999.99"))
	aAdd( (oHtml:ValByName( "IT.DEPTO" 		)), QR1->ATEND      						)
		
	QR1->(DbSkip())
EndDo             

If ! _lPrimeiro
	oProcess:Start()	
EndIf

QR1->(DbCloseArea())

Return
