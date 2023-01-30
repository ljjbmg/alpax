#INCLUDE "RWMAKE.CH"
#Include "PROTHEUS.CH"
#Include "RPTDef.ch"
#Include "FWPrintSetup.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  RFINR02 ³ Autor ³                       ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASER DO ITAU COM CODIGO DE BARRAS     ³±±                      
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function BOLITAU(_lEmail, lGetPDF )

LOCAL   aCampos 	:= {{"E1_NOMCLI","Cliente","@!"},{"E1_PREFIXO","Prefixo","@!"},{"E1_NUM","Titulo","@!"},;
{"E1_PARCELA","Parcela","@!"},{"E1_VALOR","Valor","@E 9,999,999.99"},{"E1_VENCTO","Vencimento"}}

LOCAL   aMarked 	:= {}
Local cFilePDF		:= ""
PRIVATE CB_RN_NN    := {}
PRIVATE aDadosBanco
PRIVATE cCod_Comp
PRIVATE Exec    	:= .F.
PRIVATE cIndexName 	:= ''
PRIVATE cIndexKey  	:= ''
PRIVATE cFilter    	:= ''

DEFAULT _lEmail 	:= .f.
Default lGetPDF		:= .F.

dbSelectArea("SE1")

cPerg     :="FINR03"

If( !lGetPDF )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ValidPerg()

	If !Pergunte(cPerg,.T.)
		Return()
	EndIf
EndIf

DbSelectArea("SE1")
DBGOTOP()

cIndexName := Criatrab(Nil,.F.)
cIndexKey  := 	"E1_PORTADO+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+DTOS(E1_EMISSAO)"
cFilter    := 	"E1_PREFIXO >= '" + MV_PAR01 + "' .And. E1_PREFIXO <= '" + MV_PAR02 + "' .And. " + ;
"E1_NUM     >= '" + MV_PAR03 + "' .And. E1_NUM     <= '" + MV_PAR04 + "' .And. " + ;
"E1_PARCELA >= '" + MV_PAR05 + "' .And. E1_PARCELA <= '" + MV_PAR06 + "' .And. " + ;
"E1_PORTADO  = '" + MV_PAR07 + "' .And. E1_AGEDEP   = '" + MV_PAR08 + "' .And. " + ;
"E1_CONTA    = '" + MV_PAR09 + "' .And. " + ;
"E1_CLIENTE >= '" + MV_PAR10 + "' .And. E1_CLIENTE <= '" + MV_PAR11 + "' .And. " + ;
"E1_LOJA >= '" + MV_PAR12 + "' .And. E1_LOJA <= '" + MV_PAR13 + "' .And. " + ;
"E1_NUMBOR >= '" + MV_PAR14 + "' .And. E1_NUMBOR <= '" + MV_PAR15 + "' .And. " + ;
"E1_FILIAL   = '"+xFilial('SE1')+"'"


IndRegua("SE1", cIndexName, cIndexKey,, cFilter, "Aguarde selecionando registros....")

#IFNDEF TOP
	DbSetIndex(cIndexName + OrdBagExt())
#ENDIF
dbGoTop()

If( !lGetPDF )
	@ 001,001 TO 400,700 DIALOG oDlg TITLE "Selecao de Titulos"
	@ 001,001 TO 170,350 BROWSE "SE1" MARK "E1_OK"
	@ 180,310 BMPBUTTON TYPE 01 ACTION (Exec:=.T.,Close(oDlg))
	@ 180,280 BMPBUTTON TYPE 02 ACTION (Exec:=.F.,Close(oDlg))
	ACTIVATE DIALOG oDlg CENTERED

	//dbGoTop()
	Do While !Eof()
		If Marked("E1_OK")
			AADD(aMarked,.T.)
		Else
			AADD(aMarked,.F.)
		EndIf
		dbSkip()
	EndDo

	dbGoTop()

	IF Exec
		Processa({|lEnd|MontaRel(aMarked,_lEmail,lGetPDF)})
	EndIF
else
	cFilePDF := MontaRel( aMarked, _lEmail, lGetPDF )
EndIf
RetIndex("SE1")
fErase(cIndexName+OrdBagExt())

dbSelectArea('SE1')
RetIndex('SE1')
Return cFilePDF

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  MontaRel³ Autor ³                       ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function MontaRel(aMarked,_lEmail, lGetPDF )
LOCAL   oPrint
LOCAL   n := 0
Local _cNotas := ""
LOCAL aBitmap := " " //"M:\Boletos\Itau\Valido\ITAU.BMP"
// colocar o caminho q o bitmap vai estar , nao sabe se vai ser com 4 ou 2 barras.. logo grande q vem do banco salvar no system
// salva numa pasta na maq local com nome do maq e compartilhamento //nomemaq/nome compartilhamento    linha 259tbm ..
Local cFilePDF := ""
LOCAL aDadosEmp    := {	SM0->M0_NOMECOM                                                             ,; //[1]Nome da Empresa
SM0->M0_ENDCOB                                                              ,; //[2]Endereço
AllTrim(SM0->M0_BAIRCOB)+", "+AllTrim(SM0->M0_CIDCOB)+", "+SM0->M0_ESTCOB ,; //[3]Complemento
"CEP: "+Subs(SM0->M0_CEPCOB,1,5)+"-"+Subs(SM0->M0_CEPCOB,6,3)             ,; //[4]CEP
"PABX/FAX: "+SM0->M0_TEL                                                    ,; //[5]Telefones
"C.N.P.J.: "+Subs(SM0->M0_CGC,1,2)+"."+Subs(SM0->M0_CGC,3,3)+"."+          ; //[6]
Subs(SM0->M0_CGC,6,3)+"/"+Subs(SM0->M0_CGC,9,4)+"-"+                       ; //[6]
Subs(SM0->M0_CGC,13,2)                                                     ,; //[6]CGC
"I.E.: "+Subs(SM0->M0_INSC,1,3)+"."+Subs(SM0->M0_INSC,4,3)+"."+            ; //[7]
Subs(SM0->M0_INSC,7,3)+"."+Subs(SM0->M0_INSC,10,3)                         }  //[7]I.E

LOCAL aDadosTit
LOCAL aDatSacado
LOCAL aBolText     := {""                ,;
"Após o Vencimento Mora diária 0,33% - R$ "                       ,;
"Protestar no 6º dia corrido após o vencimento"                   ,;
"Não Aceitamos Depósitos em conta, TITULO Negociado."             ,;
"Pagar somente em Banco"                                          ,;
"** ATENÇÃO: NÃO RETIRAMOS TITULO DE CARTÓRIO **"}

// "Após o vencimento cobrar multa de R$ "

LOCAL i            	:= 1
LOCAL nRec         	:= 0
LOCAL _nVlrAbat    	:= 0
Local aInfos		:= {}
Local clocal		:= ""
Default lGetPDF		:= .F.

CB_RN_NN     := {}

//oPrint:= TMSPrinter():New( "Boleto Laser" )
cFile  := "bolitau" + dToS(dDatabase) + Replace(Time(),":", "-")
cFile  := Lower( cFile )    

IF lGetPDF
	cLocal := "BOLETOS/"
Else 
	cLocal:= "C:/temp"
Endif

oPrint:= FWMSPrinter():New(cFile, IMP_PDF, .T.,clocal, .T.)
oPrint:SetPortrait() 	// ou SetLandscape()
oPrint:SetPaperSize(DMPAPER_A4)	// Papel A4

If( _lEmail .Or. lGetPDF )
	oPrint:LHASAPPLYDEF := .F.
	oPrint:SetViewPDF ( .F. )
	oPrint:lServer	:= .T.
	oPrint:cPathPDF:= clocal
	oPrint:nDevice := IMP_PDF
EndIf 
//oPrint:StartPage()   	// Inicia uma nova página

dbGoTop()
Do While !EOF()
	nRec := nRec + 1
	dbSkip()
EndDo
dbGoTop()

ProcRegua(nRec)

cCod_Comp	:= '341-7'

Do While !EOF()
	//Posiciona o SA6 (Bancos)
	DbSelectArea("SA6")
	DbSetOrder(1)
	DbSeek(xFilial("SA6")+SE1->(E1_PORTADO+E1_AGEDEP+E1_CONTA),.T.)
	
	//Posiciona na Arq de Parametros CNAB
	DbSelectArea("SEE")
	DbSetOrder(1)
	DbSeek(xFilial("SEE")+SE1->(E1_PORTADO+E1_AGEDEP+E1_CONTA),.T.)
	
	aDadosBanco  := {SA6->A6_COD,; 		// [1]Numero do Banco + Digito Moeda
	SA6->A6_NOME,; 		// [2]Nome do Banco
	SUBSTR(SEE->EE_AGENCIA,1,4),; 		// [3]Agência
	Alltrim(SEE->EE_CONTA),; 		// [4]Conta Corrente
	Alltrim(SEE->EE_DVCTA),; 		// [5]Dígito da conta corrente
	Alltrim(SA6->A6_CARTEIR )} 		// [6]Codigo da Carteira

									// [14]faixa atual

	/*
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1")+SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO),.T.)
	*/
	
	If lGetPDF .Or. aMarked[i]
		If Empty(SE1->E1_NUMBCO)
			RecLock('SE1',.F.)
			SE1->E1_NUMBCO  := Alltrim(SEE->EE_FAXATU)
			msUnlock()
			
			RecLock("SEE",.f.)
			SEE->EE_FAXATU := StrZero((Val(Alltrim(SEE->EE_FAXATU))+1),8)
			MsUnlock()
		Endif
		_cNossoNum := AllTrim(SE1->E1_NUMBCO) /*Substr(SE1->E1_NUMBCO,1,11)*/
	Endif
	
	
	//Posiciona o SA1 (Cliente)
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA,.T.)
	
	DbSelectArea("SE1")
	
	If Empty(SA1->A1_ENDCOB)
		aDatSacado   := {AllTrim(SA1->A1_NOME)                            ,;     // [1]Razão Social
		AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA           ,;     // [2]Código
		AllTrim(SA1->A1_END )+"-"+AllTrim(SA1->A1_BAIRRO),;     // [3]Endereço
		AllTrim(SA1->A1_MUN )                             ,;     // [4]Cidade
		SA1->A1_EST                                       ,;     // [5]Estado
		SA1->A1_CEP                                       ,;     // [6]CEP
		SA1->A1_CGC									  }       // [7]CGC
	Else
		aDatSacado   := {AllTrim(SA1->A1_NOME)                               ,;   // [1]Razão Social
		AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA              ,;   // [2]Código
		AllTrim(SA1->A1_ENDCOB)+"-"+AllTrim(SA1->A1_BAIRROC),;   // [3]Endereço
		AllTrim(SA1->A1_MUNC)	                              ,;   // [4]Cidade
		SA1->A1_ESTC	                                      ,;   // [5]Estado
		SA1->A1_CEPC                                         ,;   // [6]CEP
		SA1->A1_CGC										   }    // [7]CGC
	Endif
	
	If lGetPDF .Or. aMarked[i]
		_nVlrAbat   :=  SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
		
		//CB_RN_NN    := Ret_cBarra(aDadosBanco[1],aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],AllTrim(_cNossoNum),(E1_VALOR-_nVlrAbat),Datavalida(E1_VENCTO,.T.))
		CB_RN_NN    := Ret_cBarra(aDadosBanco[1],aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],AllTrim(_cNossoNum),(E1_SALDO-_nVlrAbat),E1_VENCTO)
		
		aDadosTit    := {AllTrim(E1_NUM)+"-"+AllTrim(E1_PARCELA)						,;  // [1] Número do título
		E1_EMISSAO                              					,;  // [2] Data da emissão do título
		Date()                                  					,;  // [3] Data da emissão do boleto
		E1_VENCTO                  					,;  // [4] Data do vencimento
		(E1_SALDO - _nVlrAbat)                  					,;  // [5] Valor do título
		CB_RN_NN[3]                             					,;  // [6] Nosso número (Ver fórmula para calculo)
		E1_PREFIXO                               					,;  // [7] Prefixo da NF
		E1_TIPO	                               						}  // [8] Tipo do Titulo
		
		Impress(oPrint,aBitmap,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,CB_RN_NN)

		n := n + 1
		
		IF _lEmail .and. !(SE1->E1_NUM$_cNotas)
			_cNotas += IIF(_cNotas=="",SE1->E1_NUM,"/"+Alltrim(SE1->E1_NUM))
		ENDIF
		
	EndIf

	aAdd( aInfos ,{ SE1->E1_CLIENTE , SE1->E1_PREFIXO , SE1->E1_NUM , SE1->E1_PARCELA })

/*
	If Empty(SE1->E1_DVNBCO)//NUMBCO)
		RecLock("SE1",.F.)
		SE1->E1_DVNBCO  :=     Subs(CB_RN_NN[3],13,1)  //DV DO NOSSO NUMERO
		SE1->E1_DVCNAB  :=     Subs(CB_RN_NN[3],13,1)
		MsUnlock()
	EndIf
*/	
	dbSkip()
	IncProc()
	i := i + 1
	
EndDo

If _lEmail .Or. lGetPDF 
	
	oPrint:EndPage()     // Finaliza a página	
	
	oPrint:Print()
	cFilePrint := clocal+cFile+".rel"
	File2Printer( oPrint:cFilePrint, "PDF")
	sleep(1000)

	cFilePDF := Replace(oPrint:cFilePrint, ".rel", ".pdf")

	If( File( cFilePDF ) )
		If( _lEmail )
			DEFINE MSDIALOG oDlg TITLE "Boleto Itaú" FROM 0,0 TO 180,570 OF oDlg PIXEL
			
			@  3,3 SAY "De"       SIZE 30,7 PIXEL OF oDlg
			@ 15,3 SAY "Para"     SIZE 30,7 PIXEL OF oDlg
			@ 27,3 SAY "Cc"       SIZE 30,7 PIXEL OF oDlg
			@ 39,3 SAY "Assunto"  SIZE 30,7 PIXEL OF oDlg
			@ 51,3 SAY "Anexo"    SIZE 30,7 PIXEL OF oDlg
			
			cDe    	:= UsrRetMail()
			cAnexo 	:= cFilePDF//U__fGetFiles("\BOLETOS\"+_cFile+"_PAG1.JPG")
			cPara	:= SA1->A1_MAILWF

			cCc		:= GetNewPar("MV_WFADMIN","gerenciati@descarpack.com.br")
			cAssunto:= "Boleto - Descarpack"
			cMsg	:= U__fGetHTML(_cNotas)
			_lEnvia	:= .T.
			
			@  3, 35 SAY SM0->M0_NOMECOM  PICTURE "@"   SIZE 248, 7 PIXEL OF oDlg
			@ 15, 35 GET    cPara      	  PICTURE "@"   SIZE 248, 8 PIXEL OF oDlg
			@ 27, 35 GET    cCc        	  PICTURE "@"   SIZE 248, 8 PIXEL OF oDlg WHEN .F.
			@ 39, 35 SAY    cAssunto      PICTURE "@"   SIZE 248, 8 PIXEL OF oDlg
			@ 51, 35 MSGET  cAnexo        PICTURE "@"   SIZE 248, 8 PIXEL OF oDlg WHEN .F.
			
			@ 070,130 BUTTON "&Enviar"    SIZE 36,13 PIXEL ACTION Processa({|lEnd| _fEnvMail(cPara,cCc,cAssunto,cMsg,cAnexo,oDlg)})
			ACTIVATE MSDIALOG oDlg CENTERED

			If( File(cFilePDF))
				fErase(cFilePDF)
			EndIf
		EndIf
	else
		cFilePDF	:= ""
		FwAlertError("Não foi possivel gerar o PDF que iria anexo ao e-mail")
	EndIf
ELSE

	oPrint:EndPage()     // Finaliza a página
	oPrint:SetViewPDF ( .T. )

	oPrint:Preview()     // Visualiza antes de imprimir
ENDIF
Return cFilePDF
                                                                

/**************************************************************/
Static Function _fEnvMail(cPara,cCc,cAssunto,cMsg,cAnexo,oDlg)
IF Empty(cPara)
	MsgStop("Favor preencher o e-mail do cliente!")
ELSE
	 
	IF U_DKPEMAIL(cPara, cAssunto, cMsg, cAnexo, cCc, "")//ACSendMail(,,,,cPara+";"+cCc,cAssunto, cMsg,cAnexo)
		MsgStop("E-mail enviado com sucesso!")
		oDlg:End()
	ELSE
		MsgStop("Destinatário não informado!")
	ENDIF
ENDIF
Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³  Impress ³ Autor ³                       ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Impress(oPrint,aBitmap,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,CB_RN_NN)
LOCAL _nTxper := IIF(GETMV("MV_TXPER")==0, 0.33, GETMV("MV_TXPER"))
LOCAL oFont2n
LOCAL oFont8
LOCAL oFont9
LOCAL oFont10
LOCAL oFont15n
LOCAL oFont16
LOCAL oFont16n
LOCAL oFont14n
LOCAL oFont24
LOCAL i := 0
/*
LOCAL aCoords1 := {0150,1900,0550,2300}
LOCAL aCoords2 := {0450,1050,0550,1900}
LOCAL aCoords3 := {0710,1900,0810,2300}
LOCAL aCoords4 := {0980,1900,1050,2300}
LOCAL aCoords5 := {1330,1900,1400,2300}
LOCAL aCoords6 := {2280,1900,2380,2300}     // 2000 - 2100
LOCAL aCoords7 := {2550,1900,2620,2300}     // 2270 - 2340
LOCAL aCoords8 := {2900,1900,2970,2300}     // 2620 - 2690
LOCAL oBrush
*/
aBmp := "" //"M:\Boletos\Itau\Valido\ITAU.BMP"


//Parâmetros de TFont.New()
//1.Nome da Fonte (Windows)
//3.Tamanho em Pixels
//5.Bold (T/F)
oFont2n := TFont():New("Times New Roman",,12,,.T.,,,,,.F. ) //10
oFont8  := TFont():New("Arial",9,10,.T.,.F.,5,.T.,5,.T.,.F.)//8
oFont9  := TFont():New("Arial",9,11,.T.,.F.,5,.T.,5,.T.,.F.)//9
oFont10 := TFont():New("Arial",9,14,.T.,.T.,5,.T.,5,.T.,.F.)//10
oFont14n:= TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)//14
oFont15n:= TFont():New("Arial",9,20,.T.,.T.,5,.T.,5,.T.,.F.)//20
oFont16 := TFont():New("Arial",9,18,.T.,.T.,5,.T.,5,.T.,.F.)//16
oFont16n:= TFont():New("Arial",9,18,.T.,.T.,5,.T.,5,.T.,.F.)//16
oFont24 := TFont():New("Arial",9,26,.T.,.T.,5,.T.,5,.T.,.F.)//24

oBrush := TBrush():New("",4)

oPrint:StartPage()   // Inicia uma nova página
/*
oPrint:FillRect(aCoords1,oBrush)
oPrint:FillRect(aCoords2,oBrush)
oPrint:FillRect(aCoords3,oBrush)
oPrint:FillRect(aCoords4,oBrush)
oPrint:FillRect(aCoords5,oBrush)
oPrint:FillRect(aCoords6,oBrush)
oPrint:FillRect(aCoords7,oBrush)
oPrint:FillRect(aCoords8,oBrush)
*/
// Inicia aqui a alteracao para novo layout - RAI

// Primeiras linhas do comprovante de entrega
oPrint:Line (0125,550,025, 550)
oPrint:Line (0125,800,025, 800)


// LOGOTIPO
If File(aBmp)
	oPrint:SayBitmap( 0040,0100,aBmp,0100,0100 )
	oPrint:Say  (0070,240,"Banco Itaú SA",oFont2n )	// [2]Nome do Banco
Else
	oPrint:Say  (0105,100,aDadosBanco[2],oFont15n )	// [2]Nome do Banco
EndIf


oPrint:Say  (0100,567,cCod_Comp,oFont24 )	// [1]Numero do Banco
oPrint:Say  (0084,1900,"Comprovante de Entrega",oFont10)
oPrint:Line (0125,100,0125,2300)
oPrint:Say  (0150,100 ,"Beneficiário"                                        ,oFont8)
oPrint:Say  (0200,100 ,aDadosEmp[1]                                 	,oFont10) //Nome + CNPJ
oPrint:Say  (0150,1060,"Agência/Código Beneficiário"                         ,oFont8)
oPrint:Say  (0200,1060,Subs(aDadosBanco[3],1,4)+"/"+Subs(aDadosBanco[4],1,5)+"-"+aDadosBanco[5],oFont10)
oPrint:Say  (0150,1510,"Nro.Documento"                                  ,oFont8)
oPrint:Say  (0200,1510,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela
oPrint:Say  (0250,100 ,"Pagador"                                         ,oFont8)
oPrint:Say  (0300,100 ,aDatSacado[1]                                    ,oFont10)	//Nome
oPrint:Say  (0250,1060,"Vencimento"                                     ,oFont8)
//oPrint:Say  (0300,1060,DTOC(aDadosTit[4])                               ,oFont10)
_cStr	:= DtoS(aDadosTit[4])
oPrint:Say  (0300,1060,Subs(_cStr,7,2)+'/'+Subs(_cStr,5,2)+'/'+Subs(_cStr,1,4)	,oFont10)
oPrint:Say  (0250,1510,"Valor do Documento"                          	,oFont8)
oPrint:Say  (0300,1550,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99"))   ,oFont10)
oPrint:Say  (0400,0100,"Recebi(emos) o bloqueto/título"                 ,oFont10)
oPrint:Say  (0450,0100,"com as características acima."             		,oFont10)
oPrint:Say  (0350,1060,"Data"                                           ,oFont8)
oPrint:Say  (0350,1410,"Assinatura"                                 	,oFont8)
oPrint:Say  (0450,1060,"Data"                                           ,oFont8)
oPrint:Say  (0450,1410,"Entregador"                                 	,oFont8)


// linhas do comprovante de entrega
oPrint:Line (0225, 100,0225,1900 )//250
oPrint:Line (0325, 100,0325,1900 )//350
oPrint:Line (0425,1050,0425,1900 )//450
oPrint:Line (0525, 100,0525,2300 )//550

// Colunas do comprovante de entrega
oPrint:Line (0525,1050,0125,1050 )//550
oPrint:Line (0525,1400,0325,1400 )//550
oPrint:Line (0325,1500,0125,1500 )//350
oPrint:Line (0525,1900,0125,1900 )//550

oPrint:Say  (0150,1910,"(  )Mudou-se"                                	,oFont8)
oPrint:Say  (0190,1910,"(  )Ausente"                                    ,oFont8)
oPrint:Say  (0230,1910,"(  )Não existe nº indicado"                  	,oFont8)
oPrint:Say  (0270,1910,"(  )Recusado"                                	,oFont8)
oPrint:Say  (0310,1910,"(  )Não procurado"                              ,oFont8)
oPrint:Say  (0350,1910,"(  )Endereço insuficiente"                  	,oFont8)
oPrint:Say  (0390,1910,"(  )Desconhecido"                            	,oFont8)
oPrint:Say  (0430,1910,"(  )Falecido"                                   ,oFont8)
oPrint:Say  (0470,1910,"(  )Outros(anotar no verso)"                  	,oFont8)

For i := 100 to 2300 step 50
	oPrint:Line( 0615, i, 0615, i+30)//650
Next i

//Recibo do sacado primeiras linhas
oPrint:Line (0720,100,0720,2300)//780
oPrint:Line (0720,550,0620, 550)//780
oPrint:Line (0720,800,0620, 800)//780

// LOGOTIPO
If File(aBmp)
	oPrint:SayBitmap( 0670,0100,aBmp,0100,0100 )
	oPrint:Say  (0700,240,"Banco Itaú SA",oFont2n )	// [2]Nome do Banco
Else
	oPrint:Say  (0705,100,aDadosBanco[2],oFont15n )	// [2]Nome do Banco
EndIf


oPrint:Say  (0695,0567,cCod_Comp			,oFont24 )	// [1]Numero do Banco
oPrint:Say  (0680,1900,"Recibo do Pagador"	,oFont10 )

//linhas do boleto
oPrint:Line (0820,100,0820,2300 )//880
oPrint:Line (0920,100,0920,2300 )//980
oPrint:Line (1020,100,1020,2300 )//1080
oPrint:Line (1090,100,1090,2300 )//1150
oPrint:Line (1160,100,1160,2300 )//1220

//colunas
oPrint:Line (1020,0500,1160,500)//1080
oPrint:Line (1090,0750,1160,750)//1150
oPrint:Line (1020,1000,1160,1000)//1080
oPrint:Line (1020,1350,1090,1350)//1080
oPrint:Line (1020,1550,1090,1550)//1080

oPrint:Say  (0745,0100,"Local de Pagamento"                             ,oFont8)
oPrint:Say  (0765,0400,"ATÉ O VENCIMENTO, PREFERENCIALMENTE NO ITAÚ "   ,oFont9)
oPrint:Say  (0805,0400,"APÓS O VENCIMENTO, SOMENTE NO ITAÚ "        	,oFont9)

oPrint:Say  (0745,1910,"Vencimento"                                     ,oFont8)
//oPrint:Say  (0920,2070,DTOC(aDadosTit[4])                               ,oFont10)
_cStr	:= DtoS(aDadosTit[4])
oPrint:Say  (0785,2037,Subs(_cStr,7,2)+'/'+Subs(_cStr,5,2)+'/'+Subs(_cStr,1,4)	,oFont10)

oPrint:Say  (0845,100 ,"Beneficiário"                                        ,oFont8)
oPrint:Say  (0885,100 ,aDadosEmp[1]+"                  - "+aDadosEmp[6]	,oFont10) //Nome + CNPJ

oPrint:Say  (0945,100 ,"Endereço Beneficiário / Sacador Avalista"         ,oFont8)
oPrint:Say  (0985,100 ,"AV QUEIROZ FILHO ED SKY ALTO PINHEIROS SAO PAULO SP 05319 000"	,oFont10) //Nome + CNPJ

oPrint:Say  (0845,1910,"Agência/Código Beneficiário"                         ,oFont8)
oPrint:Say  (0885,1995,Subs(aDadosBanco[3],1,4)+"/"+Subs(aDadosBanco[4],1,5)+"-"+aDadosBanco[5],oFont10)

oPrint:Say  (1045,100 ,"Data do Documento"                              ,oFont8)
oPrint:Say  (1075,100 ,DTOC(aDadosTit[2])                               ,oFont10) // Emissao do Titulo (E1_EMISSAO)

oPrint:Say  (1045,505 ,"Nro.Documento"                                  ,oFont8)
oPrint:Say  (1075,605 ,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela

oPrint:Say  (1045,1005,"Espécie Doc."                                   ,oFont8)
oPrint:Say  (1075,1050,aDadosTit[8]										,oFont10) //Tipo do Titulo

oPrint:Say  (1045,1355,"Aceite"                                         ,oFont8)
oPrint:Say  (1075,1455,"N"                                             ,oFont10)

oPrint:Say  (1045,1555,"Data do Processamento"                          ,oFont8)
oPrint:Say  (1075,1655,DTOC(aDadosTit[3])                               ,oFont10) // Data impressao

oPrint:Say  (1045,1910,"Nosso Número"                                   ,oFont8)
oPrint:Say  (1075,1958,Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4,10),oFont10)

oPrint:Say  (1115,100 ,"Uso do Banco"                                   ,oFont8)

oPrint:Say  (1115,505 ,"Carteira"                                       ,oFont8)
oPrint:Say  (1145,555 ,aDadosBanco[6]                                  	,oFont10)

oPrint:Say  (1115,755 ,"Espécie"                                        ,oFont8)
oPrint:Say  (1145,805 ,"R$"                                             ,oFont10)

oPrint:Say  (1115,1005,"Quantidade"                                     ,oFont8)
oPrint:Say  (1145,1555,"Valor"                                          ,oFont8)

oPrint:Say  (1115,1910,"Valor do Documento"                          	,oFont8)
oPrint:Say  (1145,2075,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)

//dados das instrucoes
oPrint:Say  (1185,100 ,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do Beneficiário)",oFont8)
_cStr	:= AllTrim(Transform((aDadosTit[5]*(_nTxper/100)),"@E 99,999.99"))
oPrint:Say  (1225,100 ,aBolText[2]+_cStr								,oFont10)
oPrint:Say  (1265,100 ,aBolText[3]                                        ,oFont10)
//oPrint:Say  (1320,100 ,aBolText[1]									       ,oFont10)
oPrint:Say  (1315,100 ,aBolText[4]                                        ,oFont10)
oPrint:Say  (1365,100 ,aBolText[5]                                        ,oFont10)
oPrint:Say  (1415,100 ,aBolText[6]                                        ,oFont10)

oPrint:Say  (1185,1910,"(-)Desconto/Abatimento"                         ,oFont8)
oPrint:Say  (1255,1910,"(-)Outras Deduções"                             ,oFont8)
oPrint:Say  (1325,1910,"(+)Mora/Multa"                                  ,oFont8)
oPrint:Say  (1395,1910,"(+)Outros Acréscimos"                           ,oFont8)
oPrint:Say  (1465,1910,"(=)Valor Cobrado"                               ,oFont8)

oPrint:Say  (1545,100 ,"Pagador"                                         ,oFont8)
oPrint:Say  (1550,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)
oPrint:Say  (1590,400 ,aDatSacado[3]                                    ,oFont10)
oPrint:Say  (1630,400 ,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
oPrint:Say  (1670,400 ,"CGC: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99"),oFont10) // CGC
oPrint:Say  (1670,1850,Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4,10)  ,oFont10)

oPrint:Say  (1685,100 ,"Sacador/Avalista"                               ,oFont8)
oPrint:Say  (1725,1500,"Autenticação Mecânica -"                        ,oFont8)


// linha da coluna dos valores
oPrint:Line (0820,1900,1510,1900 )//880
// outras deducoes
oPrint:Line (1230,1900,1230,2300 )//1290
//mora multa
oPrint:Line (1300,1900,1300,2300 )//1360
//outros acrescimos
oPrint:Line (1370,1900,1370,2300 )//1430

// valor cobrado
oPrint:Line (1440,1900,1440,2300 )//1500
// penultima linha(Linha do Sacado)
oPrint:Line (1520,100 ,1520,2300 )//1580
// ultima linha (Sacador avalista)
oPrint:Line (1690,100 ,1690,2300 )//1950

//Pontilhado de inicio para o ultimo conjunto
For i := 100 to 2300 step 50
	oPrint:Line( 1800, i, 1800, i+30)                 // 2195 - 12
Next i

oPrint:Line (2085,100,2085,2300)                                                       //   2280
oPrint:Line (1800,550,1900,550)                                                       //   2280
oPrint:Line (1800,810,1900,810)                                                       //    2280

// LOGOTIPO
If File(aBmp)
	oPrint:SayBitmap( 2170,0100,aBmp,0100,0100 )
	oPrint:Say  (2200,240,"Banco Itaú SA",oFont2n )	// [2]Nome do Banco
Else
	oPrint:Say  (1880,100,aDadosBanco[2],oFont15n )	// [2]Nome do Banco                     1934
EndIf


oPrint:Say  (1875,567,cCod_Comp,oFont24 )	// [1]Numero do Banco                       1912
//oPrint:Say  (2214,820,CB_RN_NN[2],oFont14n)		//Linha Digitavel do Codigo de Barras   1934
oPrint:Say  (1875,820,CB_RN_NN[2],oFont15n)

oPrint:Line (1900,100,1900,2300 )    //   2380
oPrint:Line (2000,100,2000,2300 )    //   2480
oPrint:Line (2165,100,2165,2300 )    //   2550
oPrint:Line (2235,100,2235,2300 )    //   2620

oPrint:Line (2090, 500,2235,500)      //   2480 - 2340
oPrint:Line (2165, 750,2235,750)      //   2550 - 2340
oPrint:Line (2090,1000,2235,1000)    //   2480 - 2340
oPrint:Line (2090,1350,2165,1350)    //   2480 - 2270
oPrint:Line (2090,1550,2235,1550)    //   2480 - 2340

oPrint:Say  (1920,100 ,"Local de Pagamento"                             	,oFont8)                  //    2000
oPrint:Say  (1940,400 ,"ATÉ O VENCIMENTO, PREFERENCIALMENTE NO ITAÚ "       ,oFont9)  //  2020
oPrint:Say  (1980,400 ,"APÓS O VENCIMENTO,SOMENTE NO ITAÚ "        			,oFont9)       //      2060

oPrint:Say  (1920,1910,"Vencimento"                                     	,oFont8)                  // 2000
//oPrint:Say  (2320,2070,DTOC(aDadosTit[4])                               ,oFont10)                // 2040
_cStr	:= DtoS(aDadosTit[4])
oPrint:Say  (1960,2037,Subs(_cStr,7,2)+'/'+Subs(_cStr,5,2)+'/'+Subs(_cStr,1,4)	,oFont10)

oPrint:Say  (2020,100 ,"Beneficiário"                                        ,oFont8)                      // 2100
oPrint:Say  (2060,100 ,aDadosEmp[1]+"                  - "+aDadosEmp[6]		,oFont10) //Nome + CNPJ      2140

oPrint:Say  (2020,1910,"Agência/Código Beneficiário"                         ,oFont8)                        // 2100
oPrint:Say  (2060,1995,Subs(aDadosBanco[3],1,4)+"/"+Subs(aDadosBanco[4],1,5)+"-"+aDadosBanco[5],oFont10)                  // 2140

oPrint:Say  (2120,100 ,"Data do Documento"                              	,oFont8)                                   // 2200
oPrint:Say  (2150,100 ,DTOC(aDadosTit[2])                               	,oFont10) // Emissao do Titulo (E1_EMISSAO)    2230

oPrint:Say  (2120,505 ,"Nro.Documento"                                  	,oFont8)                           // 2200
oPrint:Say  (2150,605 ,aDadosTit[7]+aDadosTit[1]							,oFont10) //Prefixo +Numero+Parcela  2230

oPrint:Say  (2120,1005,"Espécie Doc."                                   ,oFont8)                 // 2200
oPrint:Say  (2150,1050,aDadosTit[8]										,oFont10) //Tipo do Titulo  2230

oPrint:Say  (2120,1355,"Aceite"                                         ,oFont8)  // 2200
oPrint:Say  (2150,1455,"N"                                             ,oFont10)  // 2230

oPrint:Say  (2120,1555,"Data do Processamento"                          ,oFont8)       // 2200
oPrint:Say  (2150,1655,DTOC(aDadosTit[3])                               ,oFont10) // Data impressao  2230

oPrint:Say  (2120,1910,"Nosso Número"                                   ,oFont8)       // 2200
oPrint:Say  (2150,1958,Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4,10),oFont10)  // 2230

oPrint:Say  (2190,100 ,"Uso do Banco"                                   ,oFont8)       // 2270

oPrint:Say  (2190,505 ,"Carteira"                                       ,oFont8)       // 2270
oPrint:Say  (2220,555 ,aDadosBanco[6]                                  	,oFont10)      //  2300

oPrint:Say  (2190,755 ,"Espécie"                                        ,oFont8)       //  2270
oPrint:Say  (2220,805 ,"R$"                                             ,oFont10)      //  2300

oPrint:Say  (2190,1005,"Quantidade"                                     ,oFont8)       //  2270
oPrint:Say  (2190,1555,"Valor"                                          ,oFont8)       //  2270

oPrint:Say  (2190,1910,"Valor do Documento"                          	,oFont8)        //  2270
oPrint:Say  (2220,2075,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)  //   2300


oPrint:Say  (2260,100 ,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do Beneficiário)",oFont8) // 2340
//oPrint:Say  (2720,100 ,aBolText[1]										 ,oFont10)    // 2440
_cStr	:= AllTrim(Transform((aDadosTit[5]*(_nTxper/100)),"@E 99,999.99"))
oPrint:Say  (2310,100 ,aBolText[2]+_cStr								,oFont10)  // 2490  // *0.05)/30)
oPrint:Say  (2360,100 ,aBolText[3]                                        ,oFont10)    //2540
oPrint:Say  (2410,100 ,aBolText[4]                                        ,oFont10)
oPrint:Say  (2460,100 ,aBolText[5]                                        ,oFont10)
oPrint:Say  (2510,100 ,aBolText[6]                                        ,oFont10)

oPrint:Say  (2260,1910,"(-)Desconto/Abatimento"                         ,oFont8)      //  2340
oPrint:Say  (2330,1910,"(-)Outras Deduções"                             ,oFont8)      //  3410
oPrint:Say  (2400,1910,"(+)Mora/Multa"                                  ,oFont8)      //  2480
oPrint:Say  (2470,1910,"(+)Outros Acréscimos"                           ,oFont8)      //  2550
oPrint:Say  (2540,1910,"(=)Valor Cobrado"                               ,oFont8)      //  2620

oPrint:Say  (2610,100 ,"Pagador"                                         ,oFont8)
oPrint:Say  (2630,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)
oPrint:Say  (2673,400 ,aDatSacado[3]                                    ,oFont10)       // 2773
oPrint:Say  (2716,400 ,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado  2826
oPrint:Say  (2760,400 ,"CGC: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99"),oFont10) // CGC        2879
oPrint:Say  (2760,1850,Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4,10)  ,oFont10)         //  2879

oPrint:Say  (2760,100 ,"Sacador/Avalista"                               ,oFont8)       //2895
oPrint:Say  (2810,1500,"Autenticação Mecânica - FICHA DE COMPENSAÇÃO"                        ,oFont8)
//oPrint:Say  (3215,1850,"Ficha de Compensação"                           ,oFont10)      // 2935 + 280      = 3215

oPrint:Line (1900,1900,2585,1900 )         // 2280 - 2690       -
oPrint:Line (2305,1900,2305,2300 )         // 2690        -
oPrint:Line (2375,1900,2375,2300 )         // 2760        -
oPrint:Line (2445,1900,2445,2300 )         // 2830        -
oPrint:Line (2505,1900,2505,2300 )         // 2900        -
oPrint:Line (2585,100 ,2585,2300 )         // 2970        -

oPrint:Line (2780,100 ,2780,2300 )         // 3210
//MSBAR("INT25"  ,26,1.5,CB_RN_NN[1],oPrint,.F.,,,,1.2,,,,.F.)        // ANTERIORGERE
// _Tst := ReturnPrtObj()    TESTE

//  MSBAR("INT25",69.42,3.6,CB_RN_NN[1]   ,oPrint,.F.,,,0.064,3.31, NIL,NIL,NIL,.F.)
//	MSBAR("INT25",27.8 ,1.3,CB_RN_NN[1]   ,oPrint,.F.,,,,1.2, NIL,NIL,NIL,.F.) - 13/09
//	MSBAR("INT25",28.8 ,1.3,CB_RN_NN[1]   ,oPrint,.F.,,,10.3,1.3, NIL,NIL,NIL,.F.)
//MSBAR("INT25",14.1,0.9,CB_RN_NN[1]  ,oPrint,.F.,,.T.,0.013,0.64, NIL,NIL,NIL,.F.)
oPrint:FwMsBar("INT25",66,3,CB_RN_NN[1]  ,oPrint,.F.,,.T.,0.023,1, NIL,NIL,NIL,.F.)
	//(cTypeBar,nRow,nCol,cCode,oPrint,lCheck,Color,lHorz, nWidth,nHeigth,lBanner,cFont,cMode,lPrint,nPFWidth,nPFHeigth,lCmtr2Pix)

/*
DbSelectArea("SE1")
RecLock("SE1",.f.)
SE1->E1_DVCNAB :=	Subs(CB_RN_NN[3],13,1)   // Nosso número (Ver fórmula para calculo)
MsUnlock()
*/

oPrint:EndPage() // Finaliza a página
//U_F4001102(oPrint)
//oPrint:Preview()     // Visualiza antes de imprimir

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Modulo10 ³ Autor ³                       ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Modulo10(cData)
/*
LOCAL L,D,P := 0
LOCAL B     := .F.
L := Len(cData)
B := .T.
D := 0
While L > 0
P := Val(SubStr(cData, L, 1))
If (B)
P := P * 2
If P > 9
P := P - 9
End
End
D := D + P
L := L - 1
B := !B
End
D := 10 - (Mod(D,10))
If D = 10
D := 0
End
*/
LOCAL nTam	:= 0
Local nVez	:= 0
Local nRes	:= 0
Local nPeso	:= 0
Local nParc := 0
Local nTot	:= 0
Local nVez2	:= 0
Local cStr	:= ''
cData	:= Alltrim(cData)
//MSGALERT('|'+CDATA+'|')
nTam	:= Len(cData)
//MSGALERT(STR(NTAM))
nPeso	:= 2
For nVez:= nTam to 1 Step -1
	//	MSGALERT('VEZ:'+STR(NVEZ))
	nParc	:= Val(SubStr(cData, nVez, 1))
	//    MSGALERT('NPARC:'+STR(NPARC))
	nRes	:= (nParc * nPeso)
	//	MSGALERT('NRES:'+STR(NRES))
	If nRes > 9
		cStr	:= AllTrim(Str(nRes,0))
		//		MSGALERT(CSTR)
		nParc	:= Len(cStr)
		nRes	:= 0
		For nVez2 := 1 To nParc
			nRes	+= Val(Subs(cStr,nVez2,1))
		Next
	EndIf
	nTot	+= nRes
	If nPeso == 2
		nPeso	:= 1
	Else
		nPeso	:= 2
	EndIf
Next
nRes := 10 - (Mod(nTot,10))
If nRes = 10
	nRes := 0
End

Return(nRes)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Modulo10 ³ Autor ³                       ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Modulo11(cData)
LOCAL L, D, P := 0
L := Len(cdata)
D := 0
P := 1
While L > 0
	P := P + 1
	D := D + (Val(SubStr(cData, L, 1)) * P)
	If P = 9
		P := 1
	End
	L := L - 1
End
D := 11 - (mod(D,11))
If (D <= 1 .Or. D > 9 )
	D := 1
End
Return(D)


//Retorna os strings para inpressão do Boleto
//CB = String para o cód.barras, RN = String com o número digitável
//Cobrança não identificada, número do boleto = Título + Parcela

//mj Static Function Ret_cBarra(cBanco,cAgencia,cConta,cDacCC,cCarteira,cNroDoc,nValor)

//					    		   Codigo Banco            Agencia		  C.Corrente     Digito C/C
//					               1-cBancoc               2-Agencia      3-cConta       4-cDacCC       5-cNroDoc              6-nValor
//	CB_RN_NN    := Ret_cBarra(Subs(aDadosBanco[1],1,3)+"9",aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],"175"+AllTrim(E1_NUM),(E1_VALOR-_nVlrAbat) )

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Ret_cBarra³ Autor ³                       ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Ret_cBarra(cBanco1,cAgencia1,cConta1,cDacCC,cNroDoc,nValor,dVencto)

LOCAL bldocnufinal := strzero(val(cNroDoc),8)
LOCAL blvalorfinal := strzero(nValor*100,10)
LOCAL dvnn         := 0
LOCAL dvcn         := 0
LOCAL dvcb         := 0
LOCAL dv           := 0
LOCAL NN           := ''
LOCAL RN           := ''
LOCAL CB           := ''
LOCAL s            := ''
LOCAL _cfator      := ''
LOCAL _cCart	   := ''


// Ajuste dos campos
cBanco	:= Subs(cBanco1,1,3)
cAgencia:= Subs(cAgencia1,1,4)
cConta	:= Subs(cConta1,1,5)

_cfator      := strzero(dVencto - ctod("07/10/97"),4)
_cCart		:= Posicione("SEE",1,xFilial('SEE')+cBanco+cAgencia1+cConta1,"EE_CODCART")    //"109"     // DANIEL ----  CODIGO DA CARTEIRA DE COBRANCA DA ETILUX (INFORMADA PELO BANCO)

//-------- Definicao do NOSSO NUMERO
s    :=  cAgencia + cConta + _cCart + bldocnufinal
//MSGALERT('|'+CAGENCIA+'|'+CCONTA+'|'+_CCART+'|'+BLDOCNUFINAL+'|')
//MSGALERT(STR(LEN(S)))
dvnn := modulo10(s) // digito verifacador Agencia + Conta + Carteira + Nosso Num
NN   := _cCart + bldocnufinal + '-' + AllTrim(Str(dvnn))
//MSGALERT('|'+NN+'|')

// DAC de agencia e conta corrente
s	:= cAgencia + cConta
dvcn:= Modulo10(s)
//msgalert('|'+Str(dvcn)+'|')
//	-------- Definicao do CODIGO DE BARRAS
s    := cBanco + "9" + _cfator + blvalorfinal + _cCart + bldocnufinal + AllTrim(Str(dvnn)) + AllTrim(cAgencia) + AllTrim(cConta) + AllTrim(Str(dvcn)) + '000'
//MSGALERT('|'+S+'|')
dvcb := modulo11(s)
CB   := SubStr(s, 1, 4) + AllTrim(Str(dvcb)) + SubStr(s,5)

//-------- Definicao da LINHA DIGITAVEL (Representacao Numerica)
//	Campo 1			Campo 2			Campo 3			Campo 4		Campo 5
//	AAABC.CCDDX		DDDDD.DDFFFY	FGGGG.GGHHHZ	K			UUUUVVVVVVVVVV

// 	CAMPO 1:
//	AAA	= Codigo do banco na Camara de Compensacao
//	  B = Codigo da moeda, sempre 9
//	CCC = Codigo da Carteira de Cobranca
//	 DD = Dois primeiros digitos no nosso numero
//	  X = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo

s    := cBanco + "9" + _cCart + SubStr(bldocnufinal,1,2)
dv   := modulo10(s)
RN   := SubStr(s, 1, 5) + '.' + SubStr(s, 6, 4) + AllTrim(Str(dv)) + ' '

// 	CAMPO 2:
//	DDDDDD = Restante do Nosso Numero
//	     E = DAC do campo Agencia/Conta/Carteira/Nosso Numero
//	   FFF = Tres primeiros numeros que identificam a agencia
//	     Y = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo

s    := AllTrim(SubStr(bldocnufinal, 3, 6)) + AllTrim(Str(dvnn)) + AllTrim(SubStr(cAgencia, 1, 3))
dv   := modulo10(s)
RN   := RN + SubStr(s, 1, 5) + '.' + SubStr(s, 6, 5) + AllTrim(Str(dv)) + ' '

// 	CAMPO 3:
//	     F = Restante do numero que identifica a agencia
//	GGGGGG = Numero da Conta + DAC da mesma
//	   HHH = Zeros (Nao utilizado)
//	     Z = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
s    := AllTrim(SubStr(cAgencia, 4, 1)) + AllTrim(cConta) + AllTrim(cDacCC) + '000'
dv   := modulo10(s)
RN   := RN + AllTrim(SubStr(s, 1, 5)) + '.' + AllTrim(SubStr(s, 6, 5)) + AllTrim(Str(dv)) + ' '

// 	CAMPO 4:
//	     K = DAC do Codigo de Barras
RN   := RN + AllTrim(Str(dvcb)) + ' '

// 	CAMPO 5:
//	      UUUU = Fator de Vencimento
//	VVVVVVVVVV = Valor do Titulo
RN   := RN + _cfator + StrZero(nValor * 100,10)

Return({CB,RN,NN})

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³VALIDPERG ³ Autor ³                       ³ Data ³ 01/08/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ³±±
±±³          ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg()

	PutSx1(cPerg,"01","Do Prefixo           ?","","","mv_ch1","C",03,0,0,"G","","","","","mv_par01"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"02","Ate o Prefixo        ?","","","mv_ch2","C",03,0,0,"G","","","","","mv_par02"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"03","Do Numero            ?","","","mv_ch3","C",06,0,0,"G","","","","","mv_par03"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"04","Ate o Numero         ?","","","mv_ch4","C",06,0,0,"G","","","","","mv_par04"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"05","Da Parcela           ?","","","mv_ch5","C",01,0,0,"G","","","","","mv_par05"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"06","Ate a Parcela        ?","","","mv_ch6","C",01,0,0,"G","","","","","mv_par06"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"07","Banco                ?","","","mv_ch7","C",03,0,0,"G","","SA6","","","mv_par07"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"08","Agencia              ?","","","mv_ch8","C",05,0,0,"G","","","","","mv_par08"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"09","Conta                ?","","","mv_ch9","C",10,0,0,"G","","","","","mv_par09"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"10","De Cliente           ?","","","mv_cha","C",06,0,0,"G","","SA1","","","mv_par10"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"11","Ate Cliente          ?","","","mv_chb","C",06,0,0,"G","","SA1","","","mv_par11"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"12","De Loja              ?","","","mv_chc","C",02,0,0,"G","","","","","mv_par12"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"13","Ate Loja             ?","","","mv_chd","C",02,0,0,"G","","","","","mv_par13"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"14","Do Bordero           ?","","","mv_che","C",06,0,0,"G","","","","","mv_par14"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")
	PutSx1(cPerg,"15","Ate Bordero          ?","","","mv_chf","C",06,0,0,"G","","","","","mv_par15"," "," "," ",""," "," "," "," "," "," ","","","","","","","","","","")

/*
Local i,j

Local _aEstu := SX1->(dbStruct())
Local _nTam  := _aEstu[Ascan(_aEstu,{|x| x[1] == "X1_GRUPO"}),3]

cPerg := cPerg+Space(_nTam-Len(cPerg))

_sAlias := Alias()
DBSelectArea("SX1")
DBSetOrder(1)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

AADD(aRegs,{cPerg,"01","Do Prefixo           ?","","","mv_ch1","C", 3,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Ate o Prefixo        ?","","","mv_ch2","C", 3,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Do Numero            ?","","","mv_ch3","C", 6,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Ate o Numero         ?","","","mv_ch4","C", 6,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Da Parcela           ?","","","mv_ch5","C", 1,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","Ate a Parcela        ?","","","mv_ch6","C", 1,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Banco                ?","","","mv_ch7","C", 3,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","SA6","","","",""})
AADD(aRegs,{cPerg,"08","Agencia              ?","","","mv_ch8","C", 5,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Conta                ?","","","mv_ch9","C",10,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"10","De Cliente           ?","","","mv_cha","C",6,0,0,"G","","MV_PAR10","","","","","","","","","","","","","","","","","","","","","","","","","SA1","","","",""})
Aadd(aRegs,{cPerg,"11","Ate Cliente          ?","","","mv_chb","C",6,0,0,"G","","MV_PAR11","","","","ZZZZZZ","","","","","","","","","","","","","","","","","","","","","SA1","","","",""})
Aadd(aRegs,{cPerg,"12","De Loja              ?","","","mv_chc","C",2,0,0,"G","","MV_PAR12","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"13","Ate Loja             ?","","","mv_chd","C",2,0,0,"G","","MV_PAR13","","","","ZZ","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"14","Do Bordero           ?","","","mv_che","C",6,0,0,"G","","MV_PAR14","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"15","Ate Bordero          ?","","","mv_chf","C",6,0,0,"G","","MV_PAR15","","","","ZZZZZZ","","","","","","","","","","","","","","","","","","","","","","","","",""})


For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to fCount()
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

DBSelectArea(_sAlias)
 */
Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MSBAR       ³ Autor ³ ALEX SANDRO VALARIO ³ Data ³  06/99   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime codigo de barras                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 01 cTypeBar String com o tipo do codigo de barras          ³±±
±±³          ³             "EAN13","EAN8","UPCA" ,"SUP5"   ,"CODE128"     ³±±
±±³          ³             "INT25","MAT25,"IND25","CODABAR" ,"CODE3_9"    ³±±
±±³          ³ 02 nRow     Numero da Linha em centimentros                ³±±
±±³          ³ 03 nCol     Numero da coluna em centimentros               ³±±
±±³          ³ 04 cCode    String com o conteudo do codigo                ³±±
±±³          ³ 05 oPr      Objeto Printer                                 ³±±
±±³          ³ 06 lcheck   Se calcula o digito de controle                ³±±
±±³          ³ 07 Cor      Numero  da Cor, utilize a "common.ch"          ³±±
±±³          ³ 08 lHort    Se imprime na Horizontal                       ³±±
±±³          ³ 09 nWidth   Numero do Tamanho da barra em centimetros      ³±±
±±³          ³ 10 nHeigth  Numero da Altura da barra em milimetros        ³±±
±±³          ³ 11 lBanner  Se imprime o linha em baixo do codigo          ³±±
±±³          ³ 12 cFont    String com o tipo de fonte                     ³±±
±±³          ³ 13 cMode    String com o modo do codigo de barras CODE128  ³±±
±±³          ³ 14 lprint   logico para que a impressao seja na chamada da ³±±
±±³          ³             funcao - Default .T.                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ImpressÆo de etiquetas c¢digo de Barras para HP e Laser    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

