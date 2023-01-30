#INCLUDE "rwmake.ch"
#Include "Topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR007   บAutor  ณMicrosiga           บ Data ณ  22/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao do Resumo Geral (SSP)                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ESTR007()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local cDesc1		:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2		:= "de acordo com os parametros informados pelo usuario."
Local cDesc3		:= "MAPA DE ESTOCAGEM E RESUMO GERAL (SSP)"
Local cPict			:= ""
Local titulo		:= "MAPA DE ESTOCAGEM E RESUMO GERAL (SSP)"

Local Cabec1		:= ""
Local Cabec2		:= ""
Local imprime      	:= .T.
Local aOrd := {}         
Private _cDia		:= Strzero(Day(dDataBase),2)
Private _aMes		:= {"Janeiro","Fevereiro","Marco","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro",;
                        "Dezembro"}
Private _cAno		:= Strzero(Year(dDataBase),4)
Private lEnd       	:= .F.
Private lAbortPrint	:= .F.
Private CbTxt       := ""
Private limite		:= 220
Private tamanho		:= "G"
Private nomeprog	:= "ESTR007"
Private nTipo		:= 18
Private aReturn		:= { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey	:= 0
Private cbtxt		:= Space(10)
Private cbcont		:= 00
Private CONTFL		:= 01
Private m_pag		:= 01
Private wnrel		:= "ESTR007"
Private cString 	:= "SD1"
Private cPerg		:= "REST07"
Private nLin		:= 80
Private _nPag       := 1

_fCriaSx1()

Pergunte(cPerg,.t.)

dbSelectArea("SZD")
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

RptStatus({|lEnd| RunReport() })
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunReport บAutor  ณMicrosiga           บ Data ณ  10/22/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function RunReport()

Local nOrdem
Local _nCount	:= 0

dbSelectArea(cString)
dbSetOrder(1)

_cTrim := Strzero(MV_PAR01,1)

Do Case
	Case MV_PAR01 == 1
		_cPerioI	:= MV_PAR02+"01"
		_cPerioF    := MV_PAR02+"03"
		
	Case MV_PAR01 == 2
		_cPerioI	:= MV_PAR02+"04"
		_cPerioF    := MV_PAR02+"06"
		
	Case MV_PAR01 == 3
		_cPerioI	:= MV_PAR02+"07"
		_cPerioF    := MV_PAR02+"09"
	Otherwise
		_cPerioI	:= MV_PAR02+"10"
		_cPerioF    := MV_PAR02+"12"
EndCase

/*
_cQuery := "SELECT COUNT(*) AS TOTAL "
_cQuery += "       FROM " + RetSqlName("SZD") + " ZD, " + RetSqlName("SZE") + " ZE "
_cQuery += "       WHERE ZD_FILIAL = '" + xFilial("SZD") + "' AND ZE_FILIAL = '" + xFilial("SZE") + "' "
_cQuery += "             AND ZD.D_E_L_E_T_ = ' ' AND ZE.D_E_L_E_T_ = ' ' "
_cQuery += "             AND ZE_TRIMEST = '" + _cTrim + "' AND ZE_ANO = '" + MV_PAR02 + "' "
_cQuery += "             AND ZE_CODIGO = ZD_CODIGO "
                     
TcQuery _cQuery New Alias "QR1"
_nTotal := QR1->TOTAL
_nPagAte := iif(QR1->TOTAL - INT(QR1->TOTAL/45) > 0,INT(QR1->TOTAL/45)+1,QR1->TOTAL)

QR1->(DbCloseArea())
*/

_cQuery := "SELECT COUNT(DISTINCT(ZV_CLAS)) AS TOTAL "
_cQuery += "             FROM " + RetSqlName("SZV") + " ZV "
_cQuery += "                   WHERE ZV_FILIAL = '" + xFilial("SZV") + "' AND ZV_ORGAO = '001' "
_cQuery += "                   AND ZV_ANO+ZV_MES BETWEEN '" + _cPerioI + "' AND '" + _cPerioF + "' "
_cQuery += "                   AND D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias "QR1"
_nTotal := QR1->TOTAL
_nPagAte := iif(QR1->TOTAL - INT(QR1->TOTAL/45) > 0,INT(QR1->TOTAL/45)+1,QR1->TOTAL/45)

QR1->(DbCloseArea())

_cQuery := "SELECT ZV_ANO, ZV_MES, ZV_CLAS, ZV_DESCRI, ZV_SLDANT, ZV_COMPRAS, ZV_CONSUMO, ZV_SAIDAS, ZV_SALFIN, ZS_UM, ZV_ENTDV, ZV_SAIDV "
_cQuery += "       FROM " + RetSqlname("SZV") + " ZV "
_cQuery += "       INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "               ON ZS_FILIAL = '" + xFilial("SZS") + "' AND ZV_ORGAO = ZS_ORGAO AND ZV_CLAS = ZS_CON "                  
_cQuery += "                  AND ZS.D_E_L_E_T_ = ' ' "
_cQuery += "       WHERE ZV_FILIAL = '" + xFilial("SZV") + "' AND ZV_ORGAO = '003' "             
_cQuery += "             AND ZV_ANO+ZV_MES BETWEEN '" + _cPerioI + "' AND '" + _cPerioF + "' "
_cQuery += "             AND ZV.D_E_L_E_T_ = ' '                                              
_cQuery += "       ORDER BY ZV_CLAS, ZV_ANO, ZV_MES "

TcQuery _cQuery New Alias "QR1"


TcSetField("QR1","ZV_SLDANT"	,"N",13,3)
TcSetField("QR1","ZV_COMPRAS"	,"N",13,3)
TcSetField("QR1","ZV_CONSUMO"	,"N",13,3)
TcSetField("QR1","ZV_SAIDAS"	,"N",13,3)
TcSetField("QR1","ZV_SALFIN"	,"N",13,3)
TcSetField("QR1","ZV_SAIDV"  	,"N",13,3)
TcSetField("QR1","ZV_ENTDV" 	,"N",13,3)

QR1->(DbGoTop())

SetRegua(_nTotal)

_lPrimeiro := .t.

While !QR1->(Eof())
	
	IncRegua()
	
	If lEnd
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	// Cabecalho/rodape relatorio.	
	If nLin > 55
		If ! _lPrimeiro
			_fRodape()
		Endif	 
		nLin := _fCabec()
		nLin++	 
		_nPag++
		_lPrimeiro := .f.	                                
	Endif

	_cClas := QR1->ZV_CLAS
	                                                    
	_nSalAnt 	:= 0
	_nCompras	:= 0
	_nConsumo	:= 0
	_nSaidas	:= 0
	_nSalFin	:= 0             
	_cDesc		:= ""
	_cUM		:= ""
	
	Do While ! QR1->(Eof()) .And. QR1->ZV_CLAS == _cClas                            
		If (QR1->ZV_ANO+QR1->ZV_MES) == _cPerioI
			_nSalAnt := QR1->ZV_SLDANT
		EndIf
		
		If (QR1->ZV_ANO+QR1->ZV_MES) == _cPerioF
			_nSalFin := QR1->ZV_SALFIN
		EndIf                         
		_cDesc		:= QR1->ZV_DESCRI
		_cUM		:= QR1->ZS_UM
		_nCompras	+= QR1->ZV_COMPRAS+QR1->ZV_ENTDV
		_nConsumo	+= QR1->ZV_CONSUMO
		_nSaidas	+= QR1->ZV_SAIDAS+QR1->ZV_SAIDV
		QR1->(DbSkip()) 
	EndDo
	
	@ nLin,000 Psay _cDesc
	@ nLin,070 Psay _nSalAnt	Picture "@e 999,999,999.999"
	@ nLin,090 Psay _nCompras	Picture "@e 999,999,999.999"
	@ nLin,110 Psay _nConsumo	Picture "@e 999,999,999.999"
	@ nLin,132 Psay _nSaidas	Picture "@e 999,999,999.999"
	@ nLin,158 Psay _nSalFin	Picture "@e 999,999,999.999"
	@ nLin,179 Psay _cUM
	nLin++
EndDo

If ! _lPrimeiro
	_fRodape()
endIf     

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
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณMicrosiga           บ Data ณ  22/10/05   บฑฑ
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

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Trimestre  ณ
//*MV_PAR02 = Ano        *
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","Qual Trimestre ?" ,"Qual Trimestre ?","Qual Trimestre ?","mv_ch1","N",08,0,0,"C","","","","","mv_par01","1-Trimestre","1-Trimestre","-1Trimestre","","2-Trimestre","2-Trimestre","2-Trimestre","3-Trimestre","3-Trimestre","3-Trimestre","4-Trimestre","4-Trimestre","4-Trimestre","","","",,,)
PutSx1(cPerg,"02","Ano ?"            ,"Ano ?"           ,"Ano ?"           ,"mv_ch2","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCabec   บAutor  ณMicrosiga           บ Data ณ  22/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cabecalho do relatorio.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fCabec()

Do Case
	Case MV_PAR01 = 1
		_cPeriodo := "01/01/" + MV_PAR02 + " a " + "31/03/" + MV_PAR02
	Case MV_PAR01 = 2
		_cPeriodo := "01/04/" + MV_PAR02 + " a " + "30/06/" + MV_PAR02
	Case MV_PAR01 = 3
		_cPeriodo := "01/07/" + MV_PAR02 + " a " + "30/09/" + MV_PAR02
	Otherwise
		_cPeriodo := "01/10/" + MV_PAR02 + " a " + "31/12/" + MV_PAR02
EndCase

@ 000,000 Psay "                                                                                    M A P A   D E   E S T O C A G E M   E   R E S U M O   G E R A L "
@ 000,189 Psay "Pag." + Strzero(_nPag,3) + " de " + Strzero(_nPagAte,3)
@ 001,000 Psay Padc("Exigido pela Secretaria da Seguranca Publica",Limite)

@ 002,000 Psay "ALPAX COMERCIO DE PRODUTOS PARA LABORATORIOS LTDA-1503                 Discriminacao da estocagem de produtos quimicos                      Certificado de Vistoria Tecnica Policial SSP,"
@ 003,000 Psay "Estabelecimento Licenciado:                                            controlados pela secretaria da Seguranca Publica/SSP,                Sob No. 002/2018 validade 31/12/2018."
@ 004,000 Psay "RUA SERRA DA BORBOREMA, 40                                             Ministerio da Justica/Policia Federal e Ministerio da                Licenciada pela Secretaria da Seguranca Publica,"
@ 005,000 Psay "CAMPANARIO - DIADEMA - SP                                              Defesa/Exercito, Referente ao Periodo de:                            Sob.No.229/2018 validade 31/12/2018."
@ 006,000 Psay Padc(_cPeriodo,Limite)
@ 008,000 Psay "                                                                             Saldo no                                              Vendas,Perdas ou      Saldo que passa para      Unidade de
@ 009,000 Psay "Produto                                                            Trimestre Anterior             Compras             Consumo        Transferencias      o trimestre seguinte      medida
//              XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX                              999,999,999.999     999,999,999.999     999,999,999.999       999,999,999.999           999,999,999.999      XX
//              01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                        1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22  	                     
Return(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fRodape  บAutor  ณMicrosiga           บ Data ณ  22/10/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rodape do relatorio.                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fRodape() 

_cDataAtu := _cDia + " de " + _aMes[Month(dDataBase)] + " de " + _cAno + "."

nLin := 058
@ nLin,000 Psay "No ato da entrega, solicite um comprovante.                                                                          O que declaro e a verdade sob as penas da lei"
nLin++
@ nLin,000 Psay "A Nao entrega deste mapa implica a empresa severas penalidades.                                                      Sao Paulo, " + _cDataAtu
nLin++
@ nLin,000 Psay "Artigo 92 R/105 do Decreto Federal 3665 de 20/nov/2000"
nLin++
@ nLin,000 Psay "Artigo 11 do Decreto Estadual 6911 de 19/01/1935                                                                     _______________________________________________________________________"

nLin++
@ nLin,000 Psay "                                                                                                                     Luci Akemi Masumoto                                    R.G.:7.700.270-2"
nLin++
@ nLin,000 Psay "                                                                                                                     Socia/Gerente"
nLin++

Return