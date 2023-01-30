#Include "RwMake.ch"
#Include "TopConn.ch"
#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT110END  �Autor  �Marcio Medeiros Junior� Data �  03/04/20 ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada ap�s a��o na avaliacao da solicitacao      ���
���          �															  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT120APV

Local ExpC1 := Nil
Local ExpC2 := Nil
Local cGrp := "" //Grupo de aprova��o

If Type("ALTERA") == "U"
       ALTERA := .F.
Endif

If Type("PARAMIXB") == "U"
         //EXEMPLO 1 (Manipulando o grupo de aprova��o):


Else
         ExpC1 := PARAMIXB[1]
         ExpC2 := PARAMIXB[2]

         //EXEMPLO 2 (Manipulando o saldo do pedido, na altera��o do pedido):
         //Manipulando o saldo do pedido pelo usu�rio, conf. necessidade, atualizando a vari�vel n120TotLib
         If ALTERA

         Endif
Endif

MSGALERT( "Passando no ponto MT120APV")

Return Nil

Return        
