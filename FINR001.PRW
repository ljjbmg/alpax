/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFINR001   บAutor  ณAdriano Luis Brandaoบ Data ณ  31/03/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao das duplicatas.                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#INCLUDE "rwmake.ch"

User Function FINR001()

PRIVATE cDesc1         := "Este programa tem como objetivo imprimir relatorio "
PRIVATE cDesc2         := "de acordo com os parametros informados pelo usuario."
PRIVATE cDesc3         := ""
PRIVATE cPict          := ""
PRIVATE titulo       := ""
PRIVATE nLin         := 80

PRIVATE Cabec1       := ""
PRIVATE Cabec2       := ""
PRIVATE imprime      := .T.
PRIVATE aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "FINR001"
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "FINR001"
Private cPerg		:= "FINR01"
Private cString := "SF2"

dbSelectArea("SF2")
dbSetOrder(1)

_fCriaSx1()

Pergunte(cPerg,.t.)


wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|lEnd| _fImprime() })
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fImprime บAutor  ณAdriano Luis Brandaoบ Data ณ  31/03/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de impressao das duplicatas.                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fImprime()

SE1->(DbSetOrder(1))
SA1->(DbSetOrder(1))            
SD2->(DbSetOrder(3))

SE1->(DbSeek(xFilial("SE1")+MV_PAR03+MV_PAR01,.t.))

SetRegua(val(MV_PAR02)-val(MV_PAR01))

setprc(0,0)
Do While ! SE1->(EOF()) .And. SE1->E1_NUM <= MV_PAR02
	                                                
	If SE1->E1_PREFIXO <> MV_PAR03 .Or. SE1->E1_TIPO <> "NF "
		SE1->(DbSkip())
		Loop
	EndIf
	
	If lEnd
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	IncRegua()
	SA1->(DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA))
	SD2->(DbSeek(xFilial("SD2")+SE1->E1_NUM+SE1->E1_PREFIXO,.T.))
	SF4->(DbSeek(xFilial("SF4")+SD2->D2_TES))
	nLin := 6
	@ nLin,001 Psay SF4->F4_TEXTO
	nLin+= 3
	@ nLin,001 Psay chr(15)
	@ nLin,001 Psay SA1->A1_NOME
	@ nLin,083 Psay SA1->A1_CGC Picture iif(SA1->A1_PESSOA == "J","@R 99.999.999/9999-99","@X")
	@ nLin,120 Psay dToc(SD2->D2_EMISSAO)
	nLin+= 2
	@ nLin,001 Psay SA1->A1_END
	@ nLin,069 Psay Alltrim(SA1->A1_BAIRRO)
	@ nLin,103 Psay SA1->A1_CEP Picture "@R 99999-999"
	@ nLin,120 Psay SA1->A1_COD + "/" + SA1->A1_LOJA
	nLin+= 2
	@ nLin,001 Psay SA1->A1_MUN
 	@ nLin,052 Psay SA1->A1_TEL
	@ nLin,076 Psay SA1->A1_EST
	@ nLin,095 Psay SA1->A1_INSCR                                
	@ nLin,120 Psay SA1->A1_AXTELFI
	nLin+= 3
	@ nLin,001 Psay Dtoc(SD2->D2_EMISSAO)
	@ nLin,025 Psay SD2->D2_DOC
	@ nLin,050 Psay SE1->E1_VALOR Picture "@e 999,999,999.99"
	@ nLin,080 Psay SE1->E1_NUM + "/" + SE1->E1_PARCELA
	@ nLin,100 Psay Dtoc(SE1->E1_VENCTO)
	nLin += 2                                                                                       
	If ! Empty(SA1->A1_ENDCOB)
		@ nLin,001 Psay Alltrim(Left(SA1->A1_ENDCOB,80))+"-"+alltrim(SA1->A1_BAIRROC)+"-"+Alltrim(SA1->A1_MUNC)+"-"+alltrim(SA1->A1_ESTC)+"-CEP:"+SA1->A1_CEPC
	Else
		@ nLin,001 Psay Alltrim(Left(SA1->A1_END,80))+"-"+alltrim(SA1->A1_BAIRRO)+"-"+Alltrim(SA1->A1_MUN)+"-"+alltrim(SA1->A1_EST)+"-CEP:"+SA1->A1_CEP	
	EndIf
	nLin += 2
	@ nLin,001 Psay Extenso(SE1->E1_VALOR)
	nLin += 16
	@ nLin,000 Psay chr(18)
	SETPRC(0,0)
	SE1->(DbSkip())
		
EndDo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_fCriaSx1 บAutor  ณAdriano Luis Brandaoบ Data ณ  31/03/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Criacao de perguntas.                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function _fCriaSx1()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Da duplicata                   ณ
//ณMV_PAR02 = Ate duplicata                  ณ
//ณMV_PAR03 = Serie                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  

PutSx1(cPerg,"01","Da Duplicata  ?","Da Duplicata  ?","Da Duplicata  ?","mv_ch1","C",09,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",,,) 
PutSx1(cPerg,"02","Ate Duplicata ?","Ate Duplicata ?","Ate Duplicata ?","mv_ch2","C",09,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",,,) 
PutSx1(cPerg,"03","Prefixo ?"      ,"Prefixo ?"      ,"Prefixo ?"      ,"mv_ch3","C",03,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,) 

Return
