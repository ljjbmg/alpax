/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR027    บAutor  ณOcimar Rolli        บ Data ณ  02/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para geracao do workflow de or็amentos efetivados no บฑฑ
ฑฑบ          ณdia, enviando para cada vendedor/representante os seus.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#include "Rwmake.ch"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "tbiConn.ch"
#INCLUDE "TOPCONN.CH"


User Function WFR027_A()

U_WFR027({"01","01"})

Return

User Function WFR027(aParam)

Local _aItens := {}
Local _cNome	:= ""
Local _cEmail	:= ""

Private _cVend  := ""

WfPrepEnv(aParam[1],aParam[2])

_cQuery := "SELECT A3_NOME AS VENDEDOR "
_cQuery += ",      A1_NOME AS CLIENTE "
_cQuery += ",      CK_NUM AS ORCAMENTO "
_cQuery += ",      C6_NUM AS PEDIDO "
_cQuery += ",      (RTRIM(SB1.B1_DESC)+'-'+RTRIM(SB1.B1_CAPACID)+'-'+RTRIM(SB1.B1_MARCA)) AS PRODUTO "
_cQuery += ",      CK_QTDVEN AS QORC "
_cQuery += ",      CK_PRCVEN AS UORC "
_cQuery += ",      CK_VALOR AS TORC "
_cQuery += ",      C6_QTDVEN AS QVEND "
_cQuery += ",      C6_PRCVEN AS UVEND "
_cQuery += ",      C6_VALOR AS TVEND "
_cQuery += ",      A3_COD AS CODIGO "
_cQuery += ",      A3_EMAIL AS EMAIL_VEND "
_cQuery += "       FROM " + RetSqlName("SC6") + " SC6 "
_cQuery += "INNER JOIN " + RetSqlName("SC5") + " SC5 "
_cQuery += "ON SC6.C6_NUM = SC5.C5_NUM "
_cQuery += "INNER JOIN " + RetSqlName("SCK") + " SCK "
_cQuery += "ON SC6.C6_NUMORC = (SCK.CK_NUM+SCK.CK_ITEM) "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += "ON SC6.C6_PRODUTO = SB1.B1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SA1") + " SA1 "
_cQuery += "ON SC5.C5_CLIENTE = SA1.A1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SA3") + " SA3 "
_cQuery += "ON SC5.C5_VEND1 = SA3.A3_COD "
//_cQuery += "WHERE DATEDIFF(DAY,C5_EMISSAO,GETDATE()) = 1 AND A3_COD <> '000032' "
_cQuery += "WHERE C5_EMISSAO = '" + DTOS(dDataBase) + "' AND A3_COD <> '000032' " 
_cQuery += "ORDER BY A3_COD, CK_NUM "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())
    _cVend  := QR1->CODIGO            
	_cNome	:= QR1->VENDEDOR
	_cEmail	:= QR1->EMAIL_VEND
	_aItens := {}
	Do While ! 	QR1->(Eof()) .And. 	_cVend == QR1->CODIGO
		// _aItens[x,01] = Nome do cliente
		// _aItens[x,02] = Numero do or็amento
		// _aItens[x,03] = Numero do pedido 
		// _aItens[x,04] = Produto
		// _aItens[x,05] = Quantidade or็ada
		// _aItens[x,06] = Valor unitario or็ado
		// _aItens[x,07] = Valor total or็ado
		// _aItens[x,08] = Quantidade pedida 
		// _aItens[x,09] = Valor unitario pedido
		// _aItens[x,10] = Valor total pedido		
		aAdd(_aItens,{QR1->CLIENTE,QR1->ORCAMENTO, QR1->PEDIDO, QR1->PRODUTO, QR1->QORC, QR1->UORC, QR1->TORC, QR1->QVEND, QR1->UVEND, QR1->TVEND})
		QR1->(DbSkip())	
	EndDo
	If Len(_aItens) > 0
		// Funcao para enviar e-mail da matriz carregada de cada representante/vendedor.	
		fEnviaWF(_aItens,_cNome,_cEmail)
	EndIf
EndDo
QR1->(DbCloseArea())
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfEnviaWF  บAutor  ณOcimar Rolli        บ Data ณ  02/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de envio de e-mail.                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


Static Function fEnviaWF(_aItens,_cNome,_cEmail)

oProcess:= TWFProcess():New( "000027", "Orcamentos efetivados no dia " )
oProcess:NewVersion(.T.)
oProcess:NewTask( "Orcamentos efetivados (Pedidos)", "\WORKFLOW\ORC_OCI.HTM" )
oProcess:cSubject 	:= "Orcamentos efetivados no dia " + Dtoc(dDataBase)
oProcess:cTo  		:= _cEmail
oProcess:cCC	    := "luciano.pereira@alpax.com.br"
oProcess:bReturn := ""
oHtml   := oProcess:oHTML
oHtml:ValByName( "VEND"    		, _cNome			)
oHtml:ValByName( "DTREF"    	, dDataBase			)
_lPrimeiro := .f.

		// _aItens[x,01] = Nome do cliente
		// _aItens[x,02] = Numero do or็amento
		// _aItens[x,03] = Numero do pedido 
		// _aItens[x,04] = Produto
		// _aItens[x,05] = Quantidade or็ada
		// _aItens[x,06] = Valor unitario or็ado
		// _aItens[x,07] = Valor total or็ado
		// _aItens[x,08] = Quantidade pedida 
		// _aItens[x,09] = Valor unitario pedido
		// _aItens[x,10] = Valor total pedido
		
For _nY := 1 To Len(_aItens)
	aAdd( (oHtml:ValByName( "IT.CLI"    		)), _aItens[_nY,01]														)
	aAdd( (oHtml:ValByName( "IT.ORC"    		)), _aItens[_nY,02]                                                     )
	aAdd( (oHtml:ValByName( "IT.PED"    		)), _aItens[_nY,03]														)
	aAdd( (oHtml:ValByName( "IT.PROD"    		)), _aItens[_nY,04]														)
	aAdd( (oHtml:ValByName( "IT.QORC"    		)), _aItens[_nY,05]                                                     )
	aAdd( (oHtml:ValByName( "IT.UORC"    		)), Transform(_aItens[_nY,06],"@E 999,999.99")                          )
	aAdd( (oHtml:ValByName( "IT.TORC"    		)), Transform(_aItens[_nY,07],"@E 999,999.99")  						)
	aAdd( (oHtml:ValByName( "IT.QVEN"    		)), _aItens[_nY,08]														)
	aAdd( (oHtml:ValByName( "IT.UVEN"    		)), Transform(_aItens[_nY,09],"@E 999,999.99")							)
	aAdd( (oHtml:ValByName( "IT.TVEN"    		)), Transform(_aItens[_nY,10],"@E 999,999.99")							)	
Next _nY

oProcess:Start()	

Return
