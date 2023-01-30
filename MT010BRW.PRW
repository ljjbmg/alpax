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

User Function MT010BRW()

Local aRotUser := {}

//Define Array contendo as Rotinas a executar do programa     
// ----------- Elementos contidos por dimensao ------------    // 
//  1. Nome a aparecer no cabecalho                             
//  2. Nome da Rotina associada                                 
//  3. Usado pela rotina                                        
//  4. Tipo de Transacao a ser efetuada                         
//    1 - Pesquisa e Posiciona em um Banco de Dados            
//    2 - Simplesmente Mostra os Campos                        
//    3 - Inclui registros no Bancos de Dados                  
//    4 - Altera o registro corrente                           
//    5 - Remove o registro corrente do Banco de Dados         
//    6 - Altera determinados campos sem incluir novos Regs 

AAdd( aRotUser, { 'Legenda', 'U_MT010LEG', 0, 4 } )

Return (aRotUser)
