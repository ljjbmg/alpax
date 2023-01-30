/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTV004   บAutor  ณAdriano Luis Brandaoบ Data ณ  19/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validacao nos orgaos, por cliente, transportado-บฑฑ
ฑฑบ          ณra.                                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTV004(_cCad,_cCod,_aItens,_lSemQtd)
// _cCad = C=Cliente, T=Transportadora, F=Fornecedor.
// _cCod = Codigo e Loja do cadastro
// _aItens = Produto a serem checados.
//     [X,1] produto
//     [X,2] Quantidade
// _lSemQtd = Checa apenas se a licenca existe, quantidade nao eh checada (opcional).

Local _aArea 	:= GetArea()
Local _aAreaB1	:= SB1->(GetArea())
Local _aAreaZR 	:= SZR->(GetArea())
Local _aAreaA1	:= SA1->(GetArea())
Local _aAreaA2	:= SA2->(GetArea())
Local _aAreaA4	:= SA4->(GetArea())
Local _lAll := .f.
Local _aRet := {}
Local _aItPF:= {}
Local _aItEX:= {}
Local _aItSP:= {}
Local _lRet	:= .t.
Local _nY	:= 0

Private cEol		:= CHR(13)+CHR(10)
Private _cMenLog 	:= ""
Private _lChkLic	:= .t.

// utilizado somente para checar a licenca e nao as quantidades.
If _lSemQtd <> Nil
	_lChkLic := .f.
EndIf

_cMenLog += cEol

If _cCad == "C"
	SA1->(Dbseek(xFilial("SA1")+_cCod))
	
	fAtuLog("CHECAGEM DE LICENCAS NO CLIENTE " + SA1->A1_NOME)
ElseIf _cCad == "T"
	SA4->(Dbseek(xFilial("SA4")+_cCod))
	fAtuLog("CHECAGEM DE LICENCAS NA TRANSPORTADORA " + SA4->A4_NOME)
	
ElseIf _cCad == "F"
	SA2->(DbSeek(xFilial("SA2")+_cCod))
	fAtuLog("CHECAGEM DE LICENCAS NO FORNECEDOR " + SA2->A2_NOME)
EndIf
_cMenLog += cEol
_cMenLog += cEol


SB1->(DbSetOrder(1))

aItOrg := {}

//
// Checa todos os produtos em quais orgaos deverao ser consultadas as licencas
//
SZR->(DbSetOrder(1))
SZR->(DbGoTop())
//
Do While ! SZR->(Eof())
	If SZR->ZR_TIPO == "B"
		cCampo := Alltrim(SZR->ZR_B1)
		For _nY := 1 To Len(_aItens)
			If SB1->(DbSeek(xFilial("SB1")+_aItens[_nY,1]))
				If !Empty(SB1->(&cCampo))
					If SB1->B1_CONV <> 0
						_nQtdTmp := _aItens[_nY,2] * SB1->B1_CONV
					Else
						_nQtdTmp := _aItens[_nY,2]
					EndIf
					aAdd(aItOrg,{SZR->ZR_CODIGO,SB1->(&cCampo),SB1->B1_COD,_nQtdTmp})
					// aItOrg[x,1] = codigo do orgao
					// aItOrg[x,2] = codigo do produto no orgao
					// aItOrg[x,3] = codigo do produto
					// aItOrg[x,4] = Quantidade do produto
				ElseIf SB1->B1_AXSUBS == "1"

							DbSelectArea("ZA9")
							ZA9->(DbGoTop())
											
							If SZR->ZR_CODIGO == '002'
								cCampo := Alltrim(ZA9->ZA9_AXCTPF)


								If SB1->B1_CONV <> 0
									_nQtdTmp := _aItens[_nY,2] * SB1->B1_CONV
								Else
									_nQtdTmp := _aItens[_nY,2]
								EndIf

								Do While !ZA9->(Eof()) .Or. SB1->B1_COD = ZA9->ZA9_COD 

										aAdd(aItOrg,{SZR->ZR_CODIGO,cCampo, ZA9->ZA9_COD ,_nQtdTmp})

									ZA9->(DbSkip())
								EndDo
							EndIf
				EndIf
			EndIf
		Next _nY
	EndIf
	SZR->(DbSkip())
EndDo

// Separa em matriz por orgao e verifica licenca por orgao
If ! Empty(aItOrg)
	// Ordena por codigo do orgao + codigo do produto no orgao
	aSort(aItOrg,,,{|x,y| x[1]+x[2] < y[1]+y[2] })
	
	// Separa os itens por orgao e consulta.
	_cOrg 	:= aItOrg[1,1]
	aItCon	:= {}
	For _nY := 1 To Len(aItOrg)
		If _cOrg == aItOrg[_nY,1]
			aAdd(aItCon,{aItOrg[_nY,2],aItOrg[_nY,3],aItOrg[_nY,4]})
			// aItCon[x,1] = codigo do produto no orgao
			// aItCon[x,2] = codigo do produto
			// aItCon[x,3] = Quantidade do produto
		Else
			// Funcao de verificacao dos produtos no Orgao
			If ! fVerLic(_cOrg, aItCon,_cCad,_cCod)
				_lRet := .f.
			EndIf
			
			aItCon := {}
			_cOrg := aItOrg[_nY,1]
			aAdd(aItCon,{aItOrg[_nY,2],aItOrg[_nY,3],aItOrg[_nY,4]})
		EndIf
	Next _nY
	If Len(aItCon) > 0
		// Funcao de verificacao dos produtos no Orgao
		If ! fVerLic(_cOrg, aItCon,_cCad,_cCod)
			_lRet := .f.
		EndIf
		
	EndIf
EndIf

// Retorno se foi bloqueado, e Mensagem de log dos bloqueios.
_aRet := {_lRet,_cMenLog }

RestArea(_aAreaZR)
RestArea(_aAreaB1)
RestArea(_aAreaA1)
RestArea(_aAreaA2)
RestArea(_aAreaA4)
RestArea(_aArea)

Return(_aRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfVerLic   บAutor  ณAdriano Luis Brandaoบ Data ณ  25/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para verificacao das licencas por produto.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fVerLic(_cOrg, aItCon,_cCad,_cCod)
// _cOrg == Codigo do orgao
// aItCon == Itens a verificar
//           aItCon[x,1] = codigo do produto no orgao
//           aItCon[x,2] = codigo do produto
//           aItCon[x,3] = Quantidade do produto
// _cCad = C = Cliente, T=Transportadora, F=Fornecedor
// _cCod = Codigo + Loja

Local _cProd
Local _lRet 	:= .t.
Local _nQuant   := 0
Local _nZ		:= 0 

// Posiciona a tabela de Cadastro de Orgaos.
SZR->(DbSeek(xFilial("SZR")+_cOrg))


fAtulog("VERIFICACAO DAS LICENCAS NO ORGAO " + SZR->ZR_DESCR)


If ! empty(aItCon)
	_cProd 	:= aItCon[1,1]
	_nQuant	:= 0
	aProd	:= {}
	For _nZ := 1 To Len(aItCon)
		If _cProd == aItCon[_nZ,1]
			_nQuant += aItCon[_nZ,3]
			aAdd(aProd,aItCon[_nZ,2])
		Else
			// Verifica as licencas por Codigo do produto Orgao
			If ! fCheck(_cProd,aProd,_nQuant,_cCad,_cCod)
				_lRet := .f.
			EndIf
			_cProd		:= aItCon[_nZ,1]
			_nQuant 	:= aItCon[_nZ,3]
			aProd		:= {aItCon[_nZ,2]}
		EndIf
	Next _nZ
	If _nQuant > 0
		// Verifica as licencas por Codigo do Produto Orgao
		If ! fCheck(_cProd,aProd,_nQuant,_cCad,_cCod)
			_lRet := .f.
		EndIf
	EndIf
EndIf

fAtulog(Replicate("-",100))

Return(_lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCheck    บAutor  ณAdriano Luis Brandaoบ Data ณ  26/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de checagem por produto.                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCheck(_cProd,aProd,_nQuant,_cCad,_cCod,_cCodCli)
// _cProd   = Codigo Produto no Orgao
// aProd    = Matriz com os produtos do sistema que compoem o _cProd
// _nQuant  = Quantidade somada do mesmo codigo do produto no Orgao.
// _cCad    = C=Cliente, T=Transportadora, F=Fornecedor.
// _cCod    = Codigo e Loja do cadastro
// _cCodCli = Codigo do cliente para verificacao de "RETIRA"


// Busca a Licenca

Local _lRet 	:= .t.
Local _nQtdMes	:= 0
Local _nQtdLic	:= 0
Local _nX		:= 0

SZS->(DbSetOrder(1))

_cQuery := "SELECT ZU_QTDMAX "
_cQuery += "       FROM " + RetSqlName("SZU")+ " ZU "
_cQuery += "       WHERE ZU_FILIAL = '" + xFilial("SZU") + "' AND ZU_ORGAO = '" + SZR->ZR_CODIGO + "' "

If _cCad == "C"
	_cQuery += "         AND ZU_CLIENTE = '" + LEFT(_cCod,Len(SA1->A1_COD)) + "' "
	_cQuery += "         AND ZU_LOJA = '" + RIGHT(_cCod,Len(SA1->A1_LOJA)) + "' "
ElseIf _cCad == "F"
	_cQuery += "         AND ZU_FORNEC  = '" + LEFT(_cCod,Len(SA2->A2_COD)) + "' "
	_cQuery += "         AND ZU_LOJAFOR = '" + RIGHT(_cCod,Len(SA2->A2_LOJA)) + "' "
ElseIf _cCad == "T" .And. _cCod == "      "
	_cQuery += "         AND ZU_TRANSP = '" + _cCod + "' AND ZU_CLIENTE = '" + SC5->C5_CLIENTE + "' "
ElseIf _cCad == "T" .And. _cCod <> "      "
	_cQuery += "         AND ZU_TRANSP = '" + _cCod + "' "
EndIf
_cQuery += "             AND ZU_CLASS = '" + _cProd + "' "
_cQuery += "             AND '" + DTOS(dDataBase) + "' BETWEEN ZU_DTINI	 AND ZU_DTFIM "
_cQuery += "             AND ZU_TPLIC = 'N' "
_cQuery += "             AND ZU.D_E_L_E_T_ = ' ' "
MemoWrite("\queries\estv004_prod.sql",_cQuery)
TcQuery _cQuery New Alias "QRZU"

TcSetField("QRZU","ZU_QTDMAX","N",12,3)

If _cCod = "      " .And. SZR->ZR_CODIGO == "001"
	_nQtdLic := 0
Else
	_nQtdLic := QRZU->ZU_QTDMAX
EndIf

QRZU->(DbCloseArea())

// Se nao existe licenca para Transportador ou fornecedores.
//If (_nQtdLic == 0 .And. _cCad <> "C") .or. (_nQtdLic == 0 .And. ! _lChklic)
If (_nQtdLic == 0 .And. _cCad <> "C" .and. _lChkLic) // .or. (_nQtdLic == 0 .And. ! _lChklic)
	
	// Para o caso de geracao nota fiscal, se tiver licenca vencida, libera com quantidade minima.
//	If ! _lChklic
	If _lChklic
		If SZS->(DbSeek(xFilial("SZS")+SZR->ZR_CODIGO+_cProd))
			If _nQuant > SZS->ZS_QTDMIN
				_lRet := .f.
			EndIf
		Else
			_lRet := .f.
		EndIf
	EndIf
	If ! _lRet
		For _nX := 1 To Len(aProd)
			SB1->(DbSeek(xFilial("SB1")+aProd[_nX]))
			fAtulog("Produto: " + Alltrim(SB1->B1_PNUMBER) + " - " + Alltrim(SB1->B1_DESC) + ", nao existe licenca.")
		Next _nX
	EndIf
EndIf

// Se existe licenca, checa agora a quantidade necessaria se for cliente.
If _lRet .And. _cCad == "C" .And. _lChkLic // Somente para clientes.
	
	// Verifica as quantidades liberadas e faturadas do mes.
	_cQuery := "SELECT SUM(C9_QTDLIB*B1_CONV) AS QUANT "
	_cQuery += "FROM " + RetSqlName("SC9") + " C9 "
	_cQuery += "    INNER JOIN " + RetSqlName("SF2") + " F2 "
	_cQuery += "            ON F2_FILIAL = '" + xFilial("SF2")+ "' AND C9_NFISCAL = F2_DOC AND C9_SERIENF = F2_SERIE "
	_cQuery += "    INNER JOIN " + RetSqlName("SB1") + " B1 "
	_cQuery += "            ON B1_FILIAL = '" + xFilial("SB1") + "' AND C9_PRODUTO = B1_COD "
	_cQuery += "    INNER JOIN " + RetSqlName("SD2") + " D2 "
	_cQuery += "            ON F2_FILIAL = '" + xFilial("SD2")+ "' AND F2_DOC = D2_DOC AND F2_SERIE = D2_SERIE AND D2_COD = B1_COD "
	_cQuery += "    INNER JOIN " + RetSqlName("SF4") + " F4 "
	_cQuery += "            ON B1_FILIAL = '" + xFilial("SF4") + "' AND D2_TES = F4_CODIGO "
	_cQuery += "WHERE C9_FILIAL = '" + xFilial("SC9") + "'
	_cQuery += "      AND C9_CLIENTE = '" + Left(_cCod,Len(SA1->A1_COD)) + "' "
	_cQuery += "      AND C9_LOJA = '" + Right(_cCod,Len(SA1->A1_LOJA)) + "' "
	_cQuery += "      AND " + Alltrim(SZR->ZR_B1) + " = '" + _cProd + "'  "
	_cQuery += "      AND LEFT(F2_EMISSAO,06) = '" + Left(Dtos(dDAtaBase),6) + "'
	_cQuery += "      AND F4_ESTOQUE = 'S' "
	_cQuery += "      AND C9.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND D2.D_E_L_E_T_ = ' ' "
	_cQuery += "UNION ALL "
	
	_cQuery += "SELECT SUM(C9_QTDLIB*B1_CONV) AS QUANT "
	_cQuery += "FROM " + RetSqlName("SC9") + " C9 "
	_cQuery += "     INNER JOIN " + RetSqlName("SB1") + " B1 "
	_cQuery += "             ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = C9_PRODUTO "
	_cQuery += "WHERE C9_FILIAL = '" + xFilial("SC9") + "' "
	_cQuery += "      AND C9_CLIENTE = '" + Left(_cCod,Len(SA1->A1_COD)) + "' "
	_cQuery += "      AND C9_LOJA = '" + Right(_cCod,Len(SA1->A1_LOJA)) + "' "
	_cQuery += "      AND " + Alltrim(SZR->ZR_B1) + " = '" + _cProd + "'  "
	_cQuery += "      AND C9_NFISCAL = ' ' "
	_cQuery += "      AND C9.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "
	
	TcQuery _cQuery New Alias "QRC9"
	;
	QRC9->(DbGoTop())
	
	Do While ! QRC9->(Eof()) .And. SZR->ZR_CODIGO <> '001'
		_nQtdMes	+= QRC9->QUANT
		QRC9->(DbSkip())
	EndDo
	
	QRC9->(DbCloseArea())
	
	// Checa a quantidade minima.
	If SZS->(DbSeek(xFilial("SZS")+SZR->ZR_CODIGO+_cProd))
		If (_nQuant + _nQtdMes) > SZS->ZS_QTDMIN
			_lRet := .f.
		EndIf
	EndIf
	// Se estourou a quantidade minima do produto, entใo checa licenca no orgao.
	If ! _lRet
		// Se a soma da quantidade necessaria + a ja utilizada for maior que a quantidade da licenca retorna falso
		If (_nQuant + _nQtdMes) > _nQtdLic
			For _nX := 1 To Len(aProd)
				SB1->(DbSeek(xFilial("SB1")+aProd[_nX]))
				fAtulog("Produto: " + Alltrim(SB1->B1_PNUMBER) + " - " + Alltrim(SB1->B1_DESC) + ", a quantidade excede a quantidade da licenca, ou nao existe.")
			Next _nX
			_lRet := .f.
		Else
			_lRet := .t.
		EndIf
	EndIf
EndIf

Return(_lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtuLog   บAutor  ณAdriano Luis Brandaoบ Data ณ  27/05/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para atualizacao do campo de log.                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtulog(_cTexto)

_cMenLog += _cTexto + cEol

Return
