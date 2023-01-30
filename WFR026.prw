/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR026    บAutor  ณOcimar Rolli        บ Data ณ  29/04/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para geracao do workflow de orcamentos emitidos no   บฑฑ
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


User Function WFR026_A()

U_WFR026({"01","01"})

Return

User Function WFR026(aParam)

Local _aItens := {}
Local _cNome	:= ""
Local _cEmail	:= ""

Private _cVend  := ""

WfPrepEnv(aParam[1],aParam[2])


_cQuery := "SELECT A3_NOME , A3_COD, CJ_NUM, A1_NOME, A3_EMAIL, SUM(CK_VALOR) AS VALOR "
_cQuery += "       FROM " + RetSqlName("SCJ") + " CJ "
_cQuery += "       INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "             ON CJ_CLIENTE = A1_COD "
_cQuery += "       INNER JOIN " + RetSqlName("SCK") + " CK "
_cQuery += "             ON CJ_NUM = CK_NUM "
_cQuery += "       INNER JOIN " + RetSqlName("SA3") + " A3 "
_cQuery += "             ON CJ_AXVEND = A3_COD "
_cQuery += "       WHERE CJ.D_E_L_E_T_ = ' ' "
_cQuery += "             AND DATEDIFF(DD,CJ_EMISSAO,GETDATE()) = 0 AND CJ_AXVEND <> '000032' "
_cQuery += "GROUP BY CJ_NUM, A1_NOME, A3_NOME, A3_COD, A3_EMAIL "
_cQuery += "ORDER BY A3_NOME "

TcQuery _cQuery New Alias "QR1"

Do While ! QR1->(Eof())            
	_cVend 	:= QR1->A3_COD
	_cNome	:= QR1->A3_NOME
	_cEmail	:= QR1->A3_EMAIL
	_aItens := {}
	Do While ! 	QR1->(Eof()) .And. 	_cVend == QR1->A3_COD  
		// _aItens[x,1] = Numero do Orcamento
		// _aItens[x,2] = Nome do Cliente
		// _aItens[x,3] = Valor do Orcamento
		aAdd(_aItens,{QR1->CJ_NUM, QR1->A1_NOME, QR1->VALOR})
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

oProcess:= TWFProcess():New( "000026", "Orcamentos emitidos no dia" )
oProcess:NewVersion(.T.)
oProcess:NewTask( "Orcamentos emitidos", "\WORKFLOW\ORCEMI.HTM" )
oProcess:cSubject 	:= "Orcamentos emitidos no dia " + Dtoc(dDataBase)
oProcess:cTo  		:= _cEmail
oProcess:cCC	    := "luciano.pereira@alpax.com.br"
oProcess:bReturn := ""
oHtml   := oProcess:oHTML
oHtml:ValByName( "EMISSAO"    	, DTOC(dDataBase)	)
oHtml:ValByName( "VEND"    		, _cNome			)
_lPrimeiro := .f.

// _aItens[x,1] = Numero do Orcamento
// _aItens[x,2] = Nome do Cliente
// _aItens[x,3] = Valor do Orcamento

For _nY := 1 To Len(_aItens)
	aAdd( (oHtml:ValByName( "IT.ORC"    		)), _aItens[_nY,01]		                             					)
	aAdd( (oHtml:ValByName( "IT.CLIENTE"   		)), _aItens[_nY,02]					                            		)
	aAdd( (oHtml:ValByName( "IT.VALOR"  		)), Transform(_aItens[_nY,03],"@E 999,999.99")							)
Next _nY                                                                                                                                     

oProcess:Start()	

Return
