#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTM012()

_cPerg := "ESTM12"
cCadastro := "Atualizacao do consumo mensal"
aSays	:= {}
aButtons:= {}
nOpca := 0
// criacao de perguntas.
fPergM03()

AADD(aSays,"Este programa ira atualizar o consumo mesnsal na SB3" )

AADD(aButtons, { 5,.T.,{|| Pergunte(_cPerg,.T. )}})
AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1
	If ApMsgYesNo("Confirma atualizacao de acordo com as perguntas do parametro")
		Processa({|| fAtualiza()})
	EndIf
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtualiza บAutor  ณAdriano Luis Brandaoบ Data ณ  02/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de atualizacao.                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtualiza()

Pergunte(_cPerg,.F. )

IF SELECT("QR1") <> 0
	DBSELECTAREA("QR1")
	DBCLOSEAREA()
ENDIF

cqry := "SELECT D2_COD AS CODIGO, SUBSTRING(D2_EMISSAO, 1, 6) AS ANOMES, SUM(D2_QUANT) AS CONSUMO "
cqry += "FROM "+RetSqlName("SD2")+" SD2 "
cqry += "WHERE  D_E_L_E_T_ = ' ' "
cqry += "AND SUBSTRING(D2_EMISSAO,1,6) BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
cqry += "GROUP BY D2_COD, SUBSTRING(D2_EMISSAO, 1, 6) "
cqry += "ORDER BY CODIGO, ANOMES "


MEMOWRIT("D:\A\SQL_EMIN.AQL",cqry)
TcQuery cqry New Alias "QR1"

TcSetField("QR1","CODIGO" ,"C",15,0)
TcSetField("QR1","CONSUMO","N",12,0)



SB3->(DbSetOrder(1))
// B3_FILIAL, B3_COD, R_E_C_N_O_, D_E_L_E_T_

ProcRegua(SB3->(Lastrec()))


Do While !QR1->(Eof())
	IncProc("Produto: " + QR1->CODIGO )
	dbselectarea("SB1")
	DBSETORDER(1)
	DBGOTOP()
	If SB3->(DbSeek(xFilial("SB3")+alltrim(QR1->CODIGO)))
		RecLock("SB3",.f.)
		Do Case
			Case SUBSTRING(QR1->ANOMES,5,2) == '01'
				SB3->B3_Q01 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '02'
				SB3->B3_Q02 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '03'
				SB3->B3_Q03 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '04'
				SB3->B3_Q04 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '05'
				SB3->B3_Q05 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '06'
				SB3->B3_Q06 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '07'
				SB3->B3_Q07 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '08'
				SB3->B3_Q08 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '09'
				SB3->B3_Q09 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '10'
				SB3->B3_Q10 := QR1->CONSUMO																																				
			Case SUBSTRING(QR1->ANOMES,5,2) == '11'
				SB3->B3_Q11 := QR1->CONSUMO
			Case SUBSTRING(QR1->ANOMES,5,2) == '12'
				SB3->B3_Q12 := QR1->CONSUMO								
		EndCase
		
		MsUnLock()
	EndIf
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfPergM03  บAutor  ณAdriano Luis Brandaoบ Data ณ  02/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Criacao das perguntas da rotina.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fPergM03()

PutSx1(_cPerg,"01","Data de (AAAAMM) " ,"Data de (AAAAMM) " ,"Data de (AAAAMM) " ,"mv_ch1","C",06,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Data ate (AAAAMM) ","Data ate (AAAAMM) ","Data ate (AAAAMM) ","mv_ch2","C",06,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",,,)

Return
