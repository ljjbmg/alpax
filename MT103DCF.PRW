#Include "rwmake.ch"
#include "protheus.ch"                          
#include "fwbrowse.ch"
#include "totvs.ch"

User Function MT103DCF

Local lInclui := PARAMIXB[1]
Local lAltera := PARAMIXB[2]
Local lVisual := PARAMIXB[3]
Local aCamposPar := PARAMIXB[4]
Local aCamposRet := {}	
Local oDialog
Local bConfirm
Local bSair
Local cMarca        := Space(60)
Local cNumeracao    := Space(60)
Local lReturn := .F.
Local nbtn1 := 0

bConfirm    := {|| ( nOpca := 1, oDialog:End() ) }
bSair       := {|| ( oDialog:DeActivate() ) }
oFontb := TFont():New('Courier new',,-16,.T.,.T.)
oFontn := TFont():New('Courier new',,-16,.T.,.F.)

//@ 245,80 	BUTTON oBtn1 PROMPT 'Sair' ACTION ( oLocal:End() ) SIZE 75, 010 OF oLocal PIXEL
//	@ 245,160 	BUTTON oBtn2 PROMPT 'Confirma' SIZE 75, 010 OF oLocal PIXEL ACTION ( nOpca := 1, oLocal:End() )


// Método responsável por criar a janela e montar os paineis.
oDialog := FWDialogModal():New()

// Métodos para configurar o uso da classe.
oDialog:SetBackground(.F.) // .T. -> escurece o fundo da janela 
oDialog:SetTitle("Informações Marca e Volume" ) //"CADASTRO CLIENTES" 
oDialog:SetEscClose(.T.)//permite fechar a tela com o ESC
oDialog:SetSize( 150, 180 )
//oDialog:createFormBar()//cria barra de botoes
//oDialog:EnableFormBar( .T. )
oDialog:CreateDialog()

//oDialog:AddButton( ‘Confirmar’, bConfirm,, , .T., .F., .T., )
//oDialog:AddButton( ‘Sair’ , bSair ,, , .T., .F., .T., )

// Capturar o objeto do FwDialogModal para alocar outros objetos se necessário.
oPanel := oDialog:GetPanelMain()
// Cria barra de botões
oTBar := TBar():New( oPanel, 25, 32, .T.,,,, .F. )
// Cria botões
oBtn1 := TBtnBmp2():New( 02,02,26,26,'Salvar',,,,{|| ODialog:End() },oTBar,,,.T. )
oBtn2 := TBtnBmp2():New( 02,32,26,26,'Final',,,,{||oDialog:End},oTBar,,,.T. )

@ 020,007 SAY "Marca: "	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 030,007 Get oGet VAR cMarca PICTURE "@!" SIZE  150, 9 COLORS CLR_BLUE FONT oFontb OF oPanel PIXEL VALID .T.
@ 040,007 SAY "Numeração: "	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 050,007 Get oGet VAR cNumeracao PICTURE "@!" SIZE  150, 9 COLORS CLR_BLUE FONT oFontb OF oPanel PIXEL VALID .T.


oDialog:Activate()

IF nbtn1 == 1
alert("Salvo")
lreturn = .T.
End

Return 



//Return aCamposRet
