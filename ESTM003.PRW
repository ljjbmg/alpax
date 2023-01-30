#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTM003()

cCadastro := "Atualizacao prazo medio de entrega v2"
aSays	:= {}
aButtons:= {}
nOpca := 0

AADD(aSays,"Este programa ira atualizar o prazo medio de entrega" )
AADD(aSays,"chamando em conjunto U_ESTM004" )
AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )

Processa({|| fAtualiza()})

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


U_ESTM004()

//=== ZERA B1_EMIN JA FEITO EM ESTM04
//=== RODA QUERY DE MEDIA
//=== ATU B1_EMIN
//=== SE B1_COD == '031083201273BVC' JOGA 180(6 MESES) DIRETO

nDias := (MV_PAR07 - MV_PAR06)
cMes  := DTOS((DATE() - nDias))

IF SELECT("QR1") <> 0
	DBSELECTAREA("QR1")
	DBCLOSEAREA()
ENDIF


cqry := "   SELECT D2_COD, ROUND(SUM(D2_QUANT),0) QTD_VEN "
cqry += "   FROM  "+retsqlname("SD2")+" SD2 (NOLOCK) "
cqry += "   LEFT JOIN "+RETSQLNAME("SF4")+" SF4 (NOLOCK) ON SF4.D_E_L_E_T_ = '' AND SF4.F4_CODIGO = SD2.D2_TES "
cqry += "   LEFT JOIN "+RETSQLNAME("SB1")+" SB1 (NOLOCK) ON SB1.D_E_L_E_T_ = '' AND SB1.B1_COD = SD2.D2_COD "
cqry += "   WHERE SD2.D_E_L_E_T_ = '' "
cqry += "     AND SD2.D2_TIPO = 'N' "
cqry += "     AND SF4.F4_ESTOQUE = 'S' AND B1_GRUPO <> '0020' "
cqry += "     AND SD2.D2_EMISSAO  > '"+cMes+"' "
cqry += "     AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
cqry += "     AND SB1.B1_MARCA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' 
cqry += "   GROUP BY D2_COD "
//cqry += "   HAVING ROUND((SUM(D2_QUANT)/6),0) > 0 "


MEMOWRIT("D:\A\SQL_EMIN.AQL",cqry)
TcQuery cqry New Alias "QR1"

TcSetField("QR1","QTD_VEN","N",12,2)



SB1->(DbSetOrder(1))
// B1_FILIAL, B1_COD, R_E_C_N_O_, D_E_L_E_T_

ProcRegua(SB1->(Lastrec()))


Do While !QR1->(Eof())
	IncProc("Produto: " + QR1->D2_COD )
	dbselectarea("SB1")
	DBSETORDER(1)
	DBGOTOP()
	If SB1->(DbSeek(xFilial("SB1")+alltrim(QR1->D2_COD)))
		RecLock("SB1",.f.)
		
		IF ALLTRIM(QR1->D2_COD) == '031083201273BVC'                                  
			_nEMIN := ROUND(((QR1->QTD_VEN/nDias)*180),0)
		ELSE
			_nEMIN := ROUND(((QR1->QTD_VEN/nDias)*MV_PAR08),0)
		ENDIF
		
		SB1->B1_EMIN := _nEMIN
		SB1->B1_PE   := MV_PAR08
		
		
		MsUnLock()
	EndIf
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
