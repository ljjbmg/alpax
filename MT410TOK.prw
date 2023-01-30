/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT410TOK  ºAutor  ³Adriano Luis Brandao º Data ³  07/09/11  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para validacao de campos adicionais na     º±±
±±º          ³confirmacao do pedido de vendas.                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Protheus.ch"


User Function MT410TOK()

Local _nY			:= 0
Local _nX			:= 0
Local _nPosCalib	:= aScan(aHeader,{|x| Alltrim(x[2]) == "C6_AXCALIB"})
Local _nPosPtCal	:= aScan(aHeader,{|x| Alltrim(x[2]) == "C6_AXPTCAL"})
Local _nPosToler	:= aScan(aHeader,{|x| Alltrim(x[2]) == "C6_AXTOLER"})
Local _nPosItem		:= aScan(aHeader,{|x| Alltrim(x[2]) == "C6_ITEM"})
Local _nPosProd  	:= aScan(aHeader,{|x| Alltrim(x[2]) == "C6_PRODUTO"})	
Local _nPosPed		:= aScan(aHeader,{|x| Alltrim(x[2]) == "C6_NUM"})	
Local _lRet			:= .t.
Local _cMens		:= ""
Local _cEol			:= CHR(13)+CHR(10)
Local _area			:= GetArea()
Local nOpc          := PARAMIXB[1]

For _nY := 1 To Len(aCols)
	If ! aCols[_nY,len(aHeader)+1]
		If aCols[_nY,_nPosCalib] == "S"
			If Empty(aCols[_nY,_nPosPtCal]) .Or. Empty(aCols[_nY,_nPosToler])
				_cMens	+= "O Item " + aCols[_nY,_nPosItem] + " Produto " + Alltrim(aCols[_nY,_nPosProd]) 
				_cMens	+= " precisa ser preenchido o campo Ponto Calibragem ou Tolerancia " + _cEol 
				_lRet	:= .f.				
			EndIf
	    EndIf
	EndIf
Next _nY

If ! Empty(_cMens)
	fMens(_cMens)
EndIf

If nOpc == 1
	For _nX := 1 To Len(aCols)
	alert("for")
		If !aCols[_nX,len(aHeader)+1]
			DbSelectArea("ZZ1")
			ZZ1->(DbSetOrder(1))
			Alert("Entrou"+Alltrim(aCols[_nX,_nPosPed])+"-"+Alltrim(aCols[_nX,_nPosProd]))
			If ZZ1->(Dbseek(xfilial("ZZ1") + Alltrim(aCols[_nX,_nPosPed]) + Alltrim(aCols[_nX,_nPosProd])))
				_cMens := 'Pedido de Venda tem Solicitação em Aberto ' + "Num. " + ZZ1->ZZ1_SOLIC 
				fMens(_cMens)
				_lRet := .F.
			Else 
			Alert("Nao encontrou ZZ1")
			endif
		EndIf
	Next
	
End
RestArea(_area)
Return(_lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fMens     ºAutor  ³Adriano Luis Brandaoº Data ³  07/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³funcao para mostrar a tela de mensagens.                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fMens(_cMens)

Local aSize := MsAdvSize()
Local aObjects := {}
Local aInfo
Local aPosObj
Local oDlg                            

AAdd( aObjects, { 100, 010 , .T., .F. } )
AAdd( aObjects, { 100, 090 , .T., .T. } )
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5, 5 }
aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)

cCadastro := "Campos não preenchidos"

DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 To aSize[6]-100,aSize[5]-50 of oMainWnd PIXEL
oObs:=TMultiGet():New(014,003,{|u| If(PCount()>0,_cMens := u,_cMens)},oDlg,aPosObj[2,4]-30,aPosObj[2,3]-070,,.F.,,,,.T.,"",.f.,,.F.,.F.,.T.,,,.F.,,.F.)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| oDlg:End()},{||oDlg:End()},,)

Return
