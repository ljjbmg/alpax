#include "protheus.ch"
/*
=========================================================================================
FONTE       : FATG015
AUTOR       : OCIMAR ROLLI
DATA        : 08 DE JULHO DE 2015
OBJETIVO    : ACRESCENTAR NO VALOR UNITARIO UM VALOR PARA PRODUTOS CONTROLADOS PELO EXERCITO
ARQUITETURA : GATILHOS, SCJ, SCK, TIPO FRETE, CODIGO EXERCITO, PRECO UNITARIO
=========================================================================================
*/


USER FUNCTION FATG015(cFrete,cCodExe,nUnit)

Private _nValUni   := nUnit
Private _nValor    := 0
Private _nValInc   := getmv("MV_AXINCEX")

//VERIFICA SE FRETE CIF=C OU FOB= F

IF cFrete == "C" .And. cCodExe <> " "
	ApMsgStop("Produto controlado pelo exercito e sofrera acrescimo de " + "R$ "+Transform(_nValInc,"@e 999,999.99") + " referente ao frete !!!!")
	_nValor := (_nValUni+_nValInc)
Else
	_nValor := _nValUni
EndIf

return(_nValor)
                                                       
