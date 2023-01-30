/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT440LIB  ºAutor  ³Adriano Luis Brandaoº Data ³  02/07/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para liberacao automatica, analisando a licenca do   º±±
±±º          ³cliente e transportadora nos orgaos de controlados.         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include "Protheus.ch"
#include "Topconn.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"


User Function MT440LIB()

Local _aArea	:= GetArea()
Local _aAreaC5	:= SC5->(GetArea())
Local _aAreaC6	:= SC6->(GetArea())
Local _nRet		:= Paramixb
Local _aRet1	:= {}
Local _aRet2	:= {}
Local _aItens 	:= {{SC6->C6_PRODUTO,_nRet}}

// Verifica se o novo filtro de transportadora atende, caso contrario rejeita o item de pedido.
SC5->(DbSetOrder(1))
SC5->(Dbseek(xFilial("SC5")+SC6->C6_NUM))
If SC5->C5_TRANSP < MV_PAR11 .Or. SC5->C5_TRANSP > MV_PAR12
	_nRet := 0
EndIf

If Empty(SC6->C6_XAUTORI) .And. _nRet > 0
	
	SC5->(DbSetOrder(1))
	SC5->(Dbseek(xFilial("SC5")+SC6->C6_NUM))
	
	// Checa as licencas do cliente por produto
	
	_aRet1	:= U_ESTV004("C",SC6->C6_CLI+SC6->C6_LOJA,_aItens)
	// Retorno
	// _aRet[1] = .t. ou .f. = se foi aprovado
	// _aRet[2] = Log da aprovacao
	
	
	// Checa as Licencas da transportadora por produto
	
	_aRet2	:= U_ESTV004("T",SC5->C5_TRANSP,_aItens)
	// Retorno
	// _aRet[1] = .t. ou .f. = se foi aprovado
	// _aRet[2] = Log da aprovacao
	
	// se foi reprovado por cliente ou por transportadora retorna 0 para bloquear item pedido ou total.
	// se pedido ja foi bloqueado anteriormente no automatico tambem entra para bloquear 
	// de acordo a variavel publica _xAlpaxPed
	If ! _aRet1[1] .Or. ! _aRet2[1] .Or. aScan(_xAlpaxPed,SC6->C6_NUM) > 0
		_nRet := 0
		// regrava 0 para todos os itens anteriores do mesmo pedido para nao liberar.
		// pois nos casos de liberacao total, so bloqueava do item bloqueado para baixo, os outros itens anteriores liberava.
		If SC5->C5_TIPLIB == "2" // Caso de Liberacao por pedido de vendas.
			_cPed := SC6->C6_FILIAL+SC6->C6_NUM
			// adiciona na variavel publica o pedido para bloquear novamente no proximo item o pedido.
			If aScan(_xAlpaxPed,SC6->C6_NUM) == 0
				aAdd(_xAlpaxPed,SC6->C6_NUM)
			EndIf
			_nRec := SC6->(Recno())
			SC6->(DbSetOrder(1))                                                                       
			SC6->(DbSeek(_cPed))
			Do While ! SC6->(Eof()) .And. SC6->C6_FILIAL+SC6->C6_NUM == _cPed
				RecLock("SC6",.f.)
				_cItem := SC6->C6_ITEM
				SC6->C6_QTDLIB := 0
				SC6->(MsUnLock())
				SC6->(DbSkip())
			EndDo
			
			SC6->(Dbgoto(_nRec))
		EndIf
		
		//fenviamail(_aRet1,_aRet2)
	EndIf
	
EndIf

RestArea(_aAreaC6)
RestArea(_aAreaC5)
RestArea(_aArea)

Return(_nRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT440LIB  ºAutor  ³Microsiga           º Data ³  10/08/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fenviamail(_aRet1,_aRet2)

Local _cMen := ""
local cServidor  	:= GetMV("MV_RELSERV")
local cConta     	:= GetMV("MV_RELACNT")
local cPassWord  	:= GetMV("MV_RELPSW")
local lConectou	 	:= .t.
local _cMail		:= "" // UsrRetMail(SC5->C5_AXATEN1)
Local _cNome		:= UsrRetName(SC5->C5_AXATEN1)

If _aRet1 <> Nil .And. _aRet2 <> Nil
	If Len(_aRet1) > 1
		_cMen := _aRet1[2] + CHR(13)+CHR(10)
		
	EndIf
	If Len(_aRet2) > 2
		_cMen += _aRet2[2] + CHR(13)+CHR(10)
	EndIf
EndIf

If ! Empty(_cMail)
	
	cEmailBody	:=	"<html>"
	cEmailBody	+=	"<head><title>Liberação automatica de pedido de vendas</title></head>
	cEmailBody	+=	"<body><br><br>"
	cEmailBody	+=	"<br>Prezado(a):"+alltrim(_cNome)+",<br>"
	cEmailBody	+=	"<br><br>O Pedido " + SC6->C6_NUM + " Item " + SC6->C6_ITEM + " nao foi liberado: <br>"
	cEmailBody	+=	_cMen
	cEmailBody	+=	"<br><br>Obrigado<br>"
	cEmailBody	+=	"<br><br><br>"
	cEmailBody	+=	"</body>"
	cEmailBody	+=	"</html>"
	
	
	CONNECT SMTP SERVER cServidor ACCOUNT cConta PASSWORD cPassWord Result lConectou
	If !lConectou
		ConOut("Erro SMTP")
		Return(Nil)
	EndIf
	
	lConectou := MailAuth(cConta, cPassWord)
	If !lConectou
		ConOut("Erro AUTH")
	EndIf
	cAssunto  := "Liberacao automatica Pedido " + SC6->C6_NUM + " Item " + SC6->C6_ITEM
	
	SEND MAIL From "Microsiga Protheus - Workflow" To _cMail SUBJECT cAssunto BODY cEmailBody RESULT lConectou
	
	If !lConectou
		ConOut("Erro SEND MAIL")
	EndIf
	DISCONNECT SMTP SERVER
EndIf

Return
