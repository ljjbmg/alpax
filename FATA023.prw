#Include "Topconn.ch"
#Include "Protheus.ch"
#INCLUDE "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfata023   บAutor  ณOcimar Rolli        บ Data ณ  31/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para recalcular as comissoes de acordo com a tabela บฑฑ
ฑฑบ          ณ de comissoes.                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FATA023()

cPerg     := "FATA23"

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
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fProcessa()

_cQuery := "SELECT F2_VEND1, D2_DOC, D2_PEDIDO, D2_COD, D2_PRCVEN, D2_TOTAL, D2_COMIS1, D2_EMISSAO, D2_CLIENTE, D2.R_E_C_N_O_ AS REG "
_cQuery += "FROM " + RetSqlName("SF2") + " F2 "
_cQuery += "INNER JOIN " + RetSqlName("SD2") + " D2 "
_cQuery += "ON F2_DOC = D2_DOC AND F2_SERIE = F2_SERIE AND F2_CLIENTE = D2_CLIENTE "
_cQuery += "INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "ON D2_TES = F4_CODIGO "
_cQuery += "WHERE D2.D_E_L_E_T_ = ' ' AND D2_FILIAL = '" + xFilial("SD2") +"' AND F4_FILIAL = '" + xFilial("SF4") + "' "
_cQuery += "      AND D2_DOC BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02+"' "
_cQuery += "      AND F2_VEND1 BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "      AND D2_EMISSAO BETWEEN '" + DtoS(MV_PAR05) + "' AND '" + DtoS(MV_PAR06) + "' "
_cQuery += "      AND F4_DUPLIC = 'S' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D2_PRCVEN"		,"N",12,2)
TcSetField("QR1","D2_TOTAL"     	,"N",12,2)
TcSetField("QR1","D2_COMIS1"     	,"N",02,2)
TcSetField("QR1","D2_EMISSAO"     	,"D",08,2)

Private nRet := 0

QR1->(DbGoTop())

// Rotina para inclusao da comissao nos itens da nota  --  Ocimar 30/08/2012

Do While ! QR1->(Eof())
	If ! SD2->(DbGoTo(QR1->REG))
		nRet := U_ALPG002( QR1->F2_VEND1, SD2->D2_COD, SD2->D2_PRCVEN, SD2->D2_TOTAL, SD2->D2_CLIENTE)
		RecLock("SD2",.f.)
		SD2->D2_COMIS1 := nRet
		SD2->(MsUnLock())
	EndIf
	nRet := 0
	QR1->(DbSkip())
	SD2->(DbSkip())
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

PutSx1(cPerg,"01","Nota Fiscal de " ,"Nota Fiscal de " ,"Nota Fiscal de " ,"mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Nota Fiscal ate ","Nota Fiscal ate ","Nota Fiscal ate ","mv_ch2","C",09,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Vendedor de "    ,"Vendedor de "    ,"Vendedor de "    ,"mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Vendedor ate "   ,"Vendedor ate "   ,"Vendedor ate "   ,"mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Emissao de "     ,"Emissao de "     ,"Emissao de "     ,"mv_ch5","D",08,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"06","Emissao ate "    ,"Emissao ate "    ,"Emissao ate "    ,"mv_ch6","D",08,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",,,)

Return
