#INCLUDE "PROTHEUS.ch"

/*
AUTOR	: ANDERSON YAMAZAKI / BIALE
DATA	: 13/06/12
DESC	: FUNCAO PARA IMPRIMIR ETIQUETAS DE NOTAS FISCAIS DE ENTRADA PARA RASTREABILIDADE DOS PRODUTOS
*/

User Function ALPZ001()	//U_ALPZ001()


Local cDesc1         	:= "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         	:= "de acordo com os parametros informados pelo usuario."
Local cDesc3         	:= ""
Local cPict          	:= ""
Local titulo       		:= ""
Local nLin         		:= 80

Local Cabec1       		:= ""
Local Cabec2       		:= ""
Local imprime      		:= .T.
Local aOrd := {}
Private lEnd         	:= .F.
Private lAbortPrint  	:= .F.
Private CbTxt        	:= ""
Private limite          := 80
Private tamanho         := "G"
Private nomeprog        := "ALPZ001" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo           := 18
Private aReturn         := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      		:= Space(10)
Private cbcont     		:= 00
Private CONTFL     		:= 01
Private m_pag      		:= 01
Private wnrel      		:= "ALPZ01" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg 			:= nil

PRIVATE cPERG			:= PADR("ALPZ001",Len(SX1->X1_GRUPO)) 	//GRUPO DE PERGUNTAS
CRIASX1()	 													//CHAMANDO FUNCAO PARA CRIAR AS PERGUNTAS
IF !(PERGUNTE(cPERG))  											//CHAMA PERGUNTAS
	RETURN                 										//SE CANCELOU FINALIZA, SE OK CONTINUA FUNCAO
ENDIF															//FIM

dbSelectArea("SB1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint("SB1",NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,"SB1")

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  19/12/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Private cETQ 	:= ""
Private cFL  	:= CHR(13)+CHR(10)
PRIVATE cLOTE   := ""					//LOTE
PRIVATE cVCTO	:= ""					//VCTO LOTE
PRIVATE cSERIAL	:= ""					//SERIAL 

//QUERY PARA NOTAS FISCAIS DE ENTRADA -------------------------------------------
cQRY:=" SELECT B1_DESC, B1_CAPACID, B1_PNUMBER, D1_COD, D1_LOTECTL, D1_DTVALID, D1_DOC "+CRLF
cQRY+=" FROM "+RETSQLNAME("SD1")+" "+CRLF
cQRY+=" LEFT JOIN "+RETSQLNAME("SB1")+" ON B1_COD = D1_COD "+CRLF
cQRY+=" WHERE "+RETSQLNAME("SD1")+".D_E_L_E_T_ = '' "+CRLF
cQRY+=" AND "+RETSQLNAME("SB1")+".D_E_L_E_T_ = '' "+CRLF
cQRY+=" AND D1_COD = '160362683799BH1' "+CRLF
cQRY+=" AND D1_DOC = '000000368' "+CRLF
MEMOWRIT("C:\ALPAX\NFEALPAX.SQL",cQRY)
IF SELECT( "ETI" ) > 0													//SE ALIAS ESTIVER ABERTO
	DBSELECTAREA( "ETI" )    											//SELECIONA ALIAS
	ETI->( DBCLOSEAREA() ) 												//FECHA ALIAS
ENDIF                        											//FIM
DBUSEAREA( .T. , "TOPCONN", TCGenQRY( ,,cQRY ) , "ETI", .F. , .F. )		//ABRINDO cALIAS

ETI->(DBGOTOP())

cLOTE 	:= ALLTRIM(ETI->D1_LOTECTL)						//LOTE
cVCTO 	:= ALLTRIM(DTOC( STOD(ETI->D1_DTVALID) ))  	//VALIDADE DO LOTE
cSERIAL	:= "12345678901234567890"						//SERIAL

cLOTE	:= ""
cSERIAL	:= ""

cETQ += "CT~~CD,~CC^~CT~"+cFL
cETQ += "^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR4,4~SD15^JUS^LRN^CI0^XZ"+cFL
cETQ += "^XA"+cFL
cETQ += "^MMT"+cFL
cETQ += "^PW639"+cFL
cETQ += "^LL0240"+cFL
cETQ += "^LS0"+cFL
cETQ += "^BY2,3,30^FT231,157^BCN,,Y,N"+cFL
cETQ += "^FD>:1234567890^FS"+cFL
cETQ += "^BY2,3,28^FT104,214^BCN,,Y,N"+cFL
cETQ += "^FD>:12345678901234567890^FS"+cFL
cETQ += "^BY2,3,31^FT121,95^BCN,,Y,N"+cFL
cETQ += "^FD>:02131A3CZ003A27^FS"+cFL
cETQ += "^FO1,119^GB636,0,2^FS"+cFL
cETQ += "^FO1,180^GB637,0,3^FS"+cFL
cETQ += "^FT19,144^A0N,23,24^FH\^FDLOTE^FS"+cFL
cETQ += "^FT19,208^A0N,23,24^FH\^FDSERIAL^FS"+cFL
cETQ += "^FT19,172^A0N,23,24^FH\^FDVCTO mm/mm/mm^FS"+cFL
cETQ += "^FT21,60^A0N,23,24^FH\^FDWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW^FS"+cFL
cETQ += "^FT20,34^A0N,23,24^FH\^FDWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW^FS"+cFL
cETQ += "^PQ1,0,1,Y^XZ"+cFL

MEMOWRIT("C:\ALPAX\ALPZ001.TXT",cETQ)
	
@0,0 Psay cETQ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////|
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ CRIACAO DE PERGUNTAS                                                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////|

STATIC FUNCTION CRIASX1()
Local aPerguntas := {}   //Array com as perguntas

DBSELECTAREA("SX1")
IF LEN(X1_GRUPO) == 6
	cPerg := ALLTRIM(cPerg)
ENDIF

PutSx1(cPerg,"01","Da Nota Fiscal "  	,"Da Nota Fiscal"  	,"Da Nota Fiscal " 	,"mv_ch1","C",09,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","SF1",,,)
PutSx1(cPerg,"02","Ate Nota Fiscal"  	,"Ate Nota Fiscal"  ,"Ate Nota Fiscal" 	,"mv_ch2","C",09,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","SF1",,,)
PutSx1(cPerg,"03","Fornecedor"       	,"Fornecedor"  		,"Fornecedor"      	,"mv_ch3","C",06,0,0,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","SA2",,,)
PutSx1(cPerg,"04","Loja"       			,"Loja"  			,"Loja"         	,"mv_ch4","C",02,0,0,"G","",""   ,"","","mv_par04","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"05","Produto de"       	,"Produto de"  		,"Produto de"      	,"mv_ch5","C",15,0,0,"G","",""   ,"","","mv_par05","","","","","","","","","","","","","","","","SB1",,,)
PutSx1(cPerg,"06","Produto ate"       	,"Produto ate"  	,"Produto ate"    	,"mv_ch6","C",15,0,0,"G","",""   ,"","","mv_par06","","","","","","","","","","","","","","","","SB1",,,)
PutSx1(cPerg,"07","Lote de"       		,"Lote de"  		,"Lote de"        	,"mv_ch7","C",10,0,0,"G","",""   ,"","","mv_par07","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"08","Lote ate"       		,"Lote ate"  		,"Lote ate"         ,"mv_ch8","C",10,0,0,"G","",""   ,"","","mv_par08","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"09","Serial de"       	,"Serie de"  		,"Serie de"         ,"mv_ch9","C",20,0,0,"G","",""   ,"","","mv_par09","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"10","Serial ate"       	,"Serie ate"  		,"Serie ate"       	,"mv_chA","C",20,0,0,"G","",""   ,"","","mv_par10","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"11","Quantidade"       	,"Quantidade"  		,"Quantidade"      	,"mv_chB","N",09,0,0,"G","",""   ,"","","mv_par11","","","","","","","","","","","","","","","","",,,)

RETURN