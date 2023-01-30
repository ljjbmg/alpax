/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR011   ºAutor  ³Microsiga           º Data ³  13/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para impressao das requisicoes                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "Topconn.ch"

User Function ESTR011()

cPerg := "REST11"

// Criacao das perguntas
fCriaSx1()

If ! Pergunte(cPerg,.t.)
	Return
EndIf

MsgRun("Emitindo as requisicoes....",,{ || _fImprime() })

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprime ºAutor  ³Microsiga           º Data ³  13/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para impressao                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fImprime()

Private oPrint, _cQuery, nRow1

_cQuery := "SELECT D3_QUANT, B1_PNUMBER, B1_DESC, B1_CAPACID, D3_LOTECTL, D3_USUARIO, D3_EMISSAO, D3_AXMOTIV, D3_ESTORNO, D3_TM, "
_cQuery += "       D3_DOC, D3_UM, D3_LOCAL, B1_MARCA, D3_TM, F5_TEXTO "
_cQuery += "            FROM " + RetSqlName("SD3") + " D3 "
_cQuery += "                     INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                                  ON B1_FILIAL = '" + xFilial("SB1") + "' AND D3_COD = B1_COD "
_cQuery += "                     INNER JOIN " + RetSqlName("SF5") + " F5 "
_cQuery += "                                  ON B1_FILIAL = '" + xFilial("SF5") + "' AND D3_TM = F5_CODIGO "
_cQuery += "            WHERE B1.D_E_L_E_T_ = ' ' AND D3.D_E_L_E_T_ = ' ' AND D3_DOC = '" + MV_PAR01 + "' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D3_QUANT"		,"N",10,0)
TcSetField("QR1","D3_EMISSAO"	,"D",08,0)

oFont8  := TFont():New("Arial",9,8,.T.,.F.,5,.T.,5,.T.,.F.)
oFont11c := TFont():New("Courier New",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
oFont10  := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
oFont12  := TFont():New("Arial",9,12,.T.,.T.,5,.T.,5,.T.,.F.)
oFont14  := TFont():New("Arial",9,14,.T.,.T.,5,.T.,5,.T.,.F.)
oFont20  := TFont():New("Arial",9,20,.T.,.T.,5,.T.,5,.T.,.F.)
oFont21  := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
oFont16n := TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)

oFscr10  := TFont():New("Tebuchet",10,10,.T.,.F.,5,.T.,5,.T.,.F.)

oPrint:= TMSPrinter():New( "Requisicao Interna" )
oPrint:SetPortrait() // ou SetLandscape()

QR1->(DbGoTop())

_nItens := 25
_lPrimeiro := .t.

Do While ! QR1->(Eof()) .And. QR1->D3_ESTORNO <> 'S'
	If _nItens > 24
		If ! _lPrimeiro
			oPrint:EndPage()
		EndIf
		_nItens := 1
		_lPrimeiro := .f.
		fMontaForm()
	EndIf
	_cDesc := Alltrim(QR1->B1_DESC) + "-" + Alltrim(QR1->B1_MARCA)+"-"+Alltrim(QR1->B1_CAPACID)
	_cDesc1:= Left(_cDesc,55)
	_cDesc2:= Substr(_cDesc,56,55)
	oPrint:Say(nRow1+0100,0120,Transform(QR1->D3_QUANT,"@e 99,999")+" "+QR1->D3_UM				,oFont10)
	oPrint:Say(nRow1+0100,0320,QR1->B1_PNUMBER													,oFont10)
	oPrint:Say(nRow1+0100,0670,QR1->D3_LOCAL													,oFont10)	
	oPrint:Say(nRow1+0100,0740,_cDesc1															,oFont10)
	oPrint:Say(nRow1+0100,2000,QR1->D3_LOTECTL													,oFont10)
	oPrint:Say(nRow1+0200,0740,_cDesc2															,oFont10)
	nRow1 += 100
	_nItens++
	QR1->(DbSkip())
EndDo

oPrint:EndPage()     // Finaliza a página
oPrint:Preview()     // Visualiza antes de imprimir

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCriaSx1  ºAutor  ³Microsiga           º Data ³  13/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para criacao das perguntas do relatorio.             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - CAIXARS                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCriaSx1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Nr.Documento    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   

PutSx1(cPerg,"01","Nr. Documento ?","Nr. Documento ?","Nr. Documento ?","mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fMontaFormºAutor  ³Microsiga           º Data ³  03/03/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fMontaForm()

oPrint:StartPage()

nRow1 := 100
nColIni := 100
nColFim := 2300
nRowFim := 3150
oPrint:Box( nRow1     ,nColIni,nRowFim,nColFim )

For _nY := nRow1+150 To nRow1+550 step 100
	oPrint:Line(_nY,nColIni,_nY,nColFim) // Requisicao interna 
Next _nY

For _nY := nRow1+650 To nRowFim-200 Step 100
	oPrint:Line(_nY,nColIni,_nY,nColFim) // Linhas continuas
Next _nY

// titulos dos campos.
oPrint:Say(nRow1+0050,0680,"MOVIMENTAÇÃO INTERNA DE MATERIAIS"	,oFont14)
oPrint:Say(nRow1+0050,1950,QR1->D3_DOC							,oFont14)
oPrint:Say(nRow1+0175,0150,"Solicitante"						,oFont12)
oPrint:Say(nRow1+0175,1500,"Data Solicitada"					,oFont12)
oPrint:Say(nRow1+0275,0150,"Tipo Movto."						,oFont12)
oPrint:Say(nRow1+0275,1500,"Data Necessidade"					,oFont12)
oPrint:Say(nRow1+0375,0150,"Motivo"								,oFont12)
oPrint:Say(nRow1+0475,0150,"Tipo de Movimento"                  ,oFont12)
oPrint:Say(nRow1+0475,0900,"Descricao do movimento"             ,oFont12)
oPrint:Say(nRow1+0575,0150,"Qtde"								,oFont12)
oPrint:Say(nRow1+0575,0380,"Referência"							,oFont12)
oPrint:Say(nRow1+0575,0670,"Ar"									,oFont12)
oPrint:Say(nRow1+0575,1100,"Descrição"							,oFont12)
oPrint:Say(nRow1+0575,2050,"Nr.Lote"							,oFont12)
oPrint:Say(nRow1+2900,1500,"Data"								,oFont14)
oPrint:Say(nRow1+2900,0150,"Entregue por"						,oFont14)

// Linhas verticais.
oPrint:Line(nRow1+0150,0500,nRow1+0550,0500)
oPrint:Line(nRow1+0150,1450,nRow1+0350,1450)
oPrint:Line(nRow1+0150,1900,nRow1+0350,1900)
oPrint:Line(nRow1+0450,0850,nRow1+0550,0850)
oPrint:Line(nRow1+0450,1400,nRow1+0550,1400)
oPrint:Line(nRow1+0550,0300,nRowFim-200,0300)
oPrint:Line(nRow1+0550,0650,nRowFim-200,0650)
oPrint:Line(nRow1+0550,0730,nRowFim-200,0730)
oPrint:Line(nRow1+0550,1950,nRowFim-200,1950)

// Itens do cabecalho

oPrint:Say(nRow1+0175,0550,QR1->D3_USUARIO								,oFscr10)
oPrint:Say(nRow1+0175,2000,DTOC(QR1->D3_EMISSAO)						,oFscr10)
oPrint:Say(nRow1+0275,0550,IIF(QR1->D3_TM > '499','SAIDA','ENTRADA')	,oFscr10)
oPrint:Say(nRow1+0275,2000,DTOC(QR1->D3_EMISSAO)						,oFscr10)
oPrint:Say(nRow1+0375,0550,QR1->D3_AXMOTIV								,oFscr10)
oPrint:Say(nRow1+0475,0550,QR1->D3_TM									,oFscr10)
oPrint:Say(nRow1+0475,1450,QR1->F5_TEXTO								,oFscr10)

nRow1 := 675

Return
