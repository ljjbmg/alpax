#Include "Protheus.ch"
#Include "Topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA015   ºAutor  ³Adriano Luis Brandaoº Data ³  22/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para dar manutencao nas tabelas SZR - Cadastro de    º±±
±±º          ³orgaos, e SZS de cadastro de classificacao.                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATA015()


Private aRotina := {{ "Pesquisar","AxPesqui",0,1,0,.t.},;
{ "Visualizar","U_MANFAT015",0,2},;
{ "Incluir"   ,"U_MANFAT015",0,3},;
{ "Alterar"   ,"U_MANFAT015",0,4},;
{ "Excluir"   ,"U_MANFAT015",0,5}}

cCadastro := "Cadastro de Orgaos e classificacoes"

dbSelectArea("SZR")
dbSetOrder(1)
mBrowse(06,01,22,75,"SZR")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA015   ºAutor  ³Adriano Luis Brandaoº Data ³  22/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para manutencao nas tabelas                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MANFAT015(cAlias,nReg,nOpc)

Local aArea     := GetArea()
Local aPosObj   := {}
Local aObjects  := {}
Local aSize     := {}
Local aInfo     := {}
Local aPosGet   := {}
Local aStruPA4  := {}
Local aButtons	:= {} //[02] Defina aqui os Botoes da sua EnchoiceBar
Local nGetLin   := 0
Local nStyle    := 0
Local nUsado    := 0
Local nX        := 0
Local nOpcA     := 0
Local nCntFor   := 0

Local cCadastro := "Cadastro de Classificacoes"
Local cQuery    := ""

Local lCopia    := nOpc==8 //[01] Se no futuro precisar incluir opção de copia.
Local lContinua := .T.
Local lQuery    := .F.
Local lMemo     := .F.

Local oDlg
Local oSay

Local _cMenAviso

Private aHeader   := {}
Private aCols     := {}
Private aTELA[0][0]
Private aGETS[0]
Private oGetDad
Private oGetD

DEFAULT nOpc      := 2
DEFAULT INCLUI    := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica a Operacao                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case INCLUI .Or. lCopia
		nstyle := GD_INSERT+GD_UPDATE+GD_DELETE
	Case ALTERA
		nStyle := GD_INSERT+GD_UPDATE+GD_DELETE
	OtherWise
		nStyle := 0
EndCase

dbSelectArea("SX3")
dbSetOrder(1)
DbSeek("SZS")

_cNaoUsado := "ZS_ORGAO"

Do While ! SX3->(Eof()) .And. SX3->X3_ARQUIVO == "SZS"
	If X3USO(X3_USADO) .And. cNivel >= X3_NIVEL .And. ! (Alltrim(SX3->X3_CAMPO) $ _cNaoUsado)
		aAdd(aHeader,{X3Titulo(),X3_CAMPO,X3_PICTURE,X3_TAMANHO,X3_DECIMAL,X3_VALID,X3_USADO,X3_TIPO,X3_F3,X3_CONTEXT})
	Endif
	dbSkip()
EndDo


SZS->(DbSetOrder(1))
// ZS_FILIAL+ZS_ORGAO+ZS_CON
If ! Inclui
	If SZS->(DbSeek(xFilial("SZS")+SZR->ZR_CODIGO))
		Do While ! SZS->(Eof()) .And. (SZS->ZS_FILIAL+SZS->ZS_ORGAO) == (xFilial("SZS")+SZR->ZR_CODIGO)
			aAdd(aCols,Array(len(aHeader)+1))
			For nX := 1 to Len(aHeader)
				_cCampo := Alltrim(aHeader[nX,2])
				If aHeader[nX,10] <> "V"
					aCols[Len(aCols),nX] := SZS->(FieldGet(FieldPos(_cCampo)))
				Else
					aCols[Len(aCols),nX] := CriaVar(aHeader[nX,2])
				EndIf
			Next nX
			aCols[Len(aCols),Len(aHeader)+1] := .f.
			SZS->(DbSkip())
		EndDo
	Else
		aAdd(aCols,Array(len(aHeader)+1))
		For nX := 1 to Len(aHeader)
			_cCampo := Alltrim(aHeader[nX,2])
			aCols[Len(aCols),nX] := CriaVar(aHeader[nX,2])
		Next nX
		aCols[Len(aCols),Len(aHeader)+1] := .f.
	EndIf
Else
	aAdd(aCols,Array(len(aHeader)+1))
	For nX := 1 to Len(aHeader)
		_cCampo := Alltrim(aHeader[nX,2])
		aCols[Len(aCols),nX] := CriaVar(aHeader[nX,2])
	Next nX
	aCols[Len(aCols),Len(aHeader)+1] := .f.
EndIf

If ! Inclui
	
	If ApMsgYesNo("Ordenar por descricao","Confirmar")
		
		_nPosDesc := aScan(aHeader,{|x| Alltrim(x[2]) == "ZS_DESCR"})
		If _nPosDesc > 0
			aSort(aCols,,,{|x,y| x[_nPosDesc] < y[_nPosDesc]} )
		EndIf
		
	EndIf
	
Endif

If INCLUI
	RegToMemory( "SZR", .T., .F. )
Else
	RegToMemory( "SZR", .F., .F. )
EndIf


aFolder1:= {"Orgão"}
aFolderIt := {"Classificao"}
aSize := MsAdvSize()
AAdd( aObjects, { 100, 080 , .T., .F. } )
AAdd( aObjects, { 100, 100	, .T., .T. } )
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5, 5 }
aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)

_lGrava := .f.

Aadd(aButtons,{"S4WB001N", {|| fCod()}, "Ordem Codigo"})
Aadd(aButtons,{"CARGA", {|| fDesc()}, "Ord.Descricao"})



DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

oFolder1:= TFolder():New(aPosObj[1,1],aPosObj[1,2],aFolder1,{},oDlg,,,,.T.,.F.,aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1],)
oFoldIt1:= TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolderIt,{},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1],)

oEnchoice:=MsMGet():New("SZR",1,nOpc,,,,,aPosObj[1],,,,,,oFolder1:aDialogs[1],,.T.)
oEnchoice:oBox:Align := CONTROL_ALIGN_ALLCLIENT
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4

oGetD := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nStyle,"AllWaysTrue","AllWaysTrue",/*"+PAB_ITEM"*/,;
/*acpos*/,/*freeze*/,999,/*fieldok*/,/*superdel*/,/*delok*/,oFoldIt1:aDialogs[1],@aHeader,@aCols)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| _lGrava := .t.,If(oGetD:TudoOk(),oDlg:End(),_lGrava := .f.)},{||oDlg:End()},,aButtons)

If _lGrava
	MsgRun("Aguarde, gravando os dados",,{ ||fGrava015(nOpc)})
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGrava015 ºAutor  ³Adriano Luis Brandaoº Data ³  22/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para gravacao das tabelas                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fGrava015(nOpc)
//
// Se for Inclusao ou alteracao.
//

SZR->(DbSetOrder(1))
SZS->(DbSetOrder(1))

If nOpc == 3 .Or. nOpc == 4
	
	If ! SZR->(DbSeek(xfilial("SZR")+M->ZR_CODIGO))
		RecLock("SZR",.t.)
	Else
		RecLock("SZR",.f.)
	EndIf
	For nA := 1 TO FCount()
		If "FILIAL"$Field(nA)
			FieldPut(nA,xFilial('SZR'))
		Else
			cCampo :=  FieldName(nA)
			FieldPut(nA,M->&(cCampo))
		EndIf
	Next nA
	SZR->(msunlock())
	
	_nPosCON := aScan(oGetD:aHeader,{|x| Alltrim(x[2]) == "ZS_CON"})
	
	For _nY := 1 To Len(oGetD:aCols)
		If ! oGetD:aCols[_nY,Len(oGetD:aHeader)+1]
			If SZS->(DbSeek(xFilial("SZS")+M->ZR_CODIGO+oGetD:aCols[_nY,_nPosCON]))
				RecLock("SZS",.f.)
			Else
				RecLock("SZS",.t.)
			EndIf
			SZS->ZS_FILIAL := xFilial("SZS")
			For _nZ := 1 to Len(oGetD:aHeader)
				_cCampo := Alltrim(oGetD:aHeader[_nZ,2])
				SZS->(&_cCampo) := oGetD:aCols[_nY,_nZ]
			next _nZ
			SZS->ZS_ORGAO := M->ZR_CODIGO
			SZS->(MsUnLock())
		Else
			If SZS->(DbSeek(xFilial("SZS")+M->ZR_CODIGO+oGetD:aCols[_nY,_nPosCON]))
				RecLock("SZS",.f.)
				Delete
				SZS->(MsUnLock())
			EndIf
		EndIf
	Next _nY
EndIf
//
// Se for exclusao
//
If nOpc == 5
	SZS->(DbSeek(xFilial("SZS")+M->ZR_CODIGO))
	Do While ! SZS->(Eof()) .And. SZS->ZS_FILIAL == xFilial("SZS") .And. SZS->ZS_ORGAO == M->ZR_CODIGO
		RecLock("SZS",.f.)
		Delete
		SZS->(MsUnLock())
		SZS->(DbSkip())
	EndDo
	
	If SZR->(Dbseek(xFilial("SZR")+M->ZR_CODIGO))
		RecLock("SZR",.f.)
		Delete
		SZR->(MsUnLock())
	EndIf
EndIf

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA015   ºAutor  ³Adriano Luis Brandaoº Data ³  02/06/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ordena por descricao                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fDesc()
_nPosDesc := aScan(aHeader,{|x| Alltrim(x[2]) == "ZS_DESCR"})
If _nPosDesc > 0
	aSort(oGetD:aCols,,,{|x,y| x[_nPosDesc] < y[_nPosDesc]} )
EndIf
oGetD:Refresh()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCod      ºAutor  ³Adriano Luis Brandaoº Data ³  02/06/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ordena por codigo.                                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fCod()
_nPosDesc := aScan(aHeader,{|x| Alltrim(x[2]) == "ZS_CON"})
If _nPosDesc > 0
	aSort(oGetD:aCols,,,{|x,y| x[_nPosDesc] < y[_nPosDesc]} )
EndIf

oGetD:Refresh()
Return
