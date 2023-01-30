/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG003   ºAutor  ³Ocimar Rolli        º Data ³  11/10/09   º±±
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

User Function ESTG003()
Private _nCusto    := M->B1_UPRC
Private _nAliqIpi  := M->B1_IPI/100                                                       
Private _nAliqSt   := M->B1_PICMENT/100
Private _nValor    := 0
Private _nValIpi   := (_nCusto*_nAliqIpi)
Private _nValSt    := (((_nCusto+(_nCusto*(_nAliqIpi)))*(1+_nAliqST))*0.18)
Private _nVlIcmN   := (_nCusto*0.18) 
Private _cProd     := M->B1_COD

// LIMPA AREA TEMPORARIA
IF SELECT("QR1") <> 0
	DBSELECTAREA("QR1")
	DBCLOSEAREA("QR1")
ENDIF

_cQuery := "SELECT D1_VALIPI, D1_BRICMS, D1_BASEICM "
_cQuery += "FROM " + RetSqlName("SD1") + " SD1 "
_cQuery += "INNER JOIN " + RetSqlName("SF1") + " SF1 "
_cQuery += "ON D1_DOC = F1_DOC AND D1_SERIE = F1_SERIE AND D1_FORNECE = F1_FORNECE "
_cQuery += "WHERE SD1.R_E_C_N_O_ IN (SELECT MAX(R_E_C_N_O_) FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "WHERE D1.D1_COD = '"+_cProd+"' AND D1.D_E_L_E_T_ = ' ' AND D1.D1_TIPO = 'N') AND F1_STATUS = 'A'"

DbUseArea(.T.,'TOPCONN',TCGENQRY(,,_cQuery),"QR1",.F.,.T.)

TcSetField("QR1","D1_VALIPI" 	  ,"N",12,2)
TcSetField("QR1","D1_BRICMS"	  ,"N",12,2)
TcSetField("QR1","D1_BASEICM"     ,"N",12,0)

Private _nValor    := 0
Private _nValIpiN  := QR1->D1_VALIPI
Private _nBasRet   := QR1->D1_BRICMS
Private _nBasIcm   := QR1->D1_BASEICM
Private _nNovo     := ((_nBasRet/(_nBasIcm+_nValIpiN)))
Private _nValStN   := (((_nCusto+(_nCusto*(_nAliqIpi)))*(_nNovo*0.18)))

//PEGAR NA ULTIMA OPERAÇÃO DE ENTRADA O IVA AJUSTADO

If _nBasRet <> 0
	_nValSt := _nValStN
EndIf


Do Case
	
	Case _nAliqIpi==0 .And. _nAliqST==0
		_nValor := _nCusto
	Case _nAliqIpi<>0 .And. _nAliqST==0
		If M->B1_ORIGEM $ "1/6" 
			_nValor := _nCusto                                                                                                    
		Else
			_nValor := (_nCusto+_nValIpi)
		EndIf	
	Case _nAliqIpi==0 .And. _nAliqST<>0
		_nValor := (_nCusto+(_nValST-_nVlIcmN))
	Case _nAliqIpi<>0 .And. _nAliqST<>0
		_nValor := (_nCusto+_nValIpi+(_nValST-_nVlIcmN))
EndCase

Return(_nValor)
