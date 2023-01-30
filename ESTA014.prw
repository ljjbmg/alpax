
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTA014   �Autor  �Microsiga           � Data �  23/09/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �CADASTRO DE LOCALIZACOES AUTOMATICAMENTE.                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#Include "Protheus.ch"

User Function ESTA014()

Local _cTitulo	:= "Geracao automatica de localizacao para produtos"
Local lRet		:= .t.
Private _cLocal := space(02)
private _cRua	:= space(02)
Private _nBox	:= 0


DEFINE MSDIALOG oDlg TITLE _cTitulo FROM 2,10 TO 12,60 OF oMainWnd 

@ 15,05 Say "Local" 		Pixel
@ 30,05 Say "Rua"			Pixel
@ 45,05 Say "Quantidade"	Pixel
@ 15,45 MsGet _cLocal 	Size 20,08 					valid naovazio() Pixel
@ 30,45 MsGet _cRua		Size 20,08 					valid naovazio() Pixel
@ 45,45 MsGet _nBox 	Size 20,08 Picture "9999"	Valid naovazio() Pixel

ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{ || lRet := .t.,IF(ValidAll(oDlg),oDlg:End(),lRet:=.f.)},{ || lRet := .f.,oDlg:End() } ) 

If lRet 
	If ! ApMsgYesNo("Confirma geracao dos enderecamentos ??")
		Return
	EndIf
	Processa({ || _fGera() })
EndIf

Return                                                


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �_fGera    �Autor  �Microsiga           � Data �  23/09/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao para criacao dos enderecamentos.                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function _fGera()                    

ProcRegua(_nBox)

For _nY := 1 To _nBox
	IncProc("Criando localizacao" + Strzero(_nY,4))
	If ! SBE->(DbSeek(xFilial("SBE")+"01"+_cLocal+_cRua+StrZero(_nY,4)))
		RecLock("SBE",.t.)
		SBE->BE_FILIAL	:= xFilial("SBE")
		SBE->BE_LOCAL	:= "01"
		SBE->BE_LOCALIZ	:= _cLocal+_cRua+StrZero(_nY,4)
		SBE->BE_STATUS	:= "1"
		MsUnLock()
	EndIf
Next _nY

Return