#include 'protheus.ch'
#include 'topconn.ch'
#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPPVALPX1  บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA DE PRE-PEDIDO DE VENDA                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

USER FUNCTION SIGACRM()

U_PPVALPX1()    

WHILE !MSGNOYES("Finalizando Sistema Pre-Pedido")
	U_PPVALPX1()    	
ENDDO	

Final(Time()+" Finalizando Processo Pre-Pedido")
RETURN

User Function PPVALPX1()    

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private cCadastro := "Pr้-Pedido de venda"
Private _xCodPro := Space(len(SB1->B1_COD))


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta um aRotina proprio                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private aRotina := { {"Pesquisar"     ,"AxPesqui"  ,0,1} ,;
                     {"Visualizar"    ,"U_MULTLI"  ,0,2} ,;
                     {"Incluir"       ,"U_MULTLI"  ,0,3} ,;
                     {"Alterar"       ,"U_MULTLI"  ,0,4} ,;
                     {"Excluir"       ,"U_MULTLI"  ,0,5} ,; 
{"Gerar Pedido"  ,"msginfO('DESABILITADO...')",0,6} ,;                     
                     {"Legenda"       ,"U_LEGDESC" ,0,2}  } // Relat๓rios de Alunos que estใo vendidos para cursos, mais nใo constam em Turmas.
//                     {"Gerar Pedido"  ,"U_EFETIVPV",0,6} ,;

dbSelectArea("ZBH")
dbSetOrder(1)
dbGoTop()                                                
Private aCores   := {} 
           
aCores := {{"ZBH_STATUS == '0'", "BR_VERDE"   },;	 //  ABERTO
           {"ZBH_STATUS == '1'", "BR_AZUL"    }}     //  Concluido

mBrowse( 6,1,22,75,"ZBH",,,,,,aCores,,,,) //Posi็ใo 15, chama a fun็ใo na inicializa็ใo da mBrowse, com cursos terminandos.

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLEGDESC   บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLEGENDA DA ROTINA                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function LEGDESC()
            
	Local aLegenda := {	{"BR_VERDE"    ,"Aberto        " },;
						{"BR_AZUL"     ,"Efetuado      "  } }
 												
	BrwLegenda("Legenda","Status do pr้-pedido",aLegenda)
                             
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณmultli    บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMODELO 3 DA ROTINA PARA VISUALIZAR/INCLUIR/ALTERAR/EXCLUIR  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function multli(cAlias, nReg, nOpc) //ROTINA DE MODELO3 E GRAVAวรO E EXCLUSรO DOS DADOS

Local cQry        := ""

Private aHeader   := {}            //ARRAY DO CABEวALHO DOS ITENS DO GETDADOS
Private aCols     := {}            //ARRAY DOS DADOS DOS ITENS DO GETDADOS
Private cAliCab   := "ZBH"
Private cAliIte   := "ZBI"
Private acord     := {10,10,500,700}
Private CREG      := RECNO()             //ZZ3->ZZ3_FILIAL+ZZ3->ZZ3_COD+ZZ3->ZZ3_CURSO+DTOS(ZZ3->ZZ3_DTINIC) 
Private lOpc      := .F.
regtomemory(cAliCab, nOpc == 3 )

fmontahead()
fmontacols(nOpc)
                                                                        
lRet := modelo3(cCadastro, cAliCab, cAliIte, ,"AllwaysTrue", "AllwaysTrue", nOpc, nOpc,,,,,,,acord)

// Executa processamento
If  lRet
	fProcessa(nOpc)	
End           

DBSELECTAREA("ZBH")
ZBH->(dbGoto(CReg))

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfProcessa บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA AUXILIAR DE PROCESSAMENTO DOS DADOS                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fProcessa(nOpc) // Processa a confirmacao da tela

LOCAL nI , nY , nX 
LOCAL lDel := .F. 

nX := 1                        //INICIALIZA O CONTADOR DE LINHAS DO GETDADOS

IF nOpc <> 5    	                 // SE NรO FOR EXCLUSรO        		
	DBSELECTAREA("ZBH") 
	dbsetorder(1)        		
	IF Dbseek(xFilial("ZBH")+M->ZBH_CODIGO)
		IF ZBH->ZBH_STATUS <> "0"
			MSGALERT("Este Pr้-Pedido jแ foi Efetuado e nใo pode ser Alterado","ALERTA")
			Return
		endif
	endif 
	IF nOpc == 3
		RecLock("ZBH", .T.) 
			ZBH->ZBH_FILIAL :=  xFilial("ZBH")
			ZBH->ZBH_CODIGO :=  M->ZBH_CODIGO
			ZBH->ZBH_STATUS :=  "0"
			ZBH->ZBH_DATA   :=  M->ZBH_DATA  
			ZBH->ZBH_CODUSR :=  M->ZBH_CODUSR
			ZBH->ZBH_CLIENT :=  M->ZBH_CLIENT
			ZBH->ZBH_LOJA   :=  M->ZBH_LOJA  
		ZBH->(msUnLock())
	ELSE
		cQry :=" UPDATE "+retSqlName("ZBH")+" SET ZBH_CLIENT = '"+M->ZBH_CLIENT+"', ZBH_LOJA = '"+M->ZBH_LOJA+"' " 
		cQry +=" WHERE ZBH.D_E_L_E_T_ = '' AND ZBH_CODIGO = '"+M->ZBH_CODIGO+"' AND ZBH_FILIAL = '"+xFilial("ZBH")+"'  "
		TCSQLEXEC(cQry) 		
	ENDIF      
	dbSelectArea("ZBI")
	ZBI->(dbSetOrder(1)) //ZBI_FILIAL+ZBI_CODIGO+ZBI_ITEM                                                                        	
	For nI :=1 to len(aCols)
		lAchou := ZBI->(dbSeek(xFilial("ZBI")+M->ZBH_CODIGO+aCols[nI][1] ) )
		If !aCols[nI][len(aHeader)+1]                                 //SE A LINHA NรO ESTIVER APAGADA
			RecLock("ZBI",!lAchou)
			For nY := 1 to len(aHeader)	
				If aHeader[nY][10] <> 'V'                             //SE O CAMPO NรO FOR VIRTUAL
					ZBI->&(aHeader[nY][2]) := aCols[nI][nY]	          //GRAVA OS ITENS DA LINHA
				Endif	
			Next
			ZBI->ZBI_FILIAL :=  xFilial("ZBH")  //GRAVA AS AMARRAวีES ENTRE AS TABELAS
			ZBI->ZBI_CODIGO :=  M->ZBH_CODIGO   //GRAVA AS AMARRAวีES ENTRE AS TABELAS
			ZBI_ITEM        := STRZERO(nX,3)    //GRAVA A POSIวรO DA LINHA NO CAMPO DA TABELA
			ZBI->(msUnLock())                   //DESBLOQUEIA O REGISTRO
			nX := nX + 1                        //INCREMENTA O NฺMERO DA LINHA
		Else                                    //SE A LINHA ESTIVER APAGADA
			if lAchou                           //SE HOUVER REGISTRO NA TABELA 
				RecLock("ZBI",!lAchou)
					ZBI->(dbDelete())               //APAGA O REGISTRO DA TABELA
				ZBI->(msUnLock())
			Endif
		Endif
	Next nI
	//FIM DA GRAVAวรO DOS ITENS
	ZBI->(dbcloseArea())
ELSE                     //SE FOR EXCLUSAO
	If M->ZBH_STATUS<>"0"
		Alert("Nใo ้ possํvel deletar."+CRLF+"Pr้-Pedido jแ Efetuado","Alerta")
		Return
	Endif
	// Deleta os Itens 
	dbSelectArea("ZBI")
	ZBI->(dbSetOrder(1))
	ZBI->(dbSeek(xFilial("ZBI")+M->ZBH_CODIGO))
	DO While ZBI->(!eof()) .and. ZBI->ZBI_FILIAL == xFilial("ZBI") .and. ZBI->ZBI_CODIGO == M->ZBH_CODIGO 
		RecLock("ZBI",.F.)
			ZBI->(dbDelete())
		ZBI->(MsUnLock())
		ZBI->(dbSkip())
	Enddo      
	dbSelectArea("ZBI")
	ZBI->(dbCloseArea())
	// Deleta o Cabecalho
	dbSelectArea("ZBH")
	RecLock("ZBH",.F.)
		ZBH->(dbDelete())
	ZBH->(MsUnLock())
	dbSelectArea("ZBH")
	ZBH->(dbCloseArea())        
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPPVALPX1  บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA DE PRE-PEDIDO DE VENDA                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static function fmontahead()

SX3->(dbsetorder(1))
SX3->(dbSeek(cAliIte )  )
While SX3->(!EOF()) .AND. SX3->X3_ARQUIVO == cAliIte	
	If X3USO(SX3->X3_USADO) .AND. cNIVEL >= SX3->X3_NIVEL
		AADD( AHeader, { SX3->X3_TITULO,;
		SX3->X3_CAMPO,; //NOME DO CAMPO
		SX3->X3_PICTURE,;
		SX3->X3_TAMANHO,;
		SX3->X3_DECIMAL,;
		SX3->X3_VALID,;
		SX3->X3_USADO,;
		SX3->X3_TIPO,;
		SX3->X3_ARQUIVO,;
		SX3->X3_CONTEXT})  //VIRTUAL
	Endif
	SX3->(dbskip())
Enddo                                  
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPPVALPX1  บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA DE PRE-PEDIDO DE VENDA                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static function fmontacols(nOpc)

LOCAL I := 0

If nOpc == 3 //inclusao
	AADD(aCols, array(len(aHeader)+1) )
	For I:=1 to len(aHeader)
		aCols[1][I] := criavar(aHeader[I][2])	
	Next
	aCols[1][len(aHeader)+1] := .F.
	aCols[1][1] := STRZERO(+1,3)	
	
else //alteracao, visualizacao, exclusao
	ZBI->(dbSetOrder(1))
	ZBI->(dbSeek(xFilial("ZBI")+M->ZBH_CODIGO))
	While ZBI->(!EOF()) .and. ZBI->ZBI_FILIAL == xFilial("ZBI") .and. M->ZBH_CODIGO == ZBI->ZBI_CODIGO
		AADD(aCols, array(len(aHeader)+1) )		
		For I:=1 to len(aHeader)
			If aHeader[I][10] <> "V"
				aCols[LEN(aCols)][I] := ZBI->&(aHeader[I][2])	
			Else
				aCols[LEN(aCols)][I] := criavar(aHeader[I][2])
			endif
		Next
		aCols[Len(aCols)][Len(aHeader)+1] := .F.
		ZBI->(dbSkip())
	Enddo
Endif

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPPVALPX1  บAutor  ณMicrosiga           บ Data ณ  27/01/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA DE VALIDAวรO DA LINHA DO ACOLS                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static function ADV0014B() // funcao que valida a linha do aCols

Local LretB:= .T.
LOCAL nJ := 0 

//VALIDAวรO SE O ALUNO Jม EXISTE NA MESMA TURMA BEGIN
nPosALU := aScan( aHeader, { |x| alltrim(x[2]) == "ZZ6_ALUNO" } ) //pego a posicao da coluna aluno
If (!aCols[n][len(aHeader)+1] )                                   // se a linha que estou digintando nao estiver apagada	
	For nJ:=1 to len(aCols)                                       //percorro as linha do acols
		If ( nJ != n .And. !aCols[nJ][len(aHeader)+1])            // compara com as outras linhas (que nao seja a que eu estou)	
			If aCols[n][nPosALU] == aCols[nJ][nPosALU]            // se ele econtrar igual
				Alert("Aluno cadastrado nesta turma."+CRLF+"Escolha outro aluno.","ADV0014 - Cadatro de Turmas")    
				LretB:=	.F.										 // a validacao bloqueia meu registro e retorna uma mensagem na tela
				//EXIT
			Endif
		Endif
	Next
endif
//VALIDAวรO SE O ALUNO Jม EXISTE NA MESMA TURMA END

//VALIDAวรO SE ALUNO TEM PRESENวA LANวADA BEGIN
If (aCols[n][len(aHeader)+1] )                                 // SE A LINHA EM QUE SE ESTA ESTIVER APAGADA	
	ZBI->(dbSetOrder(1))                                       //ZBI_FILIAL+ZBI_COD+ZBI_CODALU
	ZBI->(dbSeek(xFilial("ZBH")+M->ZBH_COD+aCols[n][nPosALU])) //POSICIONA NO REGISTRO DA TABELA ZBI COM O MESMO CODIGO DO CURSO E DO CODIGO DO ALUNO
	While ZBI->(!EOF()) .And. ZBI->ZBI_COD == M->ZBH_COD .And. ZBI->ZBI_FILIAL == xFilial("ZBH") //CODIGO E FILIAL IGUAIS AO REGISTRO
		If !Empty(ZBI->ZBI_HORACH) .And. !Empty(ZBI->ZBI_HORASA) .And. ZBI->ZBI_CODALU == aCols[n][nPosALU]//SE AS HORAS DE ENTRADA E SAอDA ESTIVEREM VAZIAS
			Alert("Nใo ้ possํvel deletar."+CRLF+"Aluno jแ possui presen็a cadastrada.","ADV0014 - Cadatro de Turmas")//E FOREM DO ALUNO EM QUESTรO
			aCols[n][len(aHeader)+1] := .F.                    //INICIALIZA COMO NรO APAGADO A LINHA EM QUESTรO
			EXIT                                               //SAI DO LOOP
		Endif
		ZBI->(dbSkip()) 
	Enddo
	ZBI->(dbcloseArea())
Endif
//VALIDAวรO SE ALUNO TEM PRESENวA LANวADA END

Return(LretB)