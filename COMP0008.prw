#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "rwmake.ch"

user function COMP0008()
Local _NUM    	:= SC7->C7_NUM
Local _FOROLD 	:= Alltrim(SC7->C7_FORNECE)
Local _LJOLD	:= Alltrim(SC7->C7_LOJA)
Local _DESCOLD	:= ''
Local _DATA		:= DTOS(SC7->C7_DATPRF) 
Local _FORNEW	:= _FOROLD //SPACE(06)
Local _LJNEW	:= _LJOLD  //SPACE(02)
Local _DescNEW  := SPACE(40)
Local oLocal
Local _DTNEW	:= SC7->C7_DATPRF
Local _Prod		:= Space(20)
Dbselectarea("SA2")

_DESCOLD := POSICIONE("SA2", 1, xFilial("SA2")+ _FOROLD +_LJOLD ,"A2_NOME")
_DATA		:= Substring(_DATA,7,2)+'/'+Substring(_DATA,5,2)+'/'+Substring(_DATA,1,4)
_DescNEW := _DESCOLD
DEFINE MSDIALOG oLocal FROM 000,200 TO 300,590 TITLE "Altera Fornecedor Pedido: "+_NUM PIXEL
	@ 003,005 TO 125,190//090,105
	//@ 005,007 SAY "PEDIDO: "+_NUM        SIZE  60, 7
	@ 008,007 SAY "Fornecedor Atual .: " SIZE  60, 7
	@ 023,007 SAY "Codigo/Loja:" SIZE  60, 7
	@ 022,055 SAY _FOROLD +' - '+_LJOLD   SIZE  39, 9
	@ 033,007 SAY "Razão: " SIZE  60, 7
	@ 032,055 SAY _DESCOLD PICTURE "@!" SIZE  150, 9
	@ 043,007 SAY "Data Pref.: " SIZE  60, 7
	@ 042,075 SAY _DATA    SIZE  60,10
	@ 052,007 SAY REPLICATE( '-', 90 )
	
	@ 063,007 SAY "Fornecedor Novo" SIZE  60, 7
	@ 073,007 SAY "Código: " SIZE  60, 7
	@ 072,055 get _FORNEW F3 "XSA2" PICTURE "@!" SIZE  39, 9 When (Iif(__cUserId $ "000000",.T.,.F.))
	@ 083,007 SAY "Loja: "  SIZE  60, 7
	@ 082,055 GET _LJNEW SIZE  39, 9	When (Iif(__cUserId $ "000000",.T.,.F.))
	@ 093,007 SAY "Descrição: " SIZE  60, 7
	@ 092,055 GET _DescNew  SIZE  130, 9	When (Iif(__cUserId $ "000000",.T.,.F.))
	@ 103,007 SAY "Nova Data Pref.: " SIZE  60, 7
	@ 102,055 GET _DTNEW  PICTURE "@D" SIZE  130, 9
	@ 113,007 Say "Produto" Size 60,7
	@ 112,055 GET _Prod F3 "SB1" PICTURE "@!" SIZE  130, 9


	DEFINE SBUTTON FROM 130,010 TYPE 1 ACTION {||Gravar(_NUM,_FORNEW,_LJNEW,_DTNEW,_Prod),Close(oLocal)}   ENABLE OF oLocal
	DEFINE SBUTTON FROM 130,070 TYPE 2 ACTION Close(oLocal) ENABLE OF oLocal
	ACTIVATE MSDIALOG oLocal CENTER	


return


Static Function GRAVAR(_NUM,_FORNEW,_LJNEW,_DTNEW,_Prod)
Local cNUM 		:= _NUM
Local cCOD		:= _FORNEW
Local cLoja 	:= _LJNEW
Local dDTNEW	:= _DTNEW
Local cProduto  := _Prod
Local _oldcod
Local _odllj

////Verifica se o pedido não foi recebido anteriormente/////

_QRY := " SELECT * FROM "+RETSQLNAME("SC7")
_QRY += " WHERE D_E_L_E_T_ = '' AND C7_QUJE > 0 AND C7_RESIDUO = '' "
_QRY += " AND C7_NUM = '"+cNUM+"' ""
_QRY += " AND C7_PRODUTO = '"+cProduto+"' ""
MemoWrite("\queries\comp0008.sql",_QRY)

IF SELECT("TSC7") > 0
	TSC7->(DBCLOSEAREA())
ENDIF

dbUseArea( .T., "TOPCONN", TcGenQry(,,_QRY), "TSC7", .T., .F. )
dbSelectArea("TSC7")
TSC7->(dbGoTop())

IF TSC7->(!EOF())
	cTexto	:= " Este pedido não pode ser alterado, devido ter havido algum recebimento de mercadoria."+CHR(10)+CHR(13)+" Dúvidas favor entrar em contato com a TI."
	cTitulo	:= " Erro na Alteração de Fornecedor!"
	MSGALERT( cTexto, cTitulo )

Return

ENDIF
//////////////////////////////////////////////////////////////
IF ALLTRIM(cCOD) == '' .OR. ALLTRIM(cLoja) == ''
	cTexto	:= " Favor escolher um fornecedor para continuar com a alteração."+CHR(10)+CHR(13)+" Dúvidas favor entrar em contato com a TI."
	cTitulo	:= " Erro na Alteração de Fornecedor!"
	MSGALERT( cTexto, cTitulo )
	RETURN
ENDIF


////////////////////////////// Processa Alteração ////////////
IF MSGYESNO("Confirma a Troca de Data?")
		
	Dbselectarea("SC7")
	DBSETORDER(1)
	IF SC7->(DBSEEK(XFILIAL('SC7')+cNUM))
		_oldcod := SC7->C7_FORNECE
		_odllj 	:= SC7->C7_LOJA
		WHILE SC7->(!EOF()) .AND. SC7->C7_NUM == cNUM 
			
			IF Empty(AllTrim(cProduto))
				RECLOCK("SC7",.F.)
				SC7->C7_FORNECE := cCOD
				SC7->C7_LOJA	:= cLoja
				SC7->C7_DATPRF	:= dDTNEW
				SC7->(MSUNLOCK())
			
			ElseIf AllTrim(SC7->C7_PRODUTO) = AllTrim(cProduto)

				RECLOCK("SC7",.F.)
				SC7->C7_FORNECE := cCOD
				SC7->C7_LOJA	:= cLoja
				SC7->C7_DATPRF	:= dDTNEW
				SC7->(MSUNLOCK())
			
			End
		SC7->(DBSKIP())
		ENDDO
		
		MSGINFO('Alteração realizada com Sucesso!')
	ELSE
	 	ALERT('Por Favor refaça o processo, caso continue dando esta mensagem procure o departamento de TI')
	ENDIF
Else 

	MSGINFO("Processo Abortado")

Endif
/////////////////////////////////////////////


Return


