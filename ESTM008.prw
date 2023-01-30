#Include "Protheus.ch"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTM008   บAutor  ณAdriano Luis Brandaoบ Data ณ  08/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para gerar automaticamente o numero de licencas.     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ESTM008() 

Private cCadastro	:= "Gera็ใo automแtica de licen็as."
Private aSays		:= {}
Private aButtons	:= {}
Private nOpca 		:= 0
Private oPrint
Private cPerg := "ESTM008"

fCriaSx1()

If ! Pergunte(cperg,.t.)
	Return
EndIf


AADD(aSays,"Fun็ใo para gera็ใo automแtica de licen็as de acordo" )
AADD(aSays,"com os orgใos dos parโmetros.." )

AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. )}})
AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )

FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1             

	lRet := .t.

	If MV_PAR05 == 1  // Cliente
		SA1->(DbSetOrder(1))
		If ! SA1->(DbSeek(xFilial("SA1")+MV_PAR06+MV_PAR07))
			ApMsgStop("Cliente do parโmetro nใo encontrado","Confirmar")
    		lRet := .f.			
		EndIf

		 
	ElseIf MV_PAR05 == 2  // Transportadora
		SA4->(DbSetOrder(1))
		If ! SA4->(DbSeek(xFilial("SA4")+MV_PAR10))
			ApMsgStop("Transportadora nao contrada","Confirmar")
			lRet := .f.
		EndIf
			
	
	ElseIf MV_PAR05 == 3 // Fornecedor
		SA2->(DbSetOrder(1))
		If ! SA2->(DbSeek(xFilial("SA2")+MV_PAR08+MV_PAR09))
			ApMsgStop("Fornecedor do parโmetro nใo encontrado","Confirmar")
    		lRet := .f.			
		EndIf


	EndIf

	If Empty(MV_PAR01) .or. Empty(MV_PAR02) .or. MV_PAR01 > MV_PAR02
		ApMsgStop("Ajuste a data correta do periodo da licenca","Aviso")
		lRet := .f.
	EndIF
	
	If Empty(MV_PAR03)
		ApMsgStop("Preencher campo Numero da licenca","Aviso")
		lRet := .f.
	EndIf

	If lRet
		If ApMsgYesNo("Confirma gera็ใo das licen็as ??","Confirmar")
			Processa({|| fGera()})
		EndIf  
	EndIf

EndIf                   

Return    



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGera     บAutor  ณAdriano Luis Brandaoบ Data ณ  08/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para geracao das licencas.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fGera() 
                            
SZS->(DbSetOrder(1))
SZS->(DbSeek(xFilial("SZS")+MV_PAR04))                                             

SZU->(DbSetOrder(6))
// ZU_FILIAL+ZU_ORGAO+ZU_NRLIC+ZU_CLASS

Do While ! SZS->(Eof()) .And. xFilial("SZS") == SZS->ZS_FILIAL .And. SZS->ZS_ORGAO == MV_PAR04
	If ! SZU->(DbSeek(xFilial("SZU")+SZS->ZS_ORGAO+MV_PAR03+SZS->ZS_CON))
		RecLock("SZU",.t.)
		SZU->ZU_FILIAL 	:= xFilial("SZU")
		SZU->ZU_NRLIC	:= MV_PAR03
		If MV_PAR05 == 1	//Cliente
			SZU->ZU_TIPO := "C"		
			SZU->ZU_CLIENTE		:= MV_PAR06
			SZU->ZU_LOJA		:= MV_PAR07	
		ElseIf MV_PAR05 == 2 // Transportadora
			SZU->ZU_TIPO 		:= "T"		       
			SZU->ZU_TRANSP		:= MV_PAR10
		
		ElseIf MV_PAR05 == 3 // Fornecedores.
			SZU->ZU_TIPO := "F"		
			SZU->ZU_FORNECE		:= MV_PAR08
			SZU->ZU_LOJAFOR		:= MV_PAR09
		EndIf
		SZU->ZU_CLASS	:= SZS->ZS_CON
		SZU->ZU_DESCR   := SZS->ZS_DESCR
		SZU->ZU_ORGAO	:= SZS->ZS_ORGAO
		SZU->ZU_QTDMIN	:= 0.001
		SZU->ZU_QTDMAX	:= 99999999.999
		SZU->ZU_DTINI	:= MV_PAR01
		SZU->ZU_DTFIM	:= MV_PAR02
		SZU->ZU_TPLIC	:= "N"
		SZU->(MsUnLock())
	EndIf
	SZS->(DbSkip())
EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSx1  บAutor  ณAdriano Luis Brandaoบ Data ณ  08/08/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para criacao de perguntas.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSx1()

PutSx1(cPerg,"01","Periodo de"			,"Data de"      ,"Data de"		,"mv_ch1","D",08,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Periodo ate"			,"Data Ate"     ,"Data Ate"		,"mv_ch2","D",08,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","NR.Licenca"        	,"Nr.Licenca"   ,"Nr.Licenca"   ,"mv_ch3","C",15,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Orgao"        		,"Orgao"		,"Orgao"   		,"mv_ch4","C",03,0,0,"G","","SZR","","","mv_par04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Tipo"        		,"Tipo"			,"Tipo"   		,"mv_ch5","N",01,0,0,"C","","","","","mv_par05","Cliente","Cliente","Cliente","","Transportadora","Transportadora","Transportadora","Fornecedor","Fornecedor","Fornecedor","","","","","","",,,)
PutSx1(cPerg,"06","Cliente"        		,"Cliente"		,"Cliente" 		,"mv_ch6","C",06,0,0,"C","","SA1","","","mv_par06","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"07","Loja"        		,"Loja"			,"Loja"   		,"mv_ch7","C",02,0,0,"C","","","","","mv_par07","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"08","Fornecedor"        	,"Fornecedor"	,"Fornecedor" 	,"mv_ch8","C",06,0,0,"C","","SA2","","","mv_par08","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"09","Loja"        		,"Loja"			,"Loja"   		,"mv_ch9","C",02,0,0,"C","","","","","mv_par09","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"10","Transportadora"      ,"Transportadora","Transportadora" 	,"mv_cha","C",06,0,0,"C","","SA4","","","mv_par10","","","","","","","","","","","","","","","","",,,)


Return