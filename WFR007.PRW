/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR007    ºAutor  ³Microsiga           º Data ³  10/06/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Workflow de pedido de vendas vencidos para atendentes e     º±±
±±º          ³depois para vendedores.                                     º±±
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

User Function WFR007_A()

U_WFR007({"01","01"})

RETURN


User Function WFR007(aParam)

WfPrepEnv(aParam[1],aParam[2])

CHKFILE("SC6")
CHKFILE("SC5")
CHKFILE("SB1")
CHKFILE("SA1")
//
// Envia e-mail para atendente.
//
_cQuery := "SELECT C5_AXATEN1, C6_NUM, B1_DESC, B1_CAPACID, B1_MARCA, A1_NREDUZ, (C6_QTDVEN-C6_QTDENT) QUANT, "
_cQuery += "       C6_ENTREG "
_cQuery += "FROM " + RetSqlName("SC6") + " C6, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA1") + " A1, "
_cQuery +=           RetSqlName("SC5") + " C5 "
_cQuery += "WHERE C5.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      C5_FILIAL = '" + xFilial("SC5") + "' AND C6_FILIAL = '" + xFilial("SC6") + "' AND "
_cQuery += "      B1_FILIAL = '" + xFilial("SB1") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' AND "
_cQuery += "      C5_NUM = C6_NUM AND C5_CLIENTE = A1_COD AND C5_LOJACLI = A1_LOJA AND C6_PRODUTO = B1_COD AND "
_cQuery += "      C6_QTDVEN > C6_QTDENT AND C6_ENTREG < '" + Dtos(dDataBase) + "' AND "  
_cQuery += "      C6_BLQ <> 'R' "
_cQuery += "ORDER BY C5_AXATEN1, A1_NREDUZ, C6_NUM "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"
TcSetField("QR1","QUANT"	,"N",12	,2)
TcSetField("QR1","C6_ENTREG","D",08	,0)

fEnvia(1)   // 1 = Atendente  / 2 = Vendedor

QR1->(DbCloseArea())           
//
// Envia e-mail para vendedor.
//
_cQuery := "SELECT C5_AXATEN1, C6_NUM, B1_DESC, B1_CAPACID, B1_MARCA, A1_NREDUZ, (C6_QTDVEN-C6_QTDENT) QUANT, "
_cQuery += "       C6_ENTREG, C5_VEND1, A3_EMAIL, A3_NOME "
_cQuery += "FROM " + RetSqlName("SC6") + " C6, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA1") + " A1, "
_cQuery +=           RetSqlName("SC5") + " C5, " + RetSqlName("SA3") + " A3 "
_cQuery += "WHERE C5.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND "
_cQuery += "      A3.D_E_L_E_T_ = ' ' AND "
_cQuery += "      C5_FILIAL = '" + xFilial("SC5") + "' AND C6_FILIAL = '" + xFilial("SC6") + "' AND "
_cQuery += "      B1_FILIAL = '" + xFilial("SB1") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' AND "
_cQuery += "      A3_FILIAL = '" + xFilial("SA3") + "' AND "
_cQuery += "      C5_NUM = C6_NUM AND C5_CLIENTE = A1_COD AND C5_LOJACLI = A1_LOJA AND C6_PRODUTO = B1_COD AND "
_cQuery += "      C5_VEND1 = A3_COD AND "
_cQuery += "      C6_QTDVEN > C6_QTDENT AND C6_ENTREG < '" + Dtos(dDataBase) + "' AND "  
_cQuery += "      C6_BLQ <> 'R'"
_cQuery += "ORDER BY C5_VEND1, A1_NREDUZ, C6_NUM "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"
TcSetField("QR1","QUANT"	,"N",12	,2)
TcSetField("QR1","C6_ENTREG","D",08	,0)

fEnvia(2)   // 1 = Atendente  / 2 = Vendedor

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fEnvia    ºAutor  ³Adriano Luis Brandaoº Data ³  06/04/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de envio de email.                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fEnvia(_nTipo)

Local _cNome := ""

QR1->(DbGoTop())
                         
_cTipo := iif(_nTipo==1,"Atendente ","Vendedor ")

Do While ! QR1->(Eof())
	If _nTipo == 1
		_cAtend	:= QR1->C5_AXATEN1
		_cEmail := Alltrim(UsrRetMail(QR1->C5_AXATEN1))
		_cNome	:= UsrRetName(QR1->C5_AXATEN1)
		_cVar	:= "C5_AXATEN1"
		
	Else
		_cAtend	:= QR1->C5_VEND1
		_cEmail := QR1->A3_EMAIL
		_cNome	:= QR1->A3_NOME
		_cVar	:= "C5_VEND1"
	EndIf
		
	_cMail		:= _cEmail
	_cMailCC    := ""
	oProcess:= TWFProcess():New( "000002", "Pedido de Vendas vencidos por " + _cTipo)
	oProcess:NewVersion(.T.)
	oProcess:NewTask( "Pedidos a Vencer", "\WORKFLOW\PEDVENC.HTM" )
	oProcess:cSubject := "Pedidos de Vendas vencidos do " + _cTipo + _cNome
	oProcess:cTo  := _cMail
	oProcess:cCC  := "luciano.pereira@alpax.com.br"
	oProcess:cBCC := ""
	oProcess:bReturn := ""
	
	oHtml   := oProcess:oHTML
	
	oHtml:ValByName( "EMISSAO"    	, DTOC(dDataBase)  	)    
	oHtml:ValByName( "TIPO"    		, _cTipo			)	
	oHtml:ValByName( "ATEND"    	, _cNome			) 

	// todos os itens do mesmo atendente ou vendedor.

	Do While ! QR1->(Eof()) .And. _cAtend == QR1->&(_cVar)
		_cProduto	:= Alltrim(QR1->B1_DESC) + "-" + Alltrim(QR1->B1_CAPACID) + "-" + Alltrim(QR1->B1_MARCA)
		aAdd( (oHtml:ValByName( "IT.PED"    	)), QR1->C6_NUM    							)
		aAdd( (oHtml:ValByName( "IT.PRODUTO"    )), _cProduto								)
		aAdd( (oHtml:ValByName( "IT.CLIENTE"    )), QR1->A1_NREDUZ  						)
		aAdd( (oHtml:ValByName( "IT.QTDE"    	)), Transform(QR1->QUANT,"@e 999,999.99")	)
		aAdd( (oHtml:ValByName( "IT.ENTR"    	)), DTOC(QR1->C6_ENTREG)    				)
		
		QR1->(DbSkip())
	EndDo
	oProcess:Start()	
EndDo

Return
