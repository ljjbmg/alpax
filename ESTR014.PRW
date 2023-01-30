/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  ³ESTR014   ºAutor  ³Microsiga           º Data ³  12/08/06   º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "rwmake.ch"
#Include "topconn.ch"
User Function ESTR014()


If Empty(SZJ->ZJ_COLETA)
	ApMsgStop("Coleta da chamada " + SZJ->ZJ_CHAMADA + " nao preenchida, nao sera impressa !!!" )
	Return
EndIf

If ! ApMsgYesNo("Confirma a Impressao da coleta nr " + SZJ->ZJ_COLETA + " ???")
	Return
EndIf

MsgRun("Emitindo a chamada de coleta....",,{ || _fImprime() })

Return                                                        

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  ³_fImprime ºAutor  ³Microsiga           º Data ³  12/08/06   º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDesc.     ³Funcao de impressao.                                        º±±
±±º          ³                                                            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fImprime()

Local _nLinhaIni := 0480
Private nPage := 1

Private oPrint
Private nRowInRoda := 2450

_cQuery := "SELECT ZJ_NOTA, ZJ_RAZAO, ZJ_VOLUME, ZJ_PESOB, A4_NOME, A4_NREDUZ, ZJ_DATACH, ZJ_HORACH, ZJ_CONTATO, "
_cQuery += "           ZJ_COLETA, ZJ_SOLICIT, ZJ_EXPEDIT, ZJ_DATACOL, ZJ_PLACA, ZJ_MOTORI, ZJ_RGMOTO "
_cQuery += "FROM " + RetSqlName("SZJ") + " ZJ "
_cQuery += "         INNER JOIN " + RetSqlName("SA4") + " A4 "
_cQuery += "               ON A4_FILIAL = '" + xFilial("SA4") + "' AND ZJ_TRANSP = A4_COD AND ZJ.D_E_L_E_T_ = ' ' "
_cQuery += "WHERE ZJ_FILIAL = '" + xFilial("SZJ") + "' AND ZJ_CHAMADA = '" + SZJ->ZJ_CHAMADA + "' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","ZJ_VOLUME" ,"N",12,0)
TcSetField("QR1","ZJ_PESOB"  ,"N",12,3)
TcSetField("QR1","ZJ_DATACH" ,"D",08,0)                                
TcSetField("QR1","ZJ_DATACOL","D",08,0)
TcSetField("QR1","ZJ_PLACA"  ,"C",08,0)
TcSetField("QR1","ZJ_MOTORI" ,"C",25,0)
TcSetField("QR1","ZJ_RGMOTO" ,"C",12,0)

oFont8   := TFont():New("Arial",9,8,.T.,.F.,5,.T.,5,.T.,.F.)
oFont11c := TFont():New("Courier New",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
oFont10  := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
oFont12  := TFont():New("Arial",9,12,.T.,.T.,5,.T.,5,.T.,.F.)
oFont14  := TFont():New("Arial",9,14,.T.,.T.,5,.T.,5,.T.,.F.)
oFont20  := TFont():New("Arial",9,20,.T.,.T.,5,.T.,5,.T.,.F.)
oFont21  := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
oFont26  := TFont():New("Arial",9,26,.T.,.T.,5,.T.,5,.T.,.F.)
oFont16n := TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)
oFontTr12:= TFont():New("Trebuchet MS",9,12,.T.,.T.,5,.T.,5,.T.,.F.)

_lPrimeiro := .t.
_nItem := 21
nLinha := 1
nPage  := 1
QR1->(DbGoTop())

Do While ! QR1->(Eof())
	If _nItem > 20
		_nItem := 1
		If _lPrimeiro
			oPrint:= TMSPrinter():New( "Imprimindo coleta" )
			oPrint:SetPortrait() // ou SetLandscape()
			_lPrimeiro := .f.
		Else
			oPrint:EndPage()     // Finaliza a página			
		EndIf
		oPrint:StartPage() 		// Inicia uma nova pagina
		fMontaForm()
		fMontaRoda()
	EndIf
	If nLinha == 21
		
		nLinha := 1
		nPage++
		_nLinhaIni := 0480
		oPrint:EndPage()
		oPrint:StartPage() 		// Inicia uma nova pagina
		fMontaForm()
		fMontaRoda()

	EndIf

	oPrint:Say  (_nLinhaIni,0150,QR1->ZJ_NOTA									,oFontTr12 )	
	oPrint:Say  (_nLinhaIni,0500,QR1->ZJ_RAZAO									,oFontTr12 )		
	oPrint:Say  (_nLinhaIni,1430,Transform(QR1->ZJ_VOLUME,"@e 999,999,999,999")	,oFontTr12 )			
	oPrint:Say  (_nLinhaIni,1670,Transform(QR1->ZJ_PESOB,"@e 99,999,999.999")	,oFontTr12 )
	oPrint:Say  (_nLinhaIni,1950," ___ / ___ / ___"  							,oFontTr12 )	
	_nLinhaIni+=100
	nLinha++

	
	QR1->(DbSkip())
EndDo


oPrint:EndPage()     // Finaliza a página
oPrint:Preview()     // Visualiza antes de imprimir


QR1->(DbCloseArea())


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  ³fMontaFormºAutor  ³Microsiga           º Data ³  12/08/06   º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fMontaForm()

Local nRow1 := 100
Local nColIni := 100
Local nColFim := 2300
Local nRowFim := 3150

oPrint:Box( nRow1     ,nColIni,nRowFim,nColFim )

For _nY := nRow1+250 To nRowFim-300 Step 100
	oPrint:Line(_nY,nColIni,_nY,nColFim) // Linhas continuas
Next _nY

oPrint:Line(nRow1+255,nColIni,nRow1+255,nColFim) // Linhas continuas      
oPrint:Line(nRow1+355,nColIni,nRow1+355,nColFim) // Linhas continuas      

oPrint:Line(nRow1+0250,0450,nRowInRoda,0450)  // COLUNA NOTA FISCAL 
oPrint:Line(nRow1+0250,1480,nRowInRoda,1480)  // COLUNA CLIENTE 
oPrint:Line(nRow1+0250,1710,nRowInRoda,1710)  // COLUNA VOLUME 
oPrint:Line(nRow1+0250,1920,nRowInRoda,1920)  // COLUNA PESO 

oPrint:Line(nRowInRoda,1150,nRowInRoda+400,1150)  // COLUNA RODAPE
oPrint:Line(nRowInRoda+0650,0650,nRowInRoda+0650,1900)  // LINHA MOTORISTA

// Titulos do cabecalho
oPrint:SayBitmap(0150,0150,"\system\logo_alpax.bmp",600,170) 
oPrint:Say  (0180,1000,"ORDEM DE COLETA"					,oFont26 )
oPrint:Say  (0180,2100,"Pag.: "	+ Alltrim(Str(nPage))		,oFont12 )
oPrint:Say  (nRow1+0280,0150,"NOTA FISCAL"					,oFont12 )
oPrint:Say  (nRow1+0280,0500,"CLIENTE"						,oFont12 )
oPrint:Say  (nRow1+0280,1510,"VOL(S)"   					,oFont12 )
oPrint:Say  (nRow1+0280,1760,"PESO"							,oFont12 )
oPrint:Say  (nRow1+0280,1935,"PRAZO ENTREGA"				,oFont12 )

// Titulos do rodape
oPrint:Say  (nRowInRoda+0050,0150,"TRANSPORTADORA"			,oFont12 )
oPrint:Say  (nRowInRoda+0050,1200,"DATA DE CHAMADA"			,oFont12 )
oPrint:Say  (nRowInRoda+0150,0150,"CONTATO"					,oFont12 )
oPrint:Say  (nRowInRoda+0150,1200,"No. DA COLETA"			,oFont12 )
oPrint:Say  (nRowInRoda+0250,0150,"SOLICITANTE"				,oFont12 )
oPrint:Say  (nRowInRoda+0250,1200,"EXPEDIDOR"				,oFont12 )
oPrint:Say  (nRowInRoda+0350,0150,"PLACA"					,oFont12 )
oPrint:Say  (nRowInRoda+0350,1200,"DATA DA COLETA"			,oFont12 )
oPrint:Say  (nRowInRoda+0650,0150,"DADOS DO MOTORISTA"	    ,oFont10 )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  ³fMontaRodaºAutor  ³Microsiga           º Data ³  19/08/06   º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDesc.     ³Funcao para impressao do rodape do relatorio.               º±±
±±º          ³                                                            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fMontaRoda()

oPrint:Say  (nRowInRoda+0050,0650,QR1->A4_NREDUZ								  							   ,oFontTr12 )
oPrint:Say  (nRowInRoda+0050,1800,DTOC(QR1->ZJ_DATACH)					          							   ,oFontTr12 )
oPrint:Say  (nRowInRoda+0150,0650,QR1->ZJ_CONTATO								  							   ,oFontTr12 )
oPrint:Say  (nRowInRoda+0150,1800,QR1->ZJ_COLETA							      							   ,oFontTr12 )
oPrint:Say  (nRowInRoda+0250,0650,UsrRetName(QR1->ZJ_SOLICIT)	 				  							   ,oFontTr12 )
oPrint:Say  (nRowInRoda+0250,1800,UsrRetName(QR1->ZJ_EXPEDIT)					  							   ,oFontTr12 )
oPrint:Say  (nRowInRoda+0350,0650,Transform(QR1->ZJ_PLACA,"@! XXX-XXXX")		                               ,oFontTr12 ) //Henrique Caetano 06/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014 
oPrint:Say  (nRowInRoda+0350,1800,DTOC(QR1->ZJ_DATACOL)					                                       ,oFontTr12 )
oPrint:Say  (nRowInRoda+0450,0130,"Tenho ci�ncia que a (s) quantidade (s) de volume (s) retirados na Alpax contida nesta ordem de coleta, foram devidamente", oFont10)
oPrint:Say  (nRowInRoda+0500,0130,"conferidos, e ciente que se existir extravios a empresa de transporte se responsabiliza pelas perdas e danos dos produtos",oFont10)
oPrint:Say  (nRowInRoda+0650,0700,"Nome : "+QR1->ZJ_MOTORI+" - RG "+QR1->ZJ_RGMOTO,oFontTr12 ) //Henrique Caetano 02/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014

Return
