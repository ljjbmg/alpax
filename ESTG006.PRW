#Include "Topconn.ch"                 '
#Include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG006   ºAutor  ³BIALE               º Data ³  01/06/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de venda 4 %, 7% e 12% na    º±±
±±º          ³  inclusao ou alteracao do preco de compra na tabela Sb1    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß 
GATILHO CAMPO PRECO DE COMPRA TABELA SB1
*/

User Function ESTG006(cCal)
                             
Local 	aArea		:= getArea()
Local 	aAreaZ2		:= SZ2->(getArea())
Private _nCusto    	:= M->B1_AXCUS
Private _cMarca		:= GetNewPar("MV_AXMARCA","LOGEN")

If SZ2->(Dbseek(xFilial("SZ2")+M->B1_MARCA))
	nPis 		:= 1.65 //aliquota de pis
	nCof		:= 7.60 //aliquota cofins
	nIcm		:= IIF(M->B1_PICM==0,18,M->B1_PICM) //ALIQUOTA DE ICM
	nPerc		:= (100 - (nPis + nCof + nIcm)) / 100   //percentual de calculo
	aTmp 		:= INDICEMR(_nCusto * nPerc)      //PARA CALCULAR INDICE DE MARCA
	_nPrcMin1	:= aTmp[01]
	_nPrcVen1	:= aTmp[02]
	DO CASE 
		CASE M->B1_ORIGEM $ "1|2|3|8|" //4%
			If cCal =="P4" .Or. cCal =="M4"
				nPerc1 := (100 - (nPis + nCof + 4)) / 100  //percentual de calculo de 4%
				If cCal == "P4"
					_nCusto := round(_nPrcVen1 / nPerc1,2)
				ElseIf cCal == "M4"	
					_nCusto := round(_nPrcMin1 / nPerc1,2)
				EndIf
			Else
				_nCusto := 0
			EndIf	
		CASE M->B1_ORIGEM $ "0|4|5|6|7|" //7% E 12%
			If cCal =="P7" .Or. cCal =="M7" .Or. cCal =="P12" .Or. cCal =="M12"
				nPerc1 := (100 - (nPis + nCof + 7)) / 100  //percentual de calculo de 7%
				If cCal == "P7"
					_nCusto := round(_nPrcVen1 / nPerc1,2)
				ElseIf cCal == "M7"	
					_nCusto := round(_nPrcMin1 / nPerc1,2)
				ElseIf cCal =="P12" .Or. cCal =="M12"
					nPerc1 := (100 - (nPis + nCof + 12)) / 100  //percentual de calculo de 7%
					If cCal == "P12"
						_nCusto	:= round(_nPrcVen1 / nPerc1,2)
					ElseIf cCal == "M12"	
						_nCusto	:= round(_nPrcMin1 / nPerc1,2) 
					EndIf
				EndIf		
			Else
				_nCusto := 0
			EndIf
	ENDCASE								
	//NOVOS CAMPOS DE PRECO DE7ud 4%, 7% E 12% END
ENDIF    

RestArea(aAreaZ2)
REstArea(aArea)

Return(_nCusto)
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

If Alltrim(M->B1_MARCA) $ _cMarca		// SE MARCA CONSTA NO PARAMETRO, CALCULO DIFERENCIADO
	If M->B1_XSITPRO == "I"		// Importado comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(M->B1_AXINDIC > 0,M->B1_AXINDIC,SZ2->Z2_INDPRVI)))
	ElseIf M->B1_XSITPRO == "N" 	// Nacional Comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(M->B1_AXINDIC > 0,M->B1_AXINDIC,SZ2->Z2_INDPRV)))
	Else	// Produzido
		_nPrcMin2 := (nCusto * SZ2->Z2_INDPRDM)
		_nPrcVen2 := (nCusto * (Iif(M->B1_AXINDIC > 0,M->B1_AXINDIC,SZ2->Z2_INDPRDV)))
	EndIf
Else
	If M->B1_ORIGEM $ "1/6"
		_nPrcMin2 := (nCusto * SZ2->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(M->B1_AXINDIC > 0,M->B1_AXINDIC,SZ2->Z2_INDPRVI)))
	Else
		_nPrcMin2 := (nCusto * SZ2->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(M->B1_AXINDIC > 0,M->B1_AXINDIC,SZ2->Z2_INDPRV)))
	EndIf
EndIf

AADD(aRet, _nPrcMin2 ) 
AADD(aRet, _nPrcVen2 ) 

RETURN(aRet)