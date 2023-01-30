/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA003   ºAutor  ³Adriano Luis Brandaoº Data ³  08/07/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de Cadastro dos produtos e clientes controlados      º±±
±±º          ³pelo exercito. - tabela SZ8                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX.                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Rwmake.ch"

User Function FATA003()
/*
axcadastro("SZ8","Licenca do Cliente no Ministerio Exercito")
*/

cCadastro := "Cadastro de Licenca do Ministerio do Exercito"
/*    
             Inserir estas linhas abaixo caso queira utilizar a opcao de alteracao que ja esta montada e testada.
             
Private aRotina := { 	{"Pesquisar"			,"AxPesqui"		,0,1} ,;  		// Pesquisa na tabela
{"Incluir"				,"U_FATA003I()",0,3 } ,;	  	// Inclusao Modelo 2
{"Alterar"				,"U_FATA003A()",0,4 } ,;		// Alteracao Modelo 2
{"Excluir"				,"U_FATA003E()",0,5 } ,;		// Exclusao Modelo 2
{"Visualizar"			,"U_FATA003V()",0,1 } }			// Visualizacao Modelo 2
*/
Private aRotina := { 	{"Pesquisar"			,"AxPesqui"		,0,1} ,;  		// Pesquisa na tabela
{"Incluir"				,"U_FATA003I()",0,3 } ,;	  	// Inclusao Modelo 2
{"Excluir"				,"U_FATA003E()",0,5 } ,;		// Exclusao Modelo 2
{"Visualizar"			,"U_FATA003V()",0,1 } }			// Visualizacao Modelo 2

cString := "SZ8"

dbSelectArea("SZ8")
//
// Chamada do browse
//
mBrowse( 6,1,22,75,"SZ8")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA003I  ºAutor  ³Microsiga           º Data ³  05/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de Inclusao cadastro.                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATA003I()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 3

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZ8")

_nUsado:=0
aHeader:={}

_cCab := "Z8_CLIENTE/Z8_LOJA/Z8_LICENCA/Z8_DTINI/Z8_DTFIM"

While !Eof() .And. (x3_arquivo == "SZ8")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		_nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aCols  := Array(1,_nUsado+1)
_nUsado := 0

DbSelectArea("SX3")
DbSeek("SZ8")

While !Eof() .And. (x3_arquivo == "SZ8")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		_nUsado++
		
		If x3_tipo == "C"
			aCOLS[1][_nUsado] := SPACE(x3_tamanho)
		ElseIf x3_tipo == "N"
			aCOLS[1][_nUsado] := 0
		ElseIf x3_tipo == "D"
			aCOLS[1][_nUsado] := dDataBase
		ElseIf x3_tipo == "M"
			aCOLS[1][_nUsado] := ""
		Else
			aCOLS[1][_nUsado] := .F.
		EndIf
		
	Endif
	
	DbSkip()
Enddo

aCOLS[1][_nUsado+1] := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Posicionamento no aCols                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_nPosDel := Len(aHeader) + 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cCliente 	:= Space(Len(SZ8->Z8_CLIENTE))
_cLoja		:= Space(Len(SZ8->Z8_LOJA))
_cLicenca	:= Space(Len(SZ8->Z8_LICENCA))
_dDataIni	:= Ctod("")
_dDataFim	:= Ctod("")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//_cObs    := Space(256)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cTitulo  := "Inclusao Licenca Ministerio do Exercito"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cCliente" 	,{15,018} 	,"Cliente"  		,"@!"	, "Existcpo('SA1') .and. ExistChav('SZ8',_cCliente+_cLoja+_cLicenca)" 					,"SA1"	,.t.})
AADD(aC,{"_cLoja" 		,{15,100} 	,"Loja"  			,"@!"	, "Existcpo('SA1',_cCliente+_cLoja) .and. ExistChav('SZ8',_cCliente+_cLoja+_cLicenca)"	,		,.t.})
AADD(aC,{"_cLicenca" 	,{35,018} 	,"Licenca" 			,"@!"	, "naovazio() .and. ExistChav('SZ8',_cCliente+_cLoja+_cLicenca)"						,		,.t.})
AADD(aC,{"_dDataIni" 	,{55,018} 	,"Dt.Inicial"		,"@!"	, ""																					,		,.t.})
AADD(aC,{"_dDataFim" 	,{55,100} 	,"Dt.Final" 		,"@!"	, "_dDataFim >= _dDataIni"																,		,.t.})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//AADD(aR,{"_cObs",{129,17},"Observacao","@S40",,,.t.})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//aCGD := {68,5,128,315}
aCGD := {120,5,128,315}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cLinhaOk	:= ".T."
_cTudoOk	:= ".T."
n:= 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// lRetMod2 = .t. se confirmou
// lRetMod2 = .f. se cancelou

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,_cLinhaOK,_cTudoOK)

If lRetMod2
	Begin Transaction
	For _i:= 1 to Len(aCols)
		//
		// Se nao estiver deletado o item, cria o novo registro e grava os campos
		//
		If ! aCols[_i,Len(aHeader)+1]
			RecLock("SZ8",.t.)
			//
			// Gravacao do cabecalho
			//
			SZ8->Z8_FILIAL	:= xFilial("SZ8")
			SZ8->Z8_CLIENTE	:= _cCliente
			SZ8->Z8_LOJA	:= _cLoja
			SZ8->Z8_LICENCA	:= _cLicenca
			SZ8->Z8_DTINI	:= _dDataIni
			SZ8->Z8_DTFIM	:= _dDataFim
			//
			// Loop para a gravacao de todos os campos dos itens do acols
			//
			For _z:= 1 to Len(aHeader)
				_cVar := Alltrim(aHeader[_z,2])
				If ! _cVar $ _cCab
					SZ8->(&_cVar) := aCols[_i,_z]
				EndIf
			Next _z
			SZ8->(MsUnLock())
		EndIf
	Next _i
	End Transaction
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA003A  ºAutor  ³Microsiga           º Data ³  05/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de Alteracao cadastro.                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATA003A()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 3

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZ8")

nUsado:=0
aHeader:={}

_cCab := "Z8_CLIENTE/Z8_LOJA/Z8_LICENCA/Z8_DTINI/Z8_DTFIM"

While !Eof() .And. (x3_arquivo == "SZ8")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cCliente 	:= SZ8->Z8_CLIENTE
_cLoja		:= SZ8->Z8_LOJA
_cLicenca	:= SZ8->Z8_LICENCA
_dDataIni	:= SZ8->Z8_DTINI
_dDataFim	:= SZ8->Z8_DTFIM

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZ8")
DbSetOrder(1)
DbSeek(xFilial("SZ8")+_cCliente+_cLoja+_cLicenca,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZ8->(Eof()) .And. SZ8->Z8_FILIAL = xFilial("SZ8") .And. (SZ8->Z8_CLIENTE+SZ8->Z8_LOJA+SZ8->Z8_LICENCA)==;
	(_cCliente+_cLoja+_cLicenca)
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZ8->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZ8->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cTitulo  := "Alteracao Licenca Ministerio do Exercito"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cCliente" 	,{15,18} 	,"Cliente"  		,"@!"	, "Existcpo('SA1')"       						,"SA1"	,.f.})
AADD(aC,{"_cLoja" 		,{15,100} 	,"Loja"  			,"@!"	,        										,		,.f.})
AADD(aC,{"_cLicenca" 	,{35,18} 	,"Licenca" 			,"@!"	, "naovazio() .and. ExistChav('SZ8',_cCliente+_cLoja+_cLicenca)",		,.f.})
AADD(aC,{"_dDataIni" 	,{55,18} 	,"Dt.Inicial"		,"@!"	, ""											,		,.f.})
AADD(aC,{"_dDataFim" 	,{55,100} 	,"Dt.Final" 		,"@!"	, "_dDataFim >= _dDataIni"						,		,.f.})


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aCGD := {120,5,128,315}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

If lRetMod2
	
	Begin Transaction
	DbSelectArea("SZ8")
	DbSetOrder(1)
	DbSeek(xFilial("SZ8")+_cCliente+_cLoja+_cLicenca,.t.)
	//
	// Deletando os registros para gravar os novos
	//
	
	Do While ! Eof() .And. SZ8->Z8_FILIAL = xFilial("SZ8") .And. (SZ8->Z8_CLIENTE+SZ8->Z8_LOJA+SZ8->Z8_LICENCA)==;
		(_cCliente+_cLoja+_cLicenca)
		RecLock("SZ8",.f.)
		Delete
		SZ8->(MsUnLock())
		SZ8->(DbSkip())
	EndDo
	
	For _i:= 1 to Len(aCols)
		//
		// Se nao estiver deletado o item, cria o novo registro e grava os campos
		//
		If ! aCols[_i,Len(aHeader)+1]
			RecLock("SZ8",.t.)
			//
			// Gravacao do cabecalho
			//
			SZ8->Z8_FILIAL	:= xFilial("SZ8")
			SZ8->Z8_CLIENTE	:= _cCliente
			SZ8->Z8_LOJA	:= _cLoja
			SZ8->Z8_LICENCA	:= _cLicenca
			SZ8->Z8_DTINI	:= _dDataIni
			SZ8->Z8_DTFIM	:= _dDataFim
			//
			// Loop para a gravacao de todos os campos dos itens do acols
			//
			For _z:= 1 to Len(aHeader)
				_cVar := Alltrim(aHeader[_z,2])
				SZ8->(&_cVar) := aCols[_i,_z]
			Next _z
			SZ8->(MsUnLock())
		EndIf
	Next _i
	End Transaction
EndIf

DbCommitAll()

Return                


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA003E  ºAutor  ³Microsiga           º Data ³  05/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de Exclusao do cadastro.                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATA003E()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 5

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZ8")

nUsado:=0
aHeader:={}

_cCab := "Z8_CLIENTE/Z8_LOJA/Z8_LICENCA/Z8_DTINI/Z8_DTFIM"

While !Eof() .And. (x3_arquivo == "SZ8")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cCliente 	:= SZ8->Z8_CLIENTE
_cLoja		:= SZ8->Z8_LOJA
_cLicenca	:= SZ8->Z8_LICENCA
_dDataIni	:= SZ8->Z8_DTINI
_dDataFim	:= SZ8->Z8_DTFIM

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZ8")
DbSetOrder(1)
DbSeek(xFilial("SZ8")+_cCliente+_cLoja+_cLicenca,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZ8->(Eof()) .And. SZ8->Z8_FILIAL = xFilial("SZ8") .And. (SZ8->Z8_CLIENTE+SZ8->Z8_LOJA+SZ8->Z8_LICENCA)==;
	(_cCliente+_cLoja+_cLicenca)
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZ8->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZ8->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cTitulo  := "Visualizacao Licenca Ministerio do Exercito"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cCliente" 	,{15,18} 	,"Cliente"  		,"@!"	, "Existcpo('SA1')"       						,"SA1"	,.f.})
AADD(aC,{"_cLoja" 		,{15,100} 	,"Loja"  			,"@!"	,        										,		,.f.})
AADD(aC,{"_cLicenca" 	,{35,18} 	,"Licenca" 			,"@!"	, "naovazio() .and. ExistChav('SZ8',_cCliente+_cLoja+_cLicenca)",		,.f.})
AADD(aC,{"_dDataIni" 	,{55,18} 	,"Dt.Inicial"		,"@!"	, ""											,		,.f.})
AADD(aC,{"_dDataFim" 	,{55,100} 	,"Dt.Final" 		,"@!"	, "_dDataFim >= _dDataIni"						,		,.f.})


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aCGD := {120,5,128,315}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

If lRetMod2
	
	Begin Transaction
	DbSelectArea("SZ8")
	DbSetOrder(1)
	DbSeek(xFilial("SZ8")+_cCliente+_cLoja+_cLicenca,.t.)
	//
	// Deletando os registros para gravar os novos
	//
	
	Do While ! Eof() .And. SZ8->Z8_FILIAL = xFilial("SZ8") .And. (SZ8->Z8_CLIENTE+SZ8->Z8_LOJA+SZ8->Z8_LICENCA)==;
		(_cCliente+_cLoja+_cLicenca)
		RecLock("SZ8",.f.)
		Delete
		SZ8->(MsUnLock())
		SZ8->(DbSkip())
	EndDo
	End Transaction
EndIf

DbCommitAll()

Return                


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA003V  ºAutor  ³Microsiga           º Data ³  05/11/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao de Visualizacao do cadastro.                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function FATA003V()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 5

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZ8")

nUsado:=0
aHeader:={}

_cCab := "Z8_CLIENTE/Z8_LOJA/Z8_LICENCA/Z8_DTINI/Z8_DTFIM"

While !Eof() .And. (x3_arquivo == "SZ8")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cCliente 	:= SZ8->Z8_CLIENTE
_cLoja		:= SZ8->Z8_LOJA
_cLicenca	:= SZ8->Z8_LICENCA
_dDataIni	:= SZ8->Z8_DTINI
_dDataFim	:= SZ8->Z8_DTFIM

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZ8")
DbSetOrder(1)
DbSeek(xFilial("SZ8")+_cCliente+_cLoja+_cLicenca,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZ8->(Eof()) .And. SZ8->Z8_FILIAL = xFilial("SZ8") .And. (SZ8->Z8_CLIENTE+SZ8->Z8_LOJA+SZ8->Z8_LICENCA)==;
	(_cCliente+_cLoja+_cLicenca)
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZ8->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZ8->(DbSkip())
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cTitulo  := "Visualizacao Licenca Ministerio do Exercito"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cCliente" 	,{15,18} 	,"Cliente"  		,"@!"	, "Existcpo('SA1')"       						,"SA1"	,.f.})
AADD(aC,{"_cLoja" 		,{15,100} 	,"Loja"  			,"@!"	,        										,		,.f.})
AADD(aC,{"_cLicenca" 	,{35,18} 	,"Licenca" 			,"@!"	, "naovazio() .and. ExistChav('SZ8',_cCliente+_cLoja+_cLicenca)",		,.f.})
AADD(aC,{"_dDataIni" 	,{55,18} 	,"Dt.Inicial"		,"@!"	, ""											,		,.f.})
AADD(aC,{"_dDataFim" 	,{55,100} 	,"Dt.Final" 		,"@!"	, "_dDataFim >= _dDataIni"						,		,.f.})


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aCGD := {120,5,128,315}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

Return                