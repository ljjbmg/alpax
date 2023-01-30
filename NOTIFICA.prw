/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOTIFICA  �Autor  �Microsiga           � Data �  19/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � FUNCAO DE NOTIFICACAO A USUARIOS                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NOTIFICA(pcAssunto, pcTitulo, pcDetalhe, pcUsuario, pcAtachar)

oProcess          	:= TWFProcess():New( "000001", "Notificacao Avulsa" )
oProcess          	:NewTask( "Notificacao Avulsa", "\workflow\Notifica.htm" )
oProcess:cSubject 	:= pcAssunto
If '@' $ pcUsuario
	oProcess:cTo   	:= pcUsuario
Else
	oProcess:cTo    := UsrRetMail(pcUsuario)
EndIf
oProcess:UserSiga	:= '000000'  // Fixo Administrador
oProcess:NewVersion(.T.)
oHtml     			:= oProcess:oHTML
oHtml:ValByName( "REFERENTE", pcTitulo)
oHtml:ValByName( "DESCRICAO", pcDetalhe)
If pcAtachar # Nil
	oProcess:AttachFile(Upper(pcAtachar))
EndIf
oProcess:Start()

Return