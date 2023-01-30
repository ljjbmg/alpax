/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³COMR003   ºAutor  ³Microsiga           º Data ³  17/12/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ RELATORIO DE ITENS EM PONTO DE PEDIDO CONSIDERANDO PEDIDOS º±±
±±º          ³ DE VENDAS LIBERADOS E LIBERADOS COM BLOQUEIO.ALMOX.LB      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "TopConn.ch"
#Include "Rwmake.ch"

User Function COMR003()

Private cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2         := "de acordo com os parametros informados pelo usuario."
Private cDesc3         := "titulo"
Private cPict          := ""
Private titulo       := "Ponto de Pedido ALMOX.LB"
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
Private nomeprog	:= "COMR003"
Private nTipo		:= 15
Private aReturn		:= { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey	:= 0
Private cbtxt		:= Space(10)
Private cbcont		:= 00
Private CONTFL		:= 01
Private m_pag		:= 01
Private wnrel		:= "COMR003"
Private cString 	:= "SC9"
Private cPerg		:= "COMR02"
//
// Criacao das perguntas do relatorio
//

aPerg01 := { "Selecione o Almoxarifado desejado" }

PutSx1(cPerg,"01","Almoxarifado"          ,"Almoxarifado"          ,"Almoxarifado"          ,"mv_ch1","N",01,0,0,"C","",""   ,"","","mv_par01","01-Vendas","01-Vendas","01-Vendas","","02-L.Calibracao","02-L.Calibracao","02-L.Calibracao","03-Ass.Tecnica","03-Ass.Tecnica","03-Ass.Tecnica","04-Consumo","04-Consumo","04-Consumo","","","",aPerg01,aPerg01,aPerg01)

pergunte(cPerg,.f.)

dbSelectArea("SC9")
dbSetOrder(1)

//wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)
wnrel := SetPrint(cString,NomeProg,,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImprime  ºAutor  ³Microsiga           º Data ³  03/17/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImprime()

Local _nTotMarca 	:= 0
Local _nTotGeral 	:= 0
Local _nQtd01		:= 0

//_cLocal := Strzero(MV_PAR01,2)

_cQuery := "SELECT B1_PNUMBER AS REFERENCIA, B1_DESC AS PRODUTO, B1_CAPACID AS CAPACIDADE, B1_MARCA AS MARCA, "
_cQuery += "       B2_QATU AS ESTOQUE, B1_COD AS CODIGO, B2_QPEDVEN AS PED_VEN, B2_QTNP AS TERCEIROS, B2_QNPT EM_TERC,"
_cQuery += "       B2_SALPEDI AS 'PED_PEND',(B2_QPEDVEN - B2_QATU - B2_SALPEDI - B2_QTNP + B2_QNPT) AS COMPRA "
_cQuery += "       FROM " + RetSqlName("SB2") + " B2 "
_cQuery += "                INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                    ON B1_FILIAL = '" + xFilial("SB1") + "'  AND B1_COD = B2_COD "
_cQuery += "       WHERE B2_FILIAL = '" + xFilial("SB2") + "' AND B2_LOCAL = 'LB'  "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' AND B2.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY B1_PNUMBER, B1_DESC, B1_CAPACID, B1_MARCA, B2_QATU, B2_SALPEDI, B1_COD, B2_QPEDVEN, B2_QTNP, B2_QNPT "
_cQuery += "      HAVING (B2_QPEDVEN - B2_QATU - B2_SALPEDI - B2_QTNP + B2_QNPT) > 0 "
_cQuery += "ORDER BY MARCA, REFERENCIA "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","ESTOQUE"		,"N",12,2)
TcSetField("QR1","PED_PEND"		,"N",12,2)
TcSetField("QR1","COMPRA"		,"N",12,2)
TcSetField("QR1","PED_VEN"		,"N",12,2)
TcSetField("QR1","CODIGO"		,"C",15,0)    //OCIMAR
TcSetField("QR1","TERCEIROS"	,"N",12,0)    //OCIMAR
TcSetField("QR1","EM_TERC"		,"N",12,0)    //OCIMAR

QR1->(DbGoTop())

Cabec1 := "REFERENCIA            DESCRICAO / CAPACIDADE                                                                      MARCA              LOCAL     LOCAL     DE        EM     PED.COMPRA PED.VENDAS    COMPRAR        VALOR"
Cabec2 := "                                                                                                                                        01        02  TERCEIRO  TERCEIRO                                              "
//         XXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  XXXXXXXXXXXXXX  9,999.99  9,999.99  9,999.99  9,999.99    9,999.99   9,999.99   9,999.99   999,999.99
//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//

SetRegua(100)

SB2->(DbSetOrder(1))
SB1->(DbSetOrder(1))                       // OCIMAR
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
		SB1->(DbSeek(xFilial("SB1")+QR1->CODIGO))  // OCIMAR
		_nQtd01 := 0
		If SB2->(DbSeek(xFilial("SB2")+QR1->CODIGO+"01"))
			_nQtd01 := SB2->B2_QATU-SB2->B2_QPEDVEN      
			_nQtd01 := iif(_nQtd01 < 0,0,_nQtd01)		
		EndIf
//		_nValor := (QR1->COMPRA*SB1->B1_UPRC)
		_nValor := (QR1->COMPRA*SB1->B1_AXCUS)          // OCIMAR 11/10/09

		@ nLin,000 Psay QR1->REFERENCIA
		@ nLin,022 Psay Alltrim(QR1->PRODUTO) + " - " + Alltrim(QR1->CAPACIDADE)
		@ nLin,114 Psay QR1->MARCA
        @ nLin,130 Psay _nQtd01 Picture "@e 9,999.99" 
		@ nLin,140 Psay Transform(QR1->ESTOQUE		,"@e 9,999.99")
		@ nLin,150 Psay Transform(QR1->TERCEIROS	,"@e 9,999.99")		
		@ nLin,160 Psay Transform(QR1->EM_TERC		,"@e 9,999.99")				
		@ nLin,172 Psay Transform(QR1->PED_PEND		,"@e 9,999.99")
		@ nLin,183 Psay Transform(QR1->PED_VEN		,"@e 9,999.99")
		@ nLin,194 Psay Transform(QR1->COMPRA		,"@e 9,999.99")
		@ nLin,205 Psay Transform(_nValor			,"@e 999,999.99")
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
	@ nLin,205 Psay Transform(_nTotMarca	,"@e 999,999.99")
	nLin+=2
	_nTotGeral += _nTotMarca
EndDo

QR1->(DbCloseArea())

If _nTotGeral > 0
	nLin++
	@ nLin,000 Psay "T O T A L   G E R A L    ----------------- > "
	@ nLin,205 Psay Transform(_nTotGeral	,"@e 999,999.99")
EndIf

SET DEVICE TO SCREEN

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return
