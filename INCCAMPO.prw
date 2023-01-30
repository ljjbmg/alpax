#INCLUDE "protheus.ch"

//UPDATE PARA CRIACAO DOS CAMPOS

USER FUNCTION INCCAMPO()	//U_INCCAMPO()

cArqEmp 			:= "SigaMat.Emp"
__cInterNet 		:= Nil

PRIVATE cMessage
PRIVATE aArqUpd	 	:= {}
PRIVATE aREOPEN	 	:= {}
PRIVATE oMainWnd
Private nModulo 	:= 51 // modulo SIGAHSP

SET DELE ON

lEmpenho				:= .F.
lAtuMnu					:= .F.

PROCESSA({|| ProcATU()},"Processando [FAT]","Aguarde , processando preparação dos arquivos")

RETURN()


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ProcATU   ³ Autor ³                       ³ Data ³  /  /    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao de processamento da gravacao dos arquivos           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Baseado na funcao criada por Eduardo Riera em 01/02/2002   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
STATIC FUNCTION ProcATU()
Local cTexto    	:= ""
Local cFile     	:= ""
Local cMask     	:= "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno    	:= 0
Local nI        	:= 0
Local nX        	:= 0
Local aRecnoSM0 	:= {}
Local lOpen     	:= .F.

ProcRegua(1)
IncProc("Verificando integridade dos dicionários....")
If (lOpen := IIF(Alias() <> "SM0", MyOpenSm0Ex(), .T. ))

	DBSELECTAREA("SM0")
	dbGotop()
	While !Eof()
  		If Ascan(aRecnoSM0,{ |x| x[2] == M0_CODIGO}) == 0
			Aadd(aRecnoSM0,{Recno(),M0_CODIGO})
		EndIf			
		dbSkip()
	EndDo	

	If lOpen
		For nI := 1 To Len(aRecnoSM0)
			SM0->(dbGoto(aRecnoSM0[nI,1]))
			RpcSetType(2)
			RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL)
 		nModulo := 51 // modulo SIGAHSP
			lMsFinalAuto := .F.
			cTexto += Replicate("-",128)+CHR(13)+CHR(10)
			cTexto += "Empresa : "+SM0->M0_CODIGO+SM0->M0_NOME+CHR(13)+CHR(10)

			ProcRegua(8)

			Begin Transaction

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza o dicionario de arquivos.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc("Analisando Dicionario de Arquivos...")
			cTexto += GeraSX2()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza o dicionario de dados.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc("Analisando Dicionario de Dados...")
			cTexto += GeraSX3() 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza os indices.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc("Analisando arquivos de índices. "+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
			cTexto += GeraSIX()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza os Gatilhos SX7.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc("Analisando arquivos de Gatilhos. "+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
			cTexto += GeraSX7()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza Consulta Padrao SXB.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//IncProc("Analisando arquivos de Consulta Padrao. "+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
			//cTexto += GeraSXB()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza Consulta Padrao SXB.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			IncProc("Analisando arquivos de Consulta Padrao. "+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
			cTexto += GeraSX6()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Atualiza os TABELAS GENERICAS.³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			//IncProc("Analisando arquivos de índices. "+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
			//cTexto += GeraSX5()

			End Transaction
	
			__SetX31Mode(.F.)
			For nX := 1 To Len(aArqUpd)
				IncProc("Atualizando estruturas. Aguarde... ["+aArqUpd[nx]+"]")
				If Select(aArqUpd[nx])>0
					DBSELECTAREA(aArqUpd[nx])
					dbCloseArea()
				EndIf
				X31UpdTable(aArqUpd[nx])
				If __GetX31Error()
					Alert(__GetX31Trace())
					Aviso("Atencao!","Ocorreu um erro desconhecido durante a atualizacao da tabela : "+ aArqUpd[nx] + ". Verifique a integridade do dicionario e da tabela.",{"Continuar"},2)
					cTexto += "Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "+aArqUpd[nx] +CHR(13)+CHR(10)
				EndIf
				DBSELECTAREA(aArqUpd[nx])
			Next nX		

			RpcClearEnv()
			If !( lOpen := MyOpenSm0Ex() )
				Exit
		 EndIf
		Next nI
		
		If lOpen
			
			cTexto 				:= "Log da atualizacao " + CHR(13) + CHR(10) + cTexto
			__cFileLog := MemoWrite(Criatrab(,.f.) + ".LOG", cTexto)
			
			DEFINE FONT oFont NAME "Mono AS" SIZE 5,12
			DEFINE MSDIALOG oDlg TITLE "Atualizador [FAT] - Atualizacao concluida." From 3,0 to 340,417 PIXEL
				@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
				oMemo:bRClicked := {||AllwaysTrue()}
				oMemo:oFont:=oFont
				DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
				DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.t.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL //Salva e Apaga //"Salvar Como..."
			ACTIVATE MSDIALOG oDlg CENTER
	
		EndIf
		
	EndIf
		
EndIf 	

RETURN(Nil)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MyOpenSM0Ex³ Autor ³Sergio Silveira       ³ Data ³07/01/2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Efetua a abertura do SM0 exclusivo                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualizacao FIS                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
STATIC FUNCTION MyOpenSM0Ex()

Local lOpen := .F.
Local nLoop := 0

For nLoop := 1 To 20
	IF SELECT("SM0") <> 0 	   		//SE ALIAS ESTIVER ABERTO 
		DBSELECTAREA("SM0")	   		//SELECIONA
		SM0->(DBCLOSEAREA())   		//FECHA ALIAS TEMPORARIO 
		ENDIF                      	//FIM
	dbUseArea( .T.,, "SIGAMAT.EMP", "SM0", .F., .F. )
	If !Empty( Select( "SM0" ) )
		lOpen := .T.
		dbSetIndex("SIGAMAT.IND")
		Exit	
	EndIf
	Sleep( 500 )
Next nLoop

If !lOpen
	Aviso( "Atencao !", "Nao foi possivel a abertura da tabela de empresas de forma exclusiva !", { "Ok" }, 2 )
EndIf

RETURN( lOpen )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ GeraSX2  ³ Autor ³ MICROSIGA             ³ Data ³   /  /   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Funcao generica para copia de dicionarios                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC FUNCTION GeraSX2()
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aREGS  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.

aREGS  := {}
AADD(aREGS,{"ZBB","                                        ","ZBB010  ","ENDERECAMENTO POR SERIE       ","ENDERECAMENTO POR SERIE       ","ENDERECAMENTO POR SERIE       ","                                        ","C",     0," ","                                                                                                                                                                                                                                                          "," ",  0,"                                                                                                                                                                                                                                                              "})
AADD(aREGS,{"ZBC","                                        ","ZBC010  ","SEPARACAO X CAIXAS            ","SEPARACAO X CAIXAS            ","SEPARACAO X CAIXAS            ","                                        ","C",     0," ","                                                                                                                                                                                                                                                          "," ",  0,"                                                                                                                                                                                                                                                              "})

DBSELECTAREA("SX2")
DBSETORDER(1)

For i := 1 To Len(aREGS)

 DBSETORDER(1)
 lInclui := !DbSeek(aREGS[i, 1])

 cTexto += IIf( aREGS[i,1] $ cTexto, "", aREGS[i,1] + "\")

 RecLock("SX2", lInclui)
  For j := 1 to FCount()
   If j <= Len(aREGS[i])
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aREGS[i,j] := SubStr(aREGS[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
    If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
     Loop
    Else
     FieldPut(j,aREGS[i,j])
    EndIf
   Endif
  Next
 MsUnlock()
Next i


RestArea(aArea)
RETURN("SX2 : " + cTexto  + CHR(13) + CHR(10))

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ GeraSX3  ³ Autor ³ MICROSIGA             ³ Data ³   /  /   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Funcao generica para copia de dicionarios                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC FUNCTION GeraSX3()
LOCAL aArea 		:= GetArea()
LOCAL i      		:= 0
LOCAL j      		:= 0
LOCAL aREGS  		:= {}
LOCAL cTexto 		:= ''
LOCAL lInclui		:= .F.

aREGS  := {}

//CAMPOS DA TABELA ZBB(ENDERECAMENTO POR SERIE) ----------------------------------------------------------------------------------------------------
AADD(aREGS,{"ZBB","01","ZBB_FILIAL","C",02,00,"Filial      ","Sucursal    ","Branch      ","Filial do Sistema        ","Sucursal                 ","Branch of the System     ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€€","                                                                                                                                ","      ",01,"þÀ"," ","S","U","N"," "," "," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","033"," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","02","ZBB_DOC   ","C",09,00,"Num Doc     ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R","€","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","03","ZBB_SERIE ","C",03,00,"Serie       ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","04","ZBB_FORNEC","C",06,00,"Fornecedor  ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","05","ZBB_LOJA  ","C",02,00,"Loja        ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","06","ZBB_ITEM  ","C",04,00,"Item        ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","07","ZBB_COD   ","C",15,00,"Produto     ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","08","ZBB_LOCAL ","C",02,00,"Armazem     ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","09","ZBB_QUANT ","N",14,04,"Quantidade  ","            ","            ","                         ","                         ","                         ","@E 999,999,999.9999                          ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","10","ZBB_LOTE  ","C",10,00,"Lote        ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","12","ZBB_SERIAL","C",20,00,"Serial      ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","13","ZBB_STATUS","C",01,00,"Status      ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","1=ENDERECADO                                                                                                                    ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
AADD(aREGS,{"ZBB","11","ZBB_DTVAL ","D",08,00,"Dt Validade ","            ","            ","                         ","                         ","                         ","                                             ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})

//CAMPOS DA ZBC(SEPARACAO X CAIXA) -----------------------------------------------------------------------------------------------------------------
AADD(aREGS,{"ZBC","01","ZBC_FILIAL","C",02,00,"Filial      ","Sucursal    ","Branch      ","Filial do Sistema        ","Sucursal                 ","Branch of the System     ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€€","                                                                                                                                ","      ",01,"þÀ"," ","S","U","N"," "," "," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","033"," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N","N"})
AADD(aREGS,{"ZBC","02","ZBC_STATUS","C",01,00,"Status      ","Status      ","Status      ","Status                   ","Status                   ","Status                   ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","1=Separado;2=Expedido                                                                                                           ","1=Separado;2=Expedido                                                                                                           ","1=Separado;2=Expedido                                                                                                           ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","03","ZBC_CODSEP","C",12,00,"Separacao   ","Separacao   ","Separacao   ","Separacao                ","Separacao                ","Separacao                ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R","€","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","04","ZBC_CODPED","C",06,00,"Pedido      ","Pedido      ","Pedido      ","Pedido                   ","Pedido                   ","Pedido                   ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R","€","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","05","ZBC_NOTA  ","C",09,00,"Nota        ","Nota        ","Nota        ","Nota                     ","Nota                     ","Nota                     ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","06","ZBC_SERIE ","C",03,00,"Serie       ","Serie       ","Serie       ","Serie                    ","Serie                    ","Serie                    ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","07","ZBC_CODPRO","C",15,00,"Produto     ","Produto     ","Produto     ","Produto                  ","Produto                  ","Produto                  ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","08","ZBC_QUANT ","N",11,02,"Quant.      ","Quant.      ","Quant.      ","Quant.                   ","Quant.                   ","Quant.                   ","@E 99999999.99                               ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","09","ZBC_LOTE  ","C",10,00,"Lote        ","Lote        ","Lote        ","Lote                     ","Lote                     ","Lote                     ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","10","ZBC_SERIAL","C",20,00,"Serial      ","Serial      ","Serial      ","Serial                   ","Serial                   ","Serial                   ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","11","ZBC_CAIXA ","N",03,00,"Caixa       ","Caixa       ","Caixa       ","Caixa                    ","Caixa                    ","Caixa                    ","@E 999                                       ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})
AADD(aREGS,{"ZBC","12","ZBC_LOCAL ","C",20,00,"Local       ","Local       ","Local       ","Local                    ","Local                    ","Local                    ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",00,"þÀ"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})

//SC7 PEDIDO DE COMPRAS// C7_AXFINAL//ACRESCENTANDO OPCAO A=ATIVO ----------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
AADD(aREGS,{"SC7","12","C7_AXFINAL","C",02,00,"Finalidade  ","Finalidade  ","Finalidade  ","Finalidade do Material   ","Finalidade do Material   ","Finalidade do Material   ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","'01'                                                                                                                            ","LT    ",00,"þA"," ","S","U","S","A","R","€","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   "," "," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N"," "})

//DEFINE SE PRODUTO UTILIZARÁ CONTROLE DE SERIE
AADD(aREGS,{"SB1","R8","B1_CTRSER ","C",01,00,"Contr.Serial","Contr.Serial","Contr.Serial","Possui Controle de serial","Possui Controle de serial","Possui Controle de serial","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",0,"þÀ"," ","S","U","S","A","R","€","                                                                                                                                ","S=SIM;N=NAO                                                                                                                     ","S=SIM;N=NAO                                                                                                                     ","S=SIM;N=NAO                                                                                                                     ","                    ","                                                            ","                                                                                ","   ","1"," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})

//ENDERECO PADRAO ONDE O PRODUTO SERA ENDERECADO
AADD(aREGS,{"SB1","09","B1_ENDER  ","C",15,00,"Endereco Pad","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","'LOCAL'                                                                                                                         ","SBE   ",0,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   ","1"," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," ","N","N","               ","N","N","N"})

//CODIGO DE BARRAS DO RELATORIO DE SEPARACAO E CONFERENCIA
AADD(aREGS,{"SC9","70","C9_CODBAR ","C",12,00,"Cod. Barras ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",0,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   ","1"," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
//NUMERO DA CAIXA PARA SEPARACAO DO PEDIDO
AADD(aREGS,{"SC9","71","C9_CXNUM  ","N",09,00,"Caixa Num.  ","            ","            ","                         ","                         ","                         ","@E 999999999                                 ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",0,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   ","1"," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})
//NUMERO DA CAIXA PARA SEPARACAO DO PEDIDO
AADD(aREGS,{"SC9","72","C9_CXEND  ","C",30,00,"Caixa End.  ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",0,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   ","1"," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})

//CODIGO DE BARRAS DE SEPARAÇÃO NOS ITENS DA NOTA FISCAL DE SAIDA
AADD(aREGS,{"SD2","Z6","D2_CODBAR ","C",12,00,"Cod. Barras ","            ","            ","                         ","                         ","                         ","@!                                           ","                                                                                                                                ","€€€€€€€€€€€€€€ ","                                                                                                                                ","      ",0,"þA"," ","S","U","S","A","R"," ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                                                                                                                                ","                    ","                                                            ","                                                                                ","   ","1"," ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "," "," "," ","               ","N","N"," "})

DBSELECTAREA("SX3")
DBSETORDER(1)

FOR i := 1 TO LEN(aREGS)

	IF(Ascan(aArqUpd, aREGS[i,1]) == 0)
 		aAdd(aArqUpd, aREGS[i,1])
 	ENDIF

	DBSETORDER(2)
 	lInclui := !DBSEEK(aREGS[i, 3])

 	cTexto += IIf( aREGS[i,1] $ cTexto, "", aREGS[i,1] + "\")

	RECLOCK("SX3",lInclui)
	FOR j := 1 to FCount()
		IF j <= Len(aREGS[i])
			IF allTrim(Field(j)) == "X2_ARQUIVO"
				aREGS[i,j] := SubStr(aREGS[i,j], 1, 3) + SM0->M0_CODIGO + "0"
			ENDIF
			IF !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
				LOOP
			ELSE
				FieldPut(j,aREGS[i,j])
			ENDIF
		ENDIF
	NEXT
	SX3->(MSUNLOCK())
NEXT i  

RESTAREA(aAREA)
RETURN("SX3 : " + cTexto  + CHR(13) + CHR(10))

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ GeraSIX  ³ Autor ³ MICROSIGA             ³ Data ³   /  /   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Funcao generica para copia de dicionarios                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

STATIC FUNCTION GeraSIX()
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aREGS  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.

aREGS  := {}
AADD(aREGS,{"ZBB","1","ZBB_FILIAL+ZBB_DOC+ZBB_SERIE+ZBB_FORNEC+ZBB_LOJA                                                                                                                ","Num Doc+Serie+Fornecedor+Fornecedor+Loja                              ","Num Doc+Serie+Fornecedor+Fornecedor+Loja                              ","Num Doc+Serie+Fornecedor+Fornecedor+Loja                              ","U","                                                                                                                                                                ","          ","S"})
AADD(aREGS,{"ZBC","1","ZBC_FILIAL+ZBC_CODSEP+ZBC_CAIXA                                                                                                                                 ","Separacao+Caixa                                                       ","Separacao+Caixa                                                       ","Separacao+Caixa                                                       ","U","                                                                                                                                                                ","SEPARACAO ","S"})
AADD(aREGS,{"SC9","A","C9_FILIAL+C9_CODBAR                                                                                                                                             ","Cod. Barras                                                           ","Cod. Barras                                                           ","Cod. Barras                                                           ","U","                                                                                                                                                                ","C9_CODBAR ","S"})

DBSELECTAREA("SIX")
DBSETORDER(1)

For i := 1 To Len(aREGS)

 If(Ascan(aArqUpd, aREGS[i,1]) == 0)
 	aAdd(aArqUpd, aREGS[i,1])
 EndIf

 DBSETORDER(1)
 lInclui := !DbSeek(aREGS[i, 1] + aREGS[i, 2])
 If !lInclui
  TcInternal(60,RetSqlName(aREGS[i, 1]) + "|" + RetSqlName(aREGS[i, 1]) + aREGS[i, 2])
 Endif

 cTexto += IIf( aREGS[i,1] $ cTexto, "", aREGS[i,1] + "\")

 RecLock("SIX", lInclui)
  For j := 1 to FCount()
   If j <= Len(aREGS[i])
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aREGS[i,j] := SubStr(aREGS[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
    If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
     Loop
    Else
     FieldPut(j,aREGS[i,j])
    EndIf
   Endif
  Next
 MsUnlock()
Next i

RestArea(aArea)
RETURN("SIX : " + cTexto  + CHR(13) + CHR(10))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ GeraSX7  ³ Autor ³ MICROSIGA             ³ Data ³   /  /   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Funcao generica para copia de dicionarios                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC FUNCTION GeraSX7()
Local aArea 			:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aREGS  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.

aREGS  := {}
AADD(aREGS,{"C7_PRODUTO","003","M->C7_LOCAL := 'RC'                                                                                 ","C7_LOCAL  ","P","N","   ",0,"                                                                                                    ","                                        ","U"})



DBSELECTAREA("SX7")
DBSETORDER(1)

For i := 1 To Len(aREGS)

 DBSETORDER(1)
 lInclui := !DbSeek(aREGS[i, 1] + aREGS[i, 2])

 cTexto += IIf( aREGS[i,1] $ cTexto, "", aREGS[i,1] + "\")

 RecLock("SX7", lInclui)
  For j := 1 to FCount()
   If j <= Len(aREGS[i])
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aREGS[i,j] := SubStr(aREGS[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
    If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
     Loop
    Else
     FieldPut(j,aREGS[i,j])
    EndIf
   Endif
  Next
 MsUnlock()
Next i


RestArea(aArea)
RETURN("SX7 : " + cTexto  + CHR(13) + CHR(10))

/* ------------------------------------------------------------------------------------------------------------------------------------------------
AUTOR	: ANDERSON BIALE
DATA	: 02/10/12
DESC   	: FUNCAO PARA CRIACAO DE CONSULTA PADRAO SXB
------------------------------------------------------------------------------------------------------------------------------------------------*/

STATIC FUNCTION GeraSXB()
Local aArea 		:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aREGS  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.

aREGS  := {}
AADD(aREGS,{"CC2SZR","1","01","DB","Municipios clientes ","Municipios clientes ","Customer City       ","CC2                                                                                                                                                                                                                                                       ",""})
AADD(aREGS,{"CC2SZR","2","01","02","Municipio           ","                    ","                    ","                                                                                                                                                                                                                                                          ",""})
AADD(aREGS,{"CC2SZR","4","01","01","                    ","                    ","                    ","                                                                                                                                                                                                                                                          ",""})
AADD(aREGS,{"CC2SZR","4","01","02","Estado              ","Estado              ","State               ","CC2_EST                                                                                                                                                                                                                                                   ",""})
AADD(aREGS,{"CC2SZR","4","01","03","Codigo IBGE         ","Codigo IBGE         ","IBGE Code           ","CC2_CODMUN                                                                                                                                                                                                                                                ",""})
AADD(aREGS,{"CC2SZR","4","01","04","Municipio           ","Municipio           ","City                ","CC2_MUN                                                                                                                                                                                                                                                   ",""})
AADD(aREGS,{"CC2SZR","5","01","  ","                    ","                    ","                    ","CC2_CODMUN                                                                                                                                                                                                                                                ",""})
AADD(aREGS,{"CC2SZR","5","02","  ","                    ","                    ","                    ","CC2_MUN                                                                                                                                                                                                                                                   ",""})
AADD(aREGS,{"CC2SZR","6","01","  ","                    ","                    ","                    ","CC2->CC2_EST==M->ZBC_EST                                                                                                                                                                                                                                   ",""})

DBSELECTAREA("SXB")
DBSETORDER(1)

For i := 1 To Len(aREGS)

 DBSETORDER(1)
 lInclui := !DbSeek(aREGS[i, 1] + aREGS[i, 2])

 cTexto += IIf( aREGS[i,1] $ cTexto, "", aREGS[i,1] + "\")

 RecLock("SXB", lInclui)
  For j := 1 to FCount()
   If j <= Len(aREGS[i])
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aREGS[i,j] := SubStr(aREGS[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
    If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
     Loop
    Else
     FieldPut(j,aREGS[i,j])
    EndIf
   Endif
  Next
 MsUnlock()
Next i

RestArea(aArea)
RETURN("SXB : " + cTexto  + CHR(13) + CHR(10))  

/* ------------------------------------------------------------------------------------------------------------------------------------------------
AUTOR	: ANDERSON BIALE
DATA	: 03/10/12
DESC   	: FUNCAO PARA CRIACAO PARAMETROS SX6
------------------------------------------------------------------------------------------------------------------------------------------------*/

STATIC FUNCTION GeraSX6()
Local aArea 		:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aREGS  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.

aREGS  := {}
//CUSTOMIZADO PARA USUARIOS QUE PODEM FAZER TRANSFERENCIA ESPECIFICAS
AADD(aREGS,{"  ","AD_USUTRA ","C","Usuarios que podem fazer transf. especificas.     ","BIALE                                             ","                                                  ","                                                  ","                                                  ","                                                  ","                                                  ","                                                  ","                                                  ","ocimar                                                                                                                                                                                                                                                    ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          ","U"," ","                                                                                                                                ","","                                                                                                                                ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          ","                                                                                                                                                                                                                                                          "})

//PADRAO PARA FAZER O CONTROLE DE LOTE
AADD(aREGS,{"  ","MV_RASTRO ","C","Determina a utilizacao ou nao  da  Rastreabilidade","Determina el uso o no del seguimiento de los lotes","Determine the use or not of Trackability of       ","dos Lotes de Producao (Informar S para  Sim  ou  N","de produccion (informar S para si o N para no)    ","Production Lots (Enter S for Yes or               ","para Nao).                                        ",".                                                 ","N for No).                                        ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         ","S","S","                                                                                                                                ","","                                                                                                                                ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         "})
AADD(aREGS,{"  ","MV_LOCALIZ","C","Indica se produtos poderao usar controle de locali","Indica si los productos pueden usar control de    ","Inform if the products can use physical location  ","zacao fisica ou nao. (S)im ou (N)ao.              ","localizacion. (S)i o (N)o.                        ","control or not (S)=Yes or (N)o.                   ","                                                  ","                                                  ","                                                  ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         ","S","N","                                                                                                                                ","","                                                                                                                                ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         ","S                                                                                                                                                                                                                                                         "})

DBSELECTAREA("SX6")
DBSETORDER(1)

For i := 1 To Len(aREGS)

 DBSETORDER(1)
 lInclui := !DbSeek(aREGS[i, 1] + aREGS[i, 2])

 cTexto += IIf( aREGS[i,1] $ cTexto, "", aREGS[i,1] + "\")

 RecLock("SX6", lInclui)
  For j := 1 to FCount()
   If j <= Len(aREGS[i])
   	If allTrim(Field(j)) == "X2_ARQUIVO"
   		aREGS[i,j] := SubStr(aREGS[i,j], 1, 3) + SM0->M0_CODIGO + "0"
   	EndIf
    If !lInclui .AND. AllTrim(Field(j)) == "X3_ORDEM"
     Loop
    Else
     FieldPut(j,aREGS[i,j])
    EndIf
   Endif
  Next
 MsUnlock()
Next i

RestArea(aArea)
RETURN("SX6 : " + cTexto  + CHR(13) + CHR(10))   


/* ------------------------------------------------------------------------------------------------------------------------------------------------
AUTOR	: ANDERSON BIALE
DATA	: 03/10/12
DESC   	: FUNCAO PARA CRIACAO DE TABELA GENERICA
------------------------------------------------------------------------------------------------------------------------------------------------*/

STATIC FUNCTION GeraSX5()
Local aArea 		:= GetArea()
Local i      		:= 0
Local j      		:= 0
Local aREGS  		:= {}
Local cTexto 		:= ''
Local lInclui		:= .F.

aREGS  := {}
AADD(aREGS,{"  ","LT","01    ","ARMAZEM DE TRANSFERENCIA                               ","ARMAZEM DE TRANSFERENCIA                               ","ARMAZEM DE TRANSFERENCIA                               "})
AADD(aREGS,{"  ","LT","02    ","MATERIAL DE REVENDA                                    ","MATERIAL DE REVENDA                                    ","MATERIAL DE REVENDA                                    "})
AADD(aREGS,{"  ","LT","03    ","MATERIAL DE TERCEIROS PARA CALIBRAR                    ","MATERIAL DE TERCEIROS PARA CALIBRAR                    ","MATERIAL DE TERCEIROS PARA CALIBRAR                    "})
AADD(aREGS,{"  ","LT","04    ","MATERIAL DE CONSUMO E USO(OBS.SENDO SUBST. PELO MC)    ","MATERIAL DE CONSUMO E USO(OBS.SENDO SUBST. PELO MC)    ","MATERIAL DE CONSUMO E USO(OBS.SENDO SUBST. PELO MC)    "})
AADD(aREGS,{"  ","LT","05    ","MATERIAL COM DEFEITO PARA DEVOLVER                     ","MATERIAL COM DEFEITO PARA DEVOLVER                     ","MATERIAL COM DEFEITO PARA DEVOLVER                     "})
AADD(aREGS,{"  ","LT","10    ","GRAVACAO DE CALIBRACAO PEDIDOS CANCELADOS E DEVOLVIDOS ","GRAVACAO DE CALIBRACAO PEDIDOS CANCELADOS E DEVOLVIDOS ","GRAVACAO DE CALIBRACAO PEDIDOS CANCELADOS E DEVOLVIDOS "})

DBSELECTAREA("SX5")
DBSETORDER(1)

For i := 1 To Len(aREGS)

 DBSETORDER(1)
 lInclui := !DbSeek(aREGS[i, 1] + aREGS[i, 2])					//VERI

 cTexto += IIf( aREGS[i,1] $ cTexto, "", aREGS[i,1] + "\")

	RecLock("SX5", lInclui)
	For j := 1 to FCount()
		If j <= Len(aREGS[i])
			If allTrim(Field(j)) == "X2_ARQUIVO"
				aREGS[i,j] := SubStr(aREGS[i,j], 1, 3) + SM0->M0_CODIGO + "0"
			EndIf
			If !lInclui .AND. AllTrim(Field(j)) == "X5_CHAVE"
				Loop
			Else
				FieldPut(j,aREGS[i,j])
			EndIf
		Endif
	Next
 MsUnlock()

Next i

RestArea(aArea)
RETURN("SX5 : " + cTexto  + CHR(13) + CHR(10))