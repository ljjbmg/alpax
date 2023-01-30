#Include "Topconn.ch"
#Include "Protheus.ch"
#INCLUDE "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATA029   บAutor  ณOcimar Rolli        บ Data ณ  04/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para recalcular as comissoes de acordo com a tabela บฑฑ
ฑฑบ          ณ de comissoes e gravar no or็amento.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FATA029()

cPerg     := "FATA29"

//
// Criacao das perguntas a serem utilizadas no relatorio.
//

_fCriaSx1()

Pergunte(cPerg,.t.)

// verifica se pode ser alterado as comissoes.

If ! __cUserId $ "000016/000001/000045"
	ApMsgStop("Voce nao tem acesso para alterar as comissoes....")
	Return
Else
	Processa({|| fProcessa()})
endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfProcessa บAutor  ณOcimar Rolli        บ Data ณ  09/02/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de gravacao do vendedor no cabecalho do pedido de   บฑฑ
ฑฑบ          ณ vendas.                                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fProcessa()

_cQuery := "SELECT CJ_AXVEND, CJ_NUM, CK_PRODUTO, CK_PRCVEN, CK_VALOR, CK_COMIS1, CJ_EMISSAO, CK_CLIENTE, CK.R_E_C_N_O_ AS REG "
_cQuery += "FROM " + RetSqlName("SCK") + " CK "
_cQuery += "INNER JOIN " + RetSqlName("SCJ") + " CJ "
_cQuery += "ON CJ_NUM = CK_NUM "
_cQuery += "WHERE CJ.D_E_L_E_T_ = ' ' AND CJ_FILIAL = '" + xFilial("SCJ") +"' AND CK_FILIAL = '" + xFilial("SCK") + "' " 
_cQuery += "      AND CJ_NUM BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02+"' "
_cQuery += "      AND CJ_AXVEND BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "      AND CJ_EMISSAO BETWEEN '" + DtoS(MV_PAR05) + "' AND '" + DtoS(MV_PAR06) + "' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","CK_PRCVEN"		,"N",12,2)
TcSetField("QR1","CK_VALOR"     	,"N",12,2)
TcSetField("QR1","CK_COMIS1"     	,"N",02,2)
TcSetField("QR1","CJ_EMISSAO"     	,"D",08,2)

Private nRet := 0

QR1->(DbGoTop())

// Rotina para inclusao da comissao nos itens do pedido  --  Ocimar 30/08/2012

Do While ! QR1->(Eof())
	If ! SCK->(DbGoTo(QR1->REG))
		nRet := U_ALPG002( QR1->CJ_AXVEND, SCK->CK_PRODUTO, SCK->CK_PRCVEN, SCK->CK_VALOR, SCK->CK_CLIENTE)
		RecLock("SCK",.f.)
		SCK->CK_COMIS1 := nRet
		SCK->(MsUnLock())
	EndIf
	nRet := 0
	QR1->(DbSkip())
	SCK->(DbSkip())
EndDo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณAdriano Luis Brandaoบ Data ณ  25/06/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas do relatorio.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fCriaSx1()

PutSx1(cPerg,"01","Orcamento de  "  ,"Orcamento de  "  ,"Orcamento de  "  ,"mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Orcamento ate "  ,"Orcamento ate "  ,"Orcamento ate "  ,"mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Vendedor de "    ,"Vendedor de "    ,"Vendedor de "    ,"mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Vendedor ate "   ,"Vendedor ate "   ,"Vendedor ate "   ,"mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Emissao de "     ,"Emissao de "     ,"Emissao de "     ,"mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"06","Emissao ate "    ,"Emissao ate "    ,"Emissao ate "    ,"mv_ch6","D",08,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",,,)

Return
