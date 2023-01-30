/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³EFETIVPV  ³ Autor ³ MICROSIGA             ³ Data ³26/01/2015  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gera Pedido de Venda                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ EFETIVAPV()    	                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ALPAX                                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                           


USER Function EFETIVPV()

Local _aArea		:= GetArea()											// salva area corrente
Local _aAreaZBH		:= ZBH->(GetArea())									    // salva area ZBH
Local _aAreaZBI		:= ZBI->(GetArea())								     	// salva area ZBI
Local _aCabSC5		:= {}													// array cabecalho pedido de venda
Local aItens    	:= {}													// array itens pedido de venda
Local _aSC6Itens	:= {}													// array itens pedido de venda
Local _aLinha		:= {}													// array auxiliar itens pedido de venda
Local _nSaldo		:= 0													// saldo a ser efetivado pedido de venda
Local _nPrcVen		:= 0													// preco de venda
Local _nI           := 0
Local cQry          := ""                   
Local cAlias        := GetNextAlias()
Local _cItem		:= "00"													// sequencial do item
Local _cCodRepA		:= ""
Local _cLojaRepA	:= ""
Local _lRet			:= .T.													// retorno da funcao

Private lMsHelpAuto	:= .F.													// MSEXECAUTO
Private lMsErroAuto	:= .F.													// MSEXECAUTO

SA1->(dbSetOrder(1))
SB1->(dbSetOrder(1))
SB2->(dbSetOrder(1))
SF4->(dbSetOrder(1))

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

cQry := "SELECT * "
cQry += "FROM "+retSqlName("ZBI")+" ZBD "
cQry += "WHERE ZBD.D_E_L_E_T_ = '' AND ZBD_FILIAL = '"+xFilial("ZBD")+"' AND ZBD_COD = '"+ZBH->ZBH_CODUSR+"' "
MEMOWRITE("D:\EFETIVAPV1.SQL",cQry) //GRAVA A QUERY EM ALGUM LUGAR DO HD 
if tcSQLexec(cQry) < 0   //para verificar se a query funciona
	msginfo("Erro na consulta ao Banco de Dados Favor entrar em contato com Depto TI")
	return
Endif

dbUseArea(.T., "TOPCONN",TCGENQRY(,,cQry),cAlias,.F.,.T.)

cTPop := (cAlias)->ZBD_TPOP

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

// Seleciona os produtos do cliclo e seus representantes
cQry := "SELECT * "
cQry += "FROM "+retSqlName("ZBI")+" ZBI "
cQry += "WHERE ZBI.D_E_L_E_T_ = '' AND ZBI_FILIAL = '"+xFilial("ZBI")+"' AND ZBI_CODIGO = '"+ZBH->ZBH_CODIGO+"' "

MEMOWRITE("D:\EFETIVAPV2.SQL",cQry) //GRAVA A QUERY EM ALGUM LUGAR DO HD 

if tcSQLexec(cQry) < 0   //para verificar se a query funciona
	msginfo("Erro na consulta ao Banco de Dados Favor entrar em contato com Depto TI")
	return
Endif

dbUseArea(.T., "TOPCONN",TCGENQRY(,,cQry),cAlias,.F.,.T.)

Begin Transaction				

aItens   	:={}
DO WHILE (cAlias)->(!EOF())                 
	SA1->(dbSeek(xFilial("SA1")+ZBH->ZBH_CLIENT+ZBH->ZBH_LOJA ))	
	SB1->(dbSeek(xFilial("SB1")+(cAlias)->ZBI_CODPRO))								// posiciona SB1				
	_aLinha:={}
	Aadd(_aLinha,{"C6_ITEM"		,(cAlias)->ZBI_ITEM 									,Nil})
	Aadd(_aLinha,{"C6_PRODUTO"	,SB1->B1_COD            								,Nil})
	Aadd(_aLinha,{"C6_UM"		,SB1->B1_UM												,Nil})
	Aadd(_aLinha,{"C6_QTDVEN"	,(cAlias)->ZBI_QTDE										,Nil})
	Aadd(_aLinha,{"C6_PRCVEN"	,(cAlias)->ZBI_VUNI  								    ,Nil})
	Aadd(_aLinha,{"C6_VALOR"	,A410Arred((cAlias)->ZBI_QTDE * (cAlias)->ZBI_VUNI,"C6_VALOR")			,Nil})
	Aadd(_aLinha,{"C6_QTDLIB"	,0														,Nil})
	Aadd(_aLinha,{"C6_OPER"		,cTPop   												,Nil})
	Aadd(_aLinha,{"C6_LOCAL"	,"01"    												,Nil})
	Aadd(_aLinha,{"C6_PRUNIT"	,(cAlias)->ZBI_VUNI              	    				,Nil})
	Aadd(aItens,_aLinha)				
	(cAlias)->(dbSkip())
EndDO
		
if len(aItens) > 0
	// Monta cabecalho do pedido de vendas
	_aCabSC5:={}	
	Aadd(_aCabSC5,{"C5_TIPO"		,"N"						,Nil})
	Aadd(_aCabSC5,{"C5_CLIENTE"		,SA1->A1_COD				,Nil})
	Aadd(_aCabSC5,{"C5_LOJACLI"		,SA1->A1_LOJA				,Nil})
	Aadd(_aCabSC5,{"C5_CLIENT"		,SA1->A1_COD				,Nil})
	Aadd(_aCabSC5,{"C5_LOJAENT"		,SA1->A1_LOJA				,Nil})
	Aadd(_aCabSC5,{"C5_TRANSP"		,SA1->A1_TRANSP				,Nil})
	Aadd(_aCabSC5,{"C5_CONDPAG"		,Iif(Empty(SA1->A1_COND),"001",SA1->A1_COND),Nil})
	Aadd(_aCabSC5,{"C5_TABELA"		,SA1->A1_TABELA				,Nil})
	Aadd(_aCabSC5,{"C5_TIPOCLI"		,SA1->A1_TIPO				,Nil})
	Aadd(_aCabSC5,{"C5_EMISSAO"		,dDataBase					,Nil})
	Aadd(_aCabSC5,{"C5_MOEDA"		,1							,Nil})
	
	lMsHelpAuto	:= .F.
	lMsErroAuto	:= .F.
	
	If !Empty(_aCabSC5)
		MsAguarde({|| MSExecAuto({|x,y,z| MATA410(x,y,z)},_aCabSC5,aItens,3)},"Gerando Pedido de Venda..." + AllTrim(SA1->A1_NREDUZ))
		If !lMsErroAuto
			ConfirmSx8()
			//Atualiza quantidade empenhada no ciclo por representantes
			RestArea(_aAreaZBH)
			dbSelectArea("ZBH")
			RecLock("ZBH",.F.)
				ZBH->ZBH_STATUS := "1"
				ZBH->ZBH_PEDIDO := SC5->C5_NUM
			MsUnLock()
		Else
			RollBackSx8()
			MostraErro()
			DisarmTransaction()
		EndIf
	EndIf
Endif

End Transaction

IF SELECT(cAlias) > 0
	dbSelectArea(cAlias)
	dbCloseArea()
ENDIF

RestArea(_aAreaZBI)
RestArea(_aAreaZBH)
RestArea(_aArea)

Return()