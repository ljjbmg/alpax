/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG001   ºAutor  ³Ocimar Rolli        º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de venda na inclusao ou al-  º±±
±±º          ³  teracao do preco de compra (IPI / Sub. Tribut.)           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"                 '
#Include "Protheus.ch"

User Function ESTG001()

Private _nCusto    := M->B1_UPRC
Private _nValMin   := 0
Private _nAliqIpi  := M->B1_IPI/100
Private _nAliqSt   := M->B1_PICMENT/100
Private _nIndCad   := M->B1_AXINDIC
Private _nIndMar   := Posicione("SZ2",2,xFilial("SZ2")+M->B1_MARCA,"SZ2->Z2_INDPRV")
Private _nValor    := 0
Private _nValIpi   := (_nCusto*_nAliqIpi)
Private _nValSt    := (((_nCusto+(_nCusto*(_nAliqIpi)))*(1+_nAliqST))*0.18)
Private _nVlIcmN   := (_nCusto*0.18)
Private _nIndImp	:= Posicione("SZ2",2,xFilial("SZ2")+M->B1_MARCA,"SZ2->Z2_INDPRVI")
Private _cMarca		:= GetNewPar("MV_AXMARCA","LOGEN")

// se for importado, troca para o novo indice de importados.
If M->B1_ORIGEM $ "1/6"
	_nIndMar := _nIndImp
EndIf

// Se for marca Logen parametro MV_AXMARCA altera indice
If Alltrim(M->B1_MARCA) $ _cMarca
	If M->B1_XSITPRO  == "I"
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+M->B1_MARCA,"SZ2->Z2_INDPRVI")
	ElseIf M->B1_XSITPRO  == "N"
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+M->B1_MARCA,"SZ2->Z2_INDPRV")
	Else
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+M->B1_MARCA,"SZ2->Z2_INDPRDV")
	EndIf
EndIf

Do Case
	
	Case _nAliqIpi==0 .And. _nAliqST==0
		_nValor := (_nCusto*iif(_nIndCad == 0,_nIndMar,_nIndCad))
	Case _nAliqIpi<>0 .And. _nAliqST==0
		If M->B1_ORIGEM == "1"
			_nValor := _nCusto*iif(_nIndCad == 0,_nIndMar,_nIndCad)
		Else
			_nValor := (_nCusto+_nValIpi)*iif(_nIndCad == 0,_nIndMar,_nIndCad)
		EndIf
	Case _nAliqIpi==0 .And. _nAliqST<>0
		_nValor := (_nCusto+(_nValST-_nVlIcmN))*iif(_nIndCad == 0,_nIndMar,_nIndCad)
	Case _nAliqIpi<>0 .And. _nAliqST<>0
		_nValor := (_nCusto+_nValIpi+(_nValST-_nVlIcmN))*iif(_nIndCad == 0,_nIndMar,_nIndCad)
EndCase

Return(_nValor)
