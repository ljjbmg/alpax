#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZ3  � Autor � Andre Pestana      � Data �  21/05/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de nomes de produto                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico Macroplast                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function AXCADSZ3


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Private cString
cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "SZ3"

dbSelectArea("SZ3")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de nomes de produto ",cVldAlt,cVldExc)

Return
