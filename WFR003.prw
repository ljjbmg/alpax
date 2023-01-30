#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³WFR003    ºAutor  ³Adriano Luis Brandaoº Data ³  28/02/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para disparar o programa de relatorio ou e-mail para º±±
±±º          ³cliente e vendedor.                                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function WFR003()

Local oDlg,oSBtn2,oSBtn3,oSBtn4,_cMail, _aArea, _aAreaA3
Private _cCliente, _cEmailCli,_cContato, _cUsuario, _cMailCop, _cMens01, _cMens02, _cMens03

Private oDlg
Private oBtn1, oBtn2, oBtn3 
Private lSair := .F.                      
Private b1 := {||lSair := .T. , oDlg:End(), U_FATR003() }
//Private b2 := {||lSair := .T. , oDlg:End(), U_FATR007() ,U_fEnv004(_cMail) }  ->CHAMADA PARA O FONTE ANTIGO
Private b2 := {||lSair := .T. , oDlg:End(), U_FATR029() ,U_fEnv004(_cMail) }
Private b3 := {||lSair := .T. , oDlg:End()}
Private b4 := {||lSair := .T. , oDlg:End(), U_AjustCont() }

_aArea 		:= GetArea()
_aAreaA3 	:= SA3->(GetArea())

SA3->(DbSetOrder(1))
If SA3->(Dbseek(xFilial("SA3")+SCJ->CJ_AXVEND))
	_cMail := SA3->A3_EMAIL
EndIf

If Empty(_cMail)
	_cMail := "luciano.pereira@alpax.com.br"
EndIf
  

DEFINE MSDIALOG oDlg title "Impressão..." from 0,0 to 180,150 pixel

@005,010 Button oBtn1 Prompt "Relatório Padrão" size 60,12 pixel of oDlg action eval(b1)
@025,010 Button oBtn2 Prompt "Relatório PDF"    size 60,12 pixel of oDlg action eval(b2)
@045,010 Button oBtn2 Prompt "Relatório HTML"    size 60,12 pixel of oDlg action eval(b4)
@065,010 Button oBtn3 Prompt "Cancelar"         size 60,12 pixel of oDlg action eval(b3)
                                                                
/*
@005,010 Button oBtn1 Prompt "Relatório Padrão" size 60,12 pixel of oDlg action eval(b1)
@035,010 Button oBtn2 Prompt "Relatório PDF"    size 60,12 pixel of oDlg action eval(b2)
@065,010 Button oBtn3 Prompt "Cancelar"         size 60,12 pixel of oDlg action eval(b3)
*/

ACTIVATE MSDIALOG oDlg Centered valid lSair
 


/*   

08.11.09 - Eduardo/BIALE - DESATIVADO MUITO CODIGO PARA POUCA COISA!

oDlg := MSDIALOG():Create()
oDlg:cName := "oDlg"
oDlg:cCaption := "Impressao Relatorio / E-mail para o cliente"
oDlg:nLeft := 0
oDlg:nTop := 0
oDlg:nWidth := 318
oDlg:nHeight := 269
oDlg:lShowHint := .F.
oDlg:lCentered := .T.

oSBtn2 := SBUTTON():Create(oDlg)
oSBtn2:cName := "oSBtn1"
oSBtn2:cCaption := "Imprimir"
oSBtn2:cToolTip := "Relatorio padrao"
oSBtn2:cMsg := "Relatorio padrao"
oSBtn2:nLeft := 105
oSBtn2:nTop := 25
oSBtn2:nWidth := 110
oSBtn2:nHeight := 36
oSBtn2:lShowHint := .F.
oSBtn2:lReadOnly := .F.
oSBtn2:Align := 0
oSBtn2:lVisibleControl := .T.
oSBtn2:nType := 1
oSBtn2:bAction := {|| U_FATR003() }

oSBtn3 := SBUTTON():Create(oDlg)
oSBtn3:cName := "oSBtn1"
oSBtn3:cName := "IMPRESSAO PDF"
oSBtn3:cCaption := "Impressao p/PDF"
oSBtn3:cToolTip := "Impressao p/PDF"
oSBtn3:nLeft := 105
oSBtn3:nTop := 99
oSBtn3:nWidth := 110
oSBtn3:nHeight := 36
oSBtn3:lShowHint := .F.
oSBtn3:lReadOnly := .F.
oSBtn3:Align := 0
oSBtn3:lVisibleControl := .T.
oSBtn3:nType := 1                                               
oSBtn3:bAction := {|| U_fEnv004(_cMail),U_FATR007()}
//oSBtn3:bAction := {|| U_FATR007()}

oSBtn4 := SBUTTON():Create(oDlg)
oSBtn4:cName := "oSBtn4"
oSBtn4:cCaption := "Cancelar"
oSBtn4:cToolTip := "Cancelar"
oSBtn4:nLeft := 105
oSBtn4:nTop := 168
oSBtn4:nWidth := 110
oSBtn4:nHeight := 36
oSBtn4:lShowHint := .F.
oSBtn4:lReadOnly := .F.
oSBtn4:Align := 0
oSBtn4:lVisibleControl := .T.
oSBtn4:nType := 2
oSBtn4:bAction := {|| oDlg:End() }

oDlg:Activate()                      

*/
RestArea(_aAreaA3)
RestArea(_aArea)

Return
