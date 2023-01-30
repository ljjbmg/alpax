/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR01A   บAutor  ณOcimar Rolli        บ Data ณ  31/10/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para geracao do relatorio de ordem de separacao e   บฑฑ
ฑฑบ          ณ ordem de conferencia.                                      บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบalteracao ณ                                                            บฑฑ
ฑฑบem        ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบ23/08/09  ณAlterado para funcionar a partir de agora pelo numero de    บฑฑ
ฑฑบ(Adriano) ณpedido inicial e final e nao mais por nota fiscal.          บฑฑ
ฑฑบ31/10/09  ณAlterado para aglutinar os produtos para o faturamento.     บฑฑ
ฑฑบ(Ocimar)  ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Rwmake.ch"
#Include "Topconn.ch"

User function FATR01A()


private cDesc1         	:= "Este programa tem como objetivo imprimir relatorio "
private cDesc2         	:= "de ordem de separacao / conferencia."
private cDesc3         	:= ""
private cPict          	:= ""
private titulo       	:= "Relatorio separacao / conferencia."
private nLin         	:= 80

private Cabec1       	:= ""
private Cabec2       	:= ""
private imprime      	:= .T.
private aOrd := {}
Private lEnd         	:= .F.
Private lAbortPrint  	:= .F.
Private CbTxt        	:= ""
Private limite          := 220
Private tamanho         := "G"
Private nomeprog        := "RFATR01A"
Private nTipo           := 18
Private aReturn         := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 2}
Private nLastKey        := 0
Private cbtxt      		:= Space(10)
Private cbcont     		:= 00
Private CONTFL     		:= 01
Private m_pag      		:= 01
Private wnrel      		:= "FATR01A"
Private cString 		:= "SD2"
Private cPerg			:= "AXFT01"
//
// Criacao das perguntas a serem utilizadas no relatorio.
//
_fCriaSx1()

Pergunte(cPerg,.T.)

dbSelectArea("SD2")
dbSetOrder(1)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.T.,Tamanho,,.f.)

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
ฑฑบPrograma  ณ_fImprime บAutor  ณAdriano Luis Brandaoบ Data ณ  25/06/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao.                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fImprime()

Tamanho := "G"
Limite	:= 220

//	           CODIGO PRODUTO  PART NUMBER          DESCRICAO DO PRODUTO                                                        MARCA             CAPACIDADE      UN QUANTIDADE AR LOTE       VALIDADE  NF  "
//             XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX                XX              XX 9999
//             01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22

//Cabec1 := "CODIGO PRODUTO  PART NUMBER          DESCRICAO DO PRODUTO                                                    MARCA           CAPACIDADE      UN QUANTIDADE AR LOTE       VALIDADE   N.F."
Cabec1 := "CODIGO PRODUTO  PART NUMBER          DESCRICAO DO PRODUTO                                                        MARCA             CAPACIDADE      UN QUANTIDADE AR LOTE       VALIDADE  PEDIDO CLASSE"
Cabec2 := ""
//         XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XX 999,999.99 XX XXXXXXXXXX XX/XX/XXXX XXXXXX
//         0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19
//


_cQuery := "SELECT COUNT(*) AS TOTAL "
_cQuery += "FROM " + RetSqlName("SC9") + " C9 "
_cQuery += "     WHERE C9_FILIAL = '" + xFilial("SC9") + "' AND C9_SERIENF = ' ' AND C9_NFISCAL = ' ' "
_cQuery += "           AND C9_PEDIDO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "           AND D_E_L_E_T_ = ' ' AND C9_BLEST = ' ' AND C9_BLCRED = ' ' "

TcQuery _cQuery New Alias "QR1"

_nRegua := QR1->TOTAL

QR1->(DbCloseArea())

SA1->(DbSetOrder(1))
SA2->(DbSetOrder(1))
SA4->(DbSetOrder(1))

//
// ORDEM DE SEPARACAO
//

If MV_PAR03 == 1 .or. MV_PAR03 == 3
	
	Titulo := "ORDEM DE SEPARACAO"
	
	_cQuery := "SELECT C9_PRODUTO, B1_DESC, B1_UM, C9_QTDLIB, C9_LOCAL, C9_ENDPAD, C9_LOTECTL, C9_DTVALID, C9_PEDIDO, "
	_cQuery += "       B1_MARCA, B1_CAPACID, B1_PNUMBER , B1_UM , B1_AXRISCO, C9.R_E_C_N_O_ "
	_cQuery += "FROM " + RetSqlName("SC9") + " C9 "
	_cQuery += "       INNER JOIN " + RetSqlName("SC6") + " C6 "
	_cQuery += "               ON C6_FILIAL = '" + xFilial("SC6") + "' AND C6_NUM = C9_PEDIDO AND C6_ITEM = C9_ITEM "
	_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 "
	_cQuery += "               ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = C9_PRODUTO "
	_cQuery += " 	   INNER JOIN " + RetSqlName("SF4") + " F4 "
	_cQuery += "               ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = C6_TES "
	_cQuery += "WHERE  C9_FILIAL = '" + xFilial("SC9") + "' AND C9_BLEST = ' ' AND C9_BLCRED = ' ' AND C9_SERIENF = ' ' AND C9_NFISCAL = ' ' "
	_cQuery += "       AND C9_PEDIDO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' AND C9_XSEPARA = ' ' AND F4_ESTOQUE = 'S' "
	_cQuery += "       AND C9.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' "
	_cQuery += "ORDER BY B1_MARCA, B1_PNUMBER "
	
	
	_cQuery := ChangeQuery(_cQuery)
	TcQuery _cQuery New Alias "QR1"
	
	TcSetField("QR1","C9_QTDLIB"		,"N",12,2)
	TcSetField("QR1","C9_DTVALID"		,"D",08,0)
	
	SetRegua(_nRegua)
	nLin	:= 80
	
	QR1->(DbGoTop())
	Do While ! QR1->(EOF())
		
		IncRegua()
		If lEnd
			@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		If nLin > 54
			nLin := Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
			nLin++
		Endif
		
		//	           CODIGO PRODUTO  PART NUMBER          DESCRICAO DO PRODUTO                                                        MARCA             CAPACIDADE      UN QUANTIDADE AR LOTE       VALIDADE  NF     CLASSE"
		//             XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX                XX              XX 9999
		//             01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		//                       1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
		
		@ nLin,000 Psay QR1->C9_PRODUTO
		@ nLin,016 Psay QR1->B1_PNUMBER
		@ nLin,037 Psay QR1->B1_DESC
		@ nLin,113 Psay QR1->B1_MARCA
		@ nLin,131 Psay QR1->B1_CAPACID
		@ nLin,147 Psay QR1->B1_UM
		@ nLin,150 Psay QR1->C9_QTDLIB Picture "@e 999,999.99"
		@ nLin,161 Psay QR1->C9_LOCAL
		@ nLin,164 Psay QR1->C9_LOTECTL
		@ nLin,175 Psay QR1->C9_DTVALID
		@ nLin,185 Psay QR1->C9_PEDIDO
		@ nLin,192 Psay QR1->B1_AXRISCO
		nLin++
		@ nLin,000 Psay __PrtThinLine()
		nLin++
		// Gravacao de flag de relatorio ja impresso.
		SC9->(DbGoTo(QR1->R_E_C_N_O_))
		RecLock("SC9",.f.)
		SC9->C9_XSEPARA := "1"
		SC9->(MsUnLock())
		
		QR1->(DbSkip())
	EndDo
	
	QR1->(DbCloseArea())
	
EndIf

//
// ORDEM DE CONFERENCIA
//


If MV_PAR03 == 2 .or. MV_PAR03 == 3
	
	Cabec1 := "CODIGO PRODUTO  PART NUMBER          DESCRICAO DO PRODUTO                                                        MARCA             CAPACIDADE      UN QUANTIDADE AR LOTE       VALIDADE       CLASSE    PEDIDO  CONT"
	Cabec2 := ""
	//         XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XX 999,999.99 XX XXXXXXXXXX XX/XX/XXXX
	//
	//         01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	//                   1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	//
	
	_cQuery := "SELECT C9_PRODUTO, C9_AGREG, B1_DESC, B1_UM, C9_QTDLIB, C9_LOCAL, C9_ENDPAD, C9_LOTECTL, C9_DTVALID, C9_PEDIDO, C9_CLIENTE, C9_LOJA,"
	_cQuery += "       B1_MARCA, B1_CAPACID, B1_PNUMBER, C5_TRANSP, C5_TIPO, C5_CONDPAG, B1_AXRISCO, C9.R_E_C_N_O_ , convert(char(7), C9.r_e_c_n_o_) AS REG, "
	_cQuery += "       C5_TPFRETE, C5_AXATEND "
	_cQuery += "FROM " + RetSqlName("SC9") + " C9 "
	_cQuery += "     INNER JOIN " + RetSqlName("SC6") + " C6 "
	_cQuery += "             ON C6_FILIAL = '" + xFilial("SC6") + "' AND C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM "
	_cQuery += "     INNER JOIN " + RetSqlName("SB1") + " B1 "
	_cQuery += "             ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = C9_PRODUTO "
	_cQuery += "     INNER JOIN " + RetSqlName("SF4") + " F4 "
	_cQuery += "             ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = C6_TES "
	_cQuery += "     INNER JOIN " + RetSqlName("SC5") + " C5 "
	_cQuery += "             ON C5_FILIAL = '" + xFilial("SC5") + "' AND C5_NUM = C9_PEDIDO "
	_cQuery += "     WHERE C9_FILIAL = '" + xFilial("SC9") + "' AND C9_BLEST = ' ' AND C9_BLCRED = ' ' AND C9_SERIENF = ' ' AND C9_NFISCAL = ' ' "
	_cQuery += "           AND C9_PEDIDO BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
	_cQuery += "           AND C9_CLIENTE BETWEEN '" + MV_PAR04 + "' AND '" + MV_PAR05 + "' "
	_cQuery += "           AND C5_TRANSP BETWEEN '" + MV_PAR06 + "' AND '" + MV_PAR07 + "' "
	_cQuery += "           AND F4_ESTOQUE = 'S' AND C9.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' '"
	_cQuery += "           AND C5.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "
	_cQuery += "ORDER BY C9_CLIENTE, C9_LOJA, C5_TRANSP, C5_CONDPAG, C9_AGREG "
	
	
	TcQuery _cQuery New Alias "QR1"
	
	TcSetField("QR1","C9_QTDLIB"		,"N",12,2)
	TcSetField("QR1","C9_DTVALID"		,"D",08,0)
	TcSetField("QR1","REG"				,"C",07,0)	
	
	Titulo := "ORDEM DE CONFERENCIA CLIENTE "
	SetRegua(_nRegua)
	
	
	QR1->(DbGoTop())
	Do While ! QR1->(EOF())
		
		IncRegua()
		If lEnd
			@ nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
		
		nLin	:= 80
		
		_cNomeCli 	:= ""
		SA4->(DbSeek(xFilial("SA4")+QR1->C5_TRANSP))
		_cNomeTr	:= SA4->A4_NOME
		
		If QR1->C5_TIPO == "N"
			SA1->(DbSeek(xFilial("SA1")+QR1->C9_CLIENTE+QR1->C9_LOJA))
			_cNomeCli := SA1->A1_COD + "/" + SA1->A1_LOJA + " - " + SA1->A1_NOME
		Else
			SA2->(DbSeek(xFilial("SA2")+QR1->C9_CLIENTE+QR1->C9_LOJA))
			_cNomeCli := SA2->A2_COD + "/" + SA2->A2_LOJA + " - " + SA2->A2_NOME
		EndIf
		
		_cQuery := "SELECT COUNT(*) AS TOTAL "
		_cQuery += "       FROM " + RetSqlName("SC9") + " C9 "
		_cQuery += "       WHERE C9_FILIAL = '" + xFilial("SC9") + "' "
		_cQuery += "             AND C9_PEDIDO = '" + QR1->C9_PEDIDO + "' AND C9_BLEST = ' ' AND C9_BLCRED = ' ' AND D_E_L_E_T_ = ' ' "
		
		TcQuery _cQuery New Alias "QR2"
		
		_nItens := QR2->TOTAL
		
		QR2->(DbCloseArea())
		
		_lPrimeiro := .t.
		_nItem := 0
		
		_cCliente 	:= QR1->C9_CLIENTE+QR1->C9_LOJA
		
		
		Do While ! QR1->(Eof()) .And. _cCliente == (QR1->C9_CLIENTE+QR1->C9_LOJA)
			If nLin > 54
				If ! _lPrimeiro
					@ nLin,050 Psay "N๚mero de itens na Pagina : " + Str(_nItem,2)  // + "/" + Str(_nItens,3)
					nLin++
				EndIf
				_nItem := 0
				
				Titulo2 := Titulo + _cNomeCli
				nLin := Cabec(Titulo2,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
				nLin += 2
				@ nLin,000 Psay iif(QR1->C5_TIPO=="N","Cliente: ","Fornecedor: ") + _cNomeCli
				nLin++
				@ nLin,000 Psay "Transportadora: " + _cNomeTr
				@ nLin,113 Psay "Tipo Frete: " + iif(QR1->C5_TPFRETE=="C","CIF","FOB")
				@ nLin,175 Psay "Vendedor: " + QR1->C5_AXATEND
				nLin+=2
				_lPrimeiro := .f.				
				Endif
			
			_cTransp	:= QR1->C5_TRANSP
			_cCond		:= QR1->C5_CONDPAG
			_cRisco		:= QR1->B1_AXRISCO
			_cAgreg     := QR1->REG
			
			Do While ! QR1->(Eof()) .And. _cCliente == (QR1->C9_CLIENTE+QR1->C9_LOJA) .And.;
				_cTransp == QR1->C5_TRANSP .And. _cCond == QR1->C5_CONDPAG .And. QR1->B1_AXRISCO == _cRisco
				
				If nLin > 54
					If ! _lPrimeiro
						@ nLin,050 Psay "N๚mero de itens na Pagina : " + Str(_nItem,2) + "/" + Str(_nItens,3)
						nLin++
					EndIf
					_nItem := 0
					
					Titulo2 := Titulo + _cNomeCli
					nLin := Cabec(Titulo2,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
					nLin += 2
					@ nLin,000 Psay iif(QR1->C5_TIPO=="N","Cliente: ","Fornecedor: ") + _cNomeCli
					nLin++
					@ nLin,000 Psay "Transportadora: " + _cNomeTr
					nLin+=2
					_lPrimeiro := .f.
				Endif
				
				_nItem++
				
				@ nLin,000 Psay QR1->C9_PRODUTO
				@ nLin,016 Psay QR1->B1_PNUMBER
				@ nLin,037 Psay QR1->B1_DESC
				@ nLin,113 Psay QR1->B1_MARCA
				@ nLin,131 Psay QR1->B1_CAPACID
				@ nLin,147 Psay QR1->B1_UM
				@ nLin,150 Psay QR1->C9_QTDLIB Picture "@e 999,999.99"
				@ nLin,161 Psay QR1->C9_LOCAL
				@ nLin,164 Psay QR1->C9_LOTECTL
				@ nLin,175 Psay QR1->C9_DTVALID
				If Substr(QR1->B1_AXRISCO,1,1) $ "8"
					@ nLin,190 Psay iif(Substr(QR1->B1_DESC,1,5) $ "ACIDO",(rTrim(QR1->B1_AXRISCO) + " ACIDO"),(rTrim(QR1->B1_AXRISCO) + " BASE"))
				Else
					@ nLin,190 Psay QR1->B1_AXRISCO
				EndIf
				@ nLin,200 Psay QR1->C9_PEDIDO
				@ nLin,208 Psay SUBSTR(_cAgreg,4,4)
				nLin++
				// Gravacao de flag de relatorio ja impresso e agrega็ใo dos produtos.
				SC9->(DbGoTo(QR1->R_E_C_N_O_))
				RecLock("SC9",.f.)
				SC9->C9_XSEPARA := '2'
				SC9->C9_AGREG   := SUBSTR(_cAgreg,4,4)
				SC9->C9_AXDTIMP := dDataBase
				SC9->C9_AXHRIMP := Transform(Time(),"99:99:99")
				SC9->(MsUnLock())
				
				QR1->(DbSkip())
			EndDo
			nLin++
			@ nLin,000 Psay __PrtThinLine()
			nLin++
		
		EndDo
		If ! _lPrimeiro
			@ nLin,050 Psay "N๚mero de itens na Pagina : " + Str(_nItem,2) //+ "/" + Str(_nItens,3)
			nLin++
		EndIf
		
		@ 54,000 Psay "Separado  por :  "
		@ 54,120 Psay "Conferido por :  "
		@ 55,000 Psay __PrtThinLine()
		@ 59,000 Psay "Observacoes   :  "
		@ 60,000 Psay __PrtThinLine()
		// Soma 1 para diferenciar o grupo de produtos na nota
		
	EndDo
	
	QR1->(DbCloseArea())
	
EndIf

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
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณAdriano Luis Brandaoบ Data ณ  25/06/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas do relatorio.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fCriaSx1()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Da Pedido                      ณ
//ณMV_PAR02 = Ate Pedido                     ณ
//ณMV_PAR03 = O.Separacao/O.Conferencia/Ambosณ
//ณMV_PAR04 = Cliente de                     ณ
//ณMV_PAR05 = Cliente ate                    ณ
//ณMV_PAR06 = Transportadora de              ณ
//ณMV_PAR07 = Transportadora ate             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","Do Pedido","Do Pedido","Da Nota Fiscal","mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Ate Pedido","Ate Pedido","Ate Pedido","mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Tipo","Tipo","Tipo","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Ordem Separacao","Ordem Separacao","Ordem Separacao","","Ordem Conferenc","Ordem Conferenc","Ordem Conferenc","Ambos","Ambos","Ambos","","","","","","",,,)
PutSx1(cPerg,"04","Cliente de ","Cliente de ","Cliente de ","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Cliente ate ","Cliente ate ","Cliente ate ","mv_ch5","C",06,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"06","Transportadora de ","Transportadora de ","Transportadora de ","mv_ch6","C",06,0,0,"G","","SA4","","","mv_par06","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"07","Transportadora ate","Transportadora ate","Transportadora ate","mv_ch7","C",06,0,0,"G","","SA4","","","mv_par07","","","","","","","","","","","","","","","","",,,)

Return
