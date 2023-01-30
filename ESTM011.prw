/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTM011   ºAutor  ³Ocimar              º Data ³  18/08147   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para atualizacao do ultimo preco de compra,          º±±
±±º          ³preco de venda, preco minimo                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "Topconn.ch"                 
#Include "Protheus.ch"

User Function ESTM011(_aParam)

Private _cPerg := "ESTM11"
Private cCadastro := "Atualizacao Ultimo preco de compra"
Private aSays	  :={}
Private aButtons  :={}
Private nOpca	  := 0

If _aParam == Nil
	
	AADD(aSays,"Este programa ira atualizar o ultimo preco de compra, preco de custo," )
	AADD(aSays,"preco minimo e preco de venda de acordo com indice digitado nas perguntas")
	
	AADD(aButtons, { 5,.T.,{|| Pergunte(_cPerg,.T. )}})
	AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
	AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )
	
	FormBatch( cCadastro, aSays, aButtons )
	
	If nOpca == 1
		If ApMsgYesNo("Confirma atualizacao de acordo com as perguntas do parametro")
			Processa({|| fAtualiza()})
		EndIf
	EndIf
	
Else
	
	MV_PAR01 = _aParam[01]
	MV_PAR02 = _aParam[02]
	MV_PAR03 = _aParam[03]
	MV_PAR04 = _aParam[04]
	MV_PAR05 = _aParam[05]
	MV_PAR06 = _aParam[06]
	MV_PAR07 = _aParam[07]
	
	Processa({|| fAtualiza()})
	
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fatualiza ºAutor  ³Microsiga           º Data ³  13/01/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³funcao de processamento e atualizacao dos precos a partir   º±±
±±º          ³do B1_UPRC                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fAtualiza()

Private   _cQuery
Private   _nIndice  := MV_PAR07

SB1->(DbSetOrder(1))

_cQuery := "SELECT B1_COD, B1_UPRC, B1_AXCUS, B1_PRV1, B1_AXPRMIN, B1_XPRV4, B1_XPRMN4, B1_XPRV7, B1_XPRMN7, B1_XPRV12, B1_XPRMN12, B1_IPI, B1_PICMENT, B1_MARCA, B1_ORIGEM, B1_XSITPRO "
_cQuery += "       FROM " + RetSqlName("SB1") + " B1 "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "             AND B1_AXLINHA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "             AND B1_MARCA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_UPRC"	    ,"N",12,2)
TcSetField("QR1","B1_AXCUS"	    ,"N",12,2)
TcSetField("QR1","B1_PRV1"	    ,"N",12,2)
TcSetField("QR1","B1_AXPRMIN"   ,"N",12,2)
TcSetField("QR1","B1_XPRV4"	    ,"N",12,2)
TcSetField("QR1","B1_XPRMN4"    ,"N",12,2)
TcSetField("QR1","B1_XPRV7"	    ,"N",12,2)
TcSetField("QR1","B1_XPRMN7"    ,"N",12,2)
TcSetField("QR1","B1_XPRV12"    ,"N",12,2)
TcSetField("QR1","B1_XPRMN12"   ,"N",12,2)
TcSetField("QR1","B1_IPI"	    ,"N",03,2)
TcSetField("QR1","B1_PICMENT"	,"N",03,2)

_nLinha := 1

Do While ! QR1->(Eof())
	If SB1->(DbSeek(xFilial("SB1")+QR1->B1_COD))
		RecLock("SB1",.f.)
		If QR1->B1_UPRC <> 0
			SB1->B1_UPRC := (QR1->B1_UPRC*_nIndice)
			CALXCUS()
			CALCVEN()
		EndIf
		SB1->(MsUnLock())
		AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco compra produto " + SB1->B1_PNUMBER + " para R$." + Transform(SB1->B1_UPRC,"@E 9,999,999.99"))
	EndIf
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

AutoGrLog("***********  Termino da rotina")
_cArqIni := NomeAutoLog()
__CopyFile( _cArqIni, "LOG_ULTPRC.TXT" )
MostraErro()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CALXCUS   ºAutor  ³Ocimar Rolli        º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de custo na inclusao ou al-  º±±
±±º          ³  teracao do preco de compra (IPI / Sub. Tribut.)           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

STATIC Function CALXCUS()

Private _nCusto    := QR1->B1_UPRC
Private _nAliqIpi  := QR1->B1_IPI/100
Private _nAliqST   := QR1->B1_PICMENT/100
Private _nValor    := 0
Private _nValIpi   := (_nCusto*_nAliqIpi)
Private _nValST    := (((_nCusto+(_nCusto*(_nAliqIpi)))*(1+_nAliqST))*0.18)
Private _nVlIcmN   := (_nCusto*0.18)

Do Case
	
	Case _nAliqIpi==0 .And. _nAliqST==0
		_nValor := _nCusto
	Case _nAliqIpi<>0 .And. _nAliqST==0
		If SB1->B1_ORIGEM $ "1/6"
			_nValor := _nCusto
		Else
			_nValor := (_nCusto+_nValIpi)
		EndIf
	Case _nAliqIpi==0 .And. _nAliqST<>0
		_nValor := (_nCusto+(_nValST-_nVlIcmN))
	Case _nAliqIpi<>0 .And. _nAliqST<>0
		_nValor := (_nCusto+_nValIpi+(_nValST-_nVlIcmN))
EndCase

SB1->B1_AXCUS := _nValor

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CALCVEN   ºAutor  ³BIALE               º Data ³  01/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de venda 4 %, 7% e 12% na    º±±
±±º          ³  inclusao ou alteracao do preco de compra na tabela Sb1    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CALCVEN()

Local _aAreaZ2	:= SZ2->(GetArea())

Private _cMarca		:= "LOGEN"

SZ2->(DbSetOrder(2))

If SZ2->(Dbseek(xFilial("SZ2")+QR1->B1_MARCA))
	nPis 		:= 1.65 //aliquota de pis
	nCof		:= 7.60 //aliquota cofins
	nIcm		:= IIF(SB1->B1_PICM==0,18,SB1->B1_PICM) //ALIQUOTA DE ICM
	nPerc		:= (100 - (nPis + nCof + nIcm)) / 100   //percentual de calculo
	aTmp 		:= INDICEMR(SB1->B1_AXCUS * nPerc)      //PARA CALCULAR INDICE DE MARCA
	_nPrcMin1	:= aTmp[01]
	_nPrcVen1	:= aTmp[02]
	DO CASE
		CASE SB1->B1_ORIGEM $ "1|2|3|8|" //4%
			nPerc1 			:= (100 - (nPis + nCof + 4)) / 100  //percentual de calculo de 4%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_XPRV4		:= _nPrcVen
			SB1->B1_XPRMN4  	:= _nPrcMin
			SB1->B1_XPRV7     := 0
			SB1->B1_XPRMN7    := 0
			SB1->B1_XPRV12    := 0
			SB1->B1_XPRMN12   := 0
			nPerc1 			:= (100 - (nPis + nCof + 18)) / 100  //percentual de calculo de 4%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_PRV1      := _nPrcVen
			SB1->B1_AXPRMIN   := _nPrcMin
			
		CASE QR1->B1_ORIGEM $ "0|4|5|6|7|" //7% E 12%
			nPerc1 			:= (100 - (nPis + nCof + 7)) / 100  //percentual de calculo de 7%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_XPRV7		:= _nPrcVen
			SB1->B1_XPRMN7  	:= _nPrcMin
			nPerc1 			:= (100 - (nPis + nCof + 12)) / 100  //percentual de calculo de 7%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_XPRV12	:= _nPrcVen
			SB1->B1_XPRMN12 	:= _nPrcMin
			SB1->B1_XPRV4     := 0
			SB1->B1_XPRMN4    := 0
			nPerc1 			:= (100 - (nPis + nCof + 18)) / 100  //percentual de calculo de 4%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_PRV1      := _nPrcVen
			SB1->B1_AXPRMIN   := _nPrcMin
	ENDCASE
	//NOVOS CAMPOS DE PRECO DE7ud 4%, 7% E 12% END
ENDIF

RestArea(_aAreaZ2)

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³INDICEMR  ºAutor  ³Microsiga           º Data ³  06/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ROTINA AUXILIAR PARA ADQUIRIR INDICE DE MARCA               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION INDICEMR(nCusto)

Local aRet		:= {}
Local _nPrcMin2	:= 0
Local _nPrcVen2	:= 0

If Alltrim(SB1->B1_MARCA) $ _cMarca		// SE MARCA CONSTA NO PARAMETRO, CALCULO DIFERENCIADO
	If SB1->B1_XSITPRO == "I"		// Importado comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRVI)))
	ElseIf QR1->B1_XSITPRO == "N" 	// Nacional Comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRV)))
	Else	// Produzido
		_nPrcMin2 := (nCusto * SZ2->Z2_INDPRDM)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRDV)))
	EndIf
Else
	If SB1->B1_ORIGEM $ "1/6"
		_nPrcMin2 := (nCusto * SZ2->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRVI)))
	Else
		_nPrcMin2 := (nCusto * SZ2->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRV)))
	EndIf
EndIf

AADD(aRet, _nPrcMin2 )
AADD(aRet, _nPrcVen2 )

RETURN(aRet)
