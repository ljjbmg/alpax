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

User Function ETINFE()

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

local _ny 
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
		
			//VALIDACAO PARA IMPRIMIR O SERIAL SE TIVER
			DBSELECTAREA("SB1")								//CAD PRODUTO 
			DBSETORDER(1)          							//FILIAL + COD
			IF DBSEEK(xFILIAL("SB1")+TMP->TM_COD)			//SE ACHAR PRODUTO 
				IF SB1->B1_CTRSER = 'S'                  	//SE CONTROLA SERIAL
						
					//QUERY PARA BUSCA DO SERIAL
					cQRY:=" SELECT ZBB_DOC, ZBB_SERIE, ZBB_FORNEC, ZBB_LOJA, ZBB_COD, ZBB_LOCAL, ZBB_LOTE, ZBB_SERIAL "	+CRLF
					cQRY+=" FROM ZBB010 AS ZBB (NOLOCK) "                                                             	+CRLF
					cQRY+=" WHERE ZBB.D_E_L_E_T_ = '' "                                                               	+CRLF
					cQRY+=" 	AND ZBB_FILIAL 	= '"+xFILIAL("ZBB")+"' "                                              	+CRLF
					cQRY+=" 	AND ZBB_DOC 	= '"+ALLTRIM(TMP->TM_DOC)+"' "                                        	+CRLF
					cQRY+=" 	AND ZBB_SERIE 	= '"+ALLTRIM(TMP->TM_SERIE)+"' "                                     	+CRLF
					cQRY+="		AND ZBB_FORNEC 	= '"+ALLTRIM(TMP->TM_FORNECE)+"' "                                   	+CRLF
					cQRY+=" 	AND ZBB_LOJA 	= '"+ALLTRIM(TMP->TM_LOJA)+"' "                                      	+CRLF
					cQRY+=" 	AND ZBB_COD 	= '"+ALLTRIM(TMP->TM_COD)+"' "                                       	+CRLF
					cQRY+=" 	AND ZBB_LOCAL 	= '"+ALLTRIM(TMP->TM_LOCAL)+"' "                                      	+CRLF
					cQRY+=" 	AND ZBB_LOTE 	= '"+ALLTRIM(TMP->TM_LOTECTL)+"' "                                    	+CRLF
					IF SELECT("SER") > 0										//SE ALIAS ABERTO
						DBSELECTAREA("SER")    									//SELECIONA
						SER->(DBCLOSEAREA())   									//FECHA
					ENDIF                     									//FIM
					DBUSEAREA(.T.,"TOPCONN",TcGenqry(,,cQRY),"SER",.F.,.T.)	//
					SER->(DBGOTOP())  									   		//PRIMEIRO REGISTRO
							
					//LENDO TODOS OS SERIAIS GRAVADOS ---------------------------------------------------------------------
					cSERIAL := ""
					WHILE SER->(!EOF())
						IF ALLTRIM(SER->ZBB_SERIAL) == ALLTRIM(TMP->TM_SERIAL)  
							//NAO FAZ NADA E SEGUE PARA O PROXIMO ATE ENCONTRAR DIFERENTE
						ELSE
							RECLOCK("TMP",.F.)
							TMP->TM_SERIAL := SER->ZBB_SERIAL 
							TMP->(MSUNLOCK())
							cSERIAL := SER->ZBB_SERIAL
							_fImpr003(cSERIAL)
						ENDIF 	
						SER->(DBSKIP())                       		//PROXIMO REGISTRO
					ENDDO                                          	//FIM -------------------------------------------------
					        
					IF SELECT("SER") > 0							//SE ALIAS ABERTO
						DBSELECTAREA("SER")    						//SELECIONA
						SER->(DBCLOSEAREA())   						//FECHA
					ENDIF                     						//FIM
				ELSE
					_fImpr003()   // - ETIQUETA ANTERIOR, ALTERADA PELO OCIMAR. 		
				ENDIF
			ELSE
					MSGALERT("PRODUTO: "+QR1->D1_COD+" NรO ENCONTRADO!","ETINFE.PRW LINE:135")
			ENDIF
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

LOCAL cSERIAL := ""		//SERIAL DO PRODUTO

//
// Monta Query das notas fiscais.
//               
_cComplem	:= ""

If MV_PAR02 == 1
	_cComplem	+= " AND D1_AXIMPR <> 'S' "
EndIf

_cQuery := "SELECT D1_TIPO, D1_DOC, D1_SERIE, D1_FORNECE, D1_LOJA, D1_COD, B1_DESC, B1_AXRISCO, D1_LOCAL, "
_cQuery += "       D1_QUANT, D1_LOTECTL, D1_ITEM, D1_DTVALID AS D1VAL, B8_DTVALID AS B8VAL, B1_MARCA, B1_CAPACID, B1_PNUMBER, B1_AXFEDER, B1_AXSUBS, B1_AXEXERC, B1_AXSSP "
_cQuery += "FROM   " + RetSqlName("SD1") + " D1 "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "ON D1_COD = B1_COD "
_cQuery += "LEFT JOIN " + RetSqlName("SB8") + " B8 "
_cQuery += "ON D1_COD = B8_PRODUTO AND D1_LOTECTL = B8_LOTECTL AND B8.D_E_L_E_T_ = ' ' AND B8_LOCAL = 'RC' AND B8_FILIAL = '" + xFilial("SB8") + "' "
_cQuery += "WHERE  D1.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND " 
_cQuery += "       D1_FILIAL = '" + xFilial("SD1") + "' AND B1_FILIAL = '" + xFilial("SB1") + "' AND SUBSTRING(D1_CF,2,3) NOT IN ('933','556','653','353') AND " 
_cQuery += "       D1_DTDIGIT = '" + Dtos(MV_PAR01) + "'  " 
_CqUERY += _cComplem

_cQuery := ChangeQuery(_cQuery)

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","D1_QUANT","N",12,2)
TcSetField("QR1","B8VAL","D",08,0)
TcSetField("QR1","D1VAL","D",08,0)
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
				{ "TM_D1VAL"	,	"D",	08,	00	}	,;				
				{ "TM_B8VAL"	,	"D",	08,	00	}	,;				
				{ "TM_LOTECTL"	,	"C",	10,	00	}	,;
				{ "TM_CAPACID"	,	"C",	15,	00	}	,;
				{ "TM_PNUMBER"	,	"C",	20,	00	}	,;
				{ "TM_AXFEDER"	,	"C",	01,	00	}	,;
				{ "TM_AXSUBS"	,	"C",	01,	00	}	,;
				{ "TM_AXEXERC"	,	"C",	01,	00	}	,;
				{ "TM_AXSSP"	,	"C",	01,	00	}	,;
				{ "TM_AXRISCO"	,	"C",	04,	00	}	,;
				{ "TM_LOCAL"	,	"C",	02,	00	}	,;
				{ "TM_SERIAL"	,	"C",	20,	00	}	}

_cArqTmp	:= Criatrab(_aCampos,.t.)
_cIndTmp	:= Criatrab(,.f.)
IF SELECT("TMP") > 0											//SE ALIAS ESTIVER ABERTO
	DBSELECTAREA("TMP")    										//SELECIONA ALIAS
	TMP->(DBCLOSEAREA()) 										//FECHA ALIAS
ENDIF                        									//FIM
DbUseArea(.t.,,_cArqTmp,"TMP",.f.,.f.)
IndRegua("TMP",_cIndTmp,"TM_TIPO+TM_DOC+TM_SERIE",,,"Selecionando Registros...")

QR1->(DbGoTop())
Do While ! QR1->(Eof())
             
	RECLOCK("TMP",.t.)
	TMP->TM_TIPO	:= QR1->D1_TIPO
	TMP->TM_DOC		:= QR1->D1_DOC
	TMP->TM_SERIE	:= QR1->D1_SERIE
	TMP->TM_FORNECE	:= QR1->D1_FORNECE
	TMP->TM_LOJA	:= QR1->D1_LOJA
	TMP->TM_COD		:= QR1->D1_COD
	TMP->TM_ITEM	:= QR1->D1_ITEM
	TMP->TM_DESC	:= QR1->B1_DESC 
	//VALIDACAO PARA CONTROLE DE SERIAL --------------------------------------------------------------------
	DBSELECTAREA("SB1")								//PRODUTOS
	DBSETORDER(1)                                  	//FILIAL + COD
	IF DBSEEK(xFILIAL("SB1")+ALLTRIM(QR1->D1_COD))	//SE ACHOU PRODUTO
		IF SB1->B1_CTRSER = 'S'						//SE CONTROLA SERIAL
			TMP->TM_QUANT	:= 1					//QUANTIDADE SERA 1 E SERA DESMEBRADO NA TABELA ZZB	
		ELSE                                     	//SE NAO CONTROLA
			TMP->TM_QUANT	:= QR1->D1_QUANT     	//QUANTIDADE NORMAL
		ENDIF                                      	//FIM
	ELSE
		MSGALERT("PRODUTO: "+ALLTRIM(QR1->D1_COD)+" NรO ENCONTRADO!","ETINFE.PRW LINE:279")
	ENDIF											//FIM -------------------------------------------------
	
	TMP->TM_LOTECTL	:= QR1->D1_LOTECTL
	TMP->TM_D1VAL   := QR1->D1VAL        
	TMP->TM_B8VAL	:= QR1->B8VAL
	TMP->TM_MARCA	:= QR1->B1_MARCA                                              
	TMP->TM_CAPACID	:= QR1->B1_CAPACID                  
	TMP->TM_PNUMBER	:= QR1->B1_PNUMBER
	TMP->TM_AXFEDER	:= QR1->B1_AXFEDER
	TMP->TM_AXSUBS	:= QR1->B1_AXSUBS
	TMP->TM_AXEXERC	:= QR1->B1_AXEXERC
	TMP->TM_AXSSP	:= QR1->B1_AXSSP
	TMP->TM_AXRISCO	:= QR1->B1_AXRISCO
	TMP->TM_LOCAL	:= QR1->D1_LOCAL
 	TMP->TM_SERIAL 	:= ""
	TMP->(MSUNLOCK())
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

_aCampos	:= {	{"TM_OK"      	,,""            	,"@!" 					}	,;
					{"TM_DOC"		,,"N.F."			,"@!"					}	,;
					{"TM_SERIE"		,,"Serie"			,"@!"					}	,;
					{"TM_FORNECE"	,,"Forn/Cliente"	,"@!"					}	,;
					{"TM_LOJA"		,,"Loja"			,"@!"					}	,;
					{"TM_PNUMBER"	,,"Part Number"		,""						}	,;
					{"TM_DESC"		,,"Produto"			,"@!"					}	,;
					{"TM_CAPACID"	,,"Capacidade"		,""						}	,;
					{"TM_QUANT"		,,"Qtde."			,"@e 999,999.99"		}	,;
					{"TM_LOTECTL"	,,"Lote"			,"@!"					}	,;
					{"TM_D1VAL  "	,,"Val. Nota"		,"@!"   				}	,;
					{"TM_B8VAL  "	,,"Val. Sist."		,"@!"   				}	,;
					{"TM_AXFEDER"	,,"P.Feder"			,						}	,;
					{"TM_AXSUBS"	,,"Substancia PF"	,						}	,;
					{"TM_AXEXERC"	,,"Exercito"		,						}	,;
					{"TM_AXSSP"		,,"Seg.Public"		,						}	,;
					{"TM_AXRISCO"	,,"Risco"			,						}   ,;
					{"TM_LOCAL"	    ,,"Armazem"	    	,						}	,;
					{"TM_SERIAL"	,,"Num. Serie"		,						}	}

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
Static Function _fImpr003(cSERIAL) 

Private cETQ 	:= ""
Private cFL  	:= CHR(13)+CHR(10)
PRIVATE cLOTE   := ""					//LOTE
PRIVATE cVCTO	:= ""					//VCTO LOTE
PRIVATE cDESC	:= ""					//PNUMBER + DESCRICAO

DEFAULT cSERIAL := REPLICATE("X",6)		//SE NUM SERIE NAO FOI PASSADO RECEBE XXXXXX
IF cSERIAL <> REPLICATE("X",6)			//CLIENTE ENCONTRADO
	cSERIAL := ALLTRIM(cSERIAL)        	//NUMERO DE SERIE	
ELSE                                  	//SE NAO
	cSERIAL := ""						//SERIAL EM BRANCO
ENDIF                               	//FIM
                                 
IF EMPTY(ALLTRIM(TMP->TM_PNUMBER))											//SE PNUMBER VAZIO		
	cDESC := ALLTRIM(TMP->TM_DESC)                                      	//RECEBE SO DESCRICAO
ELSE                                                                      	//SE NAO
	cDESC := ALLTRIM(ALLTRIM(TMP->TM_PNUMBER)+" - "+ALLTRIM(TMP->TM_DESC))	//RECEBE PNUMBER + DESCRICAO	
ENDIF                                                                    	//FIM
                        
IF EMPTY(ALLTRIM(TMP->TM_CAPACID)) .OR.	ALLTRIM(TMP->TM_CAPACID) == "."		//SE CAPACIDADE VAZIO OU PREENCHIDO COM "." 
	//cDESC CONTINUA COMO ESTA                    	
ELSE                                               							//SE NAO	
	cDESC := cDESC+" - "+ALLTRIM(TMP->TM_CAPACID)  							//DESC + CAPACIDADE  	
ENDIF                                            							//FIM

cLOTE 	:= ALLTRIM(TMP->TM_LOTECTL)					//LOTE
cVCTO 	:= ALLTRIM(DTOC( IIF(EMPTY(TMP->TM_B8VAL),TMP->TM_D1VAL,TMP->TM_B8VAL )))    	//VALIDADE DO LOTE

/*
cETQ += "CT~~CD,~CC^~CT~"+cFL
cETQ += "^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR4,4~SD15^JUS^LRN^CI0^XZ"+cFL
cETQ += "^XA"+cFL
cETQ += "^MMT"+cFL
cETQ += "^PW639"+cFL
cETQ += "^LL0240"+cFL
cETQ += "^LS0"+cFL
cETQ += "^BY2,3,30^FT231,157^BCN,,Y,N"+cFL
IF !EMPTY(cLOTE)                                    //SE TIVER LOTE IMPRIMI CODBAR LOTE
	cETQ += "^FD>:"+ALLTRIM(cLOTE)+"^FS"+cFL		//CODBAR LOTE
ELSE       											//SE NAO TIVER LOTE
	cVCTO := ""                                   	//NA IMPRIMI LOTE E APAGA VCTO LOTE
ENDIF                                     	   		//FIM 
cETQ += "^BY2,3,28^FT104,214^BCN,,Y,N"+cFL                
IF !EMPTY(cSERIAL)                                	//SE TIVER SERIAL
	cETQ += "^FD>:"+ALLTRIM(cSERIAL)+"^FS"+cFL    	//SERIAL
ENDIF                                         		//FIM
cETQ += "^BY2,3,31^FT121,95^BCN,,Y,N"+cFL
cETQ += "^FD>:"+ALLTRIM(TMP->TM_COD)+"^FS"+cFL		//CODBAR PRODUTO
cETQ += "^FO1,119^GB636,0,2^FS"+cFL
cETQ += "^FO1,180^GB637,0,3^FS"+cFL
cETQ += "^FT19,144^A0N,23,24^FH\^FDLOTE^FS"+cFL
cETQ += "^FT19,208^A0N,23,24^FH\^FDSERIAL^FS"+cFL
cETQ += "^FT19,172^A0N,23,24^FH\^FDVCTO "+ALLTRIM(cVCTO)+"^FS"+cFL 					//VENCIMENTO LOTE
cETQ += "^FT21,60^A0N,23,24^FH\^FD"+ALLTRIM( SUBSTRING(cDESC,51,49) )+"^FS"+cFL   	//DESC PARTE 2
cETQ += "^FT20,34^A0N,23,24^FH\^FD"+ALLTRIM( SUBSTRING(cDESC,1 ,50) )+"^FS"+cFL    	//DESC PARTE 1
cETQ += "^PQ1,0,1,Y^XZ"+cFL
*/

cETQ += "CT~~CD,~CC^~CT~"+cFL
cETQ += "^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR4,4~SD15^JUS^LRN^CI0^XZ"+cFL
cETQ += "^XA"+cFL
cETQ += "^MMT"+cFL
cETQ += "^PW639"+cFL
cETQ += "^LL0240"+cFL
cETQ += "^LS0"+cFL
cETQ += "^BY2,3,30^FT231,157^BCN,,Y,N"+cFL
IF !EMPTY(cLOTE)                                    //SE TIVER LOTE IMPRIMI CODBAR LOTE
	cETQ += "^FD>:"+ALLTRIM(cLOTE)+"^FS"+cFL		//CODBAR LOTE
ELSE       											//SE NAO TIVER LOTE
	cVCTO := ""                                   	//NA IMPRIMI LOTE E APAGA VCTO LOTE
ENDIF                                     	   		//FIM 
cETQ += "^BY2,3,28^FT104,214^BCN,,Y,N"+cFL                
IF !EMPTY(cSERIAL)                                	//SE TIVER SERIAL
	cETQ += "^FD>:"+ALLTRIM(cSERIAL)+"^FS"+cFL    	//SERIAL
ENDIF                                         		//FIM
cETQ += "^BY2,3,31^FT121,95^BCN,,N,N"+cFL
cETQ += "^FD>:"+ALLTRIM(TMP->TM_COD)+"^FS"+cFL
cETQ += "^FO1,119^GB636,0,2^FS"+cFL
cETQ += "^FO1,180^GB637,0,3^FS"+cFL
cETQ += "^FT268,115^A0N,20,19^FH\^FD"+ALLTRIM(TMP->TM_PNUMBER)+"^FS"+cFL
cETQ += "^FT19,144^A0N,23,24^FH\^FDLOTE^FS"+cFL
cETQ += "^FT19,208^A0N,23,24^FH\^FDSERIAL^FS"+cFL
cETQ += "^FT19,172^A0N,23,24^FH\^FDVCTO "+ALLTRIM(cVCTO)+"^FS"+cFL
cETQ += "^FT21,60^A0N,23,24^FH\^FD"+ALLTRIM( SUBSTRING(cDESC,51,49) )+"^FS"+cFL
cETQ += "^FT20,34^A0N,23,24^FH\^FD"+ALLTRIM( SUBSTRING(cDESC,1 ,50) )+"^FS"+cFL
cETQ += "^PQ1,0,1,Y^XZ"+cFL

MEMOWRIT("C:\ALPAX\ALPZ001.TXT",cETQ)

@0,0 Psay cETQ

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
If TMP->TM_AXSUBS == '1'
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
MSCBSAY(35,23,DTOC(IIF(EMPTY(TMP->TM_B8VAL),TMP->TM_D1VAL,TMP->TM_B8VAL))				,"N","2","01,01",.t.)
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
