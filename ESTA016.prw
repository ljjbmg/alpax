/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTA016   �Autor  �Ocimar Rolli        � Data �  29/03/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao de Cadastro dos produtos perigosos incompativeis     ���
���          � Tabela SZM010                                              ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#Include "rwmake.ch"
#Include "TopConn.ch"
#Include "Protheus.ch"

User Function ESTA016()

cCadastro := "Cadastro de Incompatibilidade de Produtos Perigosos"

Private aRotina := {   	{"Incluir"				,"U_ESTA016I()",0,3 } ,;	  	// Inclusao Modelo 2
						{"Alterar"				,"U_ESTA016A()",0,4 } ,;		// Alteracao Modelo 2
						{"Excluir"				,"U_ESTA016E()",0,5 } ,;		// Exclusao Modelo 2
						{"Visualizar"			,"U_ESTA016V()",0,1 } }			// Visualizacao Modelo 2

cString := "SZM"

dbSelectArea("SZM")
//
// Chamada do browse
//
mBrowse( 6,1,22,75,"SZM")

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTA016I  �Autor  �Microsiga           � Data �  05/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao de Inclusao cadastro.                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ESTA016I()

//��������������������������������������������������������������Ŀ
//� Opcao de acesso para o Modelo 2                              �
//����������������������������������������������������������������
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 3

//��������������������������������������������������������������Ŀ
//� Montando aHeader                                             �
//����������������������������������������������������������������

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZM")

_nUsado:=0
aHeader:={}

_cCab := "ZM_CLASSE/ZM_DESCCL"

While !Eof() .And. (x3_arquivo == "SZM")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		_nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo

//��������������������������������������������������������������Ŀ
//� Montando aCols                                               �
//����������������������������������������������������������������

aCols  := Array(1,_nUsado+1)
_nUsado := 0

DbSelectArea("SX3")
DbSeek("SZM")

While !Eof() .And. (x3_arquivo == "SZM")
	
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

//��������������������������������������������������������������Ŀ
//� Variaveis do Posicionamento no aCols                         �
//����������������������������������������������������������������

_nPosDel := Len(aHeader) + 1

//��������������������������������������������������������������Ŀ
//� Variaveis do Cabecalho do Modelo 2                           �
//����������������������������������������������������������������

_cClasse 	:= Space(Len(SZM->ZM_CLASSE))
_cDesccl 	:= Space(Len(SZM->ZM_DESCCL))

//��������������������������������������������������������������Ŀ
//� Variaveis do Rodape do Modelo 2                              �
//����������������������������������������������������������������

//_cObs    := Space(256)

//��������������������������������������������������������������Ŀ
//� Titulo da Janela                                             �
//����������������������������������������������������������������

cTitulo  := "Inclusao de Incompatibilidade de Produtos Perigosos"

//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Cabecalho do Modelo 2      �
//����������������������������������������������������������������

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cClasse" 	,{15,018} 	,"Classe     "  ,"@!"	,"U_VALIDA()","Z1",.t.})
AADD(aC,{"_cDesccl" 	,{30,018} 	,"Descricao"   	,"@!"	,,,.f.})

//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Rodape do Modelo 2         �
//����������������������������������������������������������������

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//AADD(aR,{"_cObs",{129,17},"Observacao","@S40",,,.t.})

//��������������������������������������������������������������Ŀ
//� Array com coordenadas da GetDados no modelo2                 �
//����������������������������������������������������������������

//aCGD := {68,5,128,315}
aCGD := {120,5,128,315}

//��������������������������������������������������������������Ŀ
//� Validacoes na GetDados da Modelo 2                           �
//����������������������������������������������������������������

_cLinhaOk	:= ".T."
_cTudoOk	:= ".T."
n:= 1

//��������������������������������������������������������������Ŀ
//� Chamada da Modelo2                                           �
//����������������������������������������������������������������

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
			RecLock("SZM",.t.)
			//
			// Gravacao do cabecalho
			//
			SZM->ZM_FILIAL	:= xFilial("SZM")
			SZM->ZM_CLASSE	:= _cClasse
			SZM->ZM_DESCCL	:= _cDesccl
			//
			// Loop para a gravacao de todos os campos dos itens do acols
			//
			For _z:= 1 to Len(aHeader)
				_cVar := Alltrim(aHeader[_z,2])
				If ! _cVar $ _cCab
					SZM->(&_cVar) := aCols[_i,_z]
				EndIf
			Next _z
			SZM->(MsUnLock())
		EndIf
	Next _i
	End Transaction
EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTA016A  �Autor  �Microsiga           � Data �  05/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao de Alteracao cadastro.                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ESTA016A()

//��������������������������������������������������������������Ŀ
//� Opcao de acesso para o Modelo 2                              �
//����������������������������������������������������������������
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 3

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZM")

nUsado:=0
aHeader:={}

_cCab := "ZM_CLASSE/ZM_DESCCL"

While !Eof() .And. (x3_arquivo == "SZM")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//��������������������������������������������������������������Ŀ
//� Variaveis do Cabecalho do Modelo 2                           �
//����������������������������������������������������������������

_cClasse 	:= SZM->ZM_CLASSE
_cDesccl 	:= SZM->ZM_DESCCL

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZM")
DbSetOrder(1)
DbSeek(xFilial("SZM")+_cClasse,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZM->(Eof()) .And. SZM->ZM_FILIAL = xFilial("SZM") .And. SZM->ZM_CLASSE == _cClasse
	
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZM->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZM->(DbSkip())
Enddo

//��������������������������������������������������������������Ŀ
//� Titulo da Janela                                             �
//����������������������������������������������������������������

cTitulo  := "Alteracao de Incompatibilidade de Produtos Perigosos"


//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Cabecalho do Modelo 2      �
//����������������������������������������������������������������

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cClasse" 	,{15,018} 	,"Classe     "  	,"@!"	,,,.f.})
AADD(aC,{"_cDesccl" 	,{30,018} 	,"Descricao"   		,"@!"	,,,.f.})

//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Rodape do Modelo 2         �
//����������������������������������������������������������������

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//��������������������������������������������������������������Ŀ
//� Array com coordenadas da GetDados no modelo2                 �
//����������������������������������������������������������������

aCGD := {120,5,128,315}

//��������������������������������������������������������������Ŀ
//� Validacoes na GetDados da Modelo 2                           �
//����������������������������������������������������������������

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

If lRetMod2
	
	Begin Transaction
	DbSelectArea("SZM")
	DbSetOrder(1)
	DbSeek(xFilial("SZM")+_cClasse,.t.)
	//
	// Deletando os registros para gravar os novos
	//
	
	Do While ! Eof() .And. SZM->ZM_FILIAL = xFilial("SZM") .And. SZM->ZM_CLASSE == _cClasse
		RecLock("SZM",.f.)
		Delete
		SZM->(MsUnLock())
		SZM->(DbSkip())
	EndDo
	
	For _i:= 1 to Len(aCols)
		//
		// Se nao estiver deletado o item, cria o novo registro e grava os campos
		//
		If ! aCols[_i,Len(aHeader)+1]
			RecLock("SZM",.t.)
			//
			// Gravacao do cabecalho
			//
			SZM->ZM_FILIAL	:= xFilial("SZM")
			SZM->ZM_CLASSE	:= _cClasse
			SZM->ZM_DESCCL	:= _cDesccl
			//
			// Loop para a gravacao de todos os campos dos itens do acols
			//
			For _z:= 1 to Len(aHeader)
				_cVar := Alltrim(aHeader[_z,2])
				SZM->(&_cVar) := aCols[_i,_z]
			Next _z
			SZM->(MsUnLock())
		EndIf
	Next _i
	End Transaction
EndIf

DbCommitAll()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTA016E  �Autor  �Microsiga           � Data �  05/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao de Exclusao do cadastro.                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ESTA016E()

//��������������������������������������������������������������Ŀ
//� Opcao de acesso para o Modelo 2                              �
//����������������������������������������������������������������
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 5

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZM")

nUsado:=0
aHeader:={}

_cCab := "ZM_CLASSE/ZM_DESCCL"

While !Eof() .And. (x3_arquivo == "SZM")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//��������������������������������������������������������������Ŀ
//� Variaveis do Cabecalho do Modelo 2                           �
//����������������������������������������������������������������

_cClasse 	:= SZM->ZM_CLASSE
_cDesccl 	:= SZM->ZM_DESCCL

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZM")
DbSetOrder(1)
DbSeek(xFilial("SZM")+_cClasse,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZM->(Eof()) .And. SZM->ZM_FILIAL = xFilial("SZM") .And. (SZM->ZM_CLASSE)==(_cClasse)
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZM->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZM->(DbSkip())
Enddo

//��������������������������������������������������������������Ŀ
//� Titulo da Janela                                             �
//����������������������������������������������������������������

cTitulo  := "Exclusao de Incompatibilidade de Produtos Perigosos"


//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Cabecalho do Modelo 2      �
//����������������������������������������������������������������

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cClasse" 	,{15,018} 	,"Classe     "  	,"@!"	,"U_VALIDA()",,.t.})
AADD(aC,{"_cDesccl" 	,{30,018} 	,"Descricao"   		,"@!"	, ,,.t.})

//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Rodape do Modelo 2         �
//����������������������������������������������������������������

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//��������������������������������������������������������������Ŀ
//� Array com coordenadas da GetDados no modelo2                 �
//����������������������������������������������������������������

aCGD := {120,5,128,315}

//��������������������������������������������������������������Ŀ
//� Validacoes na GetDados da Modelo 2                           �
//����������������������������������������������������������������

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

If lRetMod2
	
	Begin Transaction
	DbSelectArea("SZM")
	DbSetOrder(1)
	DbSeek(xFilial("SZM")+_cClasse,.t.)
	//
	// Deletando os registros para gravar os novos
	//
	
	Do While ! Eof() .And. SZM->ZM_FILIAL = xFilial("SZM") .And. (SZM->ZM_CLASSE)==(_cClasse)
		RecLock("SZM",.f.)
		Delete
		SZM->(MsUnLock())
		SZM->(DbSkip())
	EndDo
	End Transaction
EndIf

DbCommitAll()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTA016V  �Autor  �Microsiga           � Data �  05/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao de Visualizacao do cadastro.                        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ESTA016V()

//��������������������������������������������������������������Ŀ
//� Opcao de acesso para o Modelo 2                              �
//����������������������������������������������������������������
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

nOpcx := 5

//
// Montando um Aheader
//

DbSelectArea("SX3")
DbSetOrder(1)
DbSeek("SZM")

nUsado:=0
aHeader:={}

_cCab := "ZM_CLASSE/ZM_DESCCL"

While !Eof() .And. (x3_arquivo == "SZM")
	
	If X3USO(x3_usado) .AND. cNivel >= x3_nivel .And. ! Alltrim(X3_CAMPO) $ _cCab
		nUsado++
		AADD(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
		x3_decimal,, x3_usado, x3_tipo,;
		x3_arquivo, x3_context } )
	EndIf
	
	DbSkip()
Enddo


//��������������������������������������������������������������Ŀ
//� Variaveis do Cabecalho do Modelo 2                           �
//����������������������������������������������������������������

_cClasse 	:= SZM->ZM_CLASSE
_cDesccl 	:= SZM->ZM_DESCCL

//
// Variaveis de rodape
//
//_cObs    := SC3->C3_OBS

//
// Posiciona no primeiro item da tabela para adiciona-los no acols
//
DbSelectArea("SZM")
DbSetOrder(1)
DbSeek(xFilial("SZM")+_cClasse,.t.)

//
// String para inclusao na matriz dos itens
//
_cString	:= ""
//
// Inicializando a matriz dos itens e matriz em branco
//
aCols 	:= {}
n			:= 1


While !SZM->(Eof()) .And. SZM->ZM_FILIAL = xFilial("SZM") .And. (SZM->ZM_CLASSE)==(_cClasse)
	//
	// Adiciona matriz em branco, criado-se assim uma nova linha
	//
	aAdd(aCols,Array(nUsado+1))
	//
	// Grava todos os campos na linha do acols corrente
	//
	For _I:= 1 to Len(aHeader)
		_cVar := Alltrim(aHeader[_I,2])
		aCols[len(aCols),_I] := SZM->(&_cVar)
	Next _I
	//
	// Grava a ultima coluna logica .f. = usado
	//
	aCols[Len(aCols),Len(aHeader)+1] := .f.
	
	SZM->(DbSkip())
Enddo

//��������������������������������������������������������������Ŀ
//� Titulo da Janela                                             �
//����������������������������������������������������������������

cTitulo  := "Visualizacao de Incompatibilidade de produtos Perigosos"


//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Cabecalho do Modelo 2      �
//����������������������������������������������������������������

aC := { }

// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

AADD(aC,{"_cClasse" 	,{15,018} 	,"Classe     "  	,"@!"	, "ExistChav('SZM',_cClasse)",,.t.})
AADD(aC,{"_cDesccl" 	,{30,018} 	,"Descricao"   		,"@!"	, ,,.t.})

//��������������������������������������������������������������Ŀ
//� Array com descricao dos campos do Rodape do Modelo 2         �
//����������������������������������������������������������������

aR := { }

// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .t. se nao .f.

//��������������������������������������������������������������Ŀ
//� Array com coordenadas da GetDados no modelo2                 �
//����������������������������������������������������������������

aCGD := {120,5,128,315}

//��������������������������������������������������������������Ŀ
//� Validacoes na GetDados da Modelo 2                           �
//����������������������������������������������������������������

cLinhaOk := ".T."
cTudoOk  := ".T."

lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTA016   �Autor  �Ocimar Rolli        � Data �  12/04/08   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao para retornar descricao da classe no cabecalho do   ���
���          � mod. 2                                                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Valida()

_lRet := .t.

DbSelectArea("SX5")
DbSetOrder(1)
DbSeek(xFilial("SX5")+"Z1"+_cClasse,.t.)

if _cClasse <> " " .And. SX5->X5_CHAVE == _cClasse
	_cDesccl := SX5->X5_DESCRI
else
	MsgBox("Nao existe esta classe de risco")
	_lRet := .f.
EndIf

Return(_lRet)
