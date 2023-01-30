/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM006   บAutor  ณAdriano Luis Brandaoบ Data ณ  06/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออ0อออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar fechamento dos orgaos.                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTM006()

Private cCadastro	:= "Impressao de Faturas"
Private aSays		:= {}
Private aButtons	:= {}
Private nOpca 		:= 0
Private oPrint
Private cPerg := "XESTM006"   

// Funcao para criacao das perguntas.
fCriaSx1()                           

// Forca o usuario a preencher as perguntas.
If ! Pergunte(cPerg,.t.)
	Return
EndIf

AADD(aSays,"Este programa ้ utilizado para fazer o fechamento do mes " )
AADD(aSays,"do orgao selecionado nos parametros." )


AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. )}})
AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1
	If ApMsgYesNo("Confirma fechamento do orgใo " + Posicione("SZR",1,xFilial("SZR")+MV_PAR03,"ZR_DESCR")+" ?","Confirmar")
		_fProc()
	EndIf
EndIf                   


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fProc    บAutor  ณAdrino Luis Brandao บ Data ณ  19/07/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento do arquivo texto.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fProc()
                                                 
Local lGera	:= .f.
//
// Gera Registro de produtos
//
MsgRun("Gerando registro dos produtos",,{|| lGera:= _fGeraProd()})

If lGera
	ApMsgAlert("Fechamento concluido !!!","AVISO")
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fGeraProdบAutor  ณAdriano Luis Brandaoบ Data ณ  03/08/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera os registros dos produtos.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fGeraProd()

_cPeriodo := MV_PAR01+MV_PAR02

_cCFO_VEN	:= GetNewPar("MV_AXCFVEN","")
_cCFO_COM	:= GetNewPar("MV_AXCFCOM","")


If Empty(_cCFO_VEN)
	ApmsgStop("Preencher parametro MV_AXCFVEN, esta em branco ou parametro nao foi criado!!!","Rotina Bloqueada")
	Return(.f.)
EndIf

If Empty(_cCFO_COM)
	Apmsgstop("Preencher parametro MV_AXCFCOM, esta em branco ou parametro nao foi criado!!!","Rotina Bloqueada")
	Return(.f.)
EndIf

SZR->(DbSetOrder(1))
If ! SZR->(DbSeek(xFilial("SZR")+MV_PAR03))
	ApMsgStop("Orgใo " + MV_PAR03 + " nao localizado !!!","Rotina cancelada !")
	Return(.f.)
EndIf     


_cCampo := Alltrim(SZR->ZR_B1)

If At("B1_",_cCampo) == 0
	ApMsgStop("Campo de relacionamento ao SB1 incorreto no cadastro de Orgใos (ZR_B1)","Verificar")
	Return(.f.)
EndIf

_cQuery := "SELECT 'S' AS TIPO, " + _cCampo + ", B1_AXCONC, B1_AXDENS, B1_POSIPI, ZS_UM AS UM,  "
_cQuery += "       D2_CF AS CFO, ZS_DESCR, SUM(D2_QUANT * B1_CONV) AS QUANT "
_cQuery += "FROM " + RetSqlName("SD2") + " D2 "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "        ON B1_FILIAL = '" + xFilial("SB1") + "' AND D2_COD = B1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "        ON ZS_FILIAL = '" + xFilial("SZS") + "' AND ZS_ORGAO = '" + MV_PAR03 + "' "
_cQuery += "           AND ZS_CON = " + _cCampo + " "
_cQuery += "INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "        ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D2_TES " 
_cQuery += "WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND LEFT(D2_EMISSAO,6) = '" + _cPeriodo + "' "
_cQuery += "      AND D2_TES NOT IN ('522','519','505') AND D2.D_E_L_E_T_ = ' ' "
_cQuery += "      AND B1_MSBLQL <> '1' AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "      AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY " + _cCampo + ", B1_AXCONC, B1_AXDENS, B1_POSIPI, ZS_UM, D2_CF, ZS_DESCR "


_cQuery += "UNION ALL "

_cQuery += "SELECT 'E' AS TIPO, " + _cCampo + ", B1_AXCONC, B1_AXDENS, B1_POSIPI, ZS_UM AS UM,  "
_cQuery += "       D1_CF AS CFO, ZS_DESCR, SUM(D1_QUANT * B1_CONV) AS QUANT "
_cQuery += "FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "        ON B1_FILIAL = '" + xFilial("SB1") + "' AND D1_COD = B1_COD "
_cQuery += "INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "        ON ZS_FILIAL = '" + xFilial("SZS") + "' AND ZS_ORGAO = '" + MV_PAR03 + "' "
_cQuery += "           AND ZS_CON = " + _cCampo + " "
_cQuery += "INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "        ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D1_TES " 
_cQuery += "WHERE D1_FILIAL = '" + xFilial("SD1") + "' AND LEFT(D1_EMISSAO,6) = '" + _cPeriodo + "' "
_cQuery += "      AND D1.D_E_L_E_T_ = ' ' "
_cQuery += "      AND B1_MSBLQL <> '1' AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "      AND F4_ESTOQUE = 'S' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY " + _cCampo + ", B1_AXCONC, B1_AXDENS, B1_POSIPI, ZS_UM, D1_CF, ZS_DESCR "

MemoWrite("\queries\estm0006.sql",_cQuery)
_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_AXDENS"		,"N",12,2)
TcSetField("QR1","B1_AXCONC"		,"N",12,2)
TcSetField("QR1","QUANT"			,"N",12,3)

_aCampos := { 	{ "TMP_NOME"	,"C",70,0	}	,;	// Nome Produto
{ "TMP_AXCLAS"	,"C",06,0	}	,;	// Classificao produto
{ "TMP_CONC"	,"C",06,0 	}	,;	// Concentracao
{ "TMP_DENS"	,"C",06,0 	}	,;	// Densidade
{ "TMP_QANTER"	,"N",12,3	}	,;	// Quantidade anterior de estoque
{ "TMP_COMPRA"	,"N",12,3	}	,;	// Quantidade de compras
{ "TMP_VENDA"	,"N",12,3	}	,;	// Quantidade de vendas.
{ "TMP_ENTDV"	,"N",12,3	}	,;	// Quantidade de algumas Compras e dev.estoque
{ "TMP_SAIDV"	,"N",12,3	}	,;	// Quantidade de algumas saidas e requis.estoque
{ "TMP_UM"		,"C",06,0	}	,;	// Unidade de medida.
{ "TMP_NCM"		,"C",10,0	}	}	// NCM
//
// Arquivo temporario e o indice.
//
_cArqTmp := Criatrab(_aCampos,.t.)
DbUseArea(.t.,,_cArqTmp,"TMP",.f.,.f.)
_cIndTmp := Criatrab(,.f.)
IndRegua("TMP",_cIndTmp,"TMP_AXCLAS+TMP_CONC+TMP_DENS",,,"Criando Indice temporario")

QR1->(DbGoTop())                   


Do While ! QR1->(Eof())
	_cConc 	:= iif(_cCampo == "B1_AXCTPF",StrTran(Strzero(QR1->B1_AXCONC,6,2),".",","),"")
	_cDens	:= iif(_cCampo == "B1_AXCTPF",StrTran(Strzero(QR1->B1_AXDENS,6,2),".",","),"")
	If ! TMP->(DbSeek(QR1->(&_cCampo)+_cConc+_cDens))
		RecLock("TMP",.t.)
		TMP->TMP_AXCLAS	:= QR1->(&_cCampo)
		TMP->TMP_NOME	:= QR1->ZS_DESCR
		TMP->TMP_CONC	:= _cConc
		TMP->TMP_DENS	:= _cDens
		TMP->TMP_UM		:= QR1->UM
		TMP->TMP_NCM	:= QR1->B1_POSIPI
	Else
		RecLock("TMP",.f.)
	EndIf
	
	Do Case
		//
		// Nota fiscal de venda
		//
		Case QR1->TIPO == "S"
			If Alltrim(QR1->CFO) $ _cCFO_VEN
				TMP->TMP_VENDA 	+= QR1->QUANT
			Else // saidas diversas
				TMP->TMP_SAIDV 	+= QR1->QUANT
			EndIf
			//
			// Nota Fiscal de compra
			//
		Case QR1->TIPO = "E"
			If Alltrim(QR1->CFO) $ _cCFO_COM
				TMP->TMP_COMPRA	+= QR1->QUANT
			Else  // entradas diversas
				TMP->TMP_ENTDV	+= QR1->QUANT
			EndIf
	EndCase
	TMP->(MsUnLock())
	// salta registro
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

TMP->(dbGoTop())
_cAno := MV_PAR01        
_cMes := MV_PAR02                                                    
// BUSCA PROXIMO PERIODO.
_cAnoPer := iif(val(_cMes)==12,Strzero(val(_cAno)+1,4),_cAno)  // PROXIMO ANO
_cMesPer := iif(val(_cMes)==12,"01",strzero(val(_cMes)+1,2))   // PROXIMO MES

_cProxPer := _cAnoPer+_cMesPer


// Limpa o mes corrente se existir registros.
_cUpdate := "UPDATE " + RetSqlName("SZV")
_cUpdate += " SET ZV_COMPRAS = 0, ZV_CONSUMO = 0, ZV_SAIDAS = 0, "
_cUpdate += "     ZV_ENTDV = 0, ZV_SAIDV = 0, ZV_SALFIN = ZV_SLDANT, "
_cUpdate += "     WHERE ZV_FILIAL = '" + xFilial("SZV") + "' "
_cUpdate += "           AND ZV_ANO = '" + _cAno + "' "
_cUpdate += "           AND ZV_MES = '" + _cMes + "' "
_cUpdate += "           AND ZV_ORGAO = '" + MV_PAR03 + "' "
_cUpdate += "           AND D_E_L_E_T_ = ' ' "
TcSqlExec(_cUpdate)


// Deleta os saldos iniciais do proximo mes se existirem para serem recriados
_cDelete := "DELETE " + RetSqlName("SZV") 
_cDelete += "      WHERE ZV_FILIAL = '" + xFilial("SZV") + "' "
_cDelete += "            AND ZV_ANO = '" + _cAnoPer + "' "
_cDelete += "            AND ZV_MES = '" + _cMesPer + "' "
_cDelete += "            AND ZV_ORGAO = '" + MV_PAR03 + "' "
_cDelete += "            AND D_E_L_E_T_ = ' ' "
TcSqlExec(_cDelete)


// Grava os saldos e movimentos do mes corrente.

SZV->(DbSetOrder(1))

Do While ! TMP->(Eof())
	_nSaldoIni := 0                 
	_lLocal := .f.
    // ZV_FILIAL, ZV_ANO, ZV_MES, ZV_ORGAO, ZV_CLAS, ZV_CONC, ZV_DENS, R_E_C_N_O_, D_E_L_E_T_
	If SZV->(DbSeek(xFilial("SZV")+_cAno+_cMes+MV_PAR03+TMP->TMP_AXCLAS+TMP->TMP_CONC))
		_nSaldoIni := SZV->ZV_SLDANT
		_lLocal		:= .t. 
	EndIf

	_nEstAtual	:= (_nSaldoIni + TMP->TMP_COMPRA - TMP->TMP_VENDA + TMP->TMP_ENTDV - TMP->TMP_SAIDV)

	If SZV->(DbSeek(xFilial("SZV")+_cAno+_cMes+MV_PAR03+TMP->TMP_AXCLAS+TMP->TMP_CONC))
		RecLock("SZV",.f.)
	Else
		RecLock("SZV",.t.)
	EndIf
	SZV->ZV_FILIAL	:= xFilial("SZV")
	SZV->ZV_ANO		:= _cAno			// ANO ATUAL (PARAMETRO MV_PAR01)
	SZV->ZV_MES		:= _cMes			// MES ATUAL (PARAMETRO MV_PAR02)
	SZV->ZV_ORGAO	:= MV_PAR03			// ORGAO
	SZV->ZV_CLAS	:= TMP->TMP_AXCLAS	// CLASSIFICACAO
	SZV->ZV_CONC	:= TMP->TMP_CONC	// CONCENTRACAO
	SZV->ZV_DENS	:= TMP->TMP_DENS	// DENSIDADE
	SZV->ZV_COMPRAS := TMP->TMP_COMPRA	// COMPRAS
	SZV->ZV_ENTDV	:= TMP->TMP_ENTDV   // ENTRADAS DIVERSAS
	SZV->ZV_CONSUMO := 0				// USO FUTURO
	SZV->ZV_SAIDAS	:= TMP->TMP_VENDA	// VENDAS
	SZV->ZV_SAIDV	:= TMP->TMP_SAIDV	// SAIDAS DIVERSAS
	SZV->ZV_SALFIN	:= _nEstAtual		// SALDO FINAL
	SZV->ZV_NCM		:= TMP->TMP_NCM		// NUMERO DO NCM (Posicao IPI).                  
	SZV->ZV_DESCRI	:= TMP->TMP_NOME	// Descricao
//	SZV->ZV_UM		:= TMP->TMP_UM		// Unidade de medida.

	SZV->(MsUnLock())
	
	TMP->(DbSkip())
EndDo

TMP->(DbCloseArea())

//
// Geracao de saldos iniciais para o proximo mes
//                                              
_cQuery := "SELECT * "
_cQuery += "FROM " + RetSqlName("SZV") 
_cQuery += "    WHERE ZV_FILIAL = '" + xFilial("SZV") + "' "
_cQuery += "          AND ZV_ANO = '" + _cAno + "' "
_cQuery += "          AND ZV_MES = '" + _cMes + "' "
_cQuery += "          AND ZV_ORGAO = '" + MV_PAR03 + "' "
_cQuery += "          AND D_E_L_E_T_ = ' ' "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

TCSetField("QR1","ZV_SLDANT" ,"N",12,3)
TCSetField("QR1","ZV_COMPRAS","N",12,3)
TCSetField("QR1","ZV_ENTDV"  ,"N",12,3)
TCSetField("QR1","ZV_CONSUMO","N",12,3)
TCSetField("QR1","ZV_SAIDAS" ,"N",12,3)
TCSetField("QR1","ZV_SAIDV"  ,"N",12,3)

// Recalcula os saldos do mes corrente para atualizar os produtos sem movimento - Ocimar 08/10/2013

QR1->(DbGoTop())

Do While ! QR1->(Eof()) 
 
	_nEstAtual := (QR1->ZV_SLDANT + QR1->ZV_COMPRAS + QR1->ZV_ENTDV - QR1->ZV_CONSUMO - QR1->ZV_SAIDAS - QR1->ZV_SAIDV)    

	If SZV->(DbSeek(xFilial("SZV")+_cAno+_cMes+MV_PAR03+QR1->ZV_CLAS+QR1->ZV_CONC))
		RecLock("SZV",.f.)
	Else
		RecLock("SZV",.t.)
	EndIf
	SZV->ZV_FILIAL	:= xFilial("SZV")
	SZV->ZV_ANO		:= _cAno			// ANO ATUAL (PARAMETRO MV_PAR01)
	SZV->ZV_MES		:= _cMes			// MES ATUAL (PARAMETRO MV_PAR02)
	SZV->ZV_ORGAO	:= MV_PAR03			// ORGAO
	SZV->ZV_CLAS	:= QR1->ZV_CLAS	    // CLASSIFICACAO
	SZV->ZV_CONC	:= QR1->ZV_CONC   	// CONCENTRACAO
	SZV->ZV_DENS	:= QR1->ZV_DENS 	// DENSIDADE
	SZV->ZV_COMPRAS := QR1->ZV_COMPRAS	// COMPRAS
	SZV->ZV_ENTDV	:= QR1->ZV_ENTDV    // ENTRADAS DIVERSAS
	SZV->ZV_CONSUMO := 0				// USO FUTURO
	SZV->ZV_SAIDAS	:= QR1->ZV_SAIDAS	// VENDAS
	SZV->ZV_SAIDV	:= QR1->ZV_SAIDV	// SAIDAS DIVERSAS
	SZV->ZV_SALFIN	:= _nEstAtual		// SALDO FINAL
	SZV->ZV_NCM		:= QR1->ZV_NCM		// NUMERO DO NCM (Posicao IPI).                  
	SZV->ZV_DESCRI	:= QR1->ZV_DESCRI 	// Descricao
//	SZV->ZV_UM		:= TMP->TMP_UM		// Unidade de medida.

	SZV->(MsUnLock())
	
	QR1->(DbSkip())
	
EndDo        

// Grava proximo periodo

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	RecLock("SZV",.t.)
	
	SZV->ZV_FILIAL	:= xFilial("SZV")
	SZV->ZV_ANO		:= _cAnoPer			// ANO PROXIMO PERIODO (PARAMETRO MV_PAR01)
	SZV->ZV_MES		:= _cMesPer			// MES PROXIMO PERIODO (PARAMETRO MV_PAR02)
	SZV->ZV_ORGAO	:= MV_PAR03			// ORGAO
	SZV->ZV_CLAS	:= QR1->ZV_CLAS		// CLASSIFICACAO
	SZV->ZV_CONC	:= QR1->ZV_CONC		// CONCENTRACAO
	SZV->ZV_DENS	:= QR1->ZV_DENS		// DENSIDADE                
	SZV->ZV_NCM		:= QR1->ZV_NCM		// NCM
	SZV->ZV_SLDANT  := QR1->ZV_SALFIN	// SALDO INICIAL PROXIMO MES                  
	SZV->ZV_DESCRI	:= QR1->ZV_DESCRI	// Descricao

	SZV->(MsUnLock())
	
	QR1->(DbSkip())
	
EndDo

QR1->(DbCloseArea())

Ferase(_cArqTmp+".DBF")
Ferase(_cIndTmp+OrdBagExt())

Return(.t.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSx1  บAutor  ณAdriano Luis Brandaoบ Data ณ  06/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas da rotina.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSx1()

PutSx1(cPerg,"01","Ano"          ,"Ano"          ,"Ano"          ,"mv_ch1","C",04,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Mes"          ,"Mes"          ,"Mes"          ,"mv_ch2","C",02,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Orgao"        ,"Orgao"        ,"Orgao"        ,"mv_ch3","C",03,0,0,"G","","SZR","","","mv_par03","","","","","","","","","","","","","","","","",,,)

Return
