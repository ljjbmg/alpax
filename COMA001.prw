
#Include "Topconn.ch"

User Function COMA001()

_cQuery := "SELECT DISTINCT C7_NUM, A2_NOME, C7_WF, C7_WFID "
_cQuery += "           FROM SC7010 C7, SA2010 A2 "
_cQuery += "           WHERE C7.D_E_L_E_T_ = ' ' AND A2.D_E_L_E_T_ = ' ' "
_cQuery += "                 AND C7_FILIAL = '" + xFilial("SC7") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' "
_cQuery += "                 AND C7_FORNECE = A2_COD AND C7_LOJA = A2_LOJA "
_cQuery += "                 AND C7_WF IN (' ','1') "

TcQuery _cQuery New Alias "QR1"

_aCampos := { 	{ "C7_NUM"	,"C",06,00	},;
				{ "A2_NOME" ,"C",60,00	},;
				{ "C7_WF"	,"C",01,00	},;
				{ "C7_WFID"	,"C",05,00	} }

_cArqTmp 	:= Criatrab(_aCampos,.t.)
_cArqInd	:= Criatrab(,.f.)

DbUseArea(.t.,,_cArqTmp,"TMP",.f.)

IndRegua("TMP",_cArqInd,"C7_NUM",,,"Criando Indice temporario....")

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	RecLock("TMP",.T.)
	TMP->C7_NUM 	:= QR1->C7_NUM
	TMP->A2_NOME	:= QR1->A2_NOME
	TMP->C7_WF		:= QR1->C7_WF
	TMP->C7_WFID	:= QR1->C7_WFID
	TMP->(MsUnLock())	
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

aRotina 	:= { 	{"Reenvio","U_Reenv01()",0,1},;
					{"Legenda","U_Legen01()",0,1} }

_aFields := { 	{"Pedido"				, 	"C7_NUM"		}	,;
				{"Fornecedor"			,	"A2_NOME"		}	}


aCores := 	{	{ " Empty(C7_WF)"	, 'BR_VERDE' 	}	,;
            	{ " C7_WF == '1'" 	, 'BR_AMARELO' 	}	}

mBrowse( 6,1,22,75,"TMP",_aFields,,,,,aCores)

TMP->(DbCloseArea())

Ferase(_cArqTmp+".DBF")
Ferase(_cArqInd+OrdBagExt())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReenv01   บAutor  ณMicrosiga           บ Data ณ  10/12/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Limpa os flags para reenvio do workflow.                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Reenv01()

If ! ApMsgYesNo("Confirma reenvio deste pedido ???","Confirmar")
	Return
EndIf

_cUpdate := "UPDATE " + RetSqlName("SC7")
_cUpdate += "       SET C7_WF = ' ', C7_WFID = ' ' "
_cUpdate += "       WHERE C7_FILIAL = '" + xFilial("SC7") + "' AND D_E_L_E_T_ = ' ' "
_cUpdate += "             AND C7_NUM = '" + TMP->C7_NUM + "' "

TcSqlExec(_cUpdate)

RecLock("TMP",.f.)
TMP->C7_WF 		:= ""
TMP->C7_WFID 	:= ""
TMP->(MsUnLock())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLegen01   บAutor  ณMicrosiga           บ Data ณ  10/12/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Legenda do browse                                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Legen01()

Local aCores
Local cCadastro

cCadastro := "Confirmacao dos Pedidos de compras"
aCores    := {	{ 'BR_VERDE'	, "Nao Enviado" 	}	,;
				{ 'BR_AMARELO'	, "Nao respondido"	}	}

BrwLegenda(cCadastro,"Legenda do Browse",aCores)

Return