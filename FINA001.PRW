#Include "Protheus.ch"
#Include "Topconn.ch"

User Function FINA001()                               

_cPerg := "FINA01"

PutSx1(_cPerg,"01","Data de referencia" ,"Data de referencia" ,"Data de referencia" ,"mv_ch1","D",08,0,0,"G","","","","","MV_PAR01","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Tipo de cliente   " ,"Tipo de cliente   " ,"Tipo de cliente   " ,"mv_ch1","C",01,0,0,"G","","","","","MV_PAR02","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"03","Cliente de        " ,"Cliente de        " ,"Cliente de        " ,"mv_ch1","C",06,0,0,"G","","","","","MV_PAR03","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"04","Cliente ate       " ,"Cliente ate       " ,"Cliente ate       " ,"mv_ch1","C",06,0,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",,,)
PutSx1(_cPerg,"05","Valor do credito  " ,"Valor do credito  " ,"Valor do credito  " ,"mv_ch1","N",12,2,0,"G","","","","","MV_PAR04","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde atualizando o cadastro de clientes",,{ || fAtualiza() })
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtualiza บAutor  ณOcimar Rolli        บ Data ณ  08/10/13   บฑฑ
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

cqry :="SELECT A1_COD, A1_LC, A1_ULTCOM FROM SA1010 "
cqry +="WHERE A1_ULTCOM < '"+DtoS(MV_PAR01)+"' "
cqry +="AND A1_TIPO = '"+MV_PAR02+"' "
cqry +="AND A1_COD BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "
cqry +="ORDER BY A1_COD "

MEMOWRIT("D:\A\SQL_LC.AQL",cqry)
TcQuery cqry New Alias "QR1"

TcSetField("QR1","A1_COD","C",06,0)
TcSetField("QR1","A1_LC" ,"N",12,2)

SA1->(DbSetOrder(1))
// A1_FILIAL, A1_COD

ProcRegua(SA1->(Lastrec()))

Do While !QR1->(Eof())
	IncProc("CLIENTE: " + QR1->A1_COD )
	dbselectarea("SA1")
	DBSETORDER(1)
	DBGOTOP()
	SA1->(DbSeek(xFilial("SA1")+alltrim(QR1->A1_COD)))
	RecLock("SA1",.f.)
	SA1->A1_LC := MV_PAR05
	MsUnLock()
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
