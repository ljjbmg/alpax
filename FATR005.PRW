/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR005   บAutor  ณMicrosiga           บ Data ณ  30/01/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio das listas de precos.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#INCLUDE "rwmake.ch"
#Include "Topconn.ch"

User Function FATR005()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2         := "de acordo com os parametros informados pelo usuario."
Private cDesc3         := "titulo"
Private cPict          := ""
Private titulo       := "Lista de preco"
Private nLin         := 80

Private Cabec1       := "Part Number Descricao Preco"
Private Cabec2       := ""
Private imprime      := .T.
Private aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 132
Private tamanho          := "M"
Private nomeprog         := "FATR005"
Private nTipo            := 15
Private aReturn          := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "FATR005"
Private cString := "SB1"
Private cPerg	:= "FATR05"
//
// Criacao das perguntas do relatorio
//
_fCriaSx1()

pergunte(cPerg,.f.)

dbSelectArea("SB1")
dbSetOrder(1)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|lEnd| fImprime() })
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImprime  บAutor  ณMicrosiga           บ Data ณ  30/01/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImprime()

Titulo := "Tabela de Precos"
Cabec1 := "Part Number            Descricao                                                                     Capacidade        Preco"
Cabec2 := ""
//         XXXXXXXXXXXXXXXXXXXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   XXXXXXXXXXXXXXX   999,999,999.99
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9        10        11        12

If MV_PAR01 == 1
	_cQuery := "SELECT B1_MARCA,  B1_PNUMBER, B1_DESC,  B1_CAPACID, B1_PRV1 AS PRECO "
	_cQuery += "FROM " + RetSqlName("SB1") + " B1 "
	_cQuery += "WHERE B1_PNUMBER BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	_cQuery += "          AND B1_MARCA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
	_cQuery += "          AND B1_AXLISTP = 'S' AND B1.D_E_L_E_T_ = ' ' "
	_cQuery += "          AND B1_FILIAL = '" + xFilial("SB1") + "' AND B1_MSBLQL <> '1' "
	_cQuery += "ORDER BY B1_MARCA, B1_PNUMBER"
Else
	_cQuery := "SELECT B1_MARCA, B1_PNUMBER, B1_DESC, B1_CAPACID, DA1_PRCVEN AS PRECO "
	_cQuery += "FROM " + RetSqlName("SB1") + " B1, " + RetSqlName("DA1") + " DA1 "
	_cQuery += "WHERE B1_PNUMBER BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
	_cQuery += "          AND B1_MARCA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
	_cQuery += "          AND B1.D_E_L_E_T_ = ' '  AND B1_FILIAL = '" + xFilial("SB1") + "' "
	_cQuery += "          AND DA1_CODTAB = '" + MV_PAR02 + "' AND DA1_CODPRO = B1_COD "
	_cQuery += "          AND DA1_FILIAL = '" + xFilial("DA1") + "' AND DA1.D_E_L_E_T_ = ' ' AND B1_MSBLQL <> '1' ""
	_cQuery += "ORDER BY B1_MARCA, B1_PNUMBER "
EndIf

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","PRECO","N",12,2)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	If lEnd
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 8
	//
	// ainda falta quebrar por marca de produtos e ajustar a query com os parametros.  30/01/06.
	//
	_cMarca := QR1->B1_MARCA
	@ nLin,000 Psay "MARCA:" + QR1->B1_MARCA
	nLin++
	@ nLin,000 Psay __PrtThinLine()
	nLin++
	Do While ! QR1->(Eof()) .And. QR1->B1_MARCA == _cMarca
		If nLin > 55
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin := 8
			@ nLin,000 Psay "MARCA:" + QR1->B1_MARCA
			nLin++
			@ nLin,000 Psay __PrtThinLine()
			nLin++
		Endif
		@ nLin,000 Psay QR1->B1_PNUMBER
		@ nLin,023 Psay QR1->B1_DESC
		@ nLin,101 Psay QR1->B1_CAPACID
		@ nLin,119 Psay QR1->PRECO Picture "@e 999,999,999.99"
		QR1->(DbSkip())
		nLin++
	EndDo
	
EndDo

QR1->(DbCloseArea())

SET DEVICE TO SCREEN

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณMicrosiga           บ Data ณ  30/01/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fCriaSx1()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ\
//ณMV_PAR01 = Tabela Cadastro (S/N)ณ
//ณMV_PAR02 = Tabela ?             ณ
//ณMV_PAR03 = PNUMBER DE           ณ
//ณMV_PAR04 = PNUMBER ATE          ณ
//ณMV_PAR05 = MARCA DE             ณ
//ณMV_PAR06 = MARCA ATE            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ\

PutSx1(cPerg,"01","Tabela Cadastro ?" ,"Tabela Cadastro ?" ,"Tabela Cadastro ?" ,"mv_ch1","N",01,0,0,"C",""   ,"","","","mv_par01","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","","","","")
PutSx1(cPerg,"02","Tabela ?"          ,"Tabela ?"          ,"Tabela ?"          ,"mv_ch2","C",03,0,0,"G","DAO","","","","mv_par02",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"03","Part Number de ?"  ,"Part Number de ?"  ,"Part Number de ?"  ,"mv_ch3","C",20,0,0,"G",""   ,"","","","mv_par03",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"04","Part Number ate ?" ,"Part Number ate ?" ,"Part Number ate ?" ,"mv_ch4","C",20,0,0,"G",""   ,"","","","mv_par04",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"05","Marca de ?"        ,"Marca de ?"        ,"Marca de ?"        ,"mv_ch5","C",15,0,0,"G",""   ,"","","","mv_par05",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"06","Marca ate?"        ,"Marca ate?"        ,"Marca ate?"        ,"mv_ch6","C",15,0,0,"G",""   ,"","","","mv_par06",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")

Return
