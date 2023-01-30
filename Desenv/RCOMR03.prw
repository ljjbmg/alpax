#INCLUDE "PROTHEUS.CH"
#include "rwmake.ch"     
#include "TopConn.ch"    
#Include "AP5MAIL.ch"
#Include "TOTVS.ch"
#Include "FWPrintSetup.ch"
#Include "RPTDEF.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"  

/*                                                                        
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  ³ RCOMR03  ºAutor  ³André R. Esteves    º Data ³  14/12/12   º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDescricao ³Imprimir Pedido de Compras Grafico                          º±±
±±º          ³                                                            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ ESPECIFICO ALPAX                                          º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RCOMR03() 

SetPrvt("CDESC1,CDESC2,CDESC3,COBS,COBS01,COBS02,COBS03,COBS04,COBS05,_CSTRING,AORD,J")
SetPrvt("oFont1,oFont2,oFont3,oFont3n,oFont4,oFont5,oFont6,oFont7")
Private  nPag  := 1
Private  nPagd := 0
Private NumPed := Space(6)
Private aEmail := {}
Private cPFornec
Private cEmailForn
Private cEmailNome 
Private cFornece
RptStatus({|| Relato()})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÝÝÝÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝËÝÝÝÝÝÝÑÝÝÝÝÝÝÝÝÝÝÝÝÝ»±±
±±ºPrograma  ³ RELATO   ºAutor  ³ André R. Esteves   º Data ³  03/02/2005 º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÊÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÝÝÝÝÝÝÝÝÝÝØÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¹±±
±±ºUso       ³ AP6                                                        º±±
±±ÈÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Relato()
Local cQuery
Local cAliasSql
Local nReem
Local nOrder
Local cCondBus
Local nSavRec
Local aSavRec := {}
Private lEnc  := .f.
Private cTitulo
Private oFont, cCode, oPrn
Private cCGCPict, cCepPict    
Private lPrimPag :=.t.
Private cPerg   :="MTR11G", cMsg, nLinha, nLinhaD, nLinhaO, cObs

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01	     	  Do Pedido                              ³
//³ mv_par02	     	  Ate o Pedido 		                     ³
//³ mv_par03	     	  A partir da Data                       ³
//³ mv_par04              Ate a Data                  	     	 ³
//³ mv_par05              Somente os novos?           	   	     ³
//³ mv_par06              Descricao Produto                      ³
//³ mv_par07              Qual Unid.Medida                       ³
//³ mv_par08              Imprime?                               ³
//³ mv_par09              Nr.Vias                                ³
//³ mv_par10              Imprime Pedidos?                       ³
//³ mv_par11              Considera SCs?                         ³
//³ mv_par12              Qual Moeda?                            ³
//³ mv_par13              Endereco de Entrega                    ³
//³ mv_par14              Destino: Impressão/e-mail?             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ValidPerg()

If !Pergunte(cPerg,.T.)
	Return
EndIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Definir as pictures                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCepPict:=PesqPict("SA2","A2_CEP")
cCGCPict:=PesqPict("SA2","A2_CGC")

oFont1 := TFont():New( "Arial",,16,,.t.,,,,,.f. )
oFont2 := TFont():New( "Arial",,16,,.f.,,,,,.f. )
oFont3 := TFont():New( "Arial",,10,,.t.,,,,,.f. )
oFont3p := TFont():New( "Arial",,09,,.t.,,,,,.f. )
oFont4 := TFont():New( "Arial",,08,,.f.,,,,,.f. )
oFont5 := TFont():New( "Arial",,08,,.t.,,,,,.f. )  
oFont6 := TFont():New( "Arial",,08,,.f.,,,,,.f. )
oFont7 := TFont():New( "Arial",,14,,.t.,,,,,.f. )                                                               	
oFont8 := TFont():New( "Arial",,14,,.f.,,,,,.f. )
oFont9 := TFont():New( "Arial",,12,,.t.,,,,,.f. )  
oFont10:= TFont():New( "Arial",,12,,.f.,,,,,.f. ) 
oFont11:= TFont():New( "Arial",,07,,.t.,,,,,.f. )  
oFont12:= TFont():New( "Arial",,07,,.f.,,,,,.f. )

oFont1c := TFont():New( "Courier New",,16,,.t.,,,,,.f. )
oFont2c := TFont():New( "Courier New",,16,,.f.,,,,,.f. )
oFont3c := TFont():New( "Courier New",,10,,.t.,,,,,.f. )
oFont4c := TFont():New( "Courier New",,10,,.f.,,,,,.f. )
oFont5c := TFont():New( "Courier New",,09,,.t.,,,,,.f. )  
oFont6c := TFont():New( "Courier New",,09,,.T.,,,,,.f. )
oFont7c := TFont():New( "Courier New",,14,,.t.,,,,,.f. )  
oFont8c := TFont():New( "Courier New",,14,,.f.,,,,,.f. )
oFont9c := TFont():New( "Courier New",,12,,.t.,,,,,.f. )  
oFont10c:= TFont():New( "Courier New",,12,,.f.,,,,,.f. )
oFont11c:= TFont():New( "Courier New",,08,,.T.,,,,,.f. ) 

oFont3b := TFont():New( "Arial",,07,,.t.,,,,,.f. )

		cDir   := GetTempPath(.T.)
	   	oPrn  := FWMSPrinter():New("PC" + DTOS(Date()) + StrTran(Time(),":",""), IMP_PDF, .T.,, .T.,.T.,,,,,, .F.)   
	   	oPrn:SetViewPDF(.T.)
	   	oPrn:SetResolution(78)
	   	oPrn:SetLandscape()
	   	oPrn:SetPaperSize(DMPAPER_A4)
	   	oPrn:SetMargin(60,60,60,60)
	   	oPrn:nDevice  := IMP_PDF//IMP_SPOOL
	   	oPrn:cPathPDF := cDir      
		oPrn:SetParm( "-RFS")   
		
nDescProd:= 0
nTotal   := 0
nTotMerc := 0
cCondBus := mv_par01
nOrder	 :=	1
nRegs    :=0   //andre
nPed     := 0 //ANDRE
cObs     := "Horario de Recebimento 08:00 as 16:00 seg a sexta" //Andre R. Esteves - 10/04/2018

cQuery := "SELECT "
cQuery += "SC7.R_E_C_N_O_ RECSC7,C7_FILIAL,C7_NUM,C7_ITEM,C7_SEQUEN "
cQuery += "FROM "+RetSQLName("SC7")+" SC7 "
cQuery += "WHERE "
cQuery += "SC7.D_E_L_E_T_ =' ' "
cQuery += "AND C7_NUM    >='"+MV_PAR01+"' "
cQuery += "AND C7_NUM    <='"+MV_PAR02+"' "
cQuery += "AND C7_EMISSAO>='"+DToS(MV_PAR03)+"' "
cQuery += "AND C7_EMISSAO<='"+DToS(MV_PAR04)+"' "         
cQuery += "ORDER BY "
cQuery += "C7_FILIAL,C7_NUM,C7_ITEM,C7_SEQUEN"

cQuery    := ChangeQuery(cQuery)
cAliasSql := GetNextAlias()
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSql,.F.,.F.)

dbSelectArea("SC7")
dbSetOrder(nOrder)
SetRegua(RecCount())

If (cAliasSql)->(!EOF())
	SC7->(dbGoTo( (cAliasSql)->RECSC7 ))
Else
	SC7->(dbSeek(xFilial("SC7")+cCondBus,.T.))
EndIf                                         
(cAliasSql)->(dbCloseArea())



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Faz manualmente porque nao chama a funcao Cabec()                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC7")
While !Eof() .And. C7_FILIAL = xFilial("SC7") .And. C7_NUM >= mv_par01 .And. ;
		C7_NUM <= mv_par02
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Cria as variaveis para armazenar os valores do pedido        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nOrdem   := 1
	nReem    := 0

	If C7_EMITIDO == "S" .And. mv_par05 == 1
		dbSkip()
		Loop
	Endif
	If (C7_CONAPRO == "B" .And. mv_par10 == 1) .Or.;
	   (C7_CONAPRO != "B" .And. mv_par10 == 2)
		dbSkip()
		Loop
	Endif
	If (C7_EMISSAO < mv_par03) .Or. (C7_EMISSAO > mv_par04)
		dbSkip()
		Loop
	Endif
	If C7_TIPO == 2
		dbSkip()
		Loop
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtra Tipo de SCs Firmes ou Previstas                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !MtrAValOP(mv_par11, 'SC7')
		dbSkip()
		Loop
	EndIf
		
	MaFisEnd()
	R110FIniPC(SC7->C7_NUM) // Substituir a funcao MaFisIniPC
  
//Calculo de numero de páginas
//*********************************************************************************************
	nPed := SC7-> C7_NUM
	Set Filter to SC7->C7_NUM== nPed 
    Count to nRegs
    nPagd := (nRegs + 19)/20 
    Set Filter To

   dbSeek(xFilial("SC7")+nPed) 
//*********************************************************************************************    
	For ncw := 1 To mv_par09		// Imprime o numero de vias informadas

		oPrn:StartPage()
		ImpCabec()
		
		nTotal   := 0
		nTotMerc	:= 0
		nDescProd:= 0
		nReem    := SC7->C7_QTDREEM + 1
		nSavRec  := SC7->(Recno())
		NumPed   := SC7->C7_NUM
        li       := 590        
        nTotDesc := 0
        cFornece := SC7->(C7_FORNECE+C7_LOJA)

		While !Eof() .And. SC7->C7_FILIAL = xFilial("SC7") .And. SC7->C7_NUM == NumPed
		
			dbSelectArea("SC7")
			If Ascan(aSavRec,Recno()) == 0		// Guardo recno p/gravacao
				AADD(aSavRec,Recno())
			Endif
			
			IncRegua()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Verifica se havera salto de formulario                       ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		  	If li > 1620
				nOrdem++
			   oPrn:EndPage() 	//Marcio
			   oPrn:StartPage()	//Marcio
				ImpRodape()			// Imprime rodape do formulario e salta para a proxima folha
				ImpCabec()
				li  := 590  
			Endif
			
			li:=li+60
			
		 	oPrn:Say( li, /*0070*/ CalcCol(0065), StrZero(Val(SC7->C7_ITEM),2),oFont4,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
            //oPrn:Say( li, /*0165*/ CalcCol(0147) , AllTrim(UPPER(SC7->C7_PRODUTO)),oFont4,100,,,2) 
			oPrn:Say( li, /*0165*/ CalcCol(0147) , AllTrim(UPPER(SC7->C7_AXPART)),oFont4,100,,,2) 

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Pesquisa Descricao do Produto                                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			ImpProd()

			If SC7->C7_DESC1 != 0 .or. SC7->C7_DESC2 != 0 .or. SC7->C7_DESC3 != 0
				nDescProd+= CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
			Else
				nDescProd+=SC7->C7_VLDESC
			Endif

			dbSkip()
		EndDo
		
		dbGoto(nSavRec)

		If li>1620
			nOrdem++  
		   oPrn:EndPage() 	//Marcio
		   oPrn:StartPage()	//Marcio			
			ImpRodape()		// Imprime rodape do formulario e salta para a proxima folha
			ImpCabec()
			li  := 590
		Endif

		FinalPed()		// Imprime os dados complementares do PC
        oPrn:EndPage()
	Next

	MaFisEnd()
	
	dbSelectArea("SC7")
	If Len(aSavRec)>0
		For i:=1 to Len(aSavRec)
			dbGoto(aSavRec[i])
			RecLock("SC7",.F.)  //Atualizacao do flag de Impressao
			Replace C7_QTDREEM With (C7_QTDREEM+1)
			Replace C7_EMITIDO With "S"
			MsUnLock()
		Next
		dbGoto(aSavRec[Len(aSavRec)])		// Posiciona no ultimo elemento e limpa array
	Endif
    
	// dbGoto(aSavRec[Len(aSavRec)])		// Posiciona no ultimo elemento e limpa array

	aSavRec := {}
	
	dbSkip()
EndDo

dbSelectArea("SC7")
Set Filter To
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

If lEnc
   oPrn:Preview()
   MS_FLUSH()
   /*
   If mv_par14==2
	   oPrn:SaveAllAsJpeg("\RELATO\COMPRAS\",1280,1280)
	   //ImpHtml()
   EndIf
   */   
EndIf
   
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpCabec ³ Autor ³ André R. Esteves      ³ Data ³ 03/02/2005±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o Cabecalho do Pedido de Compra                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpCabec(Void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCabec()
Local nOrden, cCGC
LOCAL cMoeda
Local cComprador:=""
LOcal cAlter	:=""
Local cAprova	:=""
Local cCompr	:=""

cMoeda := Iif(mv_par12<10,Str(mv_par12,1),Str(mv_par12,2))

If !lPrimPag
//   oPrn:EndPage()	   //Marcio
//   oPrn:StartPage() //Marcio
   nPag += 1
Else
   lPrimPag := .f.
   lEnc     := .t.
// oPrn  := TMSPrinter():New() //-- Marcio - mudan�a para FWMSPrinter()

/* -- Marcio - mudan�a para FWMSPrinter()
   oPrn:setPaperSize(9) // A4
   oPrn:setlandscape()
   oPrn:Setup()
*/ 

EndIF  
oPrn:Say( 0020, 0020, " ",oFont,100 ) // startando a impressora   
           

//Verifica Comprador 
PswOrder(1)
If PswSeek(SC7->C7_USER,.t.)
	cCompr := AllTrim(UsrFullName(SC7->C7_USER))    
Else 
	cCompr:= "Nao Cadastrado"
EndIF	

dbSelectArea("SC7") 
//If C7_CONAPRO != "B" //Linha original do programa
If C7_CONAPRO == "B"
	dbSelectArea("SCR")
	dbSetOrder(1)
	dbSeek(xFilial()+"PC"+SC7->C7_NUM)
	While !Eof() .And. SCR->CR_FILIAL+Alltrim(SCR->CR_NUM)==xFilial("SCR")+SC7->C7_NUM .And. SCR->CR_TIPO == "PC"
		IF SCR->CR_STATUS=="03"
			cAprova += AllTrim(UsrFullName(SCR->CR_USER))
		EndIF
		dbSelectArea("SCR")
		dbSkip()
	Enddo
	If !Empty(SC7->C7_GRUPCOM)
		dbSelectArea("SAJ")
		dbSetOrder(1)
		dbSeek(xFilial()+SC7->C7_GRUPCOM)
		While !Eof() .And. SAJ->AJ_FILIAL+SAJ->AJ_GRCOM == xFilial("SAJ")+SC7->C7_GRUPCOM
			If SAJ->AJ_USER != SC7->C7_USER
				cAlter += AllTrim(UsrFullName(SAJ->AJ_USER))+"/"
			EndIf
			dbSelectArea("SAJ")
			dbSkip()
		EndDo
	EndIf
Else
   cAprova := "Nao Aprovado"
EndIF

cGrpCompany	:= AllTrim(FWGrpCompany())
cCodEmpGrp	:= AllTrim(FWCodEmp())
cUnitGrp	:= AllTrim(FWUnitBusiness())
cFilGrp		:= AllTrim(FWFilial())
			
If !Empty(cUnitGrp)
	cDescLogo	:= cGrpCompany + cCodEmpGrp + cUnitGrp + cFilGrp
Else
	cDescLogo	:= cEmpAnt + cFilAnt
EndIf

cLogo := GetSrvProfString("Startpath","") + "DANFE" + cDescLogo + ".BMP"//"ALPAX.BMP"

//Cabecalho (Enderecos da Empresa e Fornecedor)
oPrn:Box( 0175, CalcCol(0010) , 0545,CalcCol(0410) ) //Box do Logo
oPrn:Box( 0175, CalcCol(0410) , 0300,CalcCol(2350) ) //Box Cabeçalho (PEDIDO DE COMPRA...)
oPrn:Box( 0175, CalcCol(2350) , 0300,CalcCol(2750) ) //Box Nºdo Pedido 
oPrn:Box( 0175, CalcCol(2750) , 0300,CalcCol(2950) ) //Box Nºda via 
oPrn:Box( 0175, CalcCol(2950) , 0300,CalcCol(3340) ) //Box Nºda página
oPrn:Box( 0300, CalcCol(0410) , 0545,CalcCol(1300) ) //Box dados da empresa
oPrn:Box( 0300, CalcCol(1300) , 0545,CalcCol(2350) ) //Box dados do fornecedor
oPrn:Box( 0300, CalcCol(2350) , 0545,CalcCol(3340) ) //Box Data emissão + comprador

oPrn:SayBitmap(0250,020,cLogo,235,235)//oPrn:SayBitmap( 0225, CalcCol(0245) ,"\system\alpax.bmp",0313,0245)

//Cabecalho Produto do Pedido
oPrn:Box( 0545, CalcCol(0010) , 0605,CalcCol(0140) ) //BOX ITEM
oPrn:Box( 0545, CalcCol(0140) , 0605,CalcCol(0410) ) //BOX CÓDIGO
oPrn:Box( 0545, CalcCol(0410) , 0605,CalcCol(1300) ) //BOX DESCRIÇÃO
oPrn:Box( 0545, CalcCol(1300) , 0605,CalcCol(1496) ) //BOX NCM
oPrn:Box( 0545, CalcCol(1496) , 0605,CalcCol(1582) ) //BOX UN
oPrn:Box( 0545, CalcCol(1582) , 0605,CalcCol(1737) ) //BOX QTDE - 175
oPrn:Box( 0545, CalcCol(1737) , 0605,CalcCol(2026) ) //BOX VALOR UNIT - 270
//oPrn:Box( 0545, 1780, 0605,1976) //BOX % DESC - 165
oPrn:Box( 0545, CalcCol(2026) , 0605,CalcCol(2160) ) //BOX % IPI - 135  
oPrn:Box( 0545, CalcCol(2160) , 0605,CalcCol(2450) ) //BOX VALOR TOTAL - 280
oPrn:Box( 0545, CalcCol(2450) , 0605,CalcCol(2710) ) //BOX DATA ENTR - 210
oPrn:Box( 0545, CalcCol(2710) , 0605,CalcCol(2920) ) //BOX CENTRO CUSTO - 290
oPrn:Box( 0545, CalcCol(2920) , 0605,CalcCol(3130) ) //BOX ITEM CONTA. - 290
oPrn:Box( 0545, CalcCol(3130) , 0605,CalcCol(3340) ) //BOX S.C. - 290

//Espaco dos Itens do Pedido
oPrn:Box( 0605, CalcCol(0010) , 1730,CalcCol(0140) ) //Box Item
oPrn:Box( 0605, CalcCol(0140) , 1730,CalcCol(0410) ) //Box código
oPrn:Box( 0605, CalcCol(0410) , 1730,CalcCol(1300) ) //Box descrição
oPrn:Box( 0605, CalcCol(1300) , 1730,CalcCol(1496) ) //Box NCM
oPrn:Box( 0605, CalcCol(1496) , 1730,CalcCol(1582) ) //Box UM
oPrn:Box( 0605, CalcCol(1582) , 1730,CalcCol(1737) ) //Box Qtde
oPrn:Box( 0605, CalcCol(1737) , 1730,CalcCol(2026) ) //Box Valor Unit
//oPrn:Box( 0605, 1780, 1730,1976) //Box % desc
oPrn:Box( 0605, CalcCol(2026) , 1730,CalcCol(2160) ) //Box % IPI
oPrn:Box( 0605, CalcCol(2160) , 1730,CalcCol(2450) ) //Box valor total
oPrn:Box( 0605, CalcCol(2450) , 1730,CalcCol(2710) ) //Box Data entrega
oPrn:Box( 0605, CalcCol(2710) , 1730,CalcCol(2920) ) //Box Centro de custo
oPrn:Box( 0605, CalcCol(2920) , 1730,CalcCol(3130) ) //Box S.C.
oPrn:Box( 0605, CalcCol(3130) , 1730,CalcCol(3340) ) //Box Item Conta

dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(xFilial()+SC7->C7_FORNECE+SC7->C7_LOJA)

//Titulo
oPrn:Say( 0205, CalcCol(1100) , "PEDIDO DE COMPRA",oFont1,100 )
oPrn:Say( 0210, CalcCol(2395) , "N�",oFont3,100 )
oPrn:Say( 0211, CalcCol(2500) , SC7->C7_NUM,oFont1,100 )
oPrn:Say( 0205, CalcCol(2800) , Str(ncw,2)+"a.VIA" ,oFont3,100 )
oPrn:Say( 0205, CalcCol(3015) , "PA�G.:" ,oFont3,100 )
oPrn:Say( 0205, CalcCol(3182) , Alltrim(StrZero(nPag,2))+" / "+Alltrim(StrZero(nPagD,2)) ,oFont3,100 )

//Itens da Empresa / Fornecedor
oPrn:Say( 0310, CalcCol(0420) , SubStr(SM0->M0_NOMECOM,1,38) ,oFont3,100 )
oPrn:Say( 0310, CalcCol(1315) , "FORNECEDOR",oFont3,100 )
oPrn:Say( 0310, /*2570*/ CalcCol(2395) , "DATA EMISSAO:" ,oFont3,100 )
oPrn:Say( 0310, /*2940*/ CalcCol(2765) , DTOC(SC7->C7_EMISSAO) ,oFont3,100 )
oPrn:Say( 0355, CalcCol(0420) , UPPER(SM0->M0_ENDENT) ,oFont6,100 )
oPrn:Say( 0355, CalcCol(1315) , Alltrim(Substr(SA2->A2_NOME,1,40))+" - ("+SA2->A2_COD+")" ,oFont3,100 )
oPrn:Say( 0390, CalcCol(0420) , UPPER("CEP: "+Trans(SM0->M0_CEPENT,cCepPict)),oFont6,100 )
oPrn:Say( 0390, CalcCol(1000) , UPPER(Trim(SM0->M0_CIDENT)+" - "+SM0->M0_ESTENT) ,oFont6,100 )
oPrn:Say( 0390, CalcCol(1315) , UPPER(Substr(SA2->A2_END,1,40)+ Substr(SA2->A2_BAIRRO,1,20)) ,oFont6,100 )
oPrn:Say( 0425, CalcCol(1315) , Upper(Trim(SA2->A2_MUN)+"   "+SA2->A2_EST+" "+" - CEP: "+SA2->A2_CEP),oFont6,100 )
oPrn:Say( 0425, CalcCol(1975) , "FAX: " + "("+Substr(SA2->A2_DDD,1,3)+") "+SA2->A2_FAX ,oFont6,100 )
oPrn:Say( 0425, CalcCol(0420) , "TEL: " + SM0->M0_TEL ,oFont6,100 )
oPrn:Say( 0400, /*2570*/ CalcCol(2395) , "COMPRADOR : ",oFont5,100 )
oPrn:Say( 0400, /*2820*/ CalcCol(2645) , UPPER(Alltrim(cCompr)),oFont6,100 )
//oPrn:Say( 0460, 1000, "FAX: " + SM0->M0_FAX ,oFont6,100 )
dbSelectArea("SX3")
dbSetOrder(2)
dbSeek("A2_CGC")
cCGC := Alltrim(X3TITULO())
nOrden = IndexOrd()
oPrn:Say( 0460, CalcCol(0420) , (cCGC) + " "+ Transform(SM0->M0_CGC,cCgcPict) ,oFont6,100 )
oPrn:Say( 0460, CalcCol(1000) , "IE:" + InscrEst() ,oFont6,100 )
oPrn:Say( 0460, CalcCol(1315) , "VENDEDOR: " + Upper(Substr(SC7->C7_CONTATO,1,15)),oFont6,100 )
oPrn:Say( 0460, CalcCol(1975) , "FONE: " + "("+Substr(SA2->A2_DDD,1,3)+") "+Substr(SA2->A2_TEL,1,15) ,oFont6,100 )
oPrn:Say( 0490, /*2570*/CalcCol(2395) , Str(SC7->C7_QTDREEM+1,2)+"a. Emissao ",oFont6,100 )

dbSelectArea("SA2")
dbSetOrder(nOrden)
oPrn:Say( 0495, CalcCol(1315) , "CNPJ: " + Alltrim(Transform(SA2->A2_CGC,cCgcPict)) ,oFont6,100 )
oPrn:Say( 0495, CalcCol(1975) , "IE: " + SA2->A2_INSCR ,oFont6,100 )
                   
//Cabeçalho dos itens do Pedido
oPrn:Say( 0560, /*0035*/ CalcCol(0040) , "ITEM"  ,oFont3,100,,,2 )
oPrn:Say( 0560, /*0165*/ CalcCol(0230) , "CODIGO" ,oFont3,100,,,2 )
oPrn:Say( 0560, /* 0430*/ CalcCol(0790) , "DESCRICAO" ,oFont3,100,,,2 )   
oPrn:Say( 0560, /*1350*/ CalcCol(1370) , "NCM" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*1510*/ CalcCol(1525) , "UN" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*1600*/ CalcCol(1635) , "QTD"  ,oFont3,100,,,2 )
oPrn:Say( 0560, /*1753*/ CalcCol(1830) , "VL UNIT" ,oFont3,100,,,2 )
//oPrn:Say( 0560, 1821, "%Desc" ,oFont3,100 )
oPrn:Say( 0560, /*2006*/ CalcCol(2070) , "IPI%" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2141*/ CalcCol(2250) , "VL TOTAL" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2383*/ CalcCol(2530) , "DT ENTR." ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2680*/ CalcCol(2760) , "C.CUSTO" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2680*/ CalcCol(2970) , "ITEM CTA" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*3036*/ CalcCol(3220) , "SC" ,oFont3,100,,,2 )

cSubject := "Pedido de Compras nr."+SC7->C7_NUM+" / "+AllTrim(Left(SA2->A2_NOME,30))
cEmailEnd:= SA2->A2_EMAIL
aAdd(aEmail,{nPag,cEmailEnd,cSubject})

Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpProd  ³ Autor ³ André R. Esteves      ³ Data ³03/02/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pesquisar e imprimir  dados Cadastrais do Produto.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpProd(Void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpProd()
LOCAL cDesc, nLinRef := 1, nBegin := 0, cDescri := "", nLinha:=0,;
		nTamDesc := 50, aColuna := Array(8)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da descricao generica do Produto.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If      mv_par06 == 1				// B1_DESC"
	cDescri := Trim(Posicione("SB1",1,xFilial("SB1")+SC7->C7_PRODUTO,"SB1->B1_DESC"))
ElseIf  mv_par06 == 2				// B5_CEME
	cDescri := Trim(Posicione("SB5",1,xFilial("SB5")+SC7->C7_PRODUTO,"SB5->B5_CEME"))
ElseIf  mv_par06 == 4				// C1_DESCRI
	cDescri := Trim(Posicione("SC1",1,xFilial("SC1")+SC7->C7_NUMSC+SC7->C7_ITEMSC,"SC1->C1_DESCRI"))
EndIf
cDescri := If(Empty(cDescri),Trim(SC7->C7_DESCRI),cDescri)  	// opcao 3

If cObs != " "
cObs := cObs + " - " + Trim(SC7->C7_OBS)
Else
cObs := Trim(SC7->C7_OBS)
End If

dbSelectArea("SC7")
nLinhaD:= MLCount(cDescri,nTamDesc)
nLinhaO:= MLCount(cObs,30)
nLinha := nLinhaD
oPrn:Say( li, CalcCol(0430) , MemoLine(cDescri,nTamDesc,1) ,oFont4,100 )

ImpCampos()

For nBegin := 2 To nLinha
	li+=50             
	If nLinhaD>=nBegin
	  //oPrn:Say( li, 0430, MemoLine(cDescri,nTamDesc,1) ,oFont4,100 ) 
	  oPrn:Say( li, CalcCol(0430) , MemoLine(cDescri,nTamDesc,nBegin) ,oFont4,100 )
	EndIf
Next nBegin

Return NIL

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpCampos³ Autor ³ André R. Esteves      ³ Data ³03/02/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprimir dados Complementares do Produto no Pedido.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpCampos(Void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpCampos()
Local cNcm
Local cItemCta

dbSelectArea("SC7")   
       
//Busca NCM - Andre R. Esteves - 14/12/2012
cNcm := Trim(Posicione("SB1",1,xFilial("SB1")+SC7->C7_PRODUTO,"SB1->B1_POSIPI"))
oPrn:Say( li, /*1320*/ CalcCol(1365) , cNcm ,oFont6,100,,,2 )

If MV_PAR07 == 2 .And. !Empty(SC7->C7_SEGUM)
   oPrn:Say( li, /*1500*/ CalcCol(1535) , SC7->C7_SEGUM ,oFont6,100,,,2 )
Else
   oPrn:Say( li, /*1510*/ CalcCol(1535) , SC7->C7_UM ,oFont6,100,,,2 )
EndIf

If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM) 
   oPrn:Say( li,  CalcCol(1490) , Transform(SC7->C7_QTSEGUM,/*PesqPict("SC7","C7_QUANT",14,mv_par12)*/PesqPict("SC7","C7_QUANT")) ,oFont6c,100,,,2 ) // 1400
Else
   oPrn:Say( li, CalcCol(1490) , Transform(SC7->C7_QUANT,/*PesqPict("SC7","C7_QUANT",14,mv_par12)*/ PesqPict("SC7","C7_QUANT")) ,oFont6c,100,,,2 )  // 1400
EndIf

If MV_PAR07 == 2 .And. !Empty(SC7->C7_QTSEGUM)  
   oPrn:Say( li,  CalcCol(1720)  , Transform(xMoeda((SC7->C7_TOTAL/SC7->C7_QTSEGUM),SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),/*PesqPict("SC7","C7_FRETE",14, mv_par12)*/PesqPict("SC7","C7_FRETE")) ,oFont6c,100/*,,,2*/ ) 
Else
   oPrn:Say( li, CalcCol(1720)   , Transform(xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),/*PesqPict("SC7","C7_FRETE",14,mv_par12)*/PesqPict("SC7","C7_FRETE")) ,oFont6c,100/*,,,2*/ )
EndIf
                             
//oPrn:Say( li, 1630, Transform(SC7->C7_DESC1,PesqPict("SC7","C7_DESC1",16,mv_par12)) ,oFont6c,100 )
oPrn:Say( li, CalcCol(2050) 	, Transform(SC7->C7_IPI,/*PesqPict("SC7","C7_IPI",16,mv_par12)*/PesqPict("SC7","C7_IPI")) ,oFont6c,100/*,,,2*/ ) 
oPrn:Say( li, CalcCol(2150)  , Transform(xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),PesqPict("SC7","C7_FRETE",14,mv_par12)) ,oFont6c,100/*,,,2*/ )
oPrn:Say( li, /*2433*/ CalcCol(2550) , DateToC(SC7->C7_DATPRF) ,oFont6c,100,,,2 )
oPrn:Say( li, /*2750*/ CalcCol(2835) , Transform(SC7->C7_CC     ,PesqPict("SC7","C7_CC",16,mv_par12)) ,oFont6c,100,,,2 ) 

cItemCta := AllTrim(SC7->C7_ITEMCTA)
If !Empty(cItemCta)
	If Len(cItemCta) > 6           
		oPrn:Say( li, /*2750*/ CalcCol(3030) , cItemCta ,oFont11c,100,,,2 ) 	
	Else	
		//cItemCta := PadL(cItemCta,6)
		oPrn:Say( li, /*2750*/ CalcCol(3040) , cItemCta ,oFont6c,100,,,2 ) 		
	EndIf
EndIf
oPrn:Say( li, /*3106*/ CalcCol(3235) , Transform(SC7->C7_NUMSC  ,PesqPict("SC7","C7_NUMSC",16,mv_par12)) ,oFont6c,100,,,2 ) 

nTotal  :=nTotal+SC7->C7_TOTAL
nTotMerc:=MaFisRet(,"NF_TOTAL")
nTotDesc+=SC7->C7_VLDESC



Return .T.  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ImpRodape³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime o rodape do formulario e salta para a proxima folha³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ ImpRodape(Void)   			         					  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 					                     				      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ImpRodape()

oPrn:Say( 1760, CalcCol(0070) , "CONTINUA ..." ,oFont3,100 )

Return .T. 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FinalPed ³ Autor ³ Wagner Xavier         ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime os dados complementares do Pedido de Compra        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FinalPed(Void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MatR110                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FinalPed()

Local nk 		:= 1,nG
Local nQuebra	:= 0
Local lNewAlc	:= .F.
Local lLiber 	:= .F.
Local lImpLeg	:= .T.
//Local cComprador:=""
//LOcal cAlter	:=""
//Local cAprova	:=""
//Local cCompr	:=""
Local aColuna   := Array(8), nTotLinhas 
Local nTotIpi	:= MaFisRet(,'NF_VALIPI')
Local nTotIcms	:= MaFisRet(,'NF_VALICM')
Local nTotDesp	:= MaFisRet(,'NF_DESPESA')
Local nTotFrete	:= MaFisRet(,'NF_FRETE')
Local nTotalNF	:= MaFisRet(,'NF_TOTAL')
Local nTotSeguro:= MaFisRet(,'NF_SEGURO')
Local aValIVA   := MaFisRet(,"NF_VALIMP")
nPag :=0

//Rodape
oPrn:Box( 1730, CalcCol(0010) , 1950,CalcCol(1820) ) //Box Local entrega
oPrn:Box( 1730, CalcCol(1820) , 1950,CalcCol(2550) ) //Box Impostos
oPrn:Box( 1730, CalcCol(2550) , 1950,CalcCol(3340) ) //Box SubTotal
oPrn:Box( 1840, CalcCol(2550) , 1950,CalcCol(3340) ) //Box Total
oPrn:Box( 1950, CalcCol(0010) , 2220,CalcCol(1820) ) //Box Observações
oPrn:Box( 1950, CalcCol(1820) , 2220,CalcCol(3340) ) //Box Nota  
oPrn:Box( 2220, CalcCol(0010) , 2350,/*0610*/ CalcCol(1820) ) //Box Ass. Comprador
//oPrn:Box( 2130, 0610, 2350,1210) //Box Ass. Gerencia
oPrn:Box( 2220, /*1210*/ CalcCol(1820) , 2350,/*1820*/ CalcCol(3340) ) //Box Ass. Diretoria 
//oPrn:Box( 2130, 1820, 2350,2633) //Box Lib. Pedido
//oPrn:Box( 2130, 2633, 2350,3340) //Box Obs. do frete
If cPaisLoc <> "BRA" .And. !Empty(aValIVA)
   For nG:=1 to Len(aValIVA)
       nValIVA+=aValIVA[nG]
   Next
Endif

oPrn:Say( 1765, CalcCol(2580) , "SUB TOTAL:        "/*+Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR"))*/ ,oFont9,100 )
oPrn:Say( 1765, /* 2880 */ CalcCol(3340 - 30 * Len(Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotal,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotal,14,MsDecimais(MV_PAR12)))))), Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotal,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotal,14,MsDecimais(MV_PAR12)))) ,oFont9c,100 )
                         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessar o Endereco para Entrega do Arquivo de Empresa SM0.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAlias := Alias()
dbSelectArea("SM0")
dbSetOrder(1)   // forca o indice na ordem certa
nRegistro := Recno()
dbSeek(SUBS(cNumEmp,1,2)+SC7->C7_FILENT)

oPrn:Say( 1750, CalcCol(0050) , "LOCAL DE ENTREGA: " ,oFont3,100 )  
If Empty(MV_PAR13)
   oPrn:Say( 1750, /*0420*/ CalcCol(0490) , UPPER(SM0->M0_ENDENT) ,oFont4,100 )
   oPrn:Say( 1750, CalcCol(1230) , UPPER("CEP: "+Trans(SM0->M0_CEPENT,cCepPict)),oFont4,100 )
   oPrn:Say( 1750, CalcCol(1450) , "-" ,oFont4,100 )
   oPrn:Say( 1750, CalcCol(1540) , UPPER(Alltrim(SM0->M0_CIDENT)) ,oFont4,100 )
Else
   oPrn:Say( 1750, /*0420*/ CalcCol(0490) , Upper(Alltrim(MV_PAR13)) ,oFont4,100 )
EndIf

dbGoto(nRegistro)
dbSelectArea( cAlias )

oPrn:Say( 1795,CalcCol(0050) , "LOCAL DE COBRANCA: ",oFont3,100 )
oPrn:Say( 1795, /*0420*/ CalcCol(0490) , SM0->M0_ENDCOB ,oFont4,100 )
oPrn:Say( 1795, CalcCol(1230) , UPPER("CEP: "+Trans(SM0->M0_CEPCOB,cCepPict)),oFont4,100 )
oPrn:Say( 1795, CalcCol(1450) , "-" ,oFont4,100 )
oPrn:Say( 1795, CalcCol(1540) , Alltrim(SM0->M0_CIDCOB) ,oFont4,100 )

dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(xFilial()+SC7->C7_COND)
dbSelectArea("SC7")

oPrn:Say( 1840, CalcCol(0050) , "CONDICAO DE PAGTO:",oFont3,100 ) 
oPrn:Say( 1840, /*0420*/ CalcCol(0490) , Alltrim(SubStr(SE4->E4_DESCRI,1,15)),oFont4,100 )

oPrn:Say( 1840, CalcCol(1230) ,  "TIPO DE FRETE: ",oFont3,100 )
oPrn:Say( 1840, CalcCol(1530) , IF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF"," " )),oFont4c,100 )

oPrn:Say( 1870, CalcCol(2580) , "TOT IMPOSTOS: ",oFont9,100 )
oPrn:Say( 1870, /* 2880 */ CalcCol(3340 - 30 * Len(Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotMerc,14,MsDecimais(MV_PAR12)))))) , Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotMerc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotMerc,14,MsDecimais(MV_PAR12)))),oFont9c,100 )                         
                             
dbSelectArea("SM4")
dbSetOrder(1)
dbSelectArea("SC7")

//oPrn:Say( 1885, 0050, "REAJUSTE :",oFont3,100 )
oPrn:Say( 1750, CalcCol(1850) , "IPI :" ,oFont3,100 )
oPrn:Say( 1750, CalcCol(2050) , Transform(xMoeda(nTotIPI,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotIpi,14,MsDecimais(MV_PAR12))) ,oFont4c,100 )
//oPrn:Say( 1780, 1850, "ICMS :" ,oFont3,100 )
//oPrn:Say( 1780, 2050, Transform(xMoeda(nTotIcms,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotIcms,14,MsDecimais(MV_PAR12))) ,oFont4c,100 )
oPrn:Say( 1795, CalcCol(1850) , "FRETE :" ,oFont3,100 )
oPrn:Say( 1795, CalcCol(2050) , Transform(xMoeda(nTotFrete,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotFrete,14,MsDecimais(MV_PAR12))) ,oFont4c,100 )
//oPrn:Say( 1840, 1850, "Seguro :" ,oFont3,100 )
//oPrn:Say( 1840, 2050, Transform(xMoeda(nTotSeguro,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotSeguro,14,MsDecimais(MV_PAR12))) ,oFont4c,100 ) 
oPrn:Say( 1840, CalcCol(1850) , "DESPESAS:" ,oFont3,100 )
oPrn:Say( 1840, CalcCol(2050) , Transform(xMoeda(nTotDesp,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotDesp,14,MsDecimais(MV_PAR12))) ,oFont4c,100 )
oPrn:Say( 1885, CalcCol(1850) , "DESCONTO:" ,oFont3,100 )
oPrn:Say( 1885, CalcCol(2050) , Transform(xMoeda(nTotDesc,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotSeguro,14,MsDecimais(MV_PAR12))) ,oFont4c,100 )
oPrn:Say( 1965, CalcCol(0050) , "OBSERVACOES:",oFont3,100 ) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Didive as observacoes em linhas para a impressao             ³
//³ Serao criadas as variaveis cObs?? ate o numero definido em   ³
//³ nNumDiv                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nNumDiv := 5 // Numero de linhas para impressao
nObs := 1

For nObs := 1 To nNumDiv
    cVar := "cObs"+StrZero(nObs,2)
    Eval(MemVarBlock(cVar),Substr(cObs,(65*(nObs-1))+1,65))
Next nObs
oPrn:Say( 1970, CalcCol(0350), cObs01,oFont4c,100 ) 
oPrn:Say( 2010, CalcCol(0350) , cObs02,oFont4c,100 )
oPrn:Say( 2050, CalcCol(0350) , cObs03,oFont4c,100 )
oPrn:Say( 2090, CalcCol(0350) , cObs04,oFont4c,100 )
oPrn:Say( 2130, CalcCol(0350) , cObs05,oFont4c,100 )


oPrn:Say( 1960, CalcCol(1830) ,  " NOTAS: ",oFont3,100) // oFont7,100 )
oPrn:Say( 2000, CalcCol(1840) ,  "1. So aceitaremos a mercadoria, se na sua Nota Fiscal constar o numero de nosso pedido de compras.",oFont6,100)// oFont3,100 )
//oPrn:Say( 1990, 1920,  " o número de nosso pedido de compras.",oFont4c,100 )

//oPrn:Say( 2035, 1840,  "2. Os produtos comprados pela ALPAX atraves do presente Pedido de Compra, deverao ser entregues na quantidade ",oFont6,100) 
//oPrn:Say( 2065, 1840,  "   apresentada e/ou informada por nossa empresa, observando-se os termos dos Artigos 441, 442 e 484 conforme ",oFont6,100) 
//oPrn:Say( 2095, 1840,  "   Codigo Civil Lei 10406/02, sob pena de indenizacao, conforme o previsto no Artigo 186 deste mesmo diploma legal.",oFont6,100)

oPrn:Say( 2035, CalcCol(1840) ,  "2. Os produtos comprados pela ALPAX atraves do presente Pedido de Compra, deverao ser entregues na quantidade",oFont6,100) 
oPrn:Say( 2065, CalcCol(1840) ,  "    apresentada  e/ou  informada  por nossa empresa, observando-se os termos dos  Artigos 441, 442 e 484 conforme",oFont6,100) 
oPrn:Say( 2095, CalcCol(1840) ,  "    Codigo Civil Lei 10406/02, sob pena de indenizacao, conforme o previsto no Artigo 186 deste mesmo diploma legal.",oFont6,100)

oPrn:Say( 2130, CalcCol(1840) ,  "3. O arquivo XML dever� ser enviado no m�nimo com 1 dia de anteced�ncia.",oFont6,100)             

oPrn:Say( 2165, CalcCol(1840) ,  "4. A classifica��o fiscal dever� estar de acordo com o pedido de compra.",oFont6,100) 

//oPrn:Say( 2260, 0050,  "_________________________",oFont4c,100 )
//oPrn:Say( 2300, 0200,  "Comprador",oFont3,100 )
oPrn:Say( 2280, /*0650*/ CalcCol(0725) ,  "_________________________",oFont4c,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
oPrn:Say( 2320, /*0820*/ CalcCol(0905) ,  "COMPRADOR",oFont3b,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
//oPrn:Say( 2260, 1260,  "_________________________",oFont4c,100 )
//oPrn:Say( 2300, 1430,  "Diretoria",oFont3,100 )
oPrn:Say( 2280, /*1860*/ /*2320*/ CalcCol(2300) ,  "__________________________________",oFont4c,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
oPrn:Say( 2320, /*2120*/ /*2580*/ CalcCol(2580) ,  "DIRETORIA",oFont3b,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
//oPrn:Say( 2220, 2750,  "Obs. do Frete: ",oFont3,100 )
//oPrn:Say( 2220, 3050, IF( SC7->C7_TPFRETE $ "F","FOB",IF(SC7->C7_TPFRETE $ "C","CIF"," " )),oFont4c,100 )
                                                                      
Return .T.

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ENVEMAIL ³ Autor ³ Daniel G.Jr.TI1239    ³ Data ³ 07/11/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envia e-mail da Cotação para o Fornecedor                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico Krill                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function EnvEmail()

Local cServer   := "Endereco do servidor smtp"
Local cAccount  := 'Conta para login no servidor smtp'
Local cEnvia    := 'endereco de e-mail do remetente'
Local cCopia    := 'endereco de e-mail para receber copia do e-mail'
Local cRecebe   
Local cPassword := 'digite aqui a senha do servidor smtp'
Local aFiles    := {}                                                                 
Local nI        := 1
Local cMensagem := ''
Local cTos
//Local CRLF      := CRLF
Local cBuffer, nHandle, nBytes:=0, nTamArq
Local cArqS, cArqD, cSubject, lEnviado

cMensagem := 'Encaminhamos a esta conceituosa empresa nosso pedido de Compra abaixo, conforme'+ CRLF+;
			 'seu retorno sobre nossa cotacao N� '+nNumCotacao +CRLF+CRLF +;
			 'No Aguardo da confirmacao de recebimento, bem como condicao e data de entrega.'+ CRLF+CRLF+;
			 'Subscrevemos-nos'+CRLF+;
			 'ALPAX'+CRLF
			 
CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lConectou

For _nI:=1 to Len(aEmail)

   	cArqD    := "" //".\RELATO\COMPRAS\COTAKRILL_PAG"+Str(aEmail[_nI,1],1)+".JPG"
	cRecebe  := aEmail[_nI,2]
	cSubject := aEmail[_nI,3]
	lEnviado := .F.
                        
	MAILAUTH(cEnvia,cPassword)

	SEND MAIL FROM cEnvia ;
		        TO cRecebe ;
	    	    CC cCopia ;
	       SUBJECT cSubject ;
		      BODY cMensagem + CRLF + cMsg ;
	    ATTACHMENT cArqD;
    	    RESULT lEnviado

	If lEnviado 
		//	Alert("Enviado E-Mail")
	Else
		cMensagem := ""
		GET MAIL ERROR cMensagem
		Alert(cMensagem)
	Endif

	fErase(cArqD)

Next _nI

DISCONNECT SMTP SERVER Result lDisConectou

If lDisConectou
	//	Alert("Desconectado com servidor de E-Mail - " + cServer)
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Funcao   ³VALIDPERG ³ Autor³Adalberto Moreno Batista³ Data ³11.02.2000³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÝÄÄÄÄÄÄÝÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()

Local _aAlias := Alias(), aRegs

dbSelectArea("SX1")
dbSetOrder(1)
aRegs:={}
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01","Do Pedido ?","¿De Pedido?","From Order ?","mv_ch1","C",6,0,0,"G","","mv_par01","","","","000068","","","","","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"02","Ate o Pedido ?","¿A  Pedido?","To Order ?","mv_ch2","C",6,0,0,"G","","mv_par02","","","","000068","","","","","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"03","A partir da Data ?","¿De Fecha?","From Date ?","mv_ch3","D",8,0,0,"G","","mv_par03","","","","'01/01/2002'","","","","","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"04","Ate a Data ?","¿A  Fecha?","To Date ?","mv_ch4","D",0,0,0,"G","","mv_par04","","","","'26/12/2003'","","","","","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"05","Somente os novos ?","¿Solo los Nuevos?","Only the new ones ?","mv_ch5","N",1,0,2,"C","","mv_par05","Sim","Si","Yes","","","Nao","No","No","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"06","Descricao Produto ?","¿Descripcion Prodc.?","Product Description ?","mv_ch6","N",10,0,4,"C","","mv_par06","B1_DESC","","","","","B5_CEME","","","","","C7_DESCRI","","","","","C1_DESCRI","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"07","Qual Unid. de Med. ?","¿Cual Unidad Medida?","Which Unit of Meas. ?","mv_ch7","N",1,0,1,"C","","mv_par07","Primaria","Primaria","Primary","","","Secundaria","Secundaria","Secondary","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"08","Imprime ?","¿Imprime?","Print ?","mv_ch8","N",1,0,1,"C","","mv_par08","Pedido Compra","Pedido Compra","Purchase Order","","","Aut. de Entrega","Aut. de Entrega","Delivery Author","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"09","Numero de Vias ?","¿Numero de Copias?","Number of Copies ?","mv_ch9","N",2,0,0,"G","","mv_par09","","",""," 1","","","","","","","","","","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"10","Imprime Pedidos ?","¿Imprime Pedidos?","Print Orders ?","mv_cha","N",1,0,3,"C","","mv_par10","Liberados","Aprobados","Approved","","","Bloqueados","Bloqueados","Blocked","","","Ambos","Ambos","Both","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"11","Considera SCs ?","¿Considerar SCs?","Consider Purc.Req. ?","mv_chb","N",1,0,3,"C","","mv_par11","Firmes","Confirmadas","Confirmed","","","Previstas","Previstas","Expected","","","Ambas","Ambos","Both","","","","","","","","","","","","","S","",""})
aAdd(aRegs,{cPerg,"12","Qual Moeda ?","¿Cual Moneda?","Currency ?","mv_chc","N",1,0,1,"C","","mv_par12","Moeda 1","Moneda 1","Currency 1","","","Moeda 2","Moneda 2","Currency 2","","","Moeda 3","Moneda 3","Currency 3","","","Moeda 4","Moneda 4","Currency 4","","","Moeda 5","Moneda 5","Currency 5","","","S","",""})
aAdd(aRegs,{cPerg,"13","Endereco de Entrega ?","Local de Entrega","Delivery Address","mv_chd","C",40,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
//aAdd(aRegs,{cPerg,"14","Destino?","","","mv_che","N",1,0,2,"C","","mv_par14","Impressora","","","","","e-mail","","","","","","","","","","","","","","","","","","","","S","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+'    '+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next
dbSelectArea(_aAlias)

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �R110FIniPC� Autor � Edson Maricate        � Data �20/05/2000���
�������������������������������������������������������������������������Ĵ��
���Descricao � Inicializa as funcoes Fiscais com o Pedido de Compras      ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � R110FIniPC(ExpC1,ExpC2)                                    ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpC1 := Numero do Pedido                                  ���
���          � ExpC2 := Item do Pedido                                    ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � MATR110,MATR120,Fluxo de Caixa                             ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function R110FIniPC(cPedido,cItem,cSequen,cFiltro)
Local aArea		:= GetArea()
Local aAreaSC7	:= SC7->(GetArea())
Local cValid	:= ""
Local nPosRef	:= 0
Local nItem		:= 0
Local cItemDe	:= IIf(cItem==Nil,'',cItem)
Local cItemAte	:= IIf(cItem==Nil,Repl('Z',Len(SC7->C7_ITEM)),cItem)
Local cRefCols	:= ""
DEFAULT cSequen	:= ""
DEFAULT cFiltro	:= ""

dbSelectArea("SC7")
dbSetOrder(1)
If dbSeek(xFilial("SC7")+cPedido+cItemDe+Alltrim(cSequen))
	MaFisEnd()
	MaFisIni(SC7->C7_FORNECE,SC7->C7_LOJA,"F","N","R",{})
	While !Eof() .AND. SC7->C7_FILIAL+SC7->C7_NUM == xFilial("SC7")+cPedido .AND. ;
			SC7->C7_ITEM <= cItemAte .AND. (Empty(cSequen) .OR. cSequen == SC7->C7_SEQUEN)

		// Nao processar os Impostos se o item possuir residuo eliminado  
		If &cFiltro
			dbSelectArea('SC7')
			dbSkip()
			Loop
		EndIf
            
		// Inicia a Carga do item nas funcoes MATXFIS  
		nItem++
		MaFisIniLoad(nItem)
		dbSelectArea("SX3")
		dbSetOrder(1)
		dbSeek('SC7')
		While !EOF() .AND. (X3_ARQUIVO == 'SC7')

			If AllTRim(SX3->X3_CAMPO) == "C7_OPER"
				SX3->(DbSkip())
				Loop
			Endif

			cValid	:= StrTran(UPPER(SX3->X3_VALID)," ","")
			cValid	:= StrTran(cValid,"'",'"')
			If "MAFISREF" $ cValid
				nPosRef  := AT('MAFISREF("',cValid) + 10
				cRefCols := Substr(cValid,nPosRef,AT('","MT120",',cValid)-nPosRef )
				// Carrega os valores direto do SC7.           
				MaFisLoad(cRefCols,&("SC7->"+ SX3->X3_CAMPO),nItem)
			EndIf
			dbSkip()
		End
		MaFisEndLoad(nItem,2)
		dbSelectArea('SC7')
		dbSkip()
	End
EndIf

RestArea(aAreaSC7)
RestArea(aArea)

Return .T.
//-----------------------------------------------------------------------------
Static Function DateToC(dData)
Local cData := DToS(dData) 
Return SubStr(cData,7,2) +"/"+ SubStr(cData,5,2) +"/"+ SubStr(cData,3,2)

                                                              
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RCOMR03   �Autor  �Marcio           � Data �  03/09/21   ���
�������������������������������������������������������������������������͹��
���Desc.     �Recalcula colunas ap�s transformar fun��o de TMSPrinter em  ���
���          �FWMSPrinter                                                 ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CalcCol(nPosOri)

nPosOri -= 70 
nNewCol := nPosOri - (0.05 * nPosOri)

Return nNewCol
