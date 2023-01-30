/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTA012   บAutor  ณMicrosiga           บ Data ณ  15/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar o chamado de transporte por lote.        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

#Include "TopConn.ch"
#Include "Protheus.ch"

User Function ESTA012()

Private _cArqTmp	:= ""
Private _cIndTmp	:= ""
Private cMarca 	:= GetMark()
Private lInverte	:= .F.
Private _aBrowse    := {}
Private _cTitulo	:= "Geracao das Chamadas de coletas"
Private nOpc		:= 0
Private _cPerg := "AXFT12"
// CRIACAO DE PERGUNTAS
fCriaSx1()
// CHAMADA DAS PERGUNTAS
Pergunte(_cPerg,.t.)

_aBut012 := {{"PMSOPCAO",{||fLegenda()}, "Legenda" ,"Legenda"}}

MsgRun("Aguarde montando tela de chamada de coleta",,{ || _fProcessa() })

TMP->(DbGoTop())

oMainWnd:ReadClientCoors()

DEFINE MSDIALOG oDlg TITLE _cTitulo FROM oMainWnd:nTop,oMainWnd:nLeft to oMainWnd:nBottom-40,oMainWnd:nRight-10 Of oMainWnd Pixel
oMark:= MsSelect():New("TMP","OK","!ESPECIE",_aBrowse,@lInverte,@cMarca,{20,1,(oDlg:nHeight-30)/2,(oDlg:nClientWidth-4)/2})
//oMark := MsSelect():New(cAlias,"E1_OK","!E1_SALDO",aCampos,@lInverte,@cMarca,{35,1,143,315})
oMark:oBrowse:lhasMark := .t.
oMark:oBrowse:lCanAllmark := .t.
oMark:oBrowse:bAllMark := {|| fInverte(cMarca,@oMark)}

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||nOpc:=_fConfirme(),oDlg:End()}, {||oDlg:End()},,_aBut012)	//CENTERED   // retorna 1 ou 0

IF nOpc == 1
	Processa( { || _fGerColet() })
ENDIF

TMP->(DbCloseArea())

Ferase(_cArqTmp+".DBF")
Ferase(_cIndTmp+OrdBagExt())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fConfirmeบAutor  ณMicrosiga           บ Data ณ  15/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณConfirmacao de execucao de rotina.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fConfirme()

Local _nRet := 1

If ! ApMsgYesNo("Confirma a geracao da chamada de coleta")
	_nRet := 0
EndIf

Return(_nRet)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGerColetบAutor  ณMicrosiga           บ Data ณ  15/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento de todos os registros selecionados           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fGerColeta()

Private _cChamada := ""

ProcRegua(TMP->(Lastrec()))

TMP->(DbGoTop())

Begin Transaction

Do While ! TMP->(Eof())
	
	_cTipo 	:= TMP->TIPO
	_cCodTr	:= TMP->CODTRANS
	_lPrimeiro := .t.
	Do While ! TMP->(Eof()) .And. (_cTipo == TMP->TIPO .And. _cCodTr == TMP->CODTRANS)
		IncProc("Gerando chamada " + _cChamada)	
		If TMP->OK <> cMarca
			TMP->(DbSkip())
			Loop
		EndIf        
		
		If _lPrimeiro
			_cChamada := GetSxeNum("SZJ","ZJ_CHAMADA")		
			_lPrimeiro := .f.
			ConfirmSx8()
		EndIf                
		// Grava item de chamada.
		_fGrvCham(_cChamada)
		
		TMP->(DbSkip())
	EndDo
	
EndDo

End Transaction

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fProcessaบAutor  ณMicrosiga           บ Data ณ  15/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para a criacao do arquivo temporario.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fProcessa()
       
Local _cSituacao := ""
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Transportadora de                          ณ
//ณMV_PAR02 = Transportadora ate                         ณ
//ณMV_PAR03 = Estado                                     ณ
//ณMV_PAR04 = Situacao : 1-Embalado/2-em processo/3-todosณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Do Case               
	Case MV_PAR04 == 1
		_cSituacao := " AND F2_ESPECI1 <> ' ' "
	Case MV_PAR04 == 2
		_cSituacao := " AND F2_ESPECI1 = ' ' "
EndCase


_cQuery := "SELECT F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_NREDUZ, A1_MUN, A1_EST, A4_COD, A4_NREDUZ, A4_TEL, F2_VOLUME1, "
_cQuery += "       F2_ESPECI1, F2_PBRUTO, F2_VALBRUT "
_cQuery += "FROM " + RetSqlName("SF2") + " F2, " + RetSqlName("SA1") + " A1, " + RetSqlName("SA4") + " A4 "
_cQuery += "WHERE F2.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND A4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND F2_FILIAL = '" + xFilial("SF2") + "' AND A1_FILIAL = '" + xFilial("SA1") + "' "
_cQuery += "      AND A4_FILIAL = '" + xFilial("SA4") + "' "
_cQuery += "      AND F2_TRANSP = A4_COD AND F2_CLIENTE = A1_COD AND F2_LOJA = A1_LOJA "
_cQuery += "      AND F2_AXCOLET = ' ' AND F2_TRANSP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += iif(! MV_PAR03 $ "**/* / *","AND A1_EST = '" + MV_PAR03 + "' ","")  
_cQuery += _cSituacao 
_cQuery += "      AND F2_TIPO = 'N' AND F2_SERIE = '1' AND F2_EMISSAO BETWEEN '" + DtoS(MV_PAR05) + "' AND '" + DtoS(MV_PAR06) + "' "
_cQuery += "UNION ALL "
_cQuery += "SELECT F2_DOC, F2_SERIE, F2_EMISSAO, A2_COD, A2_NREDUZ, A2_MUN, A2_EST, A4_COD, A4_NREDUZ, A4_TEL, F2_VOLUME1, "
_cQuery += "       F2_ESPECI1, F2_PBRUTO, F2_VALBRUT "
_cQuery += "FROM " + RetSqlName("SF2") + " F2, " + RetSqlName("SA2") + " A2, " + RetSqlName("SA4") + " A4 "
_cQuery += "WHERE F2.D_E_L_E_T_ = ' ' AND A2.D_E_L_E_T_ = ' ' AND A4.D_E_L_E_T_ = ' ' "
_cQuery += "      AND F2_FILIAL = '" + xFilial("SF2") + "' AND A2_FILIAL = '" + xFilial("SA2") + "' "
_cQuery += "      AND A4_FILIAL = '" + xFilial('SA4') + "' "
_cQuery += "      AND F2_TRANSP = A4_COD AND F2_CLIENTE = A2_COD AND F2_LOJA = A2_LOJA "
_cQuery += "      AND F2_AXCOLET = ' ' AND F2_TRANSP BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery +=  iif(! MV_PAR03 $ "**/* / *","AND A2_EST = '" + MV_PAR03 + "' ","")
_cQuery += _cSituacao 
_cQuery += "      AND F2_TIPO IN ('D','B') AND F2_SERIE = '1' AND F2_EMISSAO BETWEEN '" + DtoS(MV_PAR05) + "' AND '" + DtoS(MV_PAR06) + "' ""
_cQuery += "ORDER BY A4_COD, F2_DOC "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","F2_VOLUME1","N",12,0)
TcSetField("QR1","F2_EMISSAO","D",08,0)
TcSetField("QR1","F2_PBRUTO" ,"N",12,3)
TcSetField("QR1","F2_VALBRUT","N",12,2)

_aCampos	:= {	{"OK"		 ,"C",02,00	}	,;
{"TIPO"		 ,"C",01,00	}	,;
{"DOC"		 ,"C",09,00	}	,;
{"SERIE"	 ,"C",03,00	}	,;
{"EMISSAO"	 ,"D",08,00	}	,;
{"CLIENTE"	 ,"C",37,00	}	,;
{"MUN"		 ,"C",15,00	}	,;
{"EST"		 ,"C",02,00	}	,;
{"CODTRANS"  ,"C",06,00 }	,;
{"TRANSP"	 ,"C",20,00	}	,;
{"TELTRANS"  ,"C",15,00	}	,;
{"F2_VOLUME1","N",12,00	}	,;
{"ESPECIE"	 ,"C",20,00	}	,;
{"F2_PBRUTO" ,"N",12,03	}	,;
{"F2_VALBRUT","N",12,02	}	}

_aBrowse	:= {	{"OK"			,"", "OK"									},;
{"TIPO"			,"", "Tipo" 								},;
{"DOC"			,"", "Nota Fiscal"							},;
{"SERIE"		,"", "Serie"     							},;
{"EMISSAO"		,"","Emissao"								},;
{"CLIENTE"		,"","Cliente"								},;
{"MUN"			,"","Municipio"								},;
{"EST"			,"","Estado"								},;
{"CODTRANS"		,"","Cod.Transp"							},;
{"TRANSP"		,"","Transportadora"						},;
{"TELTRANS"		,"","Telefone"								},;
{"F2_VOLUME1"	,"","Volume"		,"@e 999,999,999,999"	},;
{"ESPECIE"		,"","Especie"								},;
{"F2_PBRUTO"	,"","Peso Bruto"	,"@e 99,999,999.999"	},;
{"F2_VALBRUT"	,"","Valor Bruto"	,"@e 99,999,999.99"		} }

_cArqTmp	:= Criatrab(_aCampos,.t.)
_cIndTmp	:= Criatrab(,.f.)

DbUseArea(.t.,,_cArqTmp,"TMP",.f.)
IndRegua("TMP",_cIndTmp,"TRANSP+TIPO",,,"Criando Indice")

SD2->(DbSetOrder(3))
SC5->(DbSetOrder(1))

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	
	SD2->(DbSeek(xFilial("SD2")+QR1->F2_DOC+QR1->F2_SERIE,.T.))
	SC5->(DbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
	
	RecLock("TMP",.t.)
	TMP->TIPO		:= SC5->C5_TPFRETE
	TMP->DOC 		:= QR1->F2_DOC
	TMP->SERIE		:= QR1->F2_SERIE
	TMP->EMISSAO	:= QR1->F2_EMISSAO
	TMP->CLIENTE	:= QR1->A1_COD + "-" + QR1->A1_NREDUZ
	TMP->MUN		:= QR1->A1_MUN
	TMP->EST		:= QR1->A1_EST
	TMP->CODTRANS	:= QR1->A4_COD
	TMP->TRANSP     := QR1->A4_NREDUZ
	TMP->TELTRANS	:= QR1->A4_TEL
	TMP->F2_VOLUME1	:= QR1->F2_VOLUME1
	TMP->ESPECIE	:= QR1->F2_ESPECI1
	TMP->F2_PBRUTO	:= QR1->F2_PBRUTO
	TMP->F2_VALBRUT	:= QR1->F2_VALBRUT
	TMP->(MsUnLock())
	
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGrvCham บAutor  ณMicrosiga           บ Data ณ  22/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gravacao item chamada.                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fGrvCham(_cChamada)

RecLock("SZJ",.t.)
SZJ->ZJ_FILIAL	:= xFilial("SZJ")
SZJ->ZJ_TRANSP	:= TMP->CODTRANS
SZJ->ZJ_TIPOFR	:= TMP->TIPO
SZJ->ZJ_CHAMADA	:= _cChamada
SZJ->ZJ_COLETA	:= ""
SZJ->ZJ_VALOR	:= TMP->F2_VALBRUT
SZJ->ZJ_NOTA	:= TMP->DOC
SZJ->ZJ_EMISSAO	:= TMP->EMISSAO
SZJ->ZJ_RAZAO	:= Substr(TMP->CLIENTE,8,Len(TMP->CLIENTE)-7)
SZJ->ZJ_MUN		:= TMP->MUN
SZJ->ZJ_ESTADO	:= TMP->EST
SZJ->ZJ_VOLUME	:= TMP->F2_VOLUME1
SZJ->ZJ_ESPECIE	:= TMP->ESPECIE
SZJ->ZJ_PESOB	:= TMP->F2_PBRUTO
SZJ->ZJ_SERIE	:= TMP->SERIE
SZJ->ZJ_FONETR	:= TMP->TELTRANS
SZJ->(MsUnLock())

SF2->(DbSeek(xFilial("SF2")+TMP->DOC+TMP->SERIE,.T.))

If (SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE) == (xFilial("SF2")+TMP->DOC+TMP->SERIE)
	RecLock("SF2",.f.)
	SF2->F2_AXCOLET := _cChamada
	SF2->(MsUnLock())
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfInverte  บAutor  ณMicrosiga           บ Data ณ  22/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para inverter a marcacao.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fInverte(cMarca,oMark)

Local _nRecno := TMP->(Recno())

TMP->(DbGoTop())

Do While ! TMP->(Eof())
	RecLock("TMP",.f.)
	If TMP->OK == cMarca
		TMP->OK := "  "
	Else
		TMP->OK := cMarca
	EndIf
	TMP->(MsUnLock())
	TMP->(DbSkip())
EndDo              

TMP->(DbGoTo(_nRecno))
oMark:oBrowse:Refresh(.t.)


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfLegenda  บAutor  ณMicrosiga           บ Data ณ  12/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Legenda programa.                                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fLegenda()
Local aCores
Local cCadastro

cCadastro := "Legenda de geracao de chamada"
aCores    := {	{ 'BR_VERDE'	, "Embalado" 		}	,;
				{ 'BR_VERMELHO'	, "Em Processo"		}	}

BrwLegenda(cCadastro,"Legenda do Browse",aCores)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSx1  บAutor  ณMicrosiga           บ Data ณ  12/08/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSx1()

Local aPerg01	:= {}
Local aPerg02 	:= {}
Local aPerg03	:= {}	
Local aPerg04	:= {}
Local aPerg05	:= {}
Local aPerg06	:= {}
Local aHelpEng	:= {}
/*
SX1->(dbSetOrder(1))
If SX1->(DbSeek(_cPerg+"01"))
	Return
EndIf
*/
Aadd( aPerg01, "Informe o codigo da transportadora " 	)
Aadd( aPerg01, "Inicial " 								)

Aadd( aPerg02, "Informe o codigo da transportadora " 	)
Aadd( aPerg02, "final " 								)

Aadd( aPerg03, "Informe o Estado ou ** para todos " 	)

Aadd( aPerg04, "Informe a Situacao: " 					)
Aadd( aPerg04, "- Embalado " 							)
Aadd( aPerg04, "- Em Processo "							)
Aadd( aPerg04, "- Todos"								)


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Transportadora de                          ณ
//ณMV_PAR02 = Transportadora ate                         ณ
//ณMV_PAR03 = Estado                                     ณ
//ณMV_PAR04 = Situacao : 1-Embalado/2-em processo/3-todosณ
//*MV_PAR05 = Data de emissao inicial                    *
//*MV_PAR06 = Data de emissao final                      *
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(_cPerg,"01","Transportadora de" ,"Transportadora de" ,"Transportadora de" ,"mv_ch1","C",06,0,0,"G","","SA4","","","mv_par01","","","","","","","","","","","","","","","","",aPerg01,aPerg01,aPerg01)        			
PutSx1(_cPerg,"02","Transportadora ate","Transportadora ate","Transportadora ate","mv_ch2","C",06,0,0,"G","","SA4","","","mv_par02","","","","","","","","","","","","","","","","",aPerg02,aPerg02,aPerg02)        			
PutSx1(_cPerg,"03","Estado"            ,"Estado"            ,"Estado"            ,"mv_ch3","C",02,0,0,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",aPerg03,aPerg03,aPerg03)        			
PutSx1(_cPerg,"04","Situacao"          ,"Situacao"          ,"Situacao"          ,"mv_ch4","N",01,0,0,"C","",""   ,"","","mv_par04","Embalado","Embalado","Embalado","","Em Processo","Em Processo","Em Processo","Todos","Todos","Todos","","","","","","",aPerg04,aPerg04,aPerg04)        			
PutSx1(_cPerg,"05","Data de"           ,"Data de"           ,"Data de"           ,"mv_ch5","D",08,0,0,"C","",""   ,"","","mv_par05","","","","","","","","","","","","","","","","",aPerg05,aPerg05,aPerg05)        			
PutSx1(_cPerg,"06","Data ate"          ,"Data ate"          ,"Data ate"          ,"mv_ch6","D",08,0,0,"C","",""   ,"","","mv_par06","","","","","","","","","","","","","","","","",aPerg06,aPerg06,aPerg06)

Return