/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATA015   บAutor  ณOcimar Rolli        บ Data ณ  09/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Browse para controlar a emissao das guias de trafego dos   บฑฑ
ฑฑบ          ณ produtos controlados pelo Exercito                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿   
*/

#Include "Protheus.ch"
#Include "TopConn.ch"

User Function FATA019()

_cArqTmp := ""
_cIndTmp := ""

MsgRun("Aguarde, consultando as notas fiscais ...",,{ || _fBusca() })

cCadastro 	:= "Controle de selos"
aRotina 	:= { {"SELO ","U_Fatg19()",0,1} }

_aFields := { 	{"Referencia"     , "TM_PNUMBER",	"C",	15	,	00,	Nil	}	,;
				{"Descricao"      , "TM_DESC"	,	"C",	70	,	00,	Nil	}	,;
				{"Marca"	      ,	"TM_MARCA"	,	"C",	20	,	00,	Nil	}	,;
				{"Cliente"    	  ,	"TM_CLIENTE",   "C",    50	,	00,	Nil	}	,;
				{"Nota Fiscal"	  ,	"TM_NOTA"	,	"C",	09	,	00,	Nil	}	,;				
				{"Codigo Exercito",	"TM_CODEXE"	,	"C",	06	,	00,	Nil	}	}

mBrowse( 6,1,22,75,"TMP",_aFields,,,,,)

TMP->(DbCloseArea())
Ferase(_cArqTmp+".DBF")
Ferase(_cIndTmp+OrdBagExt())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fBusca   บAutor  ณOcimar Rolli        บ Data ณ  09/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para montar uma query onde buscara as notas fiscais บฑฑ
ฑฑบ          ณ faltando emitir guia de trafego.                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fBusca()

_cQuery :="SELECT B1_PNUMBER "
_cQuery +=",      B1_DESC "
_cQuery +=",      B1_MARCA "
_cQuery +=",      D2.D2_DOC "
_cQuery +=",      A1.A1_NOME "
_cQuery +=",      C6.C6_AXCODEX "
_cQuery +=",      D2.R_E_C_N_O_ "
_cQuery +="FROM " + RetSqlName("SD2") + " D2 "
_cQuery +="      INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery +="              ON B1_FILIAL = '" + xFilial("SB1") + "' AND D2.D2_COD = B1.B1_COD "
_cQuery +="      INNER JOIN " + RetSqlName("SC6") + " C6 "
_cQuery +="              ON C6_FILIAL = '" + xFilial("SC6") + "' AND D2.D2_PEDIDO = C6.C6_NUM AND D2.D2_ITEMPV = C6.C6_ITEM "
_cQuery +="      INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery +="              ON A1_FILIAL = '" + xFilial("SA1") + "' AND D2.D2_CLIENTE = A1.A1_COD "
_cQuery +="WHERE D2_FILIAL = '" + xFilial("SD2") + "' AND D2.D_E_L_E_T_ = ' ' "
_cQuery +="      AND   C6.C6_AXCODEX <> ' ' "
_cQuery +="      AND   D2.D2_SERIE = '1' AND D2.D2_AXGUTR = ' ' "
_cQuery +="ORDER BY D2.D2_DOC "

TcQuery _cQuery New Alias "QR1"

_aCampos := { 	{ 	"TM_PNUMBER"	,	"C"	,	15	,	00 	}	,;
				{ 	"TM_DESC"       ,	"C"	,	70	,	00 	}	,;
				{	"TM_MARCA"		,	"C"	,	20	,	00	}	,;
				{	"TM_NOTA"		,	"C"	,	09	,	00	}	,;
				{	"TM_CLIENTE"	,	"C"	,	50	,	00	}	,;								
				{	"TM_CODEXE"		,	"C"	,	06	,	00	}	,;				
				{	"TM_RECNO"		,	"N"	,	15	,	00	}}

_cArqTmp := Criatrab(_aCampos,.t.)
_cIndTmp := Criatrab(,.f.)

DbUseArea(.t.,,_cArqTmp,"TMP",.f.,.f.)
IndRegua("TMP",_cIndTmp,"TM_NOTA",,,"Criando Indice")

QR1->(DbGoTop())

Do While ! QR1->(Eof())
	RecLock("TMP",.t.)
	TMP->TM_PNUMBER	:= QR1->B1_PNUMBER
	TMP->TM_DESC	:= QR1->B1_DESC
	TMP->TM_MARCA	:= QR1->B1_MARCA
	TMP->TM_NOTA	:= QR1->D2_DOC
	TMP->TM_CLIENTE	:= QR1->A1_NOME	
	TMP->TM_CODEXE  := QR1->C6_AXCODEX 
	TMP->TM_RECNO   := QR1->R_E_C_N_O_
	TMP->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFatg19    บAutor  ณOcimar Rolli        บ Data ณ  09/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de gravacao do numero do selo da guia de trafego    บฑฑ
ฑฑบ          ณ na nota fiscal.                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Fatg19()

_cSelo := space(10)
_cTitulo := 'Selo da guia de trafego'
_dDtGuia := dDataBase

DEFINE FONT oFont  NAME "Arial" SIZE 0, -12 BOLD   

Define MsDialog _oDlg1 Title OemToAnsi("GUIA DE TRAFEGO") From 2,10 TO 200,500 of oMainWnd PIXEL

oSay  := TSay():New( 015, 010, {||"Nota Fiscal "}      ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 015, 100, {||TMP->TM_NOTA}  	  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,100,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 030, 010, {||"Cliente "}		  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 40,10,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 030, 100, {||TMP->TM_CLIENTE}    ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,         ,,140,20,.F.,.F.,.F.,.F.,.F.)
oSay  := TSay():New( 055, 010, {||"Numero do Selo "}  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 70,10,.F.,.F.,.F.,.F.,.F.)
@ 055,100 MsGet oSelo   Var _cSelo   VALID naovazio()            Size 40,08 Pixel of _oDlg1
oSay  := TSay():New( 070, 010, {||"Data da Guia"}  ,_oDlg1,,oFont,.F.,.F.,.F.,.T.,CLR_GREEN,, 70,10,.F.,.F.,.F.,.F.,.F.)
@ 070,100 MsGet oDtGuia Var _dDtGuia VALID _dDtGuia <= dDataBase Size 40,08 Pixel of _oDlg1

ACTIVATE MSDIALOG _oDlg1 CENTERED ON INIT EnchoiceBar(_oDlg1,{||fGrava(),_oDlg1:End()}, {||_oDlg1:End()},,)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGrava    บAutor  ณMicrosiga           บ Data ณ  07/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/   

Static Function fGrava()

_aArea := GetArea()

SD2->(DbGoTo(TMP->TM_RECNO))
RecLock("SD2",.f.)
SD2->D2_AXGUTR := _cSelo
SD2->D2_AXDTGT := _dDtGuia
SD2->(MsUnLock())
                 
	RecLock("TMP",.f.)
	delete
	TMP->(MsUnLock())
	
RestArea(_aArea)
Return

