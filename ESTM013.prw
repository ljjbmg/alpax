#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTM013()

Private cNome        := " "
Private cDescricao   := " "
Private cDiferencial := " "
Private cLinha       := " "
Private cCapacidade  := " "
Private cMarca       := " "



If ApMsgYesNo("Este programa ira corrigir os cadastros errados nos campos part number, nome, diferencial e descricao, confirma ?")
	Processa({|| fAtualiza()})
EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtualiza บAutor  ณAdriano Luis Brandaoบ Data ณ  02/06/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de atualizacao.                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtualiza()


IF SELECT("QR1") <> 0
	DBSELECTAREA("QR1")
	DBCLOSEAREA()
ENDIF

cqry := "SELECT B1_PNUMBER AS REFERENCIA, B1_DESC AS DESCRICAO, B1_NOME AS NOME, B1_AXDIF AS DIFERENCIAL, B1_COD AS CODIGO, "
cqry += " B1_AXLINHA AS LINHA, B1_CAPACID AS CAPACIDADE, B1_MARCA AS MARCA "
cqry += "FROM "+RetSqlName("SB1")+" SB1 "
cqry += "ORDER BY B1_COD "

MEMOWRIT("D:\A\SQL_EMIN.AQL",cqry)
TcQuery cqry New Alias "QR1"

SB1->(DbSetOrder(1))
// B1_FILIAL, B1_COD, R_E_C_N_O_, D_E_L_E_T_

ProcRegua(SB1->(Lastrec()))


Do While !QR1->(Eof())
	IncProc("Produto: " + QR1->REFERENCIA )
	dbselectarea("SB1")
	DBSETORDER(1)
	DBGOTOP()
	cNome        := Space(Len(QR1->NOME))
	cDescricao   := Space(Len(QR1->DESCRICAO))
	cDiferencial := Space(Len(QR1->DIFERENCIAL))
	cLinha       := Space(Len(QR1->LINHA))
	cCapacidade  := Space(Len(QR1->CAPACIDADE))
	cMarca       := Space(Len(QR1->MARCA))	

    // LIMPA CONTEUDO DO CAMPO	
	If SB1->(DbSeek(xFilial("SB1")+alltrim(QR1->CODIGO)))
		RecLock("SB1",.f.)
		SB1->B1_NOME    := cNome
		SB1->B1_MARCA   := cMarca
		SB1->B1_AXDIF   := cDiferencial
		SB1->B1_AXLINHA := cLinha
		SB1->B1_CAPACID := cCapacidade
		SB1->B1_DESC    := cDescricao
		MsUnLock()
	EndIf
	
	// GRAVA CONTEUDO NO CAMPO	
	If SB1->(DbSeek(xFilial("SB1")+alltrim(QR1->CODIGO)))
		RecLock("SB1",.f.)
		SB1->B1_PNUMBER := QR1->REFERENCIA 
		SB1->B1_AXLINHA := Alltrim(Posicione("SZ1",1,xFilial("SZ1")+Substr(QR1->CODIGO,01,02),"Z1_DESCPRO"))
		SB1->B1_MARCA   := Alltrim(Posicione("SZ2",1,xFilial("SZ2")+Substr(QR1->CODIGO,03,03),"Z2_DESCPRO"))				
		SB1->B1_NOME    := Alltrim(Posicione("SZ3",1,xFilial("SZ3")+Substr(QR1->CODIGO,06,04),"Z3_DESCPRO"))
		SB1->B1_CAPACID := Alltrim(Posicione("SZ5",1,xFilial("SZ5")+Substr(QR1->CODIGO,10,03),"Z5_DESCPRO"))		
		SB1->B1_AXDIF   := Alltrim(Posicione("SZ6",1,xFilial("SZ6")+Substr(QR1->CODIGO,13,03),"Z6_DESCPRO"))
		SB1->B1_DESC    := ALLTRIM(QR1->NOME)+' '+ALLTRIM(QR1->DIFERENCIAL)
		MsUnLock()
	EndIf
	
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return
