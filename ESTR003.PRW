/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTR003   บAutor  ณAdriano Luis Brandaoบ Data ณ  25/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para impressao de etiquetas termicas dos produtos    บฑฑ
ฑฑบ          ณque entraram com nota fiscal de entrada.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

#Include "Protheus.ch"
#Include "Rwmake.ch"
#Include "Topconn.ch"

User Function ESTR003()

Private _cArqTmp	:= ""
Private _cIndTmp	:= ""
Private cPerg      	:= "ESTR03"
Private cPerg2		:= "ESTR3A"

_fCriaSx1()

IF ! Pergunte(cPerg,.T.)
	Return
Endif

//
// Seleciona Registros
//
MsgRun("Aguarde selecionando registros ....",,{ ||_fSelecion() })
//
//	Mark Browse para selecionar os itens de notas fiscais e imprimir os selecionados.
//
_fMarca()

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

TMP->(DbGoTop())

_lPrimeiro	:= .t.

//cPorta := "LPT1"

//MSCBPRINTER("ALLEGRO",cPorta)


SD1->(DbSetOrder(1))
// D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
Do While ! TMP->(Eof())
	If _lPrimeiro
		cPorta := "LPT1"
//		MSCBPRINTER("ALLEGRO",cPorta,,,.f.,,,,,,.t.)
		MSCBPRINTER("ZEBRA",cPorta,,,.f.,,,,,,.t.)
//		MSCBLOADGRF("ALPAX.BMP")
		_lPrimeiro := .f.
	EndIF
	//
	// Imprime o numero de etiquetas para a quantidade do item
	//
	For _nY := 1 To TMP->TM_QUANT                
	
		If TMP->(Marked("TM_OK"))
			alert("Entrou")
			_fImpr003()   // - ETIQUETA ANTERIOR, ALTERADA PELO OCIMAR.
			//_fImpr003A()
		EndIf
	Next _nY
	
	TMP->(DbSkip())
EndDo

If ! _lPrimeiro
	MSCBCLOSEPRINTER()
EndIf

//
// Fecha o objeto browse e deleta o arquivo temporario.
//
_fFecha()

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
//ณ mv_par01 = Nf Digitada em  __/__/____                                   ณ
//ณ mv_par02 = Filtra Emitidas (Sim/Nao)                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","NF Digitadas em:","NF Digitadas em:","NF digitadas em:","mv_ch1","D",08,0,0,"G","","","","","mv_par01",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"02","Filtra Emitidas?","Filtra Emitidas?","Filtra Emitidas?","mv_ch2","N",01,0,0,"C","","","","","mv_par02","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","","","","")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fSelecionบAutor  ณMicrosiga           บ Data ณ  08/25/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fSelecion()

//
// Monta Query das notas fiscais.
//               
_cComplem	:= ""

If MV_PAR02 == 1
	_cComplem	+= " AND D1_AXIMPR <> 'S' "
EndIf

_cQuery := "SELECT D1_TIPO, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, B1_DESC, B1_AXRISCO, D1_LOCAL, "
_cQuery += "       D1_QUANT, D1_LOTECTL, D1_ITEM, D1_DTVALID, B1_MARCA, B1_CAPACID, B1_PNUMBER, B1_AXFEDER, B1_AXEXERC, B1_AXSSP "
_cQuery += "FROM   " + RetSqlName("SD1") + " D1, " + RetSqlName("SB1") + " B1 "
_cQuery += "WHERE  D1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND " 
_cQuery += "       D1_FILIAL = '" + xFilial("SD1") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND" 
_cQuery += "       D1_DTDIGIT = '" + Dtos(MV_PAR01) + "' AND D1_COD = B1_COD " + _cComplem
MEMOWRIT("\query\estr003.sql",_cQuery)
_cQuery := ChangeQuery(_cQuery)

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D1_QUANT","N",12,2)
TcSetField("QR1","D1_DTVALID","D",08,0)
//
// Monta arquivo temporario
//
_aCampos := {	{ "TM_OK"		, 	"C", 	02, 00	}	,;
				{ "TM_TIPO"		, 	"C", 	01, 00	}	,;
				{ "TM_DOC"		,	"C",	09,	00	}	,;
				{ "TM_SERIE"	,	"C",	03,	00	}	,;
				{ "TM_FORNECE"	,	"C",	06,	00	}	,;
				{ "TM_LOJA"		,	"C",	02,	00	}	,;
				{ "TM_COD"		,	"C",	15,	00	}	,;
				{ "TM_ITEM"		,	"C",	04, 00	}	,;
				{ "TM_DESC"		,	"C",	75,	00	}	,;
				{ "TM_QUANT"	,	"N",	12,	00	}	,;
				{ "TM_MARCA"	,	"C",	15,	00	}	,;				
				{ "TM_DTVALID"	,	"D",	08,	00	}	,;				
				{ "TM_LOTECTL"	,	"C",	10,	00	}	,;
				{ "TM_CAPACID"	,	"C",	15,	00	}	,;
				{ "TM_PNUMBER"	,	"C",	20,	00	}	,;
				{ "TM_AXFEDER"	,	"C",	01,	00	}	,;
				{ "TM_AXEXERC"	,	"C",	01,	00	}	,;
				{ "TM_AXSSP"	,	"C",	01,	00	}	,;
				{ "TM_AXRISCO"	,	"C",	04,	00	}	,;
				{ "TM_LOCAL"	,	"C",	02,	00	}	}

_cArqTmp	:= Criatrab(_aCampos,.t.)
_cIndTmp	:= Criatrab(,.f.)
DbUseArea(.t.,,_cArqTmp,"TMP",.f.,.f.)
IndRegua("TMP",_cIndTmp,"TM_TIPO+TM_DOC+TM_SERIE",,,"Selecionando Registros...")

QR1->(DbGoTop())
Do While ! QR1->(Eof())               
	RecLock("TMP",.t.)
	TMP->TM_TIPO	:= QR1->D1_TIPO
	TMP->TM_DOC		:= QR1->D1_DOC
	TMP->TM_SERIE	:= QR1->D1_SERIE
	TMP->TM_FORNECE	:= QR1->D1_FORNECE
	TMP->TM_LOJA	:= QR1->D1_LOJA
	TMP->TM_COD		:= QR1->D1_COD
	TMP->TM_ITEM	:= QR1->D1_ITEM
	TMP->TM_DESC	:= QR1->B1_DESC
	TMP->TM_QUANT	:= QR1->D1_QUANT
	TMP->TM_LOTECTL	:= QR1->D1_LOTECTL        
	TMP->TM_DTVALID	:= QR1->D1_DTVALID
	TMP->TM_MARCA	:= QR1->B1_MARCA                                              
	TMP->TM_CAPACID	:= QR1->B1_CAPACID                  
	TMP->TM_PNUMBER	:= QR1->B1_PNUMBER
	TMP->TM_AXFEDER	:= QR1->B1_AXFEDER
	TMP->TM_AXEXERC	:= QR1->B1_AXEXERC
	TMP->TM_AXSSP	:= QR1->B1_AXSSP
	TMP->TM_AXRISCO	:= QR1->B1_AXRISCO
	TMP->TM_LOCAL	:= QR1->D1_LOCAL
	
	TMP->(MsUnLock())
	QR1->(DbSkip())
EndDo    

QR1->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fMarca   บAutor  ณAdriano Luis Brandaoบ Data ณ  25/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para marcas os itens de notas fiscais que irao ser   บฑฑ
ฑฑบ          ณimpressos.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fMarca()

Private _oMarcados

_aCampos	:= {	{"TM_OK"      	,,""        	,"@!" 					}	,;
					{"TM_DOC"		,,"N.F."			,"@!"					}	,;
					{"TM_SERIE"		,,"Serie"			,"@!"					}	,;
					{"TM_FORNECE"	,,"Forn/Cliente"	,"@!"					}	,;
					{"TM_LOJA"		,,"Loja"			,"@!"					}	,;
					{"TM_PNUMBER"	,,"Part Number"		,""						}	,;
					{"TM_DESC"		,,"Produto"			,"@!"					}	,;
					{"TM_CAPACID"	,,"Capacidade"		,""						}	,;
					{"TM_QUANT"		,,"Qtde."			,"@e 999,999.99"		}	,;
					{"TM_LOTECTL"	,,"Lote"			,"@!"					}	,;
					{"TM_AXFEDER"	,,"P.Feder"			,						}	,;
					{"TM_AXEXERC"	,,"Exercito"		,						}	,;
					{"TM_AXSSP"		,,"Seg.Public"		,						}	,;
					{"TM_AXRISCO"	,,"Risco"			,						}}

lInverte	:= .f.
cMarca		:= GetMark()
_nMarcados	:= 0

TMP->(DbGoTop())

Define MsDialog _oDlg1 Title OemToAnsi("Selecionar Registros") From 9,0 To 37,099 Of oMainWnd
@ 020,002 To 195,390
// Exibe marcados
@ 200,008 Say "Marcados"
@ 200,070 Get _nMarcados Object _oMarcados When .f. Picture "999,999.999" Size 050,12
@ 002,020 Button "Filtrar" Size 35,15	Action _fFiltro()
@ 002,070 Button "Limpar"  Size 35,15 	Action _fLimpa()
@ 002,315 BmpButton Type 2 				Action _fFecha()
@ 002,350 BmpButton Type 6				Action _fImprime()

oMark := MsSelect():New("TMP","TM_OK","",_aCampos,@lInverte,@cMarca,{24,4,193,388})
oMark:bMark := {| | _fAtualiza(@lInverte,@_oMarcados,@_nMarcados) }

Activate MsDialog _oDlg1 Centered


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fFecha   บAutor  ณAdriano Luis Brandaoบ Data ณ  25/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para fechar o objeto do browse e a tabela temporariaบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fFecha()

TMP->(DbCloseArea())
Ferase(_cArqTmp+".DBF")
Ferase(_cIndTmp+OrdBagExt())
_oDlg1:End()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fAtualizaบAutor  ณAdriano Luis Brandaoบ Data ณ  25/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para atualizar o contador de registros.             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fAtualiza(lInverte,_oMarcados,_nMarcados)


// Verifica se o registro foi marcado
If IsMark("TM_OK")
  _nMarcados++
Else
  _nMarcados--
EndIf

// Refresh do objeto 
_oMarcados:Refresh()
oMark:oBrowse:Refresh()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImpr003 บAutor  ณMicrosiga           บ Data ณ  26/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fImpr003() 

_cDesc1	:= Left(TMP->TM_DESC,35)
_cDesc2 := SUBSTR(TMP->TM_DESC,36,25) + " " + TMP->TM_CAPACID
MSCBBEGIN(1,6)
MSCBBOX(04,03,55,21,5)
MSCBLineH(04,09,55,3)
MSCBLineV(25,03,09,3)
MSCBSAY(06,05,TMP->TM_MARCA		,"N","0","30,20")
MSCBSAY(27,05,TMP->TM_PNUMBER	,"N","0","30,20")
MSCBSAY(06,10,_cDesc1			,"N","0","30,20")
MSCBSAY(06,13,_cDesc2			,"N","0","30,20")

MSCBLineH(04,16,55,3)
MSCBSAY(06,17,DTOC(TMP->TM_DTVALID)	,"N","0","30,20")
MSCBSAY(27,17,TMP->TM_LOTECTL		,"N","0","30,20")
MSCBSAYBAR(03,21,TMP->TM_COD		,"N","MB02",05)
MSCBSAY(04,27,TMP->TM_COD			,"N","0","30,20")
MSCBSAY(27,27,"Local:"+TMP->TM_LOCAL,"N","0","30,20")

MSCBEND()
If SD1->(DbSeek(xFilial("SD1")+TMP->TM_DOC+TMP->TM_SERIE+TMP->TM_FORNECE+TMP->TM_LOJA+TMP->TM_COD+TMP->TM_ITEM))
	RecLock("SD1",.f.)
	SD1->D1_AXIMPR	:= "S"
	SD1->(MsUnLock())
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImpr003 บAutor  ณMicrosiga           บ Data ณ  26/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Nova Funcao de impressao                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fImpr003A() 

Local _cDesc	:= Alltrim(TMP->TM_DESC)+ " " +TMP->TM_CAPACID
Local _cDesc1 	:= Left(_cDesc,50)
Local _cDesc2 	:= iif(Len(_cDesc) > 50,Substr(_cDesc,51,40),"")
Local _cContr	:= ""
Local _cRisco	:= Left(TMP->TM_AXRISCO,1)
Local _cImagem	:= ""

If TMP->TM_AXFEDER == 'S'
	_cContr += "PF/"
EndIf
if TMP->TM_AXEXERC == 'S'
	_cContr += "EX/"
EndIf
If TMP->TM_AXSSP == 'S'
	_cContr += "SSP"
EndIf

Do Case
	Case _cRisco == "1"
		_cImagem := "EXPLOSIVO"
	Case _cRisco == "3"
		_cImagem := "INFLAMAVEL"
	Case _cRisco == "5"
		_cImagem := "OXIDANTE"
	Case _cRisco == "6"
		_cImagem := "TOXICO"
	Case _cRisco == "8"
		_cImagem := "CORROSIVO"
EndCase

If ! Empty(_cImagem)
	MSCBLOADGRF(_cImagem + ".BMP")
EndIf
MSCBBEGIN(1,6)   
If ! Empty(_cImagem)
	MSCBGRAFIC(83,18,_cImagem)
EndIf
MSCBSAY(05,27,TMP->TM_PNUMBER					,"N","2","01,01",.t.)
MSCBSAY(35,27,TMP->TM_MARCA						,"N","2","01,01",.t.)
MSCBSAY(60,27,_cContr							,"N","2","01,01",.t.)
MSCBSAY(05,23,TMP->TM_LOTECTL					,"N","2","01,01",.t.)
MSCBSAY(35,23,DTOC(TMP->TM_DTVALID)				,"N","2","01,01",.t.)
MSCBSAY(05,19,_cDesc1							,"N","2","01,01",.t.)
MSCBSAY(05,15,_cDesc2							,"N","2","01,01",.t.)
MSCBSAYBAR(05,04,TMP->TM_COD+TMP->TM_LOTECTL	,"N","MB07",08)
MSCBSAY(05,01,TMP->TM_COD+TMP->TM_LOTECTL		,"N","2","01,01",.t.)
MSCBEND()

If SD1->(DbSeek(xFilial("SD1")+TMP->TM_DOC+TMP->TM_SERIE+TMP->TM_FORNECE+TMP->TM_LOJA+TMP->TM_COD+TMP->TM_ITEM))
	RecLock("SD1",.f.)
	SD1->D1_AXIMPR	:= "S"
	SD1->(MsUnLock())
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fFiltro  บAutor  ณmicrosiga           บ Data ณ  03/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para filtrar o browse corrente.                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fFiltro()

PutSx1(cPerg2,"01","NF Inicial"		,"NF Inicial"		,"NF Inicial"		,"mv_ch1","C",06,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg2,"02","NF Final"		,"NF Final"			,"NF Final"			,"mv_ch2","C",06,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg2,"03","Fornecedor De"	,"Fornecedor De"	,"Fornecedor De"	,"mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg2,"04","Fornecedor Ate"	,"Fornecedor Ate"	,"Fornecedor Ate"	,"mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg2,"05","PartNumber de"	,"PartNumber de"	,"PartNumber de"	,"mv_ch5","C",20,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg2,"06","PartNumber Ate"	,"PartNumber Ate"	,"PartNumber Ate"	,"mv_ch6","C",20,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",,,)


//
// Traz parametros preenchidos com todos
//
If SX1->(DbSeek(cPerg2+"01"))
	If RecLock("SX1",.f.)
	SX1->X1_CNT01 := Space(06)
	MsUnLock()
	EndIf
EndIf
If SX1->(DbSeek(cPerg2+"02"))
	If RecLock("SX1",.f.)
		SX1->X1_CNT01 := Replicate("Z",6)
		MsUnLock()
	EndIf
EndIf

If SX1->(DbSeek(cPerg2+"03"))
	If RecLock("SX1",.f.)
		SX1->X1_CNT01 := Space(06)
		MsUnLock()
	EndIf
EndIf

If SX1->(DbSeek(cPerg2+"04"))
	If RecLock("SX1",.f.)
		SX1->X1_CNT01 := Replicate("Z",6)
		MsUnLock()
	EndIf
EndIf

If SX1->(DbSeek(cPerg2+"05"))
	If RecLock("SX1",.f.)
		SX1->X1_CNT01 := Space(20)
		MsUnLock()
	EndIf
EndIf

If SX1->(DbSeek(cPerg2+"06"))
	If RecLock("SX1",.f.)
		SX1->X1_CNT01 := Replicate("Z",20)
		MsUnLock()
	EndIf
EndIf

_cCondicao := "TM_DOC >= MV_PAR01 .AND. TM_DOC <= MV_PAR02 .AND. TM_FORNECE >= MV_PAR03 .AND. TM_FORNECE <= MV_PAR04 .AND. "
_cCondicao += "TM_PNUMBER >= MV_PAR05 .AND. TM_PNUMBER <= MV_PAR06 "

If Pergunte(cPerg2,.t.)
	IndRegua("TMP",_cIndTmp,"TM_TIPO+TM_DOC+TM_SERIE",,_cCondicao,"Selecionando Registros...")
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fLimpa   บAutor  ณmicrosiga           บ Data ณ  03/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de limpeza do browse.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fLimpa()

IndRegua("TMP",_cIndTmp,"TM_TIPO+TM_DOC+TM_SERIE",,,"Selecionando Registros...")

Return
