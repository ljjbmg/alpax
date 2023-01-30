/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATR007   บAutor  ณMicrosiga           บ Data ณ  07/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ ORCAMENTO DE VENDA NO MODO GRAFICO. PDF                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP -ALPAX                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

22/03/17 - colocado tratamento para aparecer cst
15/05/17 - acerto campos na fun็ใo MAFISINI estava chumbado, efetuado corre็ใo

*/
#Include "Protheus.ch"
#Include "Topconn.ch"

User Function FATR007()
If APMsgYesNo("Confirma a impressao do orcamento " + SCJ->CJ_NUM)
	MsgRun("Aguarde Gerando relatorio",,{|| fProcessa() })
EndIf



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ          บAutor  ณMicrosiga           บ Data ณ  10/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ processamento dos dados para impressao.                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - alpax.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fProcessa()

Local _cDesc1 		:= 0
Local _cDesc2		:= 0
Local _lIpi 		:= .f.
Local _aDesc		:= {}
Local _nY

Private _nPixL, _nICMS, _lPrimeiro, oPrint
Private _nPag		:= 0
Private nColIni 	:= 0050
Private nColFim 	:= 2200
Private nRowFim 	:= 2600
Private nRowPage	:= 3000
Private _nAliqIcm	:= 0
Private	_nTotIpi	:= 0
Private	_nTotal		:= 0
Private _nTotIcms	:= 0
Private _nIcmSDes   := 0   // OCIMAR 09/02/11
Private _nTotalSub  := 0
Private _nFrete		:= 0
Private aRelimp		:= MafisRelImp("MT100",{"SF2","SD2"}) //fun็ใo adicionada SCMSIGA 15 05 2017


// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont8CN	:= TFont():New("Courier New"	,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)
Private oCour8N 	:= TFont():New("Courier New"	,09,08,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11N	:= TFont():New("Arial"			,11,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11		:= TFont():New("Arial"			,11,11,.T.,.F.,5,.T.,5,.T.,.F.)
//-------mgs de nota
Private cMvMsgTrib	:= SuperGetMV("MV_MSGTRIB",,"1")
Private cMvFntCtrb	:= SuperGetMV("MV_FNTCTRB",," ")
Private cMvFisCTrb	:= SuperGetMV("MV_FISCTRB",,"1")



// Posicionamento das tabelas de consulta
SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
// busca aliquota do ICMS do estado.
_aTXCalc := _fAliqIcms()
_nICMS := _aTXCalc[1]
_aTX := _aTXCalc[2]
_nValLiq := _aTXCalc[3]


_cQuery := "SELECT B1_COD, B1_PNUMBER, B1_DESC, DATEDIFF(DAY,CJ_EMISSAO,CK_ENTREG) AS ENTREG, CK_UM, CK_QTDVEN, CK_PRCVEN, B1_IPI, B1_AXFOTO, CK_VALOR, CK_TES, CK_LOCAL, "
_cQuery += "       CJ_AXVEND, CJ_VALIDA, CJ_CONDPAG, CJ_AXFRETE, CJ_AXPEDCL, CJ_OBSERV1, CJ_OBSERV2, CJ_AXCTATO, B1_AXTECNI, B1_TIPO, "
_cQuery += "       B1_MARCA, B1_CAPACID, U5_CONTAT, U5_EMAIL, B1_COD, F4_ICM, B1_ORIGEM, B1_POSIPI, B1.R_E_C_N_O_ AS B1RECNO, F4.R_E_C_N_O_ AS REGSF4, CK_XOPER "
_cQuery += "       , B1_ORIGEM+F4_SITTRIB XCST  "
_cQuery += "FROM " + RetSqlName("SCK") + " CK "
_cQuery += "          INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "                  ON CK_PRODUTO  = B1_COD "
_cQuery += "          INNER JOIN " + RetSqlName("SCJ") + " CJ "
_cQuery += "                  ON CJ_FILIAL = '" + xFilial("SCJ") + "' AND CK_NUM = CJ_NUM AND  CJ.D_E_L_E_T_ = ' ' "
_cQuery += "          INNER JOIN " + RetSqlName("SF4") + " F4 "
_cQuery += "                  ON F4_FILIAL = '" + xFilial("SF4") + "' AND CK_TES = F4_CODIGO "
_cQuery += "          LEFT JOIN " + RetSqlName("SU5") + " U5 "
_cQuery += "                  ON U5_FILIAL = '" + xFilial("SU5") + "' AND U5_CODCONT = CJ_AXCTATO "
_cQuery += "WHERE CK_FILIAL = '" + xFilial("SCK") + "' AND CK_NUM = '" + SCJ->CJ_NUM + "' AND  CK.D_E_L_E_T_ = ' ' "
_cQuery += "      AND B1_FILIAL = '" + xFilial("SB1") + "' AND B1.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' "
_cQuery += "ORDER BY CK_ITEM"

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","ENTREG"   	,"N",03,00)
TcSetField("QR1","CK_QTDVEN"	,"N",12,02)
TcSetField("QR1","CK_PRCVEN"	,"N",12,02)
TcSetField("QR1","B1_IPI"		,"N",05,02)
TcSetField("QR1","CK_VALOR"		,"N",12,02)
TcSetField("QR1","CJ_VALIDA"	,"D",08,00)
TcSetField("QR1","REGSF4"	    ,"N",06,00)
//TcSetField("QR1","TIPO"	        ,"C",02,00)

// POSICIONA TODAS AS TABELAS A UTILIZAR

// Cadastro de vendedor
SA3->(DbsetOrder(1))
SA3->(Dbseek(xFilial("SA3")+QR1->CJ_AXVEND))
// Cadastro de condicao de pagamento
SE4->(DbSetOrder(1))
SE4->(DbSeek(xFilial("SE4")+QR1->CJ_CONDPAG))
// Cadastro de TES
SF4->(DbSetOrder(1))
// Cadastro de produtos
SB1->(DbSetOrder(1))

_nPixL := 6000

_lPrimeiro := .t.

oPrint:= TMSPrinter():New( "Requisicao Interna" )
oPrint:SetPortrait() // ou SetLandscape()

QR1->(DbGoTop())

//-----| EDUARDO 11.08.2010 - INICIO DA OPERACAO FISCAL
MaFisSave()
MaFisEnd()
MaFisIni(SCJ->CJ_CLIENTE,;		// 1-Codigo Cliente/Fornecedor
SCJ->CJ_LOJA,;					// 2-Loja do Cliente/Fornecedor
"C",;			            	// 3-C:Cliente , F:Fornecedor
"N",;        					// 4-Tipo da NF
SA1->A1_TIPO,;				   	// 5-Tipo do Cliente/Fornecedor ALTERAวรO SCMSIGA ESTAVA CHUMBADO J 15 05 2017
aRelImp,;						// 6-Relacao de impostos que suportados no arquivo SCMSIGA 15 05 2017
Nil,;
Nil,;
NIL,;
"MATA461",;
NIL,;
NIL,;
"")

nVez := 0
Do While ! QR1->(Eof())
	
	//-----|| eduardo nakamatu  - carga fiscal
	nIcmsNt := 0
	nIpiNt  := 0
	nIcmSNt := 0
	nPisNt  := 0
	nCofNt  := 0
	nIcSNt  := 0
	nIcCNt  := 0
	nIssNt  := 0
	nIrNt   := 0
	nInsNt  := 0
	nCslNt  := 0
	
	nVez++
	SF4->(dbSetOrder(1))
	SF4->(DbSeek(xFilial("SF4")+QR1->CK_TES))
	SB1->(dbSetOrder(1))
	SB1->(DbSeek(xFilial("SB1")+QR1->B1_COD))
	dbSelectArea("SB2")
	SB2->(dbSetOrder(1))
	SB2->(DbSeek(xFilial("SB2")+QR1->B1_COD+"01"))
	dbSelectArea("SCK")
	SCK->(dbSetOrder(1))
	SCK->(dbSeek(xFilial("SCK")+SCJ->CJ_NUM ))
	
	MaFisAdd(QR1->B1_COD,;   		// 1-Codigo do Produto ( Obrigatorio )
	QR1->CK_TES,;	        // 2-Codigo do TES ( Opcional )
	QR1->CK_QTDVEN,;	    	// 3-Quantidade ( Obrigatorio )
	QR1->CK_PRCVEN,; 		// 4-Preco Unitario ( Obrigatorio )
	0,;                		// 5-Valor do Desconto ( Opcional )
	"",;						// 6-Numero da NF Original ( Devolucao/Benef )
	"",;						// 7-Serie da NF Original ( Devolucao/Benef )
	0,;					    // 8-RecNo da NF Original no arq SD1/SD2
	0,;						// 9-Valor do Frete do Item ( Opcional )
	0,;						// 10-Valor da Despesa do item ( Opcional )
	0,;            			// 11-Valor do Seguro do item ( Opcional )
	0,;						// 12-Valor do Frete Autonomo ( Opcional )
	QR1->CK_VALOR,;			// 13-Valor da Mercadoria ( Obrigatorio )
	0)						// 14-Valor da Embalagem ( Opiconal )
	
	If _nPixL >= (nRowFim-40)
		If ! _lPrimeiro
			oPrint:EndPage()
		EndIf
		// Imprime formulario e cabecalho do relatorio.
		_lPrimeiro := .f.
		_nPixL := _fForm()
	EndIf
	
	_cDescr := Alltrim(QR1->B1_DESC) + " - Marca:" + Alltrim(QR1->B1_MARCA) + " - Capacidade:" + Alltrim(QR1->B1_CAPACID)
	
	_aDesc	:= {}
	For _nY := 1 To Len(_cDescr) Step 38
		aAdd(_aDesc,Substr(_cDescr,_nY,38))
	Next _nY
	
	If SUBSTR(SF4->F4_CF,2,3) == "405"
		aAdd(_aDesc,".T.ICMS Jม RECOLHIDO POR SUBST. TRIBUT.")
	EndIf
	//Incluido por Fagner / Biale em 08/02/2013
	AADD(_aDesc,".T.NCM:" + alltrim(QR1->B1_POSIPI)+"   CST: "+alltrim(QR1->XCST))
	
	_lFoto := .f.
	If ! Empty(QR1->B1_AXFOTO)
		If _nPixL >= (nRowFIM-580) // Limite para impressao de uma foto
			oPrint:EndPage()
			_lPrimeiro := .f.
			// Imprime formulario e cabecalho do relatorio.
			_nPixL := _fForm()
		EndIf
		_lFoto := .t.
	EndIf
	_lIpi := (SF4->F4_IPI=="S")
	// funcao para buscar a aliquota de ICMS por Item
	
	// USANDO PADRAO _nAliqIcm := AliqIcms("N","S",SA1->A1_TIPO)
	nAliqICM := MAFISRET(nVez,'IT_ALIQICM') // ALIQUOTA ICMS ANFCAB[NF_IMPOSTOS]
	nAliqIPI := 0 //MAFISRET(nVez,'IT_ALIQIPI') // ALIQUOTA IPI
	//nAliqICM := MAFISRET(nVez,'IT_ALIQICM') // ALIQUOTA ICMS
	//nAliqICM := U_alqicm4("NFS","SA1",SCJ->CJ_CLIENTE,SCJ->CJ_LOJA,QR1->B1_COD,nAliqICM,"N")
	nAliqIPI := MAFISRET(nVez,'IT_ALIQIPI') // ALIQUOTA IPI
	
	// EDUARD/BIALE EM 09.11.09 - RETIRADO POIS ESTA CHUMBADO
	//If SA1->A1_GRPTRIB <> ' '
	//	_nAliqIcm := 18
	//EndIf
	
	// EDUARD/BIALE EM 09.11.09 - TRATAMENTO DE SUBSTITUICAO TRIBUTARIA
	IF ALLTRIM(QR1->CK_TES) $ "543"
		_nAliqIcm := 0
	ENDIF
	
	If QR1->F4_ICM <> "S" .And. Substr(SF4->F4_CF,2,3) == "405"
		_nAliqIcm := 0
	EndIf
	
	//	If QR1->CK_TES <> "552"		// Tem que ser produto diferente de frete, para imprimir
	
	oPrint:Say(_nPixL,nColIni+0030,QR1->B1_PNUMBER																		,oFont8CN)
	oPrint:Say(_nPixL,nColIni+0330,_aDesc[1]																			,oFont8CN)
	If QR1->ENTREG <= 2
		oPrint:Say(_nPixL,nColIni+1050,"Imediata"                        												,oFont8CN)
	Else
		oPrint:Say(_nPixL,nColIni+1050,Transform(QR1->ENTREG,"@999")+" Dias "											,oFont8CN)
	EndIf
	oPrint:Say(_nPixL,nColIni+1220,QR1->CK_UM																			,oFont8CN)
	oPrint:Say(_nPixL,nColIni+1320,Transform(QR1->CK_QTDVEN,"@e 99999")													,oFont8CN)
	oPrint:Say(_nPixL,nColIni+1445,Transform(QR1->CK_PRCVEN,"@e 999,999.99")											,oFont8CN)
	_nVlrItSt  := MAFISRET(nVez,'IT_VALSOL')
	oPrint:Say(_nPixL,nColIni+1615,Transform(QR1->CK_VALOR,"@e 9999,999.99")					   						,oFont8CN)
	//  EDUARDO NAKAMATU / BIALE 11.08.10 DESATIVANDO PARA USAR MATFIS
	//oPrint:Say(_nPixL,nColIni+1740,Transform(iif(_lIpi,QR1->B1_IPI,0),"99")								    		,oFont8CN)
	oPrint:Say(_nPixL,nColIni+1830,Transform(iif(_lIpi,NALIQIPI,0),"99.99")												,oFont8CN)
	// ocimar 07/07/09
	If QR1->CK_TES == '555'
		oPrint:Say(_nPixL,nColIni+1910,"0"													  							,oFont8CN)
		_Cocimar := '555'
	else
		//  EDUARDO NAKAMATU / BIALE 11.08.10 DESATIVANDO PARA USAR MATFIS
		//oPrint:Say(_nPixL,nColIni+1820,Transform(_nAliqIcm,"99")														,oFont8CN)
		oPrint:Say(_nPixL,nColIni+1910,Transform(nAliqIcm,"99.99")									 						,oFont8CN)
		_Cocimar := ' '
	EndIf
	oPrint:Say(_nPixL,nColIni+1975,Transform(_nVlrItSt,"@e 999,999.99")				 									,oFont8CN)
	//	Else
	//		_nFrete	+= QR1->CK_VALOR
	//	EndIf
	
	// EDUARDO NAKAMATU/BIALE 11.10.2010 TRATANDO MSFIS
	//_nValorICM  := MAFISRET(nVez,'IT_VALICM')
	// FAGNER / BIALE 31.01.13
	_nValorICM := QR1->CK_VALOR*(nAliqICM/100)
	//
	_nTotIpi	+= MAFISRET(nVez,'IT_VALIPI')
	
	//If QR1->B1_ORIGEM <> '0'                                 // OCIMAR 09/02/11
	//	_nIcmsDes   += ROUND(_nValorICM*0.9075,2)            // OCIMAR 09/02/11
	//else                                                     // OCIMAR 09/02/11
	//		_nTotIcms	+= _nValorICM                            // OCIMAR 09/02/11
	If SA1->A1_CODMUN <> "00255" .and.  Empty(SA1->A1_SUFRAMA)  // Fagner 19-02-13
		_nTotIcms	+= (QR1->CK_VALOR*nAliqICM)/100          // OCIMAR 09/02/11
	Endif
	//EndIf                                                    // OCIMAR 09/02/11
	_nTotal		+= QR1->CK_VALOR
	If SF4->F4_INCSOL <> 'N'
		_nVlrSubst  := MAFISRET(nVez,'IT_VALSOL')
	Else
		_nVlrSubst  := 0
	EndIf
	_nTotalSub  += _nVlrSubst
	
	//	ALERT( MaFisRet(,"NF_BASEDUP")	)
	
	If QR1->CK_TES <> "552"		// Tem que ser produto diferente de frete, para imprimir
		
		If _nVlrSubst > 0
			aAdd(_aDesc,".T.PROD. SUJEITO REG. SUBST. TRIBUT.")
		EndIf
		//
		// Campo Memo adicionado na descri็ใo.  (B1_AXTECNI)
		//
 
			_cBuffer := SB1->B1_AXTECNI
		
		nLinha	:= MLCount(_cBuffer,37)
		
		For nBegin := 1 To nLinha
			aAdd(_aDesc,Memoline(_cBuffer,37,nBegin,,.f.))
		Next nBegin
		
		// 03/05/2016 BEGIN INCLUSAO DE DESCRITIVO SE ITEM DO ORCAMENTO E PARA USO E CONSUMO OU REVENDA
		/*	IF ALLTRIM(QR1->CK_OPER)=="01" .OR. ALLTRIM(QR1->CK_OPER)=="" .AND. alltrim(QR1->B1_POSIPI) <> "99999999"
		AADD(_aDesc, "PARA REV/IND")
		ELSEIF ALLTRIM(QR1->CK_OPER)=="21" .AND. alltrim(QR1->B1_POSIPI) <> "99999999"
		AADD(_aDesc, "PARA USO E CONSUMO")
		ENDIF
		*/
		AADD(_aDesc,ALLTRIM(QR1->CK_XOPER))  // INCLUIDO OCIMAR 09/06/16
		
		// 03/05/2016 END INCLUSAO DE DESCRITIVO SE ITEM DO ORCAMENTO E PARA USO E CONSUMO OU REVENDA
		
		_nPixL+=40
		If Len(_aDesc) > 1
			For _nY := 2 To Len(_aDesc)
				If _nPixL >= (nRowFim-40)
					oPrint:EndPage()
					// Imprime formulario e cabecalho do relatorio.
					_nPixL := _fForm()
				EndIf
				If Left(_aDesc[_nY],3)==".T."	// para imprimir em negrito
					oPrint:Say(_nPixL,nColIni+0350,Substr(_aDesc[_nY],4,35)														,oCour8N)
				Else
					oPrint:Say(_nPixL,nColIni+0350,_aDesc[_nY]																	,oFont8CN)
				EndIf
				
				_nPixL+=40
			Next _nY
		EndIf
		
		If _lFoto
			oPrint:SayBitmap(_nPixL,nColIni+440,QR1->B1_AXFOTO,600,500)
			_nPixL+=550
		EndIf
		_nPixL+=40
	EndIf
	QR1->(dbskip())
	
	
	
EndDo

QR1->(DbCloseArea())

// Impressao do final do orcamento (condicoes gerais de venda
If ! _lPrimeiro
	_fRodape(_aTX)
	oPrint:EndPage()
	oPrint:StartPage()
	oPrint:SayBitmap(10,10,"\microsiga\fotos\PROPAG.bmp",2480,3300)
	oPrint:EndPage()
	oPrint:StartPage()
	oPrint:SayBitmap(10,10,"\microsiga\fotos\PROPAG2.bmp",2480,3300)
EndIf

oPrint:EndPage()     // Finaliza a pแgina
oPrint:Preview()     // Visualiza antes de imprimir



Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fform    บAutor  ณMicrosiga           บ Data ณ  10/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณmonta o cabecalho com o formulario completo.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fForm()

Local _nRet 	:= 0
Local nRow1 	:= 0050 // Linha para retorno
Local _cContato := QR1->U5_CONTAT
Local _cEmailCT := QR1->U5_EMAIL

_nPag++

If empty(QR1->U5_CONTAT)
	_cContato := SA1->A1_CONTATO
	_cEmailCT := SA1->A1_EMAIL
EndIf

oPrint:StartPage() 		// Inicia uma nova pagina

// Impressao do cabecalho.

oPrint:SayBitmap(nRow1,nColIni,"\system\logo_alpax.bmp",600,170)
oPrint:Say(nRow1	,nColIni+1600,"Or็amento " + SCJ->CJ_NUM,oFont18N)
oPrint:Say(nRow1+080,nColIni+1700,"Emissao:" + Dtoc(SCJ->CJ_EMISSAO),oFont14N)

oPrint:Say(nRow1+250,nColIni,SM0->M0_NOMECOM																	,oFont11N)
oPrint:Say(nRow1+300,nColIni,SM0->M0_ENDCOB																		,oFont11)
oPrint:Say(nRow1+350,nColIni,Alltrim(SM0->M0_BAIRCOB)+'-'+Alltrim(SM0->M0_CIDCOB)+"-"+SM0->M0_ESTCOB+'-'+;
Transform(SM0->M0_CEPCOB,"@R 99999-999")																,oFont11)
oPrint:Say(nRow1+400,nColIni,"Telefone (11) " + SM0->M0_TEL+'   /   FAX: (11) ' + SM0->M0_FAX					,oFont11)
oPrint:Say(nRow1+450,nColIni,"CNPJ " + Transform(SM0->M0_CGC,"@R 99.999.999/9999-99")							,oFont11)
oPrint:Say(nRow1+450,nColIni+550,"INSC." + Transform(SM0->M0_INSC,"@R 999.999.999.999")						,oFont11)

oPrint:Say(nRow1+250,nColIni+1300,"Representante:"																,oFont11N)
oPrint:Say(nRow1+300,nColIni+1300,SA3->A3_NOME																	,oFont11)
oPrint:Say(nRow1+350,nColIni+1300,SA3->A3_EMAIL																	,oFont11)
oPrint:Say(nRow1+400,nColIni+1300,"Atendente:"																	,oFont11N)
oPrint:Say(nRow1+450,nColIni+1300,UsrRetName(SCJ->CJ_AXATEND)+' - ' + UsrRetMail(SCJ->CJ_AXATEND)				,oFont11)

nRow1 += 500

oPrint:Say(nRow1+050,nColIni,"Faturamento:"																		,oFont10N)
oPrint:Say(nRow1+100,nColIni,SA1->A1_NOME																		,oFont10N)
oPrint:Say(nRow1+150,nColIni,SA1->A1_END																		,oFont10)
oPrint:Say(nRow1+200,nColIni,ALLTRIM(SA1->A1_BAIRRO)+" - "+Alltrim(SA1->A1_MUN)+','+SA1->A1_EST+' '+;
Transform(SA1->A1_CEP,"@R 99999-999")																			,oFont10)
oPrint:Say(nRow1+250,nColIni,"Contato:" + _cContato																,oFont10)
oPrint:Say(nRow1+300,nColIni,"Telefone (" + SA1->A1_DDD + ")" + SA1->A1_TEL + " / " + SA1->A1_FAX				,oFont10)
oPrint:Say(nRow1+350,nColIni,"Email:" + _cEmailCT																,oFont10)
oPrint:Say(nRow1+400,nColIni,"CNPJ:"+IIF(SA1->A1_PESSOA = "F",SA1->A1_CGC,Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")),oFont10)
oPrint:Say(nRow1+400,nColIni+550,"INSC:" +SA1->A1_INSCR 														,oFont10)

oPrint:Say(nRow1+050,nColIni+1300,"Entrega:"																	,oFont10N)
oPrint:Say(nRow1+100,nColIni+1300,SA1->A1_ENDENT																,oFont10)
oPrint:Say(nRow1+150,nColIni+1300,Alltrim(SA1->A1_BAIRROE)+'-'+Alltrim(SA1->A1_MUNE)+'-'+SA1->A1_ESTE+','+SA1->A1_CEPE	,oFont10)
oPrint:Say(nRow1+200,nColIni+1300,"CNPJ:"+IIF(SA1->A1_PESSOA = "F",SA1->A1_CGC,Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")),oFont10)
oPrint:Say(nRow1+200,nColIni+1850,"INSC:" +SA1->A1_INSCR 														,oFont10)

nRow1 += 550
// box dos itens, linhas verticais dos itens e quadro do rodape
oPrint:box(nRow1,ncolIni,nRowFim,ncolFim)
oPrint:box(nRowFim+10,ncolIni,nRowPage,ncolFim)
// Linhas verticais do cabecalho
oPrint:Line(nRow1,nColIni+0400,nRow1+0210,nColIni+0400)
oPrint:Line(nRow1,nColIni+1100,nRow1+0140,nColIni+1100)
oPrint:Line(nRow1,nColIni+1500,nRow1+0140,nColIni+1500)
oPrint:Line(nRow1+0210,nColIni,nRow1+0210,nColIni+0400)
// titulos das linhas
oPrint:Say(nRow1+0020,nColIni+0050,"Pedido Cliente"																	,oFont10N)
oPrint:Say(nRow1+0090,nColIni+0050,"Condi็ใo Pagto."																,oFont10N)
oPrint:Say(nRow1+0160,nColIni+0050,"Observa็ใo"																		,oFont10N)
oPrint:Say(nRow1+0020,nColIni+1150,"Valid.Proposta"																	,oFont10N)
oPrint:Say(nRow1+0090,nColIni+1150,"Frete"																			,oFont10N)
//oPrint:Say(nRow1+0160,nColIni+1150,"Fone Transp."																	,oFont10N)
// Campos do cabecalho nas tabelas ja pre-posicionadas.
oPrint:Say(nRow1+0020,nColIni+0430,QR1->CJ_AXPEDCL																	,oFont10 )
oPrint:Say(nRow1+0020,nColIni+1530,DTOC(QR1->CJ_VALIDA)																,oFont10 )
oPrint:Say(nRow1+0090,nColIni+0430,SE4->E4_DESCRI																	,oFont10 )
oPrint:Say(nRow1+0090,nColIni+1530,iif(QR1->CJ_AXFRETE=="F","FOB","CIF")											,oFont10 )
oPrint:Say(nRow1+0160,nColIni+0430,QR1->CJ_OBSERV1																	,oFont8CN)
oPrint:Say(nRow1+0230,nColIni+0050,QR1->CJ_OBSERV2																	,oFont8CN)

For _nY := 1 to 2
	nRow1 += 070
	oPrint:Line(nRow1,nColIni,nRow1,nColFim)
Next _nY
nRow1 += 070
For _nY := 1 to 2
	nRow1 += 070
	oPrint:Line(nRow1,nColIni,nRow1,nColFim)
Next _nY

// linhas horizontais duplas do titulo.
oPrint:Line(nRow1-65,nColIni,nRow1-65,nColFim)
nRow1 += 5
oPrint:Line(nRow1,nColIni,nRow1,nColFim)
// colunas dos itens
oPrint:Line(nRow1-70,nColIni+0300,nRowfim,nColIni+0300) // codigo
oPrint:Line(nRow1-70,nColIni+1000,nRowfim,nColIni+1000) // descricao
oPrint:Line(nRow1-70,nColIni+1200,nRowfim,nColIni+1200) // entrega
oPrint:Line(nRow1-70,nColIni+1300,nRowfim,nColIni+1300) // UM
oPrint:Line(nRow1-70,nColIni+1430,nRowfim,nColIni+1430) // Qtde
oPrint:Line(nRow1-70,nColIni+1620,nRowfim,nColIni+1620) // Unitario
oPrint:Line(nRow1-70,nColIni+1810,nRowfim,nColIni+1810) // ICMS ST
oPrint:Line(nRow1-70,nColIni+1890,nRowfim,nColIni+1890) // IPI
oPrint:Line(nRow1-70,nColIni+1990,nRowfim,nColIni+1990) // ICMS
// nome das colunas
oPrint:Say(nRow1-050,nColIni+0030,"C๓digo"																			,oCour8N)
oPrint:Say(nRow1-050,nColIni+0330,"Descri็ใo"																		,oCour8N)
oPrint:Say(nRow1-050,nColIni+1020,"Entrega"																			,oCour8N)
oPrint:Say(nRow1-050,nColIni+1220,"U.M."																			,oCour8N)
oPrint:Say(nRow1-050,nColIni+1320,"Qtde."																			,oCour8N)
oPrint:Say(nRow1-050,nColIni+1450,"Unitแrio"																		,oCour8N)
oPrint:Say(nRow1-050,nColIni+1640,"TOTAL"																			,oCour8N)
oPrint:Say(nRow1-050,nColIni+1830,"IPI"																				,oCour8N)
oPrint:Say(nRow1-050,nColIni+1900,"ICMS"																			,oCour8N)
oPrint:Say(nRow1-050,nColIni+2000,"ICMS-ST"																			,oCour8N)

// Rodape (Observacoes Gerais)
oPrint:box(nRowFim+10,ncolIni,nRowPage+60,ncolFim)
oPrint:Line(nRowPage-50,nColIni,nRowPage-50,nColFim)
// linhas verticais da observacao
oPrint:Line(nRowPage-50,nColIni+0550,nRowPage+50,nColIni+0550)
oPrint:Line(nRowPage-50,nColIni+1150,nRowPage+50,nColIni+1150)
oPrint:Line(nRowPage-50,nColIni+1650,nRowPage+50,nColIni+1650)
// titulos do box observacoes
oPrint:Say(nRowFim+030,nColIni+0050,"Observa็๕es Gerais"															,oFont10N)



oPrint:Say(nRowPage+90,nColIni+1900,"Pแgina: "+Alltrim(Str(_nPag))													,oFont12N)

// EDUARDO NAKAMATU / BIALE 11.10.10 COLOCADO GRADE ACESSARIA DE IMPOSTOS

// Retorno da linha inicial de impressao dos itens do orcamento.
_nRet := nRow1+20

Return(_nRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fAliqIcmsบAutor  ณMicrosiga           บ Data ณ  10/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para verificar a aliquota de ICMS.                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fAliqIcms()
Local _nAliq := 0
LOCAL _AIMPS  := {}
/*

Do Case
Case SA1->A1_EST == "SP"
_nAliq = 18
Case SA1->A1_EST $ "MG/PR/RJ/RS/SC"
_nAliq := 12
Otherwise
_nAliq := 7
EndCase
*/
_AIMPS := fatrImp(1)
_nTotLiq := fatrImp(2)

IF ascan(_AIMPS,{|X| X[1] == 'ICM'}) <> 0
	_nAliq := _AIMPS[ascan(_AIMPS,{|X| X[1] == 'ICM' })]
ENDIF

Return({_nAliq,_AIMPS,_nTotLiq})


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fRodape  บAutor  ณConsultoria         บ Data ณ  02/12/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ funcao para impressao do rodape final do relatorio.        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ORCAMENTO                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fRodape(_aMSgTX)

Local _nValPis 		:= 0
Local _nValCofin	:= 0
Local _nTotDesZF	:= 0
//Local _nFrete		:= 0

// Caso seja zona franca de manaus, desconta-se o PIS/COFINS/ICMS da regiao.
If SA1->A1_CODMUN == "00255"
	//	_nTotal		-=  _nTotIcms
	If ! Empty(SA1->A1_SUFRAMA) .And. SA1->A1_RECCOFI <> "S" .And. SA1->A1_RECPIS <> "S"
		_nValPis 	:= _nTotal * (GetMv("MV_TXPIS")/100)
		_nValCofin	:= _nTotal * (GetMv("MV_TXCOFIN")/100)
		_nTotal		-= (_nTotIcms+_nValPis+_nValCofin)
	EndIf
	_nTotDesZF 	:= (_nTotIcms+_nValPis+_nValCofin)
EndIf

_nFrete := SCJ->CJ_FRETE
_nTotal += _nFrete

// salto de linha com 40 pixels cada.
oPrint:Say(nRowFim+080,nColIni+0050,"Faturamento Mํnimo R$."+Getmv("MV_ALFATMIN")							,oFont8CN)
oPrint:Say(nRowFim+120,nColIni+0050,"Prazo de entrega sujeito a confirma็ใo do pedido."						,oFont8CN)
oPrint:Say(nRowFim+160,nColIni+0050,"Favor mencionar n๚mero deste or็amento em seu Pedido;"					,oFont8CN)
oPrint:Say(nRowFim+200,nColIni+0050,"Tamb้m confirmar todos os dados para faturamento/entrega."				,oFont8CN)

If _nTotalSub > 0
	oPrint:Say(nRowFim+240,nColIni+0050,"Valor Substitui็ใo jแ incluso no total do or็amento: R$." + Alltrim(Transform(_nTotalSub,"@e 999,999,999.99"))	,oCour8N)
End

oPrint:Say(nRowPage-40,nColIni+0010,"IPI nao incluso R$."+Alltrim(Transform(_nTotIpi,"@e 999,999.99"))		,oFont10N)

If _nTotDesZF > 0 .Or. _Cocimar = '555'     // ocimar 07/07/09
	If _nIcmsDes > 0
		oPrint:Say(nRowPage-40,nColIni+0600,"Icms Incluso R$."+Alltrim(Transform(_nIcmsDes,"@e 999,999.99"))	,oFont10N)
	Else
		oPrint:Say(nRowPage-40,nColIni+0600,"Icms Incluso R$."+Alltrim(Transform(0,"@e 999,999.99"))			,oFont10N)
	EndIf
Else
	oPrint:Say(nRowPage-40,nColIni+0600,"Icms Incluso R$."+Alltrim(Transform((_nTotIcms+_nIcmsDes),"@e 999,999.99"))	,oFont10N)
EndIf
oPrint:Say(nRowPage-40,nColIni+1200,"Frete R$."+Alltrim(Transform(_nFrete,"@e 999,999.99"))					,oFont10N)

oPrint:Say(nRowPage-40,nColIni+1700,"Total Merc R$."+Alltrim(Transform(_nValLiq,"@e 9,999,999.99"))			,oFont10N)

oPrint:Say(nRowPage+8,nColIni+0600,"Icms St R$."+Alltrim(Transform(_nTotalSub,"@e 999,999.99"))			,oFont10N)

if _nTotDesZF > 0
	oPrint:Say(nRowPage+8,nColIni+1200,   "Desc.Sufr:   R$."+Alltrim(Transform(    _nTotal-_nValLiq+_nVlrSubst+_nTotIpi,"@e 9,999,999.99"))			,oFont10N)
	
endif

//oPrint:Say(nRowPage+8,nColIni+1700,   "Total      R$."+Alltrim(Transform(_nTotal+_nVlrSubst+_nTotIpi,"@e 9,999,999.99"))			,oFont10N)
oPrint:Say(nRowPage+8,nColIni+1700,   "Total      R$."+Alltrim(Transform(_nValLiq+_nTotalSub+_nTotIpi+_nFrete,"@e 9,999,999.99"))			,oFont10N)

// Impressao caso seja Zona Franca de Manaus
If _nTotDesZF > 0
	oPrint:Line(nRowFim+115,nColIni+1250,nRowFim+115,nColIni+1450)
	oPrint:Line(nRowFim+230,nColIni+1250,nRowFim+230,nColIni+1450)
	
	oPrint:Say(nRowFim+060,nColIni+1100,"Descontos Zona Franca Manaus"										,oFont10N)
	oPrint:Say(nRowFim+120,nColIni+1100,"ICMS   "+Transform(_nTotIcms,	"@e 9,999,999.99")					,oFont8CN)
	oPrint:Say(nRowFim+160,nColIni+1100,"PIS    "+Transform(_nValPis,	"@e 9,999,999.99")					,oFont8CN)
	oPrint:Say(nRowFim+200,nColIni+1100,"COFINS "+Transform(_nValCofin,	"@e 9,999,999.99")					,oFont8CN)
	oPrint:Say(nRowFim+240,nColIni+1100,"TOTAL  "+Transform(_nTotDesZF,	"@e 9,999,999.99")					,oFont8CN)
EndIf


nLinX := (nRowFim+200)
For nX := 1 to len(_aMSgTX)
	
	IF alltrim(_aMSgTX[nX,1]) $ "ICC.DIF"
		nLinX := nLinX + 40
		_cMsgTX := _aMSgTX[nX,2]+" Base:"+Transform(_aMSgTX[nX,3],	"@e 9,999,999.99")+" Alq:"+Transform(_aMSgTX[nX,4],	"@e 999.99")+" Vl:"+" Base:"+Transform(_aMSgTX[nX,5],	"@e 9,999,999.99")
		oPrint:Say(nLinX,nColIni+0050,_cMsgTX					,oFont8CN)
	endif
	
Next

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATRIMP   บAutor  ณFernando Nakahara   บ Data ณ  02/02/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera simula็ใo de nota e traz array com valores de impostosบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Or็amento                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณ Retorna array com impostos                                 บฑฑ
ฑฑบ          ณ AIMP[n]                                                    บฑฑ
ฑฑบ          ณAIMP[n][1] Codigo do imposto no Array NF_IMPOSTOS           บฑฑ
ฑฑบ          ณAIMP[n][2] Descricao do imposto no Array NF_IMPOSTOS        บฑฑ
ฑฑบ          ณAIMP[n][3] Base de Calculo do Imposto no Array NF_IMPOSTOS  บฑฑ
ฑฑบ          ณAIMP[n][4] Aliquota de calculo do imposto                   บฑฑ
ฑฑบ          ณAIMP[n][5] Valor do Imposto no Array NF_IMPOSTOS            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fatrImp(_nInfo)

Local aArea		:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
Local aAreaSCK := SCK->(GetArea())
Local aDupl     := {}
Local aVencto   := {}
Local aRentab   := {}
Local nX        := 0
Local nAcerto   := 0
Local nPrcLista := 0
Local nValMerc  := 0
Local nDesconto := 0
Local nAcresFin := 0
Local nQtdPeso  := 0
Local nItem     := 0
Local cParc     := ""
Local dDataCnd  := SCJ->CJ_EMISSAO
Local oDlg
Local oDupl
Local oFolder
Local oRentab
Local AIMPS     := {}

DEFAULT _nInfo := 1

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPosiciona Registros                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SA1")
dbSetOrder(1)
MsSeek(xFilial("SA1")+If(!Empty(SCJ->CJ_CLIENT),SCJ->CJ_CLIENT,SCJ->CJ_CLIENTE)+SCJ->CJ_LOJAENT)

dbSelectArea("SE4")
dbSetOrder(1)
MsSeek(xFilial("SE4")+SCJ->CJ_CONDPAG)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicializa a funcao fiscal                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MaFisSave()
MaFisEnd()
MaFisIni(Iif(Empty(SCJ->CJ_CLIENT),SCJ->CJ_CLIENTE,SCJ->CJ_CLIENT),;// 1-Codigo Cliente/Fornecedor
SCJ->CJ_LOJAENT,;		// 2-Loja do Cliente/Fornecedor
"C",;				// 3-C:Cliente , F:Fornecedor
"N",;				// 4-Tipo da NF
SA1->A1_TIPO,;		// 5-Tipo do Cliente/Fornecedor
Nil,;
Nil,;
Nil,;
Nil,;
"MATA461")

//Na argentina o calculo de impostos depende da serie.
If cPaisLoc == 'ARG'
	MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณAgrega os itens para a funcao fiscal         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SCK")
dbsetorder(1)
dbSEEK(SCJ->(CJ_FILIAL+CJ_NUM))
While ( !Eof() .AND. SCK->(CK_FILIAL+CK_NUM) == SCJ->(CJ_FILIAL+CJ_NUM) )
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Verifica se a linha foi deletada                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If (!Empty(SCK->CK_PRODUTO) )
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณPosiciona Registros                          ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+SCK->CK_PRODUTO))
			nQtdPeso := SCK->CK_QTDVEN*SB1->B1_PESO
		EndIf
		SB2->(dbSetOrder(1))
		SB2->(MsSeek(xFilial("SB2")+SCK->CK_PRODUTO+SCK->CK_LOCAL))
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(xFilial("SF4")+SCK->CK_TES))
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณCalcula o preco de lista                     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		nValMerc  := SCK->CK_VALOR
		nPrcLista := SCK->CK_PRUNIT
		nQtdPeso  := 0
		nItem++
		If ( nPrcLista == 0 )
			nPrcLista := A410Arred(nValMerc/SCK->CK_QTDVEN,"CK_PRCVEN")
		EndIf
		nAcresFin := A410Arred(SCK->CK_PRCVEN*SE4->E4_ACRSFIN/100,"D2_PRCVEN")
		nValMerc  += A410Arred(nAcresFin*SCK->CK_QTDVEN,"D2_TOTAL")
		nDesconto := A410Arred(nPrcLista*SCK->CK_QTDVEN,"D2_DESCON")-nValMerc
		nDesconto := IIf(nDesconto==0,SCK->CK_VALDESC,nDesconto)
		nDesconto := Max(0,nDesconto)
		nPrcLista += nAcresFin
		nValMerc  += nDesconto
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณVerifica a data de entrega para as duplicatasณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		If ( SCK->(FieldPos("CK_ENTREG"))>0 )
			If ( dDataCnd > SCK->CK_ENTREG .And. !Empty(SCK->CK_ENTREG) )
				dDataCnd := SCK->CK_ENTREG
			EndIf
		Else
			dDataCnd  := SCJ->CJ_EMISSAO
		EndIf
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAgrega os itens para a funcao fiscal         ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		MaFisAdd(SCK->CK_PRODUTO,;   	// 1-Codigo do Produto ( Obrigatorio )
		SCK->CK_TES,;	   	// 2-Codigo do TES ( Opcional )
		SCK->CK_QTDVEN,;  	// 3-Quantidade ( Obrigatorio )
		nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
		nDesconto,; 	// 5-Valor do Desconto ( Opcional )
		"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
		"",;				// 7-Serie da NF Original ( Devolucao/Benef )
		0,;					// 8-RecNo da NF Original no arq SD1/SD2
		0,;					// 9-Valor do Frete do Item ( Opcional )
		0,;					// 10-Valor da Despesa do item ( Opcional )
		0,;					// 11-Valor do Seguro do item ( Opcional )
		0,;					// 12-Valor do Frete Autonomo ( Opcional )
		nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
		0)					// 14-Valor da Embalagem ( Opiconal )
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+SCK->CK_PRODUTO))
			nQtdPeso := SCK->CK_QTDVEN*SB1->B1_PESO
		Endif
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณAltera peso para calcular frete              ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		MaFisAlt("IT_PESO",nQtdPeso,nItem)
		MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
		MaFisAlt("IT_VALMERC",nValMerc,nItem)
	EndIf
	dbSelectArea("SCK")
	dbSkip()
EndDo
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณIndica os valores do cabecalho               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
MaFisAlt("NF_FRETE",SCJ->CJ_FRETE)
MaFisAlt("NF_SEGURO",SCJ->CJ_SEGURO)
MaFisAlt("NF_AUTONOMO",SCJ->CJ_FRETAUT)
MaFisAlt("NF_DESPESA",SCJ->CJ_DESPESA)
MaFisAlt("NF_DESCONTO",MaFisRet(,"NF_DESCONTO")+MaFisRet(,"NF_VALMERC")*SCJ->CJ_PDESCAB/100)
MaFisAlt("NF_DESCONTO",MaFisRet(,"NF_DESCONTO")+SCJ->CJ_DESCONT)
MaFisWrite(1)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMonta a tela de exibicao dos valores fiscais ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//MaFisRodape(1,oFolder:aDialogs[1],,{005,001,310,60},Nil,.T.)
if _nInfo <> 2
	AIMPS := MaFisRet(,"NF_IMPOSTOS")
else
	AIMPS := MaFisRet(,"NF_VALMERC")
endif
MaFisEnd()
MaFisRestore()

RestArea(aAreaSCK)
RestArea(aAreaSA1)
RestArea(aArea)
Return AIMPS
