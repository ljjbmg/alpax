#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "topconn.ch"
#INCLUDE "RPTDEF.CH"  
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "RESTFUL.ch"
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
User Function BOLSANT()

LOCAL   aMarked 	:= {}
LOCAL   cFilePDF	:= ""
PRIVATE CB_RN_NN    := {}
PRIVATE aDadosBanco
PRIVATE cCod_Comp
PRIVATE Exec    	:= .F.
PRIVATE cIndexName 	:= ''
PRIVATE cIndexKey  	:= ''
PRIVATE cFilter    	:= ''
DEFAULT _lEmail 	:= .F.
Default lGetPDF		:= .F.

dbSelectArea("SE1")

cPerg     :="FINR003"

If( !lGetPDF )
	ValidPerg()

	If !Pergunte(cPerg,.T.)
		Return()
	EndIf
EndIf

If MV_PAR16 == 1
	
	// Verifica se existe o SMTP Server 
	If 	Empty(GETMV("MV_RELSERV"))
		Help(" ",1,"SEMSMTP")//"O Servidor de SMTP nao foi configurado !!!" ,"Atencao"
		Return()
	EndIf
	
	// Verifica se existe a CONTA    
	If 	Empty(GETMV("MV_EMCONTA"))
		Help(" ",1,"SEMCONTA")//"A Conta do email nao foi configurado !!!" ,"Atencao"
		Return()
	EndIf
	
	// Verifica se existe a Senha  
	If 	Empty(GETMV("MV_EMSENHA"))
		Help(" ",1,"SEMSENHA")	//"A Senha do email nao foi configurado !!!" ,"Atencao"
		Return()
	EndIf

	_lEmail := .T.

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
"E1_FILIAL = '"+xFilial("SE1")+"' "

IndRegua("SE1", cIndexName, cIndexKey,, cFilter, "Aguarde selecionando registros....")

#IFNDEF TOP
	DbSetIndex(cIndexName + OrdBagExt())
#ENDIF

dbGoTop()

If( !lGetPDF )
	@ 001,001 TO 400,1000 DIALOG oDlg TITLE "Selecao de Titulos"
	@ 001,001 TO 170,500 BROWSE "SE1" MARK "E1_OK"
	@ 180,310 BMPBUTTON TYPE 01 ACTION (Exec:=.T.,Close(oDlg))
	@ 180,280 BMPBUTTON TYPE 02 ACTION (Exec:=.F.,Close(oDlg))
	
	ACTIVATE DIALOG oDlg CENTERED

	If !Exec
		Return Nil
	EndIf

	SE1->(dbGoTop())
	Do While !Eof()

		If Marked("E1_OK")
			AADD(aMarked,.T.)
		Else
			AADD(aMarked,.F.)
		EndIf
		SE1->(dbSkip())
	EndDo

	SE1->(dbGoTop())
EndIf


If !Exec 
	Return
EndIf

If MV_PAR16 = 2
	lGetPDF:=.T.
	IF Exec
		Processa({|lEnd|MontaRel(aMarked,_lEmail,lGetPDF)})
	EndIF
else
	lGetPDF:=.T.
	cFilePDF := MontaRel( aMarked, _lEmail, lGetPDF )
EndIf

RetIndex("SE1")
fErase(cIndexName+OrdBagExt())
//u_limpArqPdf()
dbSelectArea('SE1')
RetIndex('SE1')

Return
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
LOCAL aBitmap := " " //"M:\Boletos\Itau\Valido\ITAU.BMP"
// colocar o caminho q o bitmap vai estar , nao sabe se vai ser com 4 ou 2 barras.. logo grande q vem do banco salvar no system
// salva numa pasta na maq local com nome do maq e compartilhamento //nomemaq/nome compartilhamento    linha 259tbm ..
Local cFilePDF := ""
LOCAL aDadosEmp    := {	SM0->M0_NOMECOM                                   ,; //[1]Nome da Empresa
SM0->M0_ENDCOB                                                            ,; //[2]Endereço
AllTrim(SM0->M0_BAIRCOB)+", "+AllTrim(SM0->M0_CIDCOB)+", "+SM0->M0_ESTCOB ,; //[3]Complemento
"CEP: "+Subs(SM0->M0_CEPCOB,1,5)+"-"+Subs(SM0->M0_CEPCOB,6,3)             ,; //[4]CEP
"PABX/FAX: "+SM0->M0_TEL                                                  ,; //[5]Telefones
"C.N.P.J.: "+Subs(SM0->M0_CGC,1,2)+"."+Subs(SM0->M0_CGC,3,3)+"."+          ; //[6]
Subs(SM0->M0_CGC,6,3)+"/"+Subs(SM0->M0_CGC,9,4)+"-"+                       ; //[6]
Subs(SM0->M0_CGC,13,2)                                                     ,; //[6]CGC
"I.E.: "+Subs(SM0->M0_INSC,1,3)+"."+Subs(SM0->M0_INSC,4,3)+"."+            ; //[7]
Subs(SM0->M0_INSC,7,3)+"."+Subs(SM0->M0_INSC,10,3)                         }  //[7]I.E

LOCAL aDadosTit
LOCAL aDatSacado
LOCAL aBolText     := {""                ,;
"APOS O VENCIMENTO COBRAR MORA DE R$ "                  	    ,;
"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO"      	        ,;
"COBRANCA ESCRITURAL." 								            ,;
""						                                        ,;
""}

// "Após o vencimento cobrar multa de R$ "

LOCAL i            	:= 1
LOCAL nRec         	:= 0
LOCAL _nVlrAbat    	:= 0
Local aInfos		:= {}
Local clocal		:= ""
Local cVLDIR		:= .F.
Local aVetor		:= {}
Default lGetPDF		:= .T.

CB_RN_NN     := {}

IF lGetPDF
	cLocal:= "c:\boletos\"
	cServer := GetSrvProfString("ROOTPATH","") + "\spool\boleto\" 
Else 
	cLocal:= "c:\temp\"
Endif

cVLDIR :=  LJDIRECT(cLocal,.T.)
IF !cVLDIR
	MSGALERT("Nao foi possivel localizar/criar o diretorio ("+cLocal+"), verifique a permissao do usuario. ","Erro BOLDAY")
	return
Endif

SE1->(dbGoTop())
While SE1->(!EOF()) 
	nRec := nRec + 1

   If  Marked("E1_OK")
	AADD(aVetor, {SE1->E1_PREFIXO	,; 
				  SE1->E1_NUM       ,; 
 				  SE1->E1_PARCELA	,; 
				  SE1->E1_TIPO 		,; 
				  SE1->E1_CLIENTE	,; 
				  SE1->E1_LOJA}) 	
	EndIf
	SE1->(dbSkip())
	
Enddo

If Len(aVetor) <= 0
   Alert("Nenhum registro selecionado")
   Return
End

SE1->(dbGoTop())

cCod_Comp	:= '033-7'

DBSelectArea("SE1")

//Do While !EOF() //.Or. Len(aMarked) <= i
For i:= 1 to Len(aVetor)	
	DBSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1")+aVetor[i][1]+aVetor[i][2]+aVetor[i][3]+aVetor[i][4],.T.)


	DbSelectArea("SA6")
	DbSetOrder(1)
	DbSeek(xFilial("SA6")+SE1->(E1_PORTADO+E1_AGEDEP+E1_CONTA),.T.)
	
	DbSelectArea("SEE")
	DbSetOrder(1)
	DbSeek(xFilial("SEE")+SE1->(E1_PORTADO+E1_AGEDEP+E1_CONTA),.T.)

	//IncProc("Analisando registro "  + "...")

	If at("-",AllTrim(SEE->EE_CONTA)) > 0
		cCC   := Substr(SEE->EE_CONTA, 1,at("-",AllTrim(SEE->EE_CONTA))-1) 
		cDgCto:= Substr(SEE->EE_CONTA, at("-",AllTrim(SEE->EE_CONTA))+1,1) 
	Else
		cDgCto:= AllTrim(SEE->EE_DVCTA) 
		cCC   := AllTrim(SEE->EE_CONTA)
	End

    //Retorna Array com o nome do Logo.bmp e o nome do Banco
	Log_Nom := LogBanc((cAliasSE1)->A6_COD)

	aDadosBanco  := {"033",; 				// [1]Numero do Banco + Digito Moeda
	Log_Nom[2],; 							// [2]Nome do Banco
	SUBSTR(AllTrim(SEE->EE_AGENCIA),1,4),; 	// [3]Agência
	Alltrim(cCC),; 							// [4]Conta Corrente
	Alltrim(cDgCto),; 						// [5]Dígito da conta corrente
	Alltrim(SEE->EE_CODCART ),;
    Log_Nom[2]} 				            // [6]Logo

	If lGetPDF 
		If Empty(SE1->E1_NUMBCO)
			RecLock('SE1',.F.)
			SE1->E1_NUMBCO  := Alltrim(SEE->EE_FAXATU)
			msUnlock()
			
			RecLock("SEE",.f.)
			SEE->EE_FAXATU := StrZero((Val(Alltrim(SEE->EE_FAXATU))+1),8)
			MsUnlock()
		Endif
		_cNossoNum := AllTrim(SE1->E1_NUMBCO) 
	Endif
	
	cFile  := Lower("bol" + AllTrim(SE1->E1_NUM) + dToS(dDatabase) + Replace(Time(),":", "-"))
		
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA,.T.)
	
	//DbSelectArea("SE1")
	
	If Empty(SA1->A1_ENDCOB)
		aDatSacado   := {AllTrim(SA1->A1_NOME)                            ,;     // [1]Razão Social
		AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA           ,;     // [2]Código
		AllTrim(SA1->A1_END )+"-"+AllTrim(SA1->A1_BAIRRO),;     // [3]Endereço
		AllTrim(SA1->A1_MUN )                             ,;     // [4]Cidade
		SA1->A1_EST                                       ,;     // [5]Estado
		SA1->A1_CEP                                       ,;     // [6]CEP
		SA1->A1_CGC									  }       // [7]CGC
	Else
		aDatSacado   := {AllTrim(SA1->A1_NOME)                  ,;   // [1]Razão Social
		AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA              	,;   // [2]Código
		AllTrim(SA1->A1_ENDCOB)+"-"+AllTrim(SA1->A1_BAIRROC)	,;   // [3]Endereço
		AllTrim(SA1->A1_MUNC)	                              	,;   // [4]Cidade
		SA1->A1_ESTC	                                      	,;   // [5]Estado
		SA1->A1_CEPC                                         	,;   // [6]CEP
		SA1->A1_CGC										 		,;   // [7]CGC
		SA1->A1_AXMAILC  }    										 
	Endif
	
	If lGetPDF 
		_nVlrAbat   :=  SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
		
		//							BANCO		  AGENCIA			CONTA		DIGITO                NUMBCO             VALOR                VENCTO         CARTEIRA			
		CB_RN_NN    := Ret_cBarra(aDadosBanco[1],aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],AllTrim(_cNossoNum),(SE1->E1_SALDO-_nVlrAbat),SE1->E1_VENCTO,aDadosBanco[6])


		aDadosTit    := {AllTrim(SE1->E1_NUM)+"-"+AllTrim(SE1->E1_PARCELA)	,;  // [1] Número do título
		SE1->E1_EMISSAO                              					,;  // [2] Data da emissão do título
		Date()                                  					,;  // [3] Data da emissão do boleto
		SE1->E1_VENCTO                  									,;  // [4] Data do vencimento
		(SE1->E1_SALDO - _nVlrAbat)                  					,;  // [5] Valor do título
		CB_RN_NN[3]                             					,;  // [6] Nosso número (Ver fórmula para calculo)
		SE1->E1_PREFIXO                               					,;  // [7] Prefixo da NF
		SE1->E1_TIPO	                               						}  // [8] Tipo do Titulo
		
		oPrint:= Nil
		If _lEmail
			oPrint:= FWMSPrinter():New(cFile, IMP_PDF, .T.,cLocal, .T.,,,,,,,.F.)
		Else
			oPrint:= FWMSPrinter():New(cFile, IMP_PDF, .T.,cLocal, .T.,,,,,,,.T.)
		EndIF
		oPrint:SetPortrait() 			
		oPrint:SetPaperSize(DMPAPER_A4)	
		oPrint:StartPage()

		RptStatus({|| Impress(oPrint,aBitmap,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,CB_RN_NN,cLocal,_lEmail)}, "Aguarde...", "Executando rotina...")
//		Impress(oPrint,aBitmap,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,CB_RN_NN,cLocal,_lEmail)

		n := n + 1
		
		If _lEmail .Or. lGetPDF 
	
			//oPrint:EndPage()     // Finaliza a página	
			
			cFilePrint := clocal+cFile+".rel"
			File2Printer( oPrint:cFilePrint, "PDF")
			oPrint:cPathPDF:= cLocal
			cFilePDF := clocal+cFile+".pdf"
			
			If _lEmail
				oPrint:Print()
			EndIf
		
			CpyT2S( cFilePDF, "\RELATO\" )
			
	
			If( File( clocal+cFile+".pdf" ) ) .And. _lEMail
			
				If( _lEmail )
					_fGeraEnv( aDadosTit, aDatSacado , cFile+".pdf", CB_RN_NN)	

				EndIf
			else
				oPrint:EndPage()
				oPrint:Preview()
				cFilePDF	:= ""
			EndIf
		EndIf
	
	EndIf

	aAdd( aInfos ,{ SE1->E1_CLIENTE , SE1->E1_PREFIXO , SE1->E1_NUM , SE1->E1_PARCELA })

	IncProc('Lendo titulos: ' + Alltrim(SE1->E1_NUM) )
Next	


Return 
                                                                
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
Static Function Impress(oPrint,aBitmap,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,CB_RN_NN,cLocal,_lEmail)

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

aBmp := "\SYSTEM\" + aDadosBanco[7]


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

//Recibo do sacado primeiras linhas
oPrint:Line (0220,100,0220,2300)//780
oPrint:Line (0220,550,0120, 550)//780
oPrint:Line (0220,800,0120, 800)//780

// LOGOTIPO
If File(aBmp)
	oPrint:SayBitmap( 0170,0100,aBmp,0100,0100 )
//	oPrint:Say  (0200,240,"Banco Itaú SA",oFont2n )	// [2]Nome do Banco
Else
	oPrint:Say  (0195,100,aDadosBanco[2],oFont15n )	// [2]Nome do Banco
EndIf

oPrint:Say  (0195,0567,cCod_Comp			,oFont24 )	// [1]Numero do Banco
oPrint:Say  (0180,1900,"Recibo do Pagador"	,oFont10 )

//linhas do boleto
oPrint:Line (0320,100,0320,2300 )//880
oPrint:Line (0420,100,0420,2300 )//980
oPrint:Line (0520,100,0520,2300 )//1080
oPrint:Line (0590,100,0590,2300 )//1150
oPrint:Line (0660,100,0660,2300 )//1220

//colunas
oPrint:Line (0520,0500,0660,500)//1080
oPrint:Line (0590,0750,0660,750)//1150
oPrint:Line (0520,1000,0660,1000)//1080
oPrint:Line (0520,1350,0590,1350)//1080
oPrint:Line (0520,1550,0590,1550)//1080

oPrint:Say  (0245,0100,"Local de Pagamento"                             ,oFont8)
oPrint:Say  (0265,0400,"EM QUALQUER BANCO OU CORRESP. NAO BANCARIO"  	,oFont9)
oPrint:Say  (0305,0400,"MESMO APOS O VENCIMENTO"        				,oFont9)

oPrint:Say  (0245,1910,"Vencimento"                                     ,oFont8)
_cStr	:= DtoS(aDadosTit[4])
oPrint:Say  (0285,2037,Subs(_cStr,7,2)+'/'+Subs(_cStr,5,2)+'/'+Subs(_cStr,1,4)	,oFont10)

oPrint:Say  (0345,100 ,"Beneficiário"                               ,oFont8)
oPrint:Say  (0385,100 ,AllTrim(aDadosEmp[1])+"   - "+aDadosEmp[6]	,oFont10) //Nome + CNPJ

oPrint:Say  (0445,100 ,"Endereço Beneficiário / Sacador Avalista"         ,oFont8)
oPrint:Say  (0485,100 ,"RUA SERRA DA BORBOREMA, 40 DIADEMA SAO PAULO SP 09930 580"	,oFont10) //Nome + CNPJ

oPrint:Say  (0345,1910,"Agência/Código Beneficiário"                         ,oFont8)
oPrint:Say  (0385,1995,Subs(aDadosBanco[3],1,4)+"/"+Subs(aDadosBanco[4],1,5)+"-"+aDadosBanco[5],oFont10)

oPrint:Say  (0545,100 ,"Data do Documento"                              ,oFont8)
oPrint:Say  (0575,100 ,DTOC(aDadosTit[2])                               ,oFont10) // Emissao do Titulo (E1_EMISSAO)

oPrint:Say  (0545,505 ,"Nro.Documento"                                  ,oFont8)
oPrint:Say  (0575,605 ,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela

oPrint:Say  (0545,1005,"Espécie Doc."                                   ,oFont8)
oPrint:Say  (0575,1050,aDadosTit[8]										,oFont10) //Tipo do Titulo

oPrint:Say  (0545,1355,"Aceite"                                         ,oFont8)
oPrint:Say  (0575,1455,"N"                                             ,oFont10)

oPrint:Say  (0545,1555,"Data do Processamento"                          ,oFont8)
oPrint:Say  (0575,1655,DTOC(aDadosTit[3])                               ,oFont10) // Data impressao

oPrint:Say  (0545,1910,"Nosso Número"                                   ,oFont8)
oPrint:Say  (0575,1958,Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4,10),oFont10)

oPrint:Say  (0615,100 ,"Uso do Banco"                                   ,oFont8)

oPrint:Say  (0615,505 ,"Carteira"                                       ,oFont8)
oPrint:Say  (0645,555 ,aDadosBanco[6]                                  	,oFont10)

oPrint:Say  (0615,755 ,"Espécie"                                        ,oFont8)
oPrint:Say  (0645,805 ,"R$"                                             ,oFont10)

oPrint:Say  (0615,1005,"Quantidade"                                     ,oFont8)
oPrint:Say  (0645,1555,"Valor"                                          ,oFont8)

oPrint:Say  (0615,1910,"Valor do Documento"                          	,oFont8)
oPrint:Say  (0645,2075,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)

//dados das instrucoes
oPrint:Say  (0685,100 ,"Instruções (Todas informações deste bloqueto são de exclusiva responsabilidade do Beneficiário)",oFont8)
_cStr	:= AllTrim(Transform(((aDadosTit[5]*(5.9/100)/30)),"@E 99,999.99"))
oPrint:Say  (0725,100 ,aBolText[2]+_cStr				     			,oFont10)
oPrint:Say  (0765,100 ,aBolText[3]                                      ,oFont10)
oPrint:Say  (0815,100 ,aBolText[4]                                      ,oFont10)
oPrint:Say  (0865,100 ,aBolText[5]                                      ,oFont10)
oPrint:Say  (0915,100 ,aBolText[6]                                      ,oFont10)

oPrint:Say  (0685,1910,"(-)Desconto/Abatimento"                         ,oFont8)
oPrint:Say  (0755,1910,"(-)Outras Deduções"                             ,oFont8)
oPrint:Say  (0825,1910,"(+)Mora/Multa"                                  ,oFont8)
oPrint:Say  (0895,1910,"(+)Outros Acréscimos"                           ,oFont8)
oPrint:Say  (0965,1910,"(=)Valor Cobrado"                               ,oFont8)

oPrint:Say  (1045,100 ,"Pagador"                                         ,oFont8)
oPrint:Say  (1050,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)
oPrint:Say  (1090,400 ,aDatSacado[3]                                    ,oFont10)
oPrint:Say  (1130,400 ,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
oPrint:Say  (1170,400 ,"CGC: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99"),oFont10) // CGC
oPrint:Say  (1170,1850,Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4,10)  ,oFont10)

oPrint:Say  (1185,100 ,"Sacador/Avalista"                               ,oFont8)
oPrint:Say  (1225,1500,"Autenticação Mecânica -"                        ,oFont8)


// linha da coluna dos valores
oPrint:Line (0220,1900,1010,1900 )//880
// outras deducoes
oPrint:Line (0730,1900,0730,2300 )//1290
//mora multa
oPrint:Line (0800,1900,0800,2300 )//1360
//outros acrescimos
oPrint:Line (0870,1900,0870,2300 )//1430

// valor cobrado
oPrint:Line (0940,1900,0940,2300 )//1500
// penultima linha(Linha do Sacado)
oPrint:Line (1020,100 ,1020,2300 )//1580
// ultima linha (Sacador avalista)
oPrint:Line (1190,100 ,1190,2300 )//1950

//Pontilhado de inicio para o ultimo conjunto
For i := 100 to 2300 step 50
	oPrint:Line( 1550, i, 1550, i+30)                 // 2195 - 12
Next i

oPrint:Line (2085,100,2085,2300)                                                       //   2280
oPrint:Line (1800,550,1900,550)                                                       //   2280
oPrint:Line (1800,810,1900,810)                                                       //    2280

// LOGOTIPO
If File(aBmp)
	oPrint:SayBitmap( 2170,0100,aBmp,0100,0100 )
//	oPrint:Say  (2200,240,"Banco Itaú SA",oFont2n )	// [2]Nome do Banco
Else
	oPrint:Say  (1870,100,aDadosBanco[2],oFont15n )	// [2]Nome do Banco                     1934
EndIf


oPrint:Say  (1875,567,cCod_Comp,oFont24 )	// [1]Numero do Banco                       1912
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
oPrint:Say  (1940,400 ,"EM QUALQUER BANCO OU CORRESP. NAO BANCARIO"         ,oFont9)  //  2020
oPrint:Say  (1980,400 ,"MESMO APOS O VENCIMENTO"		        			,oFont9)       //      2060

oPrint:Say  (1920,1910,"Vencimento"                                     	,oFont8)                  // 2000
_cStr	:= DtoS(aDadosTit[4])
oPrint:Say  (1960,2037,Subs(_cStr,7,2)+'/'+Subs(_cStr,5,2)+'/'+Subs(_cStr,1,4)	,oFont10)

oPrint:Say  (2020,100 ,"Beneficiário"                                        ,oFont8)                      // 2100
oPrint:Say  (2060,100 ,AllTrim(aDadosEmp[1])+"   - "+aDadosEmp[6]	,oFont10) //Nome + CNPJ

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
_cStr	:= AllTrim(Transform(ROUND((aDadosTit[5]* (5.9/100))/30,2),"@E 99,999.99"))
oPrint:Say  (2310,100 ,aBolText[2]+_cStr								,oFont10)  // 2490  // *0.05)/30)
oPrint:Say  (2360,100 ,aBolText[3]                                      ,oFont10)    //2540
oPrint:Say  (2410,100 ,aBolText[4]                                      ,oFont10)
oPrint:Say  (2460,100 ,aBolText[5]                                      ,oFont10)
oPrint:Say  (2510,100 ,aBolText[6]                                      ,oFont10)

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

oPrint:Line (1900,1900,2585,1900 )         // 2280 - 2690       -
oPrint:Line (2305,1900,2305,2300 )         // 2690        -
oPrint:Line (2375,1900,2375,2300 )         // 2760        -
oPrint:Line (2445,1900,2445,2300 )         // 2830        -
oPrint:Line (2505,1900,2505,2300 )         // 2900        -
oPrint:Line (2585,100 ,2585,2300 )         // 2970        -

oPrint:Line (2780,100 ,2780,2300 )         // 3210
oPrint:FwMsBar("INT25",66,3,CB_RN_NN[1]  ,oPrint,.F.,,.T.,0.023,1, NIL,NIL,NIL,.F.)


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

LOCAL nTam	:= 0
Local nVez	:= 0
Local nRes	:= 0
Local nPeso	:= 0
Local nParc := 0
Local nTot	:= 0
Local nVez2	:= 0
Local cStr	:= ''
cData	:= Alltrim(cData)
nTam	:= Len(cData)
nPeso	:= 2
For nVez:= nTam to 1 Step -1
	nParc	:= Val(SubStr(cData, nVez, 1))
	nRes	:= (nParc * nPeso)
	If nRes > 9
		cStr	:= AllTrim(Str(nRes,0))
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
Static Function Ret_cBarra(cBanco1,cAgencia1,cConta1,cDacCC,cNroDoc,nValor,dVencto,cCart)

//							BANCO		  AGENCIA			CONTA		DIGITO                NUMBCO             VALOR                VENCTO         CARTEIRA			
//		CB_RN_NN    := Ret_cBarra(aDadosBanco[1],aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],AllTrim(_cNossoNum),(SE1->E1_SALDO-_nVlrAbat),SE1->E1_VENCTO,aDadosBanco[6])

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
LOCAL _cfator      := 1000
LOCAL _cCart	   := ''


// Ajuste dos campos
cBanco	:= Subs(cBanco1,1,3)
cAgencia:= Subs(cAgencia1,1,4)
cConta	:= Subs(cConta1,1,5)

If dVencto > ctod("22/02/25")  
	_cfator      += strzero(dVencto - ctod("22/02/2025"),4)
	_cfator      := StrZero(_cfator,4)
Else
	_cfator      += dVencto - ctod("03/07/2000")
	_cfator      := StrZero(_cfator,4)
End

_cCart		:=  cCart  

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



/*------------------------ Definicao do NOSSO NUMERO ------------------------*/
//-------- Nosso Numero sem digito (DAC)
_cNNDig := cNumSeq
//-------- Nosso Numero + DAC [Nosso Número]
_cNossoNum := _cNNDig + AllTrim( Mod11ST( _cNNDig,1 ) )
//-------- Nosso Numero para impressao: Nosso Numero-DAC
NN := _cNNDig + '-' + AllTrim( Mod11ST( _cNNDig,1 ) )

//Campo Livre
//cCpoLivre := StrZero(Val(Alltrim(substr(cConvenio,1,7)) ),7)/*7*/ + _cNossoNum/*8*/ + "0" + _cCart/*3*/
cCpoLivre := StrZero(Val(Alltrim(substr(cConvenio,6,7)) ),7)/*7*/ + _cNossoNum/*8*/ + "0" + _cCart/*3*/ //Thiago
//cCpoLivre := Left(ALLTRIM(cConta),7)/*7*/ + '00000'/*5*/ + _cNossoNum/*8*/ + "0" + _cCart/*3*/


/*----------------------- Definicao do CODIGO DE BARRAS ---------------------*/
//Codigo de barras sem DAC
s    := cBanco/*4*/ + _cfator/*4*/ + blvalorfinal/*10*/ + "9"/*1*/ + cCpoLivre/*24*/

//DAC [código de Barras]
dvcb := mod11ST(s,2)       

//Codigo de barras com DAC
CB   := SUBSTR(s, 1, 4) + AllTrim(Iif( valtype(dvcb)=='N',Str(dvcb),dvcb )) + SUBSTR(s,5) //Tamanho total = 44






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

/*/{Protheus.doc} limpArqPdf
Limpar os arquivos PDF que são gerados pelo schedule
@type Function
@author Emerson Campos
@since 30/06/2015
@version Generic
/*/
User Function limpArqPdf()

Local cPath	:= Lower(supergetmv("MV_RELT",,"\relato\"))
	AEVAL(DIRECTORY("\relato\"+"bol*.pdf"), { |aFile| FERASE(cPath+aFile[1]) })	

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fGeraEnv ºAutor  ³Adriano Luis Brandaoº Data ³  04/06/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para envio de e-mail                                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fGeraEnv(aDadosTit, aDatSacado, cFilePDF,CB_RN_NN)	

Local oProcess
Local oHtml
Local cSubject:=''
Local cTo:=''
Local cCC:= ''

oProcess := TWFProcess():New( "00001", "Emissao de Boleto - Alpax" )

// Cria-se uma nova tarefa para o processo.
oProcess:NewTask( "Boleto", "\WORKFLOW\BOLETO.HTM" )
oProcess:cSubject := "Boleto Contas a Receber - Alpax"
oProcess:cTo  := aDatSacado[8]    //"luiz.araujo@3proconsultoria.com.br"  
oProcess:cCC  := "financeiro@alpax.com.br"    //"ljjbmg@gmail.com"//
oProcess:cBCC := ""
oProcess:bReturn := ""

// Faz uso do objeto ohtml que pertence ao processo
oHtml := oProcess :oHtml
oHtml:ValByName("BolCliente",aDatSacado[1])

aadd(oHtml:ValByName("it.cDupli"	 )  , aDadosTit[1] )
aadd(oHtml:ValByName("it.cEmiss"	 )  , dtoc((aDadosTit[2])))
aadd(oHtml:ValByName("it.cVencim"    )  , dtoc((aDadosTit[4]))) //vencimento dos títulos
aadd(oHtml:ValByName("it.cValor"	 )  , Transform(aDadosTit[5],"@E 99,999,999.99"))
aadd(oHtml:ValByName("it.cNossoNum"	 )  , CB_RN_NN[2])

oProcess:AttachFile( "\RELATO\"+ cFilePDF )
oProcess:Start()

Return


/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³ Funcao    ³ LOGBANC()   ³                          ³ Data ³ 12/09/2012 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Descricao ³ Retorna o nome do Logo do banco                            ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Uso       ³ FINANCEIRO                                                 ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//
STATIC FUNCTION LogBanc(cBco)
	Local cLogo := ""
	Local cNome := ""
	
	Do Case

	Case cBco=="001" //Banco do Brasil
		cLogo := "bancodobrasil.bmp"
		cNome := "Banco do Brasil"
	Case cBco=="237" //Bradesco
		cLogo := "bradesco.bmp"
		cNome := "Bradesco"
	Case cBco=="104" //Caixa Economica
		cLogo := "caixa.bmp"
		cNome := "Caixa Econômica Federal"
	Case cBco=="341" //Itau
		cLogo := "itau.bmp"
		cNome := "Banco Itaú S.A."
	Case cBco=="033" //Santander
		cLogo := "santander.bmp"
		cNome := "Santander"
	Case cBco=="356" //Real
		cLogo := "real.bmp"
		cNome := "Santander" //Banco real, porem o nome exibido deve ser Santander
	OtherWise
		cLogo := ""
		cNome := ""
	EndCase

Return ({cLogo,cNome})

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao    ³ MOD11ST()  ³                           ³ Data ³ 12/09/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descricao ³ Impressao de Boleto Bancario, Calculo do 				   ³±±
±±³           ³ Digito verificador (DAC) Mod 11 - Santander				   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso       ³ FINANCEIRO                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC FUNCTION Mod11ST(cData,nOpcST)
LOCAL L, D, P := 0
L := LEN(cdata)
D := 0
P := 1
	WHILE L > 0
	P := P + 1
	D := D + (VAL(SUBSTR(cData, L, 1)) * P)
		IF P = 9
		P := 1
		ENDIF
	L := L - 1
	ENDDO
//D := 11 - (Mod(D,11))
D := Mod(D,11)
	If D == 10 .Or. D == 1 .Or. D == 0
		If nOpcST == 1 //Nosso número
		D := Iif(D == 10, 1, 0)
		Else //Linha digitável
		D := 1
		Endif
	Else
	D := 11 - D
	EndIf
D := AllTrim(Str(D))

RETURN(D)

/*/
	ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
	±±³ Funcao    ³ NUMPARCELA()³                          ³ Data ³ 12/09/2012 ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Descricao ³ Calculo da Parcela        					               ³±±
	±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
	±±³ Uso       ³ FINANCEIRO                                                 ³±±
	±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
	ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function NumParcela(_cParcela)
	Local _cRet := ""
	If ASC(_cParcela) >= 65 .or. ASC(_cParcela) <= 90
		_cRet := StrZero(Val(Chr(ASC(_cParcela)-16)),2)
	Else
		_cRet := StrZero(Val(_cParcela),2)
	Endif
Return(_cRet)
