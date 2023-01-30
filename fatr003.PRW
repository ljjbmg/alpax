/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR003   ºAutor  ³Adriano Luis Brandaoº Data ³  22/10/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para impressao do orcamento.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "rwmake.ch"

User Function FATR003() 

Private cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2         := "de orcamentos"
Private cDesc3         := ""
Private cPict          := ""
Private titulo       := "ORCAMENTO NR. "
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
Private nomeprog         := "FATR003"
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "FATR003"

Private cString := "SCJ"

dbSelectArea("SCJ")
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


SetRegua(RecCount())

Cabec1 	:= ""
Cabec2 	:= ""
Titulo 	:= Alltrim(Titulo) + SCJ->CJ_NUM
_nTotal	:= 0

SA1->(dbSetOrder(1))
SB1->(DbSetOrder(1))
SE4->(dbSetOrder(1))
SCK->(DbSetOrder(1))

SCK->(DbSeek(xFilial("SCK")+SCJ->CJ_NUM,.T.))

Do While  ! SCK->(Eof()) .And. SCK->CK_FILIAL == xFilial("SCK") .And. ;
	SCK->CK_NUM == SCJ->CJ_NUM
	
	If nLin > 55
		_fCabec()
	Endif
	
	SB1->(DbSeek(xFilial("SB1")+SCK->CK_PRODUTO))
	@ nLin,000 Psay SCK->CK_ITEM
	@ nLin,003 PSAY SB1->B1_PNUMBER
	@ nLin,024 PSAY SB1->B1_DESC
	@ nLin,100 PSAY SB1->B1_CAPACID
	@ nLin,116 PSAY SB1->B1_MARCA
	@ nLin,132 PSAY SB1->B1_UM
	@ nLin,135 PSAY SCK->CK_QTDVEN          PICTURE TM(SCK->CK_QTDVEN,10,2)
	@ nLin,146 PSAY SCK->CK_PRCVEN          PICTURE TM(SCK->CK_PRCVEN,14,2)
	@ nLin,160 PSAY SCK->CK_VALOR           PICTURE TM(SCK->CK_VALOR ,18,2)
	@ nLin,182 PSAY DTOC(SCK->CK_ENTREG)
	nLin++
	If ! Empty(SCK->CK_OBS)
		If nLin > 55
			_fCabec()
		Endif          
		@ nLin,003 Psay "Observacao Item " + SCK->CK_ITEM + "-->"
		@ nLin,024 Psay SCK->CK_OBS
		nLin++
	EndIf
	_nTotal += SCK->CK_VALOR
	SCK->(DbSkip())
EndDo

If _nTotal > 0
	If nLin > 52
		_fCabec()
	Endif
	@ nLin,000 Psay __PrtThinLine()
	nLin++
	@ nLin,000 Psay "Total do Orcamento ------>"
	@ nLin,165 PSAY _nTotal PICTURE "@e 99,999,999.99"
	nLin++
	@ nLin,000 Psay __PrtThinLine()
	nLin++
	@ nLin,000 Psay "Faturamento minimo R$.200,00"
	nLin++
	@ nLin,000 Psay 'Visite nosso Site "www.alpax.com.br"'
	//	@ nLin,000 Psay
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
nLin+=2
SA1->(DbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
SE4->(DbSeek(xFilial("SE4")+SCJ->CJ_CONDPAG))
@ nLin,000 Psay "Cliente..: " + SA1->A1_COD + "/" + SA1->A1_LOJA + " - " +SA1->A1_NOME
@ nLin,140 Psay "Validade Proposta:" + Dtoc(SCJ->CJ_VALIDA)
nLin+=2
@ nLin,000 Psay "Cond.Pag.: " + SCJ->CJ_CONDPAG+" - "+SE4->E4_DESCRI
@ nLin,140 Psay "Valor Frete......:" + Transform(SCJ->CJ_FRETE,"@e 999,999.99")
nLin+=2
_cNomeVen	:= Posicione("SA3",1,xFilial("SA3")+SCJ->CJ_AXVEND,"A3_NOME")
_cNomeAte	:= UsrRetName(SCJ->CJ_AXATEND)
@ nLin,000 Psay "Vendedor.: " + iif(empty(_cNomeVen),"",_cNomeVen)
@ nLin,140 Psay "Contato Cliente..:" + SA1->A1_CONTATO
nLin+=2
@ nLin,000 Psay "Atendente: " + iif(Empty(_cNomeAte),"",_cNomeAte)
nLin+=2
@ nLin,000 Psay __PrtFatLine()
nLin++
@ nLin,000 Psay "It Part Number          Descricao                                                                   Capacidade      Marca           UN Quantidade    Preco Venda              Total  Prz.Entrega"
//               XX XXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXX XX                                               99/99/9999
//               01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//
nLin++
@ nLin,000 Psay __PrtFatLine()
nLin++

Return