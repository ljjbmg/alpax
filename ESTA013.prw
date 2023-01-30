/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณESTA013   บAutor  ณMicrosiga           บ Data ณ  07/22/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Browse para controle dos chamados de coleta.               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Protheus.ch"

// Rotina para vendedor.
User Function ESTA013A()
U_ESTA013(.T.)
Return

// Rotina para almoxarifado.
User Function ESTA013(_lRot)

If _lRot == Nil
	aRotina 	:= { 	{"Pesquisar"		,"AxPesqui"			,0,1},;
	{"Visualizar"		,"U_fVisual013()"	,0,1},;
	{"Chamar Coleta"	,"U_fChama013()"	,0,1},;
	{"Baixar Coleta"	,"U_fBaixa013()"	,0,1},;
	{"Cancela Item"		,"U_fCanc013()"		,0,1},;
	{"Imprime Coleta"	,"U_ESTR014()"		,0,1},;
	{"Alter.Transp."	,"U_fTr013()"		,0,1},;
	{"Legenda"			,"U_Legen013()"		,0,1} }
Else
	aRotina 	:= { 	{"Pesquisar"		,"AxPesqui"			,0,1},;
	{"Visualizar"		,"U_fVisual013()"	,0,1},;
	{"Legenda"			,"U_Legen013()"		,0,1} }
	
EndIf

aCores := 	{	{ " Empty(ZJ_SOLICIT)"								, 'BR_VERDE' 	}	,;
{ " ! Empty(ZJ_SOLICIT) .And. Empty(ZJ_EXPEDIT)"	, 'BR_AMARELO' 	}	,;
{ " ! Empty(ZJ_SOLICIT) .And. ! Empty(ZJ_EXPEDIT)"	, 'BR_VERMELHO'	}	}

mBrowse( 6,1,22,75,"SZJ",,,,,,aCores)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLegen013  บAutor  ณMicrosiga           บ Data ณ  22/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de descricao das cores de legenda.                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Legen013()
Local aCores
Local cCadastro

cCadastro := "Controle de Coleta"
aCores    := {	{ 'BR_VERDE'	, "Chamar Coleta" 	}	,;
{ 'BR_AMARELO'	, "Baixar Coleta"	}	,;
{ 'BR_VERMELHO'	, "Coleta Feita"	}	}

BrwLegenda(cCadastro,"Legenda do Browse",aCores)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfChama013 บAutor  ณMicrosiga           บ Data ณ  29/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para a chamada de coleta                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fChama013()

If ! Empty(SZJ->ZJ_COLETA)
	ApMsgStop("Coleta ja chamada, selecione outra !!!","Bloqueado")
	Return
EndIf

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Opcao de acesso para o Modelo 2                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 6

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZJ")

nUsado:=0
aHeader:={}

_cCab := "ZJ_CHAMADA/ZJ_TRANSP/ZJ_TIPOFR/ZJ_COLETA/ZJ_CONTATO/ZJ_FONETR/ZJ_PLACA/ZJ_MOTORI/ZJ_RGMOTO"

While !Eof() .And. (x3_arquivo == "SZJ")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,x3_vlduser, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis do Cabecalho do Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SA4->(DbSetOrder(1))
SA4->(DbSeek(xFilial("SA4")+SZJ->ZJ_TRANSP))

_cChamada 	:= SZJ->ZJ_CHAMADA
_cTransp	:= SZJ->ZJ_TRANSP
_cNomTrans	:= SA4->A4_NREDUZ
_cFoneTr	:= SZJ->ZJ_FONETR
_cColeta	:= Space(Len(SZJ->ZJ_COLETA))
_cContato	:= Space(Len(SZJ->ZJ_CONTATO))
_cTipo		:= iif(SZJ->ZJ_TIPOFR=="C","CIF","FOB")
_cPlaca		:= SZJ->ZJ_PLACA
_cMotori	:= SZJ->ZJ_MOTORI
_cRGMoto	:= SZJ->ZJ_RGMOTO

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZJ")
DbSetOrder(1)
// ZJ_FILIAL+ZJ_CHAMADA+ZJ_SERIE+ZJ_NOTA
DbSeek(xFilial("SZJ")+_cChamada,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZJ->(Eof()) .And. SZJ->ZJ_FILIAL = xFilial("SZJ") .And. SZJ->ZJ_CHAMADA == _cChamada
	
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZJ->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZJ->(DbSkip())
Enddo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Titulo da Janela                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cTitulo  := "Chamada da Coleta"


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Cabecalho do Modelo 2      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cChamada" 	,{20,15} 	,"Chamada "  	      ,"@!"	, "				"       						,		,.f.})
AADD(aC,{"_cTransp" 	,{20,160} 	,"Transp     " 		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cNomTrans" 	,{20,240} 	,"Transportadora"	  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cFoneTr" 	,{35,15} 	,"Telefone  "		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cTipo" 		,{35,160} 	,"Tipo Frete"		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cColeta" 	,{35,240} 	,"Nr.Coleta          ","@!"	, "          "									,		,.t.})
AADD(aC,{"_cContato" 	,{50,15} 	,"Contato   "		  ,"@!"	, "          "									,		,.t.})
AADD(aC,{"_cPlaca"	 	,{50,160} 	,"Placa       "		  ,"@! XXX-XXXX"	, "          "			   			,		,.f.}) //Henrique Caetano 06/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014 
AADD(aC,{"_cMotori"	 	,{50,240} 	,"Motorista          ","@!"	, "          "									,		,.f.})
AADD(aC,{"_cRGMoto"	 	,{65,15} 	,"R.G.        "		  ,SPACE(12)	, "          "					,		,.f.})  //Henrique Caetano 02/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Rodape do Modelo 2         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows e	stao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com coordenadas da GetDados no modelo2                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aCGD := {120,5,128,315}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Validacoes na GetDados da Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cLinhaOk := ".T."
cTudoOk  := "U_fTudoOk()"

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,,,,,,,.T.) //Henrique Caetano, Incluํdo a op็ใo de maximizar a tela, conforme chamado #2461


If lRetMod2
	_nPosNf 	:= aScan(aHeader,{|x| Alltrim(x[2])=="ZJ_NOTA" 		})
	_nPosSer 	:= aScan(aHeader,{|x| Alltrim(x[2])=="ZJ_SERIE" 	})
	_nPosVlr 	:= aScan(aHeader,{|x| Alltrim(x[2])=="ZJ_VLCOLET" 	})
	
	Begin Transaction
	
	_cUpdate := "UPDATE " + RetSqlName("SZJ")
	_cUpdate += "      SET ZJ_COLETA = '" + _cColeta + "', ZJ_CONTATO = '" + _cContato + "', "
	_cUpdate += "          ZJ_DATACH = '" + DTOS(dDataBase) + "', ZJ_HORACH = '" + Transform(Time(),"@R 99:99") + "', "
	_cUpdate += "          ZJ_SOLICIT = '" + __cUserId + "' "
	_cUpdate += "      WHERE ZJ_FILIAL = '" + xFilial("SZJ") + "' AND ZJ_CHAMADA = '" + _cChamada + "' "
	
	TcSqlExec(_cUpdate)
	
	For _nY := 1 To Len(aCols)
		If SZJ->(DbSeek(xFilial("SZJ") + _cChamada + aCols[_nY,_nPosSer] + aCols[_nY,_nPosNF]))
			RecLock("SZJ",.f.)
			SZJ->ZJ_VLCOLET := aCols[_nY,_nPosVlr]
			SZJ->(MsUnLock())
		EndIf
	Next _nY
	
	End Transaction
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfTudoOk   บAutor  ณMicrosiga           บ Data ณ  29/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Validacao geral da rotina.                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function fTudoOk()
_lRet := .t.
_nPos := Ascan(aHeader,{ |x| Alltrim(x[2]) == "ZJ_VLCOLET" })
If _cTipo == "CIF"
	For _nY := 1 to Len(aCols)
		If Acols[_nY,_nPos] <= 0
			_lRet := .f.
		EndIf
	Next _nY
EndIf

If ! _lRet
	ApMsgAlert("Favor preencher o valor do frete de cada nota fiscal !!!","Bloqueado")
EndIf

Return(_lRet)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfBaixa013 บAutor  ณMicrosiga           บ Data ณ  29/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Baixa da coleta.                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function fBaixa013()

If ! Empty(SZJ->ZJ_DATACOL)
	ApMsgStop("Coleta ja Baixada, selecione outra !!!","Bloqueado")
	Return
EndIf

If Empty(SZJ->ZJ_COLETA)
	ApMsgStop("Coleta nao chamada, nao pode ser baixada !!!!","Bloqueado")
	Return
EndIf


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Opcao de acesso para o Modelo 2                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 6

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZJ")

nUsado:=0
aHeader:={}



_cCab := "ZJ_CHAMADA/ZJ_TRANSP/ZJ_TIPOFR/ZJ_COLETA/ZJ_CONTATO/ZJ_FONETR/ZJ_PLACA/ZJ_MOTORI/ZJ_RGMOTO"

While !Eof() .And. (x3_arquivo == "SZJ")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,x3_vlduser, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis do Cabecalho do Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SA4->(DbSetOrder(1))
SA4->(DbSeek(xFilial("SA4")+SZJ->ZJ_TRANSP))

_cChamada 	:= SZJ->ZJ_CHAMADA
_cTransp	:= SZJ->ZJ_TRANSP
_cNomTrans	:= SA4->A4_NREDUZ
_cFoneTr	:= SZJ->ZJ_FONETR
_cColeta	:= SZJ->ZJ_COLETA
_cContato	:= SZJ->ZJ_CONTATO
_cTipo		:= iif(SZJ->ZJ_TIPOFR=="C","CIF","FOB")
_cPlaca		:= SZJ->ZJ_PLACA
_cMotori	:= SZJ->ZJ_MOTORI
_cRGMoto	:= SZJ->ZJ_RGMOTO

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZJ")
DbSetOrder(1)
// ZJ_FILIAL+ZJ_CHAMADA+ZJ_SERIE+ZJ_NOTA
DbSeek(xFilial("SZJ")+_cChamada,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZJ->(Eof()) .And. SZJ->ZJ_FILIAL = xFilial("SZJ") .And. SZJ->ZJ_CHAMADA == _cChamada
	
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZJ->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZJ->(DbSkip())
Enddo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Titulo da Janela                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cTitulo  := "Baixa da Coleta"


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Cabecalho do Modelo 2      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.


AADD(aC,{"_cChamada" 	,{20,15} 	,"Chamada "  	      ,"@!"	, "				"       						,		,.f.})
AADD(aC,{"_cTransp" 	,{20,160} 	,"Transp     " 		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cNomTrans" 	,{20,240} 	,"Transportadora"	  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cFoneTr" 	,{35,15} 	,"Telefone  "		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cTipo" 		,{35,160} 	,"Tipo Frete"		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cColeta" 	,{35,240} 	,"Nr.Coleta          ","@!"	, "          "									,		,.f.})
AADD(aC,{"_cContato" 	,{50,15} 	,"Contato   "		  ,"@!"	, "          "									,		,.f.})
AADD(aC,{"_cPlaca"	 	,{50,160} 	,"Placa       "		  ,"@! XXX-XXXX"	, "naovazio()"			   			,		,.t.}) //Henrique Caetano 06/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014
AADD(aC,{"_cMotori"	 	,{50,240} 	,"Motorista          ","@!"	, "naovazio()"									,		,.t.})
AADD(aC,{"_cRGMoto"	 	,{65,15} 	,"R.G.        "		  ,SPACE(12)	, "naovazio()"					,		,.t.})  //Henrique Caetano 02/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Rodape do Modelo 2         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com coordenadas da GetDados no modelo2                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aCGD := {120,5,128,315}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Validacoes na GetDados da Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,,,,,,,.T.) //Henrique Caetano, Incluํdo a op็ใo de maximizar a tela, conforme chamado #2461


If lRetMod2
	
	nPosPlaca	:= aScan(aHeader,{|x| Alltrim(X[2]) == "ZJ_PLACA"})
	nPosMotor	:= aScan(aHeader,{|x| Alltrim(X[2]) == "ZJ_MOTORI"})
	nPosRGMOTO	:= aScan(aHeader,{|x| Alltrim(X[2]) == "ZJ_RGMOTO"})
	
	
	Begin Transaction
	
	_cUpdate := "UPDATE " + RetSqlName("SZJ")
	_cUpdate += "      SET ZJ_DATACOL = '" + Dtos(dDataBase) + "' , ZJ_HORACOL = '" + Transform(Time(),"@R 99:99") + "' , "
	_cUpdate += "          ZJ_EXPEDIT = '" + __cUserId + "', ZJ_PLACA = '" + _cPlaca + "', ZJ_MOTORI = '" + _cMotori + "', "
	_cUpdate += "          ZJ_RGMOTO = '" + _cRGMoto + "' "
	_cUpdate += "      WHERE ZJ_FILIAL = '" + xFilial("SZJ") + "' AND ZJ_CHAMADA = '" + _cChamada + "' "
	
	TcSqlExec(_cUpdate)
	
	
	End Transaction
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfVisual013บAutor  ณMicrosiga           บ Data ณ  29/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de visualizacao das chamadas.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fVisual013()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Opcao de acesso para o Modelo 2                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 2

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZJ")

nUsado:=0
aHeader:={}

_cCab := "ZJ_CHAMADA/ZJ_TRANSP/ZJ_TIPOFR/ZJ_COLETA/ZJ_CONTATO/ZJ_FONETR/ZJ_PLACA/ZJ_MOTORI/ZJ_RGMOTO"

While !Eof() .And. (x3_arquivo == "SZJ")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,x3_vlduser, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis do Cabecalho do Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SA4->(DbSetOrder(1))
SA4->(DbSeek(xFilial("SA4")+SZJ->ZJ_TRANSP))

_cChamada 	:= SZJ->ZJ_CHAMADA
_cTransp	:= SZJ->ZJ_TRANSP
_cNomTrans	:= SA4->A4_NREDUZ
_cFoneTr	:= SZJ->ZJ_FONETR
_cColeta	:= SZJ->ZJ_COLETA
_cContato	:= SZJ->ZJ_CONTATO
_cTipo		:= iif(SZJ->ZJ_TIPOFR=="C","CIF","FOB")
_cStatus	:= "Chamar coleta"
_cPlaca		:= SZJ->ZJ_PLACA
_cMotori	:= SZJ->ZJ_MOTORI
_cRGMoto	:= SZJ->ZJ_RGMOTO

If ! Empty(SZJ->ZJ_COLETA) .And. Empty(SZJ->ZJ_DATACOL)
	_cStatus := "COLETA JA CHAMADA"
ElseIf ! Empty(SZJ->ZJ_DATACOL)
	_cStatus := "COLETA BAIXADA"
EndIf

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZJ")
DbSetOrder(1)
// ZJ_FILIAL+ZJ_CHAMADA+ZJ_SERIE+ZJ_NOTA
DbSeek(xFilial("SZJ")+_cChamada,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZJ->(Eof()) .And. SZJ->ZJ_FILIAL = xFilial("SZJ") .And. SZJ->ZJ_CHAMADA == _cChamada
	
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZJ->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZJ->(DbSkip())
Enddo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Titulo da Janela                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cTitulo  := "Visualiza a chamada coleta"


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Cabecalho do Modelo 2      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cChamada" 	,{20,15} 	,"Chamada "  	      ,"@!"	, "				"       						,		,.f.})
AADD(aC,{"_cTransp" 	,{20,160} 	,"Transp     " 		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cNomTrans" 	,{20,240} 	,"Transportadora"	  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cFoneTr" 	,{35,15} 	,"Telefone  "		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cTipo" 		,{35,160} 	,"Tipo Frete"		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cColeta" 	,{35,240} 	,"Nr.Coleta          ","@!"	, "          "									,		,.f.})
AADD(aC,{"_cContato" 	,{50,15} 	,"Contato   "		  ,"@!"	, "          "									,		,.f.})
AADD(aC,{"_cPlaca"	 	,{50,160} 	,"Placa       "		  ,"@! XXX-XXXX"	, "          "			   			,		,.f.}) //Henrique Caetano 06/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014
AADD(aC,{"_cMotori"	 	,{50,240} 	,"Motorista          ","@!"	, "          "									,		,.f.})
AADD(aC,{"_cRGMoto"	 	,{65,15} 	,"R.G.        "		  ,SPACE(12)	, "          "					,		,.f.})  //Henrique Caetano 02/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Rodape do Modelo 2         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com coordenadas da GetDados no modelo2                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aCGD := {120,5,128,315}


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Validacoes na GetDados da Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,,,,,,,.T.) //Henrique Caetano, Incluํdo a op็ใo de maximizar a tela, conforme chamado #2461


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCanc013  บAutor  ณMicrosiga           บ Data ณ  29/07/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCancela item da chamada.                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fCanc013()

nOpcx := 2

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZJ")

nUsado:=0
aHeader:={}

_cCab := "ZJ_CHAMADA/ZJ_TRANSP/ZJ_TIPOFR/ZJ_COLETA/ZJ_CONTATO/ZJ_FONETR/ZJ_PLACA/ZJ_MOTORI/ZJ_RGMOTO"

While !Eof() .And. (x3_arquivo == "SZJ")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,x3_vlduser, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis do Cabecalho do Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SA4->(DbSetOrder(1))
SA4->(DbSeek(xFilial("SA4")+SZJ->ZJ_TRANSP))

_cChamada 	:= SZJ->ZJ_CHAMADA
_cTransp	:= SZJ->ZJ_TRANSP
_cNomTrans	:= SA4->A4_NREDUZ
_cFoneTr	:= SZJ->ZJ_FONETR
_cColeta	:= SZJ->ZJ_COLETA
_cContato	:= SZJ->ZJ_CONTATO
_cTipo		:= iif(SZJ->ZJ_TIPOFR=="C","CIF","FOB")
_cStatus	:= "Chamar coleta"
_cPlaca		:= SZJ->ZJ_PLACA
_cMotori	:= SZJ->ZJ_MOTORI
_cRGMoto	:= SZJ->ZJ_RGMOTO

If ! Empty(SZJ->ZJ_COLETA) .And. Empty(SZJ->ZJ_DATACOL)
	_cStatus := "COLETA JA CHAMADA"
ElseIf ! Empty(SZJ->ZJ_DATACOL)
	_cStatus := "COLETA BAIXADA"
EndIf

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZJ")
DbSetOrder(1)
// ZJ_FILIAL+ZJ_CHAMADA+ZJ_SERIE+ZJ_NOTA
DbSeek(xFilial("SZJ")+_cChamada,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZJ->(Eof()) .And. SZJ->ZJ_FILIAL = xFilial("SZJ") .And. SZJ->ZJ_CHAMADA == _cChamada
	
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZJ->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZJ->(DbSkip())
Enddo

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Titulo da Janela                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cTitulo  := "Cancela chamada"


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Cabecalho do Modelo 2      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cChamada" 	,{20,15} 	,"Chamada "  	      ,"@!"	, "				"       						,		,.f.})
AADD(aC,{"_cTransp" 	,{20,160} 	,"Transp     " 		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cNomTrans" 	,{20,240} 	,"Transportadora"	  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cFoneTr" 	,{35,15} 	,"Telefone  "		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cTipo" 		,{35,160} 	,"Tipo Frete"		  ,"@!"	,        										,		,.f.})
AADD(aC,{"_cColeta" 	,{35,240} 	,"Nr.Coleta          ","@!"	, "          "									,		,.f.})
AADD(aC,{"_cContato" 	,{50,15} 	,"Contato   "		  ,"@!"	, "          "									,		,.f.})
AADD(aC,{"_cPlaca"	 	,{50,160} 	,"Placa       "		  ,"@! XXX-XXXX"	, "          "			   			,		,.f.}) //Henrique Caetano 06/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014
AADD(aC,{"_cMotori"	 	,{50,240} 	,"Motorista          ","@!"	, "          "									,		,.f.})
AADD(aC,{"_cRGMoto"	 	,{65,15} 	,"R.G.        "		  ,SPACE(12)	, "          "					,		,.f.})  //Henrique Caetano 02/04/2020 Chamado #2639 - MELHORIA no campo RG FONTE - ESTA013 e ESTR014

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com descricao dos campos do Rodape do Modelo 2         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Array com coordenadas da GetDados no modelo2                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

aCGD := {120,5,128,315}

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Validacoes na GetDados da Modelo 2                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,,,,,,,.T.,,,,,,,.T.) //Henrique Caetano, Incluํdo a op็ใo de maximizar a tela, conforme chamado #2461 

SZJ->(DbSetOrder(1))

If lRetMod2
	_nPosNf 	:= aScan(aHeader,{|x| Alltrim(x[2])=="ZJ_NOTA" 		})
	_nPosSer 	:= aScan(aHeader,{|x| Alltrim(x[2])=="ZJ_SERIE" 	})
	_nPosColet	:= aScan(aHeader,{|x| Alltrim(x[2])=="ZJ_COLETA" 	})
	_nPosDCole	:= aScan(aHeader,{|x| Alltrim(x[2])=="ZJ_DATACOL" 	})
	Begin Transaction
	For _nY := 1 to Len(aCols)
		// STATUS VERDE e AMARELO
		If aCols[_nY,Len(aHeader)+1]
			If Empty(_cColeta) .Or. Empty(aCols[_nY,_nPosDCole])
				// se estiver deletado, da um update no SF2 e deleta do SZJ
				_cUpdate := "UPDATE " + RetSqlName("SF2")
				_cUpdate += "       SET F2_AXCOLET = ' ' "
				_cUpdate += "       WHERE F2_FILIAL = '" + xFilial("SF2") + "' AND F2_DOC = '" + aCols[_nY,_nPosNF] + "' "
				_cUpdate += "             AND F2_SERIE = '" + aCols[_nY,_nPosSer] + "' AND D_E_L_E_T_ = ' ' "
				TcSqlExec(_cUpdate)
				
				If SZJ->(DbSeek(xFilial("SZJ")+_cChamada+aCols[_nY,_nPosSer]+aCols[_nY,_nPosNF]))
					RecLock("SZJ",.f.)
					Delete
					SZJ->(MsUnLock())
				EndIf
				// STATUS VERMELHO
			Else
				_cUpdate := "UPDATE " + RetSqlName("SF2")
				_cUpdate += "       SET F2_AXCOLET = ' ' "
				_cUpdate += "       WHERE F2_FILIAL = '" + xFilial("SF2") + "' AND F2_DOC = '" + aCols[_nY,_nPosNF] + "' "
				_cUpdate += "             AND F2_SERIE = '" + aCols[_nY,_nPosSer] + "' AND D_E_L_E_T_ = ' ' "
				TcSqlExec(_cUpdate)
			EndIf
		EndIf
	Next _nY
	End Transaction
EndIf

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfTr013    บAutor  ณAdriano Luis Brandaoบ Data ณ  31/03/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fTr013()

Local _cTitulo		:= "Altera Transportadora"
Private _cTransp 	:= SZJ->ZJ_TRANSP
Private _cDesc		:= Posicione("SA4",1,xFilial("SA4")+SZJ->ZJ_TRANSP,"A4_NOME")
Private oGetPesq1,oGetPesq2

DEFINE MSDIALOG oDlg TITLE _cTitulo FROM 2,10 TO 12,80 OF oMainWnd

@ 25,05 Say "Transportadora" 		Pixel
@ 25,80 MSGET oGetPesq2 VAR _cDesc SIZE 120, 08 PIXEL OF oDlg
@ 25,45 MsGet oGetPesq1 VAR _cTransp 	Size 20,08 	F3 "SA4" valid fAtual() Pixel OF oDlg // valid existcpo("SA4") .and. naovazio() Pixel OF oDlg

oGetPesq1:bChange := {||fAtual()}

//ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{ IF(ValidAll(oDlg),oDlg:End(),lRet := .f.)},{ || lRet := .f.,oDlg:End() } )
ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{ || fGrava(), oDlg:End()},{ || oDlg:End() } )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtual    บAutor  ณMicrosiga           บ Data ณ  03/31/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtual()

SA4->(DbSeek(xFilial("SA4")+_cTransp))
_cDesc := SA4->A4_NOME
oDlg:Refresh()
oGetPesq1:ReFresh()
oGetPesq2:Refresh()

Return(.t.)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGrava    บAutor  ณMicrosiga           บ Data ณ  03/31/07   บฑฑ
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

If ! ApMsgYesNo("Confirma alteracao da transportadora ??","Confirmar")
	Return
EndIf

SF2->(DbSetOrder(1))
If SF2->(DbSeek(xFilial("SF2")+SZJ->ZJ_NOTA+SZJ->ZJ_SERIE,.t.))
	Begin Transaction
	RecLock("SF2",.f.)
	SF2->F2_TRANSP := _cTransp
	SF2->(MsUnLock())
	RecLock("SZJ",.f.)
	SZJ->ZJ_TRANSP := _cTransp
	SZJ->(MsUnLock())
	End Transaction
	
EndIf

Return
