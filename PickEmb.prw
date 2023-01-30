#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PICKEMB ³ Autor ³ Fagner / Biale         ³ Data ³13/10/2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Tela para informações de embalagem após a conferência       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ALPAX                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function PickEmb(cCodBarras)

Private cTransp	 := Space(6)
Private cEspec	 := Space(25)
Private cVolume	 := Space(25)
Private cBox	 := Space(25)
Private cPesoL	 := Space(25)
Private cPesoB	 := Space(25)
Private cObs	 := ""  
Private cNomeTrans := ""
Private oTransp
Private oEspec
Private oVolume
Private oBox
Private oPesoL
Private oPesoB
Private oOBS
Private _oDlg2				// Dialog Principal
Private VISUAL := .F.                        
Private INCLUI := .F.                        
Private ALTERA := .F.                        
Private DELETA := .F.                        
                                           
DEFINE FONT oFont name "arial" size 09,-12 BOLD
DEFINE MSDIALOG _oDlg2 TITLE "Dados para a Etiqueta" FROM C(178),C(181) TO C(563),C(627) PIXEL

	@ C(007),C(006) Say "Transportadora:" Size C(039),C(008) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(016),C(006) MsGet oTransp Var cTransp F3 "SA4" Size C(038),C(009) COLOR CLR_BLACK PIXEL OF _oDlg2 valid U_BusTransp()
	@ C(017),C(052) Say cNomeTrans Size C(153),C(008) COLOR CLR_BLUE PIXEL OF _oDlg2 FONT oFont
	@ C(034),C(006) Say "Espécie" Size C(021),C(008) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(043),C(006) MsGet oEspec Var cEspec Size C(068),C(009) COLOR CLR_BLACK PIXEL OF _oDlg2	
	@ C(035),C(085) Say "Volume" Size C(019),C(008) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(043),C(085) MsGet oVolume Var cVolume PICTURE "@E 9999999999" Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(034),C(158) Say "Box" Size C(011),C(008) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(043),C(158) MsGet oBox Var cBox Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(062),C(006) Say "Peso Liquido:" Size C(034),C(008) COLOR CLR_BLACK PIXEL OF _oDlg2  
	@ C(070),C(006) MsGet oPesoL Var cPesoL  Size C(100),C(009) COLOR CLR_BLACK PIXEL OF _oDlg2 Valid u_AjuPeso(cPesoL, "cPesoL")
	@ C(062),C(117) Say "Peso Bruto" Size C(028),C(008) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(070),C(117) MsGet oPesoB Var cPesoB  Size C(101),C(009) COLOR CLR_BLACK PIXEL OF _oDlg2 Valid u_AjuPeso(cPesoB, "cPesoB")
	@ C(088),C(006) Say "Observações" Size C(033),C(008) COLOR CLR_BLACK PIXEL OF _oDlg2
	@ C(098),C(006) GET oObs Var cObs MEMO Size C(206),C(066) PIXEL OF _oDlg2
	@ C(175),C(178) Button "OK" Size C(037),C(012) PIXEL OF _oDlg2 ACTION (iif(U_GRVDTRANSP(cCodBarras),_oDlg2:end,))

ACTIVATE MSDIALOG _oDlg2 CENTERED 

Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)                                                         
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor     
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)  
		nTam *= 0.8                                                                
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600                
		nTam *= 1                                                                  
	Else	// Resolucao 1024x768 e acima                                           
		nTam *= 1.28                                                               
	EndIf                                                                         
                                                                                
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿                                               
	//³Tratamento para tema "Flat"³                                               
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                                               
	If "MP8" $ oApp:cVersion                                                      
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()                      
			nTam *= 0.90                                                            
		EndIf                                                                      
	EndIf                                                                         
Return Int(nTam)                                                                


User Function BusTransp()
Local cRet := .F.

DBSelectArea("SA4")
SA4->(DBSetorder(1))
If SA4->(DBSeek(xFilial("SA4")+ALLTRIM(cTransp)))
	cNomeTrans := SA4->A4_NOME
	cRet := .T.
	_oDlg2:Refresh()
Endif

Return cRet

User Function AjuPeso(cPeso, cCampo)

cPeso := STRTRAN(cPeso,",",".")
&cCampo := transform(val(cPeso), "@E 999,999,999.999")
_oDlg2:Refresh()

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GRVDTRANSP ³ Autor ³ Fagner / Biale      ³ Data ³13/10/2010 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Grava Dados para etiqueta na tabela SZ6                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ALPAX                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function GRVDTRANSP(cCodBarras)
 
 If empty(alltrim(cVolume)) .or. empty(alltrim(cBox)) .or. empty(alltrim(cEspec))
 	MsgInfo("Preencha os Campos 'Volume', 'Box' e 'Especie' antes de finalizar a separação !")
 	Return
 Endif

If cPesoL > cPesoB 
 	MsgInfo("Peso Líquido Maior que o Peso Bruto ! Favor ajustar ! ")
 	Return .f.
 Endif
 
 DBSELECTAREA("ZA6")
 ZA6->(DBSetOrder(1))
 
 if ZA6->(DBSeeK(xFilial("ZA6")+cCodBarras))
     Reclock("ZA6", .F.)
 Else
 	Reclock("ZA6", .T.)
 Endif
 
 	ZA6->ZA6_CODIGO := cCodBarras
 	ZA6->ZA6_TRANSP := cTransp
 	ZA6->ZA6_TIPOVO := cEspec
 	ZA6->ZA6_BOX    := cBox
 	ZA6->ZA6_QUANT  := VAL(cVolume)
 	ZA6->ZA6_PESOLI := val(strtran(cPesoL, ",", "."))
 	ZA6->ZA6_PESOBR := val(strtran(cPesoB, ",", "."))
 	ZA6->ZA6_OBS    := cObs	 
 	
 	ZA6->(MSUNLOCK())             
 	
 	U_ETIQPICK(cCodBarras)

Return .t.    



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ETIQPICK     ºAutor  ³CHRISTIAN CARDENAS  º Data ³  25/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ELABORACAO DA ETIQUETA NA IMPRESSORA ZEBRA                 º±± 
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
user function ETIQPICK(cCodBarras)

DBSELECTAREA("SA1")
SA1->(DBSETORDER(1))

IF SA1->(DBSEEK(XFILIAL("SA1")+SUBSTR(cCodBarras,16,8)))
	FOR X:=1 TO ZA6->ZA6_QUANT
		MSCBPRINTER("ZEBRA", "LPT1",NIL,84,.F.,NIL,NIL,NIL, ,  ,.t.)
		MSCBBEGIN(1,6)
		MSCBBOX(02,04,96,79)
		MSCBLineH(02,20,96,3,"B")
		MSCBLineH(02,30,96,3,"B")
		MSCBLineH(02,60,96,3,"B")
		MSCBLineV(45,20,10)
		MSCBSAY(04,06,"ALPAX ","N","F","100,033")
		MSCBSAY(36,06,"Comercio de Produtos Laborat.Ltda. ","N","B","022,010")
		MSCBSAY(36,09,"Fone : "+SM0->M0_TEL+"Fax : "+SM0->M0_FAX  ,"N","B","022,010")
		MSCBSAY(04,21,"VOLUME ","N","C","060,035")
		MSCBSAY(56,21,cvaltochar(StrZero(X,3))+"/"+cvaltochar(StrZero(ZA6->ZA6_QUANT,3)),"N","D","060,033")
		MSCBSAY(04,32,SA1->A1_NOME,"N","B","020,010")
		MSCBSAY(04,38,SA1->A1_END+"   "+SA1->A1_BAIRRO,"N","B","020,010")
		MSCBSAY(04,44,SA1->A1_MUN+"   "+SA1->A1_EST+"   "+SA1->A1_CEP,"N","B","020,010")
		MSCBSAY(04,50,"FONE :"+SA1->A1_DDD+" "+SA1->A1_TEL,"N","B","020,010")
//		MSCBSAYBAR(06,62,SC9->C9_CLIENTE+SC9->C9_LIBCODE,"MB07","C",8.36,.F.,.F.,.F.,,2,1)
		MSCBSAYBAR(06,62,cCodBarras,"MB07","C",8.36,.F.,.F.,.F.,,2,1)
//		MSCBSAY(32,72,SC9->C9_LIBCODE,"N","B","030,011")
		MSCBSAY(32,72,cCodBarras,"N","B","030,011")
		MSCBSAY(64,72,"BOX"+StrZero(Val(ZA6->ZA6_BOX),3),"N","B","030,011")
		MSCBEND()
		MSCBCLOSEPRINTER()

	NEXT   
Endif

return

