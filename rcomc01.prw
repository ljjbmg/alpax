#include "Protheus.ch"
#include "topconn.ch"
#include 'rwmake.ch'              
#include 'FileIO.ch'
#include 'TbiCode.ch'
#include 'TbiConn.ch'
#INCLUDE 'FWMVCDEF.CH'
#INCLUDE "FWMBROWSE.CH" 

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥RFATC01   ∫Autor  ≥ljjbmg                                   ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Tela de Sugest„o de Compra                                 ∫±±
±±∫          ≥                                                            ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥ Alpax                                                      ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

User Function RCOMC01()

	Local oBmp 		:= nil
	Local oChk 		:= nil
	Local lCresc 	:= nil
	Local oMOTBX 	:= nil
	Local oBtnMarcTod := nil
	Local oBtnPesq	:= nil
    Local oBtnAlt
	Local aObjects 	:= {}                           
	Local aInfo 	:= {}
	Local aPosObj 	:= {}
	Local aSize		:= MsAdvSize()
	local aButtons	:= {}
	Local cPerg		:= 'RCOMP01'

	Local aHeader	:= {"Referencia","Codigo","Descricao","Capacidade","Marca","PontoPedido","Arm. RC","Arm. TS","Estoque","PedidoLiberado","DataEntrega","PedidoCompra","Sugest„o","Ult.Prc","Giro1Mes","Giro3meses","Giro6meses","Giro12meses","Tes","Fornecedor","Loja","Cod.Pag","Gerado" }
	Local cIndex := ""
	
	Private oBL 	:= LoadBitmap(GetResources(),"BR_PRETO")
	Private oPD 	:= LoadBitmap(GetResources(),"BR_PINK")  
	Private oOK 	:= LoadBitmap(GetResources(),"BR_VERDE")  
	Private oOS 	:= LoadBitmap(GetResources(),"BR_AZUL")  
	Private VISUAL 	:= .F.
	Private INCLUI 	:= .F.
	Private ALTERA 	:= .T.
	Private DELETA 	:= .F.
	Private oLbx1 	:= nil
	Private oOk2	:= LoadBitMap(GetResources(), "LBOK")
	Private oNo2	:= LoadBitMap(GetResources(), "LBNO")
	Private cEol	:= chr(13)+chr(10)
	Private oDlgSug	
	Private aDados	:= {}
	Private dDtInic 
	Private dDtFim	
	Private cMv03
	Private cMv04
	oSize := FwDefSize():New( .T.)
	
	//Define a tecla de atalho para o pesquisar
	SetKey(VK_F12,{|| fpesq  (aSize,cIndex,oMOTBX) })   
	SetKey(VK_F10,{|| fItem  ( oLbx1:AARRAY[oLbx1:nAt][1],oLbx1:AARRAY[oLbx1:nAt][2],aSize ) })
	//SetKey(VK_F7, {|| gSolCom( aHeader )}, "Gerando Solicitacao de Compra")   })

	//Cria perguntas 
	Validperg(cPerg)

	//Exibe a tela com as perguntas
	IF !Pergunte(cPerg, .T.)
		Return nil
	Endif

 	dDtInic := MV_PAR01
	dDtFim	:= MV_PAR02
	cMv03	:= MV_PAR03
	cMv04	:= MV_PAR04

	//Execucao de query
	Processa({|| aDados:=SelDados()},"Gerando dados...")

	//Adiciona botoes
	Aadd(aButtons,{"SALARIOS",	{|| fItem( oLbx1:AARRAY[oLbx1:nAt][1],oLbx1:AARRAY[oLbx1:nAt][2],aSize )},"Consulta Itens","Consulta Itens"})
	Aadd(aButtons,{"CONTAINR",	{|| Processa( {|| gSolCom( aHeader )}, "Gerar Pedido Compra") },"Gerar Pedido Compra","Gerar Pedido Compra"})
	Aadd(aButtons,{"EXCEL",		{|| Processa( {|| fExcel ( oLbx1:AARRAY, Len(oLbx1:AARRAY),aHeader)}, "Relatorio Excel") },"Relatorio Excel","Relatorio Excel"})
//	Aadd(aButtons,{"Mail",	{|| Processa( {|| EXCELMAIL( oLbx1:AARRAY, Len(oLbx1:AARRAY),aHeader)}, "Enviar Excel") },"Enviar Excel","Enviar Excel"})
	If Len(aDados) > 0 //Se nao houver dados nao abre a tela

		//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
		//≥ Define a area dos objetos		                                            ≥
		//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
		AAdd( aObjects, { 000, 100, .t., .t. } )
		AAdd( aObjects, { 100, 015, .t., .f. } )
		aInfo 		:= { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } 
		aPosObj		:= MsObjSize( aInfo, aObjects ) 
		
		Define MSDialog oDlgSug Title "Sugestao de Compras" From aSize[7],00 TO (aSize[6]),aSize[5] Of oMainWnd Pixel
		
		@ 33,0 LISTBOX oLbx1 FIELDS HEADER 	"",;
        "",;
		aHeader[01],;
		aHeader[02],;
		aHeader[03],;
		aHeader[04],;
		aHeader[05],;
		aHeader[06],;
		aHeader[07],;
		aHeader[08],;
		aHeader[09],;
		aHeader[10],;
		aHeader[11],;
		aHeader[12],;
        aHeader[13],;
		aHeader[14],;
		aHeader[15],;
        aHeader[16],;
		aHeader[17],;
		aHeader[18],;
        aHeader[19],;
        aHeader[20],;
		aHeader[21],;
		aHeader[22],;
		aHeader[23];
		SIZE (oDlgSug:NCLIENTWIDTH)*0.5,(oDlgSug:NCLIENTHEIGHT)*0.3 OF oDlgSug PIXEL ; 
		ON dblClick( oLbx1:AARRAY[oLbx1:nAt,24] := !oLbx1:AARRAY[oLbx1:nAt,24],oLbx1:Refresh(),oLbx1:SetFocus() )

		oLbx1:SetArray(aDados)
   		oLbx1:bLine := { || {		Iif(aDados[oLbx1:nAt,24],oOk2,oNo2),; //Marcacao de processamento
		Iif(AllTrim(aDados[oLbx1:nAt,23])=="S", oBL, Iif(AllTrim(aDados[oLbx1:nAt,23])=="C",oPD,Iif(AllTrim(aDados[oLbx1:nAt,23])=="Z",oOs, oOK))),; //Legenda ID
		aDados[oLbx1:nAt,01],;//Referencia
		aDados[oLbx1:nAt,02],;//CÛdigo
		aDados[oLbx1:nAt,03],;//DescriÁ„o
        aDados[oLbx1:nAt,04],;//Capacidade
		aDados[oLbx1:nAt,05],;//Marca
		Transform(aDados[oLbx1:nAt,06],"@E 999,999,999.99"),; //Ponto Pedido
		Transform(aDados[oLbx1:nAt,07],"@E 999,999,999.99"),; //Arm. RC
		Transform(aDados[oLbx1:nAt,08],"@E 999,999,999.99"),; //Arm. TS 
		Transform(aDados[oLbx1:nAt,09],"@E 999,999,999.99"),; //Estoque oPD oPD
		Transform(aDados[oLbx1:nAt,10],"@E 999,999,999.99"),; //Pedido Liberado
		aDados[oLbx1:nAt,11],;//MÍs Ano Entrega
		Transform(aDados[oLbx1:nAt,12],"@E 999,999,999.99"),; //Pedido Compra
		Transform(aDados[oLbx1:nAt,13],"@E 999,999,999.99"),; //Sugest„o Compra
		Transform(aDados[oLbx1:nAt,14],"@E 999,999,999.99"),; //Preco
		Transform(aDados[oLbx1:nAt,15],"@E 999,999,999.99"),; //Giro 1 Mes
		Transform(aDados[oLbx1:nAt,16],"@E 999,999,999.99"),; //Giro 3 Meses
		Transform(aDados[oLbx1:nAt,17],"@E 999,999,999.99"),; //Giro 6 Meses
		Transform(aDados[oLbx1:nAt,18],"@E 999,999,999.99"),; //Giro 12 Meses
		aDados[oLbx1:nAt,19],;//TES
		aDados[oLbx1:nAt,20],;//Fornecedor
		aDados[oLbx1:nAt,21],;//Loja
		aDados[oLbx1:nAt,22],;//Cond.Pag
        aDados[oLbx1:nAt,23],;//Gerado
		}}
		oDlgSug:Refresh()
		oLbx1:Refresh()
		oLbx1:SetFocus()		

		@ (oDlgSug:NCLIENTHEIGHT)*0.40,  001	TO (oDlgSug:NCLIENTHEIGHT)*0.45, 310 LABEL "Indicador" OF oDlgSug PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.42,  005	MSCOMBOBOX oMOTBX 	VAR cIndex ITEMS aHeader size 80,10 of oDlgSug pixel
		@ (oDlgSug:NCLIENTHEIGHT)*0.42,  100	CheckBox oChk 		VAR lCresc PROMPT "Crescente?" SIZE 50,10 Of oDlgSug PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.410, 150 	BUTTON oBtnMarcTod	PROMPT "Ordenar"	SIZE 75,10 OF oDlgSug	PIXEL ACTION ( MsgRun("Sugest„o de Compras"," Ordenando... ",{||fOrdem(oMOTBX,lCresc) }) )
		@ (oDlgSug:NCLIENTHEIGHT)*0.430, 150 	BUTTON oBtnPesq		PROMPT "Pesquisar"	SIZE 75,10 OF oDlgSug	PIXEL ACTION ( fpesq(aSize,cIndex,oMOTBX) )
		@ (oDlgSug:NCLIENTHEIGHT)*0.410, 230 	BUTTON oBtnAlt		PROMPT "Alterar"	SIZE 75,10 OF oDlgSug	PIXEL ACTION {|| altreg( aHeader )}

		@ (oDlgSug:NCLIENTHEIGHT)*0.40,340 	TO (oDlgSug:NCLIENTHEIGHT)*0.45, 500 LABEL "Legenda" OF oDlgSug PIXEL	
		@ (oDlgSug:NCLIENTHEIGHT)*0.410,370 BITMAP oBmp RESNAME "BR_VERDE" 		oF oDlgSug SIZE 25,30 NOBORDER WHEN .F. PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.423,370 BITMAP oBmp RESNAME "BR_PINK" 		oF oDlgSug SIZE 25,30 NOBORDER WHEN .F. PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.436,370 BITMAP oBmp RESNAME "BR_PRETO" 		oF oDlgSug SIZE 25,30 NOBORDER WHEN .F. PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.410,440 BITMAP oBmp RESNAME "BR_AZUL"		oF oDlgSug SIZE 25,30 NOBORDER WHEN .F. PIXEL

		@ (oDlgSug:NCLIENTHEIGHT)*0.410,380 SAY "Gerar"			SIZE 245, 10 OF oDlgSug PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.423,380 SAY "Vencto Curto"	SIZE 245, 10 OF oDlgSug PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.436,380 SAY "Gerado"		SIZE 245, 10 OF oDlgSug PIXEL
		@ (oDlgSug:NCLIENTHEIGHT)*0.410,450 SAY "Sazonal"		SIZE 245, 10 OF oDlgSug PIXEL

		Activate MSDialog oDlgSug On Init EnchoiceBar(oDlgSug,{|| (oDlgSug:End())},{|| (oDlgSug:End())},,aButtons)
	Else
		MsgInfo("Nao ha dados para a pesquisa !")           
	EndIf

Return nil


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥Validperg ∫Autor  ≥                             ∫ Data ≥    ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Cria as perguntas da rotina                                ∫±±
±±∫          ≥                                                            ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥                                                            ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/

Static Function Validperg(cPerg)

	PutSx1( cPerg, "01","Dt. Entrega de?   "		,"","","MV_CH1","D", 08,0,0,"G","","   "	,"","","mv_par01","","","","","","","","","","","","","","","","",{"Informe a data inicial.  			","    "  },{},{})
	PutSx1( cPerg, "02","Dt. Entrega Ate?  "		,"","","MV_CH2","D", 08,0,0,"G","","   "	,"","","mv_par02","","","","","","","","","","","","","","","","",{"Informe a data final.    			","    "  },{},{})
	PutSx1( cPerg, "03","Produto de? "				,"","","MV_CH3","C", 02,0,0,"G","","SB1"	,"","","mv_par03","","","","","","","","","","","","","","","","",{"Informe o Produto Inicial.         	","    "  },{},{})
	PutSx1( cPerg, "04","Produto de? "				,"","","MV_CH4","C", 02,0,0,"G","","SB1"	,"","","mv_par04","","","","","","","","","","","","","","","","",{"Informe o Produto Final.         	","    "  },{},{})
	PutSx1( cPerg, "05","Grupo de? "				,"","","MV_CH5","C", 02,0,0,"G","","SBM"	,"","","mv_par05","","","","","","","","","","","","","","","","",{"Informe o Grupo Inicial.         	","    "  },{},{})
	PutSx1( cPerg, "06","Grupo Ate? "				,"","","MV_CH6","C", 02,0,0,"G","","SBM"	,"","","mv_par06","","","","","","","","","","","","","","","","",{"Informe o Grupo Final.         		","    "  },{},{})
	PutSx1( cPerg, "07","Marca de? "				,"","","MV_CH7","C", 02,0,0,"G","","SZ2"	,"","","mv_par07","","","","","","","","","","","","","","","","",{"Informe a Marca Inicial.         	","    "  },{},{})
	PutSx1( cPerg, "08","Marca Ate? "				,"","","MV_CH8","C", 02,0,0,"G","","SZ2"	,"","","mv_par08","","","","","","","","","","","","","","","","",{"Informe a Marca Final.         		","    "  },{},{})

Return nil

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥SelDados  ∫Autor  ≥                            ∫ Data ≥     ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Funcao interna que executa a consulta no banco de dados    ∫±±
±±∫          ≥ e alimenta o array da tela.                                ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥                                                            ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function SelDados()

	Local nCont  := 0
	Local aAreaAtu	:= GetArea()
	Local aRet		:= {}
	Local aRet1		:= {}
	Local nRegAtu	:= 0
	Local x			:= 0
    Local cAliasMkb := GetNextAlias()

    BeginSql Alias cAliasMkb
    
        SELECT REFERENCIA, CODPRODUTO, DESPRODUTO, CAPACIDADE, MARPRODUTO, PONTOPEDIDO,RC,TS, ESTOQUE,PEDLIBERADO,
				DATAENTREGA, PEDIDOCOMPRA,  
				TRB.PONTOPEDIDO - TRB.ESTOQUE + (TRB.PEDLIBERADO - TRB.PEDIDOCOMPRA) AS SUGCOMPRA,
				PRC,GIRO1, GIRO3, GIRO6, GIRO12,TES,FORNECE, LOJA, COND,GERADO 
		FROM
		(SELECT 
		RTRIM(B1_PNUMBER) REFERENCIA,
		RTRIM(C9_PRODUTO) CODPRODUTO, 
		RTRIM(B1_DESC) DESPRODUTO,
		B1_CAPACID CAPACIDADE,
		B1_MARCA MARPRODUTO,
		ROUND(B1_EMIN,0) PONTOPEDIDO,
		Isnull((
			SELECT SUM(B2_QATU) 
			FROM %Table:SB2% SB2 (NOLOCK)
			WHERE 	B2_COD = C9_PRODUTO AND SB2.%NotDel% AND 
					B2_LOCAL IN ('01','RC','TS')),0) ESTOQUE,
		Isnull((
			SELECT SUM(B2_QATU) 
			FROM %Table:SB2% SB2 (NOLOCK)
			WHERE  	B2_COD = C9_PRODUTO AND SB2.%NotDel% AND  
					B2_LOCAL IN ('RC')),0) RC,
		Isnull((
			SELECT SUM(B2_QATU) 
			FROM %Table:SB2% SB2 (NOLOCK)
			WHERE  	B2_COD = C9_PRODUTO AND SB2.%NotDel% AND   
					B2_LOCAL IN ('TS')),0) TS,
		SUM(C9_QTDLIB) PEDLIBERADO, 
		'' DATAENTREGA,
		Isnull((
			SELECT SUM(B2_SALPEDI) 
			FROM %Table:SB2% SB2 (NOLOCK) 
			WHERE 	B2_COD = C9_PRODUTO AND  
					B2_LOCAL IN ('01','RC')),0) PEDIDOCOMPRA,
			CASE	WHEN B1_XVENCTO = '1' AND B1_XSAZ = ' ' THEN 'C' 
					WHEN B1_XSAZ = '1' AND B1_XVENCTO = ' ' THEN 'Z' 
					WHEN B1_XSAZ = '1' AND B1_XVENCTO = '1' THEN 'T' 
					ELSE ' ' END AS GERADO,
		COALESCE((
			SELECT SUM(D2_QUANT) 
			FROM %Table:SD2% SD2 (NOLOCK), %Table:SF4% F41 (NOLOCK)
			WHERE  	D2_COD = C9_PRODUTO AND SD2.%NotDel% AND F41.%NotDel%  
					AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' 
					AND CONVERT(DATE,D2_EMISSAO,103) 
					BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 1, 0) 
					AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) GIRO1,
		COALESCE((
			SELECT SUM(D2_QUANT) 
			FROM %Table:SD2% SD2 (NOLOCK), %Table:SF4% F41 (NOLOCK)
			WHERE  	D2_COD = C9_PRODUTO AND SD2.%NotDel% AND F41.%NotDel%  
					AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' 
					AND  CONVERT(DATE,D2_EMISSAO,103) 
					BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 3, 0) 
					AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) GIRO3,
		COALESCE((
			SELECT SUM(D2_QUANT) 
			FROM %Table:SD2% SD2 (NOLOCK), %Table:SF4% F41 (NOLOCK)
			WHERE  D2_COD = C9_PRODUTO AND SD2.%NotDel% AND F41.%NotDel%  
			AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' 
			AND  CONVERT(DATE,D2_EMISSAO,103) 
			BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 6, 0) 
			AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) GIRO6,
		COALESCE((
			SELECT SUM(D2_QUANT) 
			FROM %Table:SD2% SD2 (NOLOCK), %Table:SF4% F41 (NOLOCK)
			WHERE  D2_COD = C9_PRODUTO AND SD2.%NotDel% AND F41.%NotDel%  
			AND D2_TES = F4_CODIGO AND F4_ESTOQUE = 'S' 
			AND  CONVERT(DATE,D2_EMISSAO,103) 
			BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 12, 0) 
			AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) GIRO12,
		B1_TE TES, B1_XUPRC PRC,
		COALESCE((
			SELECT TOP 1 T1.D1_FORNECE	
			FROM %Table:SD1% T1 (NOLOCK)
			WHERE  	T1.D1_DTDIGIT = (SELECT MAX(T2.D1_DTDIGIT) DT 
									FROM %Table:SD1% T2 (NOLOCK)
									WHERE  	T2.D1_COD = C9_PRODUTO 
											AND T2.%NotDel%
									GROUP BY T2.D1_COD)  
					AND T1.D1_COD = C9_PRODUTO 
					GROUP BY D1_FORNECE),' ') FORNECE,
		COALESCE((
			SELECT DISTINCT T1.D1_LOJA	
			FROM %Table:SD1% T1 (NOLOCK) 
			WHERE  	T1.D1_DTDIGIT = (SELECT MAX(T2.D1_DTDIGIT) DT 
									FROM %Table:SD1% T2 (NOLOCK)
									WHERE  	T2.D1_COD = C9_PRODUTO 
											AND T2.%NotDel%
									GROUP BY T2.D1_COD)  
					AND T1.D1_COD = C9_PRODUTO 
					GROUP BY D1_LOJA),' ') LOJA,
		COALESCE((
			SELECT TOP 1 T3.F1_COND		
			FROM %Table:SD1% T1 (NOLOCK), %Table:SF1% T3 (NOLOCK)  
			WHERE  	T1.D1_DTDIGIT = (SELECT MAX(T2.D1_DTDIGIT) DT 
									FROM %Table:SD1% T2 (NOLOCK) 
									WHERE  T2.D1_COD = C9_PRODUTO 
									AND T2.%NotDel%
									GROUP BY T2.D1_COD)  
					AND T1.D1_COD = C9_PRODUTO 
					AND T1.D1_DOC = T3.F1_DOC 
					AND T3.%NotDel%
					AND T1.D1_SERIE = T3.F1_SERIE 
					AND T1.D1_FORNECE = T3.F1_FORNECE 
					AND T1.D1_LOJA = T3.F1_LOJA 
					GROUP BY F1_COND ),' ') COND 
		FROM %Table:SC9% SC9 (NOLOCK) INNER JOIN %Table:SB1% SB1 (NOLOCK)
                 ON B1_FILIAL = %xfilial:SB1%  AND B1_COD = C9_PRODUTO AND SB1.%NotDel% AND B1_COD BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
				AND B1_GRUPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
				AND B1_MARCA BETWEEN %exp:MV_PAR07% AND %exp:MV_PAR08%
                INNER JOIN %Table:SC6% SC6 (NOLOCK)
                ON C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM	AND C9_LOCAL = C6_LOCAL 
				AND C9_FILIAL = C6_FILIAL AND C6_ENTREG BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
		WHERE SC9.%NotDel% AND C9_NFISCAL = '' AND C9_LOCAL = '01'
		GROUP BY B1_PNUMBER,C9_PRODUTO, B1_DESC, B1_CAPACID, B1_MARCA, B1_EMIN, B1_XUPRC, B1_XVENCTO, B1_XSAZ, B1_TE ) TRB
		WHERE TRB.PONTOPEDIDO - TRB.ESTOQUE + (PEDLIBERADO - PEDIDOCOMPRA) > 0
		GROUP BY REFERENCIA, CODPRODUTO, DESPRODUTO, CAPACIDADE, MARPRODUTO, PONTOPEDIDO, ESTOQUE,
		DATAENTREGA, PEDIDOCOMPRA, PEDLIBERADO, GERADO,GIRO1, GIRO3, GIRO6, GIRO12,TES,FORNECE, LOJA, COND, PRC, RC, TS
		ORDER BY  MARPRODUTO, REFERENCIA

   EndSql

   aSql := GetLastQuery()
   cSql := aSql[2]
   MemoWrite("\queries\mkbrwse.sql",cSql)

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥ Definicao da primeira regua				     ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	(cAliasMkb)->(dbEval({|| nCont++},,{|| !EOF()}))
	ProcRegua(nCont)

	(cAliasMkb)->(dbGoTop())	
	aRet1	:= Array(fCount())
	nRegAtu	:= 1

//	If MV_PARxx = 1 //Pergunta: 
//		AADD(aRet1,.T.)   
//	Else
		AADD(aRet1,.F.)   	
//	EndIf

	While (cAliasMkb)->(!Eof())
		IncProc("Lendo Registros..."+Alltrim(str(nRegAtu))+"/"+Alltrim(str(nCont)) )
		For x:=1 to fCount()
			aRet1[x] := FieldGet(x)
		Next

		AADD(aRet,aclone(aRet1))
		(cAliasMkb)->(DbSkip())
		nRegAtu += 1
	Enddo

	(cAliasMkb)->(dbCloseArea())
	RestArea(aAreaAtu)

Return aRet

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥fOrdem    ∫Autor  ≥ljjbmg   ∫ Data ≥                        ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Funcao interna que ordena os itens do array da tela.       ∫±±
±±∫          ≥                                                            ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥                                                            ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function fOrdem(oMOTBX,lCresc)

	Local nIndice := oMOTBX:nat
	Local aOrig := aClone(oLbx1:AARRAY)
/*
	If lCresc
		aOrig := ASORT(aOrig,,, { |x, y| x[nIndice] < y[nIndice] }) //Crescente
	Else
		aOrig := ASORT(aOrig,,, { |x, y| x[nIndice] > y[nIndice] }) //Decrecente
	EndIf

	oLbx1:SetArray(aOrig)
    oLbx1:bLine := { || {	Iif(aOrig[oLbx1:nAt,22],oOk2,oNo2),; //Marcao de processamento
	Iif(AllTrim(aOrig[oLbx1:nAt,21])=="S", oBL,Iif(AllTrim(aOrig[oLbx1:nAt,21])=="C",oPD,Iif(AllTrim(aDados[oLbx1:nAt,21])=="Z", oOS, oOK))),; //Legenda ID
	aOrig[oLbx1:nAt,01],;//Referencia
    aOrig[oLbx1:nAt,02],;//CÛdigo
	aOrig[oLbx1:nAt,03],;//DescriÁ„o
    aOrig[oLbx1:nAt,04],;//Capacidade
	aOrig[oLbx1:nAt,05],;//Marca
	Transform(aOrig[oLbx1:nAt,06],"@E 999,999,999.99"),; //Ponto Pedido
	Transform(aOrig[oLbx1:nAt,07],"@E 999,999,999.99"),; //Estoque
	Transform(aOrig[oLbx1:nAt,08],"@E 999,999,999.99"),; //Pedido Liberado
	StoD(aOrig[oLbx1:nAt,09]),;//Mes + Ano Entrega
	Transform(aOrig[oLbx1:nAt,10],"@E 999,999,999.99"),; //Pedido Compra
	Transform(aOrig[oLbx1:nAt,11],"@E 999,999,999.99"),; //Sugest„o Compra
	Transform(aOrig[oLbx1:nAt,12],"@E 999,999,999.99"),; //Preco Compra
	Transform(aOrig[oLbx1:nAt,13],"@E 999,999,999.99"),; //Giro 1 Mes
	Transform(aOrig[oLbx1:nAt,14],"@E 999,999,999.99"),; //Giro 3 Meses
	Transform(aOrig[oLbx1:nAt,15],"@E 999,999,999.99"),; //Giro 6 Meses
	Transform(aOrig[oLbx1:nAt,16],"@E 999,999,999.99"),; //Giro 12 Meses
	aOrig[oLbx1:nAt,17],;//Tes
	aOrig[oLbx1:nAt,18],;//Fornecedor
    aOrig[oLbx1:nAt,19],;//Loja
	aOrig[oLbx1:nAt,20],;//CondPag
    aOrig[oLbx1:nAt,21],;//Gerado
	}}

	oLbx1:nAt:=1 //Coloca o curso no primeiro item do ListBox
//	oMainWnd:Refresh()
	oDlgSug:Refresh()		 
	oLbx1:Refresh()
	oLbx1:SetFocus()
*/
return nil

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥fpesq     ∫Autor  ≥ljjbmg             ∫ Data ≥              ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Funcao interna que pesquisa pelo indice selecionado.       ∫±±
±±∫          ≥                                                            ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥                                                            ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function fpesq(aSize,cIndex,oMOTBX)

	Local oDlgPesq := nil
	Local cPesq := Space(100)
	Local oBtn := nil
	Local oBtn2 := nil
	Local nOpc := 0 //0=Cancela | 1=Pesquisar
	Local aOrig := aClone(oLbx1:AARRAY)
	Local nIndice := oMOTBX:nat
	Local xPesq := nil
	Local npos := 0

	Define MSDialog oDlgPesq Title "Pesquisar" From 00,00 TO aSize[6]*0.2,aSize[5]*0.3 Of oMainWnd Pixel

	@ 010,010 	SAY "Pesquisa por "+Alltrim(cIndex)+":"	SIZE 245, 10 OF oDlgPesq PIXEL
	@ 010,080 	GET cPesq  SIZE 100,10 OF oDlgPesq PIXEL
	@ 030,010	BUTTON oBtn		PROMPT "Pesquisar"	SIZE 75,10 OF oDlgPesq	PIXEL ACTION ( nOpc:=1,oDlgPesq:End() )	
	@ 030,100	BUTTON oBtn2	PROMPT "Cancelar"	SIZE 75,10 OF oDlgPesq	PIXEL ACTION ( nOpc:=0,oDlgPesq:End() )	

	ACTIVATE MSDIALOG oDlgPesq CENTER

	If nOpc ==1 //Confimacao
		If Valtype(aOrig[1][nIndice]) <> "C" //Verifico se o tipo nao eh caracter
			If Valtype(aOrig[1][nIndice]) == "N" //Se for numerico
				cPesq := StrTran(cPesq, "," , ".") //Substituo , por .
				xPesq := Val(cPesq) //Transformo em numero
			EndIf	
		Else //Caso seja caracter 
			If Stod(aOrig[1][nIndice]) == ctod('') //Verifico nao se pode converter em Data
				xPesq := Alltrim(cPesq)//apenas tiro os espacos
			Else
				xPesq := cTod(cPesq) //Transformo em data
			endif		
		EndIf

		If Valtype(aOrig[1][nIndice]) == "N" //Se for numerico
			npos := aScan(aOrig, { |x| x[nIndice] = xPesq })		
		ElseIf Valtype(aOrig[1][nIndice]) == "C" //se for caracter		
			If Stod(aOrig[1][nIndice]) == ctod('') //Verifico nao se pode converter em Data
				npos := aScan(aOrig, { |x| Alltrim(x[nIndice]) == xPesq })
			Else
				npos := aScan(aOrig, { |x| Stod(x[nIndice]) == xPesq }) //Transformo o array listbox em data
			EndIf
		EndIf

		If npos > 0 //Caso localize algum item 
			oLbx1:nAt:=npos
			oLbx1:Refresh()		
			oLbx1:SetFocus()
		Else //Se nao encontrar, exibe alerta e posiciona no primeiro item
			MsgStop('Item n„o encontrado !','Sugest„o Compras')
			oLbx1:nAt:=1
			oLbx1:Refresh()
			oLbx1:SetFocus()
		EndIf
	Else //Se for cancelada a tela posiciona no primeiro item 
		oLbx1:nAt:=1
		oLbx1:Refresh()	
		oLbx1:SetFocus()
	EndIf
	//aOrig:={}
Return nil
/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥ fItem    ∫Autor  ≥ljbmg   ∫ Data ≥                         ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Funcao interna que visualiza a sugest„o selecionada        ∫±±
±±∫          ≥ no listbox.                                                ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥                                                            ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function fItem(cFil,cPed,aSize)
	Local aAreaAtu	:= GetArea()

	Private aRotina	:=	{	{"Pesquisar"	, "AxPesqui" , 0 , 1},;
	{"Visualizar"	, "AxVisual" , 0 , 2},;
	{"Consultar"	, "AxAltera" , 0 , 4},;
	{"Impressao"	, "FC010IMP" , 0 , 4}} 


	
	oLbx1:Refresh()	
	oLbx1:SetFocus()

	RestArea(aAreaAtu)
Return nil

//----------------------------------------------------------
/*/{Protheus.doc} fExcel
FunÁ„o para gerar planilha excel com os dados da tela
@Author 
@Since 
@Version P12 
/*/
//----------------------------------------------------------
Static Function fExcel(aPedido,nQtdPV,aHeader)

	Local aAreaAtu  := GetArea()
	Local ni        := 0
	Local aCols     := {}
	Local lGera     := .F.

	If !ApOleClient("MSExcel")
		MsgAlert("Microsoft Excel n„o instalado!")
		Return
	Endif

	ProcRegua(0)  


	lGera:= msgyesno("Deseja Gerar apenas os Marcados?")
		
	// Busca os itens selecionados
	For ni := 1 to nQtdPV

		IncProc(aPedido[ni][1]+"/"+aPedido[ni][2])

		If aPedido[ni][24] .And. lGera		
			Aadd(aCols,aPedido[ni])
		Else
			Aadd(aCols,aPedido[ni]) 
		End

	Next ni

	DlgToExcel({ {"ARRAY", "Exportacao para o Excel", aHeader, aCols} })     
    RestArea(aAreaAtu)
Return nil


Static Function altreg(aHeader)

Local ni        := 0
Local nCount	:= 0
Local oFontb, oFontn,oBtn1, oBtn2, oGet
Local nSugQtd	:= 0 
Local nPrc		:= 0
Local nOpca		:= 0

Local nQtdProd := len(aDados)
Local aProduto := aDados
Local nPosMark
Local asc9	   := {}
Local cProduto := '' 

Private oLocal
/*
For ni := 1 to nQtdProd

		If aProduto[ni][22] 		
			nCount++
          	
			nPosMark := oLbx1:nAt
			nSugQtd := oLbx1:AARRAY[nPosMark][11]
			nPrc	:= oLbx1:AARRAY[nPosMark][12]
			cTes	:= oLbx1:AARRAY[nPosMark][17]
			cCond   := oLbx1:AARRAY[nPosMark][20]
			cFornece:= oLbx1:AARRAY[nPosMark][18]
			cLoja   := oLbx1:AARRAY[nPosMark][19]
		EndIf

Next
*/

			nPosMark := oLbx1:nAt
			nSugQtd := oLbx1:AARRAY[nPosMark][13]
			nPrc	:= oLbx1:AARRAY[nPosMark][14]
			cTes	:= oLbx1:AARRAY[nPosMark][19]
			cCond   := oLbx1:AARRAY[nPosMark][22]
			cFornece:= oLbx1:AARRAY[nPosMark][20]
			cLoja   := oLbx1:AARRAY[nPosMark][21]


/*
If nCount > 1
	MsgAlert( Str(nCount) + ' - Produtos selecionados, favor selecionar um unico produto! '  )
	oLbx1:Refresh()
	oLbx1:SetFocus()
	Return
elseif nCount = 0
	MsgAlert( Str(nCount) + ' - Nenhum Produto Selecionado, favor selecionar um produto! '  )
	oLbx1:Refresh()
	oLbx1:SetFocus()
	Return
	
End
*/
If nPosMark = 0

	MsgAlert( Str(nCount) + ' - Nenhum Produto Selecionado, favor selecionar um produto! '  )
	oLbx1:Refresh()
	oLbx1:SetFocus()
	Return

End

If !Empty(nPosMark)
	cData := cMonth( CTOD("01"+"/"+Substr(oLbx1:AARRAY[nPosMark][11],1,2)+"/"+Substr(oLbx1:AARRAY[nPosMark][11],3,4)))    
End
DEFINE MSDIALOG oLocal FROM 10,181 TO 560,690 TITLE "Informacoes Produto" PIXEL
//TFont():New( [ cName ], [ uPar2 ], [ nHeight ], [ uPar4 ], [ lBold ], [ uPar6 ], [ uPar7 ], [ uPar8 ], [ uPar9 ], [ lUnderline ], [ lItalic ] )
//cName -Indica o nome da fonte que ser· utilizada.
//uPar2-numÈrico-Compatibilidade.
//nHeight-numÈrico-Indica o tamanho da fonte.
//uPar4-lÛgico-Compatibilidade.
//lBold-lÛgico-Indica se habilita(.T.)/desabilita(.F.) o estilo negrito.
//uPar6-numÈrico-Compatibilidade.
//uPar7-lÛgico-Compatibilidade.
//uPar8-numÈrico-Compatibilidade.
//uPar9-lÛgico-Compatibilidade.
//lUnderline-lÛgico-Indica se habilita(.T.)/desabilita(.F.) o estilo sublinhado.
//lItalic-lÛgico-Indica se habilita(.T.)/desabilita(.F.) o estilo it·lico.

	oFontb := TFont():New('Courier new',,-16,.T.,.T.)
	oFontn := TFont():New('Courier new',,-16,.T.,.F.)
	@ 003,005 TO 260,250
	@ 012,007 SAY "Produto:"SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 012,050 SAY  oLbx1:AARRAY[nPosMark][2] SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL 
	@ 012,130 SAY "Ref.:" 	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 012,168 SAY  oLbx1:AARRAY[nPosMark][1] SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL 
	@ 024,007 SAY "Descr.:" SIZE  60, 9  COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 024,050 SAY oLbx1:AARRAY[nPosMark][3] SIZE 200,9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL
	@ 036,007 SAY "Capac.:"	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 036,050 SAY  oLbx1:AARRAY[nPosMark][4] SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL 
	@ 036,130 SAY "Marca:" 	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 036,168 SAY  oLbx1:AARRAY[nPosMark][5] SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL
	@ 048,007 SAY "Mes Lib.Pv.:"	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 048,130 SAY  cData+"/"+Substr(oLbx1:AARRAY[nPosMark][11],3,4) SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL 
	@ 060,007 SAY "Sugestao :"	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 060,130 Get oGet VAR nSugQtd PICTURE "@E 999,999.99" SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL VALID .T.
	@ 072,007 SAY "Ult.Preco Compra :"	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 072,130 Get oGet VAR nPrc PICTURE "@E 999,999.99" SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL VALID .T.
	@ 084,007 SAY "Tes :"	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 084,130 MSGET oGet VAR cTes PICTURE "@E 999"  SIZE 40,9 COLORS CLR_BLUE FONT oFontb OF oLocal F3 "SF4" PIXEL VALID (!Vazio() .and. existcpo("SE4"))  
	@ 096,007 SAY "Cond. Pags :"	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 096,130 MSGET oGet VAR cCond PICTURE "@E 999" SIZE 40,9 COLORS CLR_BLUE FONT oFontb OF oLocal F3 "SE4" PIXEL VALID (!Vazio() .AND. existcpo("SE4"))
	@ 108,007 SAY "Fornecedor :" 	SIZE  60, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 108,130 MSGET oGet VAR cFornece PICTURE PesqPict('SA2','A2_COD') SIZE 45,9 COLORS CLR_BLUE FONT oFontb OF oLocal F3 "SA2" PIXEL VALID (!Vazio() .AND. existcpo("SA2"))
	cCodLoja := bloja(cFornece)
	@ 108,175 SAY "Loja:" 	SIZE  45, 9 COLORS CLR_BLACK FONT oFontb OF oLocal PIXEL 
	@ 108,200 MSGET oGet VAR cCodLoja PICTURE PesqPict('SA2','A2_LOJA') SIZE 45,9 COLORS CLR_BLUE FONT oFontb OF oLocal F3 "SA2" PIXEL WHEN Iif(Empty(cCodLoja),.T.,.F.)
	//Execucao de query
	
	cProduto:=oLbx1:AARRAY[nPosMark][2]
	
	Processa({|| asc9:=Gerasc9(cProduto)},"Gerando dados...")

	If Empty(aSc9) 

		aSC9 := {}
		aRet := {'','','',0.0,dtos(ddatabase),0.0} 
		AADD(aSC9,aclone(aRet))

	End		
	@ 120,007 LISTBOX oLbxPr FIELDS HEADER "Pedido","Cliente","Vendedor","Quantidade","Dt. Entrega","PreÁo" SIZE 235,120 PIXEL 
	oLbxPr:SetArray(asc9)
	oLbxPr:bLine := { || { asc9[oLbxPr:nAt,01],	asc9[oLbxPr:nAt,02],	asc9[oLbxPr:nAt,03],;
					Transform(asc9[oLbxPr:nAt,04],"@E 999,999,999.99"),	stod(asc9[oLbxPr:nAt,05]),	Transform(asc9[oLbxPr:nAt,06],"@E 999,999,999.99") } } 

	@ 245,80 	BUTTON oBtn1 PROMPT 'Sair' ACTION ( oLocal:End() ) SIZE 75, 010 OF oLocal PIXEL
	@ 245,160 	BUTTON oBtn2 PROMPT 'Confirma' SIZE 75, 010 OF oLocal PIXEL ACTION ( nOpca := 1, oLocal:End() )


ACTIVATE MSDIALOG oLocal CENTERED
		
If nOpca == 1
	oLbx1:AARRAY[nPosMark][13] := nSugQtd
	aDados[nPosMark][13] := nSugQtd
	oLbx1:AARRAY[nPosMark][14] := nPrc
	aDados[nPosMark][14] := nPrc
	oLbx1:AARRAY[nPosMark][19] := cTes
	aDados[nPosMark][19] := cTes
	oLbx1:AARRAY[nPosMark][22] := cCond
	aDados[nPosMark][22] := cCond
	oLbx1:AARRAY[nPosMark][20] := cFornece
	aDados[nPosMark][20] := cFornece
	oLbx1:AARRAY[nPosMark][21] := cCodLoja
	aDados[nPosMark][21] := cCodLoja
End

//oLbx1:CtrlRefresh()
oMainWnd:Refresh()
oDlgSug:Refresh()		 
oLbx1:Refresh()
oLbx1:SetFocus()
		
Return

//==================================================================================================================

/*{Protheus.doc} SAeMail()
                                   
ROTINA PARA ENVIO DE EMAILS

@param      Nenhum       
@return     lOk - Cliente escolhido pelo usu·rio
@author     ljjbmg
@since      25/01/2018
@version    12.0                
*/
//==================================================================================================================
Static Function SAeMail(_cSubject, _cBody, _cMailTo, _cCC, cArquivo)
	
	Local _cMailS	:= GetMv("SA_RELSERV")
	Local _cAccount	:= GetMV("SA_RELACNT")
	Local _cPass	:= GetMV("SA_RELAPSW")
	Local lSsl 		:= GetMV("SA_RELSSL")
	Local lTls 		:= GetMV("SA_RELTLS")
 	Local oServer
 	Local oMessage
//  	Local nNumMsg 	:= 0
//  	Local nTam    	:= 0
//  	Local nI      	:= 0
//  	Local nX 		:= 1
 	Local aServPort := Strtokarr(_cMailS,":")
 	Local lEnviado 	:= .T.
 	Local nErro 	:= 0
 //	Local aNomArq 	:= {}
//	Local _cSenha2	:= GetMV("SA_RELPSW")
//	Local _cUsuario2:= GetMV("SA_RELFROM")
//	Local lAuth 	:= GetMV("SA_RELAUTH")


  //Cria a conex„o com o server STMP ( Envio de e-mail )
  oServer := TMailManager():New()
  oServer:SetUseSSL( lSsl )
  oServer:SetUseTLS( lTls )
  oServer:Init( "",aServPort[1],_cAccount,_cPass, 0, Val(aServPort[2]) )
   
  //seta um tempo de time out com servidor de 1min
  If oServer:SetSmtpTimeOut( 60 ) != 0
    Conout( "Falha ao setar o time out" )
    Return .F.
  EndIf
   
  //realiza a conex„o SMTP
  If oServer:SmtpConnect() != 0
    Conout( "Falha ao conectar" )
    Return .F.
  EndIf
  
  nErro := oServer:SmtpAuth( _cAccount, _cPass )
  If nErro <> 0
    conout( "Could not authenticate on SMTP server: " + oServer:GetErrorString( nErro ) )
    oServer:SMTPDisconnect()
    Return .F.
  Endif
    
  //Apos a conex„o, cria o objeto da mensagem
  oMessage := TMailMessage():New()
   
  //Limpa o objeto
  oMessage:Clear()
   
  //Popula com os dados de envio
  oMessage:cFrom              := _cAccount
  oMessage:cTo                := _cMailTo
  oMessage:cCc                := "ljjbmg@gmail.com"
  oMessage:cBcc               := _cCC
  oMessage:cSubject           := _cSubject
  oMessage:cBody              := _cBody
   
  //Adiciona um attach
  
  If oMessage:AttachFile(cArquivo) < 0
	    Conout( "Erro ao atachar o arquivo" )
	    Return .F.
  Else
	    //adiciona uma tag informando que È um attach e o nome do arq
	    oMessage:AddAtthTag( 'Content-Disposition: attachment; filename='+Upper(cArquivo))
  EndIf
 
   
  //Envia o e-mail
  If nErro := oMessage:Send( oServer ) != 0
    Conout( "Erro ao enviar o e-mail" )
    //Conout(oServer:GetErrorString( nErro ))
    Return .F.
  EndIf
   
  //Desconecta do servidor
  If nErro := oServer:SmtpDisconnect() != 0
    Conout( "Erro ao disconectar do servidor SMTP" )
    Return .F.
  EndIf
  Conout("Email enviado para: "+_cMailTo+" Com copia para: "+_cCC) 
  
Return lEnviado

//==================================================================================================================
/*{Protheus.doc} OrcC1()
ROTINA PARA GERACAO DE SOLICITACAO
@param      Nenhum       
@return     lOk - Cliente escolhido pelo usu·rio
@author     ljjbmg
@since      25/01/2021
@version    12.0                
*/
//==================================================================================================================
Static Function gSolCom( aHeader )

Local ni        := 0
Local nCount	:= 0
Local aCabC1    := {}
Local aCab		:= {}
Local aItensSC  := {}
Local aLinhaC1  := {}
Local aProduto	:= aDados
Local nQtdProd	:= Len(aDados)
Local nPosMark	
Local nAux := 0
Local lStatus	:= .F.
Local nx		:= 0
Local lzz1		:= .T.
Local cNumero
Local nSaveSX8  := GetSX8Len()

Private lMsHelpAuto := .T.
PRIVATE lMsErroAuto := .F.

For ni := 1 to nQtdProd
		
		If aProduto[ni][24] .And. aProduto[ni][23] <> 'S'		
			
			
			nCount++
			nPosMark := ni
			lStatus := .T.
			ConOut(strzero(nCount,4,0)+'-'+oLbx1:AARRAY[nPosMark][2]+'-'+oLbx1:AARRAY[nPosMark][5])

			SB1->(DbSetOrder(1))
			SB1->(MsSeek(xFilial("SB1")+oLbx1:AARRAY[nPosMark][2]))
		
			cItem := StrZero(nCount,4)
		
			aadd(aItensSC,{{"C7_ITEM"     ,cItem           ,Nil},; //Numero do Item
			{"C7_PRODUTO",oLbx1:AARRAY[nPosMark][2] ,Nil},; //Codigo do Produto
			{"C7_UM"     ,SB1->B1_UM ,Nil},; //Unidade de Medida
			{"C7_QUANT"  ,oLbx1:AARRAY[nPosMark][13],Nil},; //Quantidade
			{"C7_PRECO"  ,oLbx1:AARRAY[nPosMark][14],Nil},; //Preco
			{"C7_DATPRF" ,dDataBase		 ,Nil},; //Data De Entrega
			{"C7_FLUXO"  ,"S"			 	 ,Nil},; //Fluxo de Caixa (S/N)
			{"C7_LOCAL"  ,RetFldProd(SB1->B1_COD,"B1_LOCPAD")	 ,Nil}}) //Localizacao

/*

			cLocPad:= Posicione("SB1",1,XFILIAL("SB1") + oLbx1:AARRAY[nPosMark][2] , "B1_LOCPAD")

        	aadd(aLinhaC1,{"C7_PRODUTO",oLbx1:AARRAY[nPosMark][2] ,Nil})
        	aadd(aLinhaC1,{"C7_QUANT"  ,oLbx1:AARRAY[nPosMark][11],Nil})
        	aadd(aLinhaC1,{"C7_LOCAL"  ,cLocPad   ,NIL})
			aadd(aLinhaC1,{"C7_PRECO"  ,oLbx1:AARRAY[nPosMark][12],Nil})
			aadd(aLinhaC1,{"C7_TOTAL"  ,Round(oLbx1:AARRAY[nPosMark][12]*oLbx1:AARRAY[nPosMark][11],2)   ,NIL})
			aadd(aLinhaC1,{"C7_DATPRF" ,dDataBase,Nil})  
          	aadd(aItensSC,aclone(aLinhaC1))
			aadd(aSolic,oLbx1:AARRAY[nPosMark][2])
*/		

		EndIf
Next

IF lStatus .and. !Empty(aItensSC) 
  	//????????????????
	//| Verifica numero da SC |
	//????????????????
	cNumero  :=CriaVar("C7_NUM",.T.)
	aCab:={{"C7_NUM"       ,cNumero  	     ,Nil},; // Numero do Pedido
	{"C7_EMISSAO" ,dDataBase  	     ,Nil},; // Data de Emissao
	{"C7_FORNECE" ,oLbx1:AARRAY[nPosMark][20] ,Nil},; // Fornecedor
	{"C7_LOJA"    ,oLbx1:AARRAY[nPosMark][21] ,Nil},; // Loja do Fornecedor
	{"C7_COND"    ,oLbx1:AARRAY[nPosMark][22] ,Nil},; // Condicao de pagamento
	{"C7_CONTATO" ,"               ",Nil},; // Contato
	{"C7_FILENT"  ,cFilAnt  ,Nil}} // Filial Entrega
//	cDoc := GetSXENum("SC7","C7_NUM")
	SC7->(dbSetOrder(1))
/*				
	While SC7->(dbSeek(xFilial("SC7")+cDoc))
		ConfirmSX8()
		cDoc := GetSXENum("SC7","C7_NUM")
	EndDo

	aadd(aCabC1,{"C7_NUM" 		,cDoc})
	aadd(aCabC1,{"C7_EMISSAO"	,dDataBase})
	aadd(aCabC1,{"C7_FORNECE" 	,oLbx1:AARRAY[nPosMark][18]})
	aadd(aCabC1,{"C7_LOJA" 		,oLbx1:AARRAY[nPosMark][19]})
	aadd(aCabC1,{"C7_COND" 		,oLbx1:AARRAY[nPosMark][20]})
	aadd(aCabC1,{"C7_CONTATO"	,PswChave(RetCodUsr())})
	aadd(aCabC1,{"C7_FILENT" 	,cFilAnt})
*/
	lMsErroAuto := .f.
	
	If ExistBlock("MT297APC")
		aCabItem:= ExecBlock("MT297APC",.F.,.F.,{aCab,aItensSC})
		aCab	:= aCabItem[1]
		aItensSC	:= aCabItem[2]
		aCabItem:={}
	EndIf
	
	
	//MSExecAuto({|a,b,c,d,e| MATA120(a,b,c,d,e)},1,aCabC1,aItensSC,3,.f.)
	
	MSExecAuto({|v,x,y,z| MATA120(v,x,y,z)},1,aCab,aItensSC,3,.T.)
	
	If !lMsErroAuto
		ConOut(OemToAnsi("Incluido com sucesso! "))
		While ( GetSX8Len() > nSaveSX8 )
			ConfirmSX8()
		EndDo
 			
//		For ny := 1 to Len(aSolic)
//
//		 	 cProd := aSolic[ny]
//			  Processa({|| SelDados1(cProd,cDoc)}, "Amarracao Solicitacao x Pedido..." + cProd)
//		Next

		aCabC1    := {}
		aItensSC  := {}
		aLinhaC1  := {}
		aCab	  :={}

		For nx := 1 to nQtdProd
				
			If aProduto[nx][24] 
				aProduto[nx][24] := .F.
				aProduto[nx][23] := 'S'
			End

		Next

	Else
		ConOut(OemToAnsi("Erro na inclusao!"))
		MostraErro()
		lzz1 := .F.
		aErrPCAuto := GETAUTOGRLOG()
		For nAux := 1 to Len(aErrPCAuto)
			Conout(aErrPCAuto[nAux])
		Next nAux
		 aCabC1    := {}
		 aItensSC  := {}
		 aLinhaC1  := {}
		 aCab	   :={}
		Help(" ",1,"RCOMC01")
		While ( GetSX8Len() > nSaveSX8 )
			RollBackSx8()
		EndDo
		DisarmTransaction()
		Break

	EndIf
	nCount := 0

EndIf


oMainWnd:Refresh()
oDlgSug:Refresh()		 
oLbx1:Refresh()

Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥SelDados1 ∫Autor  ≥                            ∫ Data ≥     ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Funcao interna que executa a consulta no banco de dados    ∫±±
±±∫          ≥ e alimenta o array da tela.                                ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥                                                            ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function SelDados1(cProd, cDoc)

	Local nCont  := 0
	Local aAreaAtu	:= GetArea()
	Local aRet		:= {}
    Local cAliasPed := GetNextAlias()

    BeginSql Alias cAliasPed
    
        SELECT
        Referencia  = B1_PNUMBER,
        CodProduto	= B1_COD,
        Pedido		= C9_PEDIDO
        

        FROM ( SELECT
                B1_PNUMBER,
                B1_COD,
                C9_PEDIDO
            FROM %Table:SC9% SC9 (NOLOCK)
                        INNER JOIN %Table:SB1% SB1 (NOLOCK)
                            ON B1_FILIAL = %xfilial:SB1%  AND B1_COD = C9_PRODUTO AND SB1.%NotDel% AND B1_COD BETWEEN %exp:cMv03% AND %exp:cMv04%
							AND B1_GRUPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
							AND B1_MARCA BETWEEN %exp:MV_PAR07% AND %exp:MV_PAR08%
                        INNER JOIN %Table:SB2% SB2 (NOLOCK)
                            ON B2_FILIAL = %xfilial:SB2% AND B2_COD = C9_PRODUTO AND B2_LOCAL = C9_LOCAL  
                            AND SB2.%NotDel% 
                        INNER JOIN %Table:SC6% SC6 (NOLOCK)
                            ON C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM	AND C6_ENTREG BETWEEN %exp:dDtInic% AND %exp:dDtFim%
                        INNER JOIN %Table:SF4% SF4 (NOLOCK)
                            ON C6_TES = F4_CODIGO 
            WHERE C9_FILIAL = %xfilial:SC9% AND B2_LOCAL = '01'  AND C9_NFISCAL = ' ' AND C9_PRODUTO = %exp:cProd% 
                    AND SC9.%NotDel% AND F4_ESTOQUE = 'S' 
        GROUP BY   B1_COD , B1_PNUMBER,  C9_PEDIDO

        ) F
        ORDER BY CodProduto 
   EndSql

   aSql := GetLastQuery()
   cSql := aSql[2]
   MemoWrite("\queries\pedarray.sql",cSql)

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥ Definicao da primeira regua				     ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	(cAliasPed)->(dbEval({|| nCont++},,{|| !EOF()}))
	ProcRegua(nCont)

	(cAliasPed)->(dbGoTop())	

	While (cAliasPed)->(!Eof())
			
			RecLock("ZZ1",.T.)
			ZZ1->ZZ1_FILIAL := XFILIAL("ZZ1")
			ZZ1->ZZ1_PROD	:= (cAliasPed)->CodProduto
			ZZ1->ZZ1_NUM 	:= (cAliasPed)->Pedido
			ZZ1->ZZ1_SOLIC	:= cDoc
			ZZ1->ZZ1_USUARI	:= PswChave(RetCodUsr()) + ' - '+ dtoc(ddatabase)
			ZZ1->(MsUnlock())
			(cAliasPed)->(DbSkip())
	Enddo

	(cAliasPed)->(dbCloseArea())
	RestArea(aAreaAtu)

Return aRet


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…››››››››››—››››››››››À›››››››—››››››››››››››››››››À››››››—›››››››››››››ª±±
±±∫Programa  ≥SelDados  ∫Autor  ≥                            ∫ Data ≥     ∫±±
±±Ã››››››››››ÿ›››››››››› ›››››››››››››››››››››››››››› ››››››››››››››››››››π±±
±±∫Desc.     ≥ Funcao interna que executa a consulta no banco de dados    ∫±±
±±∫          ≥ e alimenta o array da tela.                                ∫±±
±±Ã››››››››››ÿ››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››π±±
±±∫Uso       ≥                                                            ∫±±
±±»›››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››››º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/
Static Function Gerasc9(cProduto)

	Local nCont  := 0
	Local aAreaAtu	:= GetArea()
	Local aReta		:= {}
	Local aRetSc9	:= {}
	Local nRegAtu	:= 0
	Local x			:= 0
    Local cAliasSc9 := GetNextAlias()

    BeginSql Alias cAliasSc9
    
        SELECT
        Pedido  	= C9_PEDIDO,
        Cliente		= CliLoja,
		Vendedor	= C5_AXATEND,
		PedLiberado = PED_LIB,
        DataEntrega = C6_ENTREG,
        Prc 		= C9_PRCVEN

        FROM ( SELECT
                C9_PEDIDO,
                C9_CLIENTE +'-'+C9_LOJA+'-'+A1_NREDUZ CliLoja,
                C5_AXATEN1+'-'+ C5_AXATEND C5_AXATEND,
                SUM(C9_QTDLIB) AS 'PED_LIB', 
                C6_ENTREG, C9_PRCVEN
            FROM %Table:SC9% SC9 (NOLOCK)
                        INNER JOIN %Table:SB1% SB1 (NOLOCK)
                            ON B1_FILIAL = %xfilial:SB1%  AND B1_COD = C9_PRODUTO AND SB1.%NotDel% AND B1_COD BETWEEN %exp:cMv03% AND %exp:cMv04%
							AND B1_GRUPO BETWEEN '' AND 'ZZZZ'
							AND B1_MARCA BETWEEN '' AND 'ZZZZZZZZZZZZZZZ'
                        INNER JOIN %Table:SB2% SB2 (NOLOCK)
                            ON B2_FILIAL = %xfilial:SB2% AND B2_COD = C9_PRODUTO AND B2_LOCAL = C9_LOCAL  
                            AND SB2.%NotDel% 
                        INNER JOIN %Table:SC6% SC6 (NOLOCK)
                            ON C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM	AND C6_ENTREG BETWEEN %exp:dDtInic% AND %exp:dDtFim%
                        INNER JOIN %Table:SF4% SF4 (NOLOCK)
                            ON C6_TES = F4_CODIGO 
                        INNER JOIN %Table:SA1% SA1 (NOLOCK)
                            ON C9_CLIENTE = A1_COD AND C9_LOJA = A1_LOJA  
                            AND SA1.%NotDel% 
                        INNER JOIN %Table:SC5% SC5 (NOLOCK)
                            ON C9_PEDIDO = C5_NUM AND C9_FILIAL = C5_FILIAL   
                            AND SC5.%NotDel% 
                        INNER JOIN %Table:SA3% SA3 (NOLOCK)
                            ON C5_VEND1 = A3_COD   
                            AND SA1.%NotDel% 
							
            WHERE C9_FILIAL = %xfilial:SC9% AND B2_LOCAL = '01'  AND C9_NFISCAL = ' ' 
                    AND SC9.%NotDel% AND F4_ESTOQUE = 'S' AND  C9_PRODUTO = %exp:cProduto%
        GROUP BY  B1_DESC,  B1_MARCA, B1_EMIN, B2_QATU, B2_SALPEDI, B1_COD , F4_CODIGO, C6_ENTREG, C9_PEDIDO, C9_LOJA, A1_NREDUZ, C9_CLIENTE, C5_AXATEND, C9_PRCVEN, C5_AXATEN1
//            HAVING (B1_EMIN - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI) > 0 
        ) F
        ORDER BY Pedido 
   EndSql

   aSql := GetLastQuery()
   cSql := aSql[2]
   MemoWrite("\queries\sc9brwse.sql",cSql)

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥ Definicao da primeira regua				     ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	(cAliasSc9)->(dbEval({|| nCont++},,{|| !EOF()}))
	ProcRegua(nCont)

	(cAliasSc9)->(dbGoTop())	
	aRetSc9	:= Array(fCount())
	nRegAtu	:= 1

//	If MV_PARxx = 1 //Pergunta: 
//		AADD(aRet1,.T.)   
//	Else
		AADD(aRetSc9,.F.)   	
//	EndIf

	While (cAliasSc9)->(!Eof())
		IncProc("Lendo Registros..."+Alltrim(str(nRegAtu))+"/"+Alltrim(str(nCont)) )
		For x:=1 to fCount()
			aRetSc9[x] := FieldGet(x)
		Next

		AADD(aReta,aclone(aRetSc9))
		(cAliasSc9)->(DbSkip())
		nRegAtu += 1
	Enddo

	(cAliasSc9)->(dbCloseArea())
	RestArea(aAreaAtu)

Return aReta


Static function bloja(cFornece)

Local lRetorno
Local aArea := GetArea()
Local cCodLoja := ''
dbSelectArea("SA2")
dbSetOrder(1)
If !(xFilial("SA2") == SA2->A2_FILIAL .And. cFornece == SA2->A2_COD)
	If MsSeek(xFilial("SA2")+cFornece)
		cCodLoja := SA2->A2_LOJA
		lRetorno := .T.
	Else
		Help("  ",1,"REGNOIS")
	EndIf
Else
	cCodLoja := SA2->A2_LOJA
	lRetorno := .T.
	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥ Verifica se o Registro esta Bloqueado.≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	If lRetorno .And. !RegistroOk("SA2")
		lRetorno := .F.
	EndIf				
EndIf

RestArea(aArea)

Return cCodLoja
