/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR018    บAutor  ณOcimar Rolli        บ Data ณ  30/04/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para geracao do workflow de pedidos efetivados no    บฑฑ
ฑฑบ          ณdia. enviando para cada vendedor/representante os seus.     บฑฑ
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


User Function WFR018_A()

U_WFR018({"01","01"})

Return

User Function WFR018(aParam)

Local _aItens := {}
Local _cNome	:= ""
Local _cEmail	:= ""

Private _cVend  := ""

WfPrepEnv(aParam[1],aParam[2])

_cQuery := "SELECT CK_NUM AS NUMORC, SUM(CK_VALOR) AS VALORC, C6_NUM AS NUMPED, SUM(C6_VALOR) AS VALPED, "
_cQuery += "       A1_NOME AS CLIENTE, A3_NOME AS VENDEDOR, A3_EMAIL AS EMAIL_VEND, A3_COD AS CODIGO "
_cQuery += "       FROM " + RetSqlName("SC6") + " C6 "
_cQuery += "       INNER JOIN " + RetSqlName("SCK") + " CK "
_cQuery += "       ON C6_NUMORC = (CK_NUM+CK_ITEM) "
_cQuery += "	   INNER JOIN " + RetSqlName("SA1") + " SA "
_cQuery += "       ON CK_CLIENTE = A1_COD "
_cQuery += "       INNER JOIN " + RetSqlName("SCJ") + " CJ "
_cQuery += "       ON CK_NUM = CJ_NUM "
_cQuery += "       INNER JOIN " + RetSqlName("SA3") + " A3 "
_cQuery += "       ON CJ_AXVEND = A3_COD "
_cQuery += "       INNER JOIN " + RetSqlName("SC5") + " C5 "
_cQuery += "       ON C6_NUM = C5_NUM "
_cQuery += "       WHERE CK.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND C6_BLQ = ' ' AND A3_COD NOT IN ('000032','000063') "
_cQuery += "       AND DATEDIFF(DD,C5_EMISSAO,GETDATE()) = 0 "
_cQuery += "       GROUP BY C6_NUM, CK_NUM, A1_NOME, A3_NOME, A3_EMAIL, A3_COD "
_cQuery += "       ORDER BY A3_NOME "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())            
	_cVend 	:= QR1->CODIGO
	_cNome	:= QR1->VENDEDOR
	_cEmail	:= QR1->EMAIL_VEND
	_aItens := {}
	Do While ! 	QR1->(Eof()) .And. 	_cVend == QR1->CODIGO
		// _aItens[x,1] = Numero do orcamento
		// _aItens[x,2] = Valor do orcamento
		// _aItens[x,3] = Nome do Cliente 
		// _aItens[x,4] = Numero do pedido
		// _aItens[x,5] = Valor do pedido
		aAdd(_aItens,{QR1->NUMORC, QR1->VALORC, QR1->CLIENTE, QR1->NUMPED, QR1->VALPED})
		QR1->(DbSkip())	
	EndDo
	If Len(_aItens) > 0
		// Funcao para enviar e-mail da matriz carregada de cada representante/vendedor.	
		fEnviaWF(_aItens,_cNome,_cEmail)
	EndIf
EndDo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfEnviaWF  บAutor  ณOcimar Rolli        บ Data ณ  30/04/11   บฑฑ
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

oProcess:= TWFProcess():New( "000018", "Orcamentos efetivados no dia" )
oProcess:NewVersion(.T.)
oProcess:NewTask( "Orcamentos efetivados (Pedidos)", "\WORKFLOW\ORCEFE.HTM" )
oProcess:cSubject 	:= "Orcamentos efetivados no dia " + Dtoc(dDataBase)
oProcess:cTo  		:= _cEmail
oProcess:cCC	    := "luciano.pereira@alpax.com.br"
oProcess:bReturn := ""
oHtml   := oProcess:oHTML
oHtml:ValByName( "VEND"    		, _cNome			)
_lPrimeiro := .f.

// _aItens[x,1] = Numero do orcamento
// _aItens[x,2] = Valor do orcamento
// _aItens[x,3] = Nome do Cliente 
// _aItens[x,4] = Numero do pedido
// _aItens[x,5] = Valor do pedido
		
For _nY := 1 To Len(_aItens)
	aAdd( (oHtml:ValByName( "IT.ORC"    		)), _aItens[_nY,01]														)
	aAdd( (oHtml:ValByName( "IT.VALORC"    		)), Transform(_aItens[_nY,02],"@E 999,999.99")  						)
	aAdd( (oHtml:ValByName( "IT.CLI"    		)), _aItens[_nY,03]														)
	aAdd( (oHtml:ValByName( "IT.PED"    		)), _aItens[_nY,04]														)
	aAdd( (oHtml:ValByName( "IT.VALPED"    		)), Transform(_aItens[_nY,05],"@E 999,999.99")							)	
Next _nY

oProcess:Start()	

Return
