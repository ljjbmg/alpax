#Include "TopConn.ch"
#Include "Protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM004   บAutor  ณAdriano Luis Brandaoบ Data ณ  07/07/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para atualizar os grupos de produtos de acordo com  บฑฑ
ฑฑบ          ณ o numero de itens vendidos no periodo selecionado.         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
giro
*/

User Function ESTM004()

_cPerg := "ESTM04"
cCadastro := "Atualizacao do grupo de produtos."
aSays	:= {}
aButtons:= {}
nOpca := 0

// criacao de perguntas.
fPergM004()
pergunte(_cPerg,.f.)

AADD(aSays,"Este programa ira alterar o grupo de produtos para 0020," )
AADD(aSays,"Caso o numero de movimentos for menor que do parametro nr.ocorrencias." )

AADD(aButtons, { 5,.T.,{|| Pergunte(_cPerg,.T. )}})
AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1
	If ApMsgYesNo("Confirma atualizacao de acordo com as perguntas do parametro")
		Processa({|| fAtualiza()})
		ApMsgInfo("Termino do processamento !!!","TERMINO")
	EndIf
EndIf



return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtualiza บAutor  ณAdriano Luis Brandaoบ Data ณ  07/07/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de processamento da rotina.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtualiza()

// ZERA GRUPO 0020(MATERIAL SEM GIRO) E O  SALDO MINIMO(PONTO PEDIDO)
if TCSQLEXEC("UPDATE "+RETSQLNAME("SB1")+" SET B1_GRUPO = '0020', B1_EMIN = 0, B1_PE = 0 WHERE B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' AND B1_MARCA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' ") < 0
	Msgalert("Falha no Update:  "+"UPDATE "+RETSQLNAME("SB1")+" SET B1_GRUPO = '0020', B1_EMIN = 0 ")
	return
endif

// Altera os produtos que nao se enquadram no codigo 0020 que deveriam ter ocorrencia menor que o parametro MV_PAR05
_cQuery := "SELECT D2_COD, COUNT(*) AS TOTAL "
_cQuery += "FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "    INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "          ON B1_FILIAL = '" + xFilial("SB1") + "' AND D2_COD = B1_COD "
_cQuery += "WHERE D2_FILIAL = '" + xFilial("SD2") + "' "
_cQuery += "      AND D2_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "      AND D2_EMISSAO BETWEEN '" + DTOS(MV_PAR06) + "' AND '" + DTOS(MV_PAR07) + "' AND D2.D_E_L_E_T_ = ' ' "
_cQuery += "      AND B1_MARCA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "      AND B1_GRUPO = '0020' "
_cQuery += "GROUP BY D2_COD "
_cQuery += "HAVING COUNT(*) > " + Str(MV_PAR05,05)
TcQuery _cQuery New Alias "QR2"

TcSetField("QR2","TOTAL","N",05,00)

SB1->(DbSetOrder(1))
While !QR2->(Eof())
	dbselectarea("SB1")
	DBSETORDER(1)
	if DbSeek(xFilial("SB1")+alltrim(QR2->D2_COD))
		RecLock("SB1",.f.)
		
		SB1->B1_GRUPO = ' '
		SB1->(MsUnLock())
		commit
	endif
	QR2->(DbSkip())
EndDo

QR2->(DbCloseArea())


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtualiza บAutor  ณAdriano Luis Brandaoบ Data ณ  07/07/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de processamento da rotina.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ                

ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fPergM004()

PutSx1(_cPerg,"01","Produto de"     ,"Produto de"     ,"Produto de"     ,"mv_ch1","C",15,0,0,"G","","SB1","","","MV_PAR01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Produto Ate"    ,"Produto ate"    ,"Produto ate"    ,"mv_ch2","C",15,0,0,"G","","SB1","","","MV_PAR02","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"03","Marca de"       ,"Marca de"       ,"Marca de"       ,"mv_ch3","C",15,0,0,"G","","SZ2","","","MV_PAR03","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"04","Marca ate"      ,"Marca ate"      ,"Marca ate"      ,"mv_ch4","C",15,0,0,"G","","SZ2","","","MV_PAR04","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"05","Ocorrencias"    ,"Ocorrencias"    ,"Ocorrencias"    ,"mv_ch5","N",05,0,0,"G","",""   ,"","","MV_PAR05","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"06","Emissao de"     ,"Emissao de "    ,"Emissao de "    ,"mv_ch6","D",08,0,0,"G","",""   ,"","","MV_PAR06","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"07","Emissao ate"    ,"Emissao ate"    ,"Emissao ate"    ,"mv_ch7","D",08,0,0,"G","",""   ,"","","MV_PAR07","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"08","Estoque para "  ,"Estoque para "  ,"Estoque para "  ,"mv_ch8","N",03,0,0,"G","",""   ,"","","MV_PAR08","","","","","","","","","","","","","","","","",,,)

Return
