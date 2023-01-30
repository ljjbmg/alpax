/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���PROGRAMA  �MTA410    �AUTOR  �MICROSIGA           � DATA �  01/08/05   ���
�������������������������������������������������������������������������͹��
���DESC.     � PONTO DE ENTRADA PARA VALIDACAO DA INCLUSAO DE UM PEDIDO   ���
���          � DE VENDAS.                                                 ���
�������������������������������������������������������������������������͹��
���USO       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#Include "Topconn.ch"

User Function MTA410()

LOCAL cUsrSup	:= SUPERGETMV('AX_USRSUP', .T., 'ADMINISTRADOR')
Local _nY	
_lRet			:= .t.
_aArea			:= GetArea()



If M->C5_AXATEN1 <> __cUserId .and. ! Upper(Alltrim(cUserName)) $ cUsrSup
	// se nao � o usuario do pedido, testa se � supervisor do atendente
	PswOrder(1)
	If PswSeek(M->C5_AXATEN1,.t.)
		_aSuperior :=pswret(1)
		If _aSuperior[1,11] <> __cUserId		// se tambem nao � o supervisor do atendente bloqueia liberacao
			ApMsgStop("Este pedido pertence a outro usuario, geracao de pedido de vendas bloqueada ....")
			_lRet := .f.
		EndIf
	Endif
EndIf

// Incluido ocimar -> gravar preco de lista igual preco de venda
_nPosPRUN := aScan(aHeader,{|x| Alltrim(x[2]) == "C6_PRUNIT"})
_nPosPRVE := aScan(aHeader,{|x| Alltrim(x[2]) == "C6_PRCVEN"}) 

For _nY := 1 To Len(acols)
  aCols[_nY,_nPosPRUN] := aCols[_nY,_nPosPRVE]
Next _nY

// fim da inclusao


Return(_lRet)
