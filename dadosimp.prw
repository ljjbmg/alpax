#INCLUDE "PROTHEUS.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �DADOSIMP   �Autor  �Fagner S. Pinto    � Data �  04/10/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �TELA CRIADA PARA INFORMA��ES DE DADOS A RESPEITO DA IMPORTA-���
���          �CAO E QUE DEVER�O CONSTAR NO XML QUE SER� ENVIADO AO SEFAZ  ���
�������������������������������������������������������������������������͹��
���Uso       � AP10 - ALPAX                                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/                         

User Function dadosimp()
Local cAliasE 		:= "SF1"           // Tabela cadastrada no Dicionario de Tabelas (SX2) que sera editada
Local aCpoEnch  	:= {"F1_DOC","F1_EMISSAO","F1_NFENRDI","F1_NFEDTDI","F1_NFELOC","F1_NFEUF","F1_NFEDES","F1_VTRANS","F1_VAFRMM","F1_INTERM","F1_CNPJAE","F1_UFTERC"}
Local aAlterEnch	:= {"F1_NFENRDI","F1_NFEDTDI","F1_NFELOC","F1_NFEUF","F1_NFEDES","F1_VTRANS","F1_VAFRMM","F1_INTERM","F1_CNPJAE","F1_UFTERC"}		// Vetor com nome dos campos que poderao ser editados                                           
Local nOpc    		:= 4			// Numero da linha do aRotina que definira o tipo de edicao (Inclusao, Alteracao, Exclucao, Visualizacao)
Local nReg    		:= 1			// Numero do Registro a ser Editado/Visualizado (Em caso de Alteracao/Visualizacao)
Local aPos		  	:= {C(000),C(000),C(090),C(390)}                        
Local nModelo	  	:= 3       	// Se for diferente de 1 desabilita execucao de gatilhos estrangeiros                           
Local lF3 		  	:= .F.		// Indica se a enchoice esta sendo criada em uma consulta F3 para utilizar variaveis de memoria 
Local lMemoria  	:= .T.		// Indica se a enchoice utilizara variaveis de memoria ou os campos da tabela na edicao         
Local lColumn	  	:= .F.		// Indica se a apresentacao dos campos sera em forma de coluna                                  
Local caTela 	  	:= "" 		// Nome da variavel tipo "private" que a enchoice utilizara no lugar da propriedade aTela       
Local lNoFolder 	:= .F.		// Indica se a enchoice nao ira utilizar as Pastas de Cadastro (SXA)                            
Local lProperty 	:= .T.		// Indica se a enchoice nao utilizara as variaveis aTela e aGets, somente suas propriedades com os mesmos nomes
Local _aArea   		:= {}
Local _aAlias  		:= {}
Private _oDlg				// Dialog Principal

Private VISUAL := .F.                        
Private INCLUI := .F.                        
Private ALTERA := .F.                        
Private DELETA := .F.                        

Private oGetDados1

DEFINE MSDIALOG _oDlg TITLE "Dados da Importa��o" FROM C(198),C(181) TO C(578),C(967) PIXEL
	RegToMemory(cAliasE, INCLUI, .F.)                   
	Enchoice(cAliasE,nReg,nOpc,/*aCRA*/,/*cLetra*/,/*cTexto*/,aCpoEnch,aPos,;
		aAlterEnch,nModelo,/*nColMens*/,/*cMensagem*/,/*cTudoOk*/,_oDlg,lF3,;    
		lMemoria,lColumn,caTela,lNoFolder,lProperty)                             
	@ C(169),C(353) Button "OK" Size C(037),C(012) PIXEL OF _oDlg action(iif(u_dadosgrv(),_oDlg:end(),.f.))
	fGetDados1()

ACTIVATE MSDIALOG _oDlg CENTERED 

Return(.T.)

/*����������������������������������������������������������������������������������
������������������������������������������������������������������������������������
��������������������������������������������������������������������������������Ŀ��
���Programa   �fGetDados1()� Autor � Cristiane de Campos Figue � Data �01/10/2010���
��������������������������������������������������������������������������������Ĵ��
���Descricao  � Montagem da GetDados                                             ���
��������������������������������������������������������������������������������Ĵ��
���Observacao � O Objeto oGetDados1 foi criado como Private no inicio do Fonte   ���
���           � desta forma voce podera trata-lo em qualquer parte do            ���
���           � seu programa:                                                    ���
���           �                                                                  ���
���           � Para acessar o aCols desta MsNewGetDados: oGetDados1:aCols[nX,nY]���
���           � Para acessar o aHeader: oGetDados1:aHeader[nX,nY]                ���
���           � Para acessar o "n"    : oGetDados1:nAT                           ���
���������������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������������
����������������������������������������������������������������������������������*/
Static Function fGetDados1()
Local nX			:= 0                                                                                                              
Local aCpoGDa       := {"D1_ITEM","B1_DESC", "D1_COD", "B1_PNUMBER", "B1_POSIPI","D1_NFEADIC","D1_NFEITAD", "D1_II","D1_ALIQII","D1_NFEFABR"}                                                                                                 
Local aAlter       	:= {"D1_NFEADIC","D1_NFEITAD", "D1_II","D1_ALIQII"}
Local nSuperior    	:= C(093)           // Distancia entre a MsNewGetDados e o extremidade superior do objeto que a contem
Local nEsquerda    	:= C(001)           // Distancia entre a MsNewGetDados e o extremidade esquerda do objeto que a contem
Local nInferior    	:= C(162)           // Distancia entre a MsNewGetDados e o extremidade inferior do objeto que a contem
Local nDireita     	:= C(389)           // Distancia entre a MsNewGetDados e o extremidade direita  do objeto que a contem
Local nOpc         	:= GD_INSERT+GD_DELETE+GD_UPDATE                                                                            
Local cLinhaOk     	:= "AllwaysTrue"    // Funcao executada para validar o contexto da linha atual do aCols                  
Local cTudoOk      	:= "AllwaysTrue"    // Funcao executada para validar o contexto geral da MsNewGetDados (todo aCols)      
Local cIniCpos     	:= ""               // Nome dos campos do tipo caracter que utilizarao incremento automatico.            
                                         // Este parametro deve ser no formato "+<nome do primeiro campo>+<nome do            
                                         // segundo campo>+..."                                                               
Local nFreeze      	:= 000              // Campos estaticos na GetDados.                                                               
Local nMax         	:= 999              // Numero maximo de linhas permitidas. Valor padrao 99                           
Local cCampoOk     	:= "AllwaysTrue"    // Funcao executada na validacao do campo                                           
Local cSuperApagar 	:= ""               // Funcao executada quando pressionada as teclas <Ctrl>+<Delete>                    
Local cApagaOk     	:= "AllwaysTrue"    // Funcao executada para validar a exclusao de uma linha do aCols                   
Local oWnd          	:= _oDlg                                                                                                  
Private aHead        	:= {}               // Array a ser tratado internamente na MsNewGetDados como aHeader                    
Private aCol         	:= {}               // Array a ser tratado internamente na MsNewGetDados como aCols                      
                                                                                                                                
DbSelectArea("SX3")                                                                                                             
SX3->(DbSetOrder(2)) // Campo                                                                                                   
For nX := 1 to Len(aCpoGDa)                                                                                                     
	If SX3->(DbSeek(aCpoGDa[nX]))                                                                                                 
		Aadd(aHead,{ AllTrim(X3Titulo()),;                                                                                         
			SX3->X3_CAMPO	,;                                                                                                       
			SX3->X3_PICTURE,;                                                                                                       
			SX3->X3_TAMANHO,;                                                                                                       
			SX3->X3_DECIMAL,;                                                                                                       
			SX3->X3_VALID	,;                                                                                                       
			SX3->X3_USADO	,;                                                                                                       
			SX3->X3_TIPO	,;                                                                                                       
			SX3->X3_F3 		,;                                                                                                       
			SX3->X3_CONTEXT,;                                                                                                       
			SX3->X3_CBOX	,;                                                                                                       
			SX3->X3_RELACAO})                                                                                                       
	Endif                                                                                                                         
Next nX                                                                                                                         
aAux := {}                
                                                                                                      
/*For nX := 1 to Len(aCpoGDa)                                                                                                     
	If DbSeek(aCpoGDa[nX])                                                                                                        
		Aadd(aAux,CriaVar(SX3->X3_CAMPO))
//	CriaVar(SX3->X3_CAMPO)                                                                                          
	Endif                                                                                                                         
Next nX                                    
*/

cQry:= "select D1_ITEM, B1_DESC, D1_COD, B1_PNUMBER, B1_POSIPI,D1_NFEADIC,D1_NFEITAD, D1_II, D1_ALIQII, D1_FORNECE D1_NFEFABR from "+RETSQLNAME("SD1") + " D1 "
cQry+= " INNER JOIN " + RETSQLNAME("SB1") + " B1 "
cQry+= " ON D1_COD = B1_COD "                                                          

cQry+= " WHERE D1_DOC = '" + SF1->F1_DOC + "' AND D1_FORNECE = '" + SF1->F1_FORNECE +"' AND D1.D_E_L_E_T_ = ''"
//cQry+= " WHERE D1_DOC = '000033536'  AND D1.D_E_L_E_T_ = ''"
cQry+= " ORDER BY B1_POSIPI, D1_COD "

DbUseArea( .T., "TOPCONN", TcGenqry( , , cQry), "TRB", .F., .F. )
	
TRB->(dbGoTop())                           
While TRB->(!EOF())
    aAux :={}
    For nX:= 1 to len(aHead)
		cCampo :="TRB->"+aHead[nX,2]
		AADD(aAux,&cCampo)
	Next
    Aadd(aAux,.F.)                                                                                                                  
	Aadd(aCol,aAux)                                                                                                                 
	TRB->(DBSKIP())
Enddo
TRB->(DbCloseArea())
                                                                                    
oGetDados1:= MsNewGetDados():New(nSuperior,nEsquerda,nInferior,nDireita,nOpc,cLinhaOk,cTudoOk,cIniCpos,;                               
                             aAlter,nFreeze,nMax,cCampoOk,cSuperApagar,cApagaOk,oWnd,aHead,aCol)                                   
Return Nil                                                                                                                      

/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   �   C()   � Autores � Norbert/Ernani/Mansano � Data �10/05/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Funcao responsavel por manter o Layout independente da       ���
���           � resolucao horizontal do Monitor do Usuario.                  ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function C(nTam)                                                         
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor     
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)  
		nTam *= 0.8                                                                
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600                
		nTam *= 1                                                                  
	Else	// Resolucao 1024x768 e acima                                           
		nTam *= 1.28                                                               
	EndIf                                                                         
                                                                                
	//���������������������������Ŀ                                               
	//�Tratamento para tema "Flat"�                                               
	//�����������������������������                                               
	If "MP8" $ oApp:cVersion                                                      
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()                      
			nTam *= 0.90                                                            
		EndIf                                                                      
	EndIf                                                                         
Return Int(nTam)                                                                
/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   � NwFieldPos � Autor � Ricardo Mansano       � Data �06/09/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Retorna numero da coluna onde se encontra o Campo na         ���
���           � NewGetDados                                                  ���
����������������������������������������������������������������������������Ĵ��
���Parametros � oObjeto := Objeto da NewGetDados                             ���
���           � cCampo  := Nome do Campo a ser localizado                    ���
����������������������������������������������������������������������������Ĵ��
���Retorno    � Numero da coluna localizada pelo aScan                       ���
���           � OBS: Se retornar Zero significa que nao localizou o Registro ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function NwFieldPos(oObjeto,cCampo)                                      
Local nCol := aScan(oObjeto:aHeader,{|x| AllTrim(x[2]) == Upper(cCampo)})       
Return(nCol)                                                                    
                                                                                
/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   � NwFieldGet � Autor � Ricardo Mansano       � Data �06/09/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Retorna Valor da Celula da NewGetDados                       ���
����������������������������������������������������������������������������Ĵ��
���Parametros � oObjeto := Objeto da NewGetDados                             ���
���           � cCampo  := Nome do Campo a ser localizado                    ���
���           � nLinha  := Linha da GetDados, caso o parametro nao seja      ���
���           �            preenchido o Default sera o nAt da NewGetDados    ���
����������������������������������������������������������������������������Ĵ��
���Retorno    � xRet := O Valor da Celula independente de seu TYPE           ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function NwFieldGet(oObjeto,cCampo,nLinha)                               
Local nCol := aScan(oObjeto:aHeader,{|x| AllTrim(x[2]) == Upper(cCampo)})       
Local xRet                                                                      
// Se nLinha nao for preenchida Retorna a Posicao de nAt do Objeto              
Default nLinha := oObjeto:nAt                                                   
	xRet := oObjeto:aCols[nLinha,nCol]                                            
Return(xRet)                                                                    
                                                                                
/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   � NwFieldPut � Autor � Ricardo Mansano       � Data �06/09/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Alimenta novo Valor na Celula da NewGetDados                 ���
����������������������������������������������������������������������������Ĵ��
���Parametros � oObjeto := Objeto da NewGetDados                             ���
���           � cCampo  := Nome do Campo a ser localizado                    ���
���           � nLinha  := Linha da GetDados, caso o parametro nao seja      ���
���           �            preenchido o Default sera o nAt da NewGetDados    ���
���           � xNewValue := Valor a ser inputado na Celula.                 ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function NwFieldPut(oObjeto,cCampo,nLinha,xNewValue)                     
Local nCol := aScan(oObjeto:aHeader,{|x| AllTrim(x[2]) == Upper(cCampo)})       
// Se nLinha nao for preenchida Retorna a Posicao de nAt do Objeto              
Default nLinha := oObjeto:nAt                                                   
	// Alimenta Celula com novo Valor se este foi preenchido                      
	If !Empty(xNewValue)                                                          
		oObjeto:aCols[nLinha,nCol] := xNewValue                                    
	Endif                                                                         
Return Nil                                                                      
                                                                                
/*������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Programa   � NwDeleted  � Autor � Ricardo Mansano       � Data �06/09/2005���
����������������������������������������������������������������������������Ĵ��
���Descricao  � Verifica se a linha da NewGetDados esta Deletada.            ���
����������������������������������������������������������������������������Ĵ��
���Parametros � oObjeto := Objeto da NewGetDados                             ���
���           � nLinha  := Linha da GetDados, caso o parametro nao seja      ���
���           �            preenchido o Default sera o nAt da NewGetDados    ���
����������������������������������������������������������������������������Ĵ��
���Retorno    � lRet := True = Linha Deletada / False = Nao Deletada         ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
������������������������������������������������������������������������������*/
Static Function NwDeleted(oObjeto,nLinha)                                       
Local nCol := Len(oObjeto:aCols[1])                                             
Local lRet := .T.                                                               
// Se nLinha nao for preenchida Retorna a Posicao de nAt do Objeto              
Default nLinha := oObjeto:nAt                                                   
	// Alimenta Celula com novo Valor                                             
	lRet := oObjeto:aCols[nLinha,nCol]                                            
Return(lRet)                                                                    


User Function dadosgrv()

	If EMPTY(ALLTRIM(M->F1_NFENRDI)) 
		MsgInfo("Preencha corretamente o N�mero da DI !")
		Return .F.
	Endif 

	If EMPTY(M->F1_NFEDTDI) 
		MsgInfo("Preencha corretamente a Data da DI !")
		Return .F.
	Endif                                    
	
	If EMPTY(ALLTRIM(M->F1_NFELOC)) 
		MsgInfo("Preencha corretamente o Local de desembarque !")
		Return .F.
	Endif                                                    
	
	If EMPTY(ALLTRIM(M->F1_NFEUF)) 
		MsgInfo("Preencha corretamente a UF do local do Desembarque !")
		Return .F.
	Endif                                                          
	
	If EMPTY(M->F1_NFEDES)
		MsgInfo("Preencha corretamente a Data do Desembarque !")
		Return .F.
	Endif
	
	reclock("SF1",.F.)
		SF1->F1_NFENRDI := M->F1_NFENRDI
		SF1->F1_NFEDTDI := M->F1_NFEDTDI
		SF1->F1_NFELOC  := M->F1_NFELOC
		SF1->F1_NFEUF   := M->F1_NFEUF
		SF1->F1_NFEDES  := M->F1_NFEDES                               
		
		SF1->F1_VTRANS  := M->F1_VTRANS
		SF1->F1_VAFRMM  := M->F1_VAFRMM  
		SF1->F1_INTERM  := M->F1_INTERM                      
		SF1->F1_CNPJAE	:= M->F1_CNPJAE                      
		SF1->F1_UFTERC	:= M->F1_UFTERC  
	SF1->(MSUNLOCK())
	
	For nI:= 1 to len(oGetDados1:aCols)  
		nPosAdic := ASCAN(OgETDADOS1:AHEADER,{|X| ALLTRIM(X[2]) == "D1_NFEADIC"})
		nPosItem := ASCAN(OgETDADOS1:AHEADER,{|X| ALLTRIM(X[2]) == "D1_NFEITAD"})
		nPosFabr := ASCAN(OgETDADOS1:AHEADER,{|X| ALLTRIM(X[2]) == "D1_NFEFABR"})
		nPosProd := ASCAN(OgETDADOS1:AHEADER,{|X| ALLTRIM(X[2]) == "D1_COD"})
		nItemNF  := ASCAN(OgETDADOS1:AHEADER,{|X| ALLTRIM(X[2]) == "D1_ITEM"})
		nPosValII := ASCAN(OgETDADOS1:AHEADER,{|X| ALLTRIM(X[2]) == "D1_II"})
		nPosAliqII:= ASCAN(OgETDADOS1:AHEADER,{|X| ALLTRIM(X[2]) == "D1_ALIQII"})

		IF EMPTY(oGetDados1:aCols[NI,nPosAdic]) .OR. EMPTY(oGetDados1:aCols[NI,nPosItem])
			MsgInfo("Preencha a Adi��o e Item de todos os Produtos !")
			Return .F. 
		Endif     
		
		IF oGetDados1:aCols[NI,nPosValII] = 0  .OR. oGetDados1:aCols[NI,nPosAliqII] = 0
			MsgInfo("Preencha o Valor do II e a Aliquota Correspondente de cada item dos Produtos !")
			Return .F. 
		Endif     
		
		DBSELECTAREA("SD1")
		DBSETORDER(1)
		IF SD1->(DBSEEK(XFILIAL("SD1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA+oGetDados1:aCols[NI,nPosProd]+oGetDados1:aCols[NI,nItemNF]))
			reclock("SD1",.F.)
				SD1->D1_NFEADIC := oGetDados1:aCols[NI,nPosAdic]
				SD1->D1_NFEITAD := oGetDados1:aCols[NI,nPosItem]
				SD1->D1_NFEFABR := oGetDados1:aCols[NI,nPosFabr]                      
				SD1->D1_II 		:= oGetDados1:aCols[NI,nPosValII]                      
				SD1->D1_ALIQII 	:= oGetDados1:aCols[NI,nPosAliqII]                      
			SD1->(MSUNLOCK())	
		Endif
	Next
	
Return .T.