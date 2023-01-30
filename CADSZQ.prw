#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CADSZQ    º Autor ³ Fagner / Biale     º Data ³  28/12/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CADSZQ

Private cCadastro := "Cadastro de Comissões"
/*
Private aRotina := { {"Pesquisar" ,"AxPesqui"     ,0,1} ,;
                     {"Visualizar","u_SZQCAD(2)"     ,0,2} ,;
                     {"Incluir"   ,"u_SZQCAD(3)"     ,0,3} ,;
                     {"Alterar"   ,"u_SZQCAD(4)"     ,0,4} ,;
                     {"Excluir"   ,"u_SZQCAD(5)"     ,0,5} ,;
                     {"Relatório" ,"U_RELSZQ"     ,0,6} }
*/
Private aRotina := { {"Pesquisar" ,"AxPesqui"     ,0,1} ,;
                     {"Visualizar","AxVisual"     ,0,2} ,;
                     {"Incluir"   ,"AxInclui"     ,0,3} ,;
                     {"Alterar"   ,"AxAltera"     ,0,4} ,;
                     {"Excluir"   ,"AxDeleta"     ,0,5} ,;
                     {"Relatório" ,"U_RELSZQ"     ,0,6} }


Private cString := "SZQ" 

DBSelectArea(cString)
DBSetOrder(1)

MBROWSE(,,,,cString)

Return
/*
User Function CADSZQ

Private cCadastro := "Cadastro de Comissões"
Private aRotina := { {"Pesquisar" ,"AxPesqui"     ,0,1} ,;
                     {"Visualizar","AxVisual"     ,0,2} ,;
                     {"Incluir"   ,"AxInclui"     ,0,3} ,;
                     {"Alterar"   ,"AxAltera"     ,0,4} ,;
                     {"Excluir"   ,"AxDeleta"     ,0,5} ,;
                     {"Relatório" ,"U_RELSZQ"     ,0,6} }

Private cString := "TMP" 
Private aCampos := {}
Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

aadd(aCampos, {"Código"  ,"ZQ_VEND"   ,"C",6 ,0,"@!"}) 
aadd(aCampos, {"Vendedor","ZQ_DSVEND","C",20,0,"@!"}) 
      
cQry:= "SELECT ZQ_VEND, ZQ_DSVEND FROM SZQ010 WHERE D_E_L_E_T_ = '' GROUP BY  ZQ_VEND, ZQ_DSVEND ORDER BY 1"

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"TMP",.F.,.F.)
                                      
cFiltro         := ''
cIndex    		:= CriaTrab(NIL,.F.)
cChave			:= "ZQ_VEND, ZQ_DSVEND"

IndRegua("TMP",cIndex,cChave,,cFiltro)


DBSelectArea(cString)
//DBSetOrder(1)           
TMP->(DBGOTOP())
MBROWSE(,,,,cString,aCampos)

TMP->(DBCloseArea())
*/
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RELSZQ    º Autor ³ Fagner / Biale     º Data ³  28/12/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function RELSZQ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Relatório de Comissão"
Local cPict          := ""
Local titulo       := "Relatório de Comissão"
Local nLin         := 80

Local Cabec1       := "Vendedor                      Linha             Familia  % Min.  % Max.  Comissão "
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "RELSZQ" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cPerg       := "SZQREL"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RELSZQ" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "SZQ"

dbSelectArea("SZQ")
dbSetOrder(1)

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)


RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  28/12/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem

dbSelectArea(cString)
dbSetOrder(1)


SetRegua(RecCount())


dbGoTop()
While SZQ->(!EOF()) .AND.   SZQ->ZQ_VEND >= MV_PAR01 .AND.  SZQ->ZQ_VEND <= MV_PAR02

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif
    @nLin,00 PSAY SZQ->ZQ_VEND + ' - ' + SZQ->ZQ_DSVEND
    DBSelectArea("SZ1")
    SZ1->(DBSetOrder(1))
    
    IF SZ1->(DBSEEK(xFilial("SZ1")+ SZQ->ZQ_LINHA))
		@nLin,30 PSAY SZ1->Z1_DESCR    
    Endif
    
	@nLin,48 PSAY SZQ->ZQ_FAMILIA
	@nLin,56 PSAY TRANSFORM(SZQ->ZQ_PMINIMO, "@E 999.00")
	@nLin,64 PSAY TRANSFORM(SZQ->ZQ_PMAXIMO, "@E 999.00")
	@nLin,73 PSAY TRANSFORM(SZQ->ZQ_COMISSAO, "@E 999.00")	

   nLin := nLin + 1 // Avanca a linha de impressao

   SZQ->(dbSkip()) // Avanca o ponteiro do registro no arquivo
EndDo

SET DEVICE TO SCREEN


If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

User Function SZQCAD(nOpcx)
                                 
Private aSize	  := MsAdvSize(,.F.,430)
Private aObjects  := {}
Private aPosObj   := {}
Private aSizeAut  := MsAdvSize()    
Private aC		  := {}
Private aR		  := {}                                                 
Private aCGD 	  := {70,12,118,350} 
Private aCjan     := {70,100,450,800}
Private nUsado	  := 0
Private aHeader := {}
Private aCols   := {}

Private cVend   := iif(nOpcx = 3,criavar("SZQ->ZQ_VEND",.F.), SZQ->ZQ_VEND)
Private cDSVend := iif(nOpcx = 3,criavar("SZQ->ZQ_DSVEND",.F.), SZQ->ZQ_DSVEND)

dbSelectArea("SX3")
dbSetOrder(1)
DBSEEK("SZQ")

WHILE X3_ARQUIVO == "SZQ" .AND. !EOF()
	If X3Uso(SX3->X3_USADO) .And. SX3->X3_NIVEL <= cNivel  .AND. ! Eof() .AND. !ALLTRIM(SX3->X3_CAMPO) $ "ZQ_VEND ZQ_DSVEND"
		nUsado++
		AADD(aHeader,{ AllTrim(X3Titulo()),;
		SX3->X3_CAMPO,;
		SX3->X3_PICTURE,;
		SX3->X3_TAMANHO,;
		SX3->X3_DECIMAL,;
		SX3->X3_VALID,;
		SX3->X3_USADO,;
		SX3->X3_TIPO,;
		SX3->X3_ARQUIVO,;
		SX3->X3_CONTEXT } )
	Endif
	SX3->(dbSkip())
ENDDO
                   
If nOpcx = 3

	AADD(aCols,Array(nUsado+1))
	
	FOR I:= 1 TO Len(aHeader)
		if aHeader[i][10] <> "V"
			aCols[len(Acols)][i]:= criaVar(aHeader[i][2],.F.)
		endif
	next
	aCols[len(aCols)][len(aCols[len(aCols)])] := .F.

Else 
	dbSelectArea("SZQ")
	SZQ->(dbSetOrder(1))
	SZQ->(DBGOTOP()) 
	SZQ->(dbSeek(XFILIAL("SZQ")+cVend))
	
	nCnt := 0
	aRecnos	:=	Array(nCnt)     
	
	AADD(aC,{"cVend"    ,{20,010} ,"Código "    ,"@!",,"SA3X",.F.})
	AADD(aC,{"cDSVend"  ,{20,075} ,"Vendedor "  ,"@!",,"    ",.F.})
	
	While !Eof() .and. SZQ->ZQ_VEND== cVend .and. SZQ->ZQ_FILIAL == XFILIAL("SZQ")
		AADD(aCols,Array(nUsado+1))                   
		for i:= 1 to len(aHeader)
			if aHeader[i][10] <> "V"
				if ALLTRIM(aHeader[i][2]) == "ZQ_VEND"
					SZQ->(dbSetOrder(1))
					SZQ->(dbSeek(XFILIAL("SZQ")+ SZQ->&(aHeader[i][2])))
				ENDIF
				ACOLS[len(aCols)][i] := &(aHeader[i][2])
			endif  
		next     
		aCols[len(aCols)][len(aCols[len(aCols)])] := .F.
		dbSkip()
	Enddo
	Endif
	
lRetMod2:=Modelo2(cCadastro,aC,aR,aCGD,nOpcx,"AllwaysTrue()","AllwaysTrue()",,,,,aCjan)



Return

