#INCLUDE "rwmake.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AXCADSZ4  � Autor � Andre Pestana      � Data �  21/05/04   ���
�������������������������������������������������������������������������͹��
���Descricao � Cadastro de farmacopeias                                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico Macroplast                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function AXCADSZ4


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Private cString
cVldAlt := ".T." // Validacao para permitir a alteracao. Pode-se utilizar ExecBlock.
cVldExc := ".T." // Validacao para permitir a exclusao. Pode-se utilizar ExecBlock.

Private cString := "SZ4"

dbSelectArea("SZ4")
dbSetOrder(1)

AxCadastro(cString,"Cadastro de farmacopeias",cVldAlt,cVldExc)

Return
