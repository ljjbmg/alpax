/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?RFATC002  ?Autor  ?Microsiga           ? Data ?  31/08/05   ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ? Browse de consulta das tabelas de precos.                  ???
???          ?                                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? AP - ALPAX.                                                ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/
#INCLUDE "rwmake.ch"

User Function RFATC002()

Private cCadastro := "Consulta tabela precos"

Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
             {"Visualizar","AxVisual",0,2} ,;
             {"Precos","U_RFATC001(SB1->B1_COD)",0,4} }

dbSelectArea("SB1")

mBrowse( 6,1,22,75,"SB1")

Return