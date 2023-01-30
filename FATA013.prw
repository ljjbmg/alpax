
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA013   ºAutor  ³Adriano Luis Brandaoº Data ³  15/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para alteracao da data de entrega.                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Protheus.ch"  

User Function FATA013()

Private cCadastro := "Alteracao Campos dos itens do pedido"


Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","AxVisual",0,2} ,;
{"Alterar","U_fA013",0,4} }

dbSelectArea("SC6")

mBrowse( 6,1,22,75,"SC6")


Return                


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA013     ºAutor  ³Adriano Luis Brandaoº Data ³  15/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela de alteracao da data de entrega                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fA013(cAlias,nReg,nOpc)

Private cUserAdm	:= AllTrim(SuperGetMv('MV_USRADM',.F.,"000000|000001|000005|000009|000016|000042|000054|000087|000102|000160|000203|000229|000074"))
Private _cPedido 	:= ""
Private _cPNumber	:= ""
Private _cProduto	:= ""
Private _dEntrega	:= ""
Private _aSuperior  := {}
// Verifica se o pedido esta liberado.
SC9->(DbSetOrder(1))
SC9->(DbSeek(xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM,.T.))
If (xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM) == (SC9->C9_FILIAL+SC9->C9_PEDIDO+SC9->C9_ITEM)
	If Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_BLCRED)
		ApMsgStop("Data não pode ser alterada, pedido já liberado para faturamento !!!","Aviso")
		Return
	EndIf	

EndIf



// Posiciona no cabecalho do pedido de vendas para encontrar o atendente.
SC5->(DbSetOrder(1))
SC5->(DbSeek(xFilial("SC5")+SC6->C6_NUM))
                                   

PswSeek(__cUserId,.t.)
_aSuperior :=pswret(0)

// se nao for o atendendo pedido e tambem nao pertencer ao grupo de administrador, valida o supervisor.	
If SC5->C5_AXATEN1 <> __cUserId .and. !_aSuperior[1,10,1] $ cUserAdm 

	// se nao é o usuario do pedido, testa se é supervisor do atendente
	PswOrder(1)
	if PswSeek(SC5->C5_AXATEN1,.t.)
		_aSuperior :=pswret(1)
		
		
		If _aSuperior[1,11] <> __cUserId // se tambem nao é o supervisor do atendente bloqueia alteracao
			ApMsgStop("Este pedido pertence a outro usuario, vc nao pode altera-lo....","FATA013")
			Return
		EndIf
		
	Else
		ApMsgStop("Este pedido pertence a outro usuario, vc nao pode altera-lo....","FATA013")
		Return
	Endif
endif
	

SB1->(DbSetOrder(1))
SB1->(DbSeek(xfilial("SB1")+SC6->C6_PRODUTO))

_cPedido 	:= SC6->C6_NUM
_cPNumber	:= SB1->B1_PNUMBER
_cProduto	:= SB1->B1_DESC+" - " + SB1->B1_MARCA+ " - " +SB1->B1_CAPACID
_dEntrega	:= SC6->C6_ENTREG


DEFINE MSDIALOG oDlg TITLE cCadastro FROM 2,10 TO 220,700 OF oMainWnd Pixel

@ 15,010 Say "Pedido" Pixel
@ 15,050 MsGet oPedido Var _cPedido Size 30,08 Pixel of oDlg When .f.
@ 30,010 Say "Part.Number" Pixel
@ 30,050 MsGet oPNumber Var _cPNumber Size 080,08 Pixel of oDlg When .f.
@ 45,010 Say "Produto" 		Pixel
@ 45,050 MsGet oProduto VAR _cProduto 	Size 180,08 pixel OF oDlg When .f.
@ 60,010 Say "Entrega"				Pixel
@ 60,050 MsGet oEntreg VAR _dEntrega 	Size 40,08 	valid _fValid() Pixel OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{ || fGrava(), oDlg:End()},{ || oDlg:End() } )
                                      
Return
                                                                   
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA013   ºAutor  ³Microsiga           º Data ³  08/29/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fValid()

PswSeek(__cUserId,.t.)
_aSuperior :=pswret(0)

_lRet := .t.
If _aSuperior[1,10,1] $ "000000/000016/000074/000010/000106/000198/000045/000203/000014/000001/000023"
	_lRet := (_dEntrega >= dDataBase)
	If !_lRet 
		ApMsgStop("Nao aceita data menor que a data base do sistema","Aviso")
	EndIf
Else
//	_lRet := (_dEntrega >= dDataBase + 3)
	If !_lRet                                 
		ApMsgStop("So aceita data acima de 3 dias, a partir de hoje","Aviso")
	EndIf	
	
EndIf 

Return(_lRet)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGRAVA    ºAutor  ³Adriano Luis Brandaoº Data ³  15/08/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gravar a data de entrega do produto.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP  - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGRAVA()

If ! ApMsgYesNo("Quer alterar em todos os itens do Pedido "+SC6->C6_NUM + " ?? ","CONFIRMAR")


	RecLock("SC6",.F.)
	SC6->C6_ENTREG := _dEntrega
	SC6->(MsUnLock())                                                                            

Else
	SC6->(DbSetOrder(1))
	SC6->(DbSeek(xFilial("SC6")+_cPedido))
	Do While ! SC6->(Eof()).And. SC6->C6_FILIAL == xFilial("SC6") .And. SC6->C6_NUM == _cPedido
		RecLock("SC6",.F.)
		SC6->C6_ENTREG := _dEntrega
		SC6->(MsUnLock())                                                                            
    	SC6->(DbSkip())
  
  	EndDo
EndIf

Return
