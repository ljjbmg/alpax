/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTR016   ºAutor  ³Microsiga           º Data ³  09/23/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ESTR016()

Private _aPerg01 	:= {} // Armazem
Private _aPerg02 	:= {} // Local
Private _aPerg03 	:= {} // Rua
Private _aPerg04 	:= {} // Box Inicial
Private _aPerg05 	:= {} // Box Final
Private cPerg		:= "ESTR16"

aAdd(_aPerg01,"Digitar o numero do armazem")

aAdd(_aPerg02,"Digitar o Setor ")

aAdd(_aPerg03,"Digitar a Rua ")             

aAdd(_aPerg04,"Digitar o numero do box,")
aAdd(_aPerg04,"com zeros a esquerda.")
aAdd(_aPerg04,"Exemplo: 1 tem que ser 0001")
aAdd(_aPerg04,"         2 tem que ser 0002")

aAdd(_aPerg05,"Digitar o numero do box,")
aAdd(_aPerg05,"com zeros a esquerda.")
aAdd(_aPerg05,"Exemplo: 1 tem que ser 0001")
aAdd(_aPerg05,"         2 tem que ser 0002")



PutSx1(cPerg,"01","Armazem"		,"Armazem"		,"Armazem"		,"mv_ch1","C",02,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",_aPerg01,_aPerg01,_aPerg01)
PutSx1(cPerg,"02","Setor"		,"Setor"		,"Setor"		,"mv_ch2","C",02,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",_aPerg02,_aPerg02,_aPerg02)
PutSx1(cPerg,"03","Rua"			,"Rua"			,"Rua"			,"mv_ch3","C",02,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",_aPerg03,_aPerg03,_aPerg03)
PutSx1(cPerg,"04","Box Inicial"	,"Box Inicial"	,"Box Inicial"	,"mv_ch4","C",04,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",_aPerg04,_aPerg04,_aPerg04)
PutSx1(cPerg,"05","Box Final"	,"Box Final"	,"Box Final"	,"mv_ch5","C",04,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",_aPerg05,_aPerg05,_aPerg05)        			

If ! Pergunte(cPerg,.t.)
	Return
EndIf

If ! ApMsgYesNo("Confirma a impressao das etiquetas de enderecamento ???")
	Return
EndIf

Processa({ || _fImprime()})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_fImprime ºAutor  ³Microsiga           º Data ³  23/09/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de impressao das etiquetas.                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function _fImprime()


ProcRegua(Val(MV_PAR05)-Val(MV_PAR04))

cPorta := "LPT1"

MSCBPRINTER("ALLEGRO",cPorta,,,.f.,,,,,,.t.)

SBE->(DbSeek(xFilial("SBE")+MV_PAR01+MV_PAR02+MV_PAR03+MV_PAR04,.t.))

Do While ! SBE->(Eof()) .And. SBE->BE_FILIAL == xFilial("SBE") .And.;
	SBE->BE_LOCAL+Left(SBE->BE_LOCALIZ,4) == MV_PAR01+MV_PAR02+MV_PAR03 .And.;
	Substr(SBE->BE_LOCALIZ,5,4) <= MV_PAR05
	
	IncProc("Imprimindo as etiquetas !!!")
	
	MSCBBEGIN(1,6)
	
	MSCBBOX(05,12,20,28,2)	// BOX SETOR
	MSCBBOX(22,12,35,28,2)	// BOX RUA
	MSCBBOX(37,12,55,28,2)	// BOX BOX
	MSCBSAY(06,23,"Setor"						,"N","1","02,02")
	MSCBSAY(23,23,"Rua"							,"N","1","02,02")
	MSCBSAY(38,23,"Box"							,"N","1","02,02")

	MSCBSAY(09,15,MV_PAR02						,"N","2","02,02")
	MSCBSAY(26,15,MV_PAR03						,"N","2","02,02")
	MSCBSAY(40,15,Substr(SBE->BE_LOCALIZ,5,4)	,"N","2","02,02")
//	MSCBSAYBAR(05  ,01  ,SBE->BE_LOCALIZ ,"N"     ,"E"     ,09)
//	MSCBSAYBAR(05  ,01  ,SBE->BE_LOCALIZ ,"N"     ,"MB07"  ,09)
	MSCBSAYBAR(05  ,01  ,"123OCIMAR" 			,"N"     ,"MB07"  ,09)
//	MSCBSAYBAR(nXmm,nYmm,cConteudo       ,cRotacao,cTypePrt,nAltura,lDigVer,lLinha,lLinBaixo,cSubSetIni,nLargura,nRelacao,lCompacta,lSerial,cIncr,lZerosL)
	MSCBEND()
	
	SBE->(DbSkip())
	
EndDo

MSCBCLOSEPRINTER()

Return