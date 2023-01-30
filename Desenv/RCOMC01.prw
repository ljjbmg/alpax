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

	Local aHeader	:= {"Referencia","Codigo","Descricao","Capacidade","Marca","PontoPedido","Estoque","PedidoLiberado","DataEntrega","PedidoCompra","Sugest„o","Ult.Prc","Giro1Mes","Giro3meses","Giro6meses","Giro12meses","Tes","Fornecedor","Loja","Cod.Pag","Gerado" }
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
		aHeader[21];
		SIZE (oDlgSug:NCLIENTWIDTH)*0.5,(oDlgSug:NCLIENTHEIGHT)*0.3 OF oDlgSug PIXEL ; 
		ON dblClick( oLbx1:AARRAY[oLbx1:nAt,22] := !oLbx1:AARRAY[oLbx1:nAt,22],oLbx1:Refresh(),oLbx1:SetFocus() )

		oLbx1:SetArray(aDados)
   		oLbx1:bLine := { || {		Iif(aDados[oLbx1:nAt,22],oOk2,oNo2),; //Marcacao de processamento
		Iif(AllTrim(aDados[oLbx1:nAt,21])=="S", oBL, Iif(AllTrim(aDados[oLbx1:nAt,21])=="C",oPD,Iif(AllTrim(aDados[oLbx1:nAt,21])=="Z",oOs, oOK))),; //Legenda ID
		aDados[oLbx1:nAt,01],;//Referencia
		aDados[oLbx1:nAt,02],;//CÛdigo
		aDados[oLbx1:nAt,03],;//DescriÁ„o
        aDados[oLbx1:nAt,04],;//Capacidade
		aDados[oLbx1:nAt,05],;//Marca
		Transform(aDados[oLbx1:nAt,06],"@E 999,999,999.99"),; //Ponto Pedido
		Transform(aDados[oLbx1:nAt,07],"@E 999,999,999.99"),; //Estoque oPD oPD
		Transform(aDados[oLbx1:nAt,08],"@E 999,999,999.99"),; //Pedido Liberado
		StoD(aDados[oLbx1:nAt,09]),;//MÍs Ano Entrega
		Transform(aDados[oLbx1:nAt,10],"@E 999,999,999.99"),; //Pedido Compra
		Transform(aDados[oLbx1:nAt,11],"@E 999,999,999.99"),; //Sugest„o Compra
		Transform(aDados[oLbx1:nAt,12],"@E 999,999,999.99"),; //Preco
		Transform(aDados[oLbx1:nAt,13],"@E 999,999,999.99"),; //Giro 1 Mes
		Transform(aDados[oLbx1:nAt,14],"@E 999,999,999.99"),; //Giro 3 Meses
		Transform(aDados[oLbx1:nAt,15],"@E 999,999,999.99"),; //Giro 6 Meses
		Transform(aDados[oLbx1:nAt,16],"@E 999,999,999.99"),; //Giro 12 Meses
		aDados[oLbx1:nAt,17],;//TES
		aDados[oLbx1:nAt,18],;//Fornecedor
		aDados[oLbx1:nAt,19],;//Loja
		aDados[oLbx1:nAt,20],;//Cond.Pag
        aDados[oLbx1:nAt,21],;//Gerado
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
    
        SELECT
        Referencia  = B1_PNUMBER,
        CodProduto	= B1_COD,
        DesProduto	= B1_DESC,
        Capacidade  = B1_CAPACID, 
        MarProduto	= B1_MARCA,
        PontoPedido	= B1_EMIN,
        Estoque		= B2_QATU,
        PedLiberado = PED_LIB,
        DataEntrega = C6_ENTREG,
        PedCompra	= PED_COMPRA,
        SugCompra	= SUGESTAO_COMPRA,
		Prc 		= B1_XUPRC,
		Giro1		= Giro1mes,
        Giro3		= Giro3meses,
        Giro6		= Giro6meses,
        Giro12		= Giro12meses,
		Tes 		= B1_TE,
		Fornece		= D1_FORNECE,
		Loja 		= D1_LOJA,
		Cond		= F1_COND,
		Gerado		= Flag

        FROM ( SELECT
                B1_PNUMBER,
                B1_COD,
                B1_DESC,
                B1_CAPACID,
                B1_MARCA,
                ROUND(B1_EMIN,0) B1_EMIN,
                B2_QATU,
                SUM(C9_QTDLIB) AS 'PED_LIB', 
				C6_ENTREG,
//              Right(Replicate('0',2) + Convert(varchar(02),Month(C6_ENTREG)),2) + Convert(varchar(04),Year(C6_ENTREG)) C6_ENTREG,
                B2_SALPEDI AS 'PED_COMPRA',
                round((B1_EMIN - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI),0) AS 'SUGESTAO_COMPRA',
				B1_XUPRC,
				Case 	When B1_XVENCTO = '1' AND B1_XSAZ = '' Then 'C' 
						When B1_XSAZ = '1' AND B1_XVENCTO = '' Then 'Z'
						When B1_XSAZ = '1' AND B1_XVENCTO = '1' Then 'T' 
						ELSE '' END AS Flag,
				Isnull((
                SELECT 
                SUM(D2_QUANT) 
                FROM	%Table:SD2% SD2 (NOLOCK) WHERE D2_COD = B1_COD AND 
                        SD2.%NotDel% AND 
                        D2_TES = F4_CODIGO AND 
                        CONVERT(DATE,D2_EMISSAO,103) BETWEEN 
                        DateAdd(mm, DateDiff(mm,0,GetDate()) - 1, 0) AND 
                        DateAdd(mm, DateDiff(mm,0,GetDate()), -1) 
                ),0) Giro1mes,
                Isnull((
                SELECT 
                SUM(D2_QUANT) 
                FROM	%Table:SD2% SD2 (NOLOCK) WHERE D2_COD = B1_COD AND 
                        SD2.%NotDel% AND 
                        D2_TES = F4_CODIGO AND 
                        CONVERT(DATE,D2_EMISSAO,103) BETWEEN 
                        DateAdd(mm, DateDiff(mm,0,GetDate()) - 3, 0) AND 
                        DateAdd(mm, DateDiff(mm,0,GetDate()), -1) 
                ),0) Giro3meses,
                Isnull((
                SELECT 
                SUM(D2_QUANT) 
                FROM	%Table:SD2% SD2 (NOLOCK) WHERE D2_COD = B1_COD AND 
                        SD2.%NotDel% AND  
                        D2_TES = F4_CODIGO AND 
                        CONVERT(DATE,D2_EMISSAO,103) BETWEEN 
                        DateAdd(mm, DateDiff(mm,0,GetDate()) - 6, 0) AND 
                        DateAdd(mm, DateDiff(mm,0,GetDate()), -1) 
                ),0) Giro6meses,
                        Isnull((
                SELECT 
                SUM(D2_QUANT) 
                FROM	%Table:SD2% SD2 (NOLOCK) WHERE D2_COD = B1_COD AND 
                        SD2.%NotDel% AND 
                        D2_TES = F4_CODIGO AND 
                        CONVERT(DATE,D2_EMISSAO,103) BETWEEN 
                        DateAdd(mm, DateDiff(mm,0,GetDate()) - 12, 0) AND 
                        DateAdd(mm, DateDiff(mm,0,GetDate()), -1) 
                ),0) Giro12meses,
				B1_TE, 
				Isnull((SELECT DISTINCT t1.D1_FORNECE FROM  %Table:SD1% t1 (NOLOCK) 
				WHERE t1.D1_DTDIGIT = (SELECT MAX(t2.D1_DTDIGIT) DT
									FROM %Table:SD1% t2 (NOLOCK) WHERE t2.D1_COD = B1_COD AND t2.%NotDel%
									GROUP BY t2.D1_COD)
									AND t1.D1_COD = B1_COD
				GROUP BY D1_FORNECE ),'') D1_FORNECE,
				Isnull((SELECT DISTINCT t1.D1_LOJA FROM  %Table:SD1% t1 (NOLOCK)
				WHERE t1.D1_DTDIGIT = (SELECT MAX(t2.D1_DTDIGIT) DT
									FROM  %Table:SD1% t2 (NOLOCK) WHERE t2.D1_COD = B1_COD AND t2.%NotDel%
									GROUP BY t2.D1_COD)
									AND t1.D1_COD = B1_COD
				GROUP BY D1_LOJA ),'') D1_LOJA,
				Isnull((SELECT DISTINCT t3.F1_COND FROM  %Table:SD1% t1,  %Table:SF1% t3 
				WHERE t1.D1_DTDIGIT = (SELECT MAX(t2.D1_DTDIGIT) DT
									FROM  %Table:SD1% t2 WHERE t2.D1_COD = B1_COD AND t2.%NotDel%
									GROUP BY t2.D1_COD)
									AND t1.D1_COD = B1_COD AND t1.D1_DOC = t3.F1_DOC AND t3.%NotDel%
									AND t1.D1_SERIE = t3.F1_SERIE 
									AND t1.D1_FORNECE = t3.F1_FORNECE 
									AND t1.D1_LOJA = t3.F1_LOJA
				GROUP BY F1_COND ),'') F1_COND
            FROM %Table:SC9% SC9 (NOLOCK)
                        INNER JOIN %Table:SB1% SB1 (NOLOCK)
                            ON B1_FILIAL = %xfilial:SB1%  AND B1_COD = C9_PRODUTO AND SB1.%NotDel% AND B1_COD BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
							AND B1_GRUPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
							AND B1_MARCA BETWEEN %exp:MV_PAR07% AND %exp:MV_PAR08%
                        INNER JOIN %Table:SB2% SB2 (NOLOCK)
                            ON B2_FILIAL = %xfilial:SB2% AND B2_COD = C9_PRODUTO AND B2_LOCAL = C9_LOCAL  
                            AND SB2.%NotDel% 
                        INNER JOIN %Table:SC6% SC6 (NOLOCK)
                            ON C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM	AND C6_ENTREG BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
                        INNER JOIN %Table:SF4% SF4 (NOLOCK)
                            ON C6_TES = F4_CODIGO 
            WHERE C9_FILIAL = %xfilial:SC9% AND B2_LOCAL = '01'  AND C9_NFISCAL = ' ' 
                    AND SC9.%NotDel% AND F4_ESTOQUE = 'S' 
        GROUP BY  B1_DESC,  B1_MARCA, B1_EMIN, B2_QATU, B2_SALPEDI, B1_COD , F4_CODIGO, C6_ENTREG, B1_PNUMBER, B1_CAPACID, B1_XUPRC, B1_TE,B1_XVENCTO,B1_XSAZ
        HAVING (ROUND(B1_EMIN,0) - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI) > 0 

        ) F
		Union All

		SELECT 
		REFERENCIA = B1_PNUMBER,
		CODPRODUTO = B1_COD,
		DESPRODUTO = B1_DESC,
		CAPACIDADE = B1_CAPACID,
		MARPRODUTO = B1_MARCA,
		PONTOPEDIDO = B1_EMIN,
		ESTOQUE = B2_QATU,
		PEDLIBERADO = PED_LIB,
		DATAENTREGA = C6_ENTREG,
		PEDCOMPRA = PED_COMPRA,
		SUGCOMPRA = SUGESTAO_COMPRA,
		PRC = B1_XUPRC,
		GIRO1 = GIRO1MES,
		GIRO3 = GIRO3MESES,
		GIRO6 = GIRO6MESES,
		GIRO12 = GIRO12MESES,
		TES = B1_TE,
		FORNECE = D1_FORNECE,
		LOJA = D1_LOJA,
		COND = F1_COND,
		GERADO = FLAG 

		FROM (SELECT	
			   B1_PNUMBER,
			   B1_COD,
			   B1_DESC,
			   B1_CAPACID,
			   B1_MARCA,
			   ROUND(B1_EMIN,0) B1_EMIN,
			   B2_QATU,
			   0 AS 'PED_LIB',
			   CONVERT(VARCHAR(04),YEAR(GETDATE())) +RIGHT(REPLICATE('0',2) + CONVERT(VARCHAR(02),MONTH(GETDATE())),2) + '25' C6_ENTREG,
//			   RIGHT(REPLICATE('0',2) + CONVERT(VARCHAR(02),MONTH(GETDATE())),2) + CONVERT(VARCHAR(04),YEAR(GETDATE())) C6_ENTREG,
			   B2_SALPEDI AS 'PED_COMPRA',
			   ROUND(B1_EMIN ,0) AS 'SUGESTAO_COMPRA',
			   B1_XUPRC,
			   CASE WHEN B1_XVENCTO = '1' AND B1_XSAZ = ' ' THEN 'C' 
					WHEN B1_XSAZ = '1' AND B1_XVENCTO = ' ' THEN 'Z' 
					WHEN B1_XSAZ = '1' AND B1_XVENCTO = '1' THEN 'T' 
					ELSE ' ' END AS FLAG,
			   Isnull((
			   SELECT 
			   SUM(D2_QUANT) 
			   FROM 	%Table:SD2% SD2 WHERE  
			   			D2_COD = B1_COD AND SD2.%NotDel% AND 
						D2_TES = B1_TE AND CONVERT(DATE,D2_EMISSAO,103) 
						BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 1, 0) AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) 
			   GIRO1MES,
			   Isnull((
			   SELECT 
			   SUM(D2_QUANT) 
			   FROM 	%Table:SD2% SD2 WHERE  
			   			D2_COD = B1_COD AND SD2.%NotDel% AND 
						D2_TES = B1_TE AND CONVERT(DATE,D2_EMISSAO,103) 
						BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 3, 0) AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) 
			   GIRO3MESES,
			   Isnull((
			   SELECT 
			   SUM(D2_QUANT) 
			   FROM 	%Table:SD2% SD2 WHERE  
			   			D2_COD = B1_COD AND SD2.%NotDel% AND 
						D2_TES = B1_TE AND CONVERT(DATE,D2_EMISSAO,103) 
						BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 6, 0) AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) 
			   GIRO6MESES,
			   Isnull((
			   SELECT 
			   SUM(D2_QUANT) 
			   FROM 	%Table:SD2% SD2 (NOLOCK) WHERE  
			   			D2_COD = B1_COD AND SD2.%NotDel% AND 
						D2_TES = B1_TE AND CONVERT(DATE,D2_EMISSAO,103) 
						BETWEEN DATEADD(MM, DATEDIFF(MM,0,GETDATE()) - 12, 0) AND DATEADD(MM, DATEDIFF(MM,0,GETDATE()), -1)),0) 
			   GIRO12MESES,
			   B1_TE,
			   Isnull((
			   SELECT 
			   DISTINCT T1.D1_FORNECE 
			   FROM 	%Table:SD1% T1 (NOLOCK) WHERE  T1.D1_DTDIGIT = (
				   											SELECT 
															MAX(T2.D1_DTDIGIT) DT 
															FROM 	%Table:SD1% T2 (NOLOCK)
															WHERE  T2.D1_COD = B1_COD AND T2.%NotDel%
															GROUP BY T2.D1_COD)  AND T1.D1_COD = B1_COD 
															GROUP BY D1_FORNECE),' ') 
			   D1_FORNECE,
			   Isnull((
			   SELECT 
			   DISTINCT T1.D1_LOJA 
			   FROM 	%Table:SD1% T1 (NOLOCK) WHERE  T1.D1_DTDIGIT = (
				   											SELECT MAX(T2.D1_DTDIGIT) DT 
															FROM 	%Table:SD1% T2 (NOLOCK)
															WHERE  T2.D1_COD = B1_COD AND T2.%NotDel% 
															GROUP BY T2.D1_COD)  
															AND T1.D1_COD = B1_COD 
															GROUP BY D1_LOJA),' ') 
			   D1_LOJA,
			   Isnull((
			   SELECT 
			   DISTINCT T3.F1_COND 
			   FROM 	%Table:SD1% T1 (NOLOCK) , %Table:SF1% T3 (NOLOCK) WHERE  T1.D1_DTDIGIT = (
				   														SELECT MAX(T2.D1_DTDIGIT) DT 
																		FROM %Table:SD1% T2 (NOLOCK) 
																		WHERE  T2.D1_COD = B1_COD AND T2.%NotDel% 
																		GROUP BY T2.D1_COD)  
																		AND T1.D1_COD = B1_COD 
																		AND T1.D1_DOC = T3.F1_DOC 
																		AND T3.%NotDel% 
																		AND T1.D1_SERIE = T3.F1_SERIE 
																		AND T1.D1_FORNECE = T3.F1_FORNECE 
																		AND T1.D1_LOJA = T3.F1_LOJA 
																		GROUP BY F1_COND ),' ') 
			   F1_COND 
			   FROM  %Table:SB1% SB1 (NOLOCK) INNER JOIN   %Table:SB2% SB2 (NOLOCK)  ON B1_FILIAL = B2_FILIAL AND B2_COD = B1_COD
			   AND SB1.%NotDel% AND SB2.%NotDel%
			   WHERE   	B1_COD BETWEEN '               ' AND 'ZZZZZZZZZZZZZZZ' AND 
						B1_GRUPO BETWEEN '    ' AND 'ZZZZ' AND 
						B1_MARCA BETWEEN '   ' AND 'ZZZ' 
				AND B1_XSAZ = '1' AND MONTH(GETDATE()) = B1_SAZMESE  
				GROUP BY B1_DESC, B1_MARCA, B1_EMIN, B2_QATU, B2_SALPEDI, B1_COD , B1_PNUMBER, B1_CAPACID, B1_XUPRC, B1_TE,B1_XVENCTO,B1_XSAZ 
				HAVING ( ROUND(B1_EMIN,0)  > 0)
				)  F 
	ORDER BY  CODPRODUTO

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
	oLbx1:Refresh()
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
		
	alert(lGera)
	// Busca os itens selecionados
	For ni := 1 to nQtdPV

		IncProc(aPedido[ni][1]+"/"+aPedido[ni][2])

		If aPedido[ni][22] .And. lGera		
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

For ni := 1 to nQtdProd

		If aProduto[ni][22] 		
			nCount++
          	
			nPosMark := ni
			nSugQtd := oLbx1:AARRAY[nPosMark][11]
			nPrc	:= oLbx1:AARRAY[nPosMark][12]
			cTes	:= oLbx1:AARRAY[nPosMark][17]
			cCond   := oLbx1:AARRAY[nPosMark][20]
			cFornece:= oLbx1:AARRAY[nPosMark][18]
			cLoja   := oLbx1:AARRAY[nPosMark][19]
		EndIf

Next

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

If !Empty(nPosMark)
	cData := cMonth( CTOD("01"+"/"+Substr(oLbx1:AARRAY[nPosMark][9],1,2)+"/"+Substr(oLbx1:AARRAY[nPosMark][9],3,4)))    
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
	@ 048,130 SAY  cData+"/"+Substr(oLbx1:AARRAY[nPosMark][9],3,4) SIZE  80, 9 COLORS CLR_BLUE FONT oFontb OF oLocal PIXEL 
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

	@ 120,007 LISTBOX oLbxPr FIELDS HEADER "Pedido","Cliente","Vendedor","Quantidade","Dt. Entrega","PreÁo" SIZE 235,120 PIXEL 
	oLbxPr:SetArray(asc9)
	oLbxPr:bLine := { || { asc9[oLbxPr:nAt,01],	asc9[oLbxPr:nAt,02],	asc9[oLbxPr:nAt,03],;
							 Transform(asc9[oLbxPr:nAt,04],"@E 999,999,999.99"),	stod(asc9[oLbxPr:nAt,05]),	Transform(asc9[oLbxPr:nAt,06],"@E 999,999,999.99") } } 

	@ 245,80 	BUTTON oBtn1 PROMPT 'Sair' ACTION ( oLocal:End() ) SIZE 75, 010 OF oLocal PIXEL
	@ 245,160 	BUTTON oBtn2 PROMPT 'Confirma' SIZE 75, 010 OF oLocal PIXEL ACTION ( nOpca := 1, oLocal:End() )


ACTIVATE MSDIALOG oLocal CENTERED
		
If nOpca == 1
	oLbx1:AARRAY[nPosMark][11] := nSugQtd
	aDados[nPosMark][11] := nSugQtd
	oLbx1:AARRAY[nPosMark][12] := nPrc
	aDados[nPosMark][12] := nPrc
	oLbx1:AARRAY[nPosMark][17] := cTes
	aDados[nPosMark][17] := cTes
	oLbx1:AARRAY[nPosMark][20] := cCond
	aDados[nPosMark][20] := cCond
	oLbx1:AARRAY[nPosMark][18] := cFornece
	aDados[nPosMark][18] := cFornece
	oLbx1:AARRAY[nPosMark][19] := cCodLoja
	aDados[nPosMark][19] := cCodLoja
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
Local aItensSC  := {}
Local aLinhaC1  := {}
Local cMarcaAnt := ''
Local aProduto	:= aDados
Local nQtdProd	:= Len(aDados)
Local nPosMark	
Local nAux := 0
Local lStatus	:= .F.
Local ny 		:= 0
Local nx		:= 0
Local cProd		:= ''
Local aSolic	:={}
Local cDoc		:= ''
Local lzz1		:= .T.

Private lMsHelpAuto := .T.
PRIVATE lMsErroAuto := .F.

For ni := 1 to nQtdProd
		
		If aProduto[ni][22] 		
			
			nCount++
			nPosMark := ni
			lStatus := .T.
			ConOut(strzero(nCount,4,0)+'-'+oLbx1:AARRAY[nPosMark][2]+'-'+oLbx1:AARRAY[nPosMark][5])
			If nCount == 1
				cMarcaAnt := oLbx1:AARRAY[nPosMark][5]
			End
//				aadd(aLinhaC1,{"C1_ITEM"   ,StrZero(nCount,len(SC1->C1_ITEM))    ,Nil})
			If cMarcaAnt == oLbx1:AARRAY[nPosMark][5]
          		cLocPad:= Posicione("SB1",1,XFILIAL("SB1") + oLbx1:AARRAY[nPosMark][2] , "B1_LOCPAD")

          		aadd(aLinhaC1,{"C7_PRODUTO",oLbx1:AARRAY[nPosMark][2] ,Nil})
          		aadd(aLinhaC1,{"C7_QUANT"  ,oLbx1:AARRAY[nPosMark][11],Nil})
          		aadd(aLinhaC1,{"C7_LOCAL"  ,cLocPad   ,NIL})
				aadd(aLinhaC1,{"C7_PRECO"  ,oLbx1:AARRAY[nPosMark][12],Nil})
				aadd(aLinhaC1,{"C7_TOTAL"  ,Round(oLbx1:AARRAY[nPosMark][12]*oLbx1:AARRAY[nPosMark][11],2)   ,NIL})
				aadd(aLinhaC1,{"C7_DATPRF" ,oLbx1:AARRAY[nPosMark][09],Nil})  
          		aadd(aItensSC,aclone(aLinhaC1))
				aadd(aSolic,oLbx1:AARRAY[nPosMark][2])
		
			Else
			   	cMarcaAnt :=oLbx1:AARRAY[nPosMark][5]
		       	//????????????????
				//| Verifica numero da SC |
				//????????????????
				cDoc := GetSXENum("SC7","C7_NUM")
				SC7->(dbSetOrder(1))
			
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

				MSExecAuto({|a,b,c,d,e| MATA120(a,b,c,d,e)},1,aCabC1,aItensSC,3,.T.)
//				MSExecAuto({|x,y| mata110(x,y)},aCabC1,aItensSC)

				If !lMsErroAuto
					ConOut(OemToAnsi("Incluido com sucesso! "))
 					//ASORT(aItensSC, , , { | x,y | x[2] > y[2] } )  

					For ny := 1 to Len(aSolic) 
					 	 cProd := aSolic[ny]
						  Processa({|| SelDados1(cProd,cDoc)}, "Amarracao Pedido Compras x Pedido Venda..." + cProd)
					Next
					aCabC1    := {}
					aItensSC  := {}
					aLinhaC1  := {}
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

				EndIf
				nCount := 0

			End
		elseif nQtdProd == ni .and. lStatus .and. !Empty(aItensSC) .and. !aProduto[ni][22]
		       	//????????????????
				//| Verifica numero da SC |
				//????????????????
				cDoc := GetSXENum("SC7","C7_NUM")
				SC7->(dbSetOrder(1))
				
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

				MSExecAuto({|a,b,c,d,e| MATA120(a,b,c,d,e)},1,aCabC1,aItensSC,3,.T.)

				If !lMsErroAuto
					ConOut(OemToAnsi("Incluido com sucesso! "))
 					
			
					For ny := 1 to Len(aSolic)

					 	 cProd := aSolic[ny]
						  Processa({|| SelDados1(cProd,cDoc)}, "Amarracao Solicitacao x Pedido..." + cProd)
					Next
					aCabC1    := {}
					aItensSC  := {}
					aLinhaC1  := {}

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

				EndIf
				nCount := 0

		EndIf

Next

For nx := 1 to nQtdProd
		
	If aProduto[nx][22] 
		aProduto[nx][22] := .F.
		aProduto[nx][21] := 'S'
	End

Next

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
		Vendedor	= A3_NREDUZ,
		PedLiberado = PED_LIB,
        DataEntrega = C6_ENTREG,
        Prc 		= C9_PRCVEN

        FROM ( SELECT
                C9_PEDIDO,
                C9_CLIENTE +'-'+C9_LOJA+'-'+A1_NREDUZ CliLoja,
                A3_COD+'-'+ A3_NREDUZ A3_NREDUZ,
                SUM(C9_QTDLIB) AS 'PED_LIB', 
                C6_ENTREG, C9_PRCVEN
            FROM %Table:SC9% SC9 (NOLOCK)
                        INNER JOIN %Table:SB1% SB1 (NOLOCK)
                            ON B1_FILIAL = %xfilial:SB1%  AND B1_COD = C9_PRODUTO AND SB1.%NotDel% AND B1_COD BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
							AND B1_GRUPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
							AND B1_MARCA BETWEEN %exp:MV_PAR07% AND %exp:MV_PAR08%
                        INNER JOIN %Table:SB2% SB2 (NOLOCK)
                            ON B2_FILIAL = %xfilial:SB2% AND B2_COD = C9_PRODUTO AND B2_LOCAL = C9_LOCAL  
                            AND SB2.%NotDel% 
                        INNER JOIN %Table:SC6% SC6 (NOLOCK)
                            ON C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM	AND C6_ENTREG BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
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
        GROUP BY  B1_DESC,  B1_MARCA, B1_EMIN, B2_QATU, B2_SALPEDI, B1_COD , F4_CODIGO, C6_ENTREG, C9_PEDIDO, C9_LOJA, A1_NREDUZ, C9_CLIENTE, A3_NREDUZ, C9_PRCVEN, A3_COD
            HAVING (B1_EMIN - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI) > 0 

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
