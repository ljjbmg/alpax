/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR004   ºAutor  ³Adriano Luis Brandaoº Data ³  14/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do pedido de vendas.                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FATR004()

Private cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2         := "do pedido posicionado"
Private cDesc3         := ""
Private cPict          := ""
Private titulo       := "PEDIDO NR. "
Private nLin         := 80

Private Cabec1       := ""
Private Cabec2       := ""
Private imprime      := .T.
Private aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 220
Private tamanho          := "G"
Private nomeprog         := "FATR004"
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "FATR004"
Private cString := "SC5"

_aArea := GetArea()
_aAreaC5 := SC5->(GetArea())
_aAreaC6 := SC6->(GetArea())
_aAreaF4 := SF4->(GetArea())
_aAreaB1 := SB1->(GetArea())
_aAreaE4 := SE4->(GetArea())

dbSelectArea("SC5")
dbSetOrder(1)

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| _fImprime()})

RestArea(_aAreaC5)
RestArea(_aAreaC6)
RestArea(_aAreaF4)
RestArea(_aAreaB1)
RestArea(_aAreaE4)
RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprime ºAutor  ³Adriano Luis Brandaoº Data ³  22/10/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao do relatorio.                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fImprime()


SetRegua(len(aCols))

Cabec1 	:= ""
Cabec2 	:= ""
Titulo 	:= Alltrim(Titulo) + SC5->C5_NUM
_nTotal	:= 0

SA1->(dbSetOrder(1))
SB1->(DbSetOrder(1))
SE4->(dbSetOrder(1))
SC6->(DbSetOrder(1))

SC6->(DbSeek(xFilial("SC6")+SC5->C5_NUM,.T.))

Do While  ! SC6->(Eof()) .And. SC6->C6_FILIAL == xFilial("SC6") .And. ;
	SC6->C6_NUM == SC5->C5_NUM
	
	IncRegua()
	If nLin > 55
		_fCabec()
	Endif
	
	SB1->(DbSeek(xFilial("SB1")+SC6->C6_PRODUTO))
	
	_nTotalIt := SC6->C6_VALOR * (1+(SB1->B1_IPI/100))
	
	@ nLin,000 Psay SC6->C6_ITEM
	@ nLin,003 PSAY SB1->B1_PNUMBER
	@ nLin,024 PSAY SB1->B1_DESC
	@ nLin,100 PSAY SB1->B1_CAPACID
	@ nLin,116 PSAY SB1->B1_MARCA
	@ nLin,132 PSAY SB1->B1_UM
	@ nLin,135 PSAY SC6->C6_QTDVEN		PICTURE TM(SC6->C6_QTDVEN,10,2)
	@ nLin,146 PSAY SC6->C6_PRCVEN		PICTURE TM(SC6->C6_PRCVEN,14,2)
	@ nLin,167 PSAY _nTotalIt			PICTURE TM(SC6->C6_VALOR ,18,2)
	@ nLin,188 PSAY DTOC(SC6->C6_ENTREG)
	@ nLin,203 PSAY SC6->C6_AXRISCO	
	nLin++
	_nTotal += _nTotalIt
	SC6->(DbSkip())
EndDo

If _nTotal > 0
	If nLin > 52
		_fCabec()
	Endif
	@ nLin,000 Psay __PrtThinLine()
	nLin++
	@ nLin,000 Psay "Total do Pedido  -------->"
	@ nLin,167 PSAY _nTotal PICTURE "@e 999,999,999,999.99"
	nLin++
	@ nLin,000 Psay __PrtThinLine()
	nLin++
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCabec   ºAutor  ³Adriano Luis Brandaoº Data ³  22/10/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do cabecalho do relatorio.            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fCabec()

nLin:= Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
nLin++
@ nLin,000 Psay SM0->M0_NOMECOM
nLin++
@ nLin,000 Psay Alltrim(SM0->M0_ENDENT) + " - " + Alltrim(SM0->M0_CIDENT) + " - " + Alltrim(SM0->M0_ESTENT) + ;
" - CEP:" + SM0->M0_CEPENT
nLin++
@ nLin,000 Psay "Telefone:(0xx11)"
@ nLin,017 Psay Alltrim(SM0->M0_TEL) Picture "@R 9999-9999"
@ nLin,036 Psay "CNPJ:"
@ nLin,041 Psay SM0->M0_CGC Picture "@R 99.999.999/9999-99"
@ nLin,080 Psay "INSCR.ESTADUAL:" + SM0->M0_INSC
nLin++
@ nLin,000 Psay __PrtFatLine()

/* Customização imprime fornecer no Pedido de venda */

if C5_TIPO == "B"	

nLin+=2
SA2->(DbSeek(xFilial("SA2")+SC5->C5_CLIENTE+SC5->C5_LOJACLI))
SE4->(DbSeek(xFilial("SE4")+SC5->C5_CONDPAG))
@ nLin,000 Psay "Cliente: " + SA2->A2_COD + "/" + SA2->A2_LOJA + " - " +SA2->A2_NOME

ELSE

nLin+=2
SA1->(DbSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI))
SE4->(DbSeek(xFilial("SE4")+SC5->C5_CONDPAG))
@ nLin,000 Psay "Cliente..: " + SA1->A1_COD + "/" + SA1->A1_LOJA + " - " +SA1->A1_NOME

ENDIF






nLin+=2
@ nLin,000 Psay "Cond.Pag.: " + SC5->C5_CONDPAG+" - "+SE4->E4_DESCRI
@ nLin,140 Psay "Valor Frete......:" + Transform(SC5->C5_FRETE,"@e 999,999.99")
nLin+=2
_cNomeVen	:= Posicione("SA3",1,xFilial("SA3")+SC5->C5_VEND1,"A3_NOME")
_cNomeAte	:= UsrRetName(SC5->C5_AXATEN1)
@ nLin,000 Psay "Vendedor.: " + iif(empty(_cNomeVen),"",_cNomeVen)
@ nLin,140 Psay "Contato Cliente..:" + SA1->A1_CONTATO
nLin+=2
@ nLin,000 Psay "Atendente: " + iif(Empty(_cNomeAte),"",_cNomeAte)
nLin+=2 
@nLin, 000 Psay "Observacao: Os produtos com CLASSE DE RISCO INCOMPATIVEIS serao faturados em NOTAS FISCAIS SEPARADAS"
nLin+=2
@ nLin,000 Psay __PrtFatLine()
nLin++
@ nLin,000 Psay "It Part Number          Descricao                                                                   Capacidade      Marca           UN Quantidade    Preco Venda   %IPI              Total  Prz.Entrega    C. Risco"
//               XX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XX                            99.99                     99/99/9999
//               01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//
nLin++
@ nLin,000 Psay __PrtFatLine()
nLin++

Return  