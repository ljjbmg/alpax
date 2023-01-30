#Include "Protheus.ch"        
/*                                                                                
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³XPRCALPX  ºAutor  ³Microsiga           º Data ³  27/01/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³RETORNA PREÇO DE VENDA DO PRÉ-PEDIDO DE VENDA               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ALPAX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function XPRCALPX()

Local aArea   	:= getArea()
Local aAreaSA1 	:= SA1->(getArea())
Local aAreaSB1  := SB1->(getArea())
Local aAreaDA1  := DA1->(getArea())
Local nPosProd  := aScan(aHeader, {|x| Upper(AllTrim(x[2])) == "ZBI_CODPRO"  })
Local nPosQte   := aScan(aHeader, {|x| Upper(AllTrim(x[2])) == "ZBI_QTDE"  })
Local nPosUnt   := aScan(aHeader, {|x| Upper(AllTrim(x[2])) == "ZBI_VUNI"  })
Local nRet    	:= 0
Local nTipo     := PARAMIXB    
Local cTabela   := ""          

dbSelectArea("SA1")
SA1->(DbSetOrder(1))
IF SA1->(dbSeek(xFilial("SA1")+M->ZBH_CLIENT+M->ZBH_LOJA  ))
	cTabela := SA1->A1_TABELA
ENDIF

dbSelectArea("SB1")
SB1->(dbSetOrder(1))
SB1->(dbSeek(xFilial("SB1")+aCols[n][nPosProd] ) )

DO CASE 
CASE nTipo == 1
	IF Empty(cTabela)
		nRet := SB1->B1_PRV1   
	Else
		dbSelectArea("DA1")
		DA1->(dbSetOrder(1) )//DA1_FILIAL+DA1_CODTAB+DA1_CODPRO+DA1_INDLOT+DA1_ITEM
		IF DA1->(dbSeek(xFilial("DA1")+cTabela+SB1->B1_COD ) )
			nRet := DA1->DA1_PRCVEN
		ELSE
			nRet := SB1->B1_PRV1   
		ENDIF
		//nRet := A410Tabela(SB1->B1_COD,cTabela,n,aCols[n][nPosQte],SA1->A1_COD,SA1->A1_LOJA,,,.T.)
	ENDIF
CASE nTipo == 2
	nRet := aCols[n][nPosQte] * aCols[n][nPosUnt]
ENDCASE
                  
RestArea(aAreaDA1)
RestArea(aAreaSB1)
RestArea(aAreaSA1)
RestArea(aArea)

RETURN(nRet)