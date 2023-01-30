/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM007   บAutor  ณAdriano Luis Brandaoบ Data ณ  08/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para geracao do arquivo TXT dos orgaos.              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Protheus.ch"
#Include "Topconn.ch"

User Function ESTM007()

Private cPerg := "XESTM007"
Private cCadastro	:= "Gera็ใo arquivo TXT"
Private aSays		:= {}
Private aButtons	:= {}
Private nOpca 		:= 0
Private oPrint


// Funcao para criacao das perguntas da rotina.
fCriaSx1()                                    

Pergunte(cPerg,.t.)  



AADD(aSays,"Este programa ้ utilizado para gerar um arquivo " )
AADD(aSays,"TXT do orgao selecionado no parametro" )


AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. )}})
AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1
	If ApMsgYesNo("Confirma Geracao do arquivo texto " + Posicione("SZR",1,xFilial("SZR")+MV_PAR03,"ZR_DESCR")+" ?","Confirmar")
		fGera()
	EndIf
EndIf                   

Return                               


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGera     บAutor  ณAdriano Luis Brandaoบ Data ณ  08/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para geracao do arquivo texto.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fGera()

Local _cCampo := ""
Private _cArqTxt
Private nHdl

//
// Processamento do arquivo texto.
//

SZR->(DbSetOrder(1))
If SZR->(DbSeek(xFilial("SZR")+MV_PAR03))
	_cCampo := Alltrim(SZR->ZR_B1)
EndIf

Do Case
	Case _cCampo == "B1_AXCTPF"
		Processa( {|| _fProcPF() })
	
	// Case - para outros orgaos.
EndCase



fClose(nHdl)

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fProcPF  บAutor  ณAdriano Luis Brandaoบ Data ณ  08/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de processamento do arquivo texto Policia Federal.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fProcPF()

Local _cData:= DTOS(mv_par02)
Local _cAno	:= LEFT(_cData,4)
Local _cMes := Substr(_cData,5,2)

_cArqTxt := "\Export\pf" + _cAno + _cMes + ".TXT"
nHdl    := fCreate(_cArqTxt)

cEOL := CHR(13)+CHR(10)

If nHdl == -1
	MsgAlert("O arquivo "+_cArqTxt+" nao pode ser executado! Verifique os parametros.","Atencao!")
	ApMsgStop("O arquivo " + _cArqTxt + " nao pode ser criado ")
	Return
Endif 

_aMes 		:= {"JAN","FEV","MAR","ABR","MAI","JUN","JUL","AGO","SET","OUT","NOV","DEZ"}

_cMesExt	:= _aMes[val(_cMes)]

//
// Gera Registro do cabecalho
//
_cRegistro 	:= "ME"
_cRegistro 	+= SM0->M0_CGC
_cRegistro	+= _cAno
_cRegistro	+= _cMesExt
_cRegistro	+= cEOL

If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
	If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
		Return
	Endif
Endif

//
// Gera Registro da empresa
//

_cCNAE 		:= SM0->M0_CNAE

_cRegistro 	:= "EM"																// Tipo
_cRegistro 	+= SM0->M0_CGC														// CNPJ
_cRegistro	+= SM0->M0_NOMECOM + Space(30)										// Nome Razao
_cRegistro	+= "00000589-4"														// Nr. CLF
_cRegistro	+= Left(_cCNAE,4)	+ "-" + Substr(_cCNAE,5,1) + "/"
_cRegistro  += Right(_cCNAE,2) + " "											// Cod. CNAE
_cRegistro	+= "000010000"														// Grupos de 1 a 9
_cRegistro	+= Space(50)														// Des.Grupo IX
_cRegistro	+= Space(200)														// Informacoes
_cRegistro	+= "Grupo V   "														// Grupo Principal
_cRegistro	+= "LUCI AKEMI MASSUMOTO" + Space(20)								// Responsavel
_cRegistro	+= "11180580893"													// CPF do Resp.
_cRegistro	+= "77002702   "													// Ident. Resp.
_cRegistro	+= "SSP" + Space(32)												// Orgao Ident.
_cRegistro	+= "  "																// UF Identidade
_cRegistro	+= "11 "															// DDD
_cRegistro	+= Left(SM0->M0_TEL,8)												// Telefone
_cRegistro	+= Left(SM0->M0_FAX,8)												// Fax
_cRegistro	+= "alpax@alpax.com.br" + Space(32)									// email
_cRegistro	+= cEOL																// final de linha

If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
	If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
		Return
	Endif
Endif

//
// Gerando registro dos produtos.
//
_cQuery := "SELECT ZV_ANO, ZV_MES, ZV_CONC, ZV_DENS, ZV_SLDANT, ZV_COMPRAS, ZV_CONSUMO, ZV_SAIDAS, ZV_SAIDV, "
_cQuery += "       ZV_ENTDV, ZV_SALFIN, ZV_NCM, ZV_DESCRI, ZV_CLAS "
_cQuery += "FROM " + RetSqlName("SZV") + " ZV "
_cQuery += "WHERE ZV_FILIAL = '" + xFilial("SZV") + "' "
_cQuery += "      AND ZV_ANO+ZV_MES BETWEEN '" + LEFT(DTOS(MV_PAR01),6) + "' AND '" + LEFT(DTOS(MV_PAR02),6) + "' "
_cQuery += "      AND ZV_ORGAO = '" + MV_PAR03 + "' AND ZV.D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias "QR1"


TcSetField("QR1","ZV_SLDANT","N",12,3)                                                            
TcSetField("QR1","ZV_COMPRAS","N",12,3)
TcSetField("QR1","ZV_CONSUMO","N",12,3)
TcSetField("QR1","ZV_SAIDAS","N",12,3)
TcSetField("QR1","ZV_SALFIN","N",12,3)  
TcSetField("QR1","ZV_SAIDV","N",12,3)
TcSetField("QR1","ZV_ENTDV","N",12,3)                             

SZS->(DbSetOrder(1))                  
// ZS_FILIAL, ZS_ORGAO, ZS_CON

Do While ! QR1->(Eof())

	SZS->(DbSeek(xFilial("SZS")+MV_PAR03+QR1->ZV_CLAS))

	_cRegistro	:= "PR"														// TIPO
	_cRegistro	+= SM0->M0_CGC												// CNPJ
	_cRegistro	+= QR1->ZV_ANO												// Ano
	_cRegistro	+= _aMes[val(QR1->ZV_MES)]									// Mes
	_cRegistro	+= Left(QR1->ZV_CONC,6)										// Concentracao
	_cRegistro	+= Left(QR1->ZV_DENS,6) 									// Densidade
	_cRegistro	+= StrTran(Strzero(QR1->ZV_SLDANT,20,3),".",",")				// Qt.Etq. Ant.
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Produzida
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Transform.
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Utilizada
	_cRegistro	+= StrTran(Strzero(QR1->ZV_COMPRAS,20,3),".",",")			// Qt.Compras
	_cRegistro	+= StrTran(Strzero(QR1->ZV_SAIDAS,20,3),".",",")			// Qt.Vendas
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Reciclagem
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Reaproveit.
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Importacao
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Exportacao
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Perdas
	_cRegistro	+= StrTran(Strzero(0,20,3),".",",")							// Qt.Evaporacao
	_cRegistro	+= StrTran(Strzero(QR1->ZV_ENTDV,20,3),".",",")			// Qt.Entr.Divers.
	_cRegistro	+= StrTran(Strzero(QR1->ZV_SAIDV,20,3),".",",")			// Qt.Saida Divers.
	_cRegistro	+= StrTran(Strzero(QR1->ZV_SALFIN,20,3),".",",")				// Qt.Est.Atual
	_cRegistro	+= Padr(iif(alltrim(SZS->ZS_UM)=="L","Litro ",SZS->ZS_UM),6)    // Unidade Medida
	_cRegistro	+= Left(QR1->ZV_NCM,4) + "." + Substr(QR1->ZV_NCM,5,2) + "."
	_cRegistro	+= Substr(QR1->ZV_NCM,7,2)									// Cod.NCM
	_cRegistro	+= Left(QR1->ZV_DESCRI,70)									// Nome Produto
	_cRegistro	+= cEOL														// Final de linha
	If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
		If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
			Return
		Endif
	Endif              
	
	QR1->(DbSkip())
	
EndDo                                 

QR1->(DbCloseArea())

// Geracao dos movimentos.       

// Entradas de fornecedores                                          
_cQuery	:= "SELECT D1_EMISSAO, D1_CF, B1_AXCONC, SUM(D1_QUANT) AS D1_QTSEGUM, D1_SEGUM, D1_DOC, A2_CGC AS CNPJ, "
_cQuery += "       F1_AXTRANS AS TRANSP, B1_POSIPI, ZS_DESCR, ZS_UM, D1_QUANT AS D1_QUANT, "
_cQuery += "       'F' AS TIPO, B1_CONV, B1_TIPCONV "
_cQuery += "FROM " + RetSqlName("SD1") + " D1 " 
_cQuery += "     INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "             ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = D1_COD "
_cQuery += "     INNER JOIN " + RetSqlName("SA2") + " A2 "
_cQuery += "             ON A2_FILIAL = '" + xFilial("SA2") + "' AND A2_COD = D1_FORNECE "
_cQuery += "                AND A2_LOJA = D1_LOJA "
_cQuery += "     INNER JOIN " + RetSqlName("SF1") + " F1 "
_cQuery += "             ON F1_FILIAL = '" + xFilial("SF1") + "' AND F1_DOC = D1_DOC "
_cQuery += "                AND D1_SERIE = F1_SERIE AND D1_FORNECE = F1_FORNECE AND D1_LOJA = F1_LOJA "
_cQuery += "     INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "             ON ZS_FILIAL = '" + xFilial("SZS") + "' AND ZS_ORGAO = '" + SZR->ZR_CODIGO + "' "
_cQuery += "                AND ZS_CON = B1_AXCTPF " 
_cQuery += "     INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "             ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D1_TES "
_cQuery += "WHERE D1_FILIAL = '" + xFilial("SD1") + "' AND LEFT(D1_EMISSAO,06) = '" + _cAno + _cMes + "' "
_cQuery += "      AND D1_TIPO = 'N' AND D1.D_E_L_E_T_ = ' ' AND F4_ESTOQUE = 'S' "
_cQuery += "      AND A2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' "
_cQuery += "      AND ZS.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' "  
_cQuery += "GROUP BY D1_EMISSAO, D1_CF, B1_AXCONC, D1_SEGUM, D1_DOC, A2_CGC, F1_AXTRANS, "
_cQuery += "         B1_POSIPI, ZS_DESCR, ZS_UM, B1_CONV, B1_TIPCONV " 

_cQuery += "UNION ALL "

// Entradas de clientes (devolucoes e beneficiamentos)
_cQuery	+= "SELECT D1_EMISSAO, D1_CF, B1_AXCONC, SUM(D1_QUANT) AS D1_QTSEGUM, D1_SEGUM, D1_DOC, "
_cQuery += "       A1_CGC AS CNPJ, F1_AXTRANS AS TRANSP, B1_POSIPI, ZS_DESCR, ZS_UM, "
_cQuery += "       SUM(D1_QUANT) AS D1_QUANT, 'F' AS TIPO, B1_CONV, B1_TIPCONV "
_cQuery += "FROM " + RetSqlName("SD1") + " D1 " 
_cQuery += "     INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "             ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = D1_COD "
_cQuery += "     INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "             ON A1_FILIAL = '" + xFilial("SA1") + "' AND A1_COD = D1_FORNECE "
_cQuery += "                AND A1_LOJA = D1_LOJA "
_cQuery += "     INNER JOIN " + RetSqlName("SF1") + " F1 "
_cQuery += "             ON F1_FILIAL = '" + xFilial("SF1") + "' AND F1_DOC = D1_DOC "
_cQuery += "                AND F1_SERIE = D1_SERIE AND F1_FORNECE = D1_FORNECE AND F1_LOJA = D1_LOJA "
_cQuery += "     INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "             ON ZS_FILIAL = '" + xFilial("SZS") + "' AND ZS_ORGAO = '" + SZR->ZR_CODIGO + "' "
_cQuery += "                AND ZS_CON = B1_AXCTPF "                
_cQuery += "     INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "             ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D1_TES "
_cQuery += "WHERE D1_FILIAL = '" + xFilial("SD1") + "' AND LEFT(D1_EMISSAO,06) = '" + _cAno + _cMes + "' "
_cQuery += "      AND D1_TIPO IN ('D','B') AND D1.D_E_L_E_T_ = ' ' AND F4_ESTOQUE = 'S' "
_cQuery += "      AND B1.D_E_L_E_T_ = ' ' AND F1.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND ZS.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY D1_EMISSAO, D1_CF, B1_AXCONC, D1_SEGUM, D1_DOC, A1_CGC, F1_AXTRANS, B1_POSIPI, "
_cQuery += "         ZS_DESCR, ZS_UM, B1_CONV, B1_TIPCONV "

_cQuery += "UNION ALL "

// Saidas para clientes
_cQuery += "SELECT D2_EMISSAO, D2_CF, B1_AXCONC, SUM(D2_QUANT) AS D2_QTSEGUM, D2_SEGUM, D2_DOC, A1_CGC AS CNPJ, "
_cQuery += "       F2_TRANSP AS TRANSP, B1_POSIPI, ZS_DESCR, ZS_UM, SUM(D2_QUANT) AS D2_QUANT, "
_cQuery += "       'C' AS TIPO, B1_CONV, B1_TIPCONV "
_cQuery += "FROM " + RetSqlName("SD2") + " D2 " 
_cQuery += "      INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "              ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = D2_COD "
_cQuery += "      INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "              ON A1_FILIAL = '" + xFilial("SA1") + "' AND A1_COD = D2_CLIENTE AND A1_LOJA = D2_LOJA "
_cQuery += "      INNER JOIN " + RetSqlName("SF2") + " F2 "
_cQuery += "              ON F2_FILIAL = '" + xFilial("SF2") + "' AND F2_DOC = D2_DOC AND F2_SERIE = D2_SERIE "
_cQuery += "      INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "              ON ZS_FILIAL = '" + xFilial("SZS") + "' AND ZS_ORGAO = '" + SZR->ZR_CODIGO + "' "
_cQuery += "                 AND ZS_CON = B1_AXCTPF "
_cQuery += "      INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "              ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D2_TES "
_cQuery += "WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND LEFT(D2_EMISSAO,06) = '" + _cAno + _cMes + "' "
_cQuery += "      AND D2_TIPO = 'N' AND D2_TES NOT IN ('522','519','505') AND F4_ESTOQUE = 'S'
_cQuery += "      AND D2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' "
_cQuery += "      AND A1.D_E_L_E_T_ = ' ' AND ZS.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY D2_EMISSAO, D2_CF, B1_AXCONC, D2_SEGUM, D2_DOC, A1_CGC, F2_TRANSP, B1_POSIPI, ZS_DESCR, "
_cQuery += "         ZS_UM, B1_CONV, B1_TIPCONV "

_cQuery += "UNION ALL "

// Saidas para fornecedores (devolucoes e beneficiamentos a fornecedores)
_cQuery += "SELECT D2_EMISSAO, D2_CF, B1_AXCONC, SUM(D2_QUANT) AS D2_QTSEGUM, D2_SEGUM, D2_DOC, "
_cQuery += "       A2_CGC AS CNPJ, F2_TRANSP AS TRANSP, B1_POSIPI, ZS_DESCR, ZS_UM, "
_cQuery += "       SUM(D2_QUANT) AS D2_QUANT, 'C' AS TIPO, B1_CONV, B1_TIPCONV "
_cQuery += "FROM " + RetSqlName("SD2") + " D2 " 
_cQuery += "     INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "             ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = D2_COD "
_cQuery += "     INNER JOIN " + RetSqlName("SF2") + " F2 "
_cQuery += "             ON F2_FILIAL = '" + xFilial("SF2") + "' AND F2_DOC = D2_DOC AND F2_SERIE = D2_SERIE "
_cQuery += "                AND F2_CLIENTE = D2_CLIENTE AND F2_LOJA = D2_LOJA "
_cQuery += "     INNER JOIN " + RetSqlName("SA2") + " A2 "
_cQuery += "             ON A2_FILIAL = '" + xFilial("SA2") + "' AND A2_COD = D2_CLIENTE AND A2_LOJA = D2_LOJA "
_cQuery += "     INNER JOIN " + RetSqlName("SZS") + " ZS "
_cQuery += "             ON ZS_ORGAO = '" + SZR->ZR_CODIGO + "' AND ZS_CON = B1_AXCTPF "                      
_cQuery += "     INNER JOIN " + RetSqlName("SF4")+ " F4 "
_cQuery += "             ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D2_TES "
_cQuery += "WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND LEFT(D2_EMISSAO,06) = '" + _cAno + _cMes + "' "
_cQuery += "      AND D2_TES NOT IN ('522','519','505') AND D2_TIPO IN ('B','D') AND D2.D_E_L_E_T_ = ' ' "
_cQuery += "      AND F4_ESTOQUE = 'S' "
_cQuery += "      AND B1.D_E_L_E_T_ = ' ' AND F2.D_E_L_E_T_ = ' ' "
_cQuery += "      AND A2.D_E_L_E_T_ = ' ' AND ZS.D_E_L_E_T_ = ' ' "
_cQuery += "GROUP BY D2_EMISSAO, D2_CF, B1_AXCONC, D2_SEGUM, D2_DOC, A2_CGC, F2_TRANSP, B1_POSIPI, ZS_DESCR,"
_cQuery += "         D2_DOC, A2_CGC, F2_TRANSP, B1_POSIPI, ZS_DESCR, ZS_UM, B1_CONV, B1_TIPCONV "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_AXCONC"		,"N",7,2)
TcSetField("QR1","D1_QTSEGUM"		,"N",12,3)
TcSetField("QR1","D1_QUANT"			,"N",12,3)
TcSetField("QR1","D1_CONV"			,"N",12,3)

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	_nQtdSeg := 0
	If QR1->B1_CONV # 0
		If QR1->B1_TIPCONV == "M"
			_nQtdSeg := QR1->D1_QUANT * QR1->B1_CONV
		ElseIf QR1->B1_TIPCONV == "D"
			_nQtdSeg := QR1->D1_QUANT / QR1->B1_CONV
		EndIf
	EndIF
	
	_cRegistro	:= "MV"														// TIPO
	_cRegistro	+= SM0->M0_CGC												// CNPJ
	_cRegistro	+= Left(QR1->D1_EMISSAO,4)									// Ano
	_cRegistro	+= _aMes[val(Substr(QR1->D1_EMISSAO,5,2))]					// Mes
	_cRegistro	+= Right(QR1->D1_EMISSAO,2)									// Dia
	_cRegistro	+= Left(QR1->D1_CF,1) + "." + Substr(QR1->D1_CF,2,3)		// CFOP
	_cRegistro	+= StrTran(Strzero(QR1->B1_AXCONC,06,2),".",",")			// Concentracao
	_cRegistro	+= StrTran(Strzero(_nQtdSeg,20,3),".",",")					// Qtde.Produto
	_cRegistro	+= iif(alltrim(QR1->ZS_UM)=="L","Litro ",QR1->ZS_UM+Space(04))	// Unidade Medida
	_cRegistro	+= QR1->D1_DOC + Space(01)									// Nota Fiscal
	_cRegistro	+= QR1->CNPJ												// CNPJ
	If QR1->TIPO == 'F'
		_cRegistro	+= Left(Posicione("SA4",1,xFilial("SA4")+QR1->TRANSP,"A4_CGC"),14) // CGC TRANSP
	Else
		_cRegistro	+= IIF(QR1->TRANSP=="      ",QR1->CNPJ,Left(Posicione("SA4",1,xFilial("SA4")+QR1->TRANSP,"A4_CGC"),14)) // CGC TRANSP	
	EndIf
	_cRegistro	+= Left(QR1->B1_POSIPI,4) + "." + Substr(QR1->B1_POSIPI,5,2) + "."
	_cRegistro	+= Substr(QR1->B1_POSIPI,7,2)								// Cod.NCM
	_cRegistro	+= QR1->ZS_DESCR + Space(40)									// Nome Produto
	_cRegistro	+= cEOL														// Fim de linha
	If fWrite(nHdl,_cRegistro,Len(_cRegistro)) != Len(_cRegistro)
		If ApMsgStop("Ocorreu um erro na gravacao do arquivo, processo cancelado !!!")
			Return
		Endif
	Endif
	
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSx1  บAutor  ณAdriano Luis Brandaoบ Data ณ  08/08/11   บฑฑ
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
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = DATA DE ณ
//ณMV_PAR02 = DATA ATEณ
//ณMV_PAR03 = ORGAO   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

PutSx1(cPerg,"01","Data de"         ,"Data de"      ,"Data de" ,"mv_ch1","D",08,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Data ate"        ,"Data Ate"     ,"Data Ate","mv_ch2","D",08,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Orgao"        	,"Orgao"        ,"Orgao"   ,"mv_ch3","C",03,0,0,"G","","SZR","","","mv_par03","","","","","","","","","","","","","","","","",,,)

Return