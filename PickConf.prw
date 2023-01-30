#INCLUDE "PROTHEUS.CH"
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³PICKCONF ³ Autor ³ Fagner / Biale         ³ Data ³23/09/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Tela para conferência da separação dos pedidos de venda     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ALPAX                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function PickConf() 

// Variaveis Locais da Funcao
Private cCodProd := Space(35)
Private cCodPed	 := Space(25)
Private oEdit1
Private oEdit2
Private _oDlg
Private VISUAL := .F.                        
Private INCLUI := .F.                        
Private ALTERA := .F.                        
Private DELETA := .F.                        
Private aListBox1 := {}
Private oListBox1               
Private cNomeCli := ""
Private oOk      := LoadBitmap( GetResources(), "BR_VERDE" )
Private oNo      := LoadBitmap( GetResources(), "BR_VERMELHO" )
                                             
DEFINE FONT oFont name "arial" Size 10,-10 BOLD

DEFINE MSDIALOG _oDlg TITLE "Conferência de Pedido" FROM C(221),C(238) TO C(708),C(940) PIXEL

	@ C(001),C(012) TO C(040),C(342) LABEL "" PIXEL OF _oDlg
	@ C(043),C(012) TO C(245),C(342) LABEL "" PIXEL OF _oDlg
	@ C(011),C(018) Say "Código de Barras do Pedido: " Size C(071),C(008) COLOR CLR_BLACK PIXEL OF _oDlg 
	@ C(011),C(099) MsGet oEdit2 Var cCodPed Size C(236),C(009) COLOR CLR_BLACK PIXEL OF _oDlg valid u_buscacli() //when iif(empty(alltrim(cCodPed)),.t.,u_buscaCli()) 
	@ C(026),C(020) Say "Cliente: " Size C(021),C(008) COLOR CLR_BLACK PIXEL OF _oDlg 
	@ C(026),C(041) Say cNomeCli Size C(294),C(008) COLOR CLR_BLUE PIXEL OF _oDlg FONT oFont
	@ C(050),C(099) MsGet oEdit1 Var cCodProd Size C(236),C(009) COLOR CLR_BLACK PIXEL OF _oDlg valid u_buscaPROD()
	@ C(052),C(016) Say "Código de Barra do Produto:" Size C(071),C(008) COLOR CLR_BLACK PIXEL OF _oDlg 
	@ C(231),C(302) Button "Cancelar" Size C(037),C(012) PIXEL OF _oDlg action _oDlg:end()	
//	@ C(231),C(261) Button "Cancelar" Size C(037),C(012) PIXEL OF _oDlg action _oDlg:end()
//	@ C(231),C(302) Button "Concluir" Size C(037),C(012) PIXEL OF _oDlg action u_FECHACONF()

	@ C(068),C(014) ListBox oListBox1 Fields ;
		HEADER "","Qtd.Pedido","Qtd.Caixa","Part Number","Lote","Serie","Descrição", "Marca" , "Capacidade", "Und.Medida";
		Size C(323),C(155) Of _oDlg Pixel;
		ColSizes 8,25,25,50,50,50,30,20,8
	oListBox1:SetArray(aListBox1)     
	Aadd(aListBox1,{.t.,"","","","", "", "", "","", ""})	
	oListBox1:bLine := {|| {;
		If(aListBox1[oListBox1:nAt,01],oOk,oNo),;
		aListBox1[oListBox1:nAT,02],;
		aListBox1[oListBox1:nAT,03],;
		aListBox1[oListBox1:nAT,04],;
		aListBox1[oListBox1:nAT,05],;
		aListBox1[oListBox1:nAT,06],;
		aListBox1[oListBox1:nAT,07],;
		aListBox1[oListBox1:nAT,08],;
		aListBox1[oListBox1:nAT,09],;
		aListBox1[oListBox1:nAT,10]}}
	oListBox1:refresh()
	
ACTIVATE MSDIALOG _oDlg CENTERED 

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

      
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³BUSCACLI ³ Autor ³ Fagner / Biale         ³ Data ³23/09/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Busca o Cliente de separação para a montagem  do ListBox     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ALPAX                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function BuscaCli()      

Local lRet := .F.                  

DBSELECTAREA("SA1")
SA1->(DBSETORDER(1))
if SA1->(DBSEEK(XFILIAL("SA1")+SUBSTR(cCodPed,16,8)))                     
	cNomeCli:= SA1->A1_NOME
	lRet := .T.    
	oEdit2:disable()	                                                         
		
	CQUERY:= " SELECT SC9.C9_LOTECTL, SC9.C9_CLIENTE,SC9.C9_PEDIDO, SC9.C9_PRODUTO, SC9.C9_LIBCODE,"
	CQUERY+= " SB1.B1_AXRISCO,ISNULL(SX5.X5_DESCRI,'SIMPLES') AS DESCRICAO  ,SC9.C9_NUMSERI, "
	CQUERY+= " SB1.B1_PNUMBER ,SB1.B1_DESC,SB1.B1_MARCA,SB1.B1_CAPACID,SB1.B1_UM,SC9.C9_QTDLIB"
	CQUERY+= " FROM "+retsqlname("SC9")+" SC9 (NOLOCK)  "
	CQUERY+= " LEFT JOIN "+retsqlname("SB1")+" SB1 (NOLOCK) "
	CQUERY+= " ON SB1.D_E_L_E_T_ <> '*'  AND SC9.C9_PRODUTO = SB1.B1_COD "
	CQUERY+= " LEFT JOIN "+retsqlname("SX5")+" SX5 (NOLOCK) "
	CQUERY+= " ON SX5.X5_TABELA  = 'Z1'AND SX5.D_E_L_E_T_ <> '*'  "
	CQUERY+= " AND SB1.B1_AXRISCO = SX5.X5_CHAVE "
	CQUERY+= " WHERE SC9.D_E_L_E_T_ <> '*'     "
	CQUERY+= " AND SC9.C9_DATALIB >= "+DTOS(DDATABASE-90)
	CQUERY+= " AND SC9.C9_NFISCAL = ''   "
	CQUERY+= " AND  SC9.C9_BLEST =  '' "
	CQUERY+= " AND SC9.C9_BLCRED =  '' AND SC9.C9_FILIAL = "+XFILIAL("SC9")
//	CQUERY+= " AND  SC9.C9_CLIENTE =  '"+SUBSTR(cCodPed,1,6)+"' "
//	CQUERY+= " AND  SC9.C9_AXRISCO =  '"+ALLTRIM(SUBSTR(cCodPed,9,4))+"' "
	CQUERY+= " AND  SC9.C9_XCHPICK =  '"+cCodPed+"' "
	CQUERY+= " ORDER BY  SC9.C9_CLIENTE, B1_AXRISCO "                                                                     
	
	DbUseArea( .T., "TOPCONN", TcGenqry( , , cQUERY), "TRB", .F., .F. )           
	
	Count to nRec
	
	If nRec > 0
        aListBox1:= {}        
		TRB->(DBGOTOP())                                                                                               
	    While TRB->(!EOF())	
			Aadd(aListBox1,{.t.,TRB->C9_QTDLIB,0,TRB->B1_PNUMBER,TRB->C9_LOTECTL, TRB->C9_NUMSERI, TRB->B1_DESC, TRB->B1_MARCA, TRB->B1_CAPACID, TRB->B1_UM, TRB->C9_PRODUTO})
	        TRB->(DBSKIP())
		
		Enddo        
	Else     
	     MsgInfo("Não Existe PEDIDO LIBERADO para este CLIENTE")
	     oEdit2:disable()   
	     lRet := .T.
	     
	Endif
    TRB->(DBCLOSEAREA())                        
   	oListBox1:SetArray(aListBox1)
	oListBox1:bLine := {|| {;
		If(aListBox1[oListBox1:nAt,01],oOk,oNo),;
		aListBox1[oListBox1:nAT,02],;
		aListBox1[oListBox1:nAT,03],;
		aListBox1[oListBox1:nAT,04],;
		aListBox1[oListBox1:nAT,05],;
		aListBox1[oListBox1:nAT,06],;
		aListBox1[oListBox1:nAT,07],;
		aListBox1[oListBox1:nAT,08],;
		aListBox1[oListBox1:nAT,09],;
		aListBox1[oListBox1:nAT,10]}}

	_oDlg:refresh()
	oListBox1:refresh()
	
Else
	MsgInfo("Cliente não Encontrado")
Endif

Return lRet                                      

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³BUSCAPROD ³ Autor ³ Fagner / Biale        ³ Data ³24/09/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³Busca e controla itens do pedido dentro do vetor.           ³±±
±±³          ³Liberando a tela somente após a conferencia total do pedido ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ALPAX                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function BuscaProd()
                                                                        
/* Layout do vetor

01 -> Semaforo 
02 -> Qtd.Pedido
03 -> Qtd.Caixa
04 -> Part Number
05 -> Lote
06 -> Serie
07 -> Descrição
08 -> Marca
09 -> Capacidade
10 -> Und.Medida
11 -> Cod. Produto

*/                                                                           

Local cTipoProd   := SUBSTR(cCodProd, 1,1)
Local cCodeProd    := SUBSTR(cCodProd, 2,15)
Local cLoteProd   := SUBSTR(cCodProd, 17,15) 
Local lAchou      := .F.        

if empty(cCodProd)
	oEdit2:SetFocus()
    Return .T.
Endif

For nI := 1 to Len(aListBox1)
 if cCodeProd == aListBox1[nI,11] .and. (ALLTRIM(cLoteProd) ==  alltrim(aListBox1[nI,5]) .or. ALLTRIM(cLoteProd) == alltrim(aListBox1[nI,6]))
    If  aListBox1[nI,2] > aListBox1[nI,3]
    	aListBox1[nI,3]++ 
    	lAchou := .T.
    Else
    	MsgInfo("QUANTIDADE DO PEDIDO JÁ ALCANÇADA !") 
    	cCodProd:= SPACE(35)
    	oEdit2:SetFocus()
    	Return .T.
    Endif                 
    
    If  aListBox1[nI,2] = aListBox1[nI,3]
    	aListBox1[nI,1] := .F. 
    Endif
    
  Endif   
 Next                                
 
 If !lAchou 
 	MsgInfo ("PRODUTO NÃO ENCONTRADO !")
 Endif

  	oListBox1:SetArray(aListBox1)
	oListBox1:bLine := {|| {;
		If(aListBox1[oListBox1:nAt,01],oOk,oNo),;
		aListBox1[oListBox1:nAT,02],;
		aListBox1[oListBox1:nAT,03],;
		aListBox1[oListBox1:nAT,04],;
		aListBox1[oListBox1:nAT,05],;
		aListBox1[oListBox1:nAT,06],;
		aListBox1[oListBox1:nAT,07],;
		aListBox1[oListBox1:nAT,08],;
		aListBox1[oListBox1:nAT,09],;
		aListBox1[oListBox1:nAT,10]}}
 	oListBox1:refresh()
 	
 cCodProd:= SPACE(35)	
 oEdit2:SetFocus()
 
 //Verificando se a conferência/separação do pedido foi concluída 
 For nI:= 1 to len(aListBox1)             
 	if aListBox1[nI,2] <> aListBox1[nI,3]
 	   Return .T.
    Endif
 Next
 //chama tela de dados para montagem da etiqueta da caixa
 u_PICKEMB(cCodPed)                                      
 //fecha a janela atual
 _oDlg:end()           
 //abre janela para nova conferência                                                     
 u_PickConf()
Return .T.                                                                  