#include "topconn.ch"
#INCLUDE "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTBR001   บAutor  ณ Ocimar Rolli       บ Data ณ  12/11/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRELATORIO DE NOTAS FISCAIS DE SERVICOS EMITIDAS NO PERIODO  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CTBR001()

PRIVATE cDesc1       := "Este programa tem como objetivo imprimir relatorio "
PRIVATE cDesc2       := "de acordo com os parametros informados pelo usuario."
PRIVATE cDesc3       := "NOTAS FISCAIS DE SERVICO NO PERIODO"
PRIVATE cPict        := ""
PRIVATE titulo       := "NOTAS FISCAIS DE SERVICO NO PERIODO"
PRIVATE nLin         := 80

PRIVATE Cabec1       := "NOTA CLIENTE"
PRIVATE Cabec2       := ""
PRIVATE imprime      := .T.
PRIVATE aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 132
Private tamanho      := "M"
Private nomeprog     := "CTBR001" 
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CTBR001"
Private cString      := "SD2"
Private cPerg	     := "RCTB01"


_fCriaSx1()

Pergunte(cPerg,.f.)

dbSelectArea("SD2")
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
ฑฑบPrograma  ณ_fImprime บAutor  ณMicrosiga           บ Data ณ  08/19/06   บฑฑ
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

Private Titulo
Private Cabec1
Private Cabec2
Private _cTransp


Titulo := "NOTAS FISCAIS DE SERVICO EMITIDAS NO PERIODO DE " + Dtoc(MV_PAR01) + " ate " + Dtoc(MV_PAR02)
Cabec1 := "Nota    CNPJ                Cliente                                                            Data de emissao       Valor da nota"
Cabec2 := ""
//         XXXXXX  XX.XXX.XXX/XXXX-XX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX     99/99/99           99,999,999.99
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17

_cQuery := "SELECT D2_DOC , D2_EMISSAO , A1_CGC , A1_NOME , SUM(D2_TOTAL) AS VALOR "
_cQuery += "FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "       INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "                    ON D2_CLIENTE = A1_COD "
_cQuery += "WHERE D2_EMISSAO BETWEEN '" + Dtos(MV_PAR01) + "' AND '" + Dtos(MV_PAR02) + "' AND SUBSTRING(D2_CF,2,3) = '933' "
_cQuery += "      AND D2_FILIAL = '" + xFilial("SD2") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' "
_cQuery += "GROUP BY D2_DOC, D2_EMISSAO, A1_CGC, A1_NOME "

TcQuery _cQuery New Alias "QR1"                          

TcSetField("QR1","D2_EMISSAO","D",12,2)
TcSetField("QR1","VALOR"     ,"N",12,2)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	If lEnd
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	nLin:=60
	Do While ! QR1->(Eof())
		If nLin > 55
			nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin++
		Endif     

		@ nLin,000 Psay QR1->D2_DOC                                     // Nota Fiscal
        @ nLin,008 Psay QR1->A1_CGC	Picture "@R 99.999.999/9999-99"	    // CNPJ do Cliente
		@ nLin,028 Psay QR1->A1_NOME                 					// Nome do Cliente
		@ nLin,098 Psay Dtoc(QR1->D2_EMISSAO) 		                    // Emissao da Nota
		@ nLin,117 Psay Transform(QR1->VALOR,"@e 99,999,999.99")        // Valor da Nota
		nLin++
		
		QR1->(dbSkip())
	EndDo
EndDo

nLin++

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

aPerg01 := {}
aPerg02 := {}

aAdd(aPerg01,"Digite a data inicial ")
aAdd(aPerg02,"Digite a data final ")

PutSx1(cPerg,"01","Data inicial"	,"Data Inicial"		,"Data Inicial"		,"mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aPerg01,aPerg01,aPerg01)        			
PutSx1(cPerg,"02","Data Final"		,"Data Final"		,"Data Final"		,"mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aPerg02,aPerg02,aPerg02)        			

Return