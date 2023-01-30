#Include "Topconn.ch"
#Include "Protheus.ch"
#INCLUDE "rwmake.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATA030   บAutor  ณAdriano Luis Brandaoบ Data ณ  12/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para alterar campos do cabecalho do pedido de vendasบฑฑ
ฑฑบ          ณ (SC5).                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
Ultima altera็ใo por Carlos Henrique Totalit em 21/09/2022
*/

User Function FATA030()

Private cCadastro := "Alteracao pedido Vendas"


Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","AxVisual",0,2} ,;
{"Alterar","U_fA030()",0,4} }

dbSelectArea("SC5")

mBrowse( 6,1,22,75,"SC5")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfA030    บAutor  ณAdriano Luis Brandaoบ Data ณ  12/05/07    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela de alteracao principal.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fA030()

Local _cTitulo		:= "ALTERACAO PEDIDO VENDA "
Private _cPedido	:= SC5->C5_NUM
Private _cCliente	:= SC5->C5_AXNOMCL
Private _cTransp 	:= SZJ->ZJ_TRANSP
Private _cDesc		:= Posicione("SA4",1,xFilial("SA4")+SZJ->ZJ_TRANSP,"A4_NOME")
Private oGetPesq1,oGetPesq2,oGetPesq3,oGetPesq4,oGetPesq5,oPedido,oCliente
Private aFrete 		:= {"CIF","FOB", "Terceiros", "Remetente", "Destinatแrio", "Sem Frete" }  //Carlos H. Totalit em 21/09/2022
Private cFrete	 	:= "" //iif(SC5->C5_TPFRETE=="C","CIF","FOB")
Private _cTransp	:= SC5->C5_TRANSP
Private _cCondPag	:= SC5->C5_CONDPAG
Private _cMens1		:= SC5->C5_MENNOTA
Private _cMens2		:= SC5->C5_MENSERV
Private aTipLib     := {"1-POR ITEM","2-POR PEDIDO"}                                        //OCIMAR 06/12/16
Private aItPar      := {"S-SIM","N-NAO"}                                                    //OCIMAR 29/03/17
Private oTipLIb                                                                             //OCIMAR 06/12/16
Private cTipLib     := iif(SC5->C5_TIPLIB =="1","1-POR ITEM","2-POR PEDIDO")                //OCIMAR 06/12/16
Private oItPar                                                                              //OCIMAR 29/03/17
Private cItPar      := iif(SC5->C5_AXLIBPR =="S","S-SIM","N-NAO")                           //OCIMAR 29/03/17
Private oPedCli                                                                             //OCIMAR 06/03/19
Private cPedCli     := SC5->C5_AXPEDCL                                                      //OCIMAR 06/03/19
Private cEndEnt  	:= SC5->C5_AXENDEN
Private aEndEnt
Private oEndEnt

Do CASE                                                                                          //Carlos H. Totalit em 21/09/2022
    CASE SC5->C5_TPFRETE== "C"
		cFrete := "CIF"

	CASE SC5->C5_TPFRETE== "F"
		cFrete := "FOB"

	CASE SC5->C5_TPFRETE== "T"
		cFrete := "Terceiros"

	CASE SC5->C5_TPFRETE== "R"
		cFrete := "Remetente"

	CASE SC5->C5_TPFRETE== "D"
		cFrete := "Destinatแrio"

	CASE SC5->C5_TPFRETE== "S"
		cFrete := "Sem Frete"

ENDCASE

// verifica se pode ser alterado o pedido.

If SC5->C5_AXATEN1 <> __cUserId .and. ! __cUserId $ "000000/000001/000005/000016/000042/000054/000087/000102/000160/000203/000248/000447"
	// se nao ้ o usuario do pedido, testa se ้ supervisor do atendente
	PswOrder(1)
	if PswSeek(SC5->C5_AXATEN1,.t.)
		_aSuperior :=pswret(1)
		If _aSuperior[1,11] <> __cUserId		// se tambem nao ้ o supervisor do atendente bloqueia alteracao
			ApMsgStop("Este pedido pertence a outro usuario, vc nao pode altera-lo....")
			Return
		EndIf
	Else
		ApMsgStop("Este pedido pertence a outro usuario, vc nao pode altera-lo....")
		Return
	Endif
endif

DEFINE MSDIALOG oDlg TITLE _cTitulo FROM 2,10 TO 300,700 OF oMainWnd Pixel

@ 15,010 Say "Pedido" Pixel
@ 15,050 MsGet oPedido Var _cPedido Size 30,08 Pixel of oDlg When .f.
@ 30,010 Say "Cliente" Pixel
@ 30,050 MsGet oCliente Var _cCliente Size 150,08 Pixel of oDlg When .f.
@ 45,010 Say "Tipo Frete" PIXEL
@ 45,050 MSCOMBOBOX oFrete VAR cFrete ITEMS aFrete SIZE 45,8 OF oDlg PIXEL
@ 45,120 Say "Transportadora" 		Pixel
/*If __cUserId $ "000001/000005/000042/000229/000160/000248"
@ 45,170 MsGet oGetPesq1 VAR _cTransp 	Size 20,08 	F3 "SA4" valid Existcpo("SA4") Pixel OF oDlg
Else
@ 45,170 Say "{ "+_cTransp+" }" Pixel
End
*/
@ 45,170 MsGet oGetPesq1 VAR _cTransp 	Size 20,08 	F3 "SA4" valid Existcpo("SA4") Pixel OF oDlg
@ 45,220 Say "Condicao"		    		Pixel
@ 45,270 MsGet oGetPesq2 VAR _cCondPag 	Size 20,08 	F3 "SE4" valid Existcpo("SE4") Pixel OF oDlg
@ 60,010 Say "Mens. Danfe"      		Pixel
@ 60,050 MsGet oGetPesq4 VAR _cMens1 	Size 280,08	Pixel OF oDlg
@ 75,010 Say "Mens. Servico"			Pixel
@ 75,050 MsGet oGetPesq5 VAR _cMens2 	Size 280,08 Pixel OF oDlg
@ 90,010 Say "tipo de liberacao"                                                         //OCIMAR 06/12/16
@ 90,080 MSCOMBOBOX oTipLib VAR cTipLIb ITEMS aTipLIb SIZE 100,8 OF oDlg PIXEL           //OCIMAR 06/12/16
@ 90,200 Say "item parcial"
@ 90,250 MSCOMBOBOX oItPar VAR cItPar ITEMS aItPar SIZE 080,8 OF oDlg PIXEL              //OCIMAR 29/03/17
@ 105,010 Say "Endereco de entrega"                                                      //OCIMAR 06/12/16
@ 105,080 MsGet oEndEnt VAR cEndEnt 	Size 250,08	Pixel OF oDlg                        //OCIMAR 06/12/16
@ 120,010 Say "Pedido do Cliente"                                                        //OCIMAR 06/03/19
@ 120,080 MsGet oEndEnt VAR cPedCli 	Size 250,08	Pixel OF oDlg                        //OCIMAR 06/03/19                                                                      OCIMAR 16/05/07

ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{ || iif(fValida(),(fGrava(),oDlg:End()),fMensblq()) },{ || oDlg:End() } )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGrava    บAutor  ณAdriano Luis Brandaoบ Data ณ  12/05/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de gravacao dos dados no cabecalho do pedido de ven บฑฑ
ฑฑบ          ณ das.                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fGrava()

If ApMsgYesNo("Confirma Alteracao ???","Confirmar")
	
	Begin Transaction
	
	RecLock("SC5",.f.)
	
	SC5->C5_TPFRETE := Left(cFrete,1)
	SC5->C5_TRANSP	:= _cTransp
	SC5->C5_CONDPAG	:= _cCondPag
	SC5->C5_MENNOTA	:= _cMens1
	SC5->C5_MENSERV	:= _cMens2
	SC5->C5_TIPLIB  := Left(cTipLib,1)                                                   //OCIMAR 06/12/16
	SC5->C5_AXLIBPR := Left(cItPar,1)                                                    //OCIMAR 29/03/17
	SC5->C5_AXENDEN := cEndEnt
	SC5->C5_AXPEDCLI:= cPedCli                                                           //OCIMAR 06/03/19
	SC5->(MsUnLock())
	
	End Transaction
	
	Posicione("SC6",1,xFilial("SC6")+_cPedido,"C6_AXLIBPR")
	
	If SC6->C6_AXLIBPR <> cItPar
		Do While ! SC6->(Eof()) .And. _cPedido == SC6->C6_NUM
			RecLock("SC6",.f.)
			SC6->C6_AXLIBPR := cItPar
			SC6->C6_AXPEDCL := cPedCli
			SC6->(MsUnLock())
			SC6->(DbSkip())
		EndDo
	EndIf
	
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfmensBlq  บAutor  ณAdriano Luis Brandaoบ Data ณ  21/01/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de mensagem de bloqueio.                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fMensblq()


If _cTransp <> " "
	ApMsgStop("Esta transportadora nใo tem licen็a para alguns produtos","Altera็ใo Invalida")
Else
	ApMsgStop("Transportadora retira nao pode ser incluida no pedido por aqui")
EndIf
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfValida   บAutor  ณAdriano Luis Brandaoบ Data ณ  21/01/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de validacao da alteracao da transportadora, checandoบฑฑ
ฑฑบ          ณas licen็as.                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fValida()

Local _aItens	:= {}
Local _lRet		:= .t.

If _cTransp <> " "
	
	_cAlias := GetNextAlias()
	
	_cQuery := "SELECT C6_PRODUTO, C6_QTDVEN-C6_QTDENT AS SALDO "
	_cQuery += "FROM " + RetSqlName("SC6") + " C6 "
	_cQuery += "WHERE C6_FILIAL = '" + xFilial("SC6") + "' AND C6_NUM = '" + _cPedido + "' "
	_cQuery += "      AND (C6_QTDVEN-C6_QTDENT) > 0 "
	_cQuery += "      AND D_E_L_E_T_ = ' ' "
	
	TcQuery _cQuery New Alias (_cAlias)
	
	TcSetField((_cAlias),"SALDO","N",12,2)
	
	Do While ! (_cAlias)->(Eof())
		aAdd(_aItens,{(_cAlias)->C6_PRODUTO,(_cAlias)->SALDO})
		
		(_cAlias)->(DbSkip())
	EndDo
	
	If ! Empty(_aItens)
		_aRet1	:= U_ESTV004("T",_cTransp,_aItens)				// Checa as Licencas da transportadora por produto
		// Retorno
		// _aRet[1] = .t. ou .f. = se foi aprovado
		// _aRet[2] = Log da aprovacao
		// _aRet[3] = Mostra ou nao Log, retorno .t. ou .f. (Para os casos de monitore)
		If ! _aRet1[1]
			_lRet := .f.
		EndIf
	EndIf
	
	(_cAlias)->(DbCloseArea())
	
Else                                                                       
	If _cTransp <> SC5->C5_TRANSP
		_lRet := .f.
	Else
		_lRet := .t.
	EndIf
EndIf

Return(_lRet)
