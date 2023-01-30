#include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATG016   ºAutor  ³Microsiga           º Data ³  06/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³GATILHO PARA ADQUIRIR PRECO DE VENDA DA TABELA SB1          º±±
±±º          ³VERIFICANDO SE É 4%, 7%, 12% E/OU 18%                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ALPAX                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
GATILHO NOS CAMPOS DE TIPO DE OPERACAO TABELA SC6 E SCK
*/
USER FUNCTION FATG016(nUnit,cTabela,cProduto,cCliente,cLoja,cTpOp)

Local 	aArea	 	:= getArea()
Local 	aAreaDA1	:= DA1->(getArea())
Local 	aAreaSA1	:= SA1->(getArea())
Local 	aAreaSB1	:= SB1->(getArea())
Local 	cTO			:= cTpOp
Local   cPrvAll     := ""
Local 	cEst		:= ""
//Local 	cTpOper		:= ALLTRIM(SUPERGETMV("AX_TPOPCON",.F.,"02|21"))
//Local  	cTpOpPd		:= ALLTRIM(supergetmv("AX_TPOPPDC",.F.,"02"))
//Local  	cTpOpRV		:= ALLTRIM(supergetmv("AX_TPOPPDR",.F.,"01"))

Private _nValor    := nUnit
Private _nValInc   := getmv("MV_AXINCEX")

dbSelectArea("DA1")
DA1->(dbSetOrder(1))
IF !DA1->(dbSeek(xFilial("DA1")+cTabela+cProduto))
	dbSelectArea("SA1")
	SA1->(dbSetOrder(1))
	IF SA1->(dbSeek( xFilial("SA1")+cCliente+cLoja ))
		IF EMPTY(cTO) .OR. (ALLTRIM(SA1->A1_INSCR) == "ISENTO" .OR. EMPTY(SA1->A1_INSCR))
			cPrvAll := "T" //CONSUMO
		ELSEIF EMPTY(cTO)
			cPrvAll :="F" //REVENDE
		ENDIF
		cEst	:= ALLTRIM(SA1->A1_EST)
	ENDIF
	dbSelectArea("SB1")
	SB1->(dbSetOrder(1))
	IF SB1->(dbSeek( xFilial("SB1")+cProduto ) )
		IF cPrvAll == "T" .OR. cEst == "SP"
			If SB1->B1_AXINDIC <> 0 //SB1->B1_AXCTEXE <> " "
				_nValor := SB1->(B1_PRV1*B1_AXINDIC)//+_nValInc
			Else
				_nValor := SB1->B1_PRV1
			EndIf
		ELSE
			DO CASE
				CASE SB1->B1_ORIGEM $ "1|2|3|8|" //4%
				If SB1->B1_AXINDIC <> 0 //SB1->B1_AXCTEXE <> " "
					_nValor := SB1->(B1_PRV1*B1_AXINDIC)//+_nValInc
//					If SB1->B1_AXCTEXE <> " "
//						_nValor := SB1->B1_XPRV4+_nValInc
					Else
						_nValor := SB1->B1_XPRV4
					EndIf
				CASE SB1->B1_ORIGEM $ "0|4|5|6|7|" //7% E 12%
					IF cEst $ "MG|PR|RS|RJ|SC"   //para estados de 12%
					If SB1->B1_AXINDIC <> 0 //SB1->B1_AXCTEXE <> " "
						_nValor := SB1->(B1_PRV1*B1_AXINDIC)//+_nValInc
//					If SB1->B1_AXCTEXE <> " "
//							_nValor := SB1->B1_XPRV12+_nValInc
						Else
							_nValor := SB1->B1_XPRV12
						EndIf
					ELSE           //para estados de 7%
						If SB1->B1_AXINDIC <> 0 //SB1->B1_AXCTEXE <> " "
							_nValor := SB1->(B1_PRV1*B1_AXINDIC)//+_nValInc
//						If SB1->B1_AXCTEXE <> " "
//							_nValor := SB1->B1_XPRV7+_nValInc
						Else
							_nValor := SB1->B1_XPRV7
						EndIf
					ENDIF
			ENDCASE
		ENDIF
	ENDIF
ENDIF

RestArea(aAreaSB1)
RestArea(aAreaSA1)
RestArea(aAreaDA1)
RestArea(aArea)

return(_nValor)
