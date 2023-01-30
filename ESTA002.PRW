/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTA002   บAutor  ณAdriano Luis Brandaoบ Data ณ  17/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Browse para controlar a entrega dos laudos das notas       บฑฑ
ฑฑบ          ณ fiscais de saida.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿   
alterado
*/
#Include "Rwmake.ch"
#Include "TopConn.ch"

User Function ESTA002()

Local    cPerg := "ESTA002"
Local _cArqTmp := ""
Local _cIndTmp := ""
Local _cGrEmb  := ""
Local dDtInic  := ""
Local dDtFim   := ""


//Cria perguntas 
fVldPerg(cPerg)

//Exibe a tela com as perguntas
IF !Pergunte(cPerg, .T.)
	Return nil
Endif

dDtInic := MV_PAR01
dDtFim	:= MV_PAR02

MsgRun("Aguarde, consultando os pedidos de vendas ...",,{ || _fBusca() })

cCadastro 	:= "Entrega de Laudos"
aRotina 	:= { {"Laudo Coletado" ,"U_Entr002()" ,0,1} ,;
{"Anexado na Nota","U_Entr003()",0,2} }

_aFields := { 	{"Pedido"				, 	"TM_PEDIDO"	,	"C",	06	,	00,	Nil	}	,;
{"Nota Fiscal"			, 	"TM_NFISCAL",	"C",	09	,	00,	Nil	}	,;
{"R.Social do Cliente"	,	"TM_NREDUZ"	,	"C",	20	,	00,	Nil	}	,;
{"Item"					,	"TM_ITEM"	,	"C",	02	,	00,	Nil	}	,;
{"Codigo Produto"		,	"TM_COD"	,	"C",	15	,	00,	Nil	}	,;
{"P.N."					,	"TM_PNUMBER",	"C",	20	,	00,	Nil	}	,;
{"Descricao Produto"	,	"TM_DESC"	,	"C",	30	,	00,	Nil	}	,;
{"Numero do Lote"       ,   "TM_LOTECTL",   "C",    10  ,   00, Nil }	,;
{"Validade"				,	"TM_DTVALID",	"D",	08	,	00,	Nil	}	,;
{"Cl. Risco"			,	"TM_CRISCO"	,	"C",	03	,	00,	Nil	}	,;
{"Nr. Risco"			,	"TM_NRISCO"	,	"C",	04	,	00,	Nil	}	,;
{"Nr. Onu"		    	,	"TM_NONU"	,	"C",	04	,	00,	Nil	}	,;
{"Gr. Embalagem"		,	"TM_GREMB"	,	"C",	09	,	00,	Nil	}	}



aCores := 	{	{ " Empty(TM_XLAUDO)"	, 'BR_VERDE' 	}	,;
{ " TM_XLAUDO == 'S'" 	, 'BR_AMARELO' 	}	}

mBrowse( 6,1,22,75,"TMP",_aFields,,,,,aCores)

TMP->(DbCloseArea())
Ferase(_cArqTmp+".DBF")
Ferase(_cIndTmp+OrdBagExt())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fBusca   บAutor  ณAdriano Luis Brandaoบ Data ณ  17/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para montar uma query onde buscara as notas fiscais บฑฑ
ฑฑบ          ณ com Laudo e que nao foram entregues.                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fBusca()

_cQuery := "SELECT C9_PEDIDO, C9_NFISCAL, C9_ITEM, C9_PRODUTO, B1_DESC, B1_PNUMBER, A1_NREDUZ, B1_AXRISCO, "
_cQuery += "       C9_CLIENTE, C9_LOJA, C9_LOTECTL, C9_DTVALID, C9.R_E_C_N_O_, C9_XLAUDO, B1_AXNONU, B1_AXNRRIS, B1_AXGREMB "
_cQuery += "FROM " + RetSqlName("SC9") + " C9 "
_cQuery += "       INNER JOIN " + RetSqlName("SC6") + " C6 "
_cQuery += "               ON C6_FILIAL = '" + xFilial("SC6") + "' AND C6_NUM = C9_PEDIDO AND C6_ITEM = C9_ITEM "
_cQuery += "       INNER JOIN " + RetSqlName("SB1") + " B1 "
_cQuery += "               ON B1_FILIAL = '" + xFilial("SB1") + "' AND B1_COD = C9_PRODUTO "
_cQuery += "       INNER JOIN " + RetSqlName("SA1") + " A1 "
_cQuery += "               ON A1_FILIAL = '" + xFilial("SA1") + "' AND A1_COD = C9_CLIENTE AND A1_LOJA = C9_LOJA "
_cQuery += "WHERE C9_FILIAL = '" + xFilial("SC9") + "' AND C6_AXLAUDO = 'S' AND C9_XLAUDO <> 'F' AND C9_LOCAL = '01' "
_cQuery += "      AND ((C9_BLEST+C9_BLCRED) IN ('    ','1010')) AND C9_LOTECTL <> ' ' "
_cQuery += "      AND C9.D_E_L_E_T_ = ' ' AND C6.D_E_L_E_T_ = ' ' AND B1.D_E_L_E_T_ = ' ' AND A1.D_E_L_E_T_ = ' ' "
_cQuery += "      AND C6.C6_ENTREG between '"+dtos(MV_PAR01)+"' and '"+dtos(MV_PAR02)+"' "
_cQuery += "ORDER BY C9_PEDIDO "
 MemoWrite("\queries\esta002.sql",_cQuery)

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","C9_DTVALID","D",8,0)

_aCampos := { 	{ 	"TM_PEDIDO"	,	"C"	,	06	,	00 	}	,;
{ 	"TM_NFISCAL",	"C"	,	09	,	00 	}	,;
{	"TM_NREDUZ"	,	"C"	,	20	,	00	}	,;
{	"TM_ITEM"	,	"C"	,	02	,	00	}	,;
{	"TM_CRISCO"	,	"C"	,	03	,	00	}	,;
{	"TM_COD"	,	"C"	,	15	,	00	}	,;
{	"TM_PNUMBER",	"C"	,	20	,	00	}	,;
{	"TM_DESC"	,	"C"	,	30	,	00	}	,;
{	"TM_CLIENTE",	"C"	,	06	,	00	}	,;
{	"TM_LOJA"	,	"C"	,	02	,	00	}	,;
{   "TM_LOTECTL",   "C" ,   10  ,   00  }	,;
{   "TM_DTVALID",   "D" ,   08	,   00 	}	,;
{	"TM_RECNO"	,	"N"	,	15	,	00	}	,;
{   "TM_XLAUDO" ,   "C" ,   01  ,   00  }   ,;
{	"TM_NRISCO"	,	"C",	04	,	00	}	,;
{	"TM_NONU"	,	"C",	04	,	00	}	,;
{	"TM_GREMB"	,	"C",	09	,	00	}}

_cArqTmp := Criatrab(_aCampos,.t.)
_cIndTmp := Criatrab(,.f.)

DbUseArea(.t.,,_cArqTmp,"TMP",.f.,.f.)
IndRegua("TMP",_cIndTmp,"TM_NREDUZ+TM_CRISCO+TM_PEDIDO",,,"Criando Indice")

QR1->(DbGoTop())

Do While ! QR1->(Eof())


Do Case
	Case QR1->B1_AXGREMB == "A"
		_cGrEmb := "Grupo I"
	Case QR1->B1_AXGREMB == "B"
		_cGrEmb := "Grupo II"
	Case QR1->B1_AXGREMB == "C"
		_cGrEmb := "Grupo III"
	Case QR1->B1_AXGREMB == "D"
		_cGrEmb := " "
	Case QR1->B1_AXGREMB == " "
	 	_cGrEmb := " "		
EndCase
*-
	RecLock("TMP",.t.)
	TMP->TM_PEDIDO	:= QR1->C9_PEDIDO
	TMP->TM_NFISCAL	:= QR1->C9_NFISCAL
	TMP->TM_NREDUZ	:= QR1->A1_NREDUZ
	TMP->TM_ITEM	:= QR1->C9_ITEM
	TMP->TM_CRISCO  := QR1->B1_AXRISCO
	TMP->TM_COD		:= QR1->C9_PRODUTO
	TMP->TM_DESC	:= QR1->B1_DESC
	TMP->TM_CLIENTE	:= QR1->C9_CLIENTE
	TMP->TM_LOJA	:= QR1->C9_LOJA
	TMP->TM_LOTECTL := QR1->C9_LOTECTL
	TMP->TM_PNUMBER := QR1->B1_PNUMBER
	TMP->TM_DTVALID	:= QR1->C9_DTVALID
	TMP->TM_RECNO	:= QR1->R_E_C_N_O_
	TMP->TM_XLAUDO  := QR1->C9_XLAUDO
	TMP->TM_NRISCO  := QR1->B1_AXNRRIS
    TMP->TM_NONU    := Alltrim(Str(QR1->B1_AXNONU))
    TMP->TM_GREMB   := _cGrEmb
	TMP->(MsUnLock())
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณENTR002   บAutor  ณAdriano Luis Brandaoบ Data ณ  17/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de gravacao de laudo coletado aguardando numero da  บฑฑ
ฑฑบ          ณ nota fiscal para anexar o laudo.                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Entr002()

_aArea := GetArea()

SC9->(DbGoTo(TMP->TM_RECNO))
RecLock("SC9",.f.)
SC9->C9_XLAUDO := "S"
TMP->TM_XLAUDO := "S"
SC9->(MsUnLock())

RestArea(_aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณENTR003   บAutor  ณAdriano Luis Brandaoบ Data ณ  17/09/04   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de gravacao de anexado laudo na nota fiscal e       บฑฑ
ฑฑบ          ณ deleta o registro do arquivo temporario                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Entr003()

_aArea := GetArea()

SC9->(DbGoTo(TMP->TM_RECNO))
If TMP->TM_XLAUDO == 'S'
	RecLock("SC9",.f.)
	SC9->C9_XLAUDO := "F"
	SC9->(MsUnLock())
	
	RecLock("TMP",.f.)
	delete
	TMP->(MsUnLock())
Else
	ApMsgStop("LAUDO NAO COLETADO, COLETAR LAUDO PRIMEIRO !!!!")
EndIf


RestArea(_aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษÝÝÝÝÝÝÝÝÝÝัÝÝÝÝÝÝÝÝÝÝหÝÝÝÝÝÝÝัÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝหÝÝÝÝÝÝัÝÝÝÝÝÝÝÝÝÝÝÝÝปฑฑ
ฑฑบPrograma  ณValidperg บAutor  ณ                             บ Data ณ    บฑฑ
ฑฑฬÝÝÝÝÝÝÝÝÝÝุÝÝÝÝÝÝÝÝÝÝสÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝสÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝนฑฑ
ฑฑบDesc.     ณ Cria as perguntas da rotina                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬÝÝÝÝÝÝÝÝÝÝุÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝÝผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fVldPerg(cPerg)

	Local aRegs   :={}
	Local x	:= 0
	Local y := 0


	aAdd(aRegs,{cPerg,"01","Data de Entrega de?                   ","","","mv_ch1","D",06,0,0,"G","","mv_par01",""   				,"","","",""   				,"","","","","","","","","","","","","","","","","","","",""	,"","",""})
	aAdd(aRegs,{cPerg,"02","Data de Entrega ate?                  ","","","mv_ch2","D",06,0,0,"G","","mv_par02",""   				,"","","",""   				,"","","","","","","","","","","","","","","","","","","",""	,"","",""})

	dbSelectArea("SX1")
	dbSetOrder(1)
	For x := 1 to Len(aRegs)
		if !SX1->( dbSeek(PADR(cPerg,10)+PADL( x,2,"0")) )
			RecLock("SX1",.T.)
			For y:=1 to FCount()
				If y <= Len(aRegs[x])
					FieldPut(y,aRegs[x,y])
				Endif
			Next
			MsUnlock()
		Endif
	Next


Return
