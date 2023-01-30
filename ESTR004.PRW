/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR004   ºAutor  ³Adriano Luis Brandaoº Data ³  15/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para imprimir etiqueta termica contada em inventario º±±
±±º          ³sem a necessidade de entrada de nota fiscal.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ESTR004()

Local oDlg,oGrp1,oSBtn2,oSBtn3,Produto,Lote,oGet6,oGet7
_cProduto 	:= space(15)
_cLote		:= Space(10)
Private _cQuant	:= Space(05)  

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Etiqueta Contagem"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 346
oDlg:nHeight := 230
oDlg:lShowHint := .F.
oDlg:lCentered := .t.

oGrp1 := TGROUP():Create(oDlg)
oGrp1:cName := "oGrp1"
oGrp1:nLeft := 25
oGrp1:nTop := 21
oGrp1:nWidth := 280
oGrp1:nHeight := 134
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oSBtn2 := SBUTTON():Create(oDlg)
oSBtn2:cName := "oSBtn2"
oSBtn2:cCaption := "oSBtn2"
oSBtn2:nLeft := 160
oSBtn2:nTop := 169
oSBtn2:nWidth := 52
oSBtn2:nHeight := 22
oSBtn2:lShowHint := .F.
oSBtn2:lReadOnly := .F.
oSBtn2:Align := 0
oSBtn2:lVisibleControl := .T.
oSBtn2:nType := 6
oSBtn2:bAction := {|| _fImprime() }
//oSBtn2:bAction := {|| _fImprNew() }

oSBtn3 := SBUTTON():Create(oDlg)
oSBtn3:cName := "oSBtn3"
oSBtn3:cCaption := "oSBtn3"
oSBtn3:nLeft := 249
oSBtn3:nTop := 169
oSBtn3:nWidth := 52
oSBtn3:nHeight := 22
oSBtn3:lShowHint := .F.
oSBtn3:lReadOnly := .F.
oSBtn3:Align := 0
oSBtn3:lVisibleControl := .T.
oSBtn3:nType := 2
oSBtn3:bAction := {|| oDlg:End() }

Produto := TSAY():Create(oDlg)
Produto:cName := "Produto"
Produto:cCaption := "Produto"
Produto:nLeft := 42
Produto:nTop := 50
Produto:nWidth := 65
Produto:nHeight := 17
Produto:lShowHint := .F.
Produto:lReadOnly := .F.
Produto:Align := 0
Produto:lVisibleControl := .T.
Produto:lWordWrap := .F.
Produto:lTransparent := .F.

Lote := TSAY():Create(oDlg)
Lote:cName := "Lote"
Lote:cCaption := "Lote"
Lote:nLeft := 40
Lote:nTop := 90
Lote:nWidth := 65
Lote:nHeight := 17
Lote:lShowHint := .F.
Lote:lReadOnly := .F.
Lote:Align := 0
Lote:lVisibleControl := .T.
Lote:lWordWrap := .F.
Lote:lTransparent := .F.

Quant := TSAY():Create(oDlg)
Quant:cName := "Quant"
Quant:cCaption := "Quant"
Quant:nLeft := 40
Quant:nTop := 120
Quant:nWidth := 65
Quant:nHeight := 17
Quant:lShowHint := .F.
Quant:lReadOnly := .F.
Quant:Align := 0
Quant:lVisibleControl := .T.
Quant:lWordWrap := .F.
Quant:lTransparent := .F.

oGet6 := TGET():Create(oDlg)
oGet6:cF3 := "SB1"
oGet6:cName := "oGet6"
oGet6:cCaption := "oGet6"
oGet6:nLeft := 118
oGet6:nTop := 50
oGet6:nWidth := 121
oGet6:nHeight := 21
oGet6:lShowHint := .F.
oGet6:lReadOnly := .F.
oGet6:Align := 0
oGet6:cVariable := "_cProduto"
oGet6:bSetGet := {|u| If(PCount()>0,_cProduto:=u,_cProduto) }
oGet6:lVisibleControl := .T.
oGet6:lPassword := .F.
oGet6:lHasButton := .F.

oGet7 := TGET():Create(oDlg)
oGet7:cName := "oGet7"
oGet7:cCaption := "oGet7"
oGet7:nLeft := 118
oGet7:nTop := 90
oGet7:nWidth := 121
oGet7:nHeight := 21
oGet7:lShowHint := .F.
oGet7:lReadOnly := .F.
oGet7:Align := 0
oGet7:cVariable := "_cLote"
oGet7:bSetGet := {|u| If(PCount()>0,_cLote:=u,_cLote) }
oGet7:lVisibleControl := .T.
oGet7:lPassword := .F.
oGet7:lHasButton := .F.

oGet8 := TGET():Create(oDlg)
oGet8:cName := "oGet8"
oGet8:cCaption := "oGet8"
oGet8:nLeft := 118
oGet8:nTop := 120
oGet8:nWidth := 121
oGet8:nHeight := 21
oGet8:lShowHint := .F.
oGet8:lReadOnly := .F.
oGet8:Align := 0
oGet8:cVariable := "_cQuant"
oGet8:bSetGet := {|u| If(PCount()>0,_cQuant:=u,_cQuant) }
oGet8:lVisibleControl := .T.
oGet8:lPassword := .F.
oGet8:lHasButton := .F.

oDlg:Activate()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprime ºAutor  ³Adriano Luis Brandaoº Data ³  15/09/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de impressao da etiqueta termica de acordo com o    º±±
±±º          ³ produto e lote selecionado.                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fImprime()

If ! ApMsgYesNo("Confirma Impressao ???")
	Return
EndIf

SB1->(DbSetOrder(1))
//	B1_FILIAL + B1_COD
SB2->(DbSetOrder(1))
//	B2_FILIAL + B2_COD + B2_LOCAL
SB8->(DbSetOrder(5))
//	B8_FILIAL+B8_PRODUTO+B8_LOTECTL+B8_NUMLOTE+DTOS(B8_DTVALID)
SB8->(DbSeek(xFilial("SB8")+_cProduto+_cLote,.t.))

_lPrimeiro := .t.

Do While ! SB8->(Eof()) .And. SB8->B8_FILIAL == xFilial("SB8") .And. SB8->B8_PRODUTO ==;
	_cProduto .And. SB8->B8_LOTECTL == _cLote

	If SB8->B8_SALDO <= 0
		SB8->(DbSkip())
		Loop
	EndIf

	If _lPrimeiro
		cPorta := "LPT1"
		MSCBPRINTER("ZEBRA",cPorta,,,.f.,,,,,,.t.)
		_lPrimeiro := .f.
	EndIF
	//
	// Imprime o numero de etiquetas para a quantidade do Lote
	//
	SB1->(DbSeek(xFilial("SB1")+SB8->B8_PRODUTO))
	For _nY := 1 To SB8->B8_SALDO
		_cDesc1	:= Left(SB1->B1_DESC,35)
		_cDesc2 := SUBSTR(SB1->B1_DESC,36,25) + " " + SB1->B1_CAPACID

		MSCBBEGIN(1,6)
		MSCBBOX(04,03,55,21,5)
		MSCBLineH(04,09,55,3)
		MSCBLineV(25,03,09,3)
		MSCBSAY(06,05,SB1->B1_MARCA		,"N","0","30,20")
		MSCBSAY(27,05,SB1->B1_PNUMBER	,"N","0","30,20")
		MSCBSAY(06,10,_cDesc1			,"N","0","30,20")
		MSCBSAY(06,13,_cDesc2			,"N","0","30,20")

		MSCBLineH(04,16,55,3)
		MSCBSAY(06,17,DTOC(SB8->B8_DTVALID)	,"N","0","30,20")
		MSCBSAY(27,17,SB8->B8_LOTECTL		,"N","0","30,20")

		MSCBSAYBAR(03,21,SB1->B1_COD		,"N","MB02",05)
		MSCBSAY(04,27,SB1->B1_COD			,"N","0","30,20")
		
		MSCBEND()
	Next _nY
	
	SB8->(DbSkip())
EndDo
//
// Etiqueta sem numero de lote, consulta o saldo total do produto.
//
If _lPrimeiro
	SB2->(DbSeek(xFilial("SB2")+_cProduto,.T.))      // ocimar
	_nSaldo := SB2->B2_QATU
	
	SB1->(DbSeek(xFilial("SB1")+_cProduto))     
	For _nY := 1 to _nSaldo
		_cDesc1	:= Left(SB1->B1_DESC,35)
		_cDesc2 := SUBSTR(SB1->B1_DESC,36,25) + " " + SB1->B1_CAPACID
		If _lPrimeiro
			cPorta := "LPT1"
			MSCBPRINTER("ZEBRA",cPorta,,,.f.,,,,,,.t.)

			_lPrimeiro := .f.
		EndIF
		
		MSCBBEGIN(1,6)
		MSCBBOX(04,03,55,21,5)
		MSCBLineH(04,09,55,3)
		MSCBLineV(25,03,09,3)
		MSCBSAY(06,05,SB1->B1_MARCA		,"N","0","30,20")
		MSCBSAY(27,05,SB1->B1_PNUMBER	,"N","0","30,20")
		MSCBSAY(06,10,_cDesc1			,"N","0","30,20")
		MSCBSAY(06,13,_cDesc2			,"N","0","30,20")
		MSCBLineH(04,16,55,3)
		MSCBSAYBAR(03,21,"DEU CERTO FICOU 1000 ALPAX-FIM","N","MB02",05)
		MSCBSAY(04,27,SB1->B1_COD			,"N","0","30,20")
/*
		MSCBBEGIN(1,6)
		MSCBBOX(06,09,56,25,3)								//	Caixa do produto
		MSCBLineH(06,20,56,1,"W")   						//	Linha horizontal Produto
		MSCBLineV(28,20,24,1,"W")							//	Linha Vertical produto
		MSCBSAY(08,21,SB1->B1_MARCA		,"N","2","01,01",.t.)
		MSCBSAY(30,21,SB1->B1_PNUMBER  	,"N","2","01,01",.t.)
		MSCBSAY(07,17,_cDesc1	    	,"N","2","01,01",.t.)
		MSCBSAY(07,14,_cDesc2	    	,"N","2","01,01",.t.)
		MSCBSAY(35,14,SB1->B1_CAPACID  	,"N","2","01,01",.t.)
		MSCBLineV(28,15,10,1)
		MSCBSAYBAR(03,03,"DEU CERTO FICOU 1000 ALPAX-FIM" 		,"N","MB07",06)

		MSCBSAY(07,00,SB1->B1_COD			,"N","2","01,01",.t.)
*/		
		MSCBEND()
	Next _nY
	
EndIf

If ! _lPrimeiro
	MSCBCLOSEPRINTER()
EndIf

ApMsgAlert("Impressao concluida com sucesso !!!")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprNew ºAutor  ³Microsiga           º Data ³  09/16/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Nova etiqueta (ocimar)                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fImprNew()

Local _cDesc	:= ""
Local _cDesc1 	:= ""
Local _cDesc2 	:= ""
Local _cImagem	:= ""

_cContr := ""

If ! ApMsgYesNo("Confirma Impressao ???")
	Return
EndIf

SB1->(DbSetOrder(1))
//	B1_FILIAL + B1_COD
SB2->(DbSetOrder(1))
//	B2_FILIAL + B2_COD + B2_LOCAL
SB8->(DbSetOrder(5))
//	B8_FILIAL+B8_PRODUTO+B8_LOTECTL+B8_NUMLOTE+DTOS(B8_DTVALID)
SB8->(DbSeek(xFilial("SB8")+_cProduto+_cLote,.t.))

_lPrimeiro := .t.      

SB1->(DbSeek(xFilial("SB1")+_cProduto))
If SB1->B1_AXFEDER == 'S'
	_cContr += "PF/"
EndIf
if SB1->B1_AXEXERC == 'S'
	_cContr += "EX/"
EndIf
If SB1->B1_AXSSP == 'S'
	_cContr += "SSP"
EndIf

_cDesc1	:= Substr(SB1->B1_DESC,1,32)
_cDesc2 := Substr(SB1->B1_DESC,33,18)

_cRisco := Left(SB1->B1_AXRISCO,1)
Do Case
	Case _cRisco == "1"
		_cImagem := "EXPLOSIVO"
	Case _cRisco == "3"
		_cImagem := "INFLAMAVEL"
	Case _cRisco == "5"
		_cImagem := "OXIDANTE"
	Case _cRisco == "6"
		_cImagem := "TOXICO"
	Case _cRisco == "8"
		_cImagem := "CORROSIVO"
EndCase
	

If SB8->B8_FILIAL == xFilial("SB8") .And. SB8->B8_PRODUTO ==;
	_cProduto .And. SB8->B8_LOTECTL == _cLote

	If _lPrimeiro
		cPorta := "LPT1"
		MSCBPRINTER("ALLEGRO",cPorta,,,.f.,,,,,,.t.)
		_lPrimeiro := .f.
		If ! Empty(_cImagem)
			MSCBLOADGRF(_cImagem + ".BMP")
		EndIf
	EndIF
	//
	// Imprime o numero de etiquetas para a quantidade do parametro
	//

	For _nY := 1 To val(_cQuant)
		MSCBBEGIN(1,6)   
		If ! Empty(_cImagem)
			MSCBGRAFIC(76,18,_cImagem)
		EndIf
		MSCBSAY(05,27,SB1->B1_PNUMBER					,"N","2","01,01",.t.)
		MSCBSAY(35,27,SB1->B1_MARCA						,"N","2","01,01",.t.)
		MSCBSAY(60,27,_cContr							,"N","2","01,01",.t.)
		MSCBSAY(05,23,SB8->B8_LOTECTL					,"N","2","01,01",.t.)
		MSCBSAY(35,23,DTOC(SB8->B8_DTVALID)				,"N","2","01,01",.t.)
		MSCBSAY(05,19,_cDesc1							,"N","2","01,01",.t.)
		MSCBSAY(05,15,_cDesc2							,"N","2","01,01",.t.)
		MSCBSAYBAR(05,04,SB1->B1_COD+SB8->B8_LOTECTL	,"N","A",08)
		MSCBSAY(05,01,SB1->B1_COD+SB8->B8_LOTECTL		,"N","2","01,01",.t.)
		
		MSCBEND()
	Next _nY
	
EndIf
//
// Etiqueta sem numero de lote, consulta o saldo total do produto.
//
_cContr := ""
If _lPrimeiro

	For _nY := 1 to val(_cQuant)

		_cDesc	:= Alltrim(SB1->B1_DESC)+ " " +SB1->B1_CAPACID
		_cDesc1	:= Left(_cDesc,50)
		_cDesc2	:= iif(Len(_cDesc) > 50,Substr(_cDesc,51,40),"")

		If _lPrimeiro
			cPorta := "LPT1"
			MSCBPRINTER("ALLEGRO",cPorta,,,.f.,,,,,,.t.)
			_lPrimeiro := .f.
			If ! Empty(_cImagem)
				MSCBLOADGRF(_cImagem + ".BMP")
			EndIf

		EndIF

		MSCBBEGIN(1,6)

		If ! Empty(_cImagem)
			MSCBGRAFIC(76,18,_cImagem)
		EndIf
		MSCBSAY(05,27,SB1->B1_PNUMBER					,"N","2","01,01",.t.)
		MSCBSAY(35,27,SB1->B1_MARCA						,"N","2","01,01",.t.)
		MSCBSAY(60,27,_cContr							,"N","2","01,01",.t.)
		MSCBSAY(05,19,_cDesc1							,"N","2","01,01",.t.)
		MSCBSAY(05,15,_cDesc2							,"N","2","01,01",.t.)
		MSCBSAYBAR(05,04,SB1->B1_COD					,"N","A",08)
		MSCBSAY(05,01,SB1->B1_COD						,"N","2","01,01",.t.)

		MSCBEND()
	Next _nY
	
EndIf

If ! _lPrimeiro
	MSCBCLOSEPRINTER()
EndIf

ApMsgAlert("Impressao concluida com sucesso !!!")

Return