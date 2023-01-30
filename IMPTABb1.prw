
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "RWMAKE.CH"
#include "Topconn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ IMPTABB1 ³ Autor ³ BIALE                         ³ Data ³ 22/11/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ IMPORTAÇÃO DE TABELA EXCEL PARA UPDATE DA TABELA SB1                ±±
±±³                                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico - ALPAX           						              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function IMPTABB1()

Private   aTeste1   := {}
Private   cType     := "Arquivo da tabela | *.CSV"
Private   cPathEnt  := ""
Private   cNomArq   := ""
Private   cArquivo  := ""
Private   lRet      := .T.
Private   cMes      := ""
Private   cAno      := ""

cArquivo := cGetFile(cType,"Selecione o arquivo de importação",1,'C:\',.F.,GETF_LOCALHARD + GETF_LOCALFLOPPY)

aArqEDI := Directory(cArquivo)

aTeste1  := STRTOKARR(cArquivo,"\")
For nx := 1 to len(aTeste1)-1
	cPathEnt += aTeste1[nx]+"\"
Next

cNomArq := aTeste1[len(aTeste1)]

iF Empty(cNomArq)
	MsgBox("Nenhum arquivo a ser processado.","Atencao","ERRO")
	Return
Endif

cNomArq := aTeste1[len(aTeste1)]

aTeste1 := {}

Processa({||IMPTAB1()},"Importando tabela...")

If lRet
	MSGINFO("Tabela Importada com sucesso!!")
Else
	MSGINFO("Erro na Importação!!")
Endif

Return(.T.)

Static Function IMPTAB1()

Local   lLoop     := .t.	// Determina se ja houve skip de linha
Local   nLinha    := 1
Local   cCodProd  := ""
Local   nCusto    := 0
Local   cPN       := ""
Local   cDesc     := ""
Local   cMarca    := ""
Local   cValor    := ""
Local   nSaldo    := 0
Local   aTeste2   := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Abre o arquivo     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FT_FUSE(cArquivo)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa regua de processamento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua(FT_FLASTREC())
//IncProc("Importando tabela - "+Trim(cNomArq))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona no inicio do arquivo ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
FT_FGOTOP()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Loop para tratamento das linhas do arquivo        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lRet := .F.
DO While .t.
	If FT_FEOF()
		EXIT
	Endif
	cLinha  := FT_FREADLN()
	aTeste1  := STRTOKARR(cLinha,";")
	nLinha := nLinha + 1
	If nLinha >= 2
		If LEN(aTeste1) < 3
			lLoop := .T.
			EXIT
		Endif
		If ALLTRIM(aTeste1[01]) == ""
			FT_FSKIP()
			LOOP
		Endif
		dbselectarea("SB1")
		SB1->(DbOrderNickName("P. NUMBER"))
		If SB1->(dbseek(xFilial("SB1")+ALLTRIM(aTeste1[01])))
			DO WHILE SB1->(!EOF()) .AND. ALLTRIM(SB1->B1_PNUMBER) == ALLTRIM(aTeste1[01])
				IF ALLTRIM(SB1->B1_MARCA) == ALLTRIM(aTeste1[03])
					Reclock("SB1",.F.)
					aTeste2    := Separa(aTeste1[02],".")
					IF LEN(aTeste2) > 1
						cValor     := aTeste2[01]+aTeste2[02]
					ELSE
						cValor     := aTeste1[02]
					ENDIF
					aTeste2    := Separa(cValor,",")
					if len(aTeste2) > 1
						cValor     := aTeste2[01]+"."+aTeste2[02]
					endif
					SB1->B1_UPRC     := VAL(cValor)
					SB1->B1_PRV1     := ESTG001(VAL(cValor))
					SB1->B1_AXPRMIN  := ESTG002(VAL(cValor))
					SB1->B1_AXCUS    := ESTG003(VAL(cValor))
					ESTG006()
					SB1->(MsUnLock())
				ENDIF
				SB1->(dbSkip())
			ENDDO
		Endif
		IncProc("Adicionando preço no P/N - "+alltrim(aTeste1[01]) )
		SB1->(dbclosearea())
	Endif
	aTeste1 := {}
	If !lLoop
		FT_FSKIP()
	Else
		lLoop := .F.
	EndIf
EndDo
lRet := .T.
FT_FUSE()

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG001   ºAutor  ³Ocimar Rolli        º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de venda na inclusao ou al-  º±±
±±º          ³  teracao do preco de compra (IPI / Sub. Tribut.)           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC Function ESTG001(nValor)

Local aArea        := getarea()
Local aAreaB1      := SB1->(getArea())

Private _nCusto    := nValor
//Private _nCusto    := SB1->B1_AXCUS
Private _nAliqIpi  := SB1->B1_IPI/100
Private _nAliqSt   := SB1->B1_PICMENT/100
Private _nIndCad   := SB1->B1_AXINDIC
Private _nIndMar   := Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDPRV")
Private _nValor    := 0
Private _nValIpi   := (_nCusto*_nAliqIpi)
Private _nValSt    := (((_nCusto+(_nCusto*(_nAliqIpi)))*(1+_nAliqST))*0.18)
Private _nVlIcmN   := (_nCusto*0.18)
Private _nIndImp	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDPRVI")
Private _cMarca		:= GetNewPar("MV_AXMARCA","LOGEN")

// se for importado, troca para o novo indice de importados.
If SB1->B1_ORIGEM $ "1/6"
	_nIndMar := _nIndImp
EndIf

// Se for marca Logen parametro MV_AXMARCA altera indice
If Alltrim(SB1->B1_MARCA) $ _cMarca
	If SB1->B1_XSITPRO  == "I"
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDPRVI")
	ElseIf SB1->B1_XSITPRO  == "N"
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDPRV")
	Else
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDPRDV")
	EndIf
EndIf

Do Case
	
	Case _nAliqIpi==0 .And. _nAliqST==0
		_nValor := (_nCusto*iif(_nIndCad == 0,_nIndMar,_nIndCad))
	Case _nAliqIpi<>0 .And. _nAliqST==0
		If SB1->B1_ORIGEM == "1"
			_nValor := _nCusto*iif(_nIndCad == 0,_nIndMar,_nIndCad)
		Else
			_nValor := (_nCusto+_nValIpi)*iif(_nIndCad == 0,_nIndMar,_nIndCad)
		EndIf
	Case _nAliqIpi==0 .And. _nAliqST<>0
		_nValor := (_nCusto+(_nValST-_nVlIcmN))*iif(_nIndCad == 0,_nIndMar,_nIndCad)
	Case _nAliqIpi<>0 .And. _nAliqST<>0
		_nValor := (_nCusto+_nValIpi+(_nValST-_nVlIcmN))*iif(_nIndCad == 0,_nIndMar,_nIndCad)
EndCase

RestArea(aAreaB1)
RestArea(aArea)

Return(_nValor)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG002   ºAutor  ³Ocimar Rolli        º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de minimo na inclusao ou al- º±±
±±º          ³  teracao do preco de compra (IPI / Sub. Tribut.)           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC Function ESTG002(nValor)

Local aArea        := getarea()
Local aAreaB1      := SB1->(getArea())

Private _nCusto    := nValor
Private _nAliqIpi  := SB1->B1_IPI/100
Private _nAliqSt   := SB1->B1_PICMENT/100
Private _nIndMar   := Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDICE")
Private _nValor    := 0
Private _nValIpi   := (_nCusto*_nAliqIpi)
Private _nValSt    := (((_nCusto+(_nCusto*(_nAliqIpi)))*(1+_nAliqST))*0.18)
Private _nVlIcmN   := (_nCusto*0.18)
Private _nIndImp	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INIMPMI")
Private _cMarca		:= GetNewPar("MV_AXMARCA","LOGEN")

If SB1->B1_ORIGEM $ "1/6"
	_nIndMar := _nIndImp
EndIf

// Se for marca Logen parametro MV_AXMARCA altera indice
If Alltrim(SB1->B1_MARCA) $ _cMarca
	If SB1->B1_XSITPRO  == "I"
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INIMPMI")
	ElseIf SB1->B1_XSITPRO  == "N"
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDICE")
	Else
		_nIndMar	:= Posicione("SZ2",2,xFilial("SZ2")+SB1->B1_MARCA,"SZ2->Z2_INDPRDM")
	EndIf
EndIf


Do Case
	
	Case _nAliqIpi==0 .And. _nAliqST==0
		_nValor := (_nCusto*_nIndMar)
	Case _nAliqIpi<>0 .And. _nAliqST==0
		If SB1->B1_ORIGEM == "1"
			_nValor := _nCusto*_nIndMar
		Else
			_nValor := (_nCusto+_nValIpi)*_nIndMar
		EndIf
	Case _nAliqIpi==0 .And. _nAliqST<>0
		_nValor := (_nCusto+(_nValST-_nVlIcmN))*_nIndMar
	Case _nAliqIpi<>0 .And. _nAliqST<>0
		_nValor := (_nCusto+_nValIpi+(_nValST-_nVlIcmN))*_nIndMar
EndCase

RestArea(aAreaB1)
RestArea(aArea)

Return(_nValor)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG003   ºAutor  ³Ocimar Rolli        º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de custo na inclusao ou al-  º±±
±±º          ³  teracao do preco de compra (IPI / Sub. Tribut.)           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ESTG003()  

Private _nCusto    := SB1->B1_UPRC
Private _nAliqIpi  := SB1->B1_IPI/100
Private _nAliqSt   := SB1->B1_PICMENT/100
Private _nValor    := 0
Private _nValIpi   := (_nCusto*_nAliqIpi)
Private _nValSt    := (((_nCusto+(_nCusto*(_nAliqIpi)))*(1+_nAliqST))*0.18)
Private _nVlIcmN   := (_nCusto*0.18)

Do Case
	
	Case _nAliqIpi==0 .And. _nAliqST==0
		_nValor := _nCusto
	Case _nAliqIpi<>0 .And. _nAliqST==0
		If SB1->B1_ORIGEM $ "1/6" 
			_nValor := _nCusto
		Else
			_nValor := (_nCusto+_nValIpi)
		EndIf	
	Case _nAliqIpi==0 .And. _nAliqST<>0
		_nValor := (_nCusto+(_nValST-_nVlIcmN))
	Case _nAliqIpi<>0 .And. _nAliqST<>0
		_nValor := (_nCusto+_nValIpi+(_nValST-_nVlIcmN))
EndCase


Return(_nValor)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ESTG006   ºAutor  ³Ocimar Rolli        º Data ³  11/10/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Gatilho para atualizar preco de custo na inclusao ou al-  º±±
±±º          ³  teracao do preco de compra (IPI / Sub. Tribut.)           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ESTG006()
                             
Local 	aArea		:= getArea()
Local 	aAreaZ2		:= SZ2->(getArea())
Private _nCusto    	:= SB1->B1_AXCUS
Private _nValor    	:= _nCusto 
Private _cMarca		:= GetNewPar("MV_AXMARCA","LOGEN")

If SZ2->(Dbseek(xFilial("SZ2")+SB1->B1_MARCA))
	nPis 		:= 1.65 //aliquota de pis
	nCof		:= 7.60 //aliquota cofins
	nIcm		:= IIF(SB1->B1_PICM==0,18,SB1->B1_PICM) //ALIQUOTA DE ICM
	nPerc		:= (100 - (nPis + nCof + nIcm)) / 100   //percentual de calculo
	aTmp 		:= INDICEMR(_nCusto * nPerc)      //PARA CALCULAR INDICE DE MARCA
	_nPrcMin1	:= aTmp[01]
	_nPrcVen1	:= aTmp[02]
	DO CASE 
		CASE SB1->B1_ORIGEM $ "1|2|3|8|" //4%
			nPerc1 			:= (100 - (nPis + nCof + 4)) / 100  //percentual de calculo de 4%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_XPRV4		:= _nPrcVen                                         			
			SB1->B1_XPRMN4  	:= _nPrcMin 
			SB1->B1_XPRV7     := 0
			SB1->B1_XPRMN7    := 0
			SB1->B1_XPRV12    := 0
			SB1->B1_XPRMN12   := 0
		CASE SB1->B1_ORIGEM $ "0|4|5|6|7|" //7% E 12%
			nPerc1 			:= (100 - (nPis + nCof + 7)) / 100  //percentual de calculo de 7%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_XPRV7		:= _nPrcVen                                         
			SB1->B1_XPRMN7  	:= _nPrcMin					
			nPerc1 			:= (100 - (nPis + nCof + 12)) / 100  //percentual de calculo de 7%
			_nPrcMin		:= round(_nPrcMin1 / nPerc1,2)
			_nPrcVen		:= round(_nPrcVen1 / nPerc1,2)
			SB1->B1_XPRV12	:= _nPrcVen                                         
			SB1->B1_XPRMN12 	:= _nPrcMin
			SB1->B1_XPRV4     := 0
			SB1->B1_XPRMN4    := 0														
	ENDCASE								
	//NOVOS CAMPOS DE PRECO DE7ud 4%, 7% E 12% END
ENDIF    

RestArea(aAreaZ2)
REstArea(aArea)

Return(_nValor)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³INDICEMR  ºAutor  ³Microsiga           º Data ³  06/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ROTINA AUXILIAR PARA ADQUIRIR INDICE DE MARCA               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION INDICEMR(nCusto)

Local aRet		:= {}
Local _nPrcMin2	:= 0
Local _nPrcVen2	:= 0

If Alltrim(SB1->B1_MARCA) $ _cMarca		// SE MARCA CONSTA NO PARAMETRO, CALCULO DIFERENCIADO
	If SB1->B1_XSITPRO == "I"		// Importado comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRVI)))
	ElseIf SB1->B1_XSITPRO == "N" 	// Nacional Comprado
		_nPrcMin2 := (nCusto * SZ2->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRV)))
	Else	// Produzido
		_nPrcMin2 := (nCusto * SZ2->Z2_INDPRDM)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRDV)))
	EndIf
Else
	If SB1->B1_ORIGEM $ "1/6"
		_nPrcMin2 := (nCusto * SZ2->Z2_INIMPMI)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRVI)))
	Else
		_nPrcMin2 := (nCusto * SZ2->Z2_INDICE)
		_nPrcVen2 := (nCusto * (Iif(SB1->B1_AXINDIC > 0,SB1->B1_AXINDIC,SZ2->Z2_INDPRV)))
	EndIf
EndIf

AADD(aRet, _nPrcMin2 ) 
AADD(aRet, _nPrcVen2 ) 

RETURN(aRet)
