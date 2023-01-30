/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR021   บAutor  ณAdriano Luis Brandaoบ Data ณ  24/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar relatorio de movimento produto quimicos  บฑฑ
ฑฑบ          ณ controlados SSP/POLICIA CIVIL ESTADUAL.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTR021()

Private cPerg := "RESTR021"
Private oPrint
Private nPag := 1

// Criacao das perguntas
fCriaSx1()

// Abre Perguntas em tela.
If ! Pergunte(cPerg,.t.)
	Return
EndIf

// Se confirmar a impressao chama rotina de processamento.
If ApMsgYesNo("Confirma Impressao do relatorio ??","Confirmar")
	Processa({ || fImprime()})
	oPrint:Preview()
EndIf	                   
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImprime  บAutor  ณAdriano Luis Brandaoบ Data ณ  24/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para processamento da impressao grafica.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImprime()

// Fontes utilizadas no relatorio.
Private oArial08	:= TFont():New("Arial"			,08,07,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial09	:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial10	:= TFont():New("Arial"			,10,09,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial12	:= TFont():New("Arial"			,12,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial14	:= TFont():New("Arial"			,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oArial09N	:= TFont():New("Arial"			,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial10N	:= TFont():New("Arial"			,10,09,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial12N	:= TFont():New("Arial"			,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial14N	:= TFont():New("Arial"			,14,13,.T.,.T.,5,.T.,5,.T.,.F.)
Private oArial16N	:= TFont():New("Arial"			,16,15,.T.,.T.,5,.T.,5,.T.,.F.)

Private oCour09		:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour09N	:= TFont():New("Courier New"	,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour10		:= TFont():New("Courier New"	,10,09,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour10T	:= TFont():New("Courier New"	,10,09,.T.,.F.,5,.T.,5,.T.,.T.)
Private oCour11		:= TFont():New("Courier New"	,11,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour11N	:= TFont():New("Courier New"	,11,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour12		:= TFont():New("Courier New"	,12,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour12N	:= TFont():New("Courier New"	,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour12T	:= TFont():New("Courier New"	,12,11,.F.,.F.,5,.T.,5,.T.,.T.)
Private oCour14		:= TFont():New("Courier New"	,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour09N	:= TFont():New("Courier New"	,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour10N	:= TFont():New("Courier New"	,10,09,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour10S	:= TFont():New("Courier New"	,10,09,.T.,.T.,5,.T.,5,.T.,.T.)
Private oCour12N	:= TFont():New("Courier New"	,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour12S	:= TFont():New("Courier New"	,12,11,.T.,.F.,5,.T.,5,.T.,.T.)
Private oCour14 	:= TFont():New("Courier New"	,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour14N	:= TFont():New("Courier New"	,14,13,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour15 	:= TFont():New("Courier New"	,15,14,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour16 	:= TFont():New("Courier New"	,16,16,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour16N	:= TFont():New("Courier New"	,16,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour16S	:= TFont():New("Courier New"	,16,16,.T.,.T.,5,.T.,5,.T.,.T.)
Private oCour18N	:= TFont():New("Courier New"	,18,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oCour20N	:= TFont():New("Courier New"	,20,20,.T.,.T.,5,.T.,5,.T.,.F.)

Private oTreb10 	:= TFont():New("Trebuchet MS"	,10,09,.T.,.F.,5,.T.,5,.T.,.F.)
Private oTreb10N 	:= TFont():New("Trebuchet MS"	,10,09,.T.,.T.,5,.T.,5,.T.,.F.)
Private oTreb12 	:= TFont():New("Trebuchet MS"	,12,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oTreb12N 	:= TFont():New("Trebuchet MS"	,12,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oTreb14 	:= TFont():New("Trebuchet MS"	,14,13,.T.,.F.,5,.T.,5,.T.,.F.)
Private oTreb14N 	:= TFont():New("Trebuchet MS"	,14,13,.T.,.T.,5,.T.,5,.T.,.F.)

Private nRowIni		:= 0050
Private nRowFim		:= 2300
Private nColIni		:= 0050
Private nColFim		:= 3160
Private _cTrim		:= Strzero(MV_PAR01,1) 

Do Case
	Case MV_PAR01 == 1
		_cPerioI	:= MV_PAR02+"01"
		_cPerioF    := MV_PAR02+"03"
		
	Case MV_PAR01 == 2
		_cPerioI	:= MV_PAR02+"04"
		_cPerioF    := MV_PAR02+"06"
		
	Case MV_PAR01 == 3
		_cPerioI	:= MV_PAR02+"07"
		_cPerioF    := MV_PAR02+"09"
	Otherwise
		_cPerioI	:= MV_PAR02+"10"
		_cPerioF    := MV_PAR02+"12"
EndCase

_cQuery := "SELECT ZV_ANO, ZV_MES, ZV_CLAS, ZV_DESCRI, ZV_SLDANT, ZV_COMPRAS, ZV_CONSUMO, ZV_SAIDAS, ZV_SALFIN, ZS_UM, ZV_ENTDV, ZV_SAIDV "
_cQuery += "       FROM " + RetSqlname("SZV") + " ZV "
_cQuery += "       INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "               ON ZV_ORGAO = ZS_ORGAO AND ZV_CLAS = ZS_CON "                  
_cQuery += "                  AND ZS.D_E_L_E_T_ = ' ' "
_cQuery += "       WHERE ZV_ORGAO = '003' "             
_cQuery += "             AND ZV_ANO+ZV_MES BETWEEN '" + _cPerioI + "' AND '" + _cPerioF + "' "
_cQuery += "             AND ZV.D_E_L_E_T_ = ' ' "                                           
_cQuery += "       ORDER BY ZV_CLAS, ZV_ANO, ZV_MES "

MemoWrite("\queries\estr021.sql",_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","ZV_SLDANT"	,"N",13,3)
TcSetField("QR1","ZV_COMPRAS"	,"N",13,3)
TcSetField("QR1","ZV_CONSUMO"	,"N",13,3)
TcSetField("QR1","ZV_SAIDAS"	,"N",13,3)
TcSetField("QR1","ZV_SALFIN"	,"N",13,3)
TcSetField("QR1","ZV_ENTDV" 	,"N",13,3)
TcSetField("QR1","ZV_SAIDV"	    ,"N",13,3)

oPrint:= TMSPrinter():New( "Movimento geral SSP" )
oPrint:SetLandscape() // SetPortrait() 

QR1->(DbGoTop())

nLinha := 1860
lPrimeiro := .t.
Do While ! QR1->(Eof())

	If nLinha > 1850
		If ! lPrimeiro 
			oPrint:EndPage()
		EndIf 
		lPrimeiro := .f.
		fForm()
		nLinha := 0535
	EndIf     

	_cClas := QR1->ZV_CLAS
	                                                    
	_nSalAnt 	:= 0
	_nCompras	:= 0
	_nConsumo	:= 0
	_nSaidas	:= 0
	_nSalFin	:= 0
	_nPerda     := 0             
	_cDesc		:= ""
	_cUM		:= ""
	
	Do While ! QR1->(Eof()) .And. QR1->ZV_CLAS == _cClas
	                            
		If (QR1->ZV_ANO+QR1->ZV_MES) == _cPerioI
			_nSalAnt := QR1->ZV_SLDANT
		EndIf
	                        
		_cDesc		:= QR1->ZV_DESCRI
		_cUM		:= QR1->ZS_UM
		
		_nCompras	+= (QR1->ZV_COMPRAS+QR1->ZV_ENTDV)
		_nConsumo	+= QR1->ZV_CONSUMO
		_nPerda     += QR1->ZV_SAIDV
		_nSaidas	+= QR1->ZV_SAIDAS
		QR1->(DbSkip()) 
	EndDo	    
	
	 _nSalFin :=(_nSalAnt+_nCompras-_nConsumo-_nSaidas-_nPerda)  
	
oPrint:Say(nRowIni+nLinha,nColIni+0040,_cDesc   										           ,oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+0670,Transform(_nSalAnt           			 ,"@e 999,999.999"),oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+0995,Transform(_nCompras                       ,"@e 999,999.999"),oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+1310,Transform((_nSalAnt+_nCompras)            ,"@e 999,999.999"),oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+1640,Transform(_nConsumo                       ,"@e 999,999.999"),oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+1960,Transform(_nSaidas                        ,"@e 999,999.999"),oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+2280,Transform(_nPerda                         ,"@e 999,999.999"),oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+2600,Transform(_nSalFin                        ,"@e 999,999.999"),oArial08)
oPrint:Say(nRowIni+nLinha,nColIni+2960,_cUM     												   ,oArial08)
nLinha += 0050
	
EndDo

QR1->(DbCloseArea())

oPrint:EndPage()     // Finaliza a pแgina                    

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSX1  บAutor  ณAdriano Luis Brandaoบ Data ณ  24/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas do relatorio.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSx1()

PutSx1(cPerg,"01","Qual Trimestre ?" ,"Qual Trimestre ?","Qual Trimestre ?","mv_ch1","N",08,0,0,"C","","","","","mv_par01","1-Trimestre","1-Trimestre","-1Trimestre","","2-Trimestre","2-Trimestre","2-Trimestre","3-Trimestre","3-Trimestre","3-Trimestre","4-Trimestre","4-Trimestre","4-Trimestre","","","",,,)
PutSx1(cPerg,"02","Ano ?"            ,"Ano ?"           ,"Ano ?"           ,"mv_ch2","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfForm     บAutor  ณAdriano Luis Brandaoบ Data ณ  24/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para montar o formulario de impressao em branco.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fForm()

LOCAL _NY

oPrint:StartPage()

//
// CABECALHO
//
oPrint:box(nRowIni,nColIni,nRowFim,nColFim) // Box Externo
oPrint:Box(nRowIni+0020,nColIni+0020,nRowIni+0400,nColFim-0020) 	// cabecalho
oPrint:Line(nRowIni+0020,nColIni+1230,nRowIni+0400,nColIni+1230)    // Coluna1 cabecalho
oPrint:Line(nRowIni+0020,nColIni+2110,nRowIni+0400,nColIni+2110)    // Coluna2 cabecalho
// PRIMEIRO QUADRO
oPrint:Say(nRowIni+0040,nColIni+0040,"ALPAX COMERCIO DE PRODUTOS P/LABORATORIOS LTDA."	,oTreb10N)
oPrint:Say(nRowIni+0110,nColIni+0040,"ESTABELECIMENTO LICENCIADO:"	                    		,oTreb10)
oPrint:Say(nRowIni+0180,nColIni+0040,"R.SERRA DA BORBOREMA, 40                         BAIRRO:CAMPANARIO",oTreb10)
oPrint:Say(nRowIni+0250,nColIni+0040,"CIDADE:DIADEMA   ESTADO:SP   CEP:09930-580   TEL.:11.4057-9200",oTreb10)
oPrint:Say(nRowIni+0340,nColIni+0040,"CNPJ:65.838.344/0001-10  -  INSCRIวรO ESTADUAL:286.100.047.111",oTreb10)
// SEGUNDO QUADRO
oPrint:Say(nRowIni+0040,nColIni+1420,"MOVIMENTO GERAL",oCour18N)
oPrint:Say(nRowIni+0100,nColIni+1540,"MAPA TRIMESTRAL",oCour10N)
oPrint:Say(nRowIni+0140,nColIni+1420,"PRODUTOS QUอMICOS CONTROLADOS",oCour10N)
oPrint:Say(nRowIni+0190,nColIni+1350,"DECADE-DPCRD - DIVISAO DE PRODUTOS",oCour10N)
oPrint:Line(nRowIni+0230,nColIni+1350,nRowIni+0230,nColIni+2040)
oPrint:Say(nRowIni+0240,nColIni+1350,"CONTROLADOS E REGISTROS DIVERSOS",oCour10N)
oPrint:Line(nRowIni+0280,nColIni+1350,nRowIni+0280,nColIni+2040)
oPrint:Say(nRowIni+0305,nColIni+1250,"Referente ao ",oCour12)
oPrint:Say(nRowIni+0300,nColIni+1580,_cTrim + "บ",oCour14N)
oPrint:Say(nRowIni+0305,nColIni+1645,"trimestre de ",oCour12)
oPrint:Say(nRowIni+0300,nColIni+1975,MV_PAR02,oCour14N)
oPrint:Line(nRowIni+0350,nColIni+1250,nRowIni+0350,nColIni+2100)
// TERCEIRO QUADRO
oPrint:Say(nRowIni+0050,nColIni+2800,"Pagina : "+ Strzero(nPag,3)                                       ,oCour12)
nPag++
//oPrint:Say(nRowIni+0100,nColIni+2150,"CERTIFICADO  DE  VISTORIA  Nบ 010/2021, EXPEDIDO",oTreb12)
oPrint:Say(nRowIni+0100,nColIni+2150,"CERTIFICADO  DE  VISTORIA  Nบ "+MV_PAR03+" , EXPEDIDO ",oTreb12) //Moises 110422
oPrint:Say(nRowIni+0150,nColIni+2150,"PELA SSP/POLอCIA  CIVIL  ESTADUAL",oTreb12)
//oPrint:Say(nRowIni+0200,nColIni+2150,"ALVARม Nบ 038/2021, EXPEDIDO PELA SECRETARIA DA",oTreb12)
oPrint:Say(nRowIni+0200,nColIni+2150,"ALVARม  Nบ "+MV_PAR04+" , EXPEDIDO  PELA  SECRETARIA DA",oTreb12) //Moises 110422
oPrint:Say(nRowIni+0250,nColIni+2150,"SEGURANวA  PฺBLICA/POLอCIA  CIVIL ESTADUAL.",oTreb12)
oPrint:Say(nRowIni+0318,nColIni+2970,".",oCour18N)
oPrint:Say(nRowIni+0340,nColIni+3000,"1503",oTreb12)

//
// ITENS
//
oPrint:Box(nRowIni+0420,nColIni+0020,nRowFim-370,nColFim-0020)	 // Itens
oPrint:Line(nRowIni+0520,nColIni+0020,nRowIni+0520,nColFim-0020) // linha Sub-titulos
// PRIMEIRO QUADRO
oPrint:Say(nRowIni+0430,nColIni+0070,"NOME DE CADA PRODUTO"	,oCour11N)
oPrint:Say(nRowIni+0460,nColIni+0150,"CONTROLADO"	,oCour11N)
// SEGUNDO QUADRO
oPrint:Say(nRowIni+0430,nColIni+0570,"SALDO DO TRIMESTRE"	,oCour09)
oPrint:Say(nRowIni+0460,nColIni+0650,"ANTERIOR"	,oCour09)
// TERCEIRO QUADRO
oPrint:Say(nRowIni+0430,nColIni+0980,"TOTAL DE"	,oCour10)
oPrint:Say(nRowIni+0460,nColIni+0995,"COMPRAS"	,oCour10)
// QUARTO QUADRO
oPrint:Say(nRowIni+0430,nColIni+1320,"SOMAS"	,oCour10)
oPrint:Say(nRowIni+0460,nColIni+1240,"(SALDO+COMPRAS)"	,oCour10)
// QUINTO QUADRO
oPrint:Say(nRowIni+0450,nColIni+1620,"CONSUMOS"	,oCour12N)
// SEXTO QUADRO
oPrint:Say(nRowIni+0450,nColIni+1960,"VENDAS"	,oCour12N)
// SETIMO QUADRO
oPrint:Say(nRowIni+0430,nColIni+2230,"PERDAS OU"	,oCour09)
oPrint:Say(nRowIni+0460,nColIni+2190,"TRANSFERENCIAS"	,oCour09)
// OITAVO QUADRO
oPrint:Say(nRowIni+0430,nColIni+2460,"SALDO QUE PASSA PARA O"	,oCour10)
oPrint:Say(nRowIni+0460,nColIni+2480,"TRIMESTRE SEGUINTE"	,oCour10)
// NONO QUADRO
oPrint:Say(nRowIni+0430,nColIni+2890,"UNIDADE DE"	,oCour09)
oPrint:Say(nRowIni+0460,nColIni+2880,"MEDIDA-KG/L"	,oCour09)

// Linhas dos itens
nLinTmp := nRowIni+0520+50
For _nY := 1 To 26
	oPrint:Line(nLinTmp,nColIni+0020,nLinTmp,nColFim-0020)
	nLinTmp+=50
Next _nY           
// Colunas dos Itens
oPrint:Line(nRowIni+0420,nColIni+0550,nRowFim-370,nColIni+0550)
oPrint:Line(nRowIni+0420,nColIni+0900,nRowFim-370,nColIni+0900)
oPrint:Line(nRowIni+0420,nColIni+1210,nRowFim-370,nColIni+1210)
oPrint:Line(nRowIni+0420,nColIni+1540,nRowFim-370,nColIni+1540)
oPrint:Line(nRowIni+0420,nColIni+1870,nRowFim-370,nColIni+1870)
oPrint:Line(nRowIni+0420,nColIni+2160,nRowFim-370,nColIni+2160)
oPrint:Line(nRowIni+0420,nColIni+2450,nRowFim-370,nColIni+2450)
oPrint:Line(nRowIni+0420,nColIni+2870,nRowFim-370,nColIni+2870)

// RODAPE
//
oPrint:Box(nRowFim-0350,nColIni+0020,nRowFim-0020,nColIni+1200) // Rodape 1
oPrint:Box(nRowFim-0350,nColIni+1220,nRowFim-0020,nColIni+2030)	// Rodape 2
oPrint:Box(nRowFim-0350,nColIni+2050,nRowFim-0020,nColFim-0020)	// Rodape 3
// PRIMEIRO QUADRO
oPrint:Say(nRowFim-0300,nColIni+0040,"ENVIAR EM TRES(3) VIAS. A NรO ENTREGA ATษ O DษCIMO(10บ) DIA ฺTIL"	,oCour09)
oPrint:Say(nRowFim-0260,nColIni+0040,"APำS O TษRMINO DE CADA TRIMESTRE PODE ACARRETAR EM PENALIDADES.",oCour09)
oPrint:Say(nRowFim-0230,nColIni+0040,"Obs.:",oCour09)
// SEGUNDO QUADRO
oPrint:Say(nRowFim-0300,nColIni+1300,"ARNON REIS - ASSESSORIA",oCour14N)
oPrint:Say(nRowFim-0220,nColIni+1300,"E  DOCUMENTOS ESPECIAIS",oCour14N)
oPrint:Say(nRowFim-0150,nColIni+1250,"RUA BARAO DE ITAPETININGA 255 3.ANDAR CJ.309 CENTRO",oArial08)
//oPrint:Line(nRowFim-0118,nColIni+1250,nRowFim-0115,nColFim-1250)
oPrint:Say(nRowFim-0110,nColIni+1250,"SAO PAULO, SP   -    ",oArial08)
oPrint:Say(nRowFim-0110,nColIni+1500,"METRO REPUBLICA",oArial08)
oPrint:Say(nRowFim-0110,nColIni+1735,"   -   CEP 01042-917",oArial08)
//oPrint:Line(nRowFim-0078,nColIni+1250,nRowFim-0078,nColFim-1250)
oPrint:Say(nRowFim-0070,nColIni+1250,"arnonreis@arnonreis.com.br",oArial08)
oPrint:Say(nRowFim-0070,nColIni+1650,"  -        TEL 11.3255-7720",oArial08)
//oPrint:Line(nRowFim-0038,nColIni+1250,nRowFim-0038,nColIni+2005)
// TERCEIRO QUADRO
oPrint:Say(nRowFim-0300,nColIni+2100,"O QUE DECLARO E VERDADE, SOB AS PENAS DA LEI.",oCour10N)
oPrint:Say(nRowFim-0230,nColIni+2100,"DIADEMA,",oCour10N)
oPrint:Say(nRowFim-0110,nColIni+2100,"ASSINATURA :",oCour10)
oPrint:Line(nRowFim-0080,nColIni+2350,nRowFim-0080,nColIni+3060)
oPrint:Say(nRowFim-0060,nColIni+2100,"NOME/CARGO/RG :",oCour10)
oPrint:Say(nRowFim-0055,nColIni+2405,"LUCI AKEMI MASUMOTO / SOCIA / 7.700.270-2",oArial08)

Return
