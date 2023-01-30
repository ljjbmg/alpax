#INCLUDE "rwmake.ch"
#Include "Topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR022   ºAutor  ³Microsiga           º Data ³  14/03/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao do Resumo Geral (Ministerio do Exercito)         º±±
±±º          ³ COM A OPCAO DE NUMERO GUIA DE TRAFEGO E PROCEDENCIA        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ESTR022()


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private _cDia		:= Strzero(Day(dDataBase),2)
Private _aMes		:= {"Janeiro","Fevereiro","Marco","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro",;
"Dezembro"}
Private _cAno		:= Strzero(Year(dDataBase),4)
Private cPerg		:= "RESTR22"

_fCriaSx1()

If ! Pergunte(cPerg,.t.)
	Return
EndIf

If ApMsgYesNo("Confirma impressao ","Confirmar")
	MsgRun("Aguarde, gerando relatorio !!!!!!",,{ || fImprime()})
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImprime  ºAutor  ³Adriano Luis Brandaoº Data ³  21/03/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de impressao do relatorio                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fImprime()

Local nOrdem

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8CN	:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16 	:= TFont():New("Arial"          ,16,16,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"          ,16,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16NT	:= TFont():New("Arial"          ,16,16,.T.,.T.,5,.T.,5,.T.,.T.)
Private oFont18N	:= TFont():New("Arial"			,18,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,20,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"     		,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont26N	:= TFont():New("Arial"			,26,26,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)

Private nRowIni		:= 0000 // Linha inicial
Private nColIni 	:= 0000 // coluna inicial
Private nRowFim 	:= 2300 // linha final
Private nColFim 	:= 3100 // coluna final

Private _nRowInic	:= 0000 // Linha inicial dos itens
Private _nRowLim	:= 0000 // Linha final dos itens
Private _nLinItem	:= 0000 // Linha do item a imprimir

_cTrim := Strzero(MV_PAR01,1)
_cAnoI := MV_PAR02

_cQuery := "SELECT COUNT(*) AS TOTAL "
_cQuery += "       FROM " + RetSqlName("SZF") + " ZF, " + RetSqlName("SZG") + " ZG "
_cQuery += "       WHERE ZF_FILIAL = '" + xFilial("SZF") + "' AND ZG_FILIAL = '" + xFilial("SZG") + "' "
_cQuery += "             AND ZF.D_E_L_E_T_ = ' ' AND ZG.D_E_L_E_T_ = ' ' "
_cQuery += "             AND ZG_TRIMEST = '" + _cTrim + "' AND ZG_ANO = '" + MV_PAR02 + "' "
_cQuery += "             AND ZG_CODIGO = ZF_CODIGO "

TcQuery _cQuery New Alias "QR1"
_nTotal := QR1->TOTAL
_nPagAte := iif(QR1->TOTAL - INT(QR1->TOTAL/45) > 0,INT(QR1->TOTAL/45)+1,QR1->TOTAL)

QR1->(DbCloseArea())

_cQuery := "SELECT ZF_CODIGO, ZF_DESC, ZG_SALANT, ZG_COMPRAS, ZG_CONSUMO, ZG_PERDAS, ZG_SAIDAS, ZG_SALFIN, ZF_UM "
_cQuery += "       FROM " + RetSqlName("SZF") + " ZF, " + RetSqlName("SZG") + " ZG "
_cQuery += "       WHERE ZF_FILIAL = '" + xFilial("SZF") + "' AND ZG_FILIAL = '" + xFilial("SZG") + "' "
_cQuery += "             AND ZF.D_E_L_E_T_ = ' ' AND ZG.D_E_L_E_T_ = ' ' "
_cQuery += "             AND ZG_TRIMEST = '" + _cTrim + "' AND ZG_ANO = '" + MV_PAR02 + "' "
_cQuery += "             AND ZG_CODIGO = ZF_CODIGO "
_cQuery += "       ORDER BY ZF_DESC "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","ZG_SALANT"	,"N",13,3)
TcSetField("QR1","ZG_COMPRAS"	,"N",13,3)
TcSetField("QR1","ZG_CONSUMO"	,"N",13,3)
TcSetField("QR1","ZG_SAIDAS"	,"N",13,3)
TcSetField("QR1","ZG_SALFIN"	,"N",13,3)

QR1->(DbGoTop())

_lPrimeiro := .t.

oPrint:= TMSPrinter():New( "Requisicao Interna" )
oPrint:SetLandscape()  //SetPortrait()

fCabec()

While !QR1->(Eof())
	
	If _nLinItem > _nRowLim		// Testa salto de pagina.
		oPrint:EndPage()
		fCabec()
	EndIf
	
	_aGuia		:= {}
	_aProced	:= {}
	
	// ZN_FILIAL, ZN_ANO, ZN_TRIMEST, ZN_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	
	SZN->(DbSeek(xFilial("SZN")+MV_PAR02+_cTrim+QR1->ZF_CODIGO))
	Do While ! SZN->(Eof()) .And. (xFilial("SZN")+MV_PAR02+_cTrim+QR1->ZF_CODIGO) == (SZN->ZN_FILIAL+SZN->ZN_ANO+SZN->ZN_TRIMEST+SZN->ZN_PRODUTO)
		aAdd(_aGuia,Alltrim(SZN->ZN_NF))
		SZN->(DbSkip())
	EndDo
	
	_aGui := fQuebra(_aGuia,24,.f.)		// Funcao que retorna um array novo, com as colunas quebradas de acordo com o tamanho definido no 2o.parametro
	
	// ZO_FILIAL, ZO_ANO, ZO_TRIMEST, ZO_PRODUTO, R_E_C_N_O_, D_E_L_E_T_
	
	SZO->(DbSeek(xFilial("SZO")+MV_PAR02+_cTrim+QR1->ZF_CODIGO))
	Do While ! SZO->(Eof()) .And. (xFilial("SZO")+MV_PAR02+_cTrim+QR1->ZF_CODIGO) == (SZO->ZO_FILIAL+SZO->ZO_ANO+SZO->ZO_TRIMEST+SZO->ZO_PRODUTO)
		If Ascan(_aProced,SZO->ZO_FORN) == 0
			aAdd(_aProced,SZO->ZO_FORN)
		EndIf
		SZO->(DbSkip())
	EndDo
	// Novo array com o nome do Fornecedor
	_aTemp := {}
	For _nF := 1 To Len(_aProced)
		_cRazao := Alltrim(Posicione("SA2",1,xFilial("SA2")+_aProced[_nF],"A2_NOME"))
		aAdd(_aTemp,_cRazao)
	Next _nF
	
	_aProc := fQuebra(_aTemp,40,.t.)	// Funcao que retorna um array novo, com as colunas quebradas de acordo com o tamanho definido no 2o.parametro
	
	_nItens := Max(Len(_aProc),Len(_aGui))
	
	oPrint:Say(_nLinItem,0050,Left(QR1->ZF_DESC,27),oFont10) // Produto controlado
	oPrint:Say(_nLinItem,0620,_aGui[1],oFont10) // Numero guia de trafego
	oPrint:Say(_nLinItem,1130,Transform(QR1->ZG_COMPRAS,"@e 999,999.999"),oFont10) // ENTRADA
	oPrint:Say(_nLinItem,1380,Transform(QR1->ZG_SALANT,"@e 999,999.999"),oFont10) // ESTOQUE ANTERIOR
	oPrint:Say(_nLinItem,1630,Transform(QR1->ZG_CONSUMO+QR1->ZG_PERDAS+QR1->ZG_SAIDAS,"@e 999,999.999"),oFont10) // CONSUMO
	oPrint:Say(_nLinItem,1870,Transform(QR1->ZG_SALFIN,"@e 999,999.999"),oFont10) // ESTOQUE PROXIMO PERIODO
	oPrint:Say(_nLinItem,2120,QR1->ZF_UM,oFont10) // UNIDADE DE MEDIDA
	oPrint:Say(_nLinItem,2270,_aProc[1],oFont10) // PROCEDENCIA
	_nLinItem+=0050
	
	For _nZ := 2 To _nItens
		
		If _nLinItem > _nRowLim		// Testa salto de pagina.
			oPrint:EndPage()
			fCabec()
		EndIf
		
		If Len(_aGui) >= _nZ
			oPrint:Say(_nLinItem,0620,_aGui[_nZ],oFont10) // Numero guia de trafego
		EndIf
		If Len(_aProc) >= _nZ
			oPrint:Say(_nLinItem,2270,_aProc[_nZ],oFont10) // PROCEDENCIA
		EndIf
		_nLinItem+=0050
	Next _nZ
	
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

oPrint:EndPage()
oPrint:Preview()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCriaSx1 ºAutor  ³Microsiga           º Data ³  22/10/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fCriaSx1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³MV_PAR01 = Trimestre  ³
//*MV_PAR02 = Ano        *
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

PutSx1(cPerg,"01","Qual Trimestre ?" ,"Qual Trimestre ?","Qual Trimestre ?","mv_ch1","N",08,0,0,"C","","","","","mv_par01","1-Trimestre","1-Trimestre","-1Trimestre","","2-Trimestre","2-Trimestre","2-Trimestre","3-Trimestre","3-Trimestre","3-Trimestre","4-Trimestre","4-Trimestre","4-Trimestre","","","",,,)
PutSx1(cPerg,"02","Ano ?"            ,"Ano ?"           ,"Ano ?"           ,"mv_ch2","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fCabec    ºAutor  ³Adriano Luis Brandaoº Data ³  21/03/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de impressao do cabecalho do relatorio.              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fCabec()


oPrint:StartPage()
oPrint:box(nRowIni,ncolIni,nRowFim,ncolFim)
oPrint:Say(nRowIni+0020,1400,"ANEXO XXIV",oFont10)
oPrint:Say(nRowIni+0070,0550,"MAPA DE ESTOCAGEM DE PRODUTOS CONTROLADOS",oFont16)
oPrint:Say(nRowIni+0170,0100,"Excelentíssimo Senhor Comandante da 2ª Região Militar",oFont12)
oPrint:Say(nRowIni+0270,0100,"ALPAX COMERCIO DE PRODUTOS P/ LABORATORIOS LTDA.",oFont12)
oPrint:Say(nRowIni+0270,1600,", estabelecida  em  DIADEMA, na  R.SERRA DA BORBOREMA, 40,",oFont12)
oPrint:Say(nRowIni+0320,0100,"portadora do Certificado de Registro nº 14865, apresenta à Vossa Excelência o",oFont12)
oPrint:Say(nRowIni+0320,1800," Mapa  de  Estocagem",oFont12)
oPrint:Say(nRowIni+0320,2400," de  produtos",oFont12)
oPrint:Say(nRowIni+0370,0100,"controlados referente ao",oFont12)
oPrint:Say(nRowIni+0370,0650,_cTrim +" º ",oFont12)
oPrint:Say(nRowIni+0370,0720," trimestre de ",oFont12)
oPrint:Say(nRowIni+0370,1050,_cAnoI,oFont12)
oPrint:Say(nRowIni+0370,1150," , de  acordo  com  o  Regulamento  para  a  Fiscalização  de  Produtos",oFont12)
oPrint:Say(nRowIni+0420,0100,"Controlados (R-105).",oFont12)

_nLin := nRowIni+0500

// Quadro dos itens

oPrint:Box(_nLin,0020,nRowFim-0020,nColFim-0020)
oPrint:Line(_nLin+0200,nColIni+0020,_nLin+0200,nColFim-0020)

// Linhas verticais

oPrint:Line(_nLin,0600,nRowFim-0020,0600) // PRODUTO CONTROLADO
oPrint:Line(_nLin,1100,nRowFim-0020,1100) // NUMERO GUIA DE TRAFEGO
oPrint:Line(_nLin,1350,nRowFim-0020,1350) // ENTRADA
oPrint:Line(_nLin,1600,nRowFim-0020,1600) // ESTOQUE TRIMESTRE ANTERIOR
oPrint:Line(_nLin,1850,nRowFim-0020,1850) // CONSUMO SAIDA/VENDAS
oPrint:Line(_nLin,2100,nRowFim-0020,2100) // ESTOQUE PARA PROXIMO TRIMESTRE
oPrint:Line(_nLin,2250,nRowFim-0020,2250) // UNIDADE

// Titulos das colunas
oPrint:Say(_nLin+0075,0100,"PRODUTO CONTROLADO",oFont10N)

oPrint:Say(_nLin+0050,0700,"NÚMERO DA(S)",oFont10N)
oPrint:Say(_nLin+0100,0640,"GUIA(S) DE TRÁFEGO",oFont10N)

oPrint:Say(_nLin+0075,1140,"ENTRADA",oFont10N)

oPrint:Say(_nLin+0020,1380,"ESTOQUE",oFont10N)
oPrint:Say(_nLin+0060,1440,"DO",oFont10N)
oPrint:Say(_nLin+0100,1370,"TRIMESTRE",oFont10N)
oPrint:Say(_nLin+0150,1380,"ANTERIOR",oFont10N)

oPrint:Say(_nLin+0020,1630,"CONSUMO",oFont10N)
oPrint:Say(_nLin+0060,1640,"( SAÍDAS,",oFont10N)
oPrint:Say(_nLin+0100,1630,"INCLUSIVE",oFont10N)
oPrint:Say(_nLin+0150,1640,"VENDAS )",oFont10N)

oPrint:Say(_nLin+0020,1870,"ESTOQUE QUE",oFont8)
oPrint:Say(_nLin+0060,1870,"PASSA PARA O",oFont8)
oPrint:Say(_nLin+0100,1880,"TRIMESTRE",oFont8)
oPrint:Say(_nLin+0150,1880,"SEGUINTE )",oFont8)

oPrint:Say(_nLin+0030,2120,"UN.DE",oFont10)
oPrint:Say(_nLin+0070,2120,"MEDIDA",oFont10)
oPrint:Say(_nLin+0110,2120,"KG ou L",oFont10)

oPrint:Say(_nLin+0075,2500,"PROCEDÊNCIA",oFont14N)

/*             posicao dos itens
oPrint:Say(_nLin+0200,0050,Replicate("X",27),oFont11C) // Produto controlado
oPrint:Say(_nLin+0200,0620,Replicate("X",24),oFont11C) // Numero guia de trafego
oPrint:Say(_nLin+0200,1130,Replicate("X",10),oFont11C) // ENTRADA
oPrint:Say(_nLin+0200,1380,Replicate("X",10),oFont11C) // ESTOQUE ANTERIOR
oPrint:Say(_nLin+0200,1630,Replicate("X",10),oFont11C) // CONSUMO
oPrint:Say(_nLin+0200,1870,Replicate("X",10),oFont11C) // ESTOQUE PROXIMO PERIODO
oPrint:Say(_nLin+0200,2120,Replicate("X",02),oFont11C) // UNIDADE DE MEDIDA
oPrint:Say(_nLin+0200,2270,Replicate("X",40),oFont11C) // PROCEDENCIA
*/

_nRowInic	:= _nLin+0200 			// Linha inicial dos itens
_nRowLim	:= (nRowFim-0070)	// Linha final dos itens

_nLinItem := _nRowInic

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fQuebra   ºAutor  ³Adriano Luis Brandaoº Data ³  28/03/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para quebrar em novo Array, com limitaçao de colunasº±±
±±º          ³ de acordo com o recebido nos parametros, retornando novo   º±±
±±º          ³ array                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fQuebra(_aTexto,_nColunas,lSimples)

_aRet := {}

_lPrim := .t.
_cTexto:= ""

If ! lSimples
	For _nY := 1 To Len(_aTexto)
		If _lPrim
			_cTexto := _aTexto[_nY]
			_lPrim := .f.
		Else
			If Len(_cTexto+"/"+_aTexto[_nY]) > _nColunas
				aAdd(_aRet,_cTexto)
				_cTexto := _aTexto[_nY]
			Else
				_cTexto += "/"+_aTexto[_nY]
			EndIf
		EndIf
	Next _nY
	
	aAdd(_aRet,_cTexto)
	
Else
	
	_cTexto := ""
	
	For _nY := 1 To Len(_aTexto)
		_cTexto += _aTexto[_nY]+"/"
		If Len(_cTexto) > _nColunas
			aAdd(_aRet,Left(_cTexto,_nColunas))
			_cTexto := Substr(_cTexto,_nColunas+1,(Len(_cTexto)-_nColunas))
		EndIf
	Next _nY
	aAdd(_aRet,_cTexto)
EndIf

Return(_aRet)
