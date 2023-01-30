#include "topconn.ch"
#INCLUDE "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR023   บAutor  ณ Ocimar Rolli       บ Data ณ  12/11/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRELATORIO DE NOTAS FISCAIS DE SERVICOS RECEBIDAS NO PERIODO บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FATR023()

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
Private nomeprog     := "FATR023" 
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "FATR023"
Private cString      := "SD2"
Private cPerg	     := "RCTB01"


_fCriaSx1()

Pergunte(cPerg,.f.)

dbSelectArea("SD1")
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


Titulo := "NOTAS FISCAIS DE SERVICO RECEBIDAS NO PERIODO DE " + Dtoc(MV_PAR01) + " ate " + Dtoc(MV_PAR02)
Cabec1 := "Nota       CNPJ                Cliente                                                    emissao     Valor da nota   Vl do Imposto"
Cabec2 := ""
//         XXXXXXXXX  XX.XXX.XXX/XXXX-XX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    99/99/99    99,999,999.99   99,999,999.99
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17

_cQuery := "SELECT D1_DOC , D1_DTDIGIT , A2_CGC , A2_NOME , SUM(D1_TOTAL) AS VALOR, D1_VALISS "
_cQuery += "FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "       INNER JOIN " + RetSqlName("SA2") + " A2 "
_cQuery += "                    ON D1_FORNECE = A2_COD "
_cQuery += "WHERE D1_DTDIGIT BETWEEN '" + Dtos(MV_PAR01) + "' AND '" + Dtos(MV_PAR02) + "' AND SUBSTRING(D1_CF,2,3) = '933' "
_cQuery += "      AND D1_FILIAL = '" + xFilial("SD1") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' "
_cQuery += "      AND D1.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY D1_DOC, D1_DTDIGIT, A2_CGC, A2_NOME, D1_VALISS "
_cQuery += "ORDER BY D1_DOC "

TcQuery _cQuery New Alias "QR1"                          

TcSetField("QR1","D1_DTDIGIT","D",12,2)
TcSetField("QR1","VALOR"     ,"N",12,2)
TcSetField("QR1","D1_VALISS" ,"N",12,2)

QR1->(DbGoTop())

_nTotServ := 0
_nTotImp  := 0

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

		@ nLin,000 Psay QR1->D1_DOC                                     // Nota Fiscal
        @ nLin,011 Psay QR1->A2_CGC	Picture "@R 99.999.999/9999-99"	    // CNPJ do Cliente
		@ nLin,031 Psay Substr(QR1->A2_NOME,1,55)      					// Nome do Cliente
		@ nLin,090 Psay Dtoc(QR1->D1_DTDIGIT) 		                    // Emissao da Nota
		@ nLin,102 Psay Transform(QR1->VALOR,"@e 99,999,999.99")        // Valor da Nota
		@ nLin,118 Psay Transform(QR1->D1_VALISS,"@e 99,999,999.99")    // Valor do Imposto		
		nLin++
		_nTotServ += QR1->VALOR
		_nTotImp  += QR1->D1_VALISS
		
		QR1->(dbSkip())
	EndDo
EndDo

nLin++
		@ nLin,080 Psay "Valor total "
		@ nLin,102 Psay Transform(_nTotServ,"@e 99,999,999.99")          // Total de servi็o no mes
		@ nLin,118 Psay Transform(_nTotImp ,"@e 99,999,999.99")          // Total de imposto no mes		
		

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