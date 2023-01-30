/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M410ALOK  �Autor  �Adriano Luis Brandao� Data �  27/10/04   ���
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
User Function M410ALOK()
                          

_lRet := .t.
 
dbSelectArea("ZBD")   //ABRE TABELA DE CONTROLE DE ACESSO DE PEDIDOS DE VENDA
ZBD->(dbSetOrder(2))  //ZBD_FILIAL+ZBD_NOME
IF ZBD->(dbSeek(xFilial("ZBD")+cUserName) )
	IF ZBD->ZBD_ALTPV == .T.
		_lRet := .T.
	ELSE
		APMSGSTOP("Voce nao tem permissao de alterar pedidos de vendas....","Bloqueio")
		_lRet := .F.
	ENDIF
ELSE
	APMSGSTOP("Voce nao tem permissao de alterar pedidos de vendas....","Bloqueio")
	_lRet := .F.
ENDIF
dbSelectArea("ZBD")
ZBD->(dbCloseArea())

Return(_lRet)