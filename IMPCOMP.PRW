#Include "Protheus.ch"
#include "Ap5Mail.ch"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPCOMP   ºAutor  ³CHRISTIAN CARDENAS  º Data ³  25/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ AJUSTE DE IMPOSTOS PARA CRIAÇAO DE ORÇAMENTO               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function AjustCont()
Private aHeaderSCL:= {}
Private aHeaderSCK:= {}

Processa({||u_IMPCOMP()},"Aguarde","Calculando Impostos. ")
Return

User Function IMPCOMP()

Local nIcmsNt := 0
Local nIpiNt  := 0
Local nIcmSNt := 0
Local nPisNt  := 0
Local nCofNt  := 0
Local nIcSNt  := 0
Local nIcCNt  := 0
Local nIssNt  := 0
Local nIrNt   := 0
Local nInsNt  := 0
Local nCslNt  := 0
Local ntotger := 0
Local nIcmsPd := 0
Local nIpiPd  := 0
Local nIcmSPd := 0
Local nPisPd  := 0
Local nCofPd  := 0
Local nIcSPd  := 0
Local nIcCPd  := 0
Local nIssPd  := 0
Local nIrPd   := 0
Local nInsPd  := 0
Local nCslPd  := 0
LOCAL nVez:= 0
Local nbasecalc:= 0
Local nvalicm := 0
Local nvalsub := 0
Local nvaldesc := 0
lOCAL nvalipi:= 0
lOCAL NZ
PRIVATE aITENS:= {}
PRIVATE aITENSX:= {}
Private aNot  := {}
Private aPed  := {}


//==============================================================================================
// REFAZENDO CALCULO DE IMPOSTOS
//==============================================================================================

dbSelectArea("SCJ")
dbSetOrder(1)

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial()+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA)

dbSelectArea("SA3")
dbSetOrder(1)
dbSeek(xFilial()+SCJ->CJ_AXVEND)

dbSelectArea("SA4")
dbSetOrder(1)
dbSeek(xFilial()+SA1->A1_TRANSP)

dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(xFilial()+SCJ->CJ_CONDPAG)

dbSelectArea("SCK")
dbSetOrder(1)
dbSeek(xFilial("SCK")+SCJ->CJ_NUM,.T.)
cArqSCK := ""
cArqSCL := ""
nItem := 0

If A415Monta(@cArqSCK,@cArqSCL,.F.)
	aHeader := aHeaderSCK
	MaFisSave()
	MaFisEnd()
	MaFisIni(Iif(Empty(SCJ->CJ_CLIENT),SCJ->CJ_CLIENTE,SCJ->CJ_CLIENT),;// 1-Codigo Cliente/Fornecedor
	SCJ->CJ_LOJAENT,;		// 2-Loja do Cliente/Fornecedor
	"C",;				// 3-C:Cliente , F:Fornecedor
	"N",;				// 4-Tipo da NF
	SA1->A1_TIPO,;		// 5-Tipo do Cliente/Fornecedor
	Nil,;
	Nil,;
	Nil,;
	Nil,;
	"MATA461")
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Agrega os itens para a funcao fiscal         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//cquery:=" select 'F' FLAG, * from "+retsqlname("SCK")+" where CK_NUM = '"+ALLTRIM(SCJ->CJ_NUM)+"' and CK_CLIENTE = '"+SCJ->CJ_CLIENTE+"' and CK_LOJA = '"+SCJ->CJ_LOJA+"'"
	//DBUseArea(.T., "TOPCONN", TCGenQry(,,cquery),"TRB", .T., .T.)
	//TCSETFIELD("TRB","FLAG","L",1,0)
	
	dbSelectArea("TMP1")
	dbGotop()
	While ( !Eof() )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se a linha foi deletada                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( !TMP1->CK_FLAG .And. !Empty(TMP1->CK_PRODUTO) )
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Posiciona Registros                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SB1->(dbSetOrder(1))
			If SB1->(MsSeek(xFilial("SB1")+TMP1->CK_PRODUTO))
				nQtdPeso := TMP1->CK_QTDVEN*SB1->B1_PESO
			EndIf
			SB2->(dbSetOrder(1))
			SB2->(MsSeek(xFilial("SB2")+TMP1->CK_PRODUTO+TMP1->CK_LOCAL))
			SF4->(dbSetOrder(1))
			SF4->(MsSeek(xFilial("SF4")+TMP1->CK_TES))
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Calcula o preco de lista                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nValMerc  := TMP1->CK_VALOR
			nPrcLista := TMP1->CK_PRUNIT
			nQtdPeso  := 0
			nItem++
			If ( nPrcLista == 0 )
				nPrcLista := A410Arred(nValMerc/TMP1->CK_QTDVEN,"CK_PRCVEN")
			EndIf
			nAcresFin := A410Arred(TMP1->CK_PRCVEN*SE4->E4_ACRSFIN/100,"D2_PRCVEN")
			nValMerc  += A410Arred(nAcresFin*TMP1->CK_QTDVEN,"D2_TOTAL")
			nDesconto := A410Arred(nPrcLista*TMP1->CK_QTDVEN,"D2_DESCON")-nValMerc
			nDesconto := IIf(nDesconto==0,TMP1->CK_VALDESC,nDesconto)
			nDesconto := Max(0,nDesconto)
			nPrcLista += nAcresFin
			nValMerc  += nDesconto
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Verifica a data de entrega para as duplicatas³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If ( TMP1->(FieldPos("CK_ENTREG"))>0 )
				If ( SCJ->CJ_EMISSAO > TMP1->CK_ENTREG .And. !Empty(TMP1->CK_ENTREG) )
					dDataCnd := TMP1->CK_ENTREG
				EndIf
			Else
				dDataCnd  := SCJ->CJ_EMISSAO
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Agrega os itens para a funcao fiscal         ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			MaFisAdd(TMP1->CK_PRODUTO,;   	// 1-Codigo do Produto ( Obrigatorio )
			TMP1->CK_TES,;	   	// 2-Codigo do TES ( Opcional )
			TMP1->CK_QTDVEN,;  	// 3-Quantidade ( Obrigatorio )
			nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
			nDesconto,; 	// 5-Valor do Desconto ( Opcional )
			"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
			"",;				// 7-Serie da NF Original ( Devolucao/Benef )
			0,;					// 8-RecNo da NF Original no arq SD1/SD2
			0,;					// 9-Valor do Frete do Item ( Opcional )
			0,;					// 10-Valor da Despesa do item ( Opcional )
			0,;					// 11-Valor do Seguro do item ( Opcional )
			0,;					// 12-Valor do Frete Autonomo ( Opcional )
			nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
			0)					// 14-Valor da Embalagem ( Opiconal )
			
			SB1->(dbSetOrder(1))
			If SB1->(MsSeek(xFilial("SB1")+TMP1->CK_PRODUTO))
				nQtdPeso := TMP1->CK_QTDVEN*SB1->B1_PESO
			Endif
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Altera peso para calcular frete              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			MaFisAlt("IT_PESO",nQtdPeso,nItem)
			MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
			MaFisAlt("IT_VALMERC",nValMerc,nItem)
			
			
			nIcmsNt := 0 //MAFISRET(nVez,'IT_VALICM')//VALOR ICMS
			nIpiNt  := 0 //MAFISRET(nVez,'IT_VALIPI')//VALOR IPI
			
			nIcmsNt := MAFISRET(nItem,'IT_VALICM')//VALOR ICMS
			nIpiNt  := MAFISRET(nItem,'IT_VALIPI')//VALOR IPI
			
//			aadd(aITENSX,{TMP1->CK_AXPNUMB,TMP1->CK_DESCRI,SB1->B1_POSIPI,	TMP1->CK_AXMARCA,	DTOC(TMP1->CK_ENTREG),	TMP1->CK_UM,	TRANSFORM(TMP1->CK_QTDVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_PRCVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(nIcmsNt,"@E 99,999,999.99"),	TRANSFORM(nIpiNt,"@E 99,999,999.99"),	TRANSFORM(SF4->F4_BASEICM,"@E 9999"),TRANSFORM(SF4->F4_BASEIPI,"@E 9999"),TMP1->CK_ITEM})   
//			aadd(aITENSX,{TMP1->CK_AXPNUMB,TMP1->CK_DESCRI+TMP1->CK_AXCAPAC,SB1->B1_POSIPI,	TMP1->CK_AXMARCA,	DTOC(TMP1->CK_ENTREG),	TMP1->CK_UM,	TRANSFORM(TMP1->CK_QTDVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_PRCVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(nIcmsNt,"@E 99,999,999.99"),	TRANSFORM(nIpiNt,"@E 99,999,999.99"),	TRANSFORM(SF4->F4_BASEICM,"@E 9999"),TRANSFORM(TMP1->CK_AXIPI,"@E 9999"),TMP1->CK_ITEM})

			nAliqICM := MAFISRET(nItem,'IT_ALIQICM') // ALIQUOTA ICMS
			nAliqICM := U_alqicm4("NFS","SA1",SCJ->CJ_CLIENTE,SCJ->CJ_LOJA,SB1->B1_COD,nAliqICM,"N")
			
			aadd(aITENSX,{TMP1->CK_AXPNUMB,TMP1->CK_DESCRI+TMP1->CK_AXCAPAC,SB1->B1_POSIPI,	TMP1->CK_AXMARCA,	DTOC(TMP1->CK_ENTREG),	TMP1->CK_UM,	TRANSFORM(TMP1->CK_QTDVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_PRCVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(nIcmsNt,"@E 99,999,999.99"),	TRANSFORM(nIpiNt,"@E 99,999,999.99"),	TRANSFORM(nAliqICM,"@E 9999"),TRANSFORM(TMP1->CK_AXIPI,"@E 9999"),TMP1->CK_ITEM})
			
			ntotger += TMP1->CK_VALOR     // valor total
			nbasecalc += TMP1->CK_VALOR   //valor base icms
			nvalicm +=nIcmsNt            //valor icms
			nvalipi+=nIpiNt              //valor ipi
			nvaldesc+= TMP1->CK_VALDESC   //desconto
			
		endif
		
		dbSelectArea("TMP1")
		dbSkip()
	EndDo
	
	aImp:=MafisRet(,"NF_IMPOSTOS")
	aImpGer := {}
	For nZ:=1  To Len (aImp)
		If aImp[nZ,1] <> "..."
			//aImp[nZ,1]-Sigla do Imposto         /aImp[nZ,2]-Descricao  do Imposto aImp[nZ,3]=Base de calculo
			//aImp[nZ,4]=Aliquota                 aImp[nZ,5]=Valor do Imposto
			//	aadd(aImpGer,{aImp[nZ,1],aImp[nZ][3],aImp[nZ][4],aImp[nZ][5]})
			aadd(aImpGer,{aImp[nZ,2],aImp[nZ,3],aImp[nZ,4],aImp[nZ][5]})
		EndIf
	Next                                                                                                                                                                                                                                                                                                                                                                                     
	
	nPosST := 0
	nPosST := aScan(aIMP,{|x| UPPER(AllTrim(x[1]))=="ICR"})
	IF nPosST > 0
		nvalsubBS :=  aIMP[nPosST,3]
		nvalsub  :=  aIMP[nPosST,5]
	else
		nvalsubBS := 0 // aIMP[nPosST,3]
		nvalsub  :=  0 //aIMP[nPosST,5]
		
	endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Indica os valores do cabecalho               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MaFisAlt("NF_FRETE",SCJ->CJ_FRETE)
	MaFisAlt("NF_SEGURO",SCJ->CJ_SEGURO)
	MaFisAlt("NF_AUTONOMO",SCJ->CJ_FRETAUT)
	MaFisAlt("NF_DESPESA",SCJ->CJ_DESPESA)
	MaFisAlt("NF_DESCONTO",MaFisRet(,"NF_DESCONTO")+MaFisRet(,"NF_VALMERC")*SCJ->CJ_PDESCAB/100)
	MaFisAlt("NF_DESCONTO",MaFisRet(,"NF_DESCONTO")+SCJ->CJ_DESCONT)
	MaFisWrite(1)
	
ENDIF


PSWORDER(1)
PSWSEEK(SCJ->CJ_AXATEND,.T.)
aUsuario := PSWRET()

If len(aUsuario) > 1
	cMailAtnt := ALLTRIM(aUsuario[1,14])
Else
	cMailAtnt := ""
Endif

PRIVATE aCABEC:= {SCJ->CJ_NUM,;                      //1
SA1->A1_NOME,;                                       //2
SA1->A1_CGC,;                                        //3
SA1->A1_END,;                                        //4
SA1->A1_BAIRRO,;                                     //5
SA1->A1_CEP,;                                        //6
SA1->A1_MUN,;                                        //7
SA1->A1_TEL,;                                        //8
SA1->A1_EST,;                                        //9
SA1->A1_INSCR,;                                      //10
Transform(ntotger,"@E 99,999,999.99" ),;             //11
Transform(nbasecalc+SCJ->CJ_FRETE+SCJ->CJ_DESPESA,"@E 99,999,999.99"),; //12
Transform(nvalicm,"@E 99,999,999.99"),;              //13
Transform(nvalsub,"@E 99,999,999.99"),;              //14
Transform(nvaldesc,"@E 99,999,999.99"),;             //15
Transform(nvalipi,"@E 99,999,999.99"),;              //16
iif(ALLTRIM(SCJ->CJ_AXFRETE)="F","1","0"),;           //17
SA1->A1_EMAIL,;                                      //18
Transform(SCJ->CJ_FRETE,"@E 99,999,999.99"),;        //19
IIF(ALLTRIM(SCJ->CJ_AXFRETE)="F",TRANSFORM(nvalipi+ntotger+nvalsub+SCJ->CJ_FRETE+SCJ->CJ_DESPESA,"@E 99,999,999.99"),TRANSFORM(nvalipi+ntotger+nvalsub+SCJ->CJ_DESPESA,"@E 99,999,999.99")) ,; //20
USRRETNAME(SCJ->CJ_AXATEND),;                           //21
ALLTRIM(cMailAtnt),;                                 //22
Alltrim(SA3->A3_NOME),;   			                        //23
ALLTRIM(SA3->A3_EMAIL),;                             //24
ALLTRIM(SCJ->CJ_CONDPAG) + " - " + ALLTRIM(SE4->E4_DESCRI),; //25
Transform(nvalsubBS ,"@E 99,999,999.99"),; // 26
Transform(SCJ->CJ_DESPESA,"@E 99,999,999.99") } //27


aITENS := ACLONE(aITENSX)

U_CRIAHTM()

aITENSX := {}
aITENS := {}
dbselectarea("TMP1")
TMP1->(DBclosearea())


//==================================================================================================================
// FIM DO CALCULO
//============================================================================================
RETURN


/*
nIcmsNt := 0
nIpiNt  := 0
nIcmSNt := 0
nPisNt  := 0
nCofNt  := 0
nIcSNt  := 0
nIcCNt  := 0
nIssNt  := 0
nIrNt   := 0
nInsNt  := 0
nCslNt  := 0
nVez++
MaFisWrite(1)
nIcmsNt := MAFISRET(nVez,'IT_VALICM')//VALOR ICMS
nIpiNt  := MAFISRET(nVez,'IT_VALIPI')//VALOR IPI
nIcmSNts := MAFISRET(nVez,'IT_VALSOL')//VALOR ICMS ST
nPisNt  := MAFISRET(nVez,'IT_VALPS2')//VALOR PIS
nCofNt  := MAFISRET(nVez,'IT_VALCF2')//VALOR COFIN
nIcSNt  := MAFISRET(nVez,'IT_VALSOL')//VALOR ICMS SOLIDARIO
nIcCNt  := MAFISRET(nVez,'IT_VALCMP')//VALOR ICMS COMPLEMENTAR
nIssNt  := MAFISRET(nVez,'IT_VALISS')//VALOR ISS
nIrNt   := MAFISRET(nVez,'IT_VALIRR')//VALOR IRRF
nInsNt  := MAFISRET(nVez,'IT_VALINS')//VALOR INSS
nCslNt  := MAFISRET(nVez,'IT_VALCSL')//VALOR CSLL
DBSELECTAREA("SB1")
DBSETORDER(1)
DBSEEK(XFILIAL()+TMP1->CK_PRODUTO)
DBSELECTAREA("SF4")
DBSETORDER(1)
DBSEEK(XFILIAL()+TMP1->CK_TES)
TMP1->(dbSkip())
EndDo



Return

*/



/*XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VERSAO ANTES DE 27.04.2011

#Include "Protheus.ch"
#include "Ap5Mail.ch"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPCOMP   ºAutor  ³CHRISTIAN CARDENAS  º Data ³  25/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ AJUSTE DE IMPOSTOS PARA CRIAÇAO DE ORÇAMENTO               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß



User Function AjustCont()
Processa({||u_IMPCOMP()},"Aguarde","Calculando Impostos. ")
Return

User Function IMPCOMP()

Local nIcmsNt := 0
Local nIpiNt  := 0
Local nIcmSNt := 0
Local nPisNt  := 0
Local nCofNt  := 0
Local nIcSNt  := 0
Local nIcCNt  := 0
Local nIssNt  := 0
Local nIrNt   := 0
Local nInsNt  := 0
Local nCslNt  := 0
Local ntotger := 0
Local nIcmsPd := 0
Local nIpiPd  := 0
Local nIcmSPd := 0
Local nPisPd  := 0
Local nCofPd  := 0
Local nIcSPd  := 0
Local nIcCPd  := 0
Local nIssPd  := 0
Local nIrPd   := 0
Local nInsPd  := 0
Local nCslPd  := 0
LOCAL nVez:= 0
Local nbasecalc:= 0
Local nvalicm := 0
Local nvalsub := 0
Local nvaldesc := 0
lOCAL nvalipi:= 0
PRIVATE aITENS:= {}
Private aNot  := {}
Private aPed  := {}


//==================================================================================================================
// refazendo calculo de impostos
//==================================================================================================================







dbselectarea("SCK")
SCK->(dbgotop())
MaFisSave()
MaFisEnd()
MaFisIni(SCJ->CJ_CLIENTE,;		// 1-Codigo Cliente/Fornecedor
SCJ->CJ_LOJA,;				// 2-Loja do Cliente/Fornecedor
"F",;			            // 3-C:Cliente , F:Fornecedor
"",;				// 4-Tipo da NF
"J",;				   		// 5-Tipo do Cliente/Fornecedor
Nil,;
Nil,;
Nil,;
Nil,;
"MATA103")
nVez := 0
cquery:=" select * from "+retsqlname("SCK")+" where CK_NUM = '"+ALLTRIM(SCJ->CJ_NUM)+"' and CK_CLIENTE = '"+SCJ->CJ_CLIENTE+"' and CK_LOJA = '"+SCJ->CJ_LOJA+"'"
DBUseArea(.T., "TOPCONN", TCGenQry(,,cquery),"TMP1", .T., .T.)
Do While !TMP1->(Eof())

nIcmsNt := 0
nIpiNt  := 0
nIcmSNt := 0
nPisNt  := 0
nCofNt  := 0
nIcSNt  := 0
nIcCNt  := 0
nIssNt  := 0
nIrNt   := 0
nInsNt  := 0
nCslNt  := 0
nVez++
MaFisAdd(TMP1->CK_PRODUTO,;   		// 1-Codigo do Produto ( Obrigatorio )
TMP1->CK_TES,;	        // 2-Codigo do TES ( Opcional )
TMP1->CK_QTDVEN,;	    	// 3-Quantidade ( Obrigatorio )
TMP1->CK_PRCVEN,; 		// 4-Preco Unitario ( Obrigatorio )
0,;                		// 5-Valor do Desconto ( Opcional )
,;						// 6-Numero da NF Original ( Devolucao/Benef )
,;						// 7-Serie da NF Original ( Devolucao/Benef )
,;					    // 8-RecNo da NF Original no arq SD1/SD2
0,;						// 9-Valor do Frete do Item ( Opcional )
0,;						// 10-Valor da Despesa do item ( Opcional )
0,;            			// 11-Valor do Seguro do item ( Opcional )
0,;						// 12-Valor do Frete Autonomo ( Opcional )
TMP1->CK_VALOR,;			// 13-Valor da Mercadoria ( Obrigatorio )
0,;						// 14-Valor da Embalagem ( Opiconal )
0,;		     			// 15-RecNo do SB1
0) 						// 16-RecNo do SF4

MaFisWrite(1)
nIcmsNt := MAFISRET(nVez,'IT_VALICM')//VALOR ICMS
nIpiNt  := MAFISRET(nVez,'IT_VALIPI')//VALOR IPI
nIcmSNts := MAFISRET(nVez,'IT_VALSOL')//VALOR ICMS ST
nPisNt  := MAFISRET(nVez,'IT_VALPS2')//VALOR PIS
nCofNt  := MAFISRET(nVez,'IT_VALCF2')//VALOR COFIN
nIcSNt  := MAFISRET(nVez,'IT_VALSOL')//VALOR ICMS SOLIDARIO
nIcCNt  := MAFISRET(nVez,'IT_VALCMP')//VALOR ICMS COMPLEMENTAR
nIssNt  := MAFISRET(nVez,'IT_VALISS')//VALOR ISS
nIrNt   := MAFISRET(nVez,'IT_VALIRR')//VALOR IRRF
nInsNt  := MAFISRET(nVez,'IT_VALINS')//VALOR INSS
nCslNt  := MAFISRET(nVez,'IT_VALCSL')//VALOR CSLL
DBSELECTAREA("SB1")
DBSETORDER(1)
DBSEEK(XFILIAL()+TMP1->CK_PRODUTO)
DBSELECTAREA("SF4")
DBSETORDER(1)
DBSEEK(XFILIAL()+TMP1->CK_TES)
ntotger += TMP1->CK_VALOR     // valor total
nbasecalc += TMP1->CK_VALOR   //valor base icms
nvalicm +=nIcmsNt            //valor icms
nvalsub+= nIcmSNts           //icms substituiçao total
nvalipi+=nIpiNt              //valor ipi
nvaldesc+= TMP1->CK_VALDESC   //desconto
aadd(aITENS,{TMP1->CK_PRODUTO,TMP1->CK_DESCRI,SB1->B1_POSIPI,	alltrim(SB1->B1_ORIGEM)+alltrim(SF4->F4_SITTRIB),	SF4->F4_CF,	TMP1->CK_UM,	TRANSFORM(TMP1->CK_QTDVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_PRCVEN,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(TMP1->CK_VALOR,"@E 99,999,999.99"),	TRANSFORM(nIcmsNt,"@E 99,999,999.99"),	TRANSFORM(nIpiNt,"@E 99,999,999.99"),	TRANSFORM(SF4->F4_BASEICM,"@E 9999"),TRANSFORM(SF4->F4_BASEIPI,"@E 9999")})
TMP1->(dbSkip())
EndDo

DBSELECTAREA("SA1")
DBSETORDER(1)
DBGOTOP()
DBSEEK(XFILIAL("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA)

DBSELECTAREA("SA3")
DBSETORDER(1)
DBGOTOP()
DBSEEK(XFILIAL("SA3")+SCJ->CJ_AXVEND)

DBSELECTAREA("SE4")
DBSETORDER(1)
DBGOTOP()
DBSEEK(XFILIAL("SE4")+SCJ->CJ_CONDPAG)


PSWORDER(1)
PSWSEEK(SCJ->CJ_AXATEND,.T.)
aUsuario := PSWRET()

If len(aUsuario) > 1
cMailAtnt := ALLTRIM(aUsuario[1,14])
Else
cMailAtnt := ""
Endif

PRIVATE aCABEC:= {SCJ->CJ_NUM,;                      //1
SA1->A1_NOME,;                                       //2
SA1->A1_CGC,;                                        //3
SA1->A1_END,;                                        //4
SA1->A1_BAIRRO,;                                     //5
SA1->A1_CEP,;                                        //6
SA1->A1_MUN,;                                        //7
SA1->A1_TEL,;                                        //8
SA1->A1_EST,;                                        //9
SA1->A1_INSCR,;                                      //10
Transform(ntotger,"@E 99,999,999.99" ),;             //11
Transform(nbasecalc,"@E 99,999,999.99"),;            //12 OK
Transform(nvalicm,"@E 99,999,999.99"),;              //13
Transform(nvalsub,"@E 99,999,999.99"),;              //14   NO
Transform(nvaldesc,"@E 99,999,999.99"),;             //15
Transform(nvalipi,"@E 99,999,999.99"),;              //16
if(ALLTRIM(SCJ->CJ_AXFRETE)="F","1","0"),;          //17
SA1->A1_EMAIL,;                                      //18
Transform(SCJ->CJ_FRETE,"@E 99,999,999.99"),;        //19
TRANSFORM(nvalipi+ntotger,"@E 99,999,999.99" ),;     //20
USRRETNAME(SCJ->CJ_AXATEND),;                           //21
ALLTRIM(cMailAtnt),;                                 //22
USRRETNAME(SCJ->CJ_AXVEND),;                           //23
ALLTRIM(SA3->A3_EMAIL),;                             //24
ALLTRIM(SCJ->CJ_CONDPAG) + " - " + ALLTRIM(SE4->E4_DESCRI) } //25

U_CRIAHTM()



dbselectarea("TMP1")
TMP1->(DBclosearea())
Return

*/
