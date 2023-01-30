/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR013   บAutor  ณMicrosiga           บ Data ณ  08/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ IMPRESSAO ETIQUETA TERMICA DE IDENTIFICACAO DE EQUIPAMENTO บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"

User Function ESTR013()

cPerg := "REST13"
// Perguntas do relatorio
_fCriaSx1()

If ! Pergunte(cPerg,.t.)
	Return
EndIf

MsgRun("Imprimindo as etiquetas, aguarde ....",,{ || _fImprime() })
ApMsgInfo("Termino da impressao")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprime บAutor  ณMicrosiga           บ Data ณ  08/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao da impressao.                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - alpax.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fImprime()

_lPrimeiro := .t.

_nSerie := MV_PAR01

For _nY := 1 to MV_PAR09
	If _lPrimeiro
		cPorta := "LPT1"
		MSCBPRINTER("ALLEGRO",cPorta,,,.f.,,,,,,.t.)
		_lPrimeiro := .f.
	EndIf

	_cTamanho := "1,1"	
	MSCBBEGIN(1,6)
	_cColIni := 3
	MSCBSAY(_cColIni,14		,"SERIE " 		+ STR(_nSerie,5)	,"N","1",_cTamanho,.t.)
	MSCBSAY(_cColIni+29,14	,"FAB " 		+ MV_PAR02			,"N","1",_cTamanho,.t.)
	MSCBSAY(_cColIni,11		,"MODELO " 		+ MV_PAR03			,"N","1",_cTamanho,.t.)
	MSCBSAY(_cColIni,08		,"EQUIP " 		+ LEFT(MV_PAR04,15)	,"N","1",_cTamanho,.t.)	
	MSCBSAY(_cColIni,05		,"TENS " 		+ MV_PAR05			,"N","1",_cTamanho,.t.)		
	MSCBSAY(_cColIni+31,05	,"AMP " 		+ MV_PAR06			,"N","1",_cTamanho,.t.)			
	MSCBSAY(_cColIni,02		,"HZ " 			+ MV_PAR07			,"N","1",_cTamanho,.t.)			
	MSCBSAY(_cColIni+25,02	,"POT " 		+ MV_PAR08			,"N","1",_cTamanho,.t.)		
	
	/*
	MSCBBOX(_cColIni-1,13,16,17,1)
	MSCBBOX(31,13,39,17,1)
	MSCBBOX(_cColIni-1,10,17,13,1)	
	MSCBBOX(_cColIni-1,07,16,10,1)		
	MSCBBOX(_cColIni-1,04,13,07,1)		
	MSCBBOX(33,04,41,07,1)		
	MSCBBOX(_cColIni-1,01,08,04,1)			
	MSCBBOX(26,01,35,04,1)			
	*/
	MSCBEND()
	_nSerie++
	
Next _nY

If ! _lPrimeiro
	MSCBCLOSEPRINTER()
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณMicrosiga           บ Data ณ  08/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Criacao das perguntas.                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fCriaSx1()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = SERIE         ณ
//ณMV_PAR02 = ANO FABRICACAOณ
//ณMV_PAR03 = MODELO        ณ
//ณMV_PAR04 = EQUIPAMENTO   ณ
//ณMV_PAR05 = TENSAO        ณ
//ณMV_PAR06 = AMPERAGEM     ณ
//ณMV_PAR07 = Hz            ณ
//ณMV_PAR08 = POTENCIA      ณ
//ณMV_PAR09 = NR.COPIAS     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู             

PutSx1(cPerg,"01","Nr. Serie ?"          ,"Nr. Serie ?"          ,"Nr. Serie ?"          ,"mv_ch1","N",05,0,0,"G","","","","","mv_par01",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"02","Ano Fabricacao ?"     ,"Ano Fabricacao ?"     ,"Ano Fabricacao ?"     ,"mv_ch2","C",04,0,0,"G","","","","","mv_par02",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"03","Modelo ?"             ,"Modelo ?"             ,"Modelo ?"             ,"mv_ch3","C",20,0,0,"G","","","","","mv_par03",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"04","Equipamento ?"        ,"Equipamento ?"        ,"Equipamento ?"        ,"mv_ch4","C",20,0,0,"G","","","","","mv_par04",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"05","Tensao ?"             ,"Tensao ?"             ,"Tensao ?"             ,"mv_ch5","C",10,0,0,"G","","","","","mv_par05",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"06","Amperagem ?"          ,"Amperagem ?"          ,"Amperagem ?"          ,"mv_ch6","C",04,0,0,"G","","","","","mv_par06",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"07","Hz ?"                 ,"Hz ?"                 ,"Hz ?"                 ,"mv_ch7","C",10,0,0,"G","","","","","mv_par07",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"08","Potencia ?"           ,"Potencia ?"           ,"Potencia ?"           ,"mv_ch8","C",05,0,0,"G","","","","","mv_par08",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"09","Nr. Copias ?"         ,"Nr. Copias ?"         ,"Nr. Copias ?"         ,"mv_ch9","N",05,0,0,"G","","","","","mv_par09",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")

Return