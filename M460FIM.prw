#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M460FIM   �Autor  �Fagner S. Pinto     � Data �  25/11/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �PONTO DE ENTRADA NO FINAL DO FATURAMENTO                    ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 - ALPAX                                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M460FIM       

//Verifica se o cliente � extrangeiro
IF SF2->F2_EST = 'EX'
     U_BIAEXP() // chamada da fun��o para inclus�o dos dados de exporta��o para o XML 
Endif

Return                              

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BIAEXP    �Autor  �Fagner S. Pinto     � Data �  25/11/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �TELA PARA PREENCHIMENTO DOS DADOOS REFERENTE A EXPORTA��O   ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 - ALPAX                                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function BIAEXP()

Private aEstado	  :={}
Private cEstado
Private cEmbarque := Space(40)
Private oEmbarqie
Private _oDlg				// Dialog Principal

aadd(aEstado, "  ")
                                                                                     
DBSELECTAREA("SX5")
SX5->(DbSetorder(1))
SX5->(DBSeek(xFilial("SX5")+'12'))
WHILE SX5->(!EOF() .and. X5_TABELA = '12' )
	aadd(aEstado, SX5->X5_CHAVE)
	SX5->(DBSkip())
Enddo


DEFINE FONT ofont NAME "ARIAL" SIZE 0,-14 OF _oDlg BOLD
DEFINE MSDIALOG _oDlg TITLE "Dados para Exporta��o" FROM C(178),C(181) TO C(333),C(752) PIXEL

	@ C(025),C(012) Say "UF Origem" Size C(060),C(008) COLOR CLR_BLUE PIXEL OF _oDlg FONT oFont
	@ C(025),C(081) Say "Local de Embarque" Size C(060),C(008) COLOR CLR_BLUE PIXEL OF _oDlg FONT oFont
	@ C(034),C(081) MsGet oEmbarque  Var cEmbarque Size C(189),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(035),C(012) ComboBox cEstado Items aEstado Size C(033),C(010) PIXEL OF _oDlg
	@ C(063),C(247) Button "OK" Size C(037),C(012) PIXEL OF _oDlg action(iif(u_grvdados(),_oDlg:end(),.f.))

ACTIVATE MSDIALOG _oDlg CENTERED 

Return(.T.)

/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   �   C()   � Autores � Norbert/Ernani/Mansano � Data �10/05/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Funcao responsavel por manter o Layout independente da       ���
���           � resolucao horizontal do Monitor do Usuario.                  ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function C(nTam)                                                         
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor     
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)  
		nTam *= 0.8                                                                
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600                
		nTam *= 1                                                                  
	Else	// Resolucao 1024x768 e acima                                           
		nTam *= 1.28                                                               
	EndIf                                                                         
                                                                                
	//���������������������������Ŀ                                               
	//�Tratamento para tema "Flat"�                                               
	//�����������������������������                                               
	If "MP8" $ oApp:cVersion                                                      
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()                      
			nTam *= 0.90                                                            
		EndIf                                                                      
	EndIf                                                                         
Return Int(nTam)                                                                

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GRVDADOS  �Autor  �Fagner S. Pinto     � Data �  25/11/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �GRAVA OS DADOS REFERENTE A EXPORTA��O  NA SF2               ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 - ALPAX                                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function grvdados()

If  empty(alltrim(cEmbarque)) .or. empty(alltrim(cEstado))
 
 MsgInfo("Preencha os Campos UF Origem e Local de Embarque !")
 Return .F.
 
Endif

Reclock("SF2",.F.)
	SF2->F2_NFELOC:= cEmbarque
	SF2->F2_NFEUF := cEstado
SF2->(MsUnlock())

Return .T.