/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTA011   ºAutor  ³Microsiga           º Data ³  02/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa de tela de chamada de coleta.                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"

User Function ESTA011()

Private cCadastro := "Coleta "
cPerg 		:= "ESTA11"
_cArqTmp	:= ""
_cIndTmp	:= ""

_fCriaSx1()      

Pergunte(cPerg,.t.)

MsgRun("Aguarde montando tela de chamada de coleta",,{ || _fProcessa() })

aRotina 	:= { {"Chamada","U_Chama011()",0,1} }

_aFields := { 	{"Tipo"					, 	"TIPO"			}	,;
				{"N.Fiscal"				, 	"DOC"			}	,;
				{"Emissao"    			,   "EMISSAO"  		}	,;
				{"R.Social do Cliente"	,	"CLIENTE"		}	,;
				{"Municipio"			,	"MUN"			}	,;
				{"Estado"				,	"EST"			}	,;
				{"Transportadora"		,	"TRANSP"		}	,;
				{"Fone Transp"			,	"TELTRANS"		}	,;				
				{"Volume"				,	"F2_VOLUME1"	}	,;
				{"Especie"       		,   "ESPECIE"		}	,;
				{"Peso Bruto"			,	"F2_PBRUTO"		}	}

mBrowse( 6,1,22,75,"TMP",_aFields)

TMP->(DbCloseArea())
Ferase(_cArqTmp+".DBF")
Ferase(_cIndTmp+OrdBagExt())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fProcessaºAutor  ³Microsiga           º Data ³  02/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento para montar o arquivo temporario do browse   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function _fProcessa()                                             

_cQuery := "SELECT F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_NREDUZ, A1_MUN, A1_EST, A4_COD, A4_NREDUZ, A4_TEL, F2_VOLUME1, "
_cQuery += "       F2_ESPECI1, F2_PBRUTO "
_cQuery += "FROM " + RetSqlName("SF2") + " F2, " + RetSqlName("SA1") + " A1, " + RetSqlName("SA4") + " A4 "
_cQuery += "WHERE F2.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND A4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND F2_FILIAL = '" + xFilial("SF2") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' "
_cQuery += "      AND A4_FILIAL = '" + xFilial("SA4") + "' "
_cQuery += "      AND F2_TRANSP = A4_COD AND F2_CLIENTE = A1_COD AND F2_LOJA = A1_LOJA "
_cQuery += "      AND F2_AXCOLET = ' ' AND F2_TRANSP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "      AND A4_COD NOT IN('000008','000240') AND F2_TIPO = 'N' "
_cQuery += "UNION ALL "
_cQuery += "SELECT F2_DOC, F2_SERIE, F2_EMISSAO, A2_COD, A2_NREDUZ, A2_MUN, A2_EST, A4_COD, A4_NREDUZ, A4_TEL, F2_VOLUME1, "
_cQuery += "       F2_ESPECI1, F2_PBRUTO "
_cQuery += "FROM " + RetSqlName("SF2") + " F2, " + RetSqlName("SA2") + " A2, " + RetSqlName("SA4") + " A4 "
_cQuery += "WHERE F2.D_E_L_E_T_ = ' ' AND A2.D_E_L_E_T_ = ' ' AND A4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND F2_FILIAL = '" + xFilial("SF2") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' "
_cQuery += "      AND A4_FILIAL = '" + xFilial('SA4') + "' "
_cQuery += "      AND F2_TRANSP = A4_COD AND F2_CLIENTE = A2_COD AND F2_LOJA = A2_LOJA "
_cQuery += "      AND F2_AXCOLET = ' ' AND F2_TRANSP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "      AND A4_COD NOT IN('000008','000240') AND F2_TIPO IN ('D','B') "
_cQuery += "ORDER BY A4_COD "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","F2_VOLUME1","N",12,0)
TcSetField("QR1","F2_EMISSAO","D",08,0)
TcSetField("QR1","F2_PBRUTO" ,"N",12,3)

_aCampos := {	{"TIPO"		 ,"C",01,00	}	,;
				{"DOC"		 ,"C",06,00	}	,;
				{"SERIE"	 ,"C",03,00	}	,;
				{"EMISSAO"	 ,"D",08,00	}	,;
				{"CLIENTE"	 ,"C",37,00	}	,;
				{"MUN"		 ,"C",15,00	}	,;
				{"EST"		 ,"C",02,00	}	,;
				{"TRANSP"	 ,"C",27,00	}	,;
				{"TELTRANS"  ,"C",15,00	}	,;
				{"F2_VOLUME1","N",12,00	}	,;
				{"ESPECIE"	 ,"C",20,00	}	,;
				{"F2_PBRUTO" ,"N",12,03	}	}
				
_cArqTmp	:= Criatrab(_aCampos,.t.)
_cIndTmp	:= Criatrab(,.f.)

DbUseArea(.t.,,_cArqTmp,"TMP",.f.)
IndRegua("TMP",_cIndTmp,"TRANSP",,,"Criando Indice")

SD2->(DbSetOrder(3))
SC5->(DbSetOrder(1))

QR1->(DbGoTop())

Do While ! QR1->(Eof())

	SD2->(DbSeek(xFilial("SD2")+QR1->F2_DOC+QR1->F2_SERIE,.T.))
	SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))

	If MV_PAR03 == 1     	// CIF
		If SC5->C5_TPFRETE <> "C"
			QR1->(DbSkip())
			Loop
		EndIf

	ElseIf MV_PAR03 == 2    // FOB
		If SC5->C5_TPFRETE <> "F"
			QR1->(DbSkip())
			Loop
		EndIf
	EndIf
	
	RecLock("TMP",.t.)                        
	TMP->TIPO		:= SC5->C5_TPFRETE
	TMP->DOC 		:= QR1->F2_DOC
	TMP->SERIE		:= QR1->F2_SERIE
	TMP->EMISSAO	:= QR1->F2_EMISSAO
	TMP->CLIENTE	:= QR1->A1_COD + "-" + QR1->A1_NREDUZ
	TMP->MUN		:= QR1->A1_MUN
	TMP->EST		:= QR1->A1_EST
	TMP->TRANSP		:= QR1->A4_COD + "-" + QR1->A4_NREDUZ
	TMP->TELTRANS	:= QR1->A4_TEL
	TMP->F2_VOLUME1	:= QR1->F2_VOLUME1
	TMP->ESPECIE	:= QR1->F2_ESPECI1
	TMP->F2_PBRUTO	:= QR1->F2_PBRUTO
	TMP->(MsUnLock())					

	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fCriaSx1 ºAutor  ³Microsiga           º Data ³  02/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Criacao das perguntas da rotina.                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/      

Static Function _fCriaSx1()

PutSx1(cPerg,"01","Da Transportadora ?" ,"Da Transportadora ?" ,"Da Transportadora ?" ,"mv_ch1","C",06,0,0,"G","SA4","","","","mv_par01",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"02","Ate Transportadora ?","Ate Transportadora ?","Ate Transportadora ?","mv_ch2","C",06,0,0,"G","SA4","","","","mv_par02",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","","","","")
PutSx1(cPerg,"03","Tipo Frete ?"        ,"Tipo Frete ?"        ,"Tipo Frete ?"        ,"mv_ch3","N",01,0,0,"G",""   ,"","","","mv_par03","C-CIF","C-CIF","C-CIF","","F-FOB","F-FOB","F-FOB","T-TODOS","T-TODOS","T-TODOS","","","","","","","","","")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Chama011  ºAutor  ³Microsiga           º Data ³  02/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Chama011()

_aArea := GetArea()

SF2->(DbSetOrder(1))
//	F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA

SF2->(DbSeek(xFilial("SF2")+TMP->DOC+TMP->SERIE,.T.))

If (xFilial("SF2")+TMP->DOC+TMP->SERIE) == (SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE)
	RecLock("SF2",.f.)
	SF2->F2_AXCOLET := "S"
	SF2->(MsUnLock())
	//
	// Deleta arquivo temporario
	//
	RecLock("TMP",.f.)
	delete
	TMP->(MsUnLock())
EndIf

RestArea(_aArea)

Return