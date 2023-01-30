#Include "PROTHEUS.CH"
#Include "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SD1100I   ºAutor  ³Microsiga           º Data ³  17/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para atualizar o ultimo preco de compra    º±±
±±º          ³com IPI, somente se a compra for maior ou adicionar os      º±±
±±º          ³tributos no caso de fornecedor com Simples Federal          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function SD1100I()

// ATUALIZANDO APENAS PRECO DE COMPRAS.
Local _aArea	:= GetArea()
Local _aAreaB1 	:= SB1->(GetArea())
Local _aAreaF4 	:= SF4->(GetArea())
Local _aAreaZ2	:= SZ2->(GetArea())
Local _nValIpi	:= 0
Local _aFornSim := 0                // Fornecedor com Simples soma os impostos ao custo
Local _aSubTrib := 0

PRIVATE _cMarca	:= GetNewPar("MV_AXMARCA","LOGEN")

SB1->(DbSetOrder(1))
SF4->(DbSetOrder(1))
SZ2->(DbSetOrder(2))

SF4->(DbSeek(xFilial("SF4")+SD1->D1_TES))

If Substr(SF4->F4_CF,2,3) $ "101/102/922/401/403" .AND. ALLTRIM(SD1->D1_TIPO) == 'N'
	If SF4->F4_CREDIPI <> "S"
		_nValIpi := iif(SD1->D1_VALIPI > 0,SD1->D1_VALIPI/SD1->D1_QUANT,0)
	EndIf
	
	If SF4->F4_CREDICM == 'N' .And. Substr(SF4->F4_CF,2,3) $ "101/102/922"
		_aFornSim := (SD1->D1_VUNIT*0.2725)
	EndIf
	
	If SD1->D1_ICMSRET <> 0 .And. Substr(SF4->F4_CF,2,3) $ "401/403"
		_aSubTrib := (SD1->D1_ICMSRET/SD1->D1_QUANT)
	EndIf
	
	If SB1->(DbSeek(xFilial("SB1")+SD1->D1_COD))

		RecLock("SB1",.f.)
		SB1->B1_XUPRC := SD1->D1_VUNIT
		If SB1->B1_UPRC < SD1->D1_VUNIT
			SB1->B1_UPRC := SD1->D1_VUNIT
			SB1->B1_AXCUS := (SD1->D1_VUNIT+_nValIpi+_aFornSim+_aSubTrib)
			If SZ2->(Dbseek(xFilial("SZ2")+SB1->B1_MARCA))
				If Alltrim(SB1->B1_MARCA) $ _cMarca		// SE MARCA CONSTA NO PARAMETRO, CALCULO DIFERENCIADO
					If SB1->B1_XSITPRO == "I"			// Importado comprado
						_nPrcMin := (SB1->B1_AXCUS * SZ2->Z2_INIMPMI)
						_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRVI)))
					ElseIf SB1->B1_XSITPRO == "N" 		// Nacional Comprado
						_nPrcMin := (SB1->B1_AXCUS * SZ2->Z2_INDICE)
						_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRV)))
					Else								// Produzido
						_nPrcMin := (SB1->B1_AXCUS * SZ2->Z2_INDPRDM)
						_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRDV)))
					EndIf
				Else
					If SB1->B1_ORIGEM $ "1/6"
						_nPrcMin := (SB1->B1_AXCUS * SZ2->Z2_INIMPMI)
						_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRVI)))
					Else
						_nPrcMin := (SB1->B1_AXCUS * SZ2->Z2_INDICE)
						_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRV)))
					EndIf
				EndIf
				SB1->B1_PRV1 	:= _nPrcVen
				SB1->B1_AXPRMIN	:= _nPrcMin
				//NOVOS CAMPOS DE PRECO DE 4%, 7% E 12% BEGIN
				nPis 		:= 1.65 					//aliquota de pis
				nCof		:= 7.60 					//aliquota cofins
				nIcm		:= IIF(SB1->B1_PICM==0,18,SB1->B1_PICM) //ALIQUOTA DE ICM
				nPerc		:= (100 - (nPis + nCof + nIcm)) / 100   //percentual de calculo
				aTmp 		:= INDICEMR(SB1->B1_AXCUS * nPerc)      //PARA CALCULAR INDICE DE MARCA
				_nPrcMin1	:= aTmp[01]
				_nPrcVen1	:= aTmp[02]
				DO CASE
					CASE SB1->B1_ORIGEM $ "1|2|3|8|" 	//4%
						nPerc1 			:= (100 - (nPis + nCof + 4)) / 100  //percentual de calculo de 4%
						_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
						_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
						SB1->B1_XPRV4	:= _nPrcVen
						SB1->B1_XPRMN4  := _nPrcMin
					CASE SB1->B1_ORIGEM $ "0|4|5|6|7|" //7% E 12%
						nPerc1 			:= (100 - (nPis + nCof + 7)) / 100  //percentual de calculo de 7%
						_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
						_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
						SB1->B1_XPRV7	:= _nPrcVen
						SB1->B1_XPRMN7  := _nPrcMin
						nPerc1 			:= (100 - (nPis + nCof + 12)) / 100  //percentual de calculo de 7%
						_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
						_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
						SB1->B1_XPRV12	:= _nPrcVen
						SB1->B1_XPRMN12 := _nPrcMin
				ENDCASE
				//NOVOS CAMPOS DE PRECO DE 4%, 7% E 12% END
			EndIf
		EndIf
		SB1->(MsUnLock())
	EndIf
EndIf

RestArea(_aAreaZ2)
RestArea(_aAreaF4)
RestArea(_aAreaB1)
RestArea(_aArea)

Return

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
	If SB1->B1_XSITPRO == "I"			// Importado comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRVI)))
	ElseIf SB1->B1_XSITPRO == "N" 		// Nacional Comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRV)))
	Else								// Produzido
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
