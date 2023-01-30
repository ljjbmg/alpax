#INCLUDE "PROTHEUS.CH"   
#INCLUDE "COLORS.CH"


/*/{Protheus.doc} MT010LEG
description
Esse fonte serve para criar a Tabela de legenda e chamar a função que mostra a tabela
@type function
@version  12.1.25
@author ljjbmg
@since 28/04/2021
@return return_type, return_description
/*/

User Function MT010LEG()

Local aLegenda := ParamIbx

//aAdd(aLegenda,{'BR_AZUL_CLARO' ,"Refrigerados"})
aAdd(aLegenda,{'BR_PRETO_0' ,"Policia Federal"})
aAdd(aLegenda,{'BR_VERDE_ESCURO' ,"Exercito"})
aAdd(aLegenda,{'BR_VIOLETA' ,"SSP"})
aAdd(aLegenda,{'BR_AMARELO' ,"SSP e PF"})
aAdd(aLegenda,{'BR_LARANJA' ,"SSP e Exercito"})

BrwLegenda("Legendas","Legenda de Produtos Controlados", aLegenda )

Return
