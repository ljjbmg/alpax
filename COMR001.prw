/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMR001   บAutor  ณMicrosiga           บ Data ณ  03/17/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ RELATORIO DE ITENS EM PONTO DE PEDIDO CONSIDERANDO PEDIDOS บฑฑ
ฑฑบ          ณ DE VENDAS LIBERADOS E LIBERADOS COM BLOQUEIO.              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "TopConn.ch"
#Include "Rwmake.ch"

User Function COMR001()  

Private cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2         := "de acordo com os parametros informados pelo usuario."
Private cDesc3         := "titulo"
Private cPict          := ""
Private titulo       := "Ponto de Pedido por item liberado"
Private nLin         := 80

Private Cabec1       := "Part Number Descricao Preco"
Private Cabec2       := ""
Private imprime      := .T.
Private aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt		:= ""
Private limite		:= 220
Private tamanho		:= "G"
Private nomeprog	:= "COMR001"
Private nTipo		:= 15
Private aReturn		:= { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey	:= 0
Private cbtxt		:= Space(10)
Private cbcont		:= 00
Private CONTFL		:= 01
Private m_pag		:= 01
Private wnrel		:= "COMR001"
Private cString 	:= "SC9"
Private cPerg		:= "COMR01"
//
// Criacao das perguntas do relatorio
//

aPerg01 := { "Selecione o Almoxarifado desejado" }

PutSx1(cPerg,"01","Almoxarifado"          ,"Almoxarifado"          ,"Almoxarifado"          ,"mv_ch1","N",01,0,0,"C","",""   ,"","","mv_par01","01-Vendas","01-Vendas","01-Vendas","","02-L.Calibracao","02-L.Calibracao","02-L.Calibracao","03-Ass.Tecnica","03-Ass.Tecnica","03-Ass.Tecnica","04-Consumo","04-Consumo","04-Consumo","","","",aPerg01,aPerg01,aPerg01)

pergunte(cPerg,.f.)

dbSelectArea("SC9")
dbSetOrder(1)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
//wnrel := SetPrint(cString,NomeProg,,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

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
ฑฑบPrograma  ณfImprime  บAutor  ณMicrosiga           บ Data ณ  03/17/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImprime()

Local _nTotMarca := 0
Local _nTotGeral := 0

//_cLocal := Strzero(MV_PAR01,2)

_cQuery := "SELECT B1_PNUMBER AS REFERENCIA, B1_DESC AS PRODUTO, B1_CAPACID AS CAPACIDADE, B1_MARCA AS MARCA, "
_cQuery += "       B1_EMIN AS 'PONTO_P', B2_QATU AS ESTOQUE, SUM(C9_QTDLIB) AS 'PED_VENDA_L', B1_COD AS CODIGO,"
_cQuery += "       B2_SALPEDI AS 'PED_PEND',(B1_EMIN - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI) AS COMPRA "
_cQuery += "       FROM " + RetSqlName("SC9") + " C9 "
_cQuery += "                INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                    ON B1_FILIAL = '" + xFilial("SB1") + "'  AND B1_COD = C9_PRODUTO AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "                INNER JOIN " + RetSqlName("SB2") + " B2 "
_cQuery += "                    ON B2_FILIAL = '" + xFilial("SB2") + "' AND B2_COD = C9_PRODUTO AND B2_LOCAL = C9_LOCAL  "
_cQuery += "                       AND B2.D_E_L_E_T_ = ' ' "
_cQuery += "        		INNER JOIN " + RetSqlName("SC6") + " C6 "
_cQuery += "        		    ON C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM	"
_cQuery += "                INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "        		    ON C6_TES = F4_CODIGO "
_cQuery += "       WHERE C9_FILIAL = '" + xFilial("SC9") + "' AND B2_LOCAL = '01'  AND C9_NFISCAL = ' ' "
_cQuery += "             AND C9.D_E_L_E_T_ = ' ' AND F4_ESTOQUE = 'S' "
If 		MV_PAR02 == 1
_cQuery += "			 AND B1_GRUPO = '0020' "
elseif 	MV_PAR02 == 2
_cQuery += "			 AND B1_GRUPO <>'0020' "
Endif
_cQuery += "GROUP BY B1_PNUMBER, B1_DESC, B1_CAPACID, B1_MARCA, B1_EMIN, B2_QATU, B2_SALPEDI, B1_COD "
_cQuery += "      HAVING (B1_EMIN - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI) > 0 "
_cQuery += "ORDER BY MARCA, REFERENCIA "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","PONTO_P"		,"N",12,2)
TcSetField("QR1","ESTOQUE"		,"N",12,2)
TcSetField("QR1","PED_VENDA_L"	,"N",12,2)                                       
TcSetField("QR1","PED_PEND"		,"N",12,2)                                       
TcSetField("QR1","COMPRA"		,"N",12,2)                                       
TcSetField("QR1","CODIGO"		,"C",15,0)    //OCIMAR                                       

QR1->(DbGoTop())

Cabec1 := "REFERENCIA            DESCRICAO / CAPACIDADE                                                                      MARCA            PTO.PEDIDO     ESTOQUE P.VENDA LIB  PED.COMPRA     COMPRAR         VALOR"
Cabec2 := ""
//         XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXX  999,999.99  999,999.99  999,999.99  999,999.99  999,999.99 99,999,999.99
//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//

SetRegua(100)

Do While ! QR1->(Eof())
//	SB1->(DbSetOrder(9))
//	SB1->(DbSeek(xFilial("SB1")+QR1->REFERENCIA))
	IncRegua()
	
	If nLin > 54
		nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin++
	Endif
	_nTotMarca 	:= 0
	_cMarca		:= QR1->MARCA     
	
	Do While ! QR1->(Eof()) .And. _cMarca == QR1->MARCA 
	SB1->(DbSetOrder(1))                       // OCIMAR
	SB1->(DbSeek(xFilial("SB1")+QR1->CODIGO))  // OCIMAR  
//		_nValor := (QR1->COMPRA*SB1->B1_UPRC)
		_nValor := (QR1->COMPRA*SB1->B1_AXCUS)          // OCIMAR 11/10/09
		@ nLin,000 Psay QR1->REFERENCIA
		@ nLin,022 Psay Alltrim(QR1->PRODUTO) + " - " + Alltrim(QR1->CAPACIDADE)
		@ nLin,114 Psay QR1->MARCA
		@ nLin,131 Psay Transform(QR1->PONTO_P		,"@e 999,999.99")
		@ nLin,143 Psay Transform(QR1->ESTOQUE		,"@e 999,999.99")
		@ nLin,155 Psay Transform(QR1->PED_VENDA_L	,"@e 999,999.99")
		@ nLin,167 Psay Transform(QR1->PED_PEND		,"@e 999,999.99")
		@ nLin,179 Psay Transform(QR1->COMPRA		,"@e 999,999.99")
		@ nLin,190 Psay Transform(_nValor			,"@e 99,999,999.99")
		nLin++
		nLin++
		_nTotMarca+= _nValor
	           If nLin > 54
		           nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		           nLin++
	Endif		
		QR1->(DbSkip())
	EndDo     
	nLin++
	@ nLin,000 Psay "TOTAL DA MARCA " + Alltrim(_cMarca) + " ----------------- > "
	@ nLin,190 Psay Transform(_nTotMarca	,"@e 99,999,999.99")
	nLin+=2
	_nTotGeral += _nTotMarca
EndDo

QR1->(DbCloseArea())

If _nTotGeral > 0
	nLin++
	@ nLin,000 Psay "T O T A L   G E R A L    ----------------- > "
	@ nLin,190 Psay Transform(_nTotGeral	,"@e 99,999,999.99")	
EndIf

SET DEVICE TO SCREEN

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return
