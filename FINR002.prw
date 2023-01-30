#Include "TopConn.ch"
#Include "RWMAKE.Ch"
#Include "Protheus.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FINR002  บAutor  ณOcimar Rolli        บ Data ณ  02/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Relatorio de Duplicatas Contas a Receber em Modo Grafico  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ  Alpax Com. Produtos p/ laboratorios ltda.                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FINR002()
Private oFont, cCode, oPrn
Private cCGCPict, cCepPict
Private lPrimPag    :=.t.
Private cNumero     := ""
Private cFornece    := ""
Private cLoja       := ""
Private lEnc        := .f.
Private nPag        := 0
Private cPerg		:= "FINR02"
Private nCont       := 1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01	     	  Do Titulo                              ณ
//ณ mv_par02	     	  Ate Titulo  		                     ณ
//ณ mv_par03	     	  Prefixo   	                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

_fCriaSx1()

If !Pergunte(cPerg,.T.)
	Return
EndIF

RptStatus({|| fLeitura()})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfLeitura  บAutor  ณOcimar Rolli        บ Data ณ  02/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fLeitura()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefinir as pictures                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cCepPict:=PesqPict("SA1","A1_CEP")
cCGCPict:=PesqPict("SA1","A1_CGC")

Private oFont1 := TFont():New( "Arial",,16,,.t.,,,,,.f. )
Private oFont2 := TFont():New( "Arial",,16,,.f.,,,,,.f. )
Private oFont3 := TFont():New( "Arial",,10,,.t.,,,,,.f. )
Private oFont4 := TFont():New( "Arial",,10,,.f.,,,,,.f. )
Private oFont5 := TFont():New( "Arial",,06,,.t.,,,,,.f. )
Private oFont6 := TFont():New( "Arial",,08,,.f.,,,,,.f. )
Private oFont7 := TFont():New( "Arial",,14,,.t.,,,,,.f. )
Private oFont8 := TFont():New( "Arial",,14,,.f.,,,,,.f. )
Private oFont9 := TFont():New( "Arial",,12,,.t.,,,,,.f. )
Private oFont10:= TFont():New( "Arial",,12,,.f.,,,,,.f. )

Private oFont1c := TFont():New( "Courier New",,16,,.t.,,,,,.f. )
Private oFont2c := TFont():New( "Courier New",,16,,.f.,,,,,.f. )
Private oFont3c := TFont():New( "Courier New",,10,,.t.,,,,,.f. )
Private oFont4c := TFont():New( "Courier New",,10,,.f.,,,,,.f. )
Private oFont5c := TFont():New( "Courier New",,09,,.t.,,,,,.f. )
Private oFont6c := TFont():New( "Courier New",,09,,.T.,,,,,.f. )
Private oFont7c := TFont():New( "Courier New",,14,,.t.,,,,,.f. )
Private oFont8c := TFont():New( "Courier New",,14,,.f.,,,,,.f. )
Private oFont9c := TFont():New( "Courier New",,12,,.t.,,,,,.f. )
Private oFont10c:= TFont():New( "Courier New",,12,,.f.,,,,,.f. )

li       := 1700
m_pag    := 1
nPag     := 0

cqry :="SELECT  E1_NUM, E1_VALOR, E1_PARCELA, E1_EMISSAO, E1_VENCTO, A1_NOME, A1_COD, A1_END, A1_MUN, E1_PREFIXO, A1_LOJA, E1_TIPO "
cqry +="        , A1_EST, A1_CEP, A1_CGC, A1_BAIRRO, A1_TEL, A1_ENDCOB, A1_BAIRROC, A1_MUNC, A1_ESTC, A1_CEPC, A1_INSCR "
cqry +="  FROM SE1010 SE1 "
cqry +="  INNER JOIN SA1010 SA1 "
cqry +="        ON SE1.E1_CLIENTE = SA1.A1_COD "
cqry +="  WHERE SE1.E1_NUM BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND E1_PREFIXO = '"+MV_PAR03+"' AND E1_TIPO = '"+MV_PAR04+"' AND SE1.D_E_L_E_T_ = ' ' "
cqry +="  ORDER BY E1_NUM, E1_PARCELA "

MEMOWRIT("D:\A\SQL_LC.AQL",cqry)
TcQuery cqry New Alias "QR1"

TcSetField("QR1","A1_COD"     ,"C",06,0)
TcSetField("QR1","E1_VALOR"   ,"N",12,2)
TcSetField("QR1","E1_EMISSAO" ,"D",08,0)
TcSetField("QR1","E1_VENCTO"  ,"D",08,0)

SD2->(DbSetOrder(3))
SF4->(DbSetOrder(1))

QR1->(DbGoTop())

While QR1->(!Eof())
	
	_cEndCob := (AllTrim(QR1->A1_ENDCOB)+" - "+AllTrim(QR1->A1_BAIRROC)+" - "+AllTrim(QR1->A1_MUNC)+" - "+;
	AllTrim(QR1->A1_ESTC)+" - "+AllTrim(QR1->A1_CEPC))
	
	If QR1->E1_TIPO == 'NCC'
		SD1->(DbSeek(xFilial("SD1")+QR1->E1_NUM+QR1->E1_PREFIXO,.T.))
	Else
		SD2->(DbSeek(xFilial("SD2")+QR1->E1_NUM+QR1->E1_PREFIXO,.T.))
	EndIf 
	
	If QR1->E1_TIPO == 'NCC'
		SF4->(DbSeek(xFilial("SF4")+SD1->D1_TES))
	Else
		SF4->(DbSeek(xFilial("SF4")+SD2->D2_TES))
	EndIf
	
	If nCont > 1
		li := 1600
		nCont := 0
	Else
		li := 0
	Endif
	
	ImpDupl()
	
	nCont++
	
	dbSkip()
	
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se em disco, desvia para Spool                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If lEnc
	oPrn:Preview()
	MS_FLUSH()
EndIf

Return(nil)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ ImpDupl  ณ Autor ณ Ocimar Rolli         ณ Data ณ 02/04/14 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Imprime as Duplicatas					                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ R150Imp                                                    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ImpDupl()

cMoeda := "1"
nPag++

If lPrimPag
	lPrimPag := .f.
	lEnc     := .t.
	oPrn  := TMSPrinter():New()
	oPrn:Setup()
EndIF

//	SD2->(DbSeek(xFilial("SD2")+cFatura+MV_PAR02,.T.))
//	cCfop := SD2->D2_CF
//	SF4->(DbSeek(xFilial("SF4")+SD2->D2_TES))
//	cTexto := SF4->F4_TEXTO

oPrn:Say( li, 0020, " ",oFont,100 ) // startando a impressora

//Cabecalho (Enderecos da Empresa e Fornecedor)
oPrn:Box( 0050 + li, 0020, 1600 + li,2330) // Box Total
oPrn:Line(0300 + li, 0020, 0300 + li,1900) // Linha cabecalho inc est
oPrn:Line(0200 + li, 1400, 0200 + li,1900) // Linha cab cnpj
oPrn:Line(0400 + li, 0020, 0400 + li,2330) // Linha Natureza horiz
oPrn:Line(0300 + li, 0600, 0400 + li,0600) // Linha Natureza vert
oPrn:Line(0300 + li, 0900, 0400 + li,0900) // Linha cfop vert
oPrn:Line(0050 + li, 1400, 0400 + li,1400) // Linha Duplicata
oPrn:Line(0050 + li, 1900, 0400 + li,1900) // Linha mensagem vencimento
oPrn:SayBitmap(0060 + li,0050,"\system\logo_alpax.bmp",400,150)
oPrn:Say( 0070 + li, 0600, "ALPAX COM. DE PRODUTOS P/ LABORATำRIOS LTDA."              ,oFont5 ,100 )
oPrn:Say( 0120 + li, 0660, "TEL.:(11) 4057-9200 - FAX: 4058-9204"                      ,oFont5 ,100 )
oPrn:Say( 0170 + li, 0600, "e-mail: alpax@alpax.com.br - site: www.alpax.com.br"       ,oFont5 ,100 )
oPrn:Say( 0250 + li, 0520, "RUA SERRA DE BORBOREMA, 40 - CEP 09930-580 - DIADEMA - SP" ,oFont5 ,100 )
oPrn:Say( 0310 + li, 0030, "NATUREZA DA OPERAวรO"                                      ,oFont5 ,100 )
oPrn:Say( 0350 + li, 0030, SF4->F4_TEXTO                                               ,oFont3c,100 )
oPrn:Say( 0310 + li, 0610, "C.F.O.P."                                                  ,oFont5 ,100 )
oPrn:Say( 0350 + li, 0610, iif(QR1->E1_TIPO == 'NCC',SD1->D1_CF,SD2->D2_CF)            ,oFont3c,100 )
oPrn:Say( 0310 + li, 0910, "INSC. EST. DO SUBS. TRIB."                                 ,oFont5 ,100 )
oPrn:Say( 0080 + li, 1500, "DUPLICATA"                                                 ,oFont7c,100 )
oPrn:Say( 0210 + li, 1410, "CNPJ"                                                      ,oFont5 ,100 )
oPrn:Say( 0250 + li, 1420, "65.838.344/0001-10"                                        ,oFont9c,100 )
oPrn:Say( 0310 + li, 1410, "INSCRIวรO ESTADUAL"                                        ,oFont5 ,100 )
oPrn:Say( 0350 + li, 1450, "286.100.047.111"                                           ,oFont9c,100 )
oPrn:Say( 0140 + li, 1930, "APำS O VENCIMENTO",oFont4,100 )
oPrn:Say( 0190 + li, 1930, " SERรO  COBRADOS ",oFont4,100 )
oPrn:Say( 0240 + li, 1930, " JUROS BANCARIOS ",oFont4,100 )

// Cabe็alho dos dados do cliente
oPrn:Box( 0420 + li, 0020, 0720 + li,2330) // Box Razใo Social
oPrn:Say( 0430 + li, 0030, "NOME / RAZรO SOCIAL"                                       ,oFont5 ,100 )
oPrn:Say( 0470 + li, 0030, QR1->A1_NOME                                                ,oFont3c,100 )
oPrn:Line(0520 + li, 0020, 0520 + li,2330) // Box Endere็o
oPrn:Say( 0530 + li, 0030, "ENDEREวO"                                                  ,oFont5 ,100 )
oPrn:Say( 0570 + li, 0030, QR1->A1_END                                                 ,oFont3c,100 )
oPrn:Line(0620 + li, 0020, 0620 + li,2330) // Box municipio
oPrn:Say( 0630 + li, 0030, "MUNICIPIO"                                                 ,oFont5 ,100 )
oPrn:Say( 0670 + li, 0030, QR1->A1_MUN                                                 ,oFont3c,100 )
oPrn:Line(0420 + li, 1400, 0520 + li,1400) // Linha cnpj
oPrn:Say( 0430 + li, 1410, "CNPJ"                                                      ,oFont5 ,100 )
oPrn:Say( 0470 + li, 1410, Transform(QR1->A1_CGC,cCgcPict)                             ,oFont3c,100 )
oPrn:Line(0420 + li, 1900, 0720 + li,1900) // Linha data de emissใo
oPrn:Say( 0430 + li, 1910, "DATA DE EMISSรO"                                           ,oFont5 ,100 )
oPrn:Say( 0470 + li, 1910, DtoC(QR1->E1_EMISSAO)                                       ,oFont3c,100 )
oPrn:Line(0520 + li, 1200, 0620 + li,1200) // Linha bairro
oPrn:Say( 0530 + li, 1210, "BAIRRO / DISTRITO"                                         ,oFont5 ,100 )
oPrn:Say( 0570 + li, 1210, QR1->A1_BAIRRO                                              ,oFont3c,100 )
oPrn:Line(0520 + li, 1600, 0620 + li,1600) // Linha cep
oPrn:Say( 0530 + li, 1610, "CEP"                                                       ,oFont5 ,100 )
oPrn:Say( 0570 + li, 1610, Left(QR1->A1_CEP,5)+"-"+Right(QR1->A1_CEP,3)                ,oFont3c,100 )
oPrn:Say( 0570 + li, 1910, (QR1->A1_COD+"/"+QR1->A1_LOJA)                              ,oFont3c,100 )
oPrn:Line(0620 + li, 1000, 0720 + li,1000) // Linha fone
oPrn:Say( 0630 + li, 1010, "FONE / FAX"                                                ,oFont5 ,100 )
oPrn:Say( 0670 + li, 1010, QR1->A1_TEL                                                 ,oFont3c,100 )
oPrn:Line(0620 + li, 1300, 0720 + li,1300) // Linha uf
oPrn:Say( 0630 + li, 1310, "U. F."                                                     ,oFont5 ,100 )
oPrn:Say( 0670 + li, 1310, QR1->A1_EST                                                 ,oFont3c,100 )
oPrn:Line(0620 + li, 1400, 0720 + li,1400) // Linha inscri็ใo estadual
oPrn:Say( 0630 + li, 1410, "INSCRIวรO ESTADUAL"                                        ,oFont5 ,100 )
oPrn:Say( 0670 + li, 1410, QR1->A1_INSCR                                               ,oFont3c,100 )

// Cabe็alho dos dados da duplicata
oPrn:Box( 0740 + li, 0020, 1140 + li,2330) // Box Duplicata
oPrn:Line(0840 + li, 0020, 0840 + li,1900) // Linha horiz endere็o
oPrn:Line(0940 + li, 0020, 0940 + li,2330) // Linha horiz valor por extenso
oPrn:Say( 0750 + li, 0030, "DATA DE EMISSรO"                                           ,oFont5 ,100 )
oPrn:Say( 0790 + li, 0030, DtoC(QR1->E1_EMISSAO)                                       ,oFont3c,100 )
oPrn:Line(0740 + li, 0400, 0840 + li,0400) // Box nf fstura
oPrn:Say( 0750 + li, 0410, "N. DA NOTA FISCAL FATURA"                                  ,oFont5 ,100 )
oPrn:Say( 0790 + li, 0410, QR1->E1_NUM                                                 ,oFont3c,100 )
oPrn:Line(0740 + li, 0720, 0840 + li,0720) // Box valor
oPrn:Say( 0750 + li, 0730, "VALOR"                                                     ,oFont5 ,100 )
oPrn:Say( 0790 + li, 0770, TransForm(QR1->E1_VALOR, "@E 999,999,999.99")               ,oFont3c,100 )
oPrn:Line(0740 + li, 1300, 0840 + li,1300) // Linha num. duplicata
oPrn:Say( 0750 + li, 1310, "N. DUPLICATA"                                              ,oFont5 ,100 )
oPrn:Say( 0790 + li, 1310, (QR1->E1_NUM+"/"+QR1->E1_PARCELA)                           ,oFont3c,100 )
oPrn:Line(0740 + li, 1600, 0840 + li,1600) // Linha vencimento
oPrn:Say( 0750 + li, 1610, "VENCIMENTO"                                                ,oFont5 ,100 )
oPrn:Say( 0790 + li, 1610, DtoC(QR1->E1_VENCTO)                                        ,oFont3c,100 )
oPrn:Say( 0750 + li, 2020, "PARA USO DA"                                               ,oFont5 ,100 )
oPrn:Say( 0780 + li, 1950, "INSTITUIวรO FINANCEIRA"                                    ,oFont5 ,100 )
oPrn:Line(0740 + li, 1900, 0940 + li,1900) // Linha endere็o de cobran็a
oPrn:Say( 0850 + li, 0030, "ENDEREวO DE COBRANวA / PRAวA DE PAGAMENTO"                 ,oFont5 ,100 )
oPrn:Say( 0890 + li, 0030, _cEndCob                                                    ,oFont3c,100 )
oPrn:Say( 0950 + li, 0030, "VALOR POR EXTENSO"                                         ,oFont5 ,100 )
cTexto := "(" + Extenso(QR1->E1_VALOR) + " )"

_cTexto1 := SubStr(cTexto,1,090)
_cTexto2 := SubStr(cTexto,091,090)
//_cTexto3 := SubStr(cTexto,141,070)

oPrn:Say( 0990 + li, 0030, _cTexto1                                                    ,oFont3c,100 )
oPrn:Say( 1040 + li, 0030, _cTexto2                                                    ,oFont3c,100 )
//oPrn:Say( 1090 + li, 0030, _cTexto3                                                    ,oFont3c,100 )

// Rodape da duplicata
oPrn:Box( 1160 + li, 0020, 1600 + li, 1000) // Box assinatura do emitente
oPrn:Box( 1160 + li, 1020, 1600 + li, 2330) // Box assinatura do sacado
oPrn:Line(1340 + li, 1020, 1340 + li, 2330) // Linha de data de aceite
oPrn:Line(1340 + li, 1340, 1600 + li, 1340) // Linha vert assinatura do sacado
oPrn:Say( 1360 + li, 1040, "DATA DO ACEITE"                                                                             ,oFont5,100 )
oPrn:Say( 1360 + li, 1360, "ASSINATURA DO SACADO"                                                                       ,oFont5,100 )
oPrn:Say( 1190 + li, 1040, "RECONHEวO(EMOS) A EXATIDรO DESTA DUPLICATA DE VENDA MERCANTIL, NA SUA IMPORTยNCIA ACIMA QUE",oFont5,100 )
oPrn:Say( 1240 + li, 1040, "PAGAREI(EMOS) ภ  ALPAX COM. DE PRODUTOS P/ LABORATำRIOS LTDA.,  OU  ภ  SUA  ORDEM  NA PRAวA",oFont5,100 )
oPrn:Say( 1290 + li, 1040, "E VENCIMENTOS INDICADOS"                                                                    ,oFont5,100 )
oPrn:Say( 1510 + li, 0080, "_________________________________________________________________________"                  ,oFont5,100 )
oPrn:Say( 1560 + li, 0370, "ASSINATURA DO EMITENTE"                                                                     ,oFont6,100 )

oPrn:Say( 1620 + li, 0020, Replicate("*",330)                                                                           ,oFont5,100 )

If li > 0
	oPrn:EndPage()
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณAdriano Luis Brandaoบ Data ณ  31/03/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Criacao de perguntas.                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fCriaSx1()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Da duplicata                   ณ
//ณMV_PAR02 = Ate duplicata                  ณ
//ณMV_PAR03 = Serie                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","Da Duplicata  ?","Da Duplicata  ?","Da Duplicata  ?","mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Ate Duplicata ?","Ate Duplicata ?","Ate Duplicata ?","mv_ch2","C",09,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Prefixo ?"      ,"Prefixo ?"      ,"Prefixo ?"      ,"mv_ch3","C",03,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Tipo ?"         ,"Tipo ?"         ,"Tipo ?"         ,"mv_ch4","C",03,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",,,)

Return
