#INCLUDE "PROTHEUS.CH"   
#INCLUDE "COLORS.CH"
/*/{Protheus.doc} MT010COR
description
Ponto de entrada que adiciona legenda de cores na tela de Cadastro de Produtos
@type function
@version  12.1.25
@author ljjbmg
@since 28/04/2021
@return return_type, return_description
/*/
User Function MT010COR()

Local aCores:={}

//aAdd(aCores,{'B1_XREFRIG == "1" .OR. B1_XREFRIG == "2"' ,'BR_AZUL_CLARO'})  //Refrigerado
aAdd(aCores,{'B1_AXFEDER == "S" .AND. B1_AXSSP == "N"'  ,'BR_PRETO_0'})     //PF
aAdd(aCores,{'B1_AXEXERC == "S" .AND. B1_AXSSP == "N"'  ,'BR_VERDE_ESCURO'})
aAdd(aCores,{'B1_AXSSP=="S" .AND. B1_AXFEDER=="N" .AND. B1_XEXERC=="N"','BR_VIOLETA'})
aAdd(aCores,{'B1_AXSSP=="S" .AND. B1_AXFEDER=="S"','BR_AMARELO'})
aAdd(aCores,{'B1_AXSSP=="S" .AND. B1_AXEXERC=="S"','BR_LARANJA'})

Return aCores
