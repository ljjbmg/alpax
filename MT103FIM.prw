#include "PROTHEUS.CH"
/*
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT103FIM   ºAutor  ³Fagner S. Pinto    º Data ³  13/10/10    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PONTO DE ENTRADA NO FINAL DA INCLUSÃO DO DOCUMENTO DE ENTRADAº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP10 - ALPAX                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         

User Function MT103FIM()                                                    


Local nOpcx		:= ParamIXB[1]
Local nOpc		:= ParamIXB[2]

//Verifica se é nota de Importação 

 IF INCLUI .AND. PARAMIXB[2] = 1 .AND. ALLTRIM(SF1->F1_EST) = 'EX'
	U_DADOSIMP()
 Endif 

IF (nOpcx == 3 .Or. nOpcx == 4) .And. nOpc == 1
	U_COMP0003()
EndIf 

/* ####################################################################### *\
|| #           PONTO DE ENTRADA UTILIZADO PELO IMPORTADOR GATI           # ||
|| #                                                                     # ||
|| #  É EXECUTADO DEPOIS QUE A NOTA É EXCLUÍDA PARA FAZER O XML VOLTAR   # ||
|| #                  PARA A TELA INICIAL DO IMPORTADOR                  # ||
\* ####################################################################### */

U_GTPE002()

Return

/*
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³COMP0003   ºAutor  ³ljjbmg             º Data ³  14/12/21    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PONTO DE ENTRADA NO FINAL DA INCLUSÃO DO DOCUMENTO DE ENTRADAº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP12 - ALPAX                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
User Function COMP0003()

Local aAreaSF1 := SF1->(GetArea())
Local nOpc := 0
Local cNF, cLoja, cFor, cNomForCli, cTitNom, cTransp := ""
Local oBtn := nil
Local oDlg

cNF 	:= SF1->F1_DOC
cLoja	:= SF1->F1_LOJA
cFor	:= SF1->F1_FORNECE
cTransp := Space(06)
cDoc	:= SF1->F1_DOC
cSerie := SF1->F1_SERIE

If SF1->F1_TIPO $ "D|B"
	cTitNom := "Clinte:"
	cNomForCli	:= Posicione ("SA1",1,xFilial("SA1")+ cFor + cLoja,"A1_NREDUZ")
else
	cTitNom := "Fornecedor:"
	cNomForCli	:= Posicione ("SA2",1,xFilial("SA2")+ cFor + cLoja,"A2_NREDUZ")	
End

oFontb := TFont():New('Courier new',,-11,.T.,.T.)
oFontn := TFont():New('Courier new',,-12,.T.,.F.)
oFontc := TFont():New('Courier new',,-13,.T.,.F.)

DEFINE MSDIALOG oDlg TITLE "Informar Transportadora" From 10,005 TO 150,400 Pixel 
oDlg:lMaximized := .F. //Maximizar a janela
@ 012,007 TO 075,385
@ 014,007 SAY "Informações Nota Fiscal"  SIZE  60, 7 COLORS CLR_BLACK FONT oFontb OF oDlg PIXEL 
@ 024,007 SAY cTitNom  			SIZE 60,7 COLORS CLR_RED FONT oFontn OF oDlg PIXEL 
@ 024,060 Say cNomForCli 		SIZE 60,9 COLORS CLR_RED FONT oFontn OF oDlg PIXEL 		
@ 024,120 Say cDoc +"-"+cSerie	SIZE 60,9 COLORS CLR_RED FONT oFontc OF oDlg PIXEL 		
@ 036,007 SAY "Tranportadora:" 	SIZE 60,7 COLORS CLR_BLACK FONT oFontn OF oDlg PIXEL 
@ 036,060 MsGet cTransp 		SIZE 60,9 COLORS CLR_RED FONT oFontn OF oDlg F3 "SA4" Pixel Picture "@!"  
@ 052,007	BUTTON oBtn		PROMPT "Confirmar"	SIZE 75,10 OF oDlg	PIXEL ACTION ( nOpc:=1,oDlg:End() )			

//	DEFINE SBUTTON FROM 048,007 TYPE 1 ACTION {||nOpc := 1, oLocal:End()} ENABLE OF oLocal
ACTIVATE MSDIALOG oDlg CENTER
	
	If nOpc == 1 

		RECLOCK("SF1",.F.)	
		SF1->F1_TRANSP := cTransp
		SF1->F1_AXTRANS := cTransp	
		SF1->(MSUNLOCK())
							 
	EndIf

RestArea(aAreaSF1)

Return nil
