#include "topconn.ch"
#INCLUDE "rwmake.ch"
/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?FATR013   ?Autor  ? Ocimar Rolli       ? Data ?  12/11/08   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ?RELATORIO DE NOTAS FISCAIS DE SERVICOS EMITIDAS NO PERIODO  ???
???          ?                                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP                                                         ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/

User Function FATR013()

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
Private nomeprog     := "FATR013" 
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "FATR013"
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
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?_fImprime ?Autor  ?Microsiga           ? Data ?  08/19/06   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ? funcao de impressao do relatorio.                          ???
???          ?                                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP                                                        ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/
Static Function _fImprime()

Private Titulo
Private Cabec1
Private Cabec2
Private _cTransp


Titulo := "NOTAS FISCAIS DE SERVICO EMITIDAS NO PERIODO DE " + Dtoc(MV_PAR01) + " ate " + Dtoc(MV_PAR02)
Cabec1 := "Nota       CNPJ                Cliente                                                    emissao     Valor da nota   Vl do Imposto"
Cabec2 := ""
//         XXXXXXXXX  XX.XXX.XXX/XXXX-XX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX    99/99/99    99,999,999.99   99,999,999.99
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17

_cQuery := "SELECT D2_DOC , D2_EMISSAO , A1_CGC , A1_NOME , SUM(D2_TOTAL) AS VALOR, D2_VALISS "
_cQuery += "FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "       INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "                    ON D2_CLIENTE = A1_COD "
_cQuery += "WHERE D2_EMISSAO BETWEEN '" + Dtos(MV_PAR01) + "' AND '" + Dtos(MV_PAR02) + "' AND SUBSTRING(D2_CF,2,3) = '933' "
_cQuery += "      AND D2_FILIAL = '" + xFilial("SD2") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' "
_cQuery += "      AND D2.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY D2_DOC, D2_EMISSAO, A1_CGC, A1_NOME, D2_VALISS "
_cQuery += "ORDER BY D2_DOC "

TcQuery _cQuery New Alias "QR1"                          

TcSetField("QR1","D2_EMISSAO","D",12,2)
TcSetField("QR1","VALOR"     ,"N",12,2)
TcSetField("QR1","D2_VALISS" ,"N",12,2)

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

		@ nLin,000 Psay QR1->D2_DOC                                     // Nota Fiscal
        @ nLin,011 Psay QR1->A1_CGC	Picture "@R 99.999.999/9999-99"	    // CNPJ do Cliente
		@ nLin,031 Psay Substr(QR1->A1_NOME,1,55)      					// Nome do Cliente
		@ nLin,090 Psay Dtoc(QR1->D2_EMISSAO) 		                    // Emissao da Nota
		@ nLin,102 Psay Transform(QR1->VALOR,"@e 99,999,999.99")        // Valor da Nota
		@ nLin,118 Psay Transform(QR1->D2_VALISS,"@e 99,999,999.99")    // Valor do Imposto		
		nLin++
		_nTotServ += QR1->VALOR
		_nTotImp  += QR1->D2_VALISS
		
		QR1->(dbSkip())
	EndDo
EndDo

nLin++
		@ nLin,080 Psay "Valor total "
		@ nLin,102 Psay Transform(_nTotServ,"@e 99,999,999.99")          // Total de servi?o no mes
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
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?_fCriaSx1 ?Autor  ?Microsiga           ? Data ?  08/19/06   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ?Funcao de criacao das perguntas.                            ???
???          ?                                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP                                                         ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/
Static Function _fCriaSx1()

aPerg01 := {}
aPerg02 := {}

aAdd(aPerg01,"Digite a data inicial ")
aAdd(aPerg02,"Digite a data final ")

PutSx1(cPerg,"01","Data inicial"	,"Data Inicial"		,"Data Inicial"		,"mv_ch1","D",08,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aPerg01,aPerg01,aPerg01)        			
PutSx1(cPerg,"02","Data Final"		,"Data Final"		,"Data Final"		,"mv_ch2","D",08,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aPerg02,aPerg02,aPerg02)        			

Return