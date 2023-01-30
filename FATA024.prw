#Include "Topconn.ch"
#Include "Protheus.ch"
#INCLUDE "rwmake.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA024   ºAutor  ³Ocimar Rolli        º Data ³  09/02/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para alterar vendedor no cabecalho do orçamento de  º±±
±±º          ³ vendas (SCJ).                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATA024()

Private cCadastro := "Alteracao orçamento de vendas"


Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","AxVisual",0,2} ,;
{"Alterar","U_fA024()",0,4} }

dbSelectArea("SCJ")

mBrowse( 6,1,22,75,"SCJ")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fA024    ºAutor  ³Ocimar Rolli        º Data ³  09/02/08    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela de alteracao principal.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fA024()

Local _cTitulo		:= "ALTERACAO DO VENDEDOR NO ORÇAMENTO DE VENDA"
Private _cOrcame	:= SCJ->CJ_NUM
Private _cCliente	:= SCJ->CJ_CLIENTE
Private _cVend      := SCJ->CJ_AXVEND
Private _cNomeVen	:= Posicione("SA3",1,xFilial("SA3")+_cVend,"A3_NOME")
Private oGetPesq1,oPedido,oCliente

// verifica se pode ser alterado o orçamento.

If ! __cUserId $ "000016/000001/000203/000360/000054"
	ApMsgStop("Voce nao tem acesso para alterar o vendedor no orcamento....")
	Return
endif

DEFINE MSDIALOG oDlg TITLE _cTitulo FROM 2,10 TO 180,600 OF oMainWnd Pixel

@ 15,010 Say "Orçamento" Pixel
@ 15,075 MsGet oOrcame Var _cOrcame Size 30,08 Pixel of oDlg When .f.
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
	
	RecLock("SCJ",.f.)
	SCJ->CJ_AXVEND   := _cVend
	SC5->(MsUnLock())
	
	End Transaction

// Rotina para inclusao da comissao nos itens do pedido  --  Ocimar 30/08/2012
	
	cLinOrc := POSICIONE("SCK",1,XFILIAL("SCK")+_cOrcame,"CK_ITEM")

		Do While ! Eof() .And. SCK->CK_FILIAL = xFilial("SCK") .And. SCK->CK_NUM==_cOrcame

			nRet := U_ALPG002( _cVend, SCK->CK_PRODUTO, SCK->CK_PRCVEN, SCK->CK_VALOR, SCK->CK_CLIENTE)
			RecLock("SCK",.f.)
			SCK->CK_COMIS1 := nRet
			SCK->(MsUnLock())
			
            nRet := 0
			SCK->(DbSkip())
		EndDo
		
	EndIf
	Return
