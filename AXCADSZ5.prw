#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZ5  � Autor � Andre Pestana      � Data �  21/05/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de capacidades de produtos                        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico Macroplast                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function AXCADSZ5


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Private cString
cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "SZ5"

dbSelectArea("SZ5")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de capacidades de produtos",cVldAlt,cVldExc)

Return
