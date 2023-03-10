/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?WFR001    ?Autor  ?Adriano Luis Brandao? Data ?  04/06/04   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ?Funcao para utilizar no workflow para envio de email de     ???
???          ?aviso de orcamentos a vencer ate 2 dias.                    ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP  - ALPAX                                                ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/

#include "Rwmake.ch"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "tbiConn.ch"
#INCLUDE "TOPCONN.CH"

User Function WFR001(aParam)

//Prepare Environment Empresa '01' Filial '01' Tables 'SA3','SCJ','SA1'
WFPREPENV(aParam[01],aParam[02])

CHKFILE("SA3")
CHKFILE("SCJ")
CHKFILE("SA1")

Private _aArea     	:= GetArea()
Private _aAreaA3	:= SA3->(GetArea())
Private _cEmail   	:= ""
Private _cCC		:= ""
Private _aDetalhe	:= {}

_cDataIni := Dtos(dDataBase)
_cDataFim := Dtos(dDataBase+2)


//
//  Envia e-mail para Vendedores
//

_cQuery := "SELECT CJ_NUM, A1_NOME, CJ_VALIDA, CJ_AXATEND, A3_COD, A3_EMAIL, A3_NOME "
_cQuery += "FROM " + RetSqlName("SCJ") + " CJ, " + RetSqlName("SA1")+ " A1, " + RetSqlName("SA3") + " A3 "
_cQuery += "WHERE CJ.D_E_L_E_T_ <> '*' AND A1.D_E_L_E_T_ <> '*' AND A3.D_E_L_E_T_ <> '*' AND "
_cQuery += "      CJ_FILIAL = '" + xFilial("SCJ") + "' AND A1_FILIAL = '" + xFilial("SA1")+ "' AND "
_cQuery += "      A3_FILIAL = '" + xFilial("SA3") + "' AND "
_cQuery += "      CJ_CLIENTE = A1_COD AND CJ_LOJA = A1_LOJA AND CJ_AXVEND = A3_COD AND "
_cQuery += "      CJ_VALIDA BETWEEN '" + _cDataIni + "' AND '" + _cDataFim + "' AND CJ_STATUS = 'A' "
_cQuery += "ORDER BY A3_COD, A1_NOME, CJ_VALIDA "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","CJ_VALIDA","D",8,0)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	_cVend 		:= QR1->A3_COD
	_cEmail 	:= ""
	_cCC		:= "luciano.pereira@alpax.com.br"
	_aDetalhe	:= {}
	// _aDetalhe[x,1] = Numero orcamento
	// _aDetalhe[x,2] = Nome do cliente
	// _aDetalhe[x,3] = Data de validade do orcamento
	// _aDetalhe[x,4] = Codigo do vendedor
	//
	Do While ! QR1->(Eof()) .And. QR1->A3_COD == _cVend                       
	    _cEmail := Alltrim(QR1->A3_EMAIL)
	    _cNome	:= Alltrim(QR1->A3_NOME)
	    If ! Empty(_cEmail)
		    aAdd(_aDetalhe,{QR1->CJ_NUM, QR1->A1_NOME, Dtoc(QR1->CJ_VALIDA)})
		Endif
		QR1->(DbSkip())
	EndDo
	If Len(_aDetalhe) > 0
		_fGeraEnv(_cEmail,_cNome)	
	EndIf

EndDo

QR1->(DbCloseArea())          


//
//  Envia e-mail para atendentes
//
_cQuery := "SELECT CJ_NUM, A1_NOME, CJ_VALIDA, CJ_AXATEND "
_cQuery += "FROM " + RetSqlName("SCJ") + " CJ, " + RetSqlName("SA1")+ " A1 " 
_cQuery += "WHERE CJ.D_E_L_E_T_ <> '*' AND A1.D_E_L_E_T_ <> '*' AND "
_cQuery += "      CJ_FILIAL = '" + xFilial("SCJ") + "' AND A1_FILIAL = '" + xFilial("SA1")+ "' AND "
_cQuery += "      CJ_CLIENTE = A1_COD AND CJ_LOJA = A1_LOJA AND "
_cQuery += "      CJ_VALIDA BETWEEN '" + _cDataIni + "' AND '" + _cDataFim + "' AND CJ_STATUS = 'A' "
_cQuery += "ORDER BY CJ_AXATEND, A1_NOME, CJ_VALIDA "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","CJ_VALIDA","D",8,0)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	_cVend 		:= QR1->CJ_AXATEND
	_cEmail 	:= ""
	_cCC		:= ""
	_aDetalhe	:= {}
	// _aDetalhe[x,1] = Numero orcamento
	// _aDetalhe[x,2] = Nome do cliente
	// _aDetalhe[x,3] = Data de validade do orcamento
	// _aDetalhe[x,4] = Codigo do vendedor
	//
	Do While ! QR1->(Eof()) .And. QR1->CJ_AXATEND == _cVend                       
	    _cEmail := UsrRetMail(QR1->CJ_AXATEND)
	    _cNome	:= UsrRetName(QR1->CJ_AXATEND)
	    If ! Empty(_cEmail)
		    aAdd(_aDetalhe,{QR1->CJ_NUM, QR1->A1_NOME, Dtoc(QR1->CJ_VALIDA)})
		Endif
		QR1->(DbSkip())
	EndDo
	If Len(_aDetalhe) > 0
		_fGeraEnv(_cEmail,_cNome)	
	EndIf
EndDo

QR1->(DbCloseArea())
RestArea(_aAreaA3)
RestArea(_aArea)

Return(.T.)

/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?_fGeraEnv ?Autor  ?Adriano Luis Brandao? Data ?  04/06/04   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ?Funcao para envio de e-mail                                 ???
???          ?                                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP - ALPAX                                                 ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/

Static Function _fGeraEnv(_cMail,_cNome)	

Local _cTransp := ""

oProcess := TWFProcess():New( "00001", "Orcamento a vencer - Alpax" )

// Cria-se uma nova tarefa para o processo.
oProcess:NewTask( "Orcamento", "\WORKFLOW\ORCAVENC.HTM" )
oProcess:cSubject := "Orcamentos a Vencer - Alpax"
oProcess:cTo  := _cMail
oProcess:cCC  := "luci@alpax.com.br;luciano.pereira@alpax.com.br"
oProcess:cBCC := ""
oProcess:bReturn := ""

// Faz uso do objeto ohtml que pertence ao processo
oHtml := oProcess :oHtml

oHtml:ValByName("VEND",_cNome)

For _nY := 1 to Len(_aDetalhe)
	AAdd( (oHtml:ValByName( "IT.ORC"		))	,_aDetalhe[_nY,1])
	AAdd( (oHtml:ValByName( "IT.CLIENTE" 	))	,_aDetalhe[_nY,2])	
	AAdd( (oHtml:ValByName( "IT.VENCIM"	))	,_aDetalhe[_nY,3])	
Next _nY

oProcess:Start()

Return
