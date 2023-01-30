#Include "Topconn.ch"
#Include "Protheus.ch"
#INCLUDE "rwmake.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA012   ºAutor  ³Ocimar Rolli        º Data ³  09/02/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para alterar vendedor no cabecalho do pedido de     º±±
±±º          ³ vendas (SC5).                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATA012()

Private cCadastro := "Alteracao pedido Vendas"


Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","AxVisual",0,2} ,;
{"Alterar","U_fA012()",0,4} }

dbSelectArea("SC5")

mBrowse( 6,1,22,75,"SC5")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fA012    ºAutor  ³Ocimar Rolli        º Data ³  09/02/08    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela de alteracao principal.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fA012()

Local _cTitulo		:= "ALTERACAO DO VENDEDOR NO PEDIDO DE VENDA"
Private _cPedido	:= SC5->C5_NUM
Private _cCliente	:= SC5->C5_AXNOMCL
Private _cVend      := SC5->C5_VEND1
Private _cNomeVen	:= Posicione("SA3",1,xFilial("SA3")+_cVend,"A3_NOME")
Private oGetPesq1,oPedido,oCliente

// verifica se pode ser alterado o pedido.

If ! __cUserId $ "000016/000001/000203/000360/000054"
	ApMsgStop("Voce nao tem acesso para alterar o vendedor no pedido....")
	Return
endif

DEFINE MSDIALOG oDlg TITLE _cTitulo FROM 2,10 TO 180,600 OF oMainWnd Pixel

@ 15,010 Say "Pedido" Pixel
@ 15,075 MsGet oPedido Var _cPedido Size 30,08 Pixel of oDlg When .f.
@ 30,010 Say "Cliente" Pixel
@ 30,075 MsGet oCliente Var _cCliente Size 180,08 Pixel of oDlg When .f.
@ 45,010 Say "Codigo do Vendedor" 		Pixel
@ 45,075 MsGet oGetPesq1 VAR _cVend 	Size 30,08 	F3 "SA3" valid Existcpo("SA3") Pixel OF oDlg
_cNomeVen	:= Posicione("SA3",1,xFilial("SA3")+_cVend,"A3_NOME")
@ 60,010 Say "Nome do Vendedor" 		Pixel
@ 60,075 MsGet oVendedor VAR _cNomeVen 	Size 180,08 Pixel of oDlg When .f.


//@ 90,010 Say "tipo de liberacao"                                                         //OCIMAR 16/05/07
//@ 90,050 MSCOMBOBOX oTipLib VAR cTipLIb ITEMS aTipLIb SIZE 100,8 OF oDlg PIXEL           //OCIMAR 16/05/07                                                                      OCIMAR 16/05/07

ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{ || fGrava(), oDlg:End()},{ || oDlg:End() } )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGrava    ºAutor  ³Ocimar Rolli        º Data ³  09/02/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de gravacao do vendedor no cabecalho do pedido de   º±±
±±º          ³ vendas.                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGrava()

Local nRet := 0

If ApMsgYesNo("Confirma Alteracao ???","Confirmar")
	
	Begin Transaction
	
	RecLock("SC5",.f.)
	
	SC5->C5_VEND1   := _cVend
	SC5->C5_COMIS1  := Posicione("SA3",1,xFilial("SA3")+_cVend,"A3_COMIS")
	SC5->(MsUnLock())
	
	End Transaction

// Rotina para inclusao da comissao nos itens do pedido  --  Ocimar 30/08/2012
	
	cLinPed := POSICIONE("SC6",1,XFILIAL("SC6")+_cPedido,"C6_ITEM")

		Do While ! Eof() .And. SC6->C6_FILIAL = xFilial("SC6") .And. SC6->C6_NUM==_cPedido

			If SC6->C6_QTDVEN > SC6->C6_QTDENT
				nRet := U_ALPG002( _cVend, SC6->C6_PRODUTO, SC6->C6_PRCVEN, SC6->C6_VALOR, SC6->C6_CLI)
				RecLock("SC6",.f.)
				SC6->C6_COMIS1 := nRet
				SC6->(MsUnLock())
			EndIf
			
            nRet := 0
			SC6->(DbSkip())
		EndDo
		
	EndIf
	Return
