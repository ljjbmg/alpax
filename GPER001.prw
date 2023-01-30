/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER001   ºAutor  ³Ocimar Rolli        º Data ³  27/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de funcionarios conforme opcao dos parametros do  º±±
±±º          ³usuario                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function GPER001()

_cPerg := "GPER01"

PutSx1(_cPerg,"01","Admissao de " ,"Admissao de " ,"Admissao de " ,"mv_ch1","D",08,0,0,"G","","","","","mv_par01",""  ,""    ,""   ,""      ,""   ,""   ,"","","","","","","","","","",,,)
PutSx1(_cPerg,"02","Admissao ate" ,"Admissao ate" ,"Admissao ate" ,"mv_ch1","D",08,0,0,"G","","","","","mv_par02",""  ,""    ,""   ,""      ,""   ,""   ,"","","","","","","","","","",,,)
PutSx1(_cPerg,"03","Demissao de " ,"Demissao de " ,"Demissao de " ,"mv_ch1","D",08,0,0,"G","","","","","mv_par03",""  ,""    ,""   ,""      ,""   ,""   ,"","","","","","","","","","",,,)
PutSx1(_cPerg,"04","Demissao ate" ,"Demissao ate" ,"Demissao ate" ,"mv_ch1","D",08,0,0,"G","","","","","mv_par04",""  ,""    ,""   ,""      ,""   ,""   ,"","","","","","","","","","",,,)
PutSx1(_cPerg,"05","Salario ?   " ,"Salario ?   " ,"Salario ?   " ,"mv_ch1","N",01,0,0,"C","","","","","mv_par05","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr001() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fImpr001  ºAutor  ³Ocimar Rolli        º Data ³  27/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de processamento do relatorio.                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fImpr001()

Private nColIni 	:= 0040
Private nColFim 	:= 2320
Private nRowIni		:= 0040
Private nRowFim 	:= 3340
Private oPrint

// Fontes utilizadas no relatorio.
Private oFont8		:= TFont():New("Arial"			,09,08,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10C	:= TFont():New("Courier New"	,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont11C	:= TFont():New("Courier New"	,10,11,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10		:= TFont():New("Arial"			,09,10,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("Arial"			,09,10,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont11N	:= TFont():New("Courier New"	,09,11,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12S	:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.T.)
Private oFont12N	:= TFont():New("Arial"			,12,12,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont12		:= TFont():New("Arial"			,12,12,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14 	:= TFont():New("Arial"			,13,14,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont14N	:= TFont():New("Arial"			,13,14,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16S	:= TFont():New("Arial"			,15,16,.T.,.F.,5,.T.,5,.T.,.T.)
Private oFont16N	:= TFont():New("Arial"			,15,16,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont18N	:= TFont():New("Arial"			,16,18,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont20N	:= TFont():New("Arial"			,18,20,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont21N	:= TFont():New("Arial"			,20,21,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont25N	:= TFont():New("Arial"			,25,25,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont28N	:= TFont():New("Arial"			,28,28,.T.,.T.,5,.T.,5,.T.,.F.)
Private oFont16		:= TFont():New("Arial"			,14,16,.T.,.F.,5,.T.,5,.T.,.F.)

_cQuery :="SELECT * "
_cQuery +="FROM (SELECT 'A' TIPOREG "
_cQuery +="             ,SRA010.RA_CC AS DEPARTAMENTO "
_cQuery +="      		,SRA010.RA_MAT AS MATRICULA "
_cQuery +="     		,SRA010.RA_NOME AS FUNCIONARIO "
_cQuery +="     		,SRJ010.RJ_DESC AS FUNCAO "
_cQuery +="     		,SRA010.RA_SALARIO AS SALARIO "
_cQuery +="		        ,SRA010.RA_ADMISSA AS ADMISSAO "
_cQuery +="		        ,ISNULL(SRA010.RA_DEMISSA,'        ') AS DEMISSAO "
_cQuery +="		        ,DATEDIFF(MONTH,(SRA010.RA_ADMISSA),(SRA010.RA_DEMISSA)) MES_EMPRESA "
_cQuery +="		     FROM "+RetSqlName("SRA")+" SRA010 "
_cQuery +="		       INNER JOIN "+RetSqlName("SRJ")+" SRJ010 "
_cQuery +="		         ON SRA010.RA_CODFUNC = SRJ010.RJ_FUNCAO "
_cQuery +="		 WHERE SRA010.D_E_L_E_T_ = ' ' "
_cQuery +="		    AND   SRA010.RA_ADMISSA BETWEEN '" + DtoS(MV_PAR01) +" ' AND '" + DtoS(MV_PAR02) +" ' "
_cQuery +="		    AND   SRA010.RA_DEMISSA BETWEEN '" + DtoS(MV_PAR03) +" ' AND '" + DtoS(MV_PAR04) +" ' "
_cQuery +="		UNION ALL "
_cQuery +="		SELECT MAX('S') TIPOREG "
_cQuery +="		        ,SRA010.RA_CC AS DEPARTAMENTO "
_cQuery +="		        ,MAX(' ') A  "
_cQuery +="		        ,MAX(' ') B  "
_cQuery +="		        ,MAX(' ') C  "
_cQuery +="		        ,SUM(SRA010.RA_SALARIO) AS SALARIO "
_cQuery +="		        ,MAX(' ') D  "
_cQuery +="		        ,MAX(' ') E  "
_cQuery +="		        ,COUNT(DATEDIFF(MONTH,(SRA010.RA_ADMISSA),(SRA010.RA_DEMISSA))) MES_EMPRESA "
_cQuery +="		     FROM "+RetSqlName("SRA")+" SRA010 "
_cQuery +="		       INNER JOIN "+RetSqlName("SRJ")+" SRJ010 "
_cQuery +="		         ON SRA010.RA_CODFUNC = SRJ010.RJ_FUNCAO "
_cQuery +="		 WHERE SRA010.D_E_L_E_T_ = ' ' "
_cQuery +="		    AND   SRA010.RA_ADMISSA BETWEEN '" + DtoS(MV_PAR01) +" ' AND '" + DtoS(MV_PAR02) +" ' "
_cQuery +="		    AND   SRA010.RA_DEMISSA BETWEEN '" + DtoS(MV_PAR03) +" ' AND '" + DtoS(MV_PAR04) +" ' "
_cQuery +="		 GROUP BY SRA010.RA_CC) AS FOLHA "
_cQuery +="		 ORDER BY  TIPOREG, DEPARTAMENTO, FUNCIONARIO "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","MATRICULA"      ,"C",06,0)
TcSetField("QR1","FUNCIONARIO"    ,"C",30,0)
TcSetField("QR1","FUNCAO"         ,"C",30,0)
TcSetField("QR1","SALARIO"        ,"N",12,2)
TcSetField("QR1","DEPARTAMENTO"   ,"C",09,0)
TcSetField("QR1","ADMISSAO"       ,"D",08,0)
TcSetField("QR1","DEMISSAO"       ,"D",08,0)
TcSetField("QR1","MES_EMPRESA"    ,"N",04,0)

oPrint:= TMSPrinter():New( "Relacao de funcionarios" )
oPrint:SetPortrait() // SetLandscape()

nLin      := 1
nPos      := 0400

Do While ! QR1->(Eof()) .And. QR1->TIPOREG == 'A'
	If nLin == 1
		nPos := 0400
		fFormCab()
	EndIf
	fFormDet()
	QR1->(DbSkip())
EndDo

nLin      := 1
nPos      := 0300

Do While ! QR1->(Eof()) .And. QR1->TIPOREG == 'S'
	If nLin == 1
		nPos      := 0300
		oPrint:EndPage()
		fFormRes()
	EndIf
	fFormRDe()
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

oPrint:Preview()

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormCab  ºAutor  ³Ocimar Rolli        º Data ³  27/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta formulario completo, para preencher coom os dados.   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fFormCab()

_aTab := {"JANEIRO","FEVEREIRO","MARÇO","ABRIL","MAIO","JUNHO","JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}
_cMesI := _aTab[Month(MV_PAR01)]
_cMesF := _aTab[Month(MV_PAR02)]
_cAnoI := Strzero(Year(MV_PAR01),4)
_cAnoF := Strzero(Year(MV_PAR02),4)

oPrint:StartPage()

// BOX CABECALHO 1
oPrint:Box(nRowIni,nColIni,nRowIni+0100,nColFim)
oPrint:Say(nRowIni+0050,nColIni+0300,"Relacao de funcionarios admitidos de "+_cMesI+" de "+_cAnoI+"  ate "+_cMesF+" de "+_cAnoF  ,oFont11N)

// BOX E CABECALHO DOS DETALHES
oPrint:Box(nRowIni+0150,nColIni,nRowIni+0350,nColFim)
oPrint:Say(nRowIni+0200,nColIni+0050,"Matricula"                                                       ,oFont10N)
oPrint:Say(nRowIni+0200,nColIni+0500,"Funcionario"                                                     ,oFont10N)
oPrint:Say(nRowIni+0200,nColIni+1400,"Funcao"                                                          ,oFont10N)
oPrint:Say(nRowIni+0300,nColIni+0050,"Salario"                                                         ,oFont10N)
oPrint:Say(nRowIni+0300,nColIni+0500,"Centro de Custo"                                                 ,oFont10N)
oPrint:Say(nRowIni+0300,nColIni+1000,"Admissao"                                                        ,oFont10N)
oPrint:Say(nRowIni+0300,nColIni+1400,"Demissao"                                                        ,oFont10N)
oPrint:Say(nRowIni+0300,nColIni+1800,"Tempo de empresa(meses)"                                         ,oFont10N)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormDet  ºAutor  ³Ocimar Rolli        º Data ³  27/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Detalhes do relatorio                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fFormDet()

// BOX DETALHES - ITENS
oPrint:Box(nRowIni+nPos,nColIni,nRowIni+nPos+0150,nColFim)
oPrint:Say(nRowIni+nPos,nColIni+0050,QR1->MATRICULA                                                  ,oFont10)
oPrint:Say(nRowIni+nPos,nColIni+0500,QR1->FUNCIONARIO                                                ,oFont10)
oPrint:Say(nRowIni+nPos,nColIni+1400,QR1->FUNCAO                                                     ,oFont10)
If MV_PAR05 == 1
	oPrint:Say(nRowIni+nPos+0100,nColIni+0050,"R$  "+Transform(QR1->SALARIO,"@e 999,999.99")         ,oFont10)
else
	oPrint:Say(nRowIni+nPos+0100,nColIni+0050,"Informacao nao disponivel"                            ,oFont10)
EndIf
oPrint:Say(nRowIni+nPos+0100,nColIni+0500,QR1->DEPARTAMENTO                                          ,oFont10)
oPrint:Say(nRowIni+nPos+0100,nColIni+1000,DtoC(QR1->ADMISSAO)                                        ,oFont10)
oPrint:Say(nRowIni+nPos+0100,nColIni+1400,DtoC(QR1->DEMISSAO)                                        ,oFont10)
If 	QR1->MES_EMPRESA > 0
	oPrint:Say(nRowIni+nPos+0100,nColIni+1900,Transform(QR1->MES_EMPRESA,"@e 999,999")        ,oFont10)
else
	oPrint:Say(nRowIni+nPos+0100,nColIni+1900,"Em atividade"                                         ,oFont10)
EndIf

nLin += 1
nPos += 0200

If nLin >= 15
	nLin := 1
	oPrint:EndPage()
EndIf

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormRes  ºAutor  ³Ocimar Rolli        º Data ³  27/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Resumo do relatorio.                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fFormRes()

_aTab1 := {"JANEIRO","FEVEREIRO","MARÇO","ABRIL","MAIO","JUNHO","JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}
_cDia1 := Strzero(Day(dDataBase),2)
_cMes1 := _aTab1[Month(dDataBase)]
_cAno1 := Strzero(Year(dDataBase),4)

oPrint:StartPage()

// BOX CABECALHO RESUMO
oPrint:Box(nRowIni,nColIni,nRowIni+0100,nColFim)
oPrint:Say(nRowIni+0050,nColIni+0300,"RESUMO GERAL DO QUADRO DE FUNCIONARIOS EM  "+_cDia1+" de "+_cMes1+" de "+_cAno1  ,oFont11N)

// BOX CABECALHO RESUMO DETALHE
oPrint:Box(nRowIni+0150,nColIni,nRowIni+0250,nColFim)
oPrint:Say(nRowIni+0200,nColIni+0050,"Centro de Custo"                                             ,oFont10N)
oPrint:Say(nRowIni+0200,nColIni+0650,"Salario"                                                     ,oFont10N)
oPrint:Say(nRowIni+0200,nColIni+1250,"Numero de funcionarios"                                      ,oFont10N)
oPrint:Say(nRowIni+0200,nColIni+1850,"Media Salarial"                                              ,oFont10N)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fFormRDe  ºAutor  ³Ocimar Rolli        º Data ³  27/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Resumo do relatorio.                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function fFormRDe()                                                  	

// BOX RESUMO DETALHE
oPrint:Box(nRowIni+nPos,nColIni,nRowIni+nPos+0100,nColFim)
oPrint:Say(nRowIni+nPos+0050,nColIni+0050,QR1->DEPARTAMENTO                                                      ,oFont10N)
If MV_PAR05 == 1
	oPrint:Say(nRowIni+nPos+0050,nColIni+0650,"R$  "+Transform(QR1->SALARIO,"@e 999,999.99")                     ,oFont10N)
	else
	oPrint:Say(nRowIni+nPos+0050,nColIni+0650,"Informacao nao disponivel"                                        ,oFont10N)	
	EndIf
oPrint:Say(nRowIni+nPos+0050,nColIni+1300,Transform(QR1->MES_EMPRESA,"@e 999,999")                               ,oFont10N)
If MV_PAR05 == 1
	oPrint:Say(nRowIni+nPos+0050,nColIni+1850,"R$  "+Transform((QR1->SALARIO/QR1->MES_EMPRESA),"@e 999,999.99")  ,oFont10N)
	else
	oPrint:Say(nRowIni+nPos+0050,nColIni+1850,"Informacao nao disponivel"                                        ,oFont10N)
	EndIf	


nLin += 1
nPos += 0150

If nLin >= 15
	nLin := 1
EndIf

Return()
