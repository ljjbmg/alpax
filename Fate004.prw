/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATE004   ºAutor  ³Adriano Luis Brandaoº Data ³  24/11/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Exeblock para utilizar na consulta especifica no campo     º±±
±±º          ³ CK_PRODUTO                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "rwmake.ch"
#Include "Topconn.ch"
#Include "protheus.ch"

User Function FATE004()  
Private _cProduto

                                          
if alltrim(UPPER(GETENVSERVER())) $ "CRM-PRODUCAO.TESTE-PRODUCAO" 
	 U_F3PROD()
	 SetKey(VK_F8,{||U_F3PROD()})
     RETURN(.T.)
ENDIF

_aArea 		:= GetArea()
_aAreaB1 	:= SB1->(GetArea())

Private aRotina := { {"Pesquisar"	,"AxPesqui"					,0,1} ,;
{"Visualizar"		,"AxVisual"					,0,2} ,;
{"Posiciona"		,"U_fAtualiza()"			,0,4} ,;
{"Compras"			,"U_fCProd415(SB1->B1_COD)"	,0,4} ,;
{"Vendas"			,"U_fCVen415(SB1->B1_COD)"	,0,4} ,;
{"Precos"			,"U_RFATC001(SB1->B1_COD)"	,0,4}	}

If Alltrim(FunName()) == "MATA410"
	_nPosProd	:= aScan(aHeader,{|x| Alltrim(x[2])=="C6_PRODUTO"})
	_cProduto	:= aCols[n,_nPosProd]
ElseIf Alltrim(FunName()) == "MATA415"                                        
	_cProduto := M->CK_PRODUTO
ElseIf Alltrim(FunName()) == "OMSA010"
	_cProduto := M->DA1_CODPRO
	                                             
	
EndIf


DbSelectArea("SB1")


mBrowse( 6,1,22,75,"SB1",,,,"SB1->B1_MSBLQL <> '1'")   // filtra produtos bloqueados no browse

If Alltrim(FunName()) == "MATA410"
	//	aCols[n,_nPosProd] := SB1->B1_COD
	M->C6_PRODUTO		:= SB1->B1_COD
ElseIf Alltrim(FunName()) == "MATA415"
	M->CK_PRODUTO := SB1->B1_COD
EndIf

RestArea(_aArea)

Return(.t.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fAtualiza ºAutor  ³Adriano Luis Brandaoº Data ³  23/05/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para reposicionar registros.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function fAtualiza()

SB1->(DbSeek(xFilial("SB1")+_cProduto))

Return
