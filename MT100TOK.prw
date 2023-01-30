#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT100TOK  ºAutor  ³Adriano Luis Brandaoº Data ³  28/01/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para validacao da nota fiscal de entrada. º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MT100TOK()

Private _lRet := .t.

_aArea 		:= GetArea()
_aAreaF4 	:= SF4->(GetArea())

//U_ICMSD1("T") // tratamento icms 4% eduardo biale

If !l103Auto
	
	//If CTIPO == "N" .And. CESPECIE <> "CTR"
	If CTIPO == "N" .And. !ALLTRIM(CESPECIE) $ "CTR/CTE"
		
		_nPosPed	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "D1_PEDIDO" })
		_nPosTes	:= Ascan(aHeader,{|x| Alltrim(x[2]) == "D1_TES" })
		For _nY := 1 To Len(aCols)
			if Empty(aCols[_nY,_nPosPed]) .AND. Posicione("SF4",1,xFilial("SF4")+aCols[_nY,_nPosTes],"F4_DUPLIC")=="S"
				_lRet := .f.
			EndIf
		Next _nY
		
	EndIf
	
	If ! _lRet
		ApMsgStop("Nota Fiscal nao sera gravada, existem itens sem numero de pedido de compras")
	EndIf
	//
	// se for devolucao o usuario devera preencher o campo D1_AXPROC com procedente ou Improcedente.
	//
	If _lRet .And. CTIPO == "D"
		_nPosProc  := aScan(aHeader,{|x| Alltrim(x[2]) == "D1_AXPROC" })
		_nPosProc1 := aScan(aHeader,{|x| Alltrim(x[2]) == "D1_AXREDE" })
		For _nY := 1 To Len(aCols)
			If aCols[_nY,_nPosProc] == "N" .Or. AllTrim(aCols[_nY,_nPosProc1]) == "NAO USADO"
				_lRet := .f.
			EndIf
		Next _nY
		
		If ! _lRet
			ApMsgStop("Favor informar os campos (Status da Devolucao) e (Responsavel pela Devolucao) !!!","Bloqueado")
		EndIf
	EndIf
	
	RestArea(_aAreaF4)
	RestArea(_aArea)
	
//Else
	
	// IMPORTA XML
	//lRet:= U_GTPE005()
	
EndIf 
// IMPORTA XML
If _lRet
	_lRet:= U_GTPE005()
EndIf	

Return(_lRet)