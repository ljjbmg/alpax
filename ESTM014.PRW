/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTM011   ºAutor  ³Ocimar              º Data ³  18/08147   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para atualizacao do ultimo preco de compra,          º±±
±±º          ³preco de venda, preco minimo                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "Topconn.ch"                 
#Include "Protheus.ch"

User Function ESTM014(_aParam)

Private _cPerg := "ESTM11"
Private cCadastro := "Atualizacao Ultimo preco de compra"
Private aSays	  :={}
Private aButtons  :={}
Private nOpca	  := 0

If _aParam == Nil
	
	AADD(aSays,"Este programa ira atualizar o ultimo preco de venda conforme o indice informado," )
	AADD(aSays,"nos parametros, usara como base o preço de custo indicado/gravado no produto.")
	
	AADD(aButtons, { 5,.T.,{|| Pergunte(_cPerg,.T. )}})
	AADD(aButtons, { 1,.T.,{|o| nOpca := 1,FechaBatch()}})
	AADD(aButtons, { 2,.T.,{|o| FechaBatch() }} )
	
	FormBatch( cCadastro, aSays, aButtons )
	
	If nOpca == 1
		If ApMsgYesNo("Confirma atualizacao de acordo com as perguntas do parametro")
			Processa({|| fAtualiza()})
		EndIf
	EndIf
	
Else
	
	MV_PAR01 = _aParam[01]
	MV_PAR02 = _aParam[02]
	MV_PAR03 = _aParam[03]
	MV_PAR04 = _aParam[04]
	MV_PAR05 = _aParam[05]
	MV_PAR06 = _aParam[06]
	MV_PAR07 = _aParam[07]
	
	Processa({|| fAtualiza()})
	
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fatualiza ºAutor  ³Microsiga           º Data ³  13/01/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³funcao de processamento e atualizacao dos precos a partir   º±±
±±º          ³do B1_UPRC                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fAtualiza()

Private   _cQuery
Private   _nIndice  := MV_PAR07

SB1->(DbSetOrder(1))

_cQuery := "SELECT B1_COD, B1_UPRC, B1_AXCUS, B1_PRV1, B1_AXPRMIN, B1_XPRV4, B1_XPRMN4, B1_XPRV7, B1_XPRMN7, B1_XPRV12, B1_XPRMN12, B1_IPI, B1_PICMENT, B1_MARCA, B1_ORIGEM, B1_XSITPRO "
_cQuery += "       FROM " + RetSqlName("SB1") + " B1 "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "             AND B1_AXLINHA BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "             AND B1_MARCA BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","B1_UPRC"	    ,"N",12,2)
TcSetField("QR1","B1_AXCUS"	    ,"N",12,2)
TcSetField("QR1","B1_PRV1"	    ,"N",12,2)
TcSetField("QR1","B1_AXPRMIN"   ,"N",12,2)
TcSetField("QR1","B1_XPRV4"	    ,"N",12,2)
TcSetField("QR1","B1_XPRMN4"    ,"N",12,2)
TcSetField("QR1","B1_XPRV7"	    ,"N",12,2)
TcSetField("QR1","B1_XPRMN7"    ,"N",12,2)
TcSetField("QR1","B1_XPRV12"    ,"N",12,2)
TcSetField("QR1","B1_XPRMN12"   ,"N",12,2)
TcSetField("QR1","B1_IPI"	    ,"N",03,2)
TcSetField("QR1","B1_PICMENT"	,"N",03,2)

_nLinha := 1

Do While ! QR1->(Eof())
	If SB1->(DbSeek(xFilial("SB1")+QR1->B1_COD))
		RecLock("SB1",.f.)
		If QR1->B1_AXCUS <> 0
			SB1->B1_PRV1    := (QR1->B1_AXCUS*_nIndice)
            SB1->B1_AXPRMIN := (QR1->B1_AXCUS*_nIndice)
            SB1->B1_XPRV4   := (QR1->B1_AXCUS*_nIndice)
            SB1->B1_XPRMN4  := (QR1->B1_AXCUS*_nIndice)
            SB1->B1_XPRV7   := (QR1->B1_AXCUS*_nIndice)
            SB1->B1_XPRMN7  := (QR1->B1_AXCUS*_nIndice)
            SB1->B1_XPRV12  := (QR1->B1_AXCUS*_nIndice)
            SB1->B1_XPRMN12 := (QR1->B1_AXCUS*_nIndice)

		EndIf
		SB1->(MsUnLock())
		AutoGrLog(Strzero(_nLinha,5) + " - Alterado Preco compra produto " + SB1->B1_PNUMBER + " para R$." + Transform(SB1->B1_UPRC,"@E 9,999,999.99"))
	EndIf
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

AutoGrLog("***********  Termino da rotina")
_cArqIni := NomeAutoLog()
__CopyFile( _cArqIni, "LOG_ULTPRC.TXT" )
MostraErro()

Return


User Function GravaErro()

Local nX     := 0
Local nCount := 0   
Local cLogFile := "" 
//nome do arquivo de log a ser gravado

Local aLog 	 := {}
Local aVetor := {}
Local nHandleLocal 
lRet := .F.   
// variável de controle interno da rotina automatica que informa se houve erro durante o processamento

PRIVATE lMsErroAuto := .F.
// variável que define que o help deve ser gravado no arquivo de log e que as informações estão vindo à partir da rotina automática.

Private lMsHelpAuto	:= .T.    // força a gravação das informações de erro em array para manipulação da gravação ao invés de gravar direto no arquivo temporário 
Private lAutoErrNoFile := .T. 
Prepare Environment Empresa "01" Filial "01" Modulo "FAT"

//+------------------------- -------------------------------------+//| Teste de Inclusao |//+------------------------------------- -------------------------+

For nCount := 1 To 3	
aVetor:= {{"B1_COD"     ,"99"+Alltrim(Str(nCount)),Nil},; 			 
{"B1_DESC"    ,"Teste"        ,Nil},;			 
{"B1_UM"      ,"UN"           ,Nil},; 			 
{"B1_LOCPAD"  ,"01"           ,Nil}}   	

lMsErroAuto := .F.    	
lRet := .F.	
AutoGrLog("Teste de geração do arquivo de log "+Alltrim(Str(nCount)))	
AutoGrLog("")		

MSExecAuto( {|x,y| MATA010(x, y) }, aVetor, 3 )	

AutoGrLog(Replicate("-", 20))	

If lMsErroAuto		

cLogFile := "C:\TESTE"+Alltrim(Str(nCount))+".LOG"		
//função que retorna as informações de erro ocorridos durante o processo da rotina automática		
aLog := GetAutoGRLog()	                                 				//efetua o tratamento para validar se o arquivo de log já existe		

If !File(cLogFile)			

If (nHandle := MSFCreate(cLogFile,0)) <> -1				
lRet := .T.			
EndIf		

Else			

If (nHandle := FOpen(cLogFile,2)) <> -1				
FSeek(nHandle,0,2)				
lRet := .T.			
EndIf		

EndIf		

If	lRet                                                                                     			
//grava as informações de log no arquivo especificado			

For nX := 1 To Len(aLog)				
FWrite(nHandle,aLog[nX]+CHR(13)+CHR(10))			
Next nX			

FClose(nHandle)		

EndIf	
EndIf
Next
If !lMsErroAuto	ConOut("Incluido com sucesso! ") 
Else	ConOut("Erro na inclusao !")
EndIf

Return
