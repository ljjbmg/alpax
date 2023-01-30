#INCLUDE "PROTHEUS.CH"
/*/{Protheus.doc} MTA265MNU
description
@type function
@version  
@author ljjbmg
@since 07/06/2021
@return return_type, return_description
/*/
User Function MTA265MNU

aAdd(aRotina,{ "Altera Lote", "U_AltLote", 0 , 2, 0, .F.})	

Return

User Function AltLote()

Local oDialog
cArea       := GetArea()
cLote       := SPACE(10)
dValidade   := dDatabase
cLoteOri    := SDA->DA_LOTECTL
cProduto    := SDA->DA_PRODUTO
cDoc        := SDA->DA_DOC
cSerie      := SDA->DA_SERIE
cClifor     := SDA->DA_CLIFOR
cLoja       := SDA->DA_LOJA
cTipoDoc    := SDA->DA_TIPONF
cOrigem     := SDA->DA_ORIGEM
cNumSeq     := SDA->DA_NUMSEQ
cLocal      := SDA->DA_LOCAL
nQtdOri     := SDA->DA_QTDORI
nSaldo      := SDA->DA_SALDO
lTrue       := .T.
nEscolha    := 0
lExist      := .F.

//bConfirm    := {|| ( nOpca := 1, oDialog:End() ) }
//bSair       := {|| ( oDialog:DeActivate() ) }
oFontb      := TFont():New('Courier new',,-16,.T.,.T.)
oFontn      := TFont():New('Courier new',,-16,.T.,.F.)
oFontc      := TFont():New('Courier new',,-14,.T.,.T.)
oDialog     := FWDialogModal():New()
oDialog:SetBackground(.F.) // .T. -> escurece o fundo da janela 
oDialog:SetTitle(DecodeUTF8("Informações do Lote", "cp1252")) //"CADASTRO CLIENTES" 
oDialog:SetEscClose(.T.)//permite fechar a tela com o ESC
oDialog:SetSize( 150, 180 )
oDialog:CreateDialog()
// Capturar o objeto do FwDialogModal para alocar outros objetos se necessário.
oPanel := oDialog:GetPanelMain()
// Cria barra de botões
oTBar := TBar():New( oPanel, 25, 32, .T.,,,, .F. )
// Cria botões
oBtn1 := TBtnBmp2():New( 02,02,26,26,'Salvar',,,,{|| nEscolha := 1, oDialog:DeActivate()  },oTBar,,,.T. )
oBtn2 := TBtnBmp2():New( 02,32,26,26,'Final' ,,,,{|| oDialog:DeActivate() },oTBar,,,.T. )

@ 020,007 SAY "Produto   : "	SIZE  60, 9 COLORS CLR_GRAY FONT oFontb OF oPanel PIXEL 
@ 020,065 SAY AllTrim(cProduto) Size 60,9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 030,007 Say "Lote Orig.: " Size 60,9 COLORS CLR_GRAY FONT oFontb OF oPanel PIXEL 
@ 030,065 Say AllTrim(cLoteOri) Size 60,9 COLORS CLR_RED FONT oFontb OF oPanel PIXEL 
@ 040,007 Say "Documento : " Size 60,9 COLORS CLR_GRAY FONT oFontb OF oPanel PIXEL 
@ 040,065 Say AllTrim(cDoc) Size 60,9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 040,115 Say "Serie : " Size 60,9 COLORS CLR_GRAY FONT oFontb OF oPanel PIXEL 
@ 040,150 Say AllTrim(cSerie) Size 60,9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 050,007 Say "Quantidade: " Size 60,9 COLORS CLR_GRAY FONT oFontb OF oPanel PIXEL 
@ 050,065 Say nQtdOri Size 60,9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 050,115 Say "Armaz.: " Size 60,9 COLORS CLR_GRAY FONT oFontb OF oPanel PIXEL 
@ 050,150 Say AllTrim(cLocal) Size 60,9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 


//@ 030,007 Get oGet VAR cMarca PICTURE "@!" SIZE  150, 9 COLORS CLR_BLUE FONT oFontb OF oPanel PIXEL VALID .T.
@ 070,007 SAY "Informar Lote e Validade: "	SIZE  150, 9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 080,007 Get oGet VAR cLote VALID NaoVazio( cLote ) PICTURE "@!" Size 60,9 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 
@ 080,100 Get oGet VAR dValidade VALID NaoVazio( dValidade ) PICTURE PesqPict("SD1","D1_DTVALID") Size 70,8 COLORS CLR_BLACK FONT oFontb OF oPanel PIXEL 


oDialog:Activate()

If nEscolha = 0
    Return
End

DBSelectArea("SB1")
DBSetOrder(1)
SB1->(dbSeek(xFilial("SB1")+cProduto))

If SB1->(Eof())
    Alert("Produto não encontrado!")
    lTrue := .F.
    Return
End

DBSelectArea("SD1")
DBSetOrder(5)
SD1->(dbSeek(xFilial("SD1")+cProduto+cLocal+cNumSeq))

If SD1->(Eof())
    Alert("Documento não encontrado!")
    lTrue := .F.
    Return
End

DBSelectArea("SB8")
DBSetOrder(3)
SB8->(dbSeek(xFilial("SB8")+cProduto+cLocal+cLoteOri))

If SB8->(Eof())
    Alert("Lote não localizado!")
    lTrue := .F.
    Return
End

DBSelectArea("SD5")
DBSetOrder(3)
SD5->(dbSeek(xFilial("SD5")+cNumSeq+cProduto+cLocal+cLoteOri))

If SD5->(Eof())
    Alert("Movimento não localizado!")
    lTrue := .F.
    Return
End


If nQtdOri <> nSaldo 
    Alert("Já existe saldo Distribuido, não é permitido alterar o lote.")
    lTrue := .F.
    Return
End
    
If SB1->B1_RASTRO <> 'L'
    Alert("Produto não controla Lote")
    lTrue := .F.
    Return
End

If lTrue

    Begin Transaction
       
        RecLock("SD1",.F.)
        SD1->D1_LOTECTL := cLote
        SD1->D1_DTVALID := dValidade
        SD1->(MsUnLock())
        
        RecLock("SDA",.F.)
        SDA->DA_LOTECTL := cLote
        SDA->(MsUnlock())
            
        DBSelectArea("SB8")
        DBSetOrder(3)
        If SB8->(dbSeek(xFilial("SB8")+cProduto+cLocal+cLote))
            
            lExist := .T.

            RecLock("SB8",.F.)
            SB8->B8_SALDO   := SB8->B8_SALDO + nQtdOri
            SB8->(MsUnlock())

            IF SB8->(dbSeek(xFilial("SB8")+cProduto+cLocal+cLoteOri))

                SB8->(RecLock("SB8",.F.))
                SB8->(DbDelete())
                SB8->(MsUnLock())
            EndIf        
        
        Else

            DBSelectArea("SB8")
            DBSetOrder(3)
            SB8->(dbSeek(xFilial("SB8")+cProduto+cLocal+cLoteOri))
            
            RecLock("SB8",.F.)
            SB8->B8_LOTECTL := cLote
            SB8->B8_DTVALID := dValidade
            SB8->(MsUnlock())
            
            
        EndIf
            
        DBSelectArea("SD5")
        DBSetOrder(3)
        If SD5->(dbSeek(xFilial("SD5")+cNumSeq+cProduto+cLocal+cLoteOri))
    
                While cLoteOri = SD5->D5_LOTECTL .And. cDoc = SD5->D5_DOC .And. cSerie = SD5->D5_SERIE .And. cClifor = SD5->D5_CLIFOR .And.;
                    cLoja = SD5->D5_LOJA .And. cNumSeq = SD5->D5_NUMSEQ

                        RecLock("SD5",.F.)
                        SD5->D5_LOTECTL := cLote
                        SD5->D5_DTVALID := dValidade
                        SD5->(MsUnlock())

                        SD5->(dbSkip())

                EndDo
        Else
                lTrue := .F.
        EndIf
    
        ///////Valida��o

        DBSelectArea("SD1")
        DBSetOrder(5)
        If SD1->(dbSeek(xFilial("SD1")+cProduto+cLocal+cNumSeq))
            If SD1->D1_LOTECTL = cLote
                DBSelectArea("SB8")
                DBSetOrder(3)
                If  SB8->(dbSeek(xFilial("SB8")+cProduto+cLocal+cLote))
                    DBSelectArea("SD5")
                    DBSetOrder(3)
                    If  SD5->(dbSeek(xFilial("SD5")+cNumSeq+cProduto+cLocal+cLote))
                        DBSelectArea("SB8")
                        DBSetOrder(3)
                        If SB8->(dbSeek(xFilial("SB8")+cProduto+cLocal+cLote))
                            If SB8->B8_SALDO < nQtdOri
                                lTure := .F.
                            EndIf
                        EndIf 
                    else
                        lTrue := .F.
                    EndIf
                else
                    lTrue := .F.
                EndIf
            else
                lTrue := .F.
            EndIf
        else
            lTrue := .F.
        End
        //////////
        If !lTrue
            DisarmTransaction()
            Alert("Altera��o foi desfeita devido problemas de integridade referencial")
        End
    End Transaction
EndIf
    
Return
