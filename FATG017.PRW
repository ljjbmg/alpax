#include "protheus.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATG017   ºAutor  ³Microsiga           º Data ³  06/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³GATILHO PARA ADQUIRIR PRECO MINIMO DE VENDA DA TABELA SB1   º±±
±±º          ³VERIFICANDO SE É 4%, 7%, 12% E/OU 18%                       º±±                               -
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ALPAX                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION FATG017(cProduto,cCliente,cLoja,cTpOp)

Local 	aArea	 	:= getArea()
Local 	aAreaSA1	:= SA1->(getArea())
Local 	aAreaSB1	:= SB1->(getArea())
Local 	cTO			:= cTpOp
Local   cPrvAll     := ""
Local 	cEst		:= ""
LOCAL   cUF7 		:= SUPERGETMV("AX_UF7", .T., "AM")
LOCAL   cUF12       := SUPERGETMV("AX_UF12", .T., "MG|PR|RJ|RS|SC")

Private _nValor    := 0
Private _nValInc   := getmv("MV_AXINCEX")

dbSelectArea("SA1")
SA1->(dbSetOrder(1))
IF SA1->(dbSeek( xFilial("SA1")+cCliente+cLoja ))
	IF Empty(cTO) .OR. (ALLTRIM(SA1->A1_INSCR) == "ISENTO" .OR. EMPTY(SA1->A1_INSCR))
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
				_nValor := SB1->B1_AXPRMIN
			EndIf
		ELSE
			DO CASE
				CASE SB1->B1_ORIGEM $ "1|2|3|8|" //4%
					If SB1->B1_AXINDIC <> 0 //SB1->B1_AXCTEXE <> " "
						_nValor := SB1->(B1_PRV1*B1_AXINDIC)//+_nValInc
	//					If SB1->B1_AXCTEXE <> " "
	//					_nValor := SB1->B1_XPRMN4+_nValInc
					Else
						_nValor := SB1->B1_XPRMN4
					EndIf
				CASE SB1->B1_ORIGEM $ "0|4|5|6|7|" //7% E 12%
					IF cEst $ cUF7   //para estados de 7%
						If SB1->B1_AXINDIC <> 0 //SB1->B1_AXCTEXE <> " "
							_nValor := SB1->(B1_PRV1*B1_AXINDIC)//+_nValInc
	//						If SB1->B1_AXCTEXE <> " "
	//						_nValor := SB1->B1_XPRMN7+_nValInc
						Else
							_nValor := SB1->B1_XPRMN7
						EndIf
					ELSEIF cEst $ cUF12         //para estados de 12%
						If SB1->B1_AXCTEXE <> " "
							_nValor := SB1->B1_XPRMN12+_nValInc
						Else
							_nValor := SB1->B1_XPRMN12
						EndIf
					ELSE
							_nValor := SB1->B1_AXPRMIN
					ENDIF
			ENDCASE
		ENDIF
ENDIF

RestArea(aAreaSB1)
RestArea(aAreaSA1)
RestArea(aArea)

return(_nValor)
