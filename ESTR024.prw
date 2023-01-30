/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR024   ºAutor  ³Ocimar Rolli        º Data ³  13/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de Ordem de servico interna da assistencia tecnicaº±±
±±º          ³por numero de nota fiscal                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function ESTR024()

_cPerg := "ESTR24"

PutSx1(_cPerg,"01","NOTA FISCAL" ,"NOTA FISCAL" ,"NOTA FISCAL" ,"mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr011() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr011  ºAutor  ³Ocimar Rolli        º Data ³  13/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de processamento do relatorio.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr011()

Private nColIni 	:= 0100
Private nColFim 	:= 2300
Private nRowIni		:= 0050
Private nRow        := nRowIni
Private nRowFim 	:= 3150
Private oPrint, _nItem, _nItens, nPag

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8CN	:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11N	:= TFont():New("Arial"			,09,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14 	:= TFont():New("Arial"			,13,14,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)

_cQuery := "SELECT SD1.D1_DTDIGIT, SD1.D1_DOC, SD1.D1_DTDIGIT, SD1.D1_EMISSAO, SA1.A1_NOME, SA1.A1_TEL, SB1.B1_PNUMBER, SB1.B1_DESC, SD1.D1_ITEM, "
_cQuery += "       RTRIM(SA1.A1_END)+' - '+RTRIM(SA1.A1_BAIRRO)+' - '+RTRIM(SA1.A1_MUN)+' - '+RTRIM(SA1.A1_EST) AS ENDER, "
_cQuery += "       SB1.B1_CAPACID, SD1.D1_QUANT, SF4.F4_TEXTO, SB1.B1_MARCA "
_cQuery += "FROM " + RetSqlName("SD1")+" SD1 "
_cQuery += "INNER JOIN " + RetSqlName("SA1")+" SA1 "
_cQuery += "ON SA1.A1_FILIAL = '" + xFilial("SA1") + "' AND SD1.D1_FORNECE = SA1.A1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SB1")+" SB1 "
_cQuery += "ON SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND SD1.D1_COD = SB1.B1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SF4")+" SF4 "
_cQuery += "ON SF4.F4_FILIAL = '" + xFilial("SF4") + "' AND SD1.D1_TES = SF4.F4_CODIGO "
_cQuery += "WHERE SD1.D_E_L_E_T_ = ' ' "
_cQuery += "AND   SD1.D1_LOCAL = '03' "
_cQuery += "AND   SD1.D1_DOC = '" + MV_PAR01 + "' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D1_DTDIGIT","D",8,0)
TcSetField("QR1","D1_EMISSAO","D",8,0)

oPrint:= TMSPrinter():New( "Ordem de servico interna" )
oPrint:SetPortrait() // ou SetLandscape()


Do While ! QR1->(Eof())
	For _ny := 1 to QR1->D1_QUANT
		fForm()
	Next _ny
	QR1->(DbSkip())
EndDo
QR1->(DbCloseArea())

oPrint:Preview()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fForm     ºAutor  ³Ocimar Rolli        º Data ³  13/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta formulario completo, para preencher coom os dados.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fForm()

oPrint:StartPage()
// BOX EXTERNO
oPrint:Box(nRowIni-20,nColIni-20,nRowFim+20,nColFim+20)

// BOX 1
oPrint:Box(nRowIni,nColIni,nRowIni+100,nColFim)
oPrint:Say(nRowIni+10,nColIni+50,"ORDEM DE SERVICO INTERNA ( ASSISTENCIA TECNICA ) Nº "+QR1->D1_DOC+"/"+QR1->D1_ITEM+strzero(_ny,2),oFont14N)           

// BOX 2
oPrint:Box(nRowIni+150,nColIni,nRowIni+1000,nColFim)
oPrint:Say(nRowIni+200,nColIni+50,"DATA",oFont14N)
oPrint:Say(nRowIni+200,nColIni+1100,"CONFERIDO POR : ",oFont14N)
oPrint:Line(nRowIni+250,nColIni+1600,nRowIni+250,nColFim-100)
oPrint:Say(nRowIni+300,nColIni+50,"CLIENTE (   )   FORNECEDOR (   )",oFont14N)
oPrint:Say(nRowIni+400,nColIni+50,"EMPRESA  : ",oFont14N)
oPrint:Say(nRowIni+405,nColIni+400,QR1->A1_NOME,oFont12)
oPrint:Say(nRowIni+500,nColIni+50,"ENDERECO : ",oFont14N)
oPrint:Say(nRowIni+505,nColIni+400,QR1->ENDER,oFont12)
oPrint:Say(nRowIni+600,nColIni+50,"FONE     : ",oFont14N)
oPrint:Say(nRowIni+605,nColIni+400,QR1->A1_TEL,oFont12)
oPrint:Say(nRowIni+600,nColIni+1100,"CONTATO : ",oFont14N)
oPrint:Line(nRowIni+650,nColIni+1400,nRowIni+650,nColFim-100)
oPrint:Say(nRowIni+700,nColIni+50,"NOTA FISCAL : ",oFont14N)
oPrint:Say(nRowIni+705,nColIni+500,QR1->D1_DOC,oFont12)
oPrint:Say(nRowIni+700,nColIni+800,"(   ) DECLARACAO ",oFont14N)
oPrint:Say(nRowIni+800,nColIni+50,"DATA DE EMISSAO : ",oFont14N)
oPrint:Say(nRowIni+805,nColIni+600,DTOC(QR1->D1_EMISSAO),oFont12)
oPrint:Say(nRowIni+800,nColIni+1100,"DATA DE ENTRADA : ",oFont14N)
oPrint:Say(nRowIni+805,nColIni+1650,DTOC(QR1->D1_DTDIGIT),oFont12)
oPrint:Say(nRowIni+900,nColIni+50,"TIPO DE OPERACAO : ",oFont14N)
oPrint:Say(nRowIni+905,nColIni+700,QR1->F4_TEXTO,oFont12)


// BOX 3
oPrint:Box(nRowIni+1050,nColIni,nRowIni+1400,nColFim)
oPrint:Say(nRowIni+1100,nColIni+50,"FRETE : (    ) CIF    (    ) FOB",oFont14N)
oPrint:Say(nRowIni+1200,nColIni+50,"(    ) ORCAMENTO P/ CONSERTO",oFont14N)
oPrint:Say(nRowIni+1200,nColIni+1000,"(    ) CALIBRACAO",oFont14N)
oPrint:Say(nRowIni+1200,nColIni+1600,"(    ) TESTE",oFont14N)
oPrint:Say(nRowIni+1300,nColIni+50,"(    ) RETORNO DE DEMONSTRACAO",oFont14N)
oPrint:Say(nRowIni+1300,nColIni+1000,"(    ) OUTROS PART NUMBER _______________",oFont14N)

// BOX 4
oPrint:Box(nRowIni+1450,nColIni,nRowIni+2000,nColFim)
oPrint:Say(nRowIni+1500,nColIni+50,"PRODUTO",oFont14N)
oPrint:Say(nRowIni+1600,nColIni+50,"MARCA",oFont14N)
oPrint:Say(nRowIni+1700,nColIni+50,"QUANTIDADE",oFont14N)
oPrint:Say(nRowIni+1800,nColIni+50,"NUMERO DE SERIE",oFont14N)
oPrint:Say(nRowIni+1900,nColIni+50,"PART NUMBER",oFont14N)
oPrint:Say(nRowIni+1505,nColIni+600,QR1->B1_DESC,oFont12)
oPrint:Say(nRowIni+1605,nColIni+600,QR1->B1_MARCA,oFont12)
oPrint:Say(nRowIni+1705,nColIni+600,"1",oFont12)
oPrint:Say(nRowIni+1905,nColIni+600,QR1->B1_PNUMBER,oFont12)


// BOX 5
oPrint:Box(nRowIni+2050,nColIni,nRowIni+2700,nColFim)
oPrint:Say(nRowIni+2100,nColIni+50,"EMBALAGEM ORIGINAL",oFont14N)
oPrint:Say(nRowIni+2200,nColIni+50,"ACOMPANHA ACESSORIOS :",oFont14N)
oPrint:Say(nRowIni+2300,nColIni+50,"(    ) NAO    (    ) SIM - QUAIS : ",oFont14N)
oPrint:Line(nRowIni+2350,nColIni+750,nRowIni+2350,nColFim-100)
oPrint:Say(nRowIni+2400,nColIni+50,"CLIENTE INFORMA QUAL O PROBLEMA DO MATERIAL ?",oFont14N)
oPrint:Say(nRowIni+2500,nColIni+50,"(    ) SIM - QUAL ? : ",oFont14N)
oPrint:Line(nRowIni+2550,nColIni+550,nRowIni+2550,nColFim-100)
oPrint:Say(nRowIni+2600,nColIni+50,"(    ) NAO - SERA ANALISADO PELA ASSISTENCIA TECNICA",oFont14N)

// BOX 6
oPrint:Box(nRowIni+2750,nColIni,nRowIni+3100,nColFim)
oPrint:Say(nRowIni+2800,nColIni+50,"MATERIAL ENVIADO PARA ASSISTENCIA TECNICA",oFont14N)
oPrint:Say(nRowIni+2900,nColIni+50,"RECEBIDO POR : _________________________",oFont14N)
oPrint:Say(nRowIni+2900,nColIni+1600,"DATA : ____ / ____ / ____",oFont14N)
oPrint:Say(nRowIni+3000,nColIni+50,"OBS : ",oFont14N)
oPrint:Line(nRowIni+3050,nColIni+200,nRowIni+3050,nColFim-100)

oPrint:EndPage()

Return()
