/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR028    บAutor  ณOcimar Rolli        บ Data ณ  14/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para geracao do workflow de folow-up dos or็amentos  บฑฑ
ฑฑบ          ณem carteira com status de 7 dias.                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ'ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#include "Rwmake.ch"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "tbiConn.ch"
#INCLUDE "TOPCONN.CH"


User Function WFR028_A()

U_WFR028({"01","01"})

Return

User Function WFR028(aParam)

Local _aItens := {}
Local _cNome	:= ""
Local _cEmail	:= ""

Private _cVend  := ""

WfPrepEnv(aParam[1],aParam[2])


_cQuery := "SELECT SA3.A3_NOME AS VENDEDOR "
_cQuery += ",      A1_NOME AS CLIENTE "
_cQuery += ",      CK_NUM AS ORCAMENTO "
_cQuery += ",      SCK.CK_NUMPV AS PEDIDO "
_cQuery += ",      (RTRIM(SB1.B1_DESC)+'-'+RTRIM(SB1.B1_CAPACID)+'-'+RTRIM(SB1.B1_MARCA)) AS PRODUTO "
_cQuery += ",      CK_QTDVEN AS QORC "
_cQuery += ",      CK_PRCVEN AS UORC "
_cQuery += ",      CK_VALOR AS TORC "
_cQuery += ",      C6_QTDVEN AS QVEND "
_cQuery += ",      C6_PRCVEN AS UVEND "
_cQuery += ",      C6_VALOR AS TVEND "
_cQuery += ",      A3_COD AS CODIGO "
_cQuery += ",      A3_EMAIL AS EMAIL_VEND "
_cQuery += ",      SCJ.CJ_STATUS AS STATUS "
_cQuery += ",      C5_EMISSAO AS EFETIVADO "
_cQuery += "FROM " + RetSqlName("SCK") + " SCK "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += "ON SCK.CK_PRODUTO = SB1.B1_COD AND SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "INNER JOIN " + RetSqlName("SA1") + " SA1 "
_cQuery += "ON SCK.CK_CLIENTE = SA1.A1_COD AND SA1.A1_FILIAL = '" + xFilial("SA1") + "' "
_cQuery += "INNER JOIN " + RetSqlName("SCJ") + " SCJ "
_cQuery += "ON SCK.CK_NUM = SCJ.CJ_NUM AND SCJ.CJ_FILIAL = '" + xFilial("SCJ") + "' "
_cQuery += "INNER JOIN " + RetSqlName("SA3") + " SA3 "
_cQuery += "ON SA3.A3_COD = SCJ.CJ_AXVEND AND SA3.A3_FILIAL = '" + xFilial("SA3") + "' "
_cQuery += "LEFT JOIN " + RetSqlName("SC6") + " SC6 "
_cQuery += "ON SC6.C6_NUMORC = (SCK.CK_NUM+SCK.CK_ITEM) AND SC6.C6_FILIAL = '" + xFilial("SC6") + "'"
_cQuery += "LEFT JOIN " + RetSqlName("SC5") + " SC5 "
_cQuery += "ON SC6.C6_NUM = SC5.C5_NUM AND SC5.C5_FILIAL = '" + xFilial("SC5") + "'"
_cQuery += "WHERE SCJ.CJ_STATUS = 'A' "
_cQuery += "AND SA3.A3_COD NOT IN ('000032','000063') "
_cQuery += "UNION ALL "
_cQuery += "SELECT SA3.A3_NOME AS VENDEDOR "
_cQuery += ",      A1_NOME AS CLIENTE "
_cQuery += ",      CK_NUM AS ORCAMENTO "
_cQuery += ",      SCK.CK_NUMPV AS PEDIDO "
_cQuery += ",      (RTRIM(SB1.B1_DESC)+'-'+RTRIM(SB1.B1_CAPACID)+'-'+RTRIM(SB1.B1_MARCA)) AS PRODUTO "
_cQuery += ",      CK_QTDVEN AS QORC "
_cQuery += ",      CK_PRCVEN AS UORC "
_cQuery += ",      CK_VALOR AS TORC "
_cQuery += ",      C6_QTDVEN AS QVEND "
_cQuery += ",      C6_PRCVEN AS UVEND "
_cQuery += ",      C6_VALOR AS TVEND "
_cQuery += ",      A3_COD AS CODIGO "
_cQuery += ",      A3_EMAIL AS EMAIL_VEND "
_cQuery += ",      SCJ.CJ_STATUS AS STATUS "
_cQuery += ",      C5_EMISSAO AS EFETIVADO "
_cQuery += "FROM " + RetSqlName("SCK") + " SCK "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += "ON SCK.CK_PRODUTO = SB1.B1_COD AND SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "INNER JOIN " + RetSqlName("SA1") + " SA1 "
_cQuery += "ON SCK.CK_CLIENTE = SA1.A1_COD AND SA1.A1_FILIAL = '" + xFilial("SA1") + "' "
_cQuery += "INNER JOIN " + RetSqlName("SCJ") + " SCJ "
_cQuery += "ON SCK.CK_NUM = SCJ.CJ_NUM AND SCJ.CJ_FILIAL = '" + xFilial("SCJ") + "' "
_cQuery += "INNER JOIN " + RetSqlName("SA3") + " SA3 "
_cQuery += "ON SA3.A3_COD = SCJ.CJ_AXVEND AND SA3.A3_FILIAL = '" + xFilial("SA3") + "' "
_cQuery += "LEFT JOIN " + RetSqlName("SC6") + " SC6 "
_cQuery += "ON SC6.C6_NUMORC = (SCK.CK_NUM+SCK.CK_ITEM) AND SC6.C6_FILIAL = '" + xFilial("SC6") + "'"
_cQuery += "LEFT JOIN " + RetSqlName("SC5") + " SC5 "
_cQuery += "ON SC6.C6_NUM = SC5.C5_NUM AND SC5.C5_FILIAL = '" + xFilial("SC5") + "'"
_cQuery += "WHERE SCJ.CJ_EMISSAO >= (GETDATE()-7) "
_cQuery += "AND SCJ.CJ_STATUS = 'C' "
_cQuery += "AND SA3.A3_COD NOT IN ('000032','000063') "
_cQuery += "ORDER BY SA3.A3_COD, SCK.CK_NUM "

TcQuery _cQuery New Alias "QR1"

QR1->(DbGoTop())

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
		// _aItens[x,11] = Status do or็amento
		// _aItens[x,12] = Data de efetiva็ใo		
//CORREวรO POR FAGNER /BIALE 04/08/2014
//		aAdd(_aItens,{QR1->CLIENTE,QR1->ORCAMENTO, QR1->PEDIDO, QR1->PRODUTO, QR1->QORC, QR1->UORC, QR1->TORC, QR1->QVEND, QR1->UVEND, QR1->TVEND, QR1->SITUACAO,QR1->EFETIVADO , })
//		aAdd(_aItens,{QR1->CLIENTE,QR1->ORCAMENTO, QR1->PEDIDO, QR1->PRODUTO, QR1->QORC, QR1->UORC, QR1->TORC, QR1->QVEND, QR1->UVEND, QR1->TVEND, QR1->STATUS  ,QR1->EFETIVADO , })
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

oProcess:= TWFProcess():New( "000028", "Folow-up semanal de or็amentos" )
oProcess:NewVersion(.T.)
oProcess:NewTask( "Folow-up semanal de or็amentos", "\WORKFLOW\ORC_SEM.HTM" )
oProcess:cSubject 	:= "Folow-up semanal de or็amentos "
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
		// _aItens[x,11] = Status do or็amento
		// _aItens[x,12] = Data de efetiva็ใo		
		
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
	aAdd( (oHtml:ValByName( "IT.STAT"           )), _aItens[_nY,11]                                                     )
	aAdd( (oHtml:ValByName( "IT.EFET"           )), _aItens[_nY,12]                                                     )         
Next _nY

oProcess:Start()	

Return
