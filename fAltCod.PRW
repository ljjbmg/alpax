/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fAltCod  ºAutor  ³Adriano Luis Brandaoº Data ³  13/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para alterar a codificacao do cadastro de produtos. º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function fAltCod()


Local oDlg,oGrp3,oList4,oSBtn5,oSBtn6  
Private nItem := 1
oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Alteracao codificacao"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 491
oDlg:nHeight := 353
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oGrp3 := TGROUP():Create(oDlg)
oGrp3:cName := "oGrp3"
oGrp3:cCaption := "Selecione o item a alterar"
oGrp3:nLeft := 56
oGrp3:nTop := 33
oGrp3:nWidth := 359
oGrp3:nHeight := 230
oGrp3:lShowHint := .F.
oGrp3:lReadOnly := .F.
oGrp3:Align := 0
oGrp3:lVisibleControl := .T.

oList4 := TLISTBOX():Create(oDlg)
oList4:cName := "oList4"
oList4:cCaption := "oList4"
oList4:nLeft := 85
oList4:nTop := 76
oList4:nWidth := 289
oList4:nHeight := 159
oList4:lShowHint := .F.
oList4:lReadOnly := .F.
oList4:Align := 0
oList4:cVariable := "nItem"
oList4:bSetGet := {|u| If(PCount()>0,nItem:=u,nItem) }
oList4:lVisibleControl := .T.
oList4:nAt := 0
oList4:aItems := { "Diferencial","Capacidade","Nome"}

oSBtn5 := SBUTTON():Create(oDlg)
oSBtn5:cName := "oSBtn5"
oSBtn5:cCaption := "Alterar"
oSBtn5:nLeft := 257
oSBtn5:nTop := 283
oSBtn5:nWidth := 52
oSBtn5:nHeight := 22
oSBtn5:lShowHint := .F.
oSBtn5:lReadOnly := .F.
oSBtn5:Align := 0
oSBtn5:lVisibleControl := .T.
oSBtn5:nType := 1
oSBtn5:bAction := {|| fProcessar() }

oSBtn6 := SBUTTON():Create(oDlg)
oSBtn6:cName := "oSBtn6"
oSBtn6:cCaption := "oSBtn6"
oSBtn6:nLeft := 359
oSBtn6:nTop := 283
oSBtn6:nWidth := 52
oSBtn6:nHeight := 22
oSBtn6:lShowHint := .F.
oSBtn6:lReadOnly := .F.
oSBtn6:Align := 0
oSBtn6:lVisibleControl := .T.
oSBtn6:nType := 2
oSBtn6:bAction := {|| oDlg:End() }

oDlg:Activate()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fProcessarºAutor  ³Adriano Luis Brandaoº Data ³  13/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para digitar os dados para alteracao.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fProcessar()
//
// nItem := 1   - Diferencial 
// nItem := 2	- Capacidade
// nItem := 3	- Nome
//
Local oDlg,oGrp2,oGet3,oGrp4,oGet5,oSBtn6,oSBtn7

Do Case
	Case nItem == 1  	// diferencial
		_cTabela := "CZ6"                             
		_cTitulo := "diferencial"
		_cCodAtu := Space(30)
		_cCodNov := Space(30)
	Case nItem == 2		// capacidade
		_cTabela := "CZ5"
		_cTitulo := "capacidade"			
		_cCodAtu := Space(15)
		_cCodNov := Space(15)
	Case nItem == 3		// Nome
        _cTabela := "CZ3"
   		_cTitulo := "Nome"   
   		_cCodAtu := Space(45)
   		_cCodNov := Space(45)
EndCase

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Alteracao dos produtos " + _cTitulo 
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 492
oDlg:nHeight := 275
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oGrp2 := TGROUP():Create(oDlg)
oGrp2:cName := "oGrp2"
oGrp2:cCaption := "Codigo atual"
oGrp2:nLeft := 24
oGrp2:nTop := 20
oGrp2:nWidth := 430
oGrp2:nHeight := 69
oGrp2:lShowHint := .F.
oGrp2:lReadOnly := .F.
oGrp2:Align := 0
oGrp2:lVisibleControl := .T.

oGet3 := TGET():Create(oDlg)
oGet3:cF3 := _cTabela
oGet3:cName := "oGet3"
oGet3:cCaption := "oGet3"
oGet3:nLeft := 34
oGet3:nTop := 50
oGet3:nWidth := 395
oGet3:nHeight := 21
oGet3:lShowHint := .F.
oGet3:lReadOnly := .F.
oGet3:Align := 0
oGet3:cVariable := "_cCodAtu"
oGet3:bSetGet := {|u| If(PCount()>0,_cCodAtu:=u,_cCodAtu) }
oGet3:lVisibleControl := .T.
oGet3:lPassword := .F.
oGet3:lHasButton := .F.

oGrp4 := TGROUP():Create(oDlg)
oGrp4:cName := "oGrp4"
oGrp4:cCaption := "Novo Codigo"
oGrp4:nLeft := 24
oGrp4:nTop := 116
oGrp4:nWidth := 430
oGrp4:nHeight := 69
oGrp4:lShowHint := .F.
oGrp4:lReadOnly := .F.
oGrp4:Align := 0
oGrp4:lVisibleControl := .T.

oGet5 := TGET():Create(oDlg)
oGet5:cF3 := _cTabela
oGet5:cName := "oGet5"
oGet5:cCaption := "oGet5"
oGet5:nLeft := 34
oGet5:nTop := 144
oGet5:nWidth := 395
oGet5:nHeight := 21
oGet5:lShowHint := .F.
oGet5:lReadOnly := .F.
oGet5:Align := 0
oGet5:cVariable := "_cCodNov"
oGet5:bSetGet := {|u| If(PCount()>0,_cCodNov:=u,_cCodNov) }
oGet5:lVisibleControl := .T.
oGet5:lPassword := .F.
oGet5:lHasButton := .F.

oSBtn6 := SBUTTON():Create(oDlg)
oSBtn6:cName := "oSBtn6"
oSBtn6:cCaption := "Gravacao"
oSBtn6:nLeft := 260
oSBtn6:nTop := 203
oSBtn6:nWidth := 63
oSBtn6:nHeight := 26
oSBtn6:lShowHint := .F.
oSBtn6:lReadOnly := .F.
oSBtn6:Align := 0
oSBtn6:lVisibleControl := .T.
oSBtn6:nType := 1
oSBtn6:bAction := {|| fProcessa() }

oSBtn7 := SBUTTON():Create(oDlg)
oSBtn7:cName := "oSBtn7"
oSBtn7:cCaption := "oSBtn7"
oSBtn7:nLeft := 386
oSBtn7:nTop := 203
oSBtn7:nWidth := 63
oSBtn7:nHeight := 26
oSBtn7:lShowHint := .F.
oSBtn7:lReadOnly := .F.
oSBtn7:Align := 0
oSBtn7:lVisibleControl := .T.
oSBtn7:nType := 2
oSBtn7:bAction := {|| oDlg:End() }

oDlg:Activate()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fSalvar   ºAutor  ³Adriano Luis Brandaoº Data ³  13/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ funcao de chamada para gravacao dos dados                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 
Static Function fProcessa()

MsgRun("Atualizando os dados do cadastro de produtos",,{ || _fSalvar() })

Return                                                                  
     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fSalvar   ºAutor  ³Adriano Luis Brandaoº Data ³  13/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ funcao da gravacao dos dados                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                        
Static Function _fSalvar()                                            

_cCodigo 	:= Space(Len(SB1->B1_COD))
_cDesc		:= Space(Len(SB1->B1_DESC))

If 	Empty(_cCodAtu) .or. Empty(_cCodNov)
	ApMsgStop("Favor preencher todos os campos corretamente")
	Return
EndIf

If ! ApMsgYesNo("Confirma a alteracao dos codigos ???")
	Return
EndIf

SB1->(DbSetOrder(5))                        

Do Case
	Case nItem == 1		// 	Diferencial 
		SB1->(DbGoTop())
		Do While ! SB1->(Eof())
			If Left(_cCodAtu,3) == Right(SB1->B1_COD,3)
			    _fCodDesc()				// Monta codigo e descricao dos produtos
				RecLock("SB1",.f.)
				SB1->B1_AXDIF	:= SZ6->Z6_DESCR
				SB1->B1_COD		:= _cCodigo
				SB1->B1_DESC	:= _cDesc
			    SB1->(MsUnLock())
			EndIf					

			SB1->(DbSkip())		
		EndDo
	
	Case nItem == 2		//	Capacidade
		SB1->(DbGoTop())
		Do While ! SB1->(Eof())
			If Left(_cCodAtu,3) == Substr(SB1->B1_COD,10,3)
				_fCodDesc()				// Monta codigo e descricao dos produtos
				RecLock("SB1",.f.)
				SB1->B1_CAPACID	:= SZ5->Z5_DESCR
				SB1->B1_COD		:= _cCodigo
				SB1->B1_DESC    := _cDesc
				SB1->(MsUnLock())         
			EndIf
			SB1->(DbSkip())		
		EndDo
	
	Case nItem == 3		//	Nome
		SB1->(DbGoTop())
		Do While ! SB1->(Eof())
			If Left(_cCodAtu,4) == Substr(SB1->B1_COD,6,4)
				_fCodDesc()				// Monta codigo e descricao dos produtos
				RecLock("SB1",.f.)
				SB1->B1_NOME	:= SZ3->Z3_DESCR
				SB1->B1_COD		:= _cCodigo
				SB1->B1_DESC	:= _cDesc
				SB1->(MsUnLock())         
			EndIf
			SB1->(DbSkip())		
		EndDo
EndCase

Return
                    
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCodDesc ºAutor  ³Adriano Luis Brandaoº Data ³  13/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para criacao do codigo novo e descricao do produto. º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                    

Static Function _fCodDesc()

SZ1->(DbSetOrder(1))
SZ2->(DbSetOrder(1))
SZ3->(DbSetOrder(1))              
SZ5->(DbSetOrder(1))
SZ6->(DbSetOrder(1))

SZ1->(DbSeek(xFilial("SZ1")+Left(SB1->B1_COD,2)))									// Linha
SZ2->(DbSeek(xFilial("SZ2")+Substr(SB1->B1_COD,3,3)))								// Marca
SZ3->(DbSeek(xFilial("SZ3")+iif(nItem == 3,_cCodNov,Substr(SB1->B1_COD,6,4))))		// Nome
SZ5->(DbSeek(xFilial("SZ5")+iif(nItem == 2,_cCodNov,Substr(SB1->B1_COD,10,3))))		// Capacidade
SZ6->(DbSeek(xFilial("SZ6")+iif(nItem == 1,_cCodNov,Right(SB1->B1_COD,3))))			// Diferencial

_cCodigo 	:= SZ1->Z1_CODLIN+SZ2->Z2_CODMARC+SZ3->Z3_CODNOME+SZ5->Z5_CODCAPA+SZ6->Z6_CODDIFE
_cDesc		:= ALLTRIM(SZ3->Z3_DESCR) + ' ' + ALLTRIM(SZ6->Z6_DESCR)                 /*OCIMAR*/

Return                  