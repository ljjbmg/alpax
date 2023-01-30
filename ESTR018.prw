#include "topconn.ch"
#INCLUDE "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR018   บAutor  ณOcimar Rolli        บ Data ณ  16/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de materiais transferidos para o armazem 02       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function ESTR018()

PRIVATE cDesc1       := "Este programa tem como objetivo imprimir relatorio "
PRIVATE cDesc2       := "de acordo com os parametros informados pelo usuario."
PRIVATE cDesc3       := "MATERIAIS TRANSFERIDOS PARA O ARMAZEM 02"
PRIVATE cPict        := ""
PRIVATE titulo       := "MAT. ENVIADOS AO LABORAT."
PRIVATE nLin         := 80

PRIVATE Cabec1       := ""
PRIVATE Cabec2       := ""
PRIVATE imprime      := .T.
PRIVATE aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "ESTR018"
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "ESTR018"
Private _cAnt        := " "
Private cString      := "SD3"
Private cPerg	     := "REST18"

_fCriaSx1()

Pergunte(cPerg,.f.)

dbSelectArea("SD3")
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

RptStatus({|lEnd| _fImprime() })
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprime บAutor  ณMicrosiga           บ Data ณ  16/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ funcao de impressao do relatorio.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fImprime()

Titulo := "MATERIAIS ENVIADOS AO LABORATORIO"
Cabec1 := "PART NUMBER         PRODUTO                                                              MARCA         CAPACIDADE     QUANT.      PEDIDOS   SALDO     CLIENTE"
Cabec2 := ""
//         XXX-XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999,999,999.99  XXXXXXXXXXXXXXX  99/99/99
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17


_cQuery := "SELECT B1_COD, B1_PNUMBER , B1_DESC , B1_CAPACID , B1_MARCA, D3_QUANT, A1_NOME, C6_NUM, (C6_QTDVEN - C6_QTDENT) AS SALDO "
_cQuery += "FROM " + RetSqlName("SD3") + " D3 "
_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                   ON D3_COD = B1_COD AND D3_FILIAL = '" + xFilial("SD3") + "' " "
_cQuery += "       LEFT JOIN " + RetSqlName("SC6") + " C6 "
_cQuery += "                   ON D3_COD = C6_PRODUTO AND C6_FILIAL = '" + xFilial("SC6") + "' " "
_cQuery += "       LEFT JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "                   ON C6_CLI = A1_COD AND A1_FILIAL = '" + xFilial("SA1") + "' " "
_cQuery += "WHERE D3.D_E_L_E_T_ = ' ' AND D3_DOC = '" + MV_PAR01 + "' "
_cQuery += "      AND D3_CF = 'DE4' AND C6.D_E_L_E_T_ = ' ' AND C6_BLQ <> 'R' AND (C6_QTDVEN - C6_QTDENT) > 0 AND C6_LOCAL = '02'"
_cQuery += "ORDER BY B1_MARCA, B1_PNUMBER "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D3_QUANT" ,"N",12,0)
TcSetField("QR1","SALDO"    ,"N",12,0)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	_cAnt := QR1->B1_COD
	
	If nLin > 55
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif
	
	@ nLin,000 Psay QR1->B1_PNUMBER
	@ nLin,020 Psay QR1->B1_DESC
	@ nLin,090 Psay rTrim(QR1->B1_MARCA)
	@ nLin,104 Psay rTrim(QR1->B1_CAPACID)
	@ nLin,118 Psay QR1->D3_QUANT Picture "@e 999,999"
	nLin++
	
	Do While QR1->B1_COD == _cAnt
		@ nLin,131 Psay QR1->C6_NUM
  		@ nLin,140 Psay QR1->SALDO Picture "@e 9,999"
  		@ nLin,150 Psay rTrim(QR1->A1_NOME)
		nLin++
		QR1->(dbSkip())
	EndDo
	@ nLin,000 PSAY Replicate("_",220)
	nLin++
	
EndDo

QR1->(DbCloseArea())

    @ 059,118 Psay "        /       /     "
	@ 060,000 Psay Replicate("_",60)
	@ 060,118 Psay " _____ / _____ / _____
	nLin++
	@ 062,000 Psay "RECEBIDO POR "
	@ 062,128 Psay "DATA "

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
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณMicrosiga           บ Data ณ  08/19/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de criacao das perguntas.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fCriaSx1()

PutSx1(cPerg,"01","Transferencia n."	,"Transferencia n."	,"Transferencia n."	,"mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","")

Return
