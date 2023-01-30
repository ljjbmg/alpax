/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA018   ºAutor  ³Ocimar Rolli        º Data ³  07/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de Consulta das notas fiscais de saida a partir da   º±±
±±º          ³tabela SD2010                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "TopConn.ch"
#Include "Protheus.ch"

User Function FATA018()

cConsulta := "Consulta Notas Fiscais de Saida"

Private aRotina := { 	{"Pesquisar"			,"AxPesqui"		,0,1} ,;  		// Pesquisa na tabela
                        {"Visualizar"			,"U_FATA018V()" ,0,1} }			// Visualizacao Modelo 2

dbSelectArea("SF2")
//
// Chamada do browse
//
mBrowse( 6,1,22,75,"SF2")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA018V ºAutor  ³Ocimar Rolli         º Data ³  07/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de Visualizacao do cadastro.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

// CRIA TABELA TEMPORARIA PARA VISUALIZACAO

User Function FATA018V()

cQuery := fquery(SF2->F2_TIPO)

TcQuery cQuery new alias "QR1"

TcSetField("QR1","UNITARIO"  ,"N",12,2)
TcSetField("QR1","TOTAL"     ,"N",12,2)
TcSetField("QR1","EMISSAO"   ,"D",08,0)
TcSetField("QR1","QUANTIDADE","N",12,2)
TcSetField("QR1","VALIDADE"  ,"D",08,0)
TcSetField("QR1","NOTA"      ,"C",09,0)
TcSetField("QR1","CLIENTE"   ,"C",75,0)
TcSetField("QR1","CODIGO"    ,"C",06,0)
TcSetField("QR1","VALIPI"    ,"N",12,2)
TcSetField("QR1","SUBTRI"    ,"N",12,2)
TcSetField("QR1","VALMER"    ,"N",12,2)
TcSetField("QR1","VALBRUT"   ,"N",12,2)
TcSetField("QR1","FRETE"     ,"N",12,2)

cCodigo    := QR1->CODIGO
cCliente   := QR1->CLIENTE
cCnpj      := QR1->CNPJ
cAtendente := QR1->ATENDENTE
cVendedor  := QR1->VENDEDOR
cNota      := QR1->NOTA
cSerie     := QR1->SERIE
cEntrega1  := Substr(QR1->ENTREGA,001,075)
cEntrega2  := Substr(QR1->ENTREGA,076,075)
cEmissao   := QR1->EMISSAO
cCodTra    := QR1->CODTRA
cNomTra    := QR1->NOMTRA
cSubTri    := QR1->SUBTRI
cValIpi    := QR1->VALIPI
cValMer    := QR1->VALMER
cValBru    := QR1->VALBRU
cValFre    := QR1->FRETE

// VERIFICA SE TEM COLETA GERADA

SZJ->(DbSetOrder(3))
If SZJ->(DbSeek(xFilial("SZJ")+cNota+cSerie,.T.))
	cDataCha   := SZJ->ZJ_DATACH
	cHoraCha   := SZJ->ZJ_HORACH
	cDataCol   := SZJ->ZJ_DATACOL
	cHoraCol   := SZJ->ZJ_HORACOL
	cMotori    := SZJ->ZJ_MOTORI
	If !EMPTY(SZJ->ZJ_COLETA)
		cColeta    := SZJ->ZJ_COLETA
	Else
		cColeta    := 'C'
	EndIf
Else
	cDataCha   := '        '
	cHoraCha   := '        '
	cDataCol   := '        '
	cHoraCol   := '        '
	cColeta    := 'G'
	cMotori    := '        '
EndIf

// MONTA A TELA

_aCampos	:= {	{"REFERENCIA"      	,,"PART NUMBER"    	,"" 					}	,;
					{"PRODUTO"		    ,,"PRODUTO"			,""	    				}	,;
					{"CAPACIDADE"		,,"CAPACIDADE"	 	,""		    			}	,;
					{"QUANTIDADE"	    ,,"QUANTIDADE"	    ,"@E 999,999.99"		}	,;
					{"UNITARIO"		    ,,"PRECO UNITARIO"	,"@E 999,999.99"		}	,;
					{"TOTAL"	        ,,"VALOR TOTAL"		,"@E 999,999.99"		}	,;
					{"LOTE"		        ,,"LOTE"	 		,""	    				}	,;
					{"VALIDADE"	        ,,"VALIDADE"    	,"" 					}	,;
					{"CFOP"	     	    ,,"CFOP"	 		,""	    				}	,;
					{"NATUREZA"	        ,,"NATUREZA"		,""						}   ,;
					{"PEDIDO"	        ,,"PEDIDO ALPAX"	,""						}   ,;
					{"PEDCLI"           ,,"PEDIDO CLIENTE"	,""						} } 

aCpo       := { {"REFERENCIA","C",len(QR1->REFERENCIA),0},;
      			{"PRODUTO"   ,"C",len(QR1->PRODUTO)   ,0},;
      			{"CAPACIDADE","C",len(QR1->CAPACIDADE),0},;
      			{"QUANTIDADE","N",12                  ,2},;
      			{"UNITARIO"  ,"N",12                  ,2},;
      			{"TOTAL"     ,"N",12                  ,2},;
      			{"LOTE"      ,"C",len(QR1->LOTE)      ,0},;
      			{"VALIDADE"  ,"D",8                   ,0},;
      			{"CFOP"      ,"C",len(QR1->CFOP)      ,0},;
      			{"NATUREZA"  ,"C",len(QR1->NATUREZA)  ,0},;
      			{"PEDIDO"    ,"C",len(QR1->PEDIDO)    ,0},;
      			{"PEDCLI"    ,"C",len(QR1->PEDCLI)    ,0} }
      			
cArqTmp    := CriaTrab(aCpo,.t.)      			
DbUseArea(.t.,,cArqTmp,"TMP",.f.,.f.)

QR1->(DbGoTop()) 
Do While ! QR1->(EOF())
	RecLock("TMP",.t.)
	For c := 1 to len(aCpo)
		cCampo := aCpo[c,1]
		TMP->(&cCampo) := QR1->(&cCampo)
	Next c
	TMP->(MsUnlock())
	QR1->(DbSkip())	
EndDo

TMP->(DbGoTop())
		
aSize := MsAdvSize()
aObjects := {}
AAdd( aObjects, { 100, 070 , .T., .F. } )
AAdd( aObjects, { 100, 030 , .T., .T. } )
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5, 5 }
aPosObj 	:= MsObjSize( aInfo, aObjects,.T.)

DEFINE FONT oFont  NAME "Arial" SIZE 0, -12 BOLD

Define MsDialog _oDlg1 Title OemToAnsi("VISUALIZADOR DE NOTA") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

oSay  := TSay():New( 015, 010, {||"Codigo "} 	 	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 30,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 015, 050, {||cCodigo  } 	  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,, 30,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 015, 100, {||iif(SF2->F2_TIPO $ "DB","Fornecedor ","Cliente ")}	  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 30,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 015, 130, {||cCliente  }         ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,300,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 025, 010, {||"End. Entrega "}	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 025, 050, {||cEntrega1}  	  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,500,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 035, 050, {||cEntrega2}  	  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,500,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 045, 010, {||"Atendente "}       ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 045, 050, {||cAtendente}  	   	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 045, 100, {||"Repres. "}		  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 045, 130, {||cVendedor}  	 	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,140,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 010, {||"Nota Fiscal "}  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 050, {||cNota}	  		  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 100, {||"Serie "}		  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 130, {||cSerie}	  	 	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 180, {||"Emissao "}	  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 230, {||cEmissao}  	 	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)

Do Case
	Case cColeta == "G"
	oSay  := TSay():New( 015, 450, {||"COLETA  NAO  GERADA "}  	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,CLR_RED,,100,10, .F., .F., .F., .F., .F. )
	Case cColeta == "C"
	oSay  := TSay():New( 015, 450, {||"COLETA  NAO  CHAMADA "} 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,CLR_RED,,100,10, .F., .F., .F., .F., .F. )
	Case cColeta <> "G" .And. cColeta <> "C"
	oSay  := TSay():New( 015, 370, {||"Num. Coleta "}  	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,CLR_GREEN,,100,10, .F., .F., .F., .F., .F. )	
	oSay  := TSay():New( 015, 410, {||cColeta} 		 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,         ,,100,10, .F., .F., .F., .F., .F. )		
	oSay  := TSay():New( 015, 460, {||"Data Chamada "} 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,CLR_GREEN,,100,10, .F., .F., .F., .F., .F. )	
	oSay  := TSay():New( 015, 510, {||cDataCha} 	 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,         ,,100,10, .F., .F., .F., .F., .F. )			
	oSay  := TSay():New( 015, 540, {||"Hora Chamada "} 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,CLR_GREEN,,100,10, .F., .F., .F., .F., .F. )	
	oSay  := TSay():New( 015, 590, {||cHoraCha} 	 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,         ,,100,10, .F., .F., .F., .F., .F. )		
	oSay  := TSay():New( 025, 460, {||"Data Coleta "} 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,CLR_GREEN,,100,10, .F., .F., .F., .F., .F. )	
	oSay  := TSay():New( 025, 510, {||cDataCol} 	 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,         ,,100,10, .F., .F., .F., .F., .F. )			
	oSay  := TSay():New( 025, 540, {||"Hora Coleta "} 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,CLR_GREEN,,100,10, .F., .F., .F., .F., .F. )	
	oSay  := TSay():New( 025, 590, {||cHoraCol} 	 	  ,_oDlg1,, oFont   , .F., .F., .F., .T.,         ,,100,10, .F., .F., .F., .F., .F. )		
EndCase

oSay  := TSay():New( 045, 370, {||"Cod. Transp. "} 	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 045, 410, {||cCodTra}	  		  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 045, 460, {||"Motorista "}	  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 045, 590, {||cMotori}  	 	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 370, {||"Transp. "} 		  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 410, {||cNomTra}	  	 	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,300,10,.F.,.F.,.F.,.F.,.F.)

oSay  := TSay():New( 250, 010, {||"Sub. Tributaria "} 					,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 80,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 250, 050, {||Transform(cSubTri,"@e 999,999.99")}	,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 250, 210, {||"Valor da Mercadoria "} 				,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 250, 300, {||Transform(cValMer,"@e 999,999.99")}   ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,300,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 250, 410, {||"Valor do Frete "}    				,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 250, 450, {||Transform(cValFre,"@e 999,999.99")}   ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,300,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 260, 010, {||"IPI "} 								,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 80,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 260, 050, {||Transform(cValIpi,"@e 999,999.99")} 	,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 260, 210, {||"Valor da Nota "}					 	,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 260, 300, {||Transform(cValBru,"@e 999,999.99")}	,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,300,10,.F.,.F.,.F.,.F.,.F.)

//                                             {LS tela meio   ,LE tela meio,LI tela meio   ,LD tela meio} 
oMark := MsSelect():New("TMP","","",_aCampos,,,{aPosObj[2,1]-10,aPosObj[2,2],aPosObj[2,3]-80,aPosObj[2,4]})

ACTIVATE MSDIALOG _oDlg1 ON INIT EnchoiceBar(_oDlg1,{||_oDlg1:End()}, {||_oDlg1:End()},,)

QR1->(DbCloseArea())
TMP->(DbCloseArea())
Ferase(cArqTmp+".dbf")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fquery    ºAutor  ³Microsiga           º Data ³  05/14/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                    

Static Function fquery(cTipo)

If !cTipo $ "D/B"
cQuery  :="SELECT A1_COD AS CODIGO "
cQuery  +=",      A1_NOME AS CLIENTE "
cQuery  +=",      A1_CGC AS CNPJ "
cQuery  +=",      B1_PNUMBER AS REFERENCIA "
cQuery  +=",      B1_DESC AS PRODUTO "
cQuery  +=",      B1_CAPACID AS CAPACIDADE "
cQuery  +=",      D2_QUANT AS QUANTIDADE "
cQuery  +=",      D2_PRCVEN AS UNITARIO "
cQuery  +=",      D2_TOTAL AS TOTAL "
cQuery  +=",      D2_LOTECTL AS LOTE "
cQuery  +=",      D2_DTVALID AS VALIDADE "
cQuery  +=",      D2_CF AS CFOP "
cQuery  +=",      F4_TEXTO AS NATUREZA "
cQuery  +=",      C5_AXATEND AS ATENDENTE "
cQuery  +=",      A3_NOME AS VENDEDOR "
cQuery  +=",      D2_DOC AS NOTA "
cQuery  +=",      D2_SERIE AS SERIE "
cQuery  +=",      C5_AXENDEN AS ENTREGA "
cQuery  +=",      D2_EMISSAO AS EMISSAO "
cQuery  +=",      D2_PEDIDO AS PEDIDO "
cQuery  +=",      C5_AXPEDCL AS PEDCLI "
cQuery  +=",      A4_COD AS CODTRA "
cQuery  +=",      A4_NOME AS NOMTRA "
cQuery  +=",      F2_ICMSRET AS SUBTRI "
cQuery  +=",      F2_VALIPI AS VALIPI "
cQuery  +=",      F2_VALMERC AS VALMER "
cQuery  +=",      F2_VALBRUT AS VALBRU "
cQuery  +=",      F2_FRETE AS FRETE "
cQuery  +=" FROM "+RetSqlName("SD2")+" D2 "
cQuery  +="      INNER JOIN "+RetSqlName("SA1")+" A1 "
cQuery  +="        ON A1_FILIAL = '"+xFilial("SA1")+"' AND D2_CLIENTE = A1_COD "
cQuery  +="      LEFT JOIN "+RetSqlName("SB1")+" B1 "
cQuery  +="        ON B1_FILIAL = '"+xFilial("SB1")+"' AND D2_COD = B1_COD "
cQuery  +="      LEFT JOIN "+RetSqlName("SC5")+" C5 "
cQuery  +="        ON C5_FILIAL = '"+xFilial("SC5")+"' AND D2_PEDIDO = C5_NUM "
cQuery  +="      LEFT JOIN "+RetSqlName("SA3")+" A3 "
cQuery  +="        ON A3_FILIAL = '"+xFilial("SA3")+"' AND C5_VEND1 = A3_COD "
cQuery  +="      LEFT JOIN "+RetSqlName("SF4")+" F4 "
cQuery  +="        ON F4_FILIAL = '"+xFilial("SF4")+"' AND D2_TES = F4_CODIGO "
cQuery  +="      LEFT JOIN "+RetSqlName("SF2")+" F2 "
cQuery  +="        ON D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE "
cQuery  +="      LEFT JOIN "+RetSqlName("SA4")+" A4 "
cQuery  +="        ON F2_TRANSP = A4_COD "
cQuery  +="          WHERE D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery  +="                AND   D2_DOC = '"+SF2->F2_DOC+"' "
cQuery  +="                AND   D2_SERIE = '"+SF2->F2_SERIE+"' AND F2_TIPO NOT IN ('D','B') "
cQuery  +="                AND   D2.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' AND A3.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "
cQuery  +="                AND   C5.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' " 
Else
cQuery  :="SELECT A2_COD AS CODIGO "
cQuery  +=",      A2_NOME AS CLIENTE "
cQuery  +=",      A2_CGC AS CNPJ "
cQuery  +=",      B1_PNUMBER AS REFERENCIA "
cQuery  +=",      B1_DESC AS PRODUTO "
cQuery  +=",      B1_CAPACID AS CAPACIDADE "
cQuery  +=",      D2_QUANT AS QUANTIDADE "
cQuery  +=",      D2_PRCVEN AS UNITARIO "
cQuery  +=",      D2_TOTAL AS TOTAL "
cQuery  +=",      D2_LOTECTL AS LOTE "
cQuery  +=",      D2_DTVALID AS VALIDADE "
cQuery  +=",      D2_CF AS CFOP "
cQuery  +=",      F4_TEXTO AS NATUREZA "
cQuery  +=",      C5_AXATEND AS ATENDENTE "
cQuery  +=",      A3_NOME AS VENDEDOR "
cQuery  +=",      D2_DOC AS NOTA "
cQuery  +=",      D2_SERIE AS SERIE "
cQuery  +=",      C5_AXENDEN AS ENTREGA "
cQuery  +=",      D2_EMISSAO AS EMISSAO "
cQuery  +=",      D2_PEDIDO AS PEDIDO "
cQuery  +=",      C5_AXPEDCL AS PEDCLI "
cQuery  +=",      A4_COD AS CODTRA "
cQuery  +=",      A4_NOME AS NOMTRA "
cQuery  +=",      F2_ICMSRET AS SUBTRI "
cQuery  +=",      F2_VALIPI AS VALIPI "
cQuery  +=",      F2_VALMERC AS VALMER "
cQuery  +=",      F2_VALBRUT AS VALBRU " 
cQuery  +=",      F2_FRETE AS FRETE "
cQuery  +=" FROM "+RetSqlName("SD2")+" D2 "
cQuery  +="      INNER JOIN "+RetSqlName("SA2")+" A2 "
cQuery  +="        ON A2_FILIAL = '"+xFilial("SA2")+"' AND D2_CLIENTE = A2_COD "
cQuery  +="      LEFT JOIN "+RetSqlName("SB1")+" B1 "
cQuery  +="        ON B1_FILIAL = '"+xFilial("SB1")+"' AND D2_COD = B1_COD "
cQuery  +="      LEFT JOIN "+RetSqlName("SC5")+" C5 "
cQuery  +="        ON C5_FILIAL = '"+xFilial("SC5")+"' AND D2_PEDIDO = C5_NUM "
cQuery  +="      LEFT JOIN "+RetSqlName("SA3")+" A3 "
cQuery  +="        ON A3_FILIAL = '"+xFilial("SA3")+"' AND C5_VEND1 = A3_COD AND A3.D_E_L_E_T_ = ' '  "
cQuery  +="      LEFT JOIN "+RetSqlName("SF4")+" F4 "
cQuery  +="        ON F4_FILIAL = '"+xFilial("SF4")+"' AND D2_TES = F4_CODIGO "
cQuery  +="      LEFT JOIN "+RetSqlName("SF2")+" F2 "
cQuery  +="        ON D2_DOC = F2_DOC AND D2_SERIE = F2_SERIE AND F2_TIPO IN ('D','B')"
cQuery  +="      LEFT JOIN "+RetSqlName("SA4")+" A4 "
cQuery  +="        ON F2_TRANSP = A4_COD "
cQuery  +="          WHERE D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery  +="                AND   D2_DOC = '"+SF2->F2_DOC+"' "
cQuery  +="                AND   D2_SERIE = '"+SF2->F2_SERIE+"' "
cQuery  +="                AND   D2.D_E_L_E_T_ = ' ' AND A2.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' "
cQuery  +="                AND   C5.D_E_L_E_T_ = ' ' AND F4.D_E_L_E_T_ = ' ' "
EndIf
Return(cQuery)