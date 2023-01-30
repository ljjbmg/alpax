#INCLUDE "PROTHEUS.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CACESSPV  �Autor  �BIALE               � Data �  04/07/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao para validar se o usuario podera ou nao alterar o    ���
���          �pedido de vendas, onde somente seus pedidos estarao habilita���
���          �dos                                                         ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function CACESSPV()


Private cCadastro := "Tabelas escolhidas pelo usu�rio"
Private aRotina := { {"Pesquisar" ,"AxPesqui" ,0,1},;
                     {"Visualizar","AxVisual" ,0,2},;
                     {"Inclui"  ,"AxInclui"   ,0,3},;
                     {"Alterar"  ,"AxAltera"  ,0,4},;
                     {"Excluir"  ,"AxDeleta"  ,0,5}}
Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cString  := "ZBD"

dbSelectArea("ZBD")
dbSetOrder(1)  

mBrowse( 6,1,22,75,"ZBD")

RETURN
                          

