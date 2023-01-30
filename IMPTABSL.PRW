
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "RWMAKE.CH"
#include "Topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPTABB1 ³ Autor ³ BIALE                         ³ Data ³ 22/11/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ IMPORTAÇÃO DE TABELA EXCEL PARA UPDATE DA TABELA SB1                ±±
±±³                                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico - ALPAX           						              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function IMPTABSL()

Private   aTeste1   := {}
Private   cType     := "Arquivo da tabela | *.CSV"
Private   cPathEnt  := ""
Private   cNomArq   := ""
Private   cArquivo  := ""
Private   lRet      := .T.
Private   cMes      := ""
Private   cAno      := ""

cArquivo := cGetFile(cType,"Selecione o arquivo de importação",1,'C:\',.F.,GETF_LOCALHARD + GETF_LOCALFLOPPY)

aArqEDI := Directory(cArquivo)

aTeste1  := STRTOKARR(cArquivo,"\")
For nx := 1 to len(aTeste1)-1
	cPathEnt += aTeste1[nx]+"\"
Next

cNomArq := aTeste1[len(aTeste1)]

iF Empty(cNomArq)
	MsgBox("Nenhum arquivo a ser processado.","Atencao","ERRO")
	Return
Endif

cNomArq := aTeste1[len(aTeste1)]

aTeste1 := {}

Processa({||IMPTAB1()},"Importando tabela...")

If lRet
	MSGINFO("Tabela Importada com sucesso!!")
Else
	MSGINFO("Erro na Importação!!")
Endif

Return(.T.)

Static Function IMPTAB1()

Local   lLoop     := .t.	// Determina se ja houve skip de linha
Local   nLinha    := 1
Local   cCodProd  := ""
Local   cPN       := ""
Local   nSaldo    := 0
Local   aTeste2   := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Abre o arquivo     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FT_FUSE(cArquivo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa regua de processamento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua(FT_FLASTREC())
//IncProc("Importando tabela - "+Trim(cNomArq))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona no inicio do arquivo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FT_FGOTOP()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Loop para tratamento das linhas do arquivo        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lRet := .F.
DO While .t.
	If FT_FEOF()
		EXIT
	Endif
	cLinha  := FT_FREADLN()
	aTeste1  := STRTOKARR(cLinha,";")
	nLinha := nLinha + 1
	If nLinha >= 2
		If LEN(aTeste1) < 3
			lLoop := .T.
			EXIT
		Endif
		If ALLTRIM(aTeste1[01]) == ""
			FT_FSKIP()
			LOOP
		Endif
		dbselectarea("SB1")
		SB1->(DbOrderNickName("P. NUMBER"))
		If SB1->(dbseek(xFilial("SB1")+ALLTRIM(aTeste1[01])))
			DO WHILE SB1->(!EOF()) .AND. ALLTRIM(SB1->B1_PNUMBER) == ALLTRIM(aTeste1[01])
				IF ALLTRIM(SB1->B1_MARCA) == ALLTRIM(aTeste1[03])
					Reclock("SB1",.F.)
					SB1->B1_AXSUBLI  := ALLTRIM(aTeste1[02])
					SB1->(MsUnLock())
				ENDIF
				SB1->(dbSkip())
			ENDDO
		Endif
		IncProc("Adicionando sub-linha no P/N - "+alltrim(aTeste1[01]) )
		SB1->(dbclosearea())
	Endif
	aTeste1 := {}
	If !lLoop
		FT_FSKIP()
	Else
		lLoop := .F.
	EndIf
EndDo
lRet := .T.
FT_FUSE()

Return(.T.)
