/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR010    ºAutor  ³Microsiga           º Data ³  19/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Workflow de confirmacao de Pedido de compras com fornecedor º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include "rwmake.ch"
#include "Topconn.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"

User Function WFR010_1()

U_WFR010({"01","01"})

Return

User Function WFR010(aParam)


WfPrepENV( aParam[1], aParam[2])

CHKFILE("SM0")

DBSelectArea("SM0")
DBSetOrder(1)
DBSeek(aParam[1],.F.)

Conout("WFR010 Empresa " + aParam[1] )

Do While ! SM0->(EOF()) .AND. SM0->M0_CODIGO == aParam[1]
	cFilAnt	:= SM0->M0_CODFIL
	
	Conout("WFR010() Empresa " + aParam[1] + " Filial " +  cFilAnt)
	
	fWF010()
	SM0->(DBSkip())
EndDo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WF010     ºAutor  ³Microsiga           º Data ³  19/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de envio Pc.                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fWF010()

Private nDD   	:= GetNewPar("MV_WFTODD", 0)	// TimeOut - Dias
Private nHH    	:= GetNewPar("MV_WFTOHH", 0)    // TimeOut - Horas
Private nMM     := GetNewPar("MV_WFTOMM", 1)    // TimeOut - Minutos

_cQuery := "SELECT C7_NUM, C7_USER, C7_FORNECE, C7_LOJA, A2_NOME, A2_AXEMAIL, E4_DESCRI, C7_ITEM, C7_AXPART, "
_cQuery += "       RTRIM(C7_DESCRI)+RTRIM(B1_CAPACID) AS DESCRI, C7_UM, C7_QUANT, C7_PRECO, C7_TOTAL, C7_TOTAL+C7_VALIPI AS TOTAL, "
_cQuery += "       C7_IPI, C7_DATPRF, C7_AXTRANS, C7_AXFINAL "
_cQuery += "       FROM " + RetSqlName("SC7") + " C7, " + RetSqlName("SE4") + " E4, " + RetSqlName("SB1") + " B1, " + RetSqlName("SA2") + " A2 "
//_cQuery +=              RetSqlName("SA2") + " A2 "  ------ RETIRADO E COLOCADO NA LINHA SUPERIOR (OCIMAR 14/07/11)
_cQuery += "       WHERE C7.D_E_L_E_T_ = ' ' AND E4.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND A2.D_E_L_E_T_ = ' ' "
_cQuery += "             AND C7_FILIAL = '" + xFilial("SC7") + "' AND E4_FILIAL = '" + xFilial("SE4") + "' "
_cQuery += "             AND B1_FILIAL = '" + xFilial("SB1") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' "
_cQuery += "             AND C7_PRODUTO = B1_COD AND C7_COND = E4_CODIGO AND C7_FORNECE = A2_COD AND C7_LOJA = A2_LOJA "
_cQuery += "             AND C7_WF = ' ' AND C7_CONAPRO = 'L' "
_cQuery += "       ORDER BY C7_NUM, C7_ITEM "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","C7_QUANT"	,"N",12,2)
TcSetField("QR1","C7_PRECO"	,"N",12,5)
TcSetField("QR1","C7_TOTAL"	,"N",12,2)
TcSetField("QR1","TOTAL"	,"N",12,2)
TcSetField("QR1","C7_DATPRF","D",08,0)

QR1->(DbGoTop())
Do While ! QR1->(Eof())
	
	_cNumPed	:= QR1->C7_NUM
	
	_cTo		:= QR1->A2_AXEMAIL
	
	if Empty(_cTo)
		PcAssunto  	:= "Pedido de compras nao enviado a fornecedor " + QR1->A2_NOME
		PcTitulo	:= "Pedido de Compras Nr." + QR1->C7_NUM
		PcDetalhe	:= "O Pedido de compras Nr." + QR1->C7_NUM + " nao pode ser enviado para o fornecedor "
		PcDetalhe	+= Alltrim(QR1->A2_NOME) + " por falta de cadastro de e-mail. Tente enviar novamente e entre em contato "
		PcDetalhe	+= "com o fornecedor. "
		PcUsuario	:= QR1->C7_USER
		
		U_NOTIFICA(pcAssunto, pcTitulo, pcDetalhe, QR1->C7_USER)
		// Salta os registros ate o proximo pedido
		Do While ! QR1->(Eof()) .And. _cNumPed == QR1->C7_NUM
			QR1->(DbSkip())
		EndDo
		// Grava o Flag de enviado no pedido.
		_cUpdate := "UPDATE " + RetSqlName("SC7")
		_cUpdate += "       SET C7_WF = '1' "
		_cUpdate += "       WHERE C7_FILIAL = '" + xFilial("SC7") + "' AND D_E_L_E_T_ = ' ' AND C7_NUM = '" + _cNumPed + "' "
		
		TcSqlExec(_cUpdate)
		
		// retorna ao inicio
		Loop
	Endif
	//
	// Inicia um novo processo de envio
	//
	conout("Enviado pedido de compras " + QR1->C7_NUM)
	
	oProcess          	:= TWFProcess():New( "000001", "Envio Confirmacao PC :" + QR1->C7_NUM )
	oProcess          	:NewTask( "Envio Confirmacao PC : " + QR1->C7_NUM, "\WORKFLOW\PCCONFIRM.HTM" )
	oProcess:cSubject 	:= "Confirmacao Pedido de Compras " + QR1->C7_NUM
	
	//  DESENVOLVER ROTINA DE RETORNO E TIME-OUT
	
	oProcess:bReturn  	:= "U_WFR010R({'" + cEmpAnt + "','" + cFilAnt + "'})"
	oProcess:bTimeOut 	:= { { "U_WFR010T({'" + cEmpAnt + "','" + cFilAnt + "'})", nDD, nHH, nMM } }
	oProcess:cTo    	:= _cTo
	oProcess:NewVersion(.T.)
	
	oHtml     			:= oProcess:oHTML
	//
	// Atualiza HTML com as informacoes do pedido de compras.
	//
	_cTransp := iif(Empty(QR1->C7_AXTRANS)," ",Posicione("SA4",1,xFilial("SA4")+QR1->C7_AXTRANS,"A4_NREDUZ"))
	
	oHtml:ValByName( "PEDIDO"		, QR1->C7_NUM 				)
	oHtml:ValByName( "COMPR"		, UsrRetName(QR1->C7_USER) 	)
	oHtml:ValByName( "FORNECE"		, QR1->A2_NOME 				)
	oHtml:ValByName( "COND"			, QR1->E4_DESCRI			)
	oHtml:ValByName( "TRANSP"		, _cTransp					)
	
	_nTotal := 0
	Do While ! QR1->(Eof()) .And. _cNumPed == QR1->C7_NUM
		
		// FINALIDADE DO ITEM
		
		DbSelectArea("SX5")
		DbSetOrder(1)
		DbGoTop()
		
		if DbSeek(xfilial("SX5")+'LT',.T.)
			While SX5->(!EOF()) .and. SX5->X5_TABELA == 'LT'
				If ALLTRIM(SX5->X5_CHAVE) == alltrim(QR1->C7_AXFINAL)
					_cFinali := ALLTRIM(SX5->X5_DESCRI)
				EndIf
				SX5->(DbSkip())
			Enddo
		Endif
		
		SX5->(DbCloseArea())
		
		/*		SUBSTITUIDO PELA ACAO ACIMA OCIMAR 05/11/2013
		
		If QR1->C7_AXFINAL == 'R'
		_cFinali := 'REVENDA'
		Else
		If QR1->C7_AXFINAL == 'C'
		_cFinali := 'CONSUMO'
		Else
		_cFinali := 'INDUSTRIALIZACAO'
		EndIf
		EndIf
		*/
		// formatando os campos
		oHtml:oFieldDefs:Caption('IT.T9'	, "Data de Previsao de Entrega")
		oHtml:oFieldDefs:Required('IT.T9'	,.T.)
		oHtml:oFieldDefs:FieldType('IT.T9'	,"D")
		// atualizando HTML
		AAdd( (oHtml:ValByName( "IT.T1"    )), QR1->C7_ITEM									)		// Item do pedido
		AAdd( (oHtml:ValByName( "IT.T2"    )), QR1->C7_AXPART								)		// Codigo (Part number)
		AAdd( (oHtml:ValByName( "IT.T3"    )), QR1->DESCRI									)		// Descricao do produto
		AAdd( (oHtml:ValByName( "IT.T4"    )), QR1->C7_UM									)		// Unidade de Medida
		AAdd( (oHtml:ValByName( "IT.T5"    )), Transform(QR1->C7_QUANT,"@e 999,999,999.99")	)		// Quantidade
		AAdd( (oHtml:ValByName( "IT.T6"    )), Transform(QR1->C7_PRECO,"@e 999,999.99999")	)		// Valor Unitario
		AAdd( (oHtml:ValByName( "IT.T7"    )), Transform(QR1->C7_IPI,"@e 999,999,999.99")	)		// Percentual de IPI
		AAdd( (oHtml:ValByName( "IT.T8"    )), Transform(QR1->TOTAL,"@e 999,999,999.99")	)		// Valor Total com IPI
		AAdd( (oHtml:ValByName( "IT.T9"    )), QR1->C7_DATPRF								)		// Prazo de entrega
		AAdd( (oHtml:ValByName( "IT.T10"   )), _cFinali     								)		// Uso do produto
		// variavel totalizadora.
		_nTotal += QR1->TOTAL
		QR1->(DbSkip())
		
	EndDo
	oHtml:ValByName( "TOTAL"		, Transform(_nTotal,"@e 999,999,999.99") )
	oProcess:nEncodeMime := 0
	_cNrId 	:= oProcess:fProcessId
	aAdd( oProcess:aParams, xFilial("SC7"))
	aAdd( oProcess:aParams, _cNumPed)
	oProcess:Start()
	
	// Grava o Flag de enviado no pedido e o numero Id do workflow.
	SC7->(DbSetOrder(1))
	If SC7->(DbSeek(xFilial("SC7")+_cNumPed))
		Do While ! SC7->(Eof()) .And. SC7->C7_NUM == _cNumPed
			RecLock("SC7",.f.)
			SC7->C7_WF := "1"
			SC7->C7_WFID := _cNrId
			SC7->(MsUnlock())
			SC7->(DbSkip())
		EndDo
	EndIf
	
	/*   - update antigo.
	_cUpdate := "UPDATE " + RetSqlName("SC7")
	_cUpdate += "       SET C7_WF = '1', C7_WFID = '" + _cNrId + "' "
	_cUpdate += "       WHERE C7_FILIAL = '" + xFilial("SC7") + "' AND D_E_L_E_T_ = ' ' AND C7_NUM = '" + _cNumPed + "' "
	TcSqlExec(_cUpdate)
	*/
	
EndDo

QR1->(DbCloseArea())
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR010R   ºAutor  ³Microsiga           º Data ³  19/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processa o retorno do fornecedor.                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WFR010R(aParams, oProcess)


WfPrepEnv( aParams[1], aParams[2] )

ChkFile("SC7")

cFilAnt      := oProcess:aParams[1]
//_cNumero     := oProcess:oHtml:RetByName("PEDIDO"     )

ConOut("----------- Processando retorno do pedido de compras fornecedor "	)
ConOut(" Filial     " + oProcess:aParams[01]      	)
ConOut(" Pedido     " + oProcess:aParams[02]     	)

_cPedido := (oProcess:aParams[01])+(oProcess:aParams[02])

SC7->(DbSetOrder(1))

For _nY := 1 To Len(oProcess:oHtml:RetByName("IT.T1"))
	_cItem	:= oProcess:oHtml:RetByName("IT.T1")[_nY]
	If SC7->(DbSeek(_cPedido+_cItem))
		RecLock("SC7",.f.)
		SC7->C7_WF		:= "2"
		SC7->(MsUnLock())
		Conout("Gravando o item " + _cItem)
	EndIf
Next

Conout("Fim do retorno do Pedido " + _cPedido)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR010T   ºAutor  ³Microsiga           º Data ³  19/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processa o Time-out do envio ao fornecedor, caso nao       º±±
±±º          ³ obteve uma resposta no prazo.                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function WFR010T(aParams, oProcess)

WfPrepEnv( aParams[1], aParams[2] )

ChkFile("SC7")
CHKFILE("SA2")

cFilAnt      := oProcess:aParams[1]

_cPedido 	:= oProcess:aParams[02]
_cPedFil	:= (oProcess:aParams[01])+(oProcess:aParams[02])

SC7->(DbSetOrder(1))

SC7->(DbSeek(_cPedfil,.t.))
SA2->(DbSeek(xFilial("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA))

PcAssunto  	:= "Fornecedor nao confirmou Pedido de compras nr." + SC7->C7_NUM + " !!! "

PcTitulo	:= "Pedido de Compras Nr." + SC7->C7_NUM + " nao respondido pelo fornecedor "

PcDetalhe	:= "Favor entrar em contato com o fornecedor " + Alltrim(SA2->A2_NOME)
PcDetalhe	+= " para saber o motivo."

PcUsuario	:= SC7->C7_USER

U_NOTIFICA(pcAssunto, pcTitulo, pcDetalhe, PcUsuario)

// Inserido para que a luci possa receber tambem este e-mail 08/04/06 - Ocimar
//PcUsuario	:= "luci@alpax.com.br"
//U_NOTIFICA(pcAssunto, pcTitulo, pcDetalhe, PcUsuario)

Return
