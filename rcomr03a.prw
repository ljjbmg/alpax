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

User Function RCOMR03a() 

SetPrvt("CDESC1,CDESC2,CDESC3,COBS,COBS01,COBS02,COBS03,COBS04,COBS05,_CSTRING,AORD,J")
SetPrvt("oFont1,oFont2,oFont3,oFont3n,oFont4,oFont5,oFont6,oFont7")
Private  nPag  	:= 1
Private  nPagd 	:= 0
Private cNumPed := SC7->C7_NUM
Private dEmissao:= SC7->C7_EMISSAO
Private aEmail 	:= {}
Private cPFornec
Private cEmailForn
Private cEmailNome 
Private cFornece
Private lAbortPrint := .F.

Processa( {|| Relato(cNumPed,dEmissao)	},"Aguarde..." , " Gerando Pedido de Compra", .T.)

Return


Static Function Relato()

Local cQuery
Local cAliasSql
Local nReem
Local nOrder
Local cCondBus
Local nSavRec
Local aSavRec := {}
Local cServer := GetSrvProfString("ROOTPATH","") + "\spool\boleto\" 
Private lEnc  := .f.
Private cTitulo
Private oFont, cCode, oPrn
Private cCGCPict, cCepPict    
Private lPrimPag :=.t.
Private cPerg   :="MTR11G", cMsg, nLinha, nLinhaD, nLinhaO, cObs, cDir, cArq


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
cArq  := "PC" + DTOS(Date()) + StrTran(Time(),":","")
oPrn  := FWMSPrinter():New("PC" + DTOS(Date()) + StrTran(Time(),":",""),IMP_PDF, .T.,, .T.,.T.,,,,,, .F.)   
oPrn:SetViewPDF(.F.)
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
cCondBus := cNumPed
nOrder	 :=	1
nRegs    := 0 
nPed     := 0 
cObs     := "Horario de Recebimento 08:15/11:30 e das 13:00/17:00 seg a sexta. " //Andre R. Esteves - 10/04/2018
cObs	 := cObs + "Produtos com validade inferior h� 1 ano s� ser�o aceitos com autoriza��o do setor de compras."

cQuery := "SELECT "
cQuery += "SC7.R_E_C_N_O_ RECSC7,C7_FILIAL,C7_NUM,C7_ITEM,C7_SEQUEN "
cQuery += "FROM "+RetSQLName("SC7")+" SC7 "
cQuery += "WHERE "
cQuery += "SC7.D_E_L_E_T_ =' ' "
cQuery += "AND C7_NUM    >='"+cNumPed+"' "
cQuery += "AND C7_NUM    <='"+cNumPed+"' "
//cQuery += "AND C7_EMISSAO>='"+DToS(dEmissao)+"' "
//cQuery += "AND C7_EMISSAO<='"+DToS(dEmissao)+"' "         
cQuery += "ORDER BY "
cQuery += "C7_FILIAL,C7_NUM,C7_ITEM,C7_SEQUEN"

cQuery    := ChangeQuery(cQuery)
cAliasSql := GetNextAlias()
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSql,.F.,.F.)

dbSelectArea("SC7")
dbSetOrder(nOrder)
ProcRegua(RecCount())

If (cAliasSql)->(!EOF())
	SC7->(dbGoTo( (cAliasSql)->RECSC7 ))
Else
	SC7->(dbSeek(xFilial("SC7")+cCondBus,.T.))
EndIf                                         
(cAliasSql)->(dbCloseArea())

dbSelectArea("SC7")
dbSetOrder(1)
dbseek(xFilial("SC7")+cNumPed)

nOrdem   := 1
nReem    := 0

MaFisEnd()
R110FIniPC(SC7->C7_NUM)
  
//Calculo de numero de páginas
//*********************************************************************************************
nPed := SC7-> C7_NUM
Set Filter to SC7->C7_NUM== nPed 
Count to nRegs
nPagd := (nRegs + 19)/20 
Set Filter To

dbSeek(xFilial("SC7")+nPed) 

oPrn:StartPage()
ImpCabec()
		
nTotal   := 0
nTotMerc	:= 0
nDescProd:= 0
nReem    := SC7->C7_QTDREEM + 1
nSavRec  := SC7->(Recno())
li       := 590        
nTotDesc := 0
cFornece := SC7->(C7_FORNECE+C7_LOJA)
lAprov	 := SC7->C7_CONAPRO <> "B"

	While !Eof() .And. SC7->C7_FILIAL = xFilial("SC7") .And. SC7->C7_NUM == cNumPed .And. !lAbortPrint
		
		dbSelectArea("SC7")
		If Ascan(aSavRec,Recno()) == 0		// Guardo recno p/gravacao
			AADD(aSavRec,Recno())
		Endif
			
		IncProc("Pedido: "+SC7->C7_NUM)			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se havera salto de formulario                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  	If li > 1620
			nOrdem++
		   oPrn:EndPage() 	
		   oPrn:StartPage()	
			ImpRodape()			
			ImpCabec()
			li  := 590  
		Endif
			
		li:=li+60
			
	 	oPrn:Say( li, /*0070*/ CalcCol(0065), StrZero(Val(SC7->C7_ITEM),2),oFont4,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
		oPrn:Say( li, /*0165*/ CalcCol(0147) , AllTrim(UPPER(SC7->C7_AXPART)),oFont4,100,,,2) 

		ImpProd()

		If SC7->C7_DESC1 != 0 .or. SC7->C7_DESC2 != 0 .or. SC7->C7_DESC3 != 0
			nDescProd+= CalcDesc(SC7->C7_TOTAL,SC7->C7_DESC1,SC7->C7_DESC2,SC7->C7_DESC3)
		Else
			nDescProd+=SC7->C7_VLDESC
		Endif

		dbSkip()
	EndDo
		
	

	FinalPed(cNumPed)	
	oPrn:Print()	
    oPrn:EndPage()
	MaFisEnd()
	aSavRec := {}
	

dbSelectArea("SC7")
Set Filter To
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

If lEnc
   MS_FLUSH()
EndIf

cMailFor := Alltrim(SA2->A2_EMAIL)
cNomeFor := Alltrim(SA2->A2_NOME)
			
WFtoFor(cNumPed,cMailFor,cNomeFor,cDir,cArq)	

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
LOcal cAlter	:=""
Local cAprova	:=""
Local cCompr	:=""

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

//oPrn:SayBitmap(0250,020,cLogo,235,235)//oPrn:SayBitmap( 0225, CalcCol(0245) ,"\system\alpax.bmp",0313,0245)
oPrn:SayBitmap(0230,005,cLogo,300,310)//oPrn:SayBitmap( 0225, CalcCol(0245) ,"\system\alpax.bmp",0313,0245)

//Cabecalho Produto do Pedido
/*
oPrn:Box( 0545, CalcCol(0010) , 0605,CalcCol(0140) ) //BOX ITEM
oPrn:Box( 0545, CalcCol(0140) , 0605,CalcCol(0410) ) //BOX CÓDIGO
oPrn:Box( 0545, CalcCol(0410) , 0605,CalcCol(1300) ) //BOX DESCRIÇÃO
oPrn:Box( 0545, CalcCol(1300) , 0605,CalcCol(1496) ) //BOX NCM
oPrn:Box( 0545, CalcCol(1496) , 0605,CalcCol(1580) ) //BOX UN
oPrn:Box( 0545, CalcCol(1580) , 0605,CalcCol(1760) ) //BOX QTDE - 175
oPrn:Box( 0545, CalcCol(1580) , 0605,CalcCol(1800) ) //BOX QTDE - 175
oPrn:Box( 0545, CalcCol(1760) , 0605,CalcCol(2026) ) //BOX VALOR UNIT - 270
oPrn:Box( 0545, CalcCol(2026) , 0605,CalcCol(2160) ) //BOX % IPI - 135  
oPrn:Box( 0545, CalcCol(2160) , 0605,CalcCol(2450) ) //BOX VALOR TOTAL - 280
oPrn:Box( 0545, CalcCol(2450) , 0605,CalcCol(2710) ) //BOX DATA ENTR - 210
oPrn:Box( 0545, CalcCol(2710) , 0605,CalcCol(2920) ) //BOX CENTRO CUSTO - 290
oPrn:Box( 0545, CalcCol(2920) , 0605,CalcCol(3130) ) //BOX ITEM CONTA. - 290
//oPrn:Box( 0545, CalcCol(3130) , 0605,CalcCol(3340) ) //BOX S.C. - 290

//Espaco dos Itens do Pedido
oPrn:Box( 0605, CalcCol(0010) , 1730,CalcCol(0140) ) //Box Item
oPrn:Box( 0605, CalcCol(0140) , 1730,CalcCol(0410) ) //Box código
oPrn:Box( 0605, CalcCol(0410) , 1730,CalcCol(1300) ) //Box descrição
oPrn:Box( 0605, CalcCol(1300) , 1730,CalcCol(1496) ) //Box NCM
oPrn:Box( 0605, CalcCol(1496) , 1730,CalcCol(1580) ) //Box UM
oPrn:Box( 0605, CalcCol(1580) , 1730,CalcCol(1760) ) //Box Qtde
oPrn:Box( 0605, CalcCol(1760) , 1730,CalcCol(2026) ) //Box Valor Unit
oPrn:Box( 0605, CalcCol(2026) , 1730,CalcCol(2160) ) //Box % IPI
oPrn:Box( 0605, CalcCol(2160) , 1730,CalcCol(2450) ) //Box valor total
oPrn:Box( 0605, CalcCol(2450) , 1730,CalcCol(2710) ) //Box Data entrega
oPrn:Box( 0605, CalcCol(2710) , 1730,CalcCol(2920) ) //Box Centro de custo
oPrn:Box( 0605, CalcCol(2920) , 1730,CalcCol(3130) ) //Box S.C.
//oPrn:Box( 0605, CalcCol(3130) , 1730,CalcCol(3340) ) //Box Item Conta
*/
oPrn:Box( 0545, CalcCol(0010) , 0605,CalcCol(0140) ) //BOX ITEM
oPrn:Box( 0545, CalcCol(0140) , 0605,CalcCol(0410) ) //BOX CÓDIGO
oPrn:Box( 0545, CalcCol(0410) , 0605,CalcCol(1300) ) //BOX DESCRIÇÃO
oPrn:Box( 0545, CalcCol(1300) , 0605,CalcCol(1496) ) //BOX NCM
oPrn:Box( 0545, CalcCol(1496) , 0605,CalcCol(1630) ) //BOX UN
oPrn:Box( 0545, CalcCol(1630) , 0605,CalcCol(1884) ) //BOX QTDE - 175
oPrn:Box( 0545, CalcCol(1884) , 0605,CalcCol(2150) ) //BOX VALOR UNIT - 270
oPrn:Box( 0545, CalcCol(2150) , 0605,CalcCol(2290) ) //BOX % IPI - 135  
oPrn:Box( 0545, CalcCol(2290) , 0605,CalcCol(2580) ) //BOX VALOR TOTAL - 280
oPrn:Box( 0545, CalcCol(2580) , 0605,CalcCol(2870) ) //BOX DATA ENTR - 210
oPrn:Box( 0545, CalcCol(2870) , 0605,CalcCol(3100) ) //BOX CENTRO CUSTO - 290
oPrn:Box( 0545, CalcCol(3100) , 0605,CalcCol(3340) ) //BOX ITEM CONTA. - 290
//oPrn:Box( 0545, CalcCol(3130) , 0605,CalcCol(3340) ) //BOX S.C. - 290

//Espaco dos Itens do Pedido
oPrn:Box( 0605, CalcCol(0010) , 1730,CalcCol(0140) ) //Box Item
oPrn:Box( 0605, CalcCol(0140) , 1730,CalcCol(0410) ) //Box código
oPrn:Box( 0605, CalcCol(0410) , 1730,CalcCol(1300) ) //Box descrição
oPrn:Box( 0605, CalcCol(1300) , 1730,CalcCol(1496) ) //Box NCM
oPrn:Box( 0605, CalcCol(1496) , 1730,CalcCol(1630) ) //Box UM
oPrn:Box( 0605, CalcCol(1630) , 1730,CalcCol(1884) ) //Box Qtde
oPrn:Box( 0605, CalcCol(1884) , 1730,CalcCol(2150) ) //Box Valor Unit
oPrn:Box( 0605, CalcCol(2150) , 1730,CalcCol(2290) ) //Box % IPI
oPrn:Box( 0605, CalcCol(2290) , 1730,CalcCol(2580) ) //Box valor total
oPrn:Box( 0605, CalcCol(2580) , 1730,CalcCol(2870) ) //Box Data entrega
oPrn:Box( 0605, CalcCol(2870) , 1730,CalcCol(3100) ) //Box Centro de custo
oPrn:Box( 0605, CalcCol(3100) , 1730,CalcCol(3340) ) //Box S.C.
//oPrn:Box( 0605, CalcCol(3130) , 1730,CalcCol(3340) ) //Box Item Conta

dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(xFilial()+SC7->C7_FORNECE+SC7->C7_LOJA)

//Titulo
oPrn:Say( 0205, CalcCol(1100) , "PEDIDO DE COMPRA",oFont3,100 )
oPrn:Say( 0210, CalcCol(2395) , "N�",oFont3,100 )
oPrn:Say( 0211, CalcCol(2500) , SC7->C7_NUM,oFont1,100 )
oPrn:Say( 0205, CalcCol(2800) , "1"+"a.VIA" ,oFont3,100 )
oPrn:Say( 0205, CalcCol(3015) , "PA�G.:" ,oFont3,100 )
oPrn:Say( 0205, CalcCol(3182) , Alltrim(StrZero(nPag,2))+" / "+Alltrim(StrZero(nPagD,2)) ,oFont3,100 )

//Itens da Empresa / Fornecedor
//oPrn:Say( 0310, CalcCol(0420) , SubStr(SM0->M0_NOMECOM,1,38) ,oFont3,100 )
oPrn:Say( 0310, CalcCol(0420) , SubStr("ALPAX COM. PRODS. LABS. LTDA",1,38) ,oFont3,100 )
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
oPrn:Say( 0560, /*0165*/ CalcCol(0230) , "PN" ,oFont3,100,,,2 )
oPrn:Say( 0560, /* 0430*/ CalcCol(0790) , "DESCRICAO" ,oFont3,100,,,2 )   
oPrn:Say( 0560, /*1350*/ CalcCol(1370) , "NCM" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*1510*/ CalcCol(1540) , "UN" ,oFont3,100,,,2 )
//oPrn:Say( 0560, /*1600*/ CalcCol(1648) , "QTD"  ,oFont3,100,,,2 )
oPrn:Say( 0560, /*1600*/ CalcCol(1725) , "QTD"  ,oFont3,100,,,2 )

oPrn:Say( 0560, /*1753*/ CalcCol(1950) , "VL UNIT" ,oFont3,100,,,2 )
//oPrn:Say( 0560, 1821, "%Desc" ,oFont3,100 )
oPrn:Say( 0560, /*2006*/ CalcCol(2180) , "IPI%" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2141*/ CalcCol(2340) , "VL TOTAL" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2383*/ CalcCol(2660) , "DT ENTR." ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2680*/ CalcCol(2920) , "C.CUSTO" ,oFont3,100,,,2 )
oPrn:Say( 0560, /*2680*/ CalcCol(3150) , "ITEM CTA" ,oFont3,100,,,2 )
//oPrn:Say( 0560, /*3036*/ CalcCol(3220) , "SC" ,oFont3,100,,,2 )

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
LOCAL  nBegin := 0, cDescri := "", nLinha:=0,;
		nTamDesc := 50, aColuna := Array(8)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao da descricao generica do Produto.                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDescri := If(Empty(cDescri),Trim(SC7->C7_DESCRI),cDescri)  	// opcao 3
cDescri += "-"+Trim(Posicione("SB1",1,xFilial("SB1")+SC7->C7_PRODUTO,"SB1->B1_CAPACID"))
cDescri += "-MARCA:"+Trim(Posicione("SB1",1,xFilial("SB1")+SC7->C7_PRODUTO,"SB1->B1_MARCA"))

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
Local cNcmf
Local cItemCta

dbSelectArea("SC7")   
       
//Busca NCM - Andre R. Esteves - 14/12/2012
cNcm := Trim(Posicione("SB1",1,xFilial("SB1")+SC7->C7_PRODUTO,"SB1->B1_POSIPI"))
oPrn:Say( li, /*1320*/ CalcCol(1365) , cNcm ,oFont6,100,,,2 )

If !Empty(SC7->C7_UM)
   oPrn:Say( li, /*1500*/ CalcCol(1550) , SC7->C7_UM ,oFont6,100,,,2 )
Else
   oPrn:Say( li, /*1510*/ CalcCol(1550) , SC7->C7_SEGUM ,oFont6,100,,,2 )
EndIf

If !Empty(SC7->C7_QUANT) 
   oPrn:Say( li,  CalcCol(1620) , Transform(SC7->C7_QUANT,PesqPict("SC7","C7_QUANT")) ,oFont6c,100,,,2 ) // 1400
Else
   oPrn:Say( li, CalcCol(1620) , Transform(SC7->C7_QTSEGUM,PesqPict("SC7","C7_QUANT")) ,oFont6c,100,,,2 )  // 1400
EndIf

If !Empty(SC7->C7_QUANT)  
   //oPrn:Say( li,  CalcCol(1880)  , Transform(xMoeda((SC7->C7_TOTAL/SC7->C7_QTSEGUM),SC7->C7_MOEDA,1,SC7->C7_DATPRF),PesqPict("SC7","C7_FRETE")) ,oFont6c,100/*,,,2*/ ) 
   oPrn:Say( li, CalcCol(1880)   , Transform(xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,1,SC7->C7_DATPRF),PesqPict("SC7","C7_FRETE")) ,oFont6c,100/*,,,2*/ )
Else
   //oPrn:Say( li, CalcCol(1880)   , Transform(xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,1,SC7->C7_DATPRF),PesqPict("SC7","C7_FRETE")) ,oFont6c,100/*,,,2*/ )
   oPrn:Say( li,  CalcCol(1880)  , Transform(xMoeda((SC7->C7_TOTAL/SC7->C7_QTSEGUM),SC7->C7_MOEDA,1,SC7->C7_DATPRF),PesqPict("SC7","C7_FRETE")) ,oFont6c,100/*,,,2*/ ) 
EndIf
                             
oPrn:Say( li, CalcCol(2180) 	, Transform(SC7->C7_IPI,PesqPict("SC7","C7_IPI")) ,oFont6c,100/*,,,2*/ ) 
oPrn:Say( li, CalcCol(2310)  , Transform(xMoeda(SC7->C7_TOTAL,SC7->C7_MOEDA,1,SC7->C7_DATPRF),PesqPict("SC7","C7_FRETE",14,1)) ,oFont6c,100/*,,,2*/ )
oPrn:Say( li, /*2433*/ CalcCol(2640) , DateToC(SC7->C7_DATPRF) ,oFont6c,100,,,2 )
oPrn:Say( li, /*2750*/ CalcCol(2920) , Transform( SC7->C7_CC   ,PesqPict("SC7","C7_CC",16,1)) ,oFont6c,100,,,2 ) 

cItemCta := AllTrim(SC7->C7_ITEMCTA)
If !Empty(cItemCta)
	If Len(cItemCta) > 6           
		oPrn:Say( li, /*2750*/ CalcCol(3150) , cItemCta ,oFont11c,100,,,2 ) 	
	Else	
		//cItemCta := PadL(cItemCta,6)
		oPrn:Say( li, /*2750*/ CalcCol(3150) , cItemCta ,oFont6c,100,,,2 ) 		
	EndIf
EndIf

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
Local nTotIpi	:= MaFisRet(,'NF_VALIPI')
Local nTotIcms	:= MaFisRet(,'NF_VALICM')
Local nTotDesp	:= MaFisRet(,'NF_DESPESA')
Local nTotFrete	:= MaFisRet(,'NF_FRETE')
Local nTotalNF	:= MaFisRet(,'NF_TOTAL')
Local nTotSeguro:= MaFisRet(,'NF_SEGURO')
Local aValIVA   := MaFisRet(,"NF_VALIMP")
Local nTotIcmsSt:= MaFisRet(,"NF_VALSOL")
nPag :=0

dbSelectArea("SC7")
dbSetOrder(1)
dbseek(xFilial("SC7")+cNumPed)

//Rodape
oPrn:Box( 1730, CalcCol(0010) , 1950,CalcCol(1820) ) //Box Local entrega
oPrn:Box( 1730, CalcCol(1820) , 1950,CalcCol(2550) ) //Box Impostos
oPrn:Box( 1730, CalcCol(2550) , 1950,CalcCol(3340) ) //Box SubTotal
oPrn:Box( 1840, CalcCol(2550) , 1950,CalcCol(3340) ) //Box Total
oPrn:Box( 1950, CalcCol(0010) , 2280,CalcCol(1820) ) //Box Observações 	2220
oPrn:Box( 1950, CalcCol(1820) , 2280,CalcCol(3340) ) //Box Nota  			2220
oPrn:Box( 2280, CalcCol(0010) , 2410,/*0610*/ CalcCol(1820) ) //Box Ass. Comprador   2350
//oPrn:Box( 2130, 0610, 2350,1210) //Box Ass. Gerencia
oPrn:Box( 2280, /*1210*/ CalcCol(1820) , 2410,/*1820*/ CalcCol(3340) ) //Box Ass. Diretoria 
//oPrn:Box( 2130, 1820, 2350,2633) //Box Lib. Pedido
//oPrn:Box( 2130, 2633, 2350,3340) //Box Obs. do frete
If cPaisLoc <> "BRA" .And. !Empty(aValIVA)
   For nG:=1 to Len(aValIVA)
       nValIVA+=aValIVA[nG]
   Next
Endif

oPrn:Say( 1765, CalcCol(2580) , "SUB TOTAL:        " ,oFont9,100 )
oPrn:Say( 1765, /* 2880 */ CalcCol(3340 - 30 * Len(Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotal,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotal,14,MsDecimais(1)))))), Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotal,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotal,14,MsDecimais(1)))) ,oFont9c,100 )
                         
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Acessar o Endereco para Entrega do Arquivo de Empresa SM0.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAlias := Alias()
dbSelectArea("SM0")
dbSetOrder(1)   // forca o indice na ordem certa
nRegistro := Recno()
dbSeek(SUBS(cNumEmp,1,2)+SC7->C7_FILENT)

oPrn:Say( 1750, CalcCol(0050) , "LOCAL DE ENTREGA: " ,oFont3,100 )  
oPrn:Say( 1750, /*0420*/ CalcCol(0490) , UPPER(SM0->M0_ENDENT) ,oFont4,100 )
oPrn:Say( 1750, CalcCol(1230) , UPPER("CEP: "+Trans(SM0->M0_CEPENT,cCepPict)),oFont4,100 )
oPrn:Say( 1750, CalcCol(1450) , "-" ,oFont4,100 )
oPrn:Say( 1750, CalcCol(1540) , UPPER(Alltrim(SM0->M0_CIDENT)) ,oFont4,100 )

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
oPrn:Say( 1870, /* 2880 */ CalcCol(3340 - 30 * Len(Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotMerc,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotMerc,14,MsDecimais(1)))))) , Iif(SC7->C7_MOEDA=1,"R$",Iif(SC7->C7_MOEDA=2,"USD","EUR")) + " " + AllTrim(Transform(xMoeda(nTotMerc,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotMerc,14,MsDecimais(1)))),oFont9c,100 )                         
                             
dbSelectArea("SM4")
dbSetOrder(1)
dbSelectArea("SC7")

//oPrn:Say( 1885, 0050, "REAJUSTE :",oFont3,100 )
oPrn:Say( 1750, CalcCol(1850) , "IPI :" ,oFont3,100 )
oPrn:Say( 1750, CalcCol(2050) , Transform(xMoeda(nTotIPI,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotIpi,14,MsDecimais(1))) ,oFont4c,100 )
//oPrn:Say( 1780, 1850, "ICMS :" ,oFont3,100 )
//oPrn:Say( 1780, 2050, Transform(xMoeda(nTotIcms,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotIcms,14,MsDecimais(MV_PAR12))) ,oFont4c,100 )
oPrn:Say( 1795, CalcCol(1850) , "FRETE :" ,oFont3,100 )
oPrn:Say( 1795, CalcCol(2050) , Transform(xMoeda(nTotFrete,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotFrete,14,MsDecimais(1))) ,oFont4c,100 )
//oPrn:Say( 1840, 1850, "Seguro :" ,oFont3,100 )
//oPrn:Say( 1840, 2050, Transform(xMoeda(nTotSeguro,SC7->C7_MOEDA,MV_PAR12,SC7->C7_DATPRF),tm(nTotSeguro,14,MsDecimais(MV_PAR12))) ,oFont4c,100 ) 
oPrn:Say( 1840, CalcCol(1850) , "ICMS ST:" ,oFont3,100 )
oPrn:Say( 1840, CalcCol(2050) , Transform(xMoeda(nTotIcmsSt,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotIcmsSt,14,MsDecimais(1))) ,oFont4c,100 )
oPrn:Say( 1885, CalcCol(1850) , "DESCONTO:" ,oFont3,100 )
oPrn:Say( 1885, CalcCol(2050) , Transform(xMoeda(nTotDesc,SC7->C7_MOEDA,1,SC7->C7_DATPRF),tm(nTotSeguro,14,MsDecimais(1))) ,oFont4c,100 )
oPrn:Say( 1960, CalcCol(0050) , "OBSERVACOES:",oFont3,100 ) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Didive as observacoes em linhas para a impressao             ³
//³ Serao criadas as variaveis cObs?? ate o numero definido em   ³
//³ nNumDiv                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nNumDiv := 5 // Numero de linhas para impressao
nObs := 1

/*
For nObs := 1 To nNumDiv
    cVar := "cObs"+StrZero(nObs,2)
    Eval(MemVarBlock(cVar),Substr(cObs,(65*(nObs-1))+1,65))
Next nObs
*/
oPrn:Say( 1990, CalcCol(0050) ,  "Horario de Recebimento 08:15/11:30 e das 13:00/17:00 seg a sexta. ",oFont6,100)
oPrn:Say( 2020, CalcCol(0050) ,  "Produtos com validade inferior h� 1 ano s� ser�o aceitos com autoriza��o do setor de compras.",oFont6,100) 
oPrn:Say( 2065, CalcCol(0050) ,  "CUMPRIMENTO DE LEIS",oFont5,100)
oPrn:Say( 2095, CalcCol(0050) ,  "O fornecedor garante que todos os artigos vendidos ou servi�os prestados est�o em conformidade com este pedido de compra, atendem a todos os requisitos e est�o em conformidade       ",oFont12,100)
oPrn:Say( 2125, CalcCol(0050) ,  "com todas as leis aplic�veis, sejam federais, estaduais e ou municipais. As leis referentes � discrimina��o e oportunidades de emprego, sal�rios, benef�cios, condi��es de trabalho, ",oFont12,100)
oPrn:Say( 2155, CalcCol(0050) ,  "s�o iguais a todos os funcion�rios,assim como a seguran�a do trabalhador,prote��o do meio ambiente, identifica��o de produtos, importa��o, exporta��o e transporte de produtos.       ",oFont12,100) 									
oPrn:Say( 2185, CalcCol(0050) ,  "Com rela��o a subst�ncias qu�micas ou misturas fornecidas segundo este todos os fornecedores dever�o cumprir com  todas as disposi��es e regulamentos aplic�veis promulgados segundo  ",oFont12,100) 									
oPrn:Say( 2215, CalcCol(0050) ,  "a lei de Controle de Substancias T�xicas e a Lei Federal de Sa�de e Seguran�a Ocupacionais de 1970, incluindo Normas de Comunica��o e Riscos. O Fornecedor dever� imediatamente       ",oFont12,100) 									
oPrn:Say( 2245, CalcCol(0050) ,  " fornecer as fichas de informa��es de Seguran�a de produtos qu�micos e misturas que, eventualmente,possam estar em conformidade com as Leis de Controle de Subst�ncias T�xicas. 		",oFont12,100) 									

/*
oPrn:Say( 1970, CalcCol(0350), cObs01,oFont4c,100 ) 
oPrn:Say( 2010, CalcCol(0350) , cObs02,oFont4c,100 )
oPrn:Say( 2050, CalcCol(0350) , cObs03,oFont4c,100 )
oPrn:Say( 2090, CalcCol(0350) , cObs04,oFont4c,100 )
oPrn:Say( 2130, CalcCol(0350) , cObs05,oFont4c,100 )
*/

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
oPrn:Say( 2340, /*0650*/ CalcCol(0725) ,  "_________________________",oFont4c,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
oPrn:Say( 2380, /*0820*/ CalcCol(0905) ,  "COMPRADOR",oFont3b,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
//oPrn:Say( 2260, 1260,  "_________________________",oFont4c,100 )
//oPrn:Say( 2300, 1430,  "Diretoria",oFont3,100 )
oPrn:Say( 2340, /*1860*/ /*2320*/ CalcCol(2300) ,  "__________________________________",oFont4c,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
oPrn:Say( 2380, /*2120*/ /*2580*/ CalcCol(2580) ,  "DIRETORIA",oFont3b,100,,,2 )// 0= esquerda, 1=direita, 2=centralizado
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
Local _nI        := 1
Local cMensagem := ''
Local cArqD, cSubject, lEnviado

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

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WFtoFor   �Autor  �Marcio           � Data �  03/09/21   ���
�������������������������������������������������������������������������͹��
���Desc.     �Recalcula colunas ap�s transformar fun��o de TMSPrinter em  ���
���          �FWMSPrinter                                                 ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function WFtoFor(cNumPed,cMailFor,cNomeFor,cDir,cArq)

Local oLocal
Local _cMail := Space(120)
Local nOpca  := 0


DEFINE MSDIALOG oLocal FROM 000,200 TO 150,650 TITLE "Informe o e-mail " PIXEL
	
	@ 003,005 TO 060,390//090,105
	@ 008,007 SAY "Informe e-mail a ser utilizado. " SIZE  130, 7
	@ 023,007 SAY "e-mail:" SIZE  60, 7
	@ 030,007 GET _cMail  SIZE  130, 9

	DEFINE SBUTTON FROM 045,010 TYPE 1 ACTION Close(oLocal) ENABLE OF oLocal
	DEFINE SBUTTON FROM 045,070 TYPE 2  ACTION ( nOpca := 1, oLocal:End() ) ENABLE OF oLocal
	
	ACTIVATE MSDIALOG oLocal CENTER	


If nOpca == 1
	Alert("envio do e-mail cancelado!")
	Return
End

If !Empty(_cMail)
	cMailFor := _cMail
End

cAnexo 	 := AllTrim(cDir) + AllTrim(cArq) + ".PDF"
CpyT2S( cAnexo, "\spool\boleto\" )

Sleep(5000)

cAnxSrv  := "\spool\boleto\" + AllTrim(cArq) + ".PDF"
cModHTML := "\WORKFLOW\HTML\WF_WFTOFOR.HTML"

oProcess := TWFProcess():New( "WFTOFOR", "Pedido de Compras" )
oProcess:NewTask( "Pedido", cModHTML )

oHtml:=oProcess:oHtml
oHtml:valByName("NOMEFOR",cNomeFor)

oProcess:fDesc := "Pedido de Compras " + cNumPed
oProcess:cSubject := "[ALPAX] - Pedido de compra - " + cNumPed
oProcess:cTo 	  := cMailFor  //"teste@alpax.com.br"  
oProcess:cCC  	  := "regina.yoko@alpax.com.br"
oProcess:AttachFile(cAnxSrv)
cMailID := oProcess:Start()

oProcess:Finish()
Alert("e-mail enviado")

Return

