/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG008   ºAutor  ³Ocimar Rolli        º Data ³  24/10/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de custo na inclusao ou al-  º±±
±±º          ³  teracao do preco de compra (IPI / Sub. Tribut.)           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"                 '
#Include "Protheus.ch"

User Function ESTG008()

Private _cProd     := M->B1_COD
Private _nCusto    := M->B1_UPRC
Private _nAliqIpi  := M->B1_IPI/100
Private _nAliqSt   := M->B1_PICMENT
Private _nOrigem   := M->B1_ORIGEM

_cQuery := "SELECT D1_VUNIT, D1_ICMSRET, D1_QUANT "
_cQuery += "FROM " + RetSqlName("SD1") + " SD1 "
_cQuery += "WHERE SD1.R_E_C_N_O_ IN (SELECT MAX(R_E_C_N_O_) FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "WHERE D1.D1_COD = '"+_cProd+"' AND D1.D_E_L_E_T_ = ' ' AND D1.D1_TIPO = 'N')"

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D1_VUNIT" 	  ,"N",12,2)
TcSetField("QR1","D1_ICMSRET"	  ,"N",12,2)
TcSetField("QR1","D1_QUANT"	      ,"N",12,0)

Private _nValor    := 0
Private _nUnitar   := QR1->D1_VUNIT
Private _nValRet   := QR1->D1_ICMSRET
Private _nQuant    := QR1->D1_QUANT
Private _nInd      := (1+((_nValRet/_nQuant)/_nUnitar))              
Private _nValIpi   := (_nCusto*_nAliqIpi)
Private _nVlIcmN   := (_nCusto*0.18)

//SE NA ULTIMA OPERACAO NAO TIVER ST

If _nValRet == 0
	_nInd := (1+((_nAliqSt*_nCusto)/_nCusto))
EndIf

Do Case
	
	Case _nAliqIpi==0 .And. _nAliqST==0
		_nValor := _nCusto
	Case _nAliqIpi<>0 .And. _nAliqST==0
		If _nOrigem $ "1/6"
			_nValor := _nCusto
		Else
			_nValor := (_nCusto+_nValIpi)
		EndIf
	Case _nAliqIpi==0 .And. _nAliqST<>0
		_nValor := (_nCusto*_nInd)
	Case _nAliqIpi<>0 .And. _nAliqST<>0                              
	
		_nValor := (_nValIpi+(_nCusto*_nInd))
EndCase

QR1->(dbcloseArea())

Return(_nValor)
