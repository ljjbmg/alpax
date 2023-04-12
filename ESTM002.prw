/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM002   บAutor  ณOcimar              บ Data ณ  13/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para atualizacao do ultimo preco de compra,          บฑฑ
ฑฑบ          ณpreco de venda, preco minimo                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

#Include "Topconn.ch"                 '
#Include "Protheus.ch"

User Function ESTM002(_aParam)

Private _cPerg := "ESTM02"
Private cCadastro := "Atualizacao Ultimo preco de compra"
Private aSays	  :={}
Private aButtons  :={}
Private nOpca	  := 0
Private _cMarca	  := GetNewPar("MV_AXMARCA")

fCriaPerg()

Pergunte(_cPerg,.f.)

If _aParam == Nil
	
	AADD(aSays,"Este programa ira atualizar o ultimo preco de compra," )
	AADD(aSays,"de acordo com o maior preco das entradas de notas fiscais")
	
	AADD(aButtons, { 5,.T.,{|| Pergunte(_cPerg,.T. )}})
	AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
	AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )
	
	FormBatch( cCadastro, aSays, aButtons )
	
	If nOpca == 1
		If ApMsgYesNo("Confirma atualizacao de acordo com as perguntas do parametro")
			Processa({|| fAtualiza()})
		EndIf
	EndIf
	
Else
	
	MV_PAR01 = _aParam[01]
	MV_PAR02 = _aParam[02]
	MV_PAR03 = _aParam[03]
	MV_PAR04 = _aParam[04]
	MV_PAR05 = _aParam[05]
	MV_PAR06 = _aParam[06]
	MV_PAR07 = _aParam[07]
	MV_PAR08 = _aParam[08]
	MV_PAR09 = _aParam[09]
	
	Processa({|| fAtualiza()})
	
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfatualiza บAutor  ณMicrosiga           บ Data ณ  13/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณfuncao de processamento e atualizacao dos precos.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtualiza()

Local _cQuery
Local _nPrcMin 	:= 0
Local _nPrcVen 	:= 0

SB1->(DbSetOrder(1))
SZ2->(DbSetOrder(2))

_cQuery := "SELECT D1_COD,  MAX((D1_VUNIT+(D1_VALIPI / D1_QUANT))+(D1_ICMSRET/D1_QUANT)) AS UNITAR, "
_cQuery += "       MAX(D1_VUNIT) AS VCOMPRA "
_cQuery += "FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "         INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "                     ON F4_FILIAL = '" + xFilial("SF4") + "' AND D1_TES = F4_CODIGO AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "                        AND F4_CREDIPI <> 'S' "
_cQuery += "         INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                     ON B1_FILIAL = '" + xFilial("SB1") + "' AND D1_COD = B1_COD "
_cQuery += "WHERE D1_TIPO = 'N' AND SUBSTRING(D1_CF,2,3) IN ('102','101','922','403') "
_cQuery += "      AND D1.D_E_L_E_T_ = ' ' AND D1_QUANT > 0 "
_cQuery += "      AND D1_DTDIGIT BETWEEN '" + DTOS(MV_PAR07) + "' AND '" + DTOS(MV_PAR08) + "' "
_cQuery += "      AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "      AND B1_AXLINHA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "      AND B1_MARCA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
If MV_PAR09 == 2 
	_cQuery += "             AND B1_AXCSV <> '1' "
EndIf
_cQuery += "GROUP BY D1_COD "

_cQuery += "UNION ALL "

_cQuery += "SELECT D1_COD,  MAX((D1_VUNIT)+(D1_ICMSRET/D1_QUANT)) AS UNITAR, "
_cQuery += "       MAX(D1_VUNIT) AS VCOMPRA "
_cQuery += "FROM " + RetSqlName("SD1") + " D1 "
_cQuery += "         INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "                     ON F4_FILIAL = '" + xFilial("SF4") + "' AND D1_TES = F4_CODIGO AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "                        AND F4_CREDIPI = 'S' "
_cQuery += "         INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                     ON B1_FILIAL = '" + xFilial("SB1") + "' AND D1_COD = B1_COD "
_cQuery += "WHERE D1_TIPO = 'N' AND SUBSTRING(D1_CF,2,3) IN ('102','101','922','403') "
_cQuery += "      AND D1.D_E_L_E_T_ = ' ' AND D1_DTDIGIT BETWEEN '" + DTOS(MV_PAR07) + "' AND '" + DTOS(MV_PAR08) + "' "
_cQuery += "      AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "      AND B1_AXLINHA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "      AND B1_MARCA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
If MV_PAR09 == 2 
	_cQuery += "             AND B1_AXCSV <> '1' "
EndIf
_cQuery += "GROUP BY D1_COD "

MemoWrite("\queries\estm0002.sql",_cQuery)

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","UNITAR" ,"N",12,2)
TcSetField("QR1","VCOMPRA","N",12,2)

AutoGrLog("***********  Inicio da rotina ESTM002 em " + Dtoc(dDAtaBase) + " - " + Transform(Time(),"99:99:99"))
_nLinha := 1
Do While ! QR1->(Eof())
	If SB1->(DbSeek(xFilial("SB1")+QR1->D1_COD))
		If SB1->B1_UPRC <> QR1->VCOMPRA
			RecLock("SB1",.f.)
			SB1->B1_UPRC := QR1->VCOMPRA
			SB1->B1_AXCUS := QR1->UNITAR
			AutoGrLog(Strzero(_nLinha,5) + " - Alterado ultimo preco produto " + SB1->B1_PNUMBER + " para R$." + Transform(SB1->B1_UPRC,"@E 9,999,999.99"))
			_nLinha++
			SB1->(MsUnLock())
		EndIf
	EndIf
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

_cQuery := "SELECT B1_COD, B1_UPRC, Z2_INDICE, Z2_INDPRV, B1_AXINDIC, B1_AXCUS, Z2_INDPRVI, Z2_INIMPMI, Z2_INDPRDM, Z2_INDPRDV "
_cQuery += "       FROM " + RetSqlName("SB1") + " B1 "
_cQuery += "       INNER JOIN " + RetSqlName("SZ2") + " Z2 "
_cQuery += "               ON Z2_FILIAL = '" + xFilial("SZ2") + "' AND Z2_DESCR = B1_MARCA "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "             AND B1_AXLINHA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "             AND B1_MARCA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
If MV_PAR09 == 2 
	_cQuery += "             AND B1_AXCSV <> '1' "
EndIf
_cQuery += "             AND Z2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "

MemoWrite("\queries\estm0002-1.sql",_cQuery)

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_UPRC"	    ,"N",12,2)
TcSetField("QR1","B1_AXINDIC"	,"N",12,2)
TcSetField("QR1","Z2_INDICE"	,"N",12,3)
TcSetField("QR1","Z2_INDPRV"	,"N",12,3)
TcSetField("QR1","B1_AXCUS"  	,"N",12,3)
TcSetField("QR1","Z2_INDPRVI"	,"N",12,3)
TcSetField("QR1","Z2_INIMPMI"	,"N",12,3)
TcSetField("QR1","Z2_INDPRDM"	,"N",12,3)
TcSetField("QR1","Z2_INDPRDV"	,"N",12,3)

Do While ! QR1->(Eof())
	If SB1->(DbSeek(xFilial("SB1")+QR1->B1_COD))
		RecLock("SB1",.f.)
		If Alltrim(SB1->B1_MARCA) $ _cMarca
			If SB1->B1_XSITPRO == "I"		// Importado comprado
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INIMPMI)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRVI)))
			ElseIf SB1->B1_XSITPRO == "N" 	// Nacional Comprado
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INDICE)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRV)))
			Else	// Produzido
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INDPRDM)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRDV)))
			EndIf
		Else
			If SB1->B1_ORIGEM $ "1/6"
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INIMPMI)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(QR1->B1_AXINDIC > 0,QR1->B1_AXINDIC,QR1->Z2_INDPRVI)))
			Else
				_nPrcMin := (SB1->B1_AXCUS * QR1->Z2_INDICE)
				_nPrcVen := (SB1->B1_AXCUS * (Iif(QR1->B1_AXINDIC > 0,QR1->B1_AXINDIC,QR1->Z2_INDPRV)))
			EndIf
		EndIf
		SB1->B1_PRV1 	:= _nPrcVen
		SB1->B1_AXPRMIN	:= _nPrcMin
		//NOVOS CAMPOS DE PRECO DE 4%, 7% E 12% BEGIN
		nPis 		:= 1.65 //aliquota de pis
		nCof		:= 7.60 //aliquota cofins
		nIcm		:= IIF(SB1->B1_PICM==0,18,SB1->B1_PICM) //ALIQUOTA DE ICM
		nPerc		:= (100 - (nPis + nCof + nIcm)) / 100   //percentual de calculo
		aTmp 		:= INDICEMR(SB1->B1_AXCUS * nPerc)      //PARA CALCULAR INDICE DE MARCA
		_nPrcMin1	:= aTmp[01]
		_nPrcVen1	:= aTmp[02]
		DO CASE 
			CASE SB1->B1_ORIGEM $ "1|2|3|8|" //4%
				nPerc1 			:= (100 - (nPis + nCof + 4)) / 100  //percentual de calculo de 4%
				_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
				_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
				SB1->B1_XPRV4	:= _nPrcVen                                         
				SB1->B1_XPRMN4  := _nPrcMin
				AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco venda 4% produto " + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcVen,"@E 9,999,999.99"))
				_nLinha++
				AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco minimo 4% produto" + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcMin,"@E 9,999,999.99"))
				_nLinha++ 				
			CASE SB1->B1_ORIGEM $ "0|4|5|6|7|" //7% E 12%
				nPerc1 			:= (100 - (nPis + nCof + 7)) / 100  //percentual de calculo de 7%
				_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
				_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
				SB1->B1_XPRV7	:= _nPrcVen                                         
				SB1->B1_XPRMN7  := _nPrcMin	 
				AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco venda 7% produto " + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcVen,"@E 9,999,999.99"))
				_nLinha++
				AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco minimo 7% produto" + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcMin,"@E 9,999,999.99"))
				_nLinha++ 								
				nPerc1 			:= (100 - (nPis + nCof + 12)) / 100  //percentual de calculo de 7%
				_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
				_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
				SB1->B1_XPRV12	:= _nPrcVen                                         
				SB1->B1_XPRMN12 := _nPrcMin								  
				AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco venda 12% produto " + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcVen,"@E 9,999,999.99"))
				_nLinha++
				AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco minimo 12% produto" + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcMin,"@E 9,999,999.99"))
				_nLinha++ 							
		ENDCASE								
		//NOVOS CAMPOS DE PRECO DE 4%, 7% E 12% END		
		SB1->(MsUnLock())
		AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco venda produto " + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcVen,"@E 9,999,999.99"))
		_nLinha++
		AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco minimo produto" + SB1->B1_PNUMBER + " para R$." + Transform(_nPrcMin,"@E 9,999,999.99"))
		_nLinha++ 
	EndIf
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

AutoGrLog("***********  Termino da rotina")
_cArqIni := NomeAutoLog()
__CopyFile( _cArqIni, "LOG_ULTPRC.TXT" )
MostraErro()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณINDICEMR  บAutor  ณMicrosiga           บ Data ณ  06/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณROTINA AUXILIAR PARA ADQUIRIR INDICE DE MARCA               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC FUNCTION INDICEMR(nCusto)

Local aRet		:= {}
Local _nPrcMin2	:= 0
Local _nPrcVen2	:= 0

If Alltrim(SB1->B1_MARCA) $ _cMarca
	If SB1->B1_XSITPRO == "I"		// Importado comprado
		_nPrcMin2 := (nCusto * QR1->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRVI)))
	ElseIf SB1->B1_XSITPRO == "N" 	// Nacional Comprado
		_nPrcMin2 := (nCusto * QR1->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRV)))
	Else	// Produzido
		_nPrcMin2 := (nCusto * QR1->Z2_INDPRDM)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,QR1->Z2_INDPRDV)))
	EndIf
Else
	If SB1->B1_ORIGEM $ "1/6"
		_nPrcMin2 := (nCusto * QR1->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(QR1->B1_AXINDIC > 0,QR1->B1_AXINDIC,QR1->Z2_INDPRVI)))
	Else
		_nPrcMin2 := (nCusto * QR1->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(QR1->B1_AXINDIC > 0,QR1->B1_AXINDIC,QR1->Z2_INDPRV)))
	EndIf
EndIf

AADD(aRet, _nPrcMin2 ) 
AADD(aRet, _nPrcVen2 ) 

RETURN(aRet)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaPerg บAutor  ณOcimar              บ Data ณ  13/01/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao das perguntas.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaPerg()

Local aPerg01 := {}
Local aPerg02 := {}
Local aPerg03 := {}
Local aPerg04 := {}
Local aPerg05 := {}
Local aPerg06 := {}

Aadd( aPerg01, "Informe o codigo do produto inicial" 	)
Aadd( aPerg02, "Informe o codigo do produto final " 	)
Aadd( aPerg03, "Informe a descricao da linha inicial"	)
Aadd( aPerg04, "Informe a descricao da linha final"		)
Aadd( aPerg05, "Informe a descricao da Marca Inicial"	)
Aadd( aPerg06, "Informe a descricao da Marca Final"		)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Produto de ณ
//ณMV_PAR02 = Produto ateณ
//ณMV_PAR03 = Linha de   ณ
//ณMV_PAR04 = Linha ate  ณ
//ณMV_PAR05 = Marca de   ณ
//ณMV_PAR06 = Marca ate  ณ
//ณMV_PAR07 = Dt.Inicial ณ
//ณMV_PAR08 = Dt.Final   ณ
//ณMV_PAR09 = Processa PRC ajustado csv?   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(_cPerg,"01","Produto de" 	 ,"Produto de" 	  ,"Produto de"    ,"mv_ch1","C",15,0,0,"G","","SB1","","","MV_PAR01","","","","","","","","","","","","","","","","",aPerg01,aPerg01,aPerg01)
PutSx1(_cPerg,"02","Produto Ate"	 ,"Produto ate"	  ,"Produto ate"   ,"mv_ch2","C",15,0,0,"G","","SB1","","","MV_PAR02","","","","","","","","","","","","","","","","",aPerg02,aPerg02,aPerg02)
PutSx1(_cPerg,"03","Linha de"   	 ,"Linha de"   	  ,"Linha de"      ,"mv_ch3","C",15,0,0,"G","","SZ1","","","MV_PAR03","","","","","","","","","","","","","","","","",aPerg03,aPerg03,aPerg03)
PutSx1(_cPerg,"04","Linha ate"  	 ,"Linha ate" 	  ,"Linha ate"     ,"mv_ch4","C",15,0,0,"G","","SZ1","","","MV_PAR04","","","","","","","","","","","","","","","","",aPerg04,aPerg04,aPerg04)
PutSx1(_cPerg,"05","Marca de"   	 ,"Marca de"   	  ,"Marca de"      ,"mv_ch5","C",15,0,0,"G","","SZ2","","","MV_PAR05","","","","","","","","","","","","","","","","",aPerg05,aPerg05,aPerg05)
PutSx1(_cPerg,"06","Marca ate"  	 ,"Marca ate"  	  ,"Marca ate"     ,"mv_ch6","C",15,0,0,"G","","SZ2","","","MV_PAR06","","","","","","","","","","","","","","","","",aPerg06,aPerg06,aPerg06)
PutSx1(_cPerg,"07","Data Inicial"    ,"Data Inicial"  ,"Data Inicial"  ,"mv_ch7","D",08,0,0,"G","",""   ,"","","MV_PAR07","","","","","","","","","","","","","","","","",       ,       ,       )
PutSx1(_cPerg,"08","Data Final"      ,"Data Final"    ,"Data Final"    ,"mv_ch8","D",08,0,0,"G","",""   ,"","","MV_PAR08","","","","","","","","","","","","","","","","",       ,       ,       )
PutSx1(_cPerg,"09","Processa PRC ajustado csv?","Processa PRC ajustado csv?","Processa PRC ajustado csv?","mv_ch9","C",01,0,0,"G","","","","","MV_PAR09","","","","","","","","","","","","","","","","",aPerg06,aPerg06,aPerg06)
Return
