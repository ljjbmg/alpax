#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.CH" 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TESTA     							 º Data ³  00/08/21   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ MarkBrowse com filtro de sugestão de compras               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/////////////////////////
// Conferencia Manual 
/////////////////////////

User Function SugCompra()
STATIC _CONFGRV := ''

U_TESTA03(1)

Return

///////////////////////////
// Estorno de Conferencia
///////////////////////////

User Function TESTA03b()

U_TESTA03(2)

Return

/////////////////////////
// Rotina
/////////////////////////

User Function TESTA03(_nTipo)

Local _nX

Private _cMarca  := GetMark()
Private cCadastro:= IIf(_nTipo=1,"Pedidos somente com bloqueio do conferente",;
"Pedidos para estorno de conferencia")
Private cDelFunc := ".T."
Private cString:="SC9"
Private _lFiltra:=.f.
Private _cOper
Private _lSair:=.f.
Private cQueryCad := ""
Private aFields := {}
Private cArq    := ""
Private _nCount := 0
Private _cCampos  := "B1_COD,B1_DESC,B1_MARCA,B1_EMIN,C9_QTDLIB,B1_COD,B2_SALPEDI,B2_SALPEDI, B2_SALPEDI, B2_SALPEDI"
//Private _cCampos  := "C9_PEDIDO,C9_ITEM,C9_SEQUEN,C9_ORDSEP,B1_CODBAR,C6_DESCRI,C9_QTDLIB,C9_PRODUTO,C9_CLIENTE,C9_DATALIB,C5_VEND1,B1_COD"
Private _aArqSel  := {'SB2','SC6','SC9','SB1'}
Private _cArqSel2 := RetSqlName("SC5")+" , "+;
RetSqlName("SC6")+" , "+;
RetSqlName("SC9")+" , "+;
RetSqlName("SB1")+"  "
Private _cOrdem   := ''
Private _cPesqPed := Space(6)
Private _cConfe   := Space(15)
Private _nqtde := 0

@ 100,005 TO 500,760 DIALOG oDlgPedL TITLE cCadastro
aCampos := {}
DbSelectArea('SX3')
DbSetOrder(1)
AADD(aCampos,{'000','C9_OK','',''})
For _nX := 1 To Len(_aArqSel)
	DbSeek(_aArqSel[_nX])
	While !Eof() .And. X3_ARQUIVO = _aArqSel[_nX]
		If ALLTRIM(X3_CAMPO) $ _cCampos
			AADD(aCampos,{StrZero(AT(ALLTRIM(X3_CAMPO),_cCampos),3,0),Alltrim(X3_CAMPO),Alltrim(X3_TITULO),If(X3_TIPO='N',X3_PICTURE,'')})
		Endif
		DbSkip()
	EndDo
Next
ASort(aCampos,,,{|x,y|x[1]<y[1]})

aCampos2 := {}
For _nX := 1 To Len(aCampos)
	AADD(aCampos2,{aCampos[_nX,2],aCampos[_nX,3],aCampos[_nX,4]})
Next
aCampos := {}
aCampos := aCampos2
Cria_TC9()
DbSelectArea('TC9')
@ 006,005 TO 190,325 BROWSE "TC9" MARK "C9_OK" FIELDS aCampos Object _oBrwPed
@ 006,330 BUTTON IIf(_nTipo=1,"_Confere","_Estorna")    SIZE 45,15 ACTION Confirma(_nTipo)
@ 026,330 BUTTON "_Marca/Desmarca" SIZE 45,15 ACTION MarcaPed()
@ 046,330 BUTTON "Pesquisa " SIZE 45,15 ACTION PesqPC()
@ 066,330 BUTTON "V. Marcados" SIZE 45,15 ACTION ViewMark()
If  (Upper(Rtrim(CUSERNAME)) $ Upper(Alltrim(SuperGetMv('MV_USUESTL',.F.,"Administrador"))))
//If (Upper(Rtrim(CUSERNAME)) $ Upper(Alltrim(SuperGetMv('MV_USUESTL',.F.,"Administrador"))))
	@ 086,330 BUTTON "_Ajuste Volume"          SIZE 40,15 ACTION AjustPed()
Endif
@ 183,330 BUTTON "_Sair"                       SIZE 40,15 ACTION Close(oDlgPedL)

Processa({|| Monta_TC9(_nTipo) } ,"Selecionando Informacoes dos Pedidos...")


@ 193,005 SAY "Foram processados "+Alltrim(Str(_nCount,6,0))+" registro(s)"
@ 193,105 SAY Alltrim(Str(_nqtde,6,0))+" PECA(s)"

ACTIVATE DIALOG oDlgPedL CENTERED

DbSelectArea("TC9")
DbCloseArea()
FErase(cArq+OrdBagExt())

Return(.T.)
                    
Static Function ViewMark()
Local _aTC9OK 	:= {}
Local _CHR 		:= CHR(10)+CHR(13)
Local _cMSG 	:= ''
Local _ContLin	:= 1
TC9->(DBgotop())
While TC9->(!EOF())
	If IsMark("C9_OK") 
			
			nTPBX := ASCAN(_aTC9OK, {|x| x[1] == TC9->C9_PEDIDO}) 
			If nTPBX == 0
				AADD(_aTC9OK,{TC9->C9_PEDIDO,TC9->C9_QTDLIB})
			Else 
				_aTC9OK[nTPBX][2]:=_aTC9OK[nTPBX][2]+TC9->C9_QTDLIB
			Endif	
	Endif
TC9->(dbskip())
Enddo

_cMSG := "Pedidos Marcados: " +_CHR

IF LEN(_aTC9OK) > 0
	For x:=1 to LEN(_aTC9OK)
		
           	If _ContLin == 1 
           	_cMSG += _aTC9OK[x][1]+' Qtd. Itens ->'+Alltrim(STR(_aTC9OK[x][2]))  	
           	_ContLin := _ContLin + 1
           	
           	elseif _ContLin < 3
           	_cMSG += ', '+SPACE(05)+_aTC9OK[x][1]+' Qtd. Itens ->'+Alltrim(STR(_aTC9OK[x][2]))
           	_ContLin := _ContLin + 1
           	
           	elseif _ContLin = 3
           	_cMSG += ', '+SPACE(05)+_aTC9OK[x][1]+' Qtd. Itens ->'+Alltrim(STR(_aTC9OK[x][2]))+_CHR
           	_ContLin := 1
           	Endif	
        
	next x
	MSGINFO(_cMSG)
Else
	ALERT('Não há pedido marcado','Visualização de Pedido')
Endif
TC9->(DBgotop())
_cMSG:= ''
Return
******************************************************
Static FUNCTION Confirma(_nTipoPar)

_lLib := .F.
_cPed := ''
_cOper:= If(_nTipoPar=1,'Conferencia','Estorno')
If !MsgYesNo('Confirma a '+If(_nTipoPar=1,'liberacao','estorno')+' dos pedidos marcados ?')
	Return(.T.)
Endif
DbSelectArea("SC5")
DbSetOrder(1)                                        
DbSelectArea("SC6")
DbSetOrder(1)
DbSelectArea('SC9')
DbSetOrder(1)
DbSelectArea('TC9')
DbGoTop()
While !Eof()
	If IsMark("C9_OK") 
		DbSelectArea('SC9')
		If DbSeek(xFilial('SC9')+TC9->C9_PEDIDO+TC9->C9_ITEM+TC9->C9_SEQUEN)
			While !Eof() .And. TC9->C9_PEDIDO+TC9->C9_ITEM+TC9->C9_SEQUEN = SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_SEQUEN
				If !Empty(SC9->C9_CARGA) .And. _nTipoPar<>1
					MsgStop('Pedido: '+TC9->C9_PEDIDO+' nao pode ser Estornado, pois esta na carga: '+SC9->C9_CARGA+' Contacte Depto Logistica.')
					Return(.T.)
				Endif
				If ALLTRIM(SC9->C9_BLEST) = ''
					If !Empty(SC9->C9_ORDSEP) //Trataemnto - Gravacao de flag de conferencia apenas para quem tem Ordem de Separacao
						RecLock('SC9',.F.)
						SC9->C9_BLCONF := IIf(_nTipoPar=1,'OK','')
						SC9->C9_CONFERE:= Upper(Rtrim(_cConfe))+" "+RTRIM(_cOper)+" "+dtoc(date())+" "+time()+" h"					
						MsUnLock()
						_lLib := .T.
					/*	
						If SC6->(DbSeek(xFilial('SC6')+TC9->C9_PEDIDO+TC9->C9_ITEM+TC9->C9_PRODUTO)) // Em fase de testes Rodolfo 22/11/11
							RecLock('SC6',.F.)
							   SC6->C6_CONFERE := Upper(Rtrim(_cConfe))+" "+RTRIM(_cOper)+" "+dtoc(date())+" "+time()+" h"
							MsUnLock()
						Endif
					*/	
						If _cPed <> TC9->C9_PEDIDO 
							If SC5->(DbSeek(xFilial('SC5')+TC9->C9_PEDIDO))
								RecLock('SC5',.F.)
								SC5->C5_XSTATUS := IIf(_nTipoPar=1,"X","T")
								MsUnLock()
							Endif                  
							If _nTipoPar = 1
								BuscaPed(TC9->C9_PEDIDO)
							Endif
							_cPed := TC9->C9_PEDIDO
						Endif
						IF TC9->(TC9->C9_PEDIDO) == _CONFGRV .or. _nTipoPar=2
							RecLock('TC9',.F.)
								DbDelete()
							MsUnlock()
						ENDIF
						Exit
					Endif
				EndIf
				DbSkip()
			EndDo
		Endif
		DbSelectArea('TC9')
	EndIf
	DbSkip()
EndDo

If _lLib
	MsgBox(If(_nTipoPar=1,'Liberacoes','Estornos')+' efetuadas com sucesso !','Conferencia','INFO')
	DbGoTop()
	SysRefresh()
	
	//Grava log de interação com pedido de venda
	If _nTipoPar==1
		U_GRVZZ2(_cPed,__cUserId,cUserName,date(),TIME(),"X","Realizada a Conferencia Manual")
	Else
		U_GRVZZ2(_cPed,__cUserId,cUserName,date(),TIME(),"X","Realizado Estorno da Conferencia Manual")
		
	ENDIF
Else
//	MsgStop('Nenhum pedido marcado para '+If(_nTipoPar=1,'liberacao !','estorno !'))
	MsgStop('Nenhum pedido marcado para '+If(_nTipoPar=1,'liberacao ou pedido sem ordem de separacao!','estorno !'))
	DbGoTop()
Endif
Return(.T.)

******************************************
Static Function MarcaPed()

Local lOrdsep := .T.

DbSelectArea('TC9')
_cPedCorr := TC9->C9_PEDIDO
_nRec := Recno()
While !Eof() .And. TC9->C9_PEDIDO = _cPedCorr
	RecLock('TC9',.F.)
	//Tiago Dantas da Cruz - 22/10/2013
	If !Empty(TC9->C9_ORDSEP)
		TC9->C9_OK := IIf(IsMark("C9_OK"),ThisMark(),_cMarca)
	Else
		lOrdsep := .F.
	EndIf	
	MsUnlock()
	DbSkip()
EndDo

If !lOrdsep
	MsgInfo('Existem itens sem ordem de separação,'+chr(13)+chr(10)+;
	'estes itens não foram selecionados !','Atenção')	
EndIf

DbGoTo(_nRec)
SysRefresh()
DlgRefresh(oDlgPedL)
Return(.T.)

******************************************************
Static FUNCTION Cria_TC9()
Local _nX

DbSelectArea('SX3')
DbSetOrder(1)
AADD(aFields,{"C9_OK"     ,"C",02,0})
For _nX := 1 To Len(_aArqSel)
	DbSeek(_aArqSel[_nX])
	While !Eof() .And. X3_ARQUIVO = _aArqSel[_nX]
		If ALLTRIM(X3_CAMPO) $ _cCampos
			AADD(aFields,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL})
		Endif
		DbSkip()
	EndDo
Next
cArq:=Criatrab(aFields,.T.)
DBUSEAREA(.t.,,cArq,"TC9")
Return

********************************************
Static Function Monta_TC9(_nTipoPar)
Local _nX
Local _cPedFil := Space(6)
               
_nCount := 0
_nCount2:= 0
_nCount3:= 0
_nqtde:=0

    BeginSql Alias cAliasMkb
    
        column D1_EMISSAO as Date
    
        SELECT
        CodProduto	= B1_COD,
        DesProduto	= B1_DESC,
        MarProduto	= B1_MARCA,
        PontoPedido	= B1_EMIN,
        Estoque		= B2_QATU,
        PedLiberado = PED_LIB,
        PedCompra	= PED_COMPRA,
        SugCompra	= SUGESTAO_COMPRA,
        Giro3		= Giro3meses,
        Giro6		= Giro6meses,
        Giro12		= Giro12meses

        FROM ( SELECT
                B1_COD,
                B1_DESC,
                B1_MARCA,
                B1_EMIN,
                B2_QATU,
                SUM(C9_QTDLIB) AS 'PED_LIB', 
                B2_SALPEDI AS 'PED_COMPRA',
                (B1_EMIN - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI) AS 'SUGESTAO_COMPRA',
                Isnull((
                SELECT 
                SUM(D2_QUANT) 
                FROM	%Table:SD2% SD2 (NOLOCK) WHERE D2_COD = B1_COD AND 
                        SD2.%NotDel% AND 
                        D2_TES = F4_CODIGO AND 
                        CONVERT(DATE,D2_EMISSAO,103) BETWEEN 
                        DateAdd(mm, DateDiff(mm,0,GetDate()) - 3, 0) AND 
                        DateAdd(mm, DateDiff(mm,0,GetDate()), -1) 
                ),0) Giro3meses,
                Isnull((
                SELECT 
                SUM(D2_QUANT) 
                FROM	%Table:SD2% SD2 (NOLOCK) WHERE D2_COD = B1_COD AND 
                        SD2.%NotDel% AND  
                        D2_TES = F4_CODIGO AND 
                        CONVERT(DATE,D2_EMISSAO,103) BETWEEN 
                        DateAdd(mm, DateDiff(mm,0,GetDate()) - 6, 0) AND 
                        DateAdd(mm, DateDiff(mm,0,GetDate()), -1) 
                ),0) Giro6meses,
                        Isnull((
                SELECT 
                SUM(D2_QUANT) 
                FROM	%Table:SD2% SD2 (NOLOCK) WHERE D2_COD = B1_COD AND 
                        SD2.%NotDel% AND 
                        D2_TES = F4_CODIGO AND 
                        CONVERT(DATE,D2_EMISSAO,103) BETWEEN 
                        DateAdd(mm, DateDiff(mm,0,GetDate()) - 12, 0) AND 
                        DateAdd(mm, DateDiff(mm,0,GetDate()), -1) 
                ),0) Giro12meses
            FROM %Table:SC9% C9 (NOLOCK)
                        INNER JOIN %Table:SB1% B1 (NOLOCK)
                            ON B1_FILIAL = ''  AND B1_COD = C9_PRODUTO AND SB1.%NotDel% 
                        INNER JOIN %Table:SB2% B2 (NOLOCK)
                            ON B2_FILIAL = '02' AND B2_COD = C9_PRODUTO AND B2_LOCAL = C9_LOCAL  
                            AND SB2.%NotDel% 
                        INNER JOIN %Table:SC6% SC6 (NOLOCK)
                            ON C9_PEDIDO = C6_NUM AND C9_ITEM = C6_ITEM	
                        INNER JOIN %Table:SF4% F4 (NOLOCK)
                            ON C6_TES = F4_CODIGO 
            WHERE C9_FILIAL = '02' AND B2_LOCAL = '01'  AND C9_NFISCAL = ' ' 
                    AND SC9.%NotDel% AND F4_ESTOQUE = 'S' 
        GROUP BY  B1_DESC,  B1_MARCA, B1_EMIN, B2_QATU, B2_SALPEDI, B1_COD , F4_CODIGO
            HAVING (B1_EMIN - B2_QATU + SUM(C9_QTDLIB)- B2_SALPEDI) > 0 

        ) F
        ORDER BY CodProduto 
   EndSql

   aSql := GetLastQuery()
   cSql := aSql[2]
   MemoWrite("\queries\mkbrwse.sql",cSql)

    ProcRegua(_nCount)

    While (cAliasMkb)->(!EOF())
	    IncProc()
	    RecLock("TC9",.T.)
	For _nX := 1 To Len(aFields)
		If aFields[_nX,1] <> 'C9_OK'
			If aFields[_nX,2] = 'C'
				_cX := 'TC9->'+aFields[_nX,1]+' := Alltrim((cAliasMkb)->'+aFields[_nX,1]+')'
			Else
				_cX := 'TC9->'+aFields[_nX,1]+' := (cAliasMkb)->'+aFields[_nX,1]
			Endif
			_cX := &_cX
		Endif
	Next
	TC9->C9_OK := ThisMark()
	MsUnLock()
	CAD->(dBSkip())
EndDo
Dbselectarea("CAD")
DbCloseArea()
Dbselectarea("TC9")
DbGoTop()

_cIndex:=Criatrab(Nil,.F.)
_cChave:="C9_PEDIDO+C9_ITEM+C9_SEQUEN"
Indregua("TC9",_cIndex,_cChave,,,"Ordenando registros selecionados...")
DbSetIndex(_cIndex+ordbagext())

SysRefresh()
Return

Static Function AjustPed()

Private oLocal
Private _PV  := Space(6)
DEFINE MSDIALOG oLocal FROM 63,181 TO 310,440 TITLE "Informe o Pedido " PIXEL
	@ 003,005 TO 095,105//090,105
	@ 005,007 SAY "PEDIDO: "  SIZE  60, 7
	@ 005,040 GET _PV F3 'SC5' SIZE  39, 9
	DEFINE SBUTTON FROM 095,010 TYPE 1 ACTION {||BSCPED(_PV),Close(oLocal)}   ENABLE OF oLocal
	DEFINE SBUTTON FROM 095,070 TYPE 2 ACTION {||Close(oLocal)} ENABLE OF oLocal
	ACTIVATE MSDIALOG oLocal CENTER


return
Static Function BSCPED(_cPed)

Private oLocal
Private _cVolume := Space(5)
Private _nPesol  := 0
Private _nPbruto := 0
Private _nCubagem:= 0
Private _dDtSaida:= CTOD('')
Private _cPedido := _cPed
Private _cTransp := ""
Private _cNota   := ""


////////////////////////////////////

DbSelectArea('SC5')
DbSetOrder(1)
If DbSeek(xFilial('SC5')+_cPedido)
	_cVolume := Str(SC5->C5_VOLUME1,5)
	_nPesol  := SC5->C5_PESOL
	_nPbruto := SC5->C5_PBRUTO
	_cTransp := SC5->C5_TRANSP
	_dDtSaida:= cTod("")           //SC5->C5_YDTFAT
	_cNota   := SC5->C5_NOTA       //SC5->C5_YNOTA
	
	DEFINE MSDIALOG oLocal FROM 63,181 TO 280,390 TITLE "Altera Volume" PIXEL
	@ 003,005 TO 090,105
	@ 013,007 SAY "Pedido:" SIZE  60, 7
	@ 012,055 SAY _cPedido Picture "XXXXXX" SIZE  29, 9 
	@ 023,007 SAY "Qtde de Volumes:" SIZE  60, 7
	@ 022,055 GET _cVolume  SIZE  39, 9
	@ 033,007 SAY "Peso Liquido:" SIZE  60, 7
	@ 032,055 GET _nPesol PICTURE "@E 999,999.99"  SIZE  39, 9
	@ 043,007 SAY "Peso Bruto:" SIZE  60, 7
	@ 042,055 GET _nPbruto PICTURE "@E 999,999.99"  SIZE  39, 9
	@ 063,007 SAY "Transp.   :"  SIZE  60, 7
	@ 062,055 GET _cTransp  F3 "SA4"  SIZE  39, 9 
	@ 073,007 SAY "Dt.Saida  :" SIZE  60, 7
	@ 072,055 GET _dDtSaida  SIZE  39, 9
	DEFINE SBUTTON FROM 095,010 TYPE 1 ACTION {||Grava(),Close(oLocal)} ENABLE OF oLocal
	DEFINE SBUTTON FROM 095,070 TYPE 2 ACTION Close(oLocal) ENABLE OF oLocal 
	ACTIVATE MSDIALOG oLocal CENTER
Endif
IF _CONFGRV == TC9->C9_PEDIDO
If (val(_cVolume)+_nPesol+_nPbruto) >0 .And. SUPERGETMV('MV_IMPETIC',.F.,'S')='S' .And. MsgYesNo("Confirma a emissao de Etiquetas?")  
	_nEtiIni := 1
	DEFINE MSDIALOG oImpEti FROM 63,181 TO 190,390 TITLE "Conferencia" PIXEL
	@ 003,005 TO 035,105
	@ 013,007 SAY "Etiqueta Inicial:" SIZE  60, 7
	@ 013,085 SAY "/"+_cVolume SIZE  20, 7
	@ 012,050 GET _nEtiIni PICTURE "9999" SIZE  30, 9           
	@ 023,007 SAY "Nota Fiscal:" SIZE  60, 7
	@ 022,050 GET _cNota         SIZE  50, 9           
	DEFINE SBUTTON FROM 050,038 TYPE 1 ACTION Close(oImpEti) ENABLE OF oImpEti
	ACTIVATE MSDIALOG oImpEti CENTER
	If MsgYesNo("Responda SIM para Impressora Argox e NAO para Impressora Zebra")
		U_NESTR01(_cPedido,Val(_cVolume),_cConfe,_nEtiIni,_cNota)
	Else
		U_NESTR01b(_cPedido,Val(_cVolume),_cConfe,_nEtiIni,_cNota)	
	Endif
Endif
ENDIF
nQLIB := 0
Return(.T.)

Static Function BuscaPed(_cPed)

Private oLocal
Private _cVolume := Space(5)
Private _nPesol  := 0
Private _nPbruto := 0
Private _nCubagem:= 0
Private _dDtSaida:= CTOD('')
Private _cPedido := IIf(_cPed=nil,Space(6),_cPed)
Private _cTransp := ""
Private _cNota   := ""


////////////iNFORMA A QTD DE ITENS
_ATC9 := TC9->(GETAREA())
TC9->(DBGOTOP())
nQLIB := 0
WHILE TC9->(!eof()) 
	If TC9->C9_PEDIDO == _cPedido

		nQLIB := nQLIB + TC9->C9_QTDLIB
	Endif
TC9->(DBSKIP())
ENDDO
RESTAREA(_ATC9) 

////////////////////////////////////


DbSelectArea('SC5')
DbSetOrder(1)
If DbSeek(xFilial('SC5')+_cPedido)
	_cVolume := Str(SC5->C5_VOLUME1,5)
	_nPesol  := SC5->C5_PESOL
	_nPbruto := SC5->C5_PBRUTO
	_cTransp := SC5->C5_TRANSP
	_dDtSaida:= cTod("")           //SC5->C5_YDTFAT
	_cNota   := SC5->C5_NOTA       //SC5->C5_YNOTA
	
	DEFINE MSDIALOG oLocal FROM 63,181 TO 310,440 TITLE "Pedido: "+_cPedido PIXEL
	@ 003,005 TO 095,105//090,105
	@ 005,007 SAY "PEDIDO: "+_cPedido  SIZE  60, 7
	@ 013,007 SAY "Qtd. Itens Lib.: "+CVALTOCHAR(nQLIB)  SIZE  60, 7
	@ 023,007 SAY "Qtde de Volumes:" SIZE  60, 7
	@ 022,055 GET _cVolume SIZE  39, 9
	@ 033,007 SAY "Peso Liquido:" SIZE  60, 7
	@ 032,055 GET _nPesol PICTURE "@E 999,999.99" SIZE  39, 9
	@ 043,007 SAY "Peso Bruto:" SIZE  60, 7
	@ 042,055 GET _nPbruto PICTURE "@E 999,999.99" SIZE  39, 9
	@ 063,007 SAY "Transp.   :"  SIZE  60, 7
	@ 062,055 GET _cTransp  F3 "SA4" When .F. SIZE  39, 9
	@ 073,007 SAY "Dt.Saida  :" SIZE  60, 7
	@ 072,055 GET _dDtSaida  SIZE  39, 9
	
	DEFINE SBUTTON FROM 095,010 TYPE 1 ACTION {||Grava(),Close(oLocal)}   ENABLE OF oLocal
	DEFINE SBUTTON FROM 095,070 TYPE 2 ACTION {||CANCSC9(),Close(oLocal)} ENABLE OF oLocal
	ACTIVATE MSDIALOG oLocal CENTER
ElseIf Empty(_cPedido) .And. (Upper(Rtrim(CUSERNAME)) $ Upper(Alltrim(SuperGetMv('MV_USUESTL',.F.,"Administrador"))))
	DEFINE MSDIALOG oLocal FROM 63,181 TO 280,390 TITLE "Altera Volume" PIXEL
	@ 003,005 TO 090,105
	@ 013,007 SAY "Informe o Pedido:" SIZE  60, 7
	@ 012,055 GET _cPedido Picture "XXXXXX" SIZE  29, 9 Valid(BuscaPed2(_cPedido))
	@ 023,007 SAY "Qtde de Volumes:" SIZE  60, 7
	@ 022,055 GET _cVolume When .F. SIZE  39, 9
	@ 033,007 SAY "Peso Liquido:" SIZE  60, 7
	@ 032,055 GET _nPesol PICTURE "@E 999,999.99" When .F. SIZE  39, 9
	@ 043,007 SAY "Peso Bruto:" SIZE  60, 7
	@ 042,055 GET _nPbruto PICTURE "@E 999,999.99" When .F. SIZE  39, 9
	@ 063,007 SAY "Transp.   :"  SIZE  60, 7
	@ 062,055 GET _cTransp  F3 "SA4" When .F. SIZE  39, 9 
	@ 073,007 SAY "Dt.Saida  :" SIZE  60, 7
	@ 072,055 GET _dDtSaida  SIZE  39, 9
	DEFINE SBUTTON FROM 095,010 TYPE 1 ACTION {||Grava(),Close(oLocal)} ENABLE OF oLocal
	DEFINE SBUTTON FROM 095,070 TYPE 2 ACTION Close(oLocal) ENABLE OF oLocal 
	ACTIVATE MSDIALOG oLocal CENTER
Endif
IF _CONFGRV == TC9->C9_PEDIDO
If (val(_cVolume)+_nPesol+_nPbruto) >0 .And. SUPERGETMV('MV_IMPETIC',.F.,'S')='S' .And. MsgYesNo("Confirma a emissao de Etiquetas?")  
	_nEtiIni := 1
	DEFINE MSDIALOG oImpEti FROM 63,181 TO 190,390 TITLE "Conferencia" PIXEL
	@ 003,005 TO 035,105
	@ 013,007 SAY "Etiqueta Inicial:" SIZE  60, 7
	@ 013,085 SAY "/"+_cVolume SIZE  20, 7
	@ 012,050 GET _nEtiIni PICTURE "9999" SIZE  30, 9           
	@ 023,007 SAY "Nota Fiscal:" SIZE  60, 7
	@ 022,050 GET _cNota         SIZE  50, 9           
	DEFINE SBUTTON FROM 050,038 TYPE 1 ACTION Close(oImpEti) ENABLE OF oImpEti
	ACTIVATE MSDIALOG oImpEti CENTER
	If MsgYesNo("Responda SIM para Impressora Argox e NAO para Impressora Zebra")
		U_NESTR01(_cPedido,Val(_cVolume),_cConfe,_nEtiIni,_cNota)
	Else
		U_NESTR01b(_cPedido,Val(_cVolume),_cConfe,_nEtiIni,_cNota)	
	Endif
Endif
ENDIF
nQLIB := 0
Return(.T.)

Static Function BuscaPed2(_cPedido)
DbSelectArea("SC5")
DbSetOrder(1)
If !DbSeek(xFilial('SC5')+_cPedido)
	MsgStop('Pedido nao encontrado')
	Return(.F.)
Endif                     

_cVolume := Str(SC5->C5_VOLUME1,5)
_nPesol  := SC5->C5_PESOL
_nPbruto := SC5->C5_PBRUTO
_cTransp := SC5->C5_TRANSP
_dDtSaida:= cTod("")            //SC5->C5_YDTFAT
_cNota   := SC5->C5_NOTA        //SC5->C5_YNOTA

Return(.T.)

Static Function Grava()

_CONFGRV := ''

if (val(_cVolume)+_nPesol+_nPbruto) >0
	_CONFGRV := TC9->C9_PEDIDO
	
	DbSelectArea("SC5")
	Reclock("SC5",.F.)
	SC5->C5_VOLUME1 := Val(_cVolume)
	SC5->C5_PESOL   := _nPesol
	SC5->C5_PBRUTO  := _nPbruto
	SC5->C5_TRANSP  := _cTransp
	Msunlock()

	
ELSE //ALM - AJIY
_AREAC9 := SC9->(GETAREA())
//		DbSelectArea('SC9')
		SC9->(DBGOTOP())
		If SC9->(DbSeek(xFilial('SC9')+TC9->C9_PEDIDO))
			While SC9->(!Eof()) .And. TC9->C9_PEDIDO == SC9->C9_PEDIDO
				RECLOCK('SC9',.F.)
					SC9->C9_BLCONF  := ''
					SC9->C9_CONFERE := ''
				SC9->(MSUNLOCK())
				
			SC9->(DBSKIP())
			ENDDO

		Endif
		MarcaPed()
RESTAREA(_AREAC9)


endif
Return(.T.)                      

STATIC FUNCTION CANCSC9()
_AREAC9 := SC9->(GETAREA())
//		DbSelectArea('SC9')
		SC9->(DBGOTOP())
		If SC9->(DbSeek(xFilial('SC9')+TC9->C9_PEDIDO))
			While !Eof() .And. TC9->C9_PEDIDO == SC9->C9_PEDIDO
				RECLOCK('SC9',.F.)
					SC9->C9_BLCONF  := ''
					SC9->C9_CONFERE := ''
				SC9->(MSUNLOCK())
				
			SC9->(DBSKIP())
			ENDDO
	MarcaPed()
		Endif
RESTAREA(_AREAC9)
RETURN

#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NESTR01   ºAutor  ³Ewerton Tomaz       º Data ³  03/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa de etiqueta de codigo de barras do pedido         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function NESTR01(_cPedido,_nQtdEtiq,_cConferente,_nEtiqIni,_cNota)
//Local _aArea := GetArea()
Local cArqTxt := "C:\ETIQUETAS\ETIQMAX.TXT"
Local cArqimp := Space(1)
Local _nX
Local _nXIni  := IIf(_nEtiqIni=Nil,1,_nEtiqIni)
Local _nEtiqs := IIf(_nQtdEtiq=Nil,1,_nQtdEtiq)

DbSelectArea("SA1")
DbSetOrder(1)

DbSelectArea("SC5")
DbSetOrder(1)
If DbSeek(xFilial("SC5")+_cPedido)
	SA1->(DbSeek(xFilial("SA1")+SC5->(C5_CLIENTE+C5_LOJACLI)))
	For _nX := _nXIni To _nEtiqs
		cArqimp += Chr(2)+"L"+Chr(13)
		cArqimp += "m"+Chr(13)
		cArqimp += "H11"+Chr(13)
		cArqimp += "D11"+Chr(13)
		cArqimp += "e"+Chr(13)
		cArqimp += "191100405600030RAZAO SOCIAL"+Chr(13)
//		cArqimp += "191100405600460CONF:"+RTrim(_cConferente)+"-"+DtoC(dDatabase)+Chr(13)
		cArqimp += "191100405600460CONF:"+DtoC(dDatabase)+Chr(13)
		cArqimp += "192100505000030"+SubStr(SA1->A1_NOME,1,17)+Chr(13)
		cArqimp += "191100404500030PEDIDO"+Chr(13)
		cArqimp += "191100404500560NOTA FISCAL"+Chr(13)
		cArqimp += "153111503400030"+SC5->C5_NUM+"/"+Chr(13)  
		If !Empty(_cNota)
			cArqimp += "192211503300560"+_cNota+Chr(13)		
		Else
			cArqimp += "192211503400530________"+Chr(13)
		Endif
		cArqimp += "191100402600030NUMERO DE VOLUMES"+Chr(13)
		cArqimp += "192211501250030"+Alltrim(StrZero(_nX,3))+"/"+Alltrim(StrZero(SC5->C5_VOLUME1,3))+Chr(13)
		cArqimp += "1e5311001400570 "+SC5->C5_NUM+Chr(13)
		cArqimp += "191200500100030"+Rtrim(SA1->A1_MUN)+Chr(13)
		cArqimp += "191200500100980"+Rtrim(SA1->A1_EST)+Chr(13)
		cArqimp += "E"+Chr(13)
	Next
	If (nHdl := fCreate(cArqTxt)) # -1
		fWrite(nHdl,cArqImp,Len(cArqImp))
		fClose(nHdl)
		cCom := "C:\ETIQUETAS\ETIQ.BAT"
		WinExec(cCom)
	Else
		MsgStop("Problemas na criação do arquivo de impressão: "+cArqTxt)
	Endif
	
Endif

Return

User Function NESTR01b(_cPedido,_nQtdEtiq,_cConferente,_nEtiqIni,_cNota)
Local cPorta
Local cModelo := ""
Local _nX
Local _nXIni  := IIf(_nEtiqIni=Nil,1,_nEtiqIni)
Local _nEtiqs := IIf(_nQtdEtiq=Nil,1,_nQtdEtiq)          

cPorta  := "LPT1:9600,e,7,2"

cModelo := "ZEBRA"

DbSelectArea("SA1")
DbSetOrder(1)

DbSelectArea("SC5")
DbSetOrder(1)
If DbSeek(xFilial("SC5")+_cPedido)
	SA1->(DbSeek(xFilial("SA1")+SC5->(C5_CLIENTE+C5_LOJACLI)))
//	MSCBPRINTER(cModelo,cPorta,,,.f.,,,,)
//	MSCBCHKSTATUS(.T.)
	MSCBPRINTER("ZEBRA",cPorta,,50) 
	MSCBCHKStatus(.F.)                   
	
	For _nX := _nXIni To _nEtiqs
		MSCBBEGIN(1,4)
		//MSCBGRAFIC(04,02,"ARA")
		//MSCBBOX(01,02,97,80,5)
/*
MSCBSAY    ¦ Autor ¦ ALEX SANDRO VALARIO ¦ Data ¦  05/98
-----------------------------------------------------------
Imprime uma String
-----------------------------------------------------------
nXmm      = Posição X em Milimetros
nYmm      = Posição Y em Milimetros
cTexto    = String a ser impressa
cRotação  = String com o tipo de Rotação (N,R,I,B)
          = N-Normal,R-Cima p/Baixo
          = I-Invertido B-Baixo p/ Cima
cFonte    = String com o tipo de Fonte (A,B,C,D,E,F,G,H,0)
cTam      = String com o tamanho da Fonte
lReverso  = logica  se imprime  em reverso quando tiver
            sobre um box preto
lSerial   = Serializa o codigo
cIncr     = Incrementa quando for serial posito ou negativo
lZerosL   = Coloca zeros a esquerda no numero serial
lNoAlltrim= permite brancos a esquerda e direita
*/		
	   
		MSCBSAY(05,02,"RAZAO SOCIAL","N","0","40") //2,2
//		MSCBSAY(42,02,"CONF:"+RTrim(_cConferente)+"-"+DtoC(dDatabase),"N","0","25")//2,2
		MSCBSAY(42,02,DtoC(dDatabase),"N","0","25")//2,2
		MSCBSAY(05,08, SubStr(SA1->A1_NOME,1,17), "N", "0", "60")		//4,3
		MSCBSAY(05,16,"PEDIDO","N","0","40") // 2,2
		MSCBSAY(50,16,"NOTA FISCAL","N","0","40") //2,2
		MSCBSAY(05,22,SC5->C5_NUM+"    "+IIf(!Empty(_cNota),_cNota,"__________"),"N","0","90") //4,3
//		MSCBSAY(50,22,IIf(!Empty(_cNota),_cNota,"__________"),"N","0","60") //4,3
		MSCBSAY(05,32,"NUMERO DE VOLUMES","N","0","40")// 2,2
		MSCBSAY(05,38,Alltrim(StrZero(_nX,4))+"/"+Alltrim(StrZero(SC5->C5_VOLUME1,4)),"N","0","100") //5,5

      MSCBSAYBAR(60,38,SC5->C5_NUM,"N","MB07",10,.F.,.F.,,,4,2)		
 	  
		MSCBSAY(05,56,Rtrim(SA1->A1_MUN),"N","0","50")//2,3
		MSCBSAY(65,56,Rtrim(SA1->A1_EST),"N","0","50")//2,3
		
		MSCBEND() // Finaliza a formacao da imagem da etiqueta
		
	Next
	
	//MSCBCLOSEPRINTER()
	
Endif

Return

Static Function PesqPC()

_cPedFil := space(06)

DEFINE MSDIALOG oPedFil FROM 63,181 TO 170,390 TITLE "Pesquisa" PIXEL
@ 003,005 TO 035,105
@ 013,007 SAY "Informe o Pedido:" SIZE  60, 7
//@ 013,007 SAY "Ordem de Separação:" SIZE  60, 7
@ 012,055 GET _cPedFil Picture "XXXXXX" SIZE  30, 9
//@ 023,007 SAY "Conferente:" SIZE  60, 7
//@ 022,055 GET _cConfe  SIZE  50, 9
DEFINE SBUTTON FROM 040,038 TYPE 1 ACTION Close(oPedFil) ENABLE OF oPedFil
ACTIVATE MSDIALOG oPedFil CENTER
TC9->(dbgotop())
If !TC9->(DbSeek(_cPedFil))
	ALERT('Verifique se o pedido informado esta correto')
	TC9->(dbgotop())
Endif


Return
