#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZ6  � Autor � Andre Pestana      � Data �  21/05/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro diferenciais de produto                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico Macroplast                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function AXCADSZ6


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Private cString
cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "SZ6"

dbSelectArea("SZ6")
dbSetOrder(1)

AxCadastro(cString,"Cadastro diferenciais de produto",cVldAlt,cVldExc)

Return
