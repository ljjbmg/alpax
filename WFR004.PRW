/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณWFR004    บAutor  ณAdriano Luis Brandaoบ Data ณ  28/02/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para disparar e-mail orcamento.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"

User Function WFR004()

Local oDlg,oGrp1,oGet3,oSay4,oGet5,oGrp8,oGet9,oGet10,oSBtn11,oSBtn12

_aArea 		:= GetArea()
_aAreaA1 	:= SA1->(GetArea())
_aAreaA3	:= SA3->(GetArea())
_aAreaCJ    := SCJ->(GetArea())

SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))

_cCliente 	:= SA1->A1_NOME
_cEmailCli	:= SA1->A1_EMAIL
_cContato	:= SA1->A1_CONTATO
_cUsuario	:= UsrRetName(SCJ->CJ_AXATEND)//cUserName
//_cMailCop	:= UsrRetMail(__cUserID)
_cMailCop	:= Alltrim(Posicione("SA3",1,xFilial("SA3")+SCJ->CJ_AXVEND,"A3_EMAIL"))
_cMailCop	:= iif(Empty(_cMailCop),UsrRetMail(SCJ->CJ_AXATEND),_cMailCop+";"+UsrRetMail(SCJ->CJ_AXATEND))
_cMens01	:= Space(065)
_cMens02	:= Space(065)
_cMens03	:= Space(065)

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Dados para envio de e-mail (orcamento)"
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
oGrp1:nHeight := 155
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oGet3 := TGET():Create(oDlg)
oGet3:cName := "oGet3"
oGet3:cCaption := "oGet3"
oGet3:nLeft := 56
oGet3:nTop := 38
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
oSay4:nTop := 070
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
oGet5:nTop := 070
oGet5:nWidth := 420
oGet5:nHeight := 21
oGet5:lShowHint := .F.
oGet5:lReadOnly := .F.
oGet5:Align := 0
oGet5:cVariable := "_cEmailCli"
oGet5:bSetGet := {|u| If(PCount()>0,_cEmailCli:=u,_cEmailCli) }
oGet5:lVisibleControl := .T.
oGet5:lPassword := .F.
oGet5:cF3 := "AC8"
oGet5:lHasButton := .F.
oGet5:bValid := {|| naovazio() }

oSay5 := TSAY():Create(oDlg)
oSay5:cName := "oSay5"
oSay5:cCaption := "Mensagem "
oSay5:nLeft := 61
oSay5:nTop := 100
oSay5:nWidth := 68
oSay5:nHeight := 17
oSay5:lShowHint := .F.
oSay5:lReadOnly := .F.
oSay5:Align := 0
oSay5:lVisibleControl := .T.
oSay5:lWordWrap := .F.
oSay5:lTransparent := .F.

oGet6 := TGET():Create(oDlg)
oGet6:cName := "oGet6"
oGet6:cCaption := "oGet6"
oGet6:nLeft := 137
oGet6:nTop := 100
oGet6:nWidth := 420
oGet6:nHeight := 21
oGet6:lShowHint := .F.
oGet6:lReadOnly := .F. 
oGet6:Align := 0
oGet6:cVariable := "_cMens01"
oGet6:bSetGet := {|u| If(PCount()>0,_cMens01:=u,_cMens01) }
oGet6:lVisibleControl := .T.
oGet6:lPassword := .F.
oGet6:lHasButton := .F.

oGet7 := TGET():Create(oDlg)
oGet7:cName := "oGet7"
oGet7:cCaption := "oGet7"
oGet7:nLeft := 137
oGet7:nTop := 120
oGet7:nWidth := 420
oGet7:nHeight := 21
oGet7:lShowHint := .F.
oGet7:lReadOnly := .F. 
oGet7:Align := 0
oGet7:cVariable := "_cMens02"
oGet7:bSetGet := {|u| If(PCount()>0,_cMens02:=u,_cMens02) }
oGet7:lVisibleControl := .T.
oGet7:lPassword := .F.
oGet7:lHasButton := .F.

oGet8 := TGET():Create(oDlg)
oGet8:cName := "oGet8"
oGet8:cCaption := "oGet8"
oGet8:nLeft := 137
oGet8:nTop := 140
oGet8:nWidth := 420
oGet8:nHeight := 21
oGet8:lShowHint := .F.
oGet8:lReadOnly := .F. 
oGet8:Align := 0
oGet8:cVariable := "_cMens03"
oGet8:bSetGet := {|u| If(PCount()>0,_cMens03:=u,_cMens03) }
oGet8:lVisibleControl := .T.
oGet8:lPassword := .F.
oGet8:lHasButton := .F.


oGrp8 := TGROUP():Create(oDlg)
oGrp8:cName := "oGrp8"
oGrp8:cCaption := "Com Copia para"
oGrp8:nLeft := 43
oGrp8:nTop := 177
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
oSBtn11:bAction := {|| _fWFR004(), oDlg:End() }

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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fWFR004  บAutor  ณAdriano Luis Brandaoบ Data ณ  28/02/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para confirmar o disparo do e-mail                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fWFR004()
//
// Altera a variavel de contato do e-mail caso tenha selecionado outro.
//
_cContato := iif(Alltrim(_cEmailCli) <> Alltrim(SA1->A1_EMAIL),SU5->U5_CONTAT,_cContato)

If ! ApMsgYesNo("Confirma o envio de e-mail ao cliente ???")
	Return
EndIf

MsgRun("Enviando e-mail para o cliente e vendedor !!!",,{ || U_fEnv004() })

Return               


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfEnv004   บAutor  ณAdriano Luis Brandaoบ Data ณ  28/02/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de disparo do e-mail ao cliente e vendedores ou     บฑฑ
ฑฑบ          ณ as contas enviados pelos parametros recebidos na funcao.   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - Alpax.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fEnv004(_cEmail,_cCopia)

_cQuery := "SELECT CK_QTDVEN, CK_ENTREG, CK_PRCVEN, CK_ITEM, CK_PRODUTO, CK_OBS, CK_TES, "
_cQuery += "       B1_DESC, B1_POSIPI, B1_MARCA, B1_PNUMBER, B1_CAPACID, B1_IPI, B1_UM, B1_AXFOTO, "
_cQuery += "       CONVERT(TEXT,CONVERT(VARCHAR(8000),CONVERT(VARBINARY(8000),B1_AXTECNI))) TECNI, B1.R_E_C_N_O_  "
_cQuery += "FROM " + RetSqlName("SCK") + " CK, " + RetSqlName("SB1") + " B1 "
_cQuery += "WHERE CK_FILIAL = '" + xFilial("SCK") + "' AND B1_FILIAL = '" + xFilial("SB1")+ "' AND "
_cQuery += "      CK.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND CK_PRODUTO = B1_COD AND CK_NUM = '"
_cQuery +=        SCJ->CJ_NUM + "' "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","CK_ENTREG","D",08,0)
TcSetField("QR1","CK_PRCVEN","N",12,2)
TcSetField("QR1","B1_IPI"	,"N",12,2)

psworder(1)
if pswseek(SCJ->CJ_AXATEND,.t.)
        _aDaduser:=pswret(1)
endif     


oProcess := TWFProcess():New( "ORC1", "Orcamento - Alpax" )

// Cria-se uma nova tarefa para o processo.
oProcess:NewTask( "Orcamento", "\WORKFLOW\ORCAMENTO.HTM" )
oProcess:cSubject := "Orcamentos - Alpax - Nr. " + SCJ->CJ_NUM
If _cEmail == Nil
	oProcess:cTo  := _cEmailCli
	oProcess:cCC  := _cMailCop
Else
	oProcess:cTo  := _cEmail
	If _cCopia <> Nil
		oProcess:cCC  := _cCopia
	EndIf
	SA1->(DbSetOrder(1))
	SA1->(DbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
	_cCliente 	:= SA1->A1_NOME                        
	SU5->(DbsetOrder(1))
	If SU5->(Dbseek(xfilial("SU5")+SCJ->CJ_AXCTATO))
		_cContato	:= Alltrim(SU5->U5_CONTAT)
		_cEmailCli	:= SU5->U5_EMAIL
	Else
		_cContato	:= SA1->A1_CONTATO
	EndIf
	_cUsuario	:= UsrRetName(SCJ->CJ_AXATEND)//cUserName
	//_cMailCop	:= UsrRetMail(__cUserID)
	_cMens01	:= Space(065)
	_cMens02	:= Space(065)
	_cMens03	:= Space(065)
EndIf
oProcess:cBCC := ""
oProcess:bReturn := ""              

// Faz uso do objeto ohtml que pertence ao processo
oHtml := oProcess :oHtml

oHtml:ValByName( "CORC"   		, SCJ->CJ_NUM)
oHtml:ValByName( "CATEND"   	, _aDaduser[1,4])
oHtml:ValByName( "CMAILUS"   	, UsrRetMail(SCJ->CJ_AXATEND))
oHtml:ValByName( "CDATABASE"   	, Dtoc(dDataBase))
oHtml:ValByName( "CCLIENTE"   	, _cCliente)
oHtml:ValByName( "CCNPJ"   		, SA1->A1_CGC)
oHtml:ValByName( "CFONE"   		, SA1->A1_TEL)
oHtml:ValByName( "CFAX"   		, SA1->A1_FAX)
oHtml:ValByName( "CEMAIL"   	, _cEmailCli)  // SUBSTITUIDO SA1->A1_EMAIL
oHtml:ValByName( "CCOND"		, Posicione("SE4",1,xFilial("SE4")+SCJ->CJ_CONDPAG,"E4_DESCRI"))
oHtml:ValByName( "CCONT"		, _cContato)
oHtml:ValByName( "FATMIN"		, Getmv("MV_ALFATMIN"))
oHtml:ValByName( "MENS1"		, _cMens01)
oHtml:ValByName( "MENS2"		, _cMens02)
oHtml:ValByName( "MENS3"		, _cMens03)

Do Case
	Case SA1->A1_EST == "SP"
		_cICMS = "18,00"
	Case SA1->A1_EST $ "MG/PR/RJ/RS/SC"
		_cICMS := "12,00"
	Otherwise
		_cICMS := "07,00"
EndCase

_nTotal := 0

SB1->(DbSetOrder(1))
SF4->(DbSetOrder(1))
Do While ! QR1->(Eof())
	// Busca nome do arquivo a anexar sem o path.
	_cAnexo := ""
	If ! Empty(QR1->B1_AXFOTO)
		_cAnx	:= Alltrim(QR1->B1_AXFOTO)
		For _nX := Len(_cAnx) To 1 Step -1
			If Substr(_cAnx,_nX,1) <> "\"
				_cAnexo := Substr(_cAnx,_nX,1)+_cAnexo
			Else
				_nX := -1
			EndIf
		Next _nX
	EndIf

	_nUnitcIPI 	:= QR1->CK_PRCVEN //QR1->CK_PRCVEN*(QR1->B1_IPI/100+1)          

	SB1->(DbSeek(xFilial("SB1")+QR1->CK_PRODUTO))
	SF4->(DbSeek(xFilial("SF4")+QR1->CK_TES))

	AAdd( (oHtml:ValByName( "IT.QUANT"		))	,QR1->CK_QTDVEN)
	AAdd( (oHtml:ValByName( "IT.ITEM"		))	,QR1->CK_ITEM)
	AAdd( (oHtml:ValByName( "IT.PRAZO"		))	,QR1->CK_ENTREG)
	AAdd( (oHtml:ValByName( "IT.PRUNIT"		))	,TRANSFORM(QR1->CK_PRCVEN,"@e 999,999,999.99"))
	AAdd( (oHtml:ValByName( "IT.PRCIPI"		))	,TRANSFORM(_nUnitcIPI,"@e 999,999,999.99"))
	AAdd( (oHtml:ValByName( "IT.PRTOTAL"	))	,TRANSFORM(_nUnitcIPI*QR1->CK_QTDVEN,"@e 999,999,999.99"))
	AAdd( (oHtml:ValByName( "IT.DESCPRO"	))	,QR1->B1_DESC)
	AAdd( (oHtml:ValByName( "IT.CLASSIF"	))	,QR1->B1_POSIPI)
	AAdd( (oHtml:ValByName( "IT.MARCA"		))	,QR1->B1_MARCA)
	AAdd( (oHtml:ValByName( "IT.IPI"		))	,TRANSFORM(QR1->B1_IPI,"@e 99.99"))
	AAdd( (oHtml:ValByName( "IT.ICMS"		))	,TRANSFORM(AliqIcms("N","S",SA1->A1_TIPO),"@e 99.99") )
	AAdd( (oHtml:ValByName( "IT.UN"			))	,QR1->B1_UM)
//	AAdd( (oHtml:ValByName( "IT.DADOS"		))	,QR1->TECNI)   // voltei a linha.       
	AAdd( (oHtml:ValByName( "IT.DADOS"		))	,SB1->B1_AXTECNI)   
	AAdd( (oHtml:ValByName( "IT.PART"		))	,QR1->B1_PNUMBER)
	AAdd( (oHtml:ValByName( "IT.CAPACID"	))	,QR1->B1_CAPACID)
	AAdd( (oHtml:ValByName( "IT.OBS"		))	,QR1->CK_OBS)
	AAdd( (oHtml:ValByName( "IT.ANEXO"		))	,_cAnexo)	
	// se existir foto anexa no e-mail o arquivo.
	If ! Empty(_cAnexo)
		oProcess:AttachFile(QR1->B1_AXFOTO)
	Endif
	_nTotal += (_nUnitcIPI*QR1->CK_QTDVEN)
	QR1->(DbSkip())
EndDo

oHtml:ValByName( "TOTCOT"		, Transform(_nTotal,"@e 999,999,999.99"))
oHtml:ValByName( "FRET"			, iif(SCJ->CJ_AXFRETE=="C","CIF","FOB"))

oProcess:Start()   

If _cEmail == Nil
	ApMsgAlert("Orcamento enviado por e-mail !!!!")
EndIf

QR1->(DbCloseArea())
	
Return