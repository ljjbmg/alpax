#include "topconn.ch"
#INCLUDE "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR015   บAutor  ณMicrosiga           บ Data ณ  08/19/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRELATORIO DE CONTROLE DE COLETAS TIPO CIF.                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function ESTR015()

PRIVATE cDesc1       := "Este programa tem como objetivo imprimir relatorio "
PRIVATE cDesc2       := "de acordo com os parametros informados pelo usuario."
PRIVATE cDesc3       := "CONTROLE DE COLETA TIPO CIF"
PRIVATE cPict        := ""
PRIVATE titulo       := "CONTROLE DE COLETA TIPO CIF"
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
Private nomeprog     := "ESTR015" 
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "ESTR015"

Private cString      := "SZJ"
Private cPerg	     := "REST15"


_fCriaSx1()

Pergunte(cPerg,.f.)

dbSelectArea("SZJ")
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
Private _nTotalG := 0
Private _nTotal  := 0


Titulo := "CONTROLE DE COLETA TIPO CIF"
Cabec1 := "Serie/Nota  Cliente                            Valor Frete  Nr.Coleta        Data Coleta"
Cabec2 := ""
//         XXX-XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  999,999,999.99  XXXXXXXXXXXXXXX  99/99/99
//         012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17


_cQuery := "SELECT ZJ_TRANSP, ZJ_RAZAO, ZJ_SERIE, ZJ_NOTA, A4_COD, A4_NOME, ZJ_VLCOLET, ZJ_COLETA, ZJ_DATACOL "
_cQuery += "FROM " + RetSqlName("SZJ") + " ZJ "
_cQuery += "       INNER JOIN " + RetSqlName("SA4") + " A4 "
_cQuery += "                   ON ZJ_TRANSP = A4_COD AND A4_FILIAL = '" + xFilial("SA4") + "' AND A4.D_E_L_E_T_ = ' ' "
_cQuery += "WHERE ZJ_TRANSP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "      AND ZJ_DATACOL BETWEEN '" + Dtos(MV_PAR03) + "' AND '" + Dtos(MV_PAR04) + "' "
_cQuery += "      AND ZJ_TIPOFR = 'C'  AND ZJ_FILIAL = '" + xFilial("SZJ") + "' AND ZJ.D_E_L_E_T_ = ' ' "
_cQuery += "ORDER BY ZJ_TRANSP"

TcQuery _cQuery New Alias "QR1"                          

TcSetField("QR1","ZJ_VLCOLET","N",12,2)
TcSetField("QR1","ZJ_DATACOL","D",12,2)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	If lEnd
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	_cTransp 	:= QR1->ZJ_TRANSP
	_nTotal		:= 0
	nLin:=60
	Do While ! QR1->(Eof()) .And. _cTransp == QR1->ZJ_TRANSP
		If nLin > 55
			nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin++
			@ nLin,000 Psay "Transportadora: " + QR1->ZJ_TRANSP + " - " + QR1->A4_NOME
			nLin++
		Endif     

		@ nLin,000 Psay QR1->ZJ_SERIE + "-" + QR1->ZJ_NOTA
		@ nLin,012 Psay QR1->ZJ_RAZAO
		@ nLin,044 Psay Transform(QR1->ZJ_VLCOLET,"@e 999,999,999.99")
		@ nLin,060 Psay QR1->ZJ_COLETA
		@ nLin,077 Psay DTOC(QR1->ZJ_DATACOL)
		_nTotal  += QR1->ZJ_VLCOLET
		_nTotalG +=	QR1->ZJ_VLCOLET
		nLin++
		
		QR1->(dbSkip())
	EndDo
	nLin++
	@ nLin,000 Psay "Total Transportadora..........."
	@ nLin,044 Psay Transform(_nTotal,"@e 999,999,999.99")	
	nLin++
	
EndDo

nLin++
@ nLin,000 Psay "Total Geral............" 
@ nLin,044 Psay Transform(_nTotalG,"@e 999,999,999.99")	

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
aPerg03 := {}
aPerg04 := {}

aAdd(aPerg01,"Digite a Transportadora Inicial")
aAdd(aPerg02,"Digite a Transportadora Final")
aAdd(aPerg03,"Digite a data inicial da coleta")
aAdd(aPerg04,"Digite a data final da coleta")

PutSx1(cPerg,"01","Transportadora de"	,"Transportadora de"	,"Transportadora de"	,"mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aPerg01,aPerg01,aPerg01)        			
PutSx1(cPerg,"02","Transportadora Ate"	,"Transportadora ate"	,"Transportadora ate"	,"mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aPerg02,aPerg02,aPerg02)        			
PutSx1(cPerg,"03","Periodo Inicial"	,"Periodo Inicial"		,"Periodo Inicial"		,"mv_ch3","D",08,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aPerg03,aPerg03,aPerg03)        			
PutSx1(cPerg,"04","Periodo Final"		,"Periodo Final"		,"Periodo Final"		,"mv_ch4","D",08,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aPerg04,aPerg04,aPerg04)        			

Return