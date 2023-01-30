#INCLUDE "PROTHEUS.CH"
#INCLUDE "REPORT.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ALPR001   ºAutor  ³ Biale              º Data ³  05/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ALLPAX                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION ALPR010()
LOCAL oReport
LOCAL oZB1
LOCAL cAlias1	:= GetNextAlias() 
LOCAL cPerg		:= "ALPA10"
Local oBreak
                
PRIVATE cCelAnt := ""
PRIVATE nSeqAnt := ""
                       
cPerg := PADR(cPerg,10)

PERGUNTE(cPerg,.F.)

DEFINE REPORT oReport NAME "ALPR010" TITLE "Relatório de Substituição Tributária" PARAMETER cPerg ;
ACTION {|oReport| PrintReport(oReport, oZB1, cAlias1 )}

DEFINE SECTION       oZB1 		OF oReport TITLE "NFs X NFe" TABLES ("ZB1", "SD2")

oZB1:SetLineBreak() 

DEFINE CELL  NAME "CAMPOX"			OF oZB1 	TITLE 	"      Saida     "+Chr(13)+Chr(10)+;
														"Numero Documento"						ALIAS "   " BLOCK {|| ALPCANPRT(oZB1, cAlias1, '1')}
//DEFINE CELL  NAME "ZB1_NFSNUM"		OF oZB1 	TITLE "Documento de Saída "					ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_NFSSER"   	OF oZB1 	TITLE 	"Saida"+Chr(13)+Chr(10)+;
														"Série"									ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_NFSITM"    	OF oZB1 	TITLE 	"Saida "+Chr(13)+Chr(10)+;
														" Item "								ALIAS "ZB1"
//DEFINE CELL  NAME "ZB1_EMISSA"	OF oZB1		TITLE 	"Data de "								ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_NFSQTD"    	OF oZB1 	TITLE 	"  Saida   "+Chr(13)+Chr(10)+;
														"Quantidade"							ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_NFSVAL"    	OF oZB1 	TITLE 	"   Saida   "+Chr(13)+Chr(10)+;
														"Valor Unit."							ALIAS "ZB1"
DEFINE CELL  NAME "NFESEQ"    		OF oZB1 	TITLE 	"Sequencial"							ALIAS "   " BLOCK {|| ALPCANPRT(oZB1, cAlias1, '2')}
DEFINE CELL  NAME "ZB1_NFENUM"    	OF oZB1 	TITLE 	"Documento de Entrada"					ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_NFESER"    	OF oZB1 	TITLE 	"Serie"									ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_NFEITM" 		OF oZB1 	TITLE 	"Item"									ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_NFEQTD"    	OF oZB1 	TITLE 	"Qtd Apropr."							ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_ICMSRE"    	OF oZB1 	TITLE 	"ICMS Entrada"							ALIAS "ZB1"
DEFINE CELL  NAME "ZB1_ICMSRS"    	OF oZB1 	TITLE 	"ICMS Saída"							ALIAS "ZB1"

//oBreak := TRBreak():New(oZB1, oZB1:Cell("ZB1_ICMSRE"),"Sub Total ICMS")
//TRFunction():New(oSection:Cell("A1_COD"),NIL,"COUNT",oBreak)
TRFunction():New(oZB1:Cell("ZB1_ICMSRE"),NIL,"SUM",oBreak)
                                                                                                                                                
//oZB1:Cell("CAMPOX"):Disable()

oReport:PrintDialog()

RETURN

STATIC FUNCTION PrintReport(oReport, oSess, cAlias)
LOCAL cQuery := ""
#IFDEF TOP

	BEGIN REPORT QUERY oSess
	
	BEGINSQL Alias cAlias                                      
	
		SELECT	ZB1_FILIAL, ZB1_NFENUM, ZB1_NFESER, ZB1_EMISSA, ZB1_NFEITM, 
				ZB1_PRODUT, ZB1_NFEQTD, ZB1_NFESEQ, ZB1_NFSNUM, ZB1_NFSSER, 
				ZB1_NFSITM, ZB1_NFSQTD, ZB1_NFSVAL, ZB1_ICMSRS, ZB1_ICMSRE
		FROM  	%Table:ZB1% ZB1   
		LEFT JOIN %TABLE:SD2% D2 ON D2.%NOTDEL% AND D2.D2_FILIAL = %XFILIAL:SD2% AND D2.D2_DOC = ZB1.ZB1_NFSNUM
                                                                  AND D2.D2_SERIE = ZB1.ZB1_NFSSER
                                                                  AND D2.D2_ITEM = ZB1.ZB1_NFSITM
		WHERE	ZB1.ZB1_FILIAL	= %xFilial:ZB1%	   											AND
				D2.D2_EMISSAO 	BETWEEN %Exp:DTOS(MV_PAR01)% 	AND %Exp:DTOS(MV_PAR02)% 	AND
				ZB1.ZB1_PRODUT  BETWEEN %Exp:MV_PAR03%          AND %Exp:MV_PAR04%          AND				
				ZB1.%notDel%
		ORDER BY ZB1_NFSNUM, ZB1_NFSSER, ZB1_NFSITM		
		
	ENDSQL
	
	cQuery := GetLastQuery()[2]	
	
	END REPORT QUERY oSess
	
	oSess:Print()
#ENDIF
RETURN

STATIC FUNCTION ALPCANPRT(oSection, cAlias, cOper)
LOCAL cRet := ''

If cOper == '1'
	cRet := &(cAlias+"->ZB1_NFSNUM")
	If ALLTRIM(cCelAnt) == ALLTRIM(&(cAlias+"->ZB1_NFSNUM")+&(cAlias+"->ZB1_NFSSER")+&(cAlias+"->ZB1_NFSITM") )
		nSeqAnt++
		If Empty(cCelAnt)
			cCelAnt := &(cAlias+"->ZB1_NFSNUM")+&(cAlias+"->ZB1_NFSSER")+&(cAlias+"->ZB1_NFSITM")
		Else
			oSection:Cell("CAMPOX"):Hide()
			oSection:Cell("ZB1_NFSSER"):Hide()
			oSection:Cell("ZB1_NFSITM"):Hide()
		//	oSection:Cell("ZB1_EMISSA"):Hide()
			oSection:Cell("ZB1_NFSQTD"):Hide()
			oSection:Cell("ZB1_NFSVAL"):Hide()
		EndIf
	Else
		cCelAnt := &(cAlias+"->ZB1_NFSNUM")+&(cAlias+"->ZB1_NFSSER")+&(cAlias+"->ZB1_NFSITM")
		nSeqAnt := 1
		oSection:Cell("CAMPOX"):Show()
		oSection:Cell("ZB1_NFSSER"):Show()
		oSection:Cell("ZB1_NFSITM"):Show()
	//	oSection:Cell("ZB1_EMISSA"):Show()
		oSection:Cell("ZB1_NFSQTD"):Show()
		oSection:Cell("ZB1_NFSVAL"):Show()
	EndIf
Else
	cRet := StrZero(nSeqAnt,3)
EndIf

RETURN cRet