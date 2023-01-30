#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "RWMAKE.CH"   
#include "Topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATM001   บAutor  ณAdriano Luis Brandaoบ Data ณ  18/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para importacao dos precos do fornecedor a partir    บฑฑ
ฑฑบ          ณde um arquivo formato CSV.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FATM001()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declara variaveis.														 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local _aDados    := {}					//Array com os campos enviados no TXT.
Local nHandle := 0						//Handle do arquivo texto.
Local cArqImp := ""						//Arquivo Txt a ser lido.
Private _cMarca := ""
Private cPerg := "FATM01"
Private _cParam := ""

fCriaSx1()

If ! Pergunte(cPerg,.t.)
	Return
EndIf

_cParam := MV_PAR01

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Busca o arquivo para leitura.											 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cArqImp := cGetFile("Arquivo .CSV |*.CSV","Selecione o Arquivo CSV",0,"",.T.,GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE)
If (nHandle := FT_FUse(cArqImp))== -1
	MsgInfo("Erro ao tentar abrir arquivo.","Aten็ใo")
	Return
EndIf

If ! ApMsgYesNo("Confirma a importacao do arquivo " + cArqImp +" ???", "Confirmar")
	Return
EndIf

MsgRun("Aguarde, lendo arquivo CSV e atualizando os precos....",, { || FLEARQ(_aDados)})



If ! Empty(_cMarca)
	
	_aParam := {}
	
	aAdd(_aParam,Space(15))
	aAdd(_aParam,Replicate("Z",15))
	aAdd(_aParam,Space(15))
	aAdd(_aParam,Replicate("Z",15))
	aAdd(_aParam,_cMarca)
	aAdd(_aParam,_cMarca)
	aAdd(_aParam,Ctod("07/09/2008"))
	aAdd(_aParam,CTOD("07/09/2008"))
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMV_PAR01 = Produto de ณ
	//ณMV_PAR02 = Produto ateณ
	//ณMV_PAR03 = Linha de   ณ
	//ณMV_PAR04 = Linha ate  ณ
	//ณMV_PAR05 = Marca de   ณ
	//ณMV_PAR06 = Marca ate  ณ
	//ณMV_PAR07 = Dt.Inicial ณ
	//ณMV_PAR08 = Dt.Final   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	// Atualizar preco venda e valor minimo.
	//U_ESTM002(_aParam)
	
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFLEARQ    บAutor  ณAdriano Luis Brandaoบ Data ณ  18/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao                                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FLEARQ()

Local cLinha  := ""	// Linha do arquivo texto a ser tratada.

FT_FGOTOP()
While !FT_FEOF()
	cLinha := FT_FREADLN()
	cLinha := Upper(NoAcento(AnsiToOem(cLinha)))
	_aDados := {}
	While At(";",cLinha) > 0
		aAdd(_aDados,Substr(cLinha,1,At(";",cLinha)-1))
		cLinha := StrTran(Substr(cLinha,At(";",cLinha)+1,Len(cLinha)-At(";",cLinha)),'"','')
	EndDo
	aAdd(_aDados,StrTran(Substr(cLinha,1,Len(cLinha)),'"',''))
	
	FATUPRECO(_aDados)
	FT_FSKIP()
EndDo
FT_FUSE()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFATUPRECO บAutor  ณAdriano Luis Brandaoบ Data ณ  18/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para atualizacao dos precos                          บฑฑ
ฑฑบ          ณrecebidos da leitura do arquivo texto.                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function FATUPRECO(_aRegistro)

Local nX			:= 0
Local aClientes	    := {}
Local cCNPJ			:= ""
Local cCliente      := ""
Local cProduto 		:= ""
Local cCondPag 		:= ""
Local cNumSer 		:= ""
Local lGeraCli      := .T.
Local lContinua     := .T.
Local lGrava		:= .F.
Private lMsErroAuto := .f.

SB1->(DbOrderNickName("P. NUMBER"))

_aRegistro[01] := Alltrim(_aRegistro[01])

If UPPER(Alltrim(_cParam)) == "SYNTH"		// Se for marca Synth, desconsidera os dois primeiros digitos.
	_cProduto := Substr(_aRegistro[01],3,Len(_aRegistro[01])-2)
Else
	_cProduto := _aRegistro[01]
EndIf

If SB1->(DbSeek(xFilial("SB1")+_cProduto))                                                                    

	lGrava := .f.
	If SB1->B1_MARCA == _cParam			// Se a marca igual do parametro Gravar
		lGrava := .t.
	Else
		// Looping para localizar o mesmo partnumber e mesma marca
		lContinua := .t.
		Do While ! SB1->(Eof()) .And. ALLTRIM(SB1->B1_PNUMBER) == _cProduto .And. lContinua 
			If SB1->B1_MARCA == _cParam 	// Se a marca igual do parametro Gravar
				lGrava := .t.
				lContinua := .f.
			EndIf
			If lContinua
				SB1->(DbSkip())
			EndIf
		EndDo
	EndIf
	// Produto bloqueado nใo grava.
	If SB1->B1_MSBLQL == "1"
		lGrava := .f.
	EndIf
	
	// Se variavel for verdadeira, grava os novos precos.
	If lGrava
		_cValor := StrTran(_aRegistro[02],".","")
		_nValor := val(strtran(_cValor,",","."))
		
		_cMarca := SB1->B1_MARCA
		
		If _nValor > 0
			aCampo	:= {}
			
			aAdd(aCampo,{"B1_COD"		,SB1->B1_COD			,Nil})
			aAdd(aCampo,{"B1_UPRC"		,_nValor				,Nil})
			
			lMsErroAuto := .f.
			
			MSExecAuto({|x,y| Mata010(x,y)},aCampo,4)
			
			If lMsErroAuto
				MostraErro()
				apmsgInfo(aCampo[01,02])
			EndIf
		EndIf
		
	EndIf
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSx1  บAutor  ณAdriano Luis Brandaoบ Data ณ  27/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Criacao das perguntas da rotina.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSx1()

PutSx1(cPerg,"01","Marca"          ,"Marca"          ,"Marca"          ,"mv_ch1","C",15,0,0,"G","","SZ2"   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)

Return
