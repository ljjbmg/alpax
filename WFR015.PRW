
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR015    บAutor  ณMicrosiga           บ Data ณ  08/19/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณworkflow orcamentos a vencer ISO/RBC                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

#Include "rwmake.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#Include "Topconn.ch"

User Function WFR015()

WfPrepEnv("01","01")

CHKFILE("SCK")
CHKFILE("SCJ")
CHKFILE("SB1")
CHKFILE("SA1") 

Private _aArea     	:= GetArea()
Private _cEmail   	:= ""
Private _cCC		:= ""
Private _aDetalhe	:= {}

_cDataIni := Dtos(dDataBase)
_cDataFim := Dtos(dDataBase+2)

_cQuery := "SELECT CK_NUM, CK_ITEM, A1_NOME, CK_DESCRI, CJ_VALIDA, Z7_USUARIO
_cQuery += "FROM " + RetSqlName("SCJ") + " SCJ "
_cQuery += "INNER JOIN " + RetSqlName("SA1") + " SA1 "
_cQuery += "ON CJ_CLIENTE = A1_COD AND CJ_LOJA = A1_LOJA "
_cQuery += "INNER JOIN " + RetSqlName("SCK") + " SCK "
_cQuery += "ON CJ_NUM = CK_NUM "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " SB1 "
_cQuery += "ON CK_PRODUTO = B1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SZ7") + " SZ7 "
_cQuery += "ON CJ_AXATEND = Z7_CODUSR "
_cQuery += "WHERE SCJ.D_E_L_E_T_ <> '*' AND SA1.D_E_L_E_T_ <> '*' AND SCK.D_E_L_E_T_ <> '*' AND  "
_cQuery += "      SB1.D_E_L_E_T_ <> '*' AND "
_cQuery += "      CJ_VALIDA <= '" + _cDataFim + "' AND CJ_STATUS = 'A' AND "
_cQuery += "      CK_AXCALIB = 'S' AND CK_DESCRI NOT LIKE '%SERVICO%' "
_cQuery += "ORDER BY CK_NUM, CJ_VALIDA  "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","CJ_VALIDA","D",8,0)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	// _aDetalhe[x,1] = Numero orcamento/Item
	// _aDetalhe[x,2] = Nome do cliente
	// _aDetalhe[x,3] = Produto
	// _aDetalhe[x,4] = Vencimento
	//                                                                              
	aAdd(_aDetalhe,{QR1->CK_NUM+"/"+QR1->CK_ITEM, QR1->A1_NOME, QR1->CK_DESCRI, Dtoc(QR1->CJ_VALIDA), QR1->Z7_USUARIO})
	QR1->(DbSkip())
EndDo

If Len(_aDetalhe) > 0
	_fGeraEnv()
EndIf

QR1->(DbCloseArea())

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGeraEnv บAutor  ณAdriano Luis Brandaoบ Data ณ  04/06/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para envio de e-mail                                 บฑฑ
ฑฑบ          ณOrcamento a vencer Mat.Calibrado                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fGeraEnv()	

Local _cTransp := ""

_cEmail += "luci@alpax.com.br" 


oProcess := TWFProcess():New( "000012", "Orcamento a vencer Mat.Calibrado - Alpax" )

// Cria-se uma nova tarefa para o processo.
oProcess:NewTask( "Orcamento", "\WORKFLOW\ORCAVENC_ISORBC.HTM" )
oProcess:cSubject := "Orcamentos a Vencer Material Calibrado - Alpax"
oProcess:cTo  := _cEmail
oProcess:cCC  := _cCC
oProcess:cBCC := ""
oProcess:bReturn := ""

// Faz uso do objeto ohtml que pertence ao processo
oHtml := oProcess :oHtml

For _nY := 1 to Len(_aDetalhe)
	AAdd( (oHtml:ValByName( "IT.ORC"		))	,_aDetalhe[_nY,1])
	AAdd( (oHtml:ValByName( "IT.CLIENTE" 	))	,_aDetalhe[_nY,2])	
	AAdd( (oHtml:ValByName( "IT.PRODUTO"	))	,_aDetalhe[_nY,3])		
	AAdd( (oHtml:ValByName( "IT.VENCIM"		))	,_aDetalhe[_nY,4])
	AAdd( (oHtml:ValByName( "IT.ATEND"		))	,_aDetalhe[_nY,5])			
Next _nY

oProcess:Start()

Return
