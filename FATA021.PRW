/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATA021   บAutor  ณOcimar              บ Data ณ  13/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para atualizacao do ultimo preco de compra,          บฑฑ
ฑฑบ          ณpreco de venda, preco minimo                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

#Include "Topconn.ch"                 '
#Include "Protheus.ch"

User Function FATA021()

Private cPerg     := "FATA21"
Private cCadastro := "Atualizacao Data de Validade da licenca da transportadora"
Private aSays	  :={}
Private aButtons  :={}
Private nOpca	  := 0

fCriaPerg()

Pergunte(cPerg,.T.)

	If Empty(MV_PAR01) .or. Empty(MV_PAR02) .or. Empty(MV_PAR03) .or. Empty(MV_PAR04) .or. Empty(MV_PAR05) .or. MV_PAR04 > MV_PAR05 
			ApMsgStop("Algum parametro esta em branco ou data inicial maior que final","Aviso")
		Else
		Processa({|| fAtualiza()})
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfatualiza บAutor  ณMicrosiga           บ Data ณ  13/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณfuncao de processamento e atualizacao dos precos.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtualiza()

Local _cQuery

SZU->(DbSetOrder(1))

_cQuery := "SELECT ZU_TRANSP AS TRANSP "
_cQuery += ",      ZU_NRLIC AS LICENCA "
_cQuery += ",      ZU_DTINI AS INICIO "
_cQuery += ",      ZU_DTFIM AS FIM "
_cQuery += ",      ZU_ORGAO AS ORGAO "
_cQuery += ",      ZU.R_E_C_N_O_ "
_cQuery += "FROM " + RetSqlName("SZU") + " ZU "
_cQuery += "       WHERE ZU_FILIAL = '" + xFilial("SZU") + "' "
_cQuery += "             AND ZU.D_E_L_E_T_ = ' ' "
_cQuery += "             AND ZU_TRANSP = '" + MV_PAR01 + "' "
_cQuery += "             AND ZU_ORGAO = '" + MV_PAR02 + "' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","TRANSP"	    ,"C",06,0)
TcSetField("QR1","LICENCA"  	,"C",15,0)
TcSetField("QR1","INICIO"	    ,"D",08,0)
TcSetField("QR1","FIM"	        ,"D",08,0)
TcSetField("QR1","ORGAO"      	,"C",03,0)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
		SZU->(DbGoTo(QR1->R_E_C_N_O_))
			RecLock("SZU",.f.) 
	   		SZU->ZU_NRLIC := MV_PAR03			
	   		SZU->ZU_DTINI := MV_PAR04
	   		SZU->ZU_DTFIM := MV_PAR05
		SZU->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaPerg บAutor  ณOcimar              บ Data ณ  13/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaPerg()

PutSx1(cPerg,"01","Transportadora"	  ,"Transportadora"   ,"Transportadora"   ,"mv_ch1","C",06,0,0,"G","","SA4","","","MV_PAR01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Orgao"      	      ,"Orgao"	          ,"Orgao"            ,"mv_ch2","C",03,0,0,"G","","SZR","","","MV_PAR02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Numero da licenca","Numero da licenca","Numero da licenca" ,"mv_ch3","C",15,0,0,"G","",""   ,"","","MV_PAR03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Data Inicial"     ,"Data Inicial"     ,"Data Inicial"      ,"mv_ch4","D",08,0,0,"G","",""   ,"","","MV_PAR04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Data Final"       ,"Data Final"       ,"Data Final"        ,"mv_ch5","D",08,0,0,"G","",""   ,"","","MV_PAR05","","","","","","","","","","","","","","","","",,,)

Return
