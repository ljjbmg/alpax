/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR001   บAutor  ณAdriano Luis Brandaoบ Data ณ  11/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao de etiqueta termica para expedicao dos บฑฑ
ฑฑบ          ณ produtos, por nota fiscal. (Impressora Allegro)            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#include "rwmake.ch"

User Function ESTR001()

cPerg      := "ESTR01"

_fCriaSx1()

IF ! Pergunte(cPerg,.T.)
	Return
Endif

_fImprime()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprime บAutor  ณAdriano Luis Brandaoบ Data ณ  11/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para impressao da etiqueta.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fImprime()

local _lPrint    := .f.
local _lPrimeiro := .t.
local _cPorta    := "LPT1"

SD2->(DbSetOrder(3))
//D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_

SC5->(DbSetOrder(1))
//C5_FILIAL, C5_NUM, R_E_C_N_O_, D_E_L_E_T_

DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+mv_par02+mv_par01,.t.)

Do While ! SF2->(Eof()) .And. (SF2->F2_FILIAL+SF2->F2_SERIE+SF2->F2_DOC) <= (xFilial("SF2")+MV_PAR01+MV_PAR03)
	If _lPrimeiro
		MSCBPRINTER("ALLEGRO",_cPorta,,,.f.,,,,,,.t.)
		_lPrimeiro := .f.
		_lPrint := .t.
	EndIf
	For _nY := 1 To SF2->F2_VOLUME1
		// cliente
		
		If SF2->F2_TIPO $ "N/C/I"
			SA1->(DbSetOrder(1))
			SA1->(DbSeek(xfilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA))
			SD2->(DbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE,.T.))
			SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			
			_cDados := 'DADOS CLIENTE'
			/*
			_cNome	:= SA1->A1_NOME
			_cEnd	:= SA1->A1_END
			_cTel	:= SA1->A1_TEL
			_cCidEst	:= Alltrim(SA1->A1_BAIRRO) + " - " + Alltrim(SA1->A1_MUN) + " - " + SA1->A1_EST
			*/
			_cNome		:= SA1->A1_NOME
			_cTel		:= SA1->A1_TEL
			_cEnd		:= Left(SC5->C5_AXENDEN,58)
			_cCidEst	:= Substr(SC5->C5_AXENDEN,59,92)
			
			// fornecedor
		Else
			SA2->(DbSetOrder(1))
			SA2->(DbSeek(xfilial("SA2")+SF2->F2_CLIENTE+SF2->F2_LOJA))
			SD2->(DbSeek(xFilial("SD1")+SF2->F2_DOC+SF2->F2_SERIE,.T.))
			SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
			_cDados := 'DADOS FORNECEDOR'
			/*
			_cNome	:=	SA2->A2_NOME
			_cEnd	:=	SA2->A2_END
			_cTel	:=	SA2->A2_TEL
			_cCidEst	:= Alltrim(SA2->A2_BAIRRO) + " - " + Alltrim(SA2->A2_MUN) + " - " + SA2->A2_EST
			*/
			_cNome	:=	SA2->A2_NOME
			_cEnd		:= Left(SC5->C5_AXENDEN,58)
			_cCidEst	:= Substr(SC5->C5_AXENDEN,59,92)
			_cTel	:=	SA2->A2_TEL
		EndIf
		
		
		If mv_par04 == 1	// Vertical
			MSCBBEGIN(1,6)
			//MSCBGRAFIC(80,10,"ALPAX.BMP") //Posiciona o logotipo
			
			_cVolume	:= Strzero(_nY,3) + "/" + Strzero(F2_VOLUME1,3)
			MSCBBOX(63,02,75,90,3,"B")	// BOX EMPRESA
			MSCBBOX(50,51,61,90,3)	// BOX NOTA FISCAL
			MSCBBOX(50,02,61,48,3)	// BOX NUMERO NOTA FISCAL
			MSCBBOX(20,02,48,90,3)	// BOX DADOS DO CLIENTE
			MSCBBOX(07,51,18,90,3)	// BOX VOLUME
			MSCBBOX(07,02,18,48,3)	// BOX QTDE.VOLUME
			MSCBLineV(40,03,89,3)	// LINHA DADOS DO CLIENTE
			MSCBSAY(67,85,'ALPAX'								,"R","2","04,02",.F.)
			MSCBSAY(70,55,'Comercio de Produtos Laborat. Ltda.'	,"R","2","01,01",.F.)
			MSCBSAY(66,55,'Fone:11 4057.9200 Fax:11 4057.9204'	,"R","2","01,01",.F.)
			MSCBSAY(53,85,'NOTA FISCAL'							,"R","2","02,02")
			MSCBSAY(53,45,SF2->F2_DOC							,"R","2","02,02")
			MSCBSAY(42,75,_cDados        		   				,"R","2","03,02")
			MSCBSAY(36,87,_cNome								,"R","3","01,01")
			MSCBSAY(32,87,_cEnd									,"R","2","01,01")
			MSCBSAY(28,87,_cCidEst								,"R","2","01,01")
			MSCBSAY(24,87,"Fone: " + _cTel						,"R","2","01,01")
			MSCBSAY(10,88,'VOLUME'								,"R","2","04,02")
			MSCBSAY(10,46,_cVolume								,"R","2","04,02")
			
			MSCBEND()
		Else		// Horizontal
			MSCBBEGIN(1,6)
			//MSCBGRAFIC(80,10,"ALPAX.BMP") //Posiciona o logotipo
			
			_cVolume	:= Strzero(_nY,3) + "/" + Strzero(F2_VOLUME1,3)
			
			MSCBBOX(05,62,95,75,3,"B")	// BOX EMPRESA
			MSCBBOX(05,49,44,60,3)		// BOX NOTA FISCAL
			MSCBBOX(46,49,95,60,3)		// BOX NUMERO NOTA FISCAL
			MSCBBOX(05,19,95,47,3)		// BOX DADOS DO CLIENTE
			MSCBBOX(05,05,45,17,3)		// BOX VOLUME
			MSCBBOX(47,05,95,17,3)		// BOX QTDE.VOLUME
			MSCBLineH(05,37,95,3)		// LINHA DADOS DO CLIENTE
			
			MSCBSAY(10,65,'ALPAX'								,"N","2","04,02",.F.)
			MSCBSAY(40,68,'Comercio de Produtos Laborat. Ltda.'	,"N","2","01,01",.F.)
			MSCBSAY(40,64,'Fone:11 4057.9200 Fax:11 4057.9204'	,"N","2","01,01",.F.)
			MSCBSAY(10,51,'NOTA FISCAL'							,"N","2","02,02")
			MSCBSAY(51,51,SF2->F2_DOC							,"N","2","02,02")
			MSCBSAY(22,39,_cDados				   				,"N","2","03,02")
			MSCBSAY(08,32,_cNome								,"N","2","01,01")
			MSCBSAY(08,28,_cEnd									,"N","2","01,01")
			MSCBSAY(08,24,_cCidEst								,"N","2","01,01")
			MSCBSAY(08,20,"Fone: " + _cTel						,"N","2","01,01")
			MSCBSAY(07,08,'VOLUME'								,"N","2","04,02")
			MSCBSAY(50,08,_cVolume								,"N","2","04,02")
			
			MSCBEND()
			
		EndIf
	Next _nY
	SF2->(DbSkip())
EndDo

If ! _lPrint
	MsgBox("Nao existe Nota Fiscal neste intervalo")
	Return
Else
	MSCBCLOSEPRINTER()
EndIf




//MSCBLOADGRF("\\ALPAX01\AP7\SIGAADV\ALPAX.BMP")


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณAdriano Luis Brandaoบ Data ณ  11/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas do relatorio.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fCriaSx1()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ mv_par01 = Serie                                                        ณ
//ณ mv_par02 = Nota Fiscal                                                  ณ
//* mv_par04 = Tipo de impressao (vertical / horizontal)                    *
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","Serie"        ,"Serie"         ,"Serie"         ,"mv_ch1","C",03,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Da Nt.Fiscal" ,"Da Nota Fiscal","Da Nota Fiscal","mv_ch2","C",09,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Ate Nt.Fiscal" ,"Ate Nt.Fiscal","Ate Nt.Fiscal" ,"mv_ch3","C",09,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Qual etiqueta","Qual etiqueta" ,"Qual etiqueta" ,"mv_ch4","N",01,0,0,"C","","","","","mv_par04","Vertical","Vertical","Vertical","","Horizontal","Horizontal","Horizontal","","","","","","","","","",,,)


Return
