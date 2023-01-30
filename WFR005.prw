/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR005    ºAutor  ³Adriano Luis Brandaoº Data ³  10/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para disparar e-mail de confirmacao do pedido de    º±±
±±º          ³ vendas.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function WFR005()

Local oDlg,oGrp1,oGet3,oSay4,oGet5,oGrp8,oGet9,oGet10,oSBtn11,oSBtn12

_aArea 		:= GetArea()
_aAreaA1 	:= SA1->(GetArea())
_aAreaA3	:= SA3->(GetArea())

SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI))

_cCliente 	:= SA1->A1_NOME
_cEmailCli	:= SA1->A1_EMAIL
_cUsuario	:= UsrRetName(SC5->C5_AXATEN1)//cUserName
//_cMailCop	:= UsrRetMail(__cUserID)
_cMailCop	:= Alltrim(Posicione("SA3",1,xFilial("SA3")+SC5->C5_VEND1,"A3_EMAIL"))
_cMailCop	:= iif(Empty(_cMailCop),UsrRetMail(SC5->C5_AXATEN1),_cMailCop+";"+UsrRetMail(SC5->C5_AXATEN1))

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Dados para envio de e-mail (Pedido de vendas)"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 609
oDlg:nHeight := 353
oDlg:lShowHint := .F.
oDlg:lCentered := .F.

oGrp1 := TGROUP():Create(oDlg)
oGrp1:cName := "oGrp1"
oGrp1:cCaption := "Dados do cliente"
oGrp1:nLeft := 43
oGrp1:nTop := 20
oGrp1:nWidth := 543
oGrp1:nHeight := 134
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oGet3 := TGET():Create(oDlg)
oGet3:cName := "oGet3"
oGet3:cCaption := "oGet3"
oGet3:nLeft := 56
oGet3:nTop := 58
oGet3:nWidth := 502
oGet3:nHeight := 21
oGet3:lShowHint := .F.
oGet3:lReadOnly := .F.
oGet3:Align := 0
oGet3:cVariable := "_cCliente"
oGet3:bSetGet := {|u| If(PCount()>0,_cCliente:=u,_cCliente) }
oGet3:lVisibleControl := .T.
oGet3:lPassword := .F.
oGet3:lHasButton := .F.
oGet3:bWhen := {|| .f. }

oSay4 := TSAY():Create(oDlg)
oSay4:cName := "oSay4"
oSay4:cCaption := "E-Mail"
oSay4:nLeft := 61
oSay4:nTop := 103
oSay4:nWidth := 68
oSay4:nHeight := 17
oSay4:lShowHint := .F.
oSay4:lReadOnly := .F.
oSay4:Align := 0
oSay4:lVisibleControl := .T.
oSay4:lWordWrap := .F.
oSay4:lTransparent := .F.

oGet5 := TGET():Create(oDlg)
oGet5:cName := "oGet5"
oGet5:cCaption := "oGet5"
oGet5:nLeft := 137
oGet5:nTop := 101
oGet5:nWidth := 420
oGet5:nHeight := 21
oGet5:lShowHint := .F.
oGet5:lReadOnly := .F.
oGet5:Align := 0
oGet5:cVariable := "_cEmailCli"
oGet5:bSetGet := {|u| If(PCount()>0,_cEmailCli:=u,_cEmailCli) }
oGet5:lVisibleControl := .T.
oGet5:lPassword := .F.
oGet5:lHasButton := .F.
oGet5:bValid := {|| naovazio() }

oGrp8 := TGROUP():Create(oDlg)
oGrp8:cName := "oGrp8"
oGrp8:cCaption := "Com Copia para"
oGrp8:nLeft := 43
oGrp8:nTop := 167
oGrp8:nWidth := 543
oGrp8:nHeight := 95
oGrp8:lShowHint := .F.
oGrp8:lReadOnly := .F.
oGrp8:Align := 0
oGrp8:lVisibleControl := .T.

oGet9 := TGET():Create(oDlg)
oGet9:cName := "oGet9"
oGet9:cCaption := "oGet9"
oGet9:nLeft := 55
oGet9:nTop := 195
oGet9:nWidth := 502
oGet9:nHeight := 21
oGet9:lShowHint := .F.
oGet9:lReadOnly := .F.
oGet9:Align := 0
oGet9:cVariable := "_cUsuario"
oGet9:bSetGet := {|u| If(PCount()>0,_cUsuario:=u,_cUsuario) }
oGet9:lVisibleControl := .T.
oGet9:lPassword := .F.
oGet9:lHasButton := .F.
oGet9:bWhen := {|| .f. }

oGet10 := TGET():Create(oDlg)
oGet10:cName := "oGet10"
oGet10:cCaption := "oGet10"
oGet10:nLeft := 54
oGet10:nTop := 227
oGet10:nWidth := 503
oGet10:nHeight := 21
oGet10:lShowHint := .F.
oGet10:lReadOnly := .F.
oGet10:Align := 0
oGet10:cVariable := "_cMailCop"
oGet10:bSetGet := {|u| If(PCount()>0,_cMailCop:=u,_cMailCop) }
oGet10:lVisibleControl := .T.
oGet10:lPassword := .F.
oGet10:lHasButton := .F.
oGet10:bWhen := {|| .f. }

oSBtn11 := SBUTTON():Create(oDlg)
oSBtn11:cName := "oSBtn11"
oSBtn11:cCaption := "Enviar"
oSBtn11:nLeft := 314
oSBtn11:nTop := 282
oSBtn11:nWidth := 52
oSBtn11:nHeight := 22
oSBtn11:lShowHint := .F.
oSBtn11:lReadOnly := .F.
oSBtn11:Align := 0
oSBtn11:lVisibleControl := .T.
oSBtn11:nType := 1
oSBtn11:bAction := {|| _fWFR005(), oDlg:End() }

oSBtn12 := SBUTTON():Create(oDlg)
oSBtn12:cName := "oSBtn12"
oSBtn12:cCaption := "oSBtn12"
oSBtn12:nLeft := 455
oSBtn12:nTop := 283
oSBtn12:nWidth := 52
oSBtn12:nHeight := 22
oSBtn12:lShowHint := .F.
oSBtn12:lReadOnly := .F.
oSBtn12:Align := 0
oSBtn12:lVisibleControl := .T.
oSBtn12:nType := 2
oSBtn12:bAction := {|| oDlg:End() }

oDlg:Activate()

RestArea(_aAreaA1)
RestArea(_aAreaA3)
RestArea(_aArea)

Return                           


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fWFR005   ºAutor  ³Adriano Luis Brandaoº Data ³  10/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para disparar e-mail.                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fWFR005()

If ! ApMsgYesNo("Confirma o envio de e-mail ao cliente ???")
	Return
EndIf

MsgRun("Enviando e-mail para o cliente e vendedor !!!",,{ || _fEnvio() })

Return               


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fEnvio   ºAutor  ³Adriano Luis Brandaoº Data ³  10/03/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de disparo do e-mail ao cliente e vendedores.       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fEnvio()

oProcess := TWFProcess():New( "ORC1", "Orcamento a vencer - Alpax" )

// Cria-se uma nova tarefa para o processo.
oProcess:NewTask( "Orcamento", "\WORKFLOW\PEDIDO.HTM" )
oProcess:cSubject := "Confirmacao do Pedido de vendas - Alpax - Nr. " + SC5->C5_NUM
oProcess:cTo  := _cEmailCli
oProcess:cCC  := _cMailCop
oProcess:cBCC := ""
oProcess:bReturn := ""

// Faz uso do objeto ohtml que pertence ao processo
oHtml := oProcess :oHtml

oHtml:ValByName( "CPED"   		, SC5->C5_NUM)
oHtml:ValByName( "CATEND"   	, _cUsuario)
oHtml:ValByName( "CMAILUS"   	, UsrRetMail(SC5->C5_AXATEN1))
oHtml:ValByName( "CDATABASE"   	, Dtoc(dDataBase))
oHtml:ValByName( "CCLIENTE"   	, _cCliente)
oHtml:ValByName( "CCNPJ"   		, SA1->A1_CGC)
oHtml:ValByName( "CFONE"   		, SA1->A1_TEL)
oHtml:ValByName( "CFAX"   		, SA1->A1_FAX)
oHtml:ValByName( "CEMAIL"   	, SA1->A1_EMAIL)
oHtml:ValByName( "CCONTATO"   	, SA1->A1_CONTATO)
oHtml:ValByName( "CPAG"   		, Posicione("SE4",1,xFilial("SE4")+SC5->C5_CONDPAG,"E4_DESCRI"))


/*
Do Case
	Case SA1->A1_EST == "SP"
		_cICMS = "18,00"
	Case SA1->A1_EST $ "MG/PR/RJ/RS/SC"
		_cICMS := "12,00"
	Otherwise
		_cICMS := "07,00"
EndCase
*/

_nPosProd	:= aScan(aHeader,{ |x| Alltrim(x[2]) == "C6_PRODUTO"	})
_nPosQtde	:= aScan(aHeader,{ |x| Alltrim(x[2]) == "C6_QTDVEN"		})
_nPosEntr	:= aScan(aHeader,{ |x| Alltrim(x[2]) == "C6_ENTREG"		})
_nPosUnit	:= aScan(aHeader,{ |x| Alltrim(x[2]) == "C6_PRCVEN"		})
_nPosItem	:= aScan(aHeader,{ |x| Alltrim(x[2]) == "C6_ITEM"		})
_nPosTes	:= aScan(aHeader,{ |x| Alltrim(x[2]) == "C6_TES"		})

SB1->(DbSetOrder(1))                             
SF4->(DbSetOrder(1))

_nTotal := 0
For _nY := 1 to Len(aCols)
	SB1->(DbSeek(xFilial("SB1")+aCols[_nY,_nPosProd]))     
	SF4->(DbSeek(xFilial("SF4")+aCols[_nY,_nPosTes]))	

	_nUnitcIPI 	:=  aCols[_nY,_nPosUnit]  //aCols[_nY,_nPosUnit]*(SB1->B1_IPI/100+1)

	AAdd( (oHtml:ValByName( "IT.QUANT"		))	,aCols[_nY,_nPosQtde])
	AAdd( (oHtml:ValByName( "IT.ITEM"		))	,aCols[_nY,_nPosItem])
	AAdd( (oHtml:ValByName( "IT.PRAZO"		))	,aCols[_nY,_nPosEntr])
	AAdd( (oHtml:ValByName( "IT.PRUNIT"		))	,TRANSFORM(aCols[_nY,_nPosUnit],"@e 999,999,999.99"))
	AAdd( (oHtml:ValByName( "IT.PRCIPI"		))	,TRANSFORM(_nUnitcIPI,"@e 999,999,999.99"))
	AAdd( (oHtml:ValByName( "IT.PRTOTAL"	))	,TRANSFORM(_nUnitcIPI*aCols[_nY,_nPosQtde],"@e 999,999,999.99"))
	AAdd( (oHtml:ValByName( "IT.DESCPRO"	))	,SB1->B1_DESC)
	AAdd( (oHtml:ValByName( "IT.CLASSIF"	))	,SB1->B1_POSIPI)
	AAdd( (oHtml:ValByName( "IT.MARCA"		))	,SB1->B1_MARCA)
	AAdd( (oHtml:ValByName( "IT.IPI"		))	,TRANSFORM(SB1->B1_IPI,"@e 99.99"))
//	AAdd( (oHtml:ValByName( "IT.ICMS"		))	,_cICMS)
	AAdd( (oHtml:ValByName( "IT.ICMS"		))	,Transform(AliqIcms("N","S",SA1->A1_TIPO),"@e 99.99"))
	AAdd( (oHtml:ValByName( "IT.UN"			))	,SB1->B1_UM)
	AAdd( (oHtml:ValByName( "IT.CAPACID"	))	,SB1->B1_CAPACID)	
	AAdd( (oHtml:ValByName( "IT.PART"		))	,SB1->B1_PNUMBER)	
	_nTotal += (_nUnitcIPI*aCols[_nY,_nPosQtde])
Next _nY

oHtml:ValByName( "TOTPED"   	, TRANSFORM(_nTotal,"@e 999,999,999.99"))

oProcess:Start()   
ApMsgAlert("Pedido enviado por e-mail !!!!")

Return