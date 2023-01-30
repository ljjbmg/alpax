#INCLUDE "protheus.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRADVM02   บ Autor ณEDUARDO NAKAMATU    บ Data ณ  12/11/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณCONTROLE DO LABORATORIO                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ALPAX                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑบALTERAวรO ณ CLAUDIO  BIALE 29/12/2010 DEVIDO SET DE LEGENDA ERRADO     บฑฑ
ฑฑบALTERAวรO ณ FERNANDO BIALE 02/12/2010 CONTI. SET DE LEGENDA ERRADO     บฑฑ
ฑฑบ          ณ CRIADO FUN็AO PARA ACERTAR A1_STATUS DE ACORDO COM REGRA   บฑฑ
ฑฑบ          ณ 														      บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿


11.01.2010 - Terceira revisao
Motivo: Atenter remessas internas a terceiros


***** controle
Public bZA1VIEW := {|| ZA1VIEW()}       // VISUAL
Public bCOMOTA  := {|| COMOTA()}        // STATUS
Public bLabRec  := {|| LAB_REC() }      //OK LABORATORIO RECEBE
Public bLabDev  := {|| LAB_DEV() }      //OK LABORATORIO DEVOLVE
Public bLabEst  := {|| LAB_EST() }      //ok LABORATORIO ESTORNA

Public bEstRel  := {|| U_RADVR001() }   // RELATORIO DE CONSISTENCIA
Public bEstEnv  := {|| EST_ENV() }      // OK ESTOQUE ENVIA
Public bEstEst  := {|| EST_EST()}       // ESTOQUE ESTORNA
Public bEstRet  := {|| EST_RET() }      //ok ESTOQUE RETORNA      



28.03.2014 - erro na build nova em 03/2014
             criado parametro novo, teste pedido 184753
/*/


User Function RADVM02(cPV)

Private cCadastro := "Movimentos Laboratorio v3.0/2014"
Private aRotina := MeuMenu()
Private aCores  := {}
//-----|| variaveis exclusivas do mata650
Private cFIlA650 := ""   //order by na query interna
Private lConsTerc := .f.
Private lConsNPT  := .f.
Private lProj711  := .f.
Private lView     := (cPV <> NIl)  
//--------- build de julho2010
Private aSav650 := array(20)  
Private lConsterc
Private lConsNPT
Private lProj711 := .f.
Private l650auto := .t.
Private AROTPROD := {}

// BUILD JULHO 2013
Private LZRHEADER := .f.          

// build MARCO 2014
Private LMATA712  := .f.
Private nPerImp	  := 0	

//Alert("teste do edu julho 2013")

if lView
	
	STATUSLAB(CPV)
	
	RETURN
ENDIF

AADD(aCores,{" ZA1->ZA1_STATUS == '0' ",'BR_BRANCO'} )
AADD(aCores,{" ZA1->ZA1_STATUS == '1' ",'BR_VERDE'  })
AADD(aCores,{" ZA1->ZA1_STATUS == '2' ",'BR_AZUL'} )
AADD(aCores,{" ZA1->ZA1_STATUS == '3' ",'BR_AMARELO' })
AADD(aCores,{" ZA1->ZA1_STATUS == '4' ",'BR_VERMELHO'} )
AADD(aCores,{" ZA1->ZA1_STATUS == '5' ",'BR_MARROM' })
AADD(aCores,{" ZA1->ZA1_STATUS == '6' ",'BR_PRETO'} )

DBSELECTAREA("ZA1")
DBGOTOP()
mBrowse( 6,1,22,75,"ZA1",,,,,,aCores)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLAB_REC   บAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ RECEBIMENTO PELO LABORATORIO                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC FUNCTION LAB_REC()

Private oDlg
Private oLinha
Private aLinha  := {}
Private cLinha := ""
Private aColuna := {}
Private oOk   := LoadBitmap(GetResources(), "LBOK")
Private oNo   := LoadBitmap(GetResources(), "LBNO")
Private nQtdEst := nQtdLab := 0
Private lSair  := .F.
Private bOK    := {||GRV_LABREC(),lSair := .T.,oDlg:End()}
Private bNO    := {||Msginfo("Processo Cancelado!"),lSair := .T., oDlg:End()}
Private cPNumber := cMarca := cCapacid := cDesc := ""


IF SELECT("TMP") <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
ENDIF

BEGINSQL ALIAS "TMP"
	
	COLUMN ZA2_QTD AS NUMERIC(17,2)
	COLUMN REG_ZA2 AS NUMERIC(17,0)
	COLUMN REG_ZA1 AS NUMERIC(17,0)
	
	SELECT ZA2_PV, ZA2_COD, ZA2_QTD,  ZA2.ZA2_DATA, ZA2.ZA2_HR, ZA2.R_E_C_N_O_ REG_ZA2
	,ZA1_NREDUZ,ZA1.R_E_C_N_O_ REG_ZA1
	,ZA1_DESC,ZA1_MARCA,ZA1_CAPACI,ZA1_PNUMBE
	FROM %table:ZA2% ZA2
	LEFT JOIN %table:ZA1% ZA1 ON ZA1.%NotDel% AND  ZA1.ZA1_FILIAL = %xfilial:ZA1% AND ZA1.ZA1_PV = ZA2.ZA2_PV
	AND ZA1.ZA1_ITEMPV = ZA2.ZA2_ITEMPV
	AND ZA1.ZA1_COD = ZA2.ZA2_COD
	
	WHERE ZA2.%NotDel%
	AND ZA2.ZA2_FILIAL = %xfilial:ZA2%
	AND ZA2.ZA2_OPER = '1'
	AND ZA2.ZA2_DTCHK = %exp:space(8)%
	AND ZA2.ZA2_QTD > ZA2_QTDOK
	ORDER BY ZA2_DATA, ZA2_HR
	
ENDSQL

DBSELECTAREA("TMP")
DBGOTOP()

aColuna := {}
aLinha  := {}

WHILE TMP->(!EOF())
	
	aColuna := {}
	TMP->(AADD(aColuna , .f. ) )         //1
	TMP->(AADD(aColuna , ZA2_COD) )      //2
	TMP->(AADD(aColuna , ZA2_QTD) )      //3
	TMP->(AADD(aColuna , ZA1_NREDUZ) )   //4
	TMP->(AADD(aColuna , ZA2_PV) )       //5
	TMP->(AADD(aColuna , REG_ZA2 ) )     //6
	TMP->(AADD(aColuna , REG_ZA1 ) )     //7
	TMP->(AADD(aColuna , ZA1_PNUMBE ) )     //8
	TMP->(AADD(aColuna , ZA1_CAPACI ) )     //9
	TMP->(AADD(aColuna , ZA1_MARCA ) )     //10
	TMP->(AADD(aColuna , ZA1_DESC ) )     //11
	
	AADD(aLinha,aColuna)
	
	nQtdEst += TMP->ZA2_QTD
	
	TMP->(DBSKIP())
ENDDO

DBSELECTAREA("TMP")
DBCLOSEAREA("TMP")

//IF nQtdEst < 1
IF nQtdEst < 1 //BIALE CLAUDIO
	MsgAlert("nao existe itens a processar")
	return
endif

*
DEFINE MSDIALOG oDlg Title "Recebimento" from 0,0 to 270,950 pixel

@010,010 ListBox oLinha Fields Header "", "Codigo", "Quantidade", "Cliente", "Pedido V"  Size 330,095 Pixel   Of oDlg
oLinha:SetArray(aLinha)

oLinha:bLine := {|| {IIF(aLinha[oLinha:nAt,1],oOK,oNo),;
aLinha[oLinha:nAt,2],;
aLinha[oLinha:nAt,3],;
aLinha[oLinha:nAt,4],;
aLinha[oLinha:nAt,5],;
}}

oLinha:bChange := {||cPNumber := aLinha[oLinha:nAt,8],;
                     cMarca := aLinha[oLinha:nAt,10],;
                     cCapacid := aLinha[oLinha:nAt,9],;
                     cDesc :=  aLinha[oLinha:nAt,11] , oDlg:refresh()}


oLinha:bLDblClick := {|| aLinha[oLinha:nAt,1] := !aLinha[oLinha:nAt,1], nQtdLab := IIF(aLinha[oLinha:nAt,1], (nQtdLab + aLinha[oLinha:nAt,3]),(nQtdLab - aLinha[oLinha:nAt,3])) ,oGetlab:REFRESH(),oLinha:Refresh()}       // Define a a็ao que devera ser executada ao dar duplo-clique numa linha.


@010,350 Say "Recebido"   size 40,10 pixel of odlg
@010,390 MsGet oGetEST Var nQtdEst size 40,10 pixel of odlg WHEN .F.
@030,350 Say "Confirmado" size 40,10 pixel of odlg
@030,390 MsGet oGetlab Var nQtdLab size 40,10 pixel of odlg WHEN .F.

@060,375 button obtn prompt "   Confirme   " size 50,12 pixel of odlg action eval(bOK)
@075,375 button obtn prompt "   Cancela    " size 50,12 pixel of odlg action eval(bNO)
ACTIVATE MSDIALOG oDlg Centered


RETURN(NIL)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRV_LABRECบAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava RECEBIMENTO PELO LABORATORIO                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
static function GRV_LABREC()

Local lret := .T.

IF SELECT("TMP") <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
ENDIF

For nX := 1 to len(oLinha:aArray)
	DBSELECTAREA("ZA2")
	IF oLinha:aArray[nX,1]
		DBGOTO(oLinha:aArray[nX,6])
		
		dbselectarea("ZA1")
		DBGOTO(oLinha:aArray[nX,7])
		
		//-----|| baixando producao NA FASE DE RECEBIMENTO DO LABORATORIO
		aProd := {}
		AADD(aProd,ZA1->ZA1_OP)
		AADD(aProd,"000")
		AADD(aProd,ZA2->ZA2_QTD)
		AADD(aProd,ZA2->(RECNO()))
		AADD(aProd,ZA1->ZA1_COD)
				
		IF !U_RADVL003(aProd,.t.)
			MsgAlert("Falha no apontamento da producao, avise o administrador")
			return(.f.)
		ENDIF
		
		RECLOCK("ZA2",.F.)
		ZA2->ZA2_OPER  := '2'
		ZA2->ZA2_QTDOK := ZA2->ZA2_QTD
		ZA2->ZA2_DTCHK := DATE()
		ZA2->ZA2_HRCHK := TIME()
		MSUNLOCK()
		COMMIT
		
		dbselectarea("ZA1")
		DBGOTO(oLinha:aArray[nX,7])
		RECLOCK("ZA1",.F.)
		ZA1->ZA1_QREC := (ZA1->ZA1_QREC + ZA2->ZA2_QTD)
		ZA1->ZA1_STATUS := QSTATUS()
		MSUNLOCK()
		COMMIT
	ENDIF
Next

MsgInfo("Marca็ใo Processada")


return(nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEst_ENV   บAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC FUNCTION EST_ENV()

Private nQtd := 0
Private aTransf := array(13)

IF SELECT("TMP") <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
ENDIF


BEGINSQL ALIAS "TMP"
	
	COLUMN ZA2_QTD  AS NUMERIC(17,2)
	COLUMN CONT_ZA2 AS NUMERIC(17,0)
	
	SELECT COUNT(*) CONT_ZA2, SUM(ZA2_QTD) ZA2_QTD
	FROM %table:ZA2% ZA2
	LEFT JOIN %table:ZA1% ZA1 ON ZA1.%notDel% AND ZA1.ZA1_FILIAL = %xfilial:ZA1%
	AND ZA1.ZA1_PV = ZA2.ZA2_PV AND ZA1.ZA1_ITEMPV = ZA2.ZA2_ITEMPV
	WHERE ZA2.%notDel%
	AND ZA2.ZA2_FILIAL = %xfilial:ZA2%
	AND ZA2.ZA2_OPER = '1'
	AND ZA2.ZA2_QTD <> ZA2.ZA2_QTDOK
	AND ZA2.ZA2_DTCHK = %exp:space(8)%
	AND ZA2.ZA2_DATA < %exp:dtos(DDATABASE)%
	
ENDSQL

IF TMP->CONT_ZA2 > 0
	MsgAlert("Existem "+STRZERO(TMP->CONT_ZA2,5)+" Processos a serem recebidos pelo Laboratorio!")
	MsgInfo("Novos processos apenas quando o Laboratorio apontar os envios anteriores!")
	dbselectarea("TMP")
	DBCLOSEAREA("TMP")
	RETURN(.F.)
ENDIF

dbselectarea("TMP")
DBCLOSEAREA("TMP")


IF (ZA1->ZA1_QPV - ZA1->ZA1_QENV) == 0
	MsgAlert("Processo de envio concluido!")
	DBSELECTAREA("ZA1")
	dbgotop()
	return
endif

IF !MsgGet2("Envio ao Laborat๓rio",ZA1->(ZA1->ZA1_COD+" / "+ZA1_DESC),@nQtd,"DESTINOS",{||_ENVIO()},"@E 999,999")
	MsgAlert("Processo Cancelado!")
	return(nil)
ENDIF


//-----|| MOVENDO ESTOQUE
//---- ANALISANDO EXISTENCIA DE ALMOXARIFADOS
DBSELECTAREA("SB2")
DBSETORDER(2)
DBGOTOP()
IF !DBSEEK(XFILIAL("SB2")+"01"+ZA1->ZA1_COD)
	CriaSB2(ZA1->ZA1_COD,"01")
ENDIF
IF !DBSEEK(XFILIAL("SB2")+"SL"+ZA1->ZA1_COD)
	CriaSB2(ZA1->ZA1_COD,"SL")
ENDIF
IF !DBSEEK(XFILIAL("SB2")+"EL"+ZA1->ZA1_COD)
	CriaSB2(ZA1->ZA1_COD,"EL")
ENDIF

*
//-----|| CRIANDO MOVIMENTACAO
DBSELECTAREA("ZA2")
DBSETORDER(1)
RECLOCK("ZA2",.T.)
ZA2->ZA2_FILIAL := XFILIAL("ZA2")
ZA2->ZA2_OPER   := "1"
ZA2->ZA2_PV     := ZA1->ZA1_PV
ZA2->ZA2_ITEMPV := ZA1->ZA1_ITEMPV
ZA2->ZA2_COD    := ZA1->ZA1_COD
ZA2->ZA2_QTD    := nQtd
ZA2->ZA2_DATA   := DATE()
ZA2->ZA2_HR     := TIME()
MSUNLOCK()
COMMIT

//-----|| MARCANDO STATUS
DBSELECTAREA("ZA1")
RECLOCK("ZA1",.F.)
ZA1->ZA1_QENV    += nQtd
ZA1->ZA1_STATUS  := QSTATUS()
MSUNLOCK()
COMMIT


RETURN(NIL)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMeuMenu   บAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็๕es de Menu                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

STATIC FUNCTION MeuMenu()

Private aRotina  := {}
Private aXnuLab  := {}
Private aXnuEst  := {}
Private lUserLab := .F. //UPPER(ALLTRIM(cUsername)) $ UPPER(GETMV("MV_USERLAB"))
Private lUserEst := .F. //UPPER(ALLTRIM(cUsername)) $ UPPER(GETMV("MV_USEREST"))

Public bZA1VIEW := {|| ZA1VIEW()}       // VISUAL
Public bCOMOTA  := {|| COMOTA()}        // STATUS
Public bLabRec  := {|| LAB_REC() }      // LABORATORIO RECEBE
Public bLabDev  := {|| LAB_DEV() }      // LABORATORIO DEVOLVE
Public bLabEst  := {|| LAB_EST() }      // LABORATORIO ESTORNA

Public bEstRel  := {|| U_RADVR001() }   // RELATORIO DE CONSISTENCIA
Public bEstEnv  := {|| EST_ENV() }      // ESTOQUE ENVIA
Public bEstEst  := {|| EST_EST()}       // ESTOQUE ESTORNA
Public bEstRet  := {|| EST_RET() }      // ESTOQUE RETORNA
Public bEstGer  := {|| EST_GER() }      // ESTOQUE RETORNA

PUBLIC bGeraOP := {||geraop()}
PUBLIC bPVAUTO := {||pvauto()}

//Public bMonitor := {|| ZA1VIEW() }
Public bLegenda := {|| Legenda() }


dbselectarea("SZ7")
DBSETORDER(2)
DBGOTOP()
IF !DBSEEK(XFILIAL("SZ7")+__cUserID)
	Msgalert("Usuario nao econtrado na tabela SZ7, avise o ADM!")
ELSE
	lUserLab := (ALLTRIM(UPPER(SZ7->Z7_EQUIPE)) == "LABORATORIO")
	lUserEst := (ALLTRIM(UPPER(SZ7->Z7_EQUIPE)) == "ESTOQUE")
ENDIF

IF (ALLTRIM(UPPER(SZ7->Z7_EQUIPE)) == "T.I") .or. __cUserID == "000000"
	lUserLab := .T. //(ALLTRIM(UPPER(SZ7->Z7_EQUIPE)) == "LABORATORIO")
	lUserEst := .T. //(ALLTRIM(UPPER(SZ7->Z7_EQUIPE)) == "ESTOQUE")
ENDIF

AADD(aRotina,{"Pesquisar"   ,"AxPesqui", 0 , 1 })
AADD(aRotina,{"Visualizar"  ,"EVAL(BZA1VIEW)", 0 , 2})


AADD(aXnuLab,{"Receber"  ,"EVAL(bLabRec)",0,4})
AADD(aXnuLab,{"Devolver_Est" ,"EVAL(bLabDev)",0,4})
AADD(aXnuLab,{"Estorno_Est" ,"EVAL(bLabEst)",0,4})

AADD(aXnuEst,{"Envio_Lab        "  ,"eval(bEstEnv)",0,4})
AADD(aXnuEst,{"Estorno_Lab      "  ,"eval(bEstEST)",0,4})
AADD(aXnuEst,{"Retorno        "  ,"eval(bEstRet)",0,4})

IF	lUserLab .AND. lUserEst
    AADD(aRotina,{"E X C L U I R !!!"  ,"eval(bEstGer)",0,4})
ENDIF

IF lUserLab
	AADD(aRotina,{"Laboratorio" ,aXnuLab   , 0 , 4})
Endif
IF lUserEst
	AADD(aRotina,{"Estoque"     ,aXnuEst   , 0 , 4})
	IF GETMV("MV_CONSEST") == "N"
	    AADD(aRotina,{"OP Venda" , "EVAL(BPVAUTO)",0,3})
	ELSE
		MSGALERT("MUDARAM O PARAMETRO MV_CONSEST, DEVE ESTAR COMO 'N', AVISE DEPTO TI!")
	ENDIF
ENDIF

AADD(aRotina,{"Relatorio   "  ,"eval(bEstRel)",0,3})
AADD(aRotina,{"Legenda"     ,"eval(bLegenda)" , 0 , 4})
AADD(aRotina,{"Status"     ,"eval(bcomota)" , 0 , 4})

return(aRotina)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLegenda   บAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta Legenda para mBrowse                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
static Function Legenda()


cCadastro := "Movimenta็๕es para Laboratorio"

aCores2 := { { "BR_BRANCO"   , "Aberto / Nao Processado"      },;
{ "BR_VERDE"    , "Envio Parcial ao Laboratorio "      },;
{ "BR_AZUL"     , "Envio Total ao Laboratorio"    },;
{ "BR_AMARELO"  ,  "Recebido do Estoque"  },;
{ "BR_VERMELHO" ,  "Devolu็ใo Parcial ao Estoque"},;
{ "BR_MARROM"   ,  "Devolu็ใo Total ao Estoque"},;
{ "BR_PRETO"    ,  "Retorno ao Estoque Confirmado"}   }


BrwLegenda(cCadastro,"Legenda do Browse",aCores2)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_ENVIO    บAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVALIDACAO DE ENVIO DE DADOS                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC FUNCTION _ENVIO()

Local nEst := POSICIONE("SB2",1,XFILIAL("SB2")+ZA1->ZA1_COD+"01","B2_QATU")
Local lRet := .T.
IF nQtd > nEst .or. nQtd > ZA1->(ZA1_QPV - ZA1->ZA1_QENV)
	lRet := .F.
	MsgAlert("Possํveis Problemas:"+CRLF+"- Produto sem Estoque"+CRLF+"- Quantidade digitada superior a saldo a enviar"+CRLF+"- Produto sem almoxarifado 01...")
ENDIF
RETURN(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLAB_DEV   บAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC FUNCTION LAB_DEV()

Private nQtd := 0
Private aTransf := array(13)

IF (ZA1->ZA1_QREC - ZA1->ZA1_QDEV) == 0
	MsgAlert("Processo de devolu็ใo concluido ou Processo sem entrada no Laboratorio!")
	dbgotop()
	return
endif

BEGINSQL ALIAS "TMP"
	
	COLUMN ZA2_QTD  AS NUMERIC(17,2)
	COLUMN CONT_ZA2 AS NUMERIC(17,0)
	
	SELECT COUNT(*) CONT_ZA2, ISNULL(SUM(ZA2_QTD),0) ZA2_QTD
	FROM %table:ZA2% ZA2
	LEFT JOIN %table:ZA1% ZA1 ON ZA1.%notDel% AND ZA1.ZA1_FILIAL = %xfilial:ZA1%
	AND ZA1.ZA1_PV = ZA2.ZA2_PV AND ZA1.ZA1_ITEMPV = ZA2.ZA2_ITEMPV
	WHERE ZA2.%notDel%
	AND ZA2.ZA2_FILIAL = %xfilial:ZA2%
	AND ZA2.ZA2_OPER = '3'
	AND ZA2.ZA2_QTD <> ZA2.ZA2_QTDOK
	AND ZA2.ZA2_DTCHK = %exp:space(8)%
	AND ZA2.ZA2_DATA < %exp:dtos(DDATABASE)%
	
ENDSQL

IF TMP->CONT_ZA2 > 0 
	MsgAlert("Existem "+STRZERO(TMP->CONT_ZA2,5)+" Processos a serem recebidos pelo Laboratorio!")
	MsgInfo("Novos processos apenas quando o Laboratorio apontar os envios anteriores!")
	dbselectarea("TMP")
	DBCLOSEAREA("TMP")
	RETURN(.F.)
ENDIF

dbselectarea("TMP")
DBCLOSEAREA("TMP")


IF !MsgGet2("Devolu็ใo ao Estoque",ZA1->(ZA1->ZA1_COD+" / "+ZA1_DESC),@nQtd,"DESTINOS",{||_DEVOL()},"@E 999,999")
	MsgAlert("Processo Cancelado!")
	return(nil)
ENDIF

//-----|| ATUALZIANDO SALDOS DE MOVIMENTACAO
RECLOCK("ZA1",.F.)
ZA1->ZA1_QDEV := ZA1->ZA1_QDEV + nQtd
ZA1->ZA1_STATUS := QSTATUS()
MSUNLOCK()
COMMIT

//-----|| CRIANDO MOVIMENTACAO
DBSELECTAREA("ZA2")
DBSETORDER(1)
RECLOCK("ZA2",.T.)
ZA2->ZA2_FILIAL := XFILIAL("ZA2")
ZA2->ZA2_OPER   := "3"
ZA2->ZA2_PV     := ZA1->ZA1_PV
ZA2->ZA2_ITEMPV := ZA1->ZA1_ITEMPV
ZA2->ZA2_COD    := ZA1->ZA1_COD
ZA2->ZA2_QTD    := nQtd
ZA2->ZA2_DATA   := DATE()
ZA2->ZA2_HR     := TIME()
MSUNLOCK()
COMMIT

RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_DEVOL    บAutor  ณEduardo Nakamatu    บ Data ณ    /  /     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo de envio d edados                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
STATIC FUNCTION _DEVOL()

Local nEst := POSICIONE("SB2",1,XFILIAL("SB2")+ZA1->ZA1_COD+"01","B2_QATU")
Local lRet := .T.

IF nQtd > ZA1->(ZA1_QREC - ZA1->ZA1_QDEV) .OR. nQtd == 0
	lRet := .F.
	MsgAlert("Possํveis Problemas:"+CRLF+"- Quantidade digitada superior a saldo a devolver"+CRLF+"- Quantidade Zerada")
ENDIF

RETURN(lRet)







STATIC FUNCTION EST_RET()

Private oDlg
Private oLinha
Private aLinha  := {}
Private cLinha := ""
Private aColuna := {}
Private oOk   := LoadBitmap(GetResources(), "LBOK")
Private oNo   := LoadBitmap(GetResources(), "LBNO")
Private nQtdEst := nQtdLab := 0
Private lSair  := .F.
Private bOK    := {||GRV_ESTRET(),lSair := .T.,oDlg:End()}
Private bNO    := {||Msginfo("Processo Cancelado!"),lSair := .T., oDlg:End()}

BEGINSQL ALIAS "TMP"
	
	COLUMN ZA2_QTD AS NUMERIC(17,2)
	COLUMN REG_ZA2 AS NUMERIC(17,0)
	COLUMN REG_ZA1 AS NUMERIC(17,0)
	
	SELECT ZA2_PV, ZA2_COD, ZA2_QTD,  ZA2.ZA2_DATA, ZA2.ZA2_HR, ZA2.R_E_C_N_O_ REG_ZA2
	,ZA1_NREDUZ,ZA1.R_E_C_N_O_ REG_ZA1, ZA1.ZA1_OP NUM_OP
	FROM %table:ZA2% ZA2
	LEFT JOIN %table:ZA1% ZA1 ON ZA1.%NotDel% AND  ZA1.ZA1_FILIAL = %xfilial:ZA1% AND ZA1.ZA1_PV = ZA2.ZA2_PV
	AND ZA1.ZA1_ITEMPV = ZA2.ZA2_ITEMPV
	AND ZA1.ZA1_COD = ZA2.ZA2_COD
	
	WHERE ZA2.%NotDel%
	AND ZA2.ZA2_FILIAL = %xfilial:ZA2%
	AND ZA2.ZA2_OPER = '3'
	AND ZA2.ZA2_DTCHK = %exp:space(8)%
	AND ZA2.ZA2_QTD <> ZA2_QTDOK
	ORDER BY ZA2_DATA, ZA2_HR
	
ENDSQL

DBSELECTAREA("TMP")
DBGOTOP()

aColuna := {}
aLinha  := {}

WHILE TMP->(!EOF())
	
	aColuna := {}
	TMP->(AADD(aColuna , .f. ) )         //1
	TMP->(AADD(aColuna , ZA2_COD) )      //2
	TMP->(AADD(aColuna , ZA2_QTD) )      //3
	TMP->(AADD(aColuna , ZA1_NREDUZ) )   //4
	TMP->(AADD(aColuna , ZA2_PV) )       //5
	TMP->(AADD(aColuna , REG_ZA2 ) )     //6
	TMP->(AADD(aColuna , REG_ZA1 ) )     //7
	TMP->(AADD(aColuna , NUM_OP  ) )     //8
	
	AADD(aLinha,aColuna)
	
	nQtdEst += TMP->ZA2_QTD
	
	TMP->(DBSKIP())
ENDDO

DBSELECTAREA("TMP")
DBCLOSEAREA("TMP")

IF nQtdEst < 1
	MsgAlert("nao existe itens a processar")
	return
endif

*
DEFINE MSDIALOG oDlg Title "Retorno do Laboratorio" from 0,0 to 270,950 pixel

@010,010 ListBox oLinha Fields Header "", "Codigo", "Quantidade", "Cliente", "Pedido V"  Size 330,095 Pixel   Of oDlg
oLinha:SetArray(aLinha)

oLinha:bLine := {|| {IIF(aLinha[oLinha:nAt,1],oOK,oNo),;
aLinha[oLinha:nAt,2],;
aLinha[oLinha:nAt,3],;
aLinha[oLinha:nAt,4],;
aLinha[oLinha:nAt,5],;
}}

oLinha:bLDblClick := {|| aLinha[oLinha:nAt,1] := !aLinha[oLinha:nAt,1], nQtdLab := IIF(aLinha[oLinha:nAt,1], (nQtdLab + aLinha[oLinha:nAt,3]),(nQtdLab - aLinha[oLinha:nAt,3])) ,oGetlab:REFRESH(),oLinha:Refresh()}       // Define a a็ao que devera ser executada ao dar duplo-clique numa linha.

@010,350 Say "Retornado"   size 40,10 pixel of odlg
@010,390 MsGet oGetEST Var nQtdEst size 40,10 pixel of odlg WHEN .F.
@030,350 Say "Confirmado" size 40,10 pixel of odlg
@030,390 MsGet oGetlab Var nQtdLab size 40,10 pixel of odlg WHEN .F.

@060,375 button obtn prompt "   Confirme   " size 50,12 pixel of odlg action eval(bOK)
@075,375 button obtn prompt "   Cancela    " size 50,12 pixel of odlg action eval(bNO)
ACTIVATE MSDIALOG oDlg Centered


RETURN(NIL)


static function GRV_ESTRET()

Local lret := .T.
Local aPar := {}

For nX := 1 to len(oLinha:aArray)
	dbselectarea("ZA2")
	IF oLinha:aArray[nX,1]
		DBGOTO(oLinha:aArray[nX,6])
		
		dbselectarea("ZA1")
		DBGOTO(oLinha:aArray[nX,7])
		
		// TRANSFERENCIA DE EL PARA LOCAL PADRAO DO PEDIDO
		cPVLOcal := POSICIONE("SC6",1,XFILIAL("SC6")+ZA1->(ZA1_PV+ZA1_ITEMPV+ZA1_COD),"C6_LOCAL")
		dbselectarea("SB2")
		dbsetorder(1)
		dbgotop()
		if !dbseek(xfilial("SB2")+ZA1->ZA1_COD+"EL")
			ALERT("PRODUTO "+ZA1->ZA1_COD+" SEM SALDO NO EL")
			LOOP
			RETURN(.F.)
		ENDIF
		
		IF SB2->(B2_QATU - B2_QEMP - B2_RESERVA) < ZA2->ZA2_QTD
			// REMOVE EMPENHO
			RECLOCK("SB2", .F.)
			SB2->B2_QEMP := IF(SB2->B2_QEMP >=ZA2->ZA2_QTD,SB2->B2_QEMP,SB2->B2_QEMP - ZA2->ZA2_QTD)
			MSUNLOCK()
			IF SB2->(B2_QATU - B2_QEMP - B2_RESERVA) < ZA2->ZA2_QTD
				Alert("Produto sem saldo: "+ZA1->ZA1_COD)
				RETURN(.F.)
			ENDIF
		ENDIF
		
		aPar := {}		
		AADD(aPar,ZA1->ZA1_COD)   // 1 - produto
		AADD(aPar,"EL")           // 2 - local origem
		AADD(aPar,ZA2->ZA2_QTD)   // 3 - qtdade
		cDoc := DTOS(DATE()) + SUBSTR(STRTRAN(TIME(),":",""),1,4)
		AADD(aPar,cDoc) // 4 - doc
		AADD(aPar,"") // 5 - lote
		AADD(aPar,"") // 6 - validade
		AADD(aPar,"") // 7 - serie
		AADD(aPar,"") // 8 - endereco
		AADD(aPar,ZA1->ZA1_COD) // 9 - prod destino
		AADD(aPar,"SL") // 10 - LOCAL DESTINO
		AADD(aPar,"") // 11 - LOCALIZACAO O DESTINO
		AADD(aPar,"") // 12 - ENREDECO?
		AADD(aPar,"") // 13 - lote?
		IF !U_RADVL001(aPar,.T.)
			MsgAlert("Falha na transferencia para SL: "+ZA1->ZA1_COD)
			return(nil)
		ENDIF
		
		DBSELECTAREA("ZA2")
		RECLOCK("ZA2",.F.)
		ZA2->ZA2_OPER  := '4'
		ZA2->ZA2_QTDOK := ZA2->ZA2_QTD
		ZA2->ZA2_DTCHK := DATE()
		ZA2->ZA2_HRCHK := TIME()
		MSUNLOCK()
		COMMIT
		
		RECLOCK("ZA1",.F.)
		ZA1->ZA1_QRET := (ZA1->ZA1_QRET + ZA2->ZA2_QTD)
		ZA1->ZA1_STATUS := QSTATUS()
		MSUNLOCK()
		COMMIT
		
	ENDIF
Next

MsgInfo("Marca็ใo Processada")


return(nil)


STATIC FUNCTION EST_EST() // ESTORNO DO LABORATORIO

Private bOK := {||GRV_ESTLAB(),lSair := .T.,oDlg:End()}
Private bNO := {||Msginfo("Processo Cancelado!"),lSair := .T., oDlg:End()}
Private oOk := LoadBitmap(GetResources(), "LBOK")
Private oNo := LoadBitmap(GetResources(), "LBNO")

Private aColuna := {}
Private aLinha  := {}
Private nQtdEst := nQtdSel := 0
Private cPNumber := space(15)
Private dData := (date() - 220)

if !MsgGet2("Estorno de Operacoes","Informe o PartNumber para Estorno!!!",@cPNumber,"DESTINOS",{||.t.},"@!")
	MsgAlert("Processo Cancelado!")
	return(nil)
ENDIF


IF SELECT("TMP")  <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
ENDIF

BEGINSQL ALIAS "TMP"
	
	COLUMN ZA2_QTD AS NUMERIC(17,2)
	COLUMN REG_ZA2 AS NUMERIC(17,2)
	COLUMN ZA2_DATA AS DATE
	
	SELECT ZA2_PV, ZA2_ITEMPV, ZA2_COD, ZA2_QTD, ZA2_DATA, ZA2_HR, ZA2.R_E_C_N_O_ REG_ZA2 ,ZA1.R_E_C_N_O_ REG_ZA1
	, ZA2.ZA2_OPER, SB1.B1_PNUMBER
	FROM %table:ZA2% ZA2
	LEFT JOIN %table:ZA1% ZA1 ON ZA1.%NotDel% AND  ZA1.ZA1_FILIAL = %xfilial:ZA1% AND ZA1.ZA1_PV = ZA2.ZA2_PV
	AND ZA1.ZA1_ITEMPV = ZA2.ZA2_ITEMPV
	AND ZA1.ZA1_COD = ZA2.ZA2_COD
	LEFT JOIN %table:SB1% SB1 ON SB1.%NotDel% AND SB1.B1_COD = ZA2.ZA2_COD
	WHERE ZA2.%notDel%
	AND SB1.B1_PNUMBER = %exp:alltrim(cPNumber)%
	AND ZA2.ZA2_DATA >= %exp:DTOS(dData)%
	AND ZA2.ZA2_OPER IN ('1','4')
	ORDER BY ZA2_DATA, ZA2_HR
	
ENDSQL

DBSELECTAREA("TMP")
DBGOTOP()

aColuna := {}
aLinha  := {}
nQtdEst := nQtdSel := 0

IF TMP->(eof())
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
	MsgAlert("Nao existe dados a processar!")
	RETURN
ENDIF
WHILE TMP->(!EOF())
	
	aColuna := {}
	TMP->(AADD(aColuna , .f. ) )            //1
	TMP->(AADD(aColuna , ZA2_PV) )          //2
	TMP->(AADD(aColuna , ZA2_ITEMPV) )      //3
	TMP->(AADD(aColuna , ZA2_COD) )         //4
	TMP->(AADD(aColuna , ZA2_QTD) )          //5
	TMP->(AADD(aColuna , ZA2_DATA) )        //6
	TMP->(AADD(aColuna , ZA2_HR) )          //7
	TMP->(AADD(aColuna , REG_ZA2 ) )        //8
	TMP->(AADD(aColuna , REG_ZA1 ) )        //9
	TMP->(AADD(aColuna , ZA2_OPER ) )        //10
	TMP->(AADD(aColuna , B1_PNUMBER ) )        //11
	
	AADD(aLinha,aColuna)
	
	nQtdEst += TMP->ZA2_QTD
	
	TMP->(DBSKIP())
ENDDO

DBSELECTAREA("TMP")
DBCLOSEAREA("TMP")


DEFINE MSDIALOG oDlg Title "Estorno Movimentos Estoque(Envio/Retorno)" from 0,0 to 270,950 pixel

@010,010 ListBox oLinha Fields Header "", "Pedido", "Item", "Produto","PNumber", "Qtdade","Data","Hora"  Size 330,095 Pixel   Of oDlg
oLinha:SetArray(aLinha)

oLinha:bLine := {|| {IIF(aLinha[oLinha:nAt,1],oOK,oNo),;
aLinha[oLinha:nAt,2],;
aLinha[oLinha:nAt,3],;
aLinha[oLinha:nAt,4],;
aLinha[oLinha:nAt,11],;
aLinha[oLinha:nAt,5],;
aLinha[oLinha:nAt,6],;
aLinha[oLinha:nAt,7],;
}}

oLinha:bLDblClick := {|| aLinha[oLinha:nAt,1] := !aLinha[oLinha:nAt,1], nQtdSel := IIF(aLinha[oLinha:nAt,1], (nQtdSel + aLinha[oLinha:nAt,5]),(nQtdSel - aLinha[oLinha:nAt,5])) ,oGetlab:REFRESH(),oLinha:Refresh()}       // Define a a็ao que devera ser executada ao dar duplo-clique numa linha.

@010,350 Say "ม Estornar"   size 40,10 pixel of odlg
@010,390 MsGet oGetEST Var nQtdEst size 40,10 pixel of odlg WHEN .F.
@030,350 Say "Confirmado" size 40,10 pixel of odlg
@030,390 MsGet oGetlab Var nQtdSel size 40,10 pixel of odlg WHEN .F.

@060,375 button obtn prompt "   Confirme   " size 50,12 pixel of odlg action eval(bOK)
@075,375 button obtn prompt "   Cancela    " size 50,12 pixel of odlg action eval(bNO)
ACTIVATE MSDIALOG oDlg Centered


RETURN(NIL)


STATIC FUNCTiON GRV_ESTLAB()


Private lret := .T.

IF SELECT("TMP") <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
ENDIF


For nX := 1 to len(oLinha:aArray)
	DBSELECTAREA("ZA2")
	IF oLinha:aArray[nX,1]
		DBGOTO(oLinha:aArray[nX,8])
		
		dbselectarea("ZA1")
		DBGOTO(oLinha:aArray[nX,9])
		
		
		IF ZA2->ZA2_OPER == "1"
			// QUANDO ENVIADO AO LABORATORIO E NAO RECEBIDO
			nQtd := ZA2->ZA2_QTD
			RECLOCK("ZA2",.F.)
			ZA2->(dbdelete())
			MSUNLOCK()
			COMMIT
			
			dbselectarea("ZA1")
			DBGOTO(oLinha:aArray[nX,9])
			RECLOCK("ZA1",.F.)
			ZA1->ZA1_QENV := (ZA1->ZA1_QENV - nQTD)
			ZA1->ZA1_STATUS := QSTATUS()
			MSUNLOCK()
			COMMIT
			
		ELSEIF ZA2->ZA2_OPER == "4"
			
			// QUANDO RETORNADO DO LABORATORIO E RECEBIDO
			// POSICIONA TABELAS
			// ZA2 POSICIONADA NO IF
			// POSICIONANDO ZA1
			
			// TRANSFERENCIA DE EL PARA LOCAL PADRAO DO PEDIDO
			aPar := {}
			cPVLOcal := POSICIONE("SC6",1,XFILIAL("SC6")+ZA1->(ZA1_PV+ZA1_ITEMPV+ZA1_COD),"C6_LOCAL")
			AADD(aPar,ZA1->ZA1_COD)   // 1 - produto
			AADD(aPar,"SL")           // 2 - local origem
			AADD(aPar,ZA2->ZA2_QTD)   // 3 - qtdade
			AADD(aPar,DTOS(DATE())+SUBSTR(STRTRAN(TIME(),":",""),1,4)) // 4 - doc
			AADD(aPar,"") // 5 - lote
			AADD(aPar,"") // 6 - validade
			AADD(aPar,"") // 7 - serie
			AADD(aPar,"") // 8 - endereco
			AADD(aPar,ZA1->ZA1_COD) // 9 - prod destino
			AADD(aPar,"EL") // 10 - LOCAL DESTINO
			AADD(aPar,"") // 11 - LOCALIZACAO O DESTINO
			AADD(aPar,"") // 12 - ENREDECO?
			AADD(aPar,"") // 13 - lote destino
			IF !U_RADVL001(aPar,.T.)
				MsgAlert("Falha na transferencia para SL: "+ZA1->ZA1_COD)
				return(nil)
			ENDIF
			
			// AJUSTA BASE DE MOVIMENTOS LABORATORIO
			RECLOCK("ZA2",.F.)
			ZA2->ZA2_OPER  := '3'
			ZA2->ZA2_QTDOK := 0//ZA2->ZA2_QTD
			ZA2->ZA2_DTCHK := STOD("")//DATE()
			ZA2->ZA2_HRCHK := ""//TIME()
			MSUNLOCK()
			COMMIT
			
			RECLOCK("ZA1",.F.)
			ZA1->ZA1_QRET := (ZA1->ZA1_QRET - ZA2->ZA2_QTD)
			ZA1->ZA1_STATUS == QSTATUS()
			MSUNLOCK()
			COMMIT
			
			MsgAlert("Estorno realizado!")
		ELSE
			Msgalert("Falha no processo de Estorno, avise o ADM!")
			
		ENDIF
	ENDIF
Next



return(nil)



//***
STATIC FUNCTION LAB_EST() // ESTORNO LABORATORIO ENVIO

Private bOK    := {||GRV_ESTEST(),lSair := .T.,oDlg:End()}
Private bNO    := {||Msginfo("Processo Cancelado!"),lSair := .T., oDlg:End()}
Private oOk   := LoadBitmap(GetResources(), "LBOK")
Private oNo   := LoadBitmap(GetResources(), "LBNO")

Private aColuna := {}
Private aLinha  := {}
Private nQtdEst := nQtdSel := 0
Private cPNumber := space(15)
Private dData := (date() - 220)

if !MsgGet2("Estorno de Operacoes","Informe o PartNumber para Estorno!!!",@cPNumber,"DESTINOS",{||.t.},"@!")
	MsgAlert("Processo Cancelado!")
	return(nil)
ENDIF


IF SELECT("TMP")  <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
ENDIF

BEGINSQL ALIAS "TMP"
	
	COLUMN ZA2_QTD AS NUMERIC(17,2)
	COLUMN REG_ZA2 AS NUMERIC(17,2)
	COLUMN ZA2_DATA AS DATE
	
	SELECT ZA2_PV, ZA2_ITEMPV, ZA2_COD, ZA2_QTD, ZA2_DATA, ZA2_HR, ZA2.R_E_C_N_O_ REG_ZA2 ,ZA1.R_E_C_N_O_ REG_ZA1
	, B1_PNUMBER
	FROM %table:ZA2% ZA2
	LEFT JOIN %table:ZA1% ZA1 ON ZA1.%NotDel% AND  ZA1.ZA1_FILIAL = %xfilial:ZA1% AND ZA1.ZA1_PV = ZA2.ZA2_PV
	AND ZA1.ZA1_ITEMPV = ZA2.ZA2_ITEMPV
	AND ZA1.ZA1_COD = ZA2.ZA2_COD
	LEFT JOIN %table:SB1% SB1 ON SB1.%NotDel% AND SB1.B1_COD = ZA1.ZA1_COD
	WHERE ZA2.%notDel%
	AND SB1.B1_PNUMBER = %exp:alltrim(cPNumber)%
	AND ZA2.ZA2_DATA >= %exp:dtos(dData)%
	AND ZA2.ZA2_OPER in ('2','3')
	ORDER BY ZA2_DATA, ZA2_HR
	
ENDSQL

DBSELECTAREA("TMP")
DBGOTOP()

aColuna := {}
aLinha  := {}
nQtdEst := nQtdSel := 0

IF TMP->(eof())
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
	MsgAlert("Nao existe dados a processar!")
	RETURN
ENDIF
WHILE TMP->(!EOF())
	
	aColuna := {}
	TMP->(AADD(aColuna , .f. ) )            //1
	TMP->(AADD(aColuna , ZA2_PV) )          //2
	TMP->(AADD(aColuna , ZA2_ITEMPV) )      //3
	TMP->(AADD(aColuna , ZA2_COD) )         //4
	TMP->(AADD(aColuna , ZA2_QTD) )          //5
	TMP->(AADD(aColuna , ZA2_DATA) )        //6
	TMP->(AADD(aColuna , ZA2_HR) )          //7
	TMP->(AADD(aColuna , REG_ZA2 ) )        //8
	TMP->(AADD(aColuna , REG_ZA1 ) )        //9
	TMP->(AADD(aColuna , B1_PNUMBER ) )        //10
	
	AADD(aLinha,aColuna)
	
	nQtdEst += TMP->ZA2_QTD
	
	TMP->(DBSKIP())
ENDDO

DBSELECTAREA("TMP")
DBCLOSEAREA("TMP")


DEFINE MSDIALOG oDlg Title "Estorno Devolucao Estoque" from 0,0 to 270,950 pixel

@010,010 ListBox oLinha Fields Header "", "Pedido", "Item", "Produto", "PNumber","Qtdade","Data","Hora"  Size 330,095 Pixel   Of oDlg
oLinha:SetArray(aLinha)

oLinha:bLine := {|| {IIF(aLinha[oLinha:nAt,1],oOK,oNo),;
aLinha[oLinha:nAt,2],;
aLinha[oLinha:nAt,3],;
aLinha[oLinha:nAt,4],;
aLinha[oLinha:nAt,10],;
aLinha[oLinha:nAt,5],;
aLinha[oLinha:nAt,6],;
aLinha[oLinha:nAt,7],;
}}

oLinha:bLDblClick := {|| aLinha[oLinha:nAt,1] := !aLinha[oLinha:nAt,1], nQtdSel := IIF(aLinha[oLinha:nAt,1], (nQtdSel + aLinha[oLinha:nAt,5]),(nQtdSel - aLinha[oLinha:nAt,5])) ,oGetlab:REFRESH(),oLinha:Refresh()}       // Define a a็ao que devera ser executada ao dar duplo-clique numa linha.

@010,350 Say "  Estornar"   size 40,10 pixel of odlg
@010,390 MsGet oGetEST Var nQtdEst size 40,10 pixel of odlg WHEN .F.
@030,350 Say "Confirmado" size 40,10 pixel of odlg
@030,390 MsGet oGetlab Var nQtdSel size 40,10 pixel of odlg WHEN .F.

@060,375 button obtn prompt "   Confirme   " size 50,12 pixel of odlg action eval(bOK)
@075,375 button obtn prompt "   Cancela    " size 50,12 pixel of odlg action eval(bNO)
ACTIVATE MSDIALOG oDlg Centered


RETURN(NIL)


STATIC FUNCTiON GRV_ESTEST()


Private lret := .T.

IF SELECT("TMP") <> 0
	DBSELECTAREA("TMP")
	DBCLOSEAREA()
ENDIF


For nX := 1 to len(oLinha:aArray)
	DBSELECTAREA("ZA2")
	IF oLinha:aArray[nX,1]
		DBGOTO(oLinha:aArray[nX,8])
		
		dbselectarea("ZA1")
		DBGOTO(oLinha:aArray[nX,9])
		
		
		nQtd := ZA2->ZA2_QTD
		
		IF ZA2->ZA2_OPER == "2"    // recebido pelo lab
			
			// ANALISE OP E SALDOS
			dbselectarea("SC2")
			dbsetorder(1)
			dbgotop()
			IF !dbseek(xfilial("SC2")+ZA1->ZA1_OP)
				ALERT("OP "+ZA1->ZA1_OP+" NAO ENCONTRADA!")
				RETURN()
			ENDIF
			
			IF ZA2->ZA2_QTD > POSICIONE("SB2",1,XFILIAL("SB2")+SC2->(C2_PRODUTO+C2_LOCAL),"B2_QATU")
				MsgAlert("Produto: "+ZA2->ZA2_COD+" sem saldo disponivel no local: "+SC2->C2_LOCAL)
				RETURN()
			ENDIF
			
			// BUSCA APONTAMENTOS E POSICIONA PARA EXCLUSAO
			dbselectarea("SD3")
			DBSETORDER(1)
			IF !DBSEEK(XFILIAL("SD3")+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN))
				MSGALERT("APONTAMENTO DA OP "+ZA1->ZA1_OP+" NAO ENCONTRADA!")
				RETURN()
			ENDIF
			
			
			lOP := .f.
			WHILE SD3->(!EOF()) .AND. ALLTRIM(SD3->D3_OP) == ALLTRIM(SC2->(C2_NUM+C2_ITEM+C2_SEQUEN))
				IF SD3->D3_QUANT == ZA2->ZA2_QTD .AND. SD3->D3_TM == '000' .AND. EMPTY(SD3->D3_ESTORNO)
					lOP := .t.
					EXIT
				ENDIF
				SD3->(DBSKIP())
			ENDDO
			
			if !lOP
				Alert("Nao Localizado Apontamento da OP: "+SC2->(C2_NUM+C2_ITEM+C2_SEQUEN))
				return(.f.)
			endif
			
			// FAZ O ESTORNO/EXCLUSAO
			aProd := {}
			AADD(aProd,SD3->D3_OP)
			AADD(aProd,SD3->D3_TM)
			AADD(aProd,SD3->D3_QUANT)
			AADD(aProd,SD3->D3_DOC)
			AADD(aProd,SD3->D3_COD)
			IF !U_RADVL003(aProd,.F.)
				MsgAlert("Falha no apontamento da producao, avise o administrador")
				return(.f.)
			ENDIF
			
			RECLOCK("ZA2",.F.)
			ZA2->ZA2_OPER := "1"
			ZA2->ZA2_QTDOK := 0
			ZA2->ZA2_DTCHK := STOD("")
			ZA2->ZA2_HRCHK := ""
			MSUNLOCK()
			COMMIT
			
			
			RECLOCK("ZA1",.F.)
			ZA1->ZA1_QREC := (ZA1->ZA1_QREC - nQTD)
			ZA1->ZA1_STATUS := QSTATUS()
			MSUNLOCK()
			COMMIT
			
		ELSEIF ZA2->ZA2_OPER == "3"
			RECLOCK("ZA2",.F.)
			ZA2->(dbdelete())
			MSUNLOCK()
			COMMIT
			
			RECLOCK("ZA1",.F.)
			ZA1->ZA1_QDEV := (ZA1->ZA1_QDEV - nQTD)
			ZA1->ZA1_STATUS := QSTATUS()
			MSUNLOCK()
			
		ENDIF
		
	ENDIF
Next

MsgInfo("Estorno Processado...!")


return(nil)


STATIC FUNCTION ZA1VIEW(cPed,cItem)

private afase   := {"Envio","Recebimento","Devolucao","Retorno"}
PRIVATE AFASE0  := {"ABERTO","ENV_PARCIAL","ENV_TOTAL","RECEBIDO","DEV_PARCIAL","DEV_TOTAL","RETORNADO"}
private CATELA  := ""
Private aCampos := {}
private alinha  := {}
Private clinha, olinha
private acoluna := {}
DEFAULT cPed  := ZA1->ZA1_PV
DEFAULT cItem := ZA1->ZA1_ITEMPV

// POSICIONA A TABELA
IF cPed+cItem <> ZA1->(ZA1_PV+ZA1_ITEMPV)
	DBSELECTAREA("ZA1")
	DBSETORDER(2)
	IF !DBSEEK(XFILIAL("ZA1")+cPed+cItem)
		MsgAlert("Processo "+cPed+"/"+cItem+" nao localizado!")
		return(nil)
	endif
ENDIF


REGTOMEMORY("ZA1",.F.,.T.)
M->ZA1_STATUS := AFASE0[VAL(M->ZA1_STATUS)+1]


BEGINSQL ALIAS "TZ2"
	
	COLUMN ZA2_QTD AS NUMERIC(17,2)
	COLUMN ZA2_DATA AS DATE
	COLUMN ZA2_DTCHK AS DATE
	
	SELECT ZA2_OPER, ZA2_QTD, ZA2_DATA, ZA2_HR, ZA2_DTCHK, ZA2_HRCHK
	FROM %table:ZA2%
	WHERE %notdel%
	AND ZA2_PV = %exp:ZA1->ZA1_PV%
	AND ZA2_ITEMPV = %exp:ZA1->ZA1_ITEMPV%
	ORDER BY ZA2_DATA, ZA2_HR
	
ENDSQL

DBSELECTAREA("TZ2")
DBGOTOP()


WHILE TZ2->(!EOF())
	
	aColuna := {}
	TZ2->(AADD(aColuna,VAL(ZA2_OPER)))
	TZ2->(AADD(aColuna,TRANSFORM(ZA2_QTD,"@999,999.99")))
	TZ2->(AADD(aColuna,DTOC(ZA2_DATA)))
	TZ2->(AADD(aColuna,ZA2_HR))
	TZ2->(AADD(aColuna,DTOC(ZA2_DTCHK)))
	TZ2->(AADD(aColuna,ZA2_HRCHK))
	
	aadd(aLinha,acoluna)
	TZ2->(DBSKIP())
ENDDO

dbselectarea("TZ2")
DBCLOSEAREA()

pRIVATE oDlX , oGDX
DEFINE MSDIALOG oDlg Title "Visual" from 0,0 to 500,750 pixel

@005,005 say "STATUS" SIZE 30,10 PIXEL OF ODLG
@005,040 MSGET OGET VAR M->ZA1_STATUS SIZE 50,8 PIXEL OF ODLG  WHEN .F.
@020,005 say "PEDIDO" SIZE 30,10 PIXEL OF ODLG
@020,040 MSGET OGET VAR M->ZA1_PV SIZE 50,8 PIXEL OF ODLG  WHEN .F.
@035,005 say "OP" SIZE 30,10 PIXEL OF ODLG
@035,040 MSGET OGET VAR M->ZA1_OP SIZE 50,8 PIXEL OF ODLG  WHEN .F.
@050,005 say "CLIENTE" SIZE 30,10 PIXEL OF ODLG
@050,040 MSGET OGET VAR M->ZA1_NREDUZ SIZE 90,8 PIXEL OF ODLG  WHEN .F.
@065,005 say "PRODUTO" SIZE 30,10 PIXEL OF ODLG
@065,040 MSGET OGET VAR M->ZA1_COD SIZE 90,8 PIXEL OF ODLG  WHEN .F.
@080,005 say "DESCRICAO" SIZE 30,10 PIXEL OF ODLG
@080,040 MSGET OGET VAR M->ZA1_DESC SIZE 90,8 PIXEL OF ODLG  WHEN .F.
@095,005 say "PNUMBER" SIZE 30,10 PIXEL OF ODLG
@095,040 MSGET OGET VAR M->ZA1_PNUMBE SIZE 90,8 PIXEL OF ODLG  WHEN .F.
@110,005 say "CMARCA" SIZE 30,10 PIXEL OF ODLG
@110,040 MSGET OGET VAR M->ZA1_MARCA SIZE 90,8 PIXEL OF ODLG  WHEN .F.


@005,140 say "QTD PV" SIZE 30,10 PIXEL OF ODLG
@005,165 MSGET OGET VAR M->ZA1_QPV SIZE 50,8 PICTURE "@E 999,999.99" PIXEL OF ODLG  WHEN .F.
@020,140 say "QTD ENV" SIZE 30,10 PIXEL OF ODLG
@020,165 MSGET OGET VAR M->ZA1_QENV SIZE 50,8  PICTURE "@E 999,999.99" PIXEL OF ODLG  WHEN .F.
@035,140 say "QTD REC" SIZE 30,10 PIXEL OF ODLG
@035,165 MSGET OGET VAR M->ZA1_QREC SIZE 50,8  PICTURE "@E 999,999.99" PIXEL OF ODLG  WHEN .F.
@050,140 say "QTD DEV" SIZE 30,10 PIXEL OF ODLG
@050,165 MSGET OGET VAR M->ZA1_QDEV SIZE 90,8  PICTURE "@E 999,999.99" PIXEL OF ODLG  WHEN .F.
@065,140 say "QTD RET" SIZE 30,10 PIXEL OF ODLG
@065,165 MSGET OGET VAR M->ZA1_QRET SIZE 90,8 PICTURE "@E 999,999.99" PIXEL OF ODLG  WHEN .F.
@080,140 say "ITEM PV" SIZE 30,10 PIXEL OF ODLG
@080,165 MSGET OGET VAR M->ZA1_ITEMPV SIZE 20,8 PIXEL OF ODLG  WHEN .F.
@095,140 say "CAPACIDADE" SIZE 30,10 PIXEL OF ODLG
@095,165 MSGET OGET VAR M->ZA1_CAPACID SIZE 50,8 PIXEL OF ODLG  WHEN .F.


if len(aLinha) > 0
	
	@125,05 ListBox oLinha Fields Header "Fase", "Qtdade", "Dt Ini", "Hr Ini", "Dt Confir", "Hr Confir" Size 330,095 Pixel   Of oDlg
	oLinha:SetArray(aLinha)
	
	oLinha:bLine := {|| {aFase[aLinha[oLinha:nAt,1]],;
	aLinha[oLinha:nAt,2],;
	aLinha[oLinha:nAt,3],;
	aLinha[oLinha:nAt,4],;
	aLinha[oLinha:nAt,5],;
	aLinha[oLinha:nAt,6],;
	}}
	
ENDIF

ACTIVATE MSDIALOG ODLG CENTERED

RETURN(NIL)

//=====================================================
//=====================================================
//=====================================================
STATIC FUNCTION STATUSLAB(xPV)

Private aLinha := {}
Private aColuna := {}
Private cLinha
Private oLInha

BEGINSQL alias "PV"
	
	COLUMN C6_QTDVEN AS NUMERIC(17,2)
	
	SELECT C6_NUM, C6_ITEM, C6_PRODUTO, B1_DESC, C6_QTDVEN, ISNULL(Z1.ZA1_OP,' SEM OP ') C6_OP
	, B1_PNUMBER, B1_CAPACID, B1_MARCA
	FROM %table:SC6% C6
	LEFT JOIN %table:SB1% B1 ON B1.%notDel% AND B1.B1_FILIAL = %xfilial:SB1% AND B1.B1_COD = C6.C6_PRODUTO
	LEFT JOIN %table:ZA1% Z1 ON Z1.%notDel% AND Z1.ZA1_FILIAL = %xfilial:ZA1% AND Z1.ZA1_PV = C6.C6_NUM AND Z1.ZA1_ITEMPV = C6.C6_ITEM
	WHERE C6.%notDel%
	AND C6.C6_FILIAL = %xfilial:SC6%
	AND C6.C6_NUM = %exp:xPV%
	AND C6.C6_LOCAL = 'SL'
	
ENDSQL

DBSELECTAREA("PV")
DBGOTOP()

IF PV->(EOF())
	MsgAlert("Nao existe dados a serem processados!")
	DBSELECTAREA("PV")
	DBCLOSEAREA()
	return
ENDIF

WHILE PV->(!EOF())
	aColuna := {}
	PV->(AADD(aColuna,C6_NUM))
	PV->(AADD(aColuna,C6_ITEM))
	PV->(AADD(aColuna,C6_PRODUTO))
	PV->(AADD(aColuna,B1_PNUMBER))
	PV->(AADD(aColuna,B1_MARCA))
	PV->(AADD(aColuna,B1_CAPACID))
	PV->(AADD(aColuna,B1_DESC))
	PV->(AADD(aColuna,TRANSFORM(C6_QTDVEN,"@E 999,999.99")))
	PV->(AADD(aColuna,C6_OP))
	AADD(aLinha,aColuna)
	
	PV->(DBSKIP())
ENDDO

DBSELECTAREA("PV")
DBCLOSEAREA()

DEFINE MSDIALOG oDlg Title "Selecione o Produto" from 0,0 to 270,750 pixel

@010,010 ListBox oLinha Fields Header "Pedido","Item","Codigo","PNumber","Marca","Capacid","Descricao","Qtdade","OP"   Size 330,095 Pixel   Of oDlg
oLinha:SetArray(aLinha)

oLinha:bLine := {|| {aLinha[oLinha:nAt,1],;
aLinha[oLinha:nAt,2],;
aLinha[oLinha:nAt,3],;
aLinha[oLinha:nAt,4],;
aLinha[oLinha:nAt,5],;
aLinha[oLinha:nAt,6],;
aLinha[oLinha:nAt,7],;
aLinha[oLinha:nAt,8],;
aLinha[oLinha:nAt,9];
}}

oLinha:bLDblClick := {|| VERPV(aLinha[oLinha:nAt,1],aLinha[oLinha:nAt,2],aLinha[oLinha:nAt,9]) }


ACTIVATE MSDIALOG oDlg Centered


RETURN

STATIC FUNCTION VERPV(cP,cI,cO)

if alltrim(cO) == "SEM OP"
	MsgAlert("Item sem movimentacao para laboratorio")
	return
endif

ZA1VIEW(cP,cI)


return


STATIC FUNCTION COMOTA()

Private aCol := {}
Private aLinhA := {}

BEGINSQL ALIAS "TMP1"
	
	COLUMN ZA2_QTD AS NUMERIC(17,2)
	COLUMN ZA2_DATA AS DATE
	
	SELECT CASE WHEN ZA2_OPER = '3' THEN 'ESTOQUE' ELSE 'LABORATORIO' END RECEBER
	,ZA1_PNUMBE, ZA2_DATA, ZA2_HR,ZA1_MARCA, ZA1_CAPACI, ZA1_DESC , ZA2_QTD, ZA1_COD
	FROM %table:ZA2% ZA2 (NOLOCK)
	LEFT JOIN %table:ZA1% ZA1 (NOLOCK) ON ZA1.%NotDel% AND ZA1.ZA1_PV = ZA2.ZA2_PV AND ZA1.ZA1_ITEMPV = ZA2.ZA2_ITEMPV
	LEFT JOIN %table:SC6% C6  (NOLOCK) ON C6.%NotDel% AND C6.C6_NUM = ZA1.ZA1_PV AND C6.C6_ITEM = ZA1.ZA1_ITEMPV
	LEFT JOIN %table:SB2% B2 (NOLOCK) ON B2.%NotDel% AND B2.B2_COD = ZA1.ZA1_COD AND B2.B2_LOCAL = C6.C6_LOCAL
	WHERE ZA2.%NotDel%
	AND ZA2_OPER IN ('1','3')
	
ENDSQL

DBSELECTAREA("TMP1")
DBGOTOP()

while !eof()
	aCol := {}
	AADD(aCol,TMP1->RECEBER)
	AADD(aCol,TMP1->ZA1_PNUMBE)
	AADD(aCol,DTOC(TMP1->ZA2_DATA))
	AADD(aCol,TMP1->ZA2_HR)
	AADD(aCol,TMP1->ZA1_MARCA)
	AADD(aCol,TMP1->ZA1_CAPACI)
	AADD(aCol,TMP1->ZA1_DESC)
	AADD(aCol,TRANSFORM(TMP1->ZA2_QTD,"@E 999,999.99"))
	AADD(aCol,TMP1->ZA1_COD)
	AADD(aLinha,aCol)
	dbskip()
enddo

dbselectarea("TMP1")
dbclosearea("TMP1")

DEFINE MSDIALOG oDlg Title "Status em "+DTOC(date())+" - "+time() from 0,0 to 270,965 pixel

@010,010 ListBox oLinha Fields Header "RECEBER", "PNumber", "Data", "Hr", "Marca","Capacid.","Descricao","Qtdade"  Size 470,095 Pixel   Of oDlg
oLinha:SetArray(aLinha)

oLinha:bLine := {|| {aLinha[oLinha:nAt,1],;
aLinha[oLinha:nAt,2],;
aLinha[oLinha:nAt,3],;
aLinha[oLinha:nAt,4],;
aLinha[oLinha:nAt,5],;
aLinha[oLinha:nAt,6],;
aLinha[oLinha:nAt,7],;
aLinha[oLinha:nAt,8],;
aLinha[oLinha:nAt,9],;
}}
ACTIVATE MSDIALOG oDlg Centered


return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณZA1ATUST  บAutor  ณFernando Nakahara   บ Data ณ  02/02/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza campo ZA1_STATUS para ser chamado com             บฑฑ
ฑฑบ          ณ ZA1_STATUS = U_ZA1ATUST() no REPLACE DO APSDU              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ESPECIFICO ALPAX                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION ZA1ATUST()
RETURN QSTATUS(.F.)

STATIC FUNCTION QSTATUS(LABRE)
local 	AAREASTATUS := getArea()
Local 	cRet := "0"
DEFAULT LABRE := .T.

/* CAMPOS   ****************************************
ZA1->ZA1_QPV  QUANTIDADE PEDIDO DE VENDA
ZA1->ZA1_QENV    ||      ENVIADO
ZA1->ZA1_QREC    ||      RECEBIDO
ZA1->ZA1_QDEV    ||      DEVOLVIDO
ZA1->ZA1_QRET    ||      RETORNADO

*/
/* LEGENDAS ****************************************
0 - BR_BRANCO   * ABERTO / NAO PROCESSADO
1 - BR_VERDE    * ENVIO PARCIAL AO LABORATORIO
2 - BR_AZUL     * ENVIO TOTAL AO LABORATORIO
3 - BR_AMARELO  * RECEBIDO DO ESTOQUE
4 - BR_VERMELHO * DEVOLU็รO PARCIAL AO ESTOQUE
5 - BR_MARROM   * DEVOLU็รO TOTAL AO ESTOQUE
6 - BR_PRETO    * RETORNO CONFIRMADO AO ESTOQUE

****************************************************
*/
IF LABRE
   DBSELECTAREA("ZA1")
ENDIF
IF  ZA1_QENV <> 0 //--------------------------HOUVE ENVIO ?
	IF  ZA1_QREC <> 0 //----------------------HOUVE RECEBIMENTO ?
		IF  ZA1_QDEV <> 0 //------------------HOUVE DEVOLU็รO ?
			IF  (ZA1_QRET == ZA1_QDEV)//------RETORNO IGUAL AO DEVOLVIDO ?
				CRET := "6" // RETORNO TOTAL
			ELSEIF  (ZA1_QDEV <> ZA1_QREC) //-DEVOLVIDO IGUAL AO RECEBIDO ?
				CRET := "5" // DEVOLUCAO TOTAL
			ELSE
				CRET := "4" // DEVOLUCAO PARCIAL
			ENDIF
		ELSE
			CRET := "3" //RECEBIDO DO ESTOQUE
		ENDIF
	ELSE
		IF  ZA1_QENV ==  ZA1_QPV //------ ENVIO TUDO ?
			CRET := "2" // ENVIO TOTAL
		ELSE
			CRET := "1" // ENVIO PARCIAL
		ENDIF
	ENDIF
ELSE
	CRET := "0" // NยO PROCESSADO
ENDIF
RESTAREA(AAREASTATUS)
/*
IF ZA1->ZA1_QPV == ZA1->ZA1_QENV .AND. ZA1->ZA1_QENV > ZA1->ZA1_QREC
RETURN("2") // ENVIO TOTAL
ENDIF

IF ZA1->ZA1_QPV == ZA1->ZA1_QENV .AND. ZA1->ZA1_QENV == ZA1->ZA1_QREC
RETURN("3") // RECEBIDO TOTAL
ENDIF


IF ZA1->ZA1_QPV == ZA1->ZA1_QENV .AND. ZA1->ZA1_QENV == ZA1->ZA1_QREC  ;
.AND. ZA1->ZA1_QREC > ZA1->ZA1_QDEV
RETURN("4") // DEVOLUCAO PARCIAL
ENDIF

IF ZA1->ZA1_QPV == ZA1->ZA1_QENV .AND. ZA1->ZA1_QENV == ZA1->ZA1_QREC  ;
.AND. ZA1->ZA1_QREC == ZA1->ZA1_QDEV  .AND. ZA1->ZA1_QDEV > ZA1->ZA1_QRET
RETURN("5") // DEVOLUCAO TOTAL
ENDIF

IF ZA1->ZA1_QPV == ZA1->ZA1_QENV .AND. ZA1->ZA1_QENV == ZA1->ZA1_QREC  ;
.AND. ZA1->ZA1_QREC == ZA1->ZA1_QDEV  .AND. ZA1->ZA1_QDEV == ZA1->ZA1_QRET
RETURN("6") // RECEBIMENTO TOTAL
ENDIF


/*
//ENVIO PARCIAL
IF ZA1->ZA1_QPV > ZA1->ZA1_QENV
cRet := "1"
ENDIF

//ENVIO TOTAL
IF ZA1->ZA1_QPV == ZA1->ZA1_QENV
cRet := "2"
ENDIF

//RECEBIDO TOTAL
IF ZA1->ZA1_QENV == ZA1->ZA1_QREC
If ZA1->ZA1_QENV <> 0 .AND. ZA1->ZA1_QREC <> 0
cRet := "3"
Endif
ENDIF

//RETORNO PARCIAL
//IF ZA1->ZA1_QENV == ZA1->ZA1_QREC .AND. ZA1->ZA1_QREC > ZA1->ZA1_QDEV
IF cRet == "3" .AND. ZA1->ZA1_QREC > ZA1->ZA1_QDEV
cRet := "4"
ENDIF

//RETORNO TOTAL
IF ZA1->ZA1_QREC == ZA1->ZA1_QDEV
If ZA1->ZA1_QREC <> 0 .AND. ZA1->ZA1_QDEV <> 0
cRet := "5"
Endif
ENDIF

//RETORNADO
IF ZA1->ZA1_QDEV == ZA1->ZA1_QRET
If ZA1->ZA1_QDEV <> 0 .AND. ZA1->ZA1_QRET <> 0
cRet := "6"
Endif
ENDIF
//BIALE CLAUDIO END
*/
RETURN(cRet)



STATIC FUNCTION EST_GER()  


IF ZA1->ZA1_QENV <> 0 .OR. ZA1->ZA1_QREC <> 0 .OR. ZA1->ZA1_QDEV <> 0 .OR. ZA1->ZA1_QRET <> 0 
    MSGINFO("OPERACAO DE EXCLUSAO PODE SER EFETUADO APENAS EM OPERACOES SEM MOVIMENTO!!!")
    RETURN(NIL)
ENDIF
            

RETURN


STATIC FUNCTION PVAUTO()

// PRIVATE __LsX8 := .T.

PRIVATE lPCPA107 := .F.
// IGUAL FONTE MATA650, LINHA 144
PERGUNTE("MTA650",.F.)
FOR Z := 1 TO 20
    aSav650[z] := &("MV_PAR"+STRZERO(Z,2))
NEXT

A650Automa("SD3",0,6)

RETURN


