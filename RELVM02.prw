
#INCLUDE "protheus.ch"
#INCLUDE "TOPCONN.ch"
               
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELVM02   � Autor �FAGNER / BIALE      � Data �  28/12/09   ���B
���Uso       � ALPAX                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RELVM02()

                      
//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1       := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2       := "de acordo com os parametros informados pelo usuario."
Local cDesc3       := "Relat�rio de Controle de Laborat�rio"
Local cPict        := ""
Local titulo       := "Relat�rio de Controle de Envio de Material ao Laborat�rio"
Local nLin         := 80
//Local Cabec1     := "1234567890ABCDEFGHIJ1234567890ABCDEFGHIJ1234567890ABCDEFGHIJ1234567890ABCDEFGHIJ1234567890ABCDEFGHIJ1234567890ABCDEFGHIJ1234567890ABCDEFGHIJ"
Local Cabec1       := "P.NUMBER             CODIGO           DESCRI��O                                           MARCA           CAPACIDADE          QTDE."
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd 		   := {}
Private lEnd       := .F.
Private lAbortPrint:= .F.
Private CbTxt      := ""
Private limite     := 132
Private tamanho    := "M"
Private nomeprog   := "RELVM02" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo      := 18
Private aReturn    := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey   := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RELVM02" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString    := ""


//���������������������������������������������������������������������Ŀ
//� Monta a interface padrao com o usuario...                           �
//�����������������������������������������������������������������������

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  28/12/09   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
local cQuery := ''

cQuery += " SELECT ZA1_PNUMBE, ZA1_COD,  ZA1_DESC, ZA1_NREDUZ,ZA1_MARCA, ZA1_CAPACI, (ZA1_QPV - ZA1_QENV) SUBIR "
cQuery += " FROM ZA1010 "                                                                                          
cQuery += " WHERE ZA1_STATUS IN ( '1', '0') AND (ZA1_QPV - ZA1_QENV) > 0 AND D_E_L_E_T_ = ''"
cQuery += " ORDER BY 1 "

DbUseArea( .T., "TOPCONN", TcGenqry( , , cQuery), "TRB", .F., .F. )



SetRegua(RecCount())

While TRB->(!EOF())

   //���������������������������������������������������������������������Ŀ
   //� Verifica o cancelamento pelo usuario...                             �
   //�����������������������������������������������������������������������

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

   //���������������������������������������������������������������������Ŀ
   //� Impressao do cabecalho do relatorio. . .                            �
   //�����������������������������������������������������������������������

   If nLin > 55 // Salto de P�gina. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

   // Coloque aqui a logica da impressao do seu programa...
   // Utilize PSAY para saida na impressora. Por exemplo:
    @nLin,000 PSAY TRB->ZA1_PNUMBE  // 20 CARAC
    @nLin,021 PSAY TRB->ZA1_COD     // 15 CARAC
    @nLin,038 PSAY TRB->ZA1_DESC    // 75 CARAC
    @nLin,090 PSAY TRB->ZA1_MARCA   // 15
    @nLin,106 PSAY TRB->ZA1_CAPACI  // 15
    @nLin,126 PSAY TRB->SUBIR
    

   nLin := nLin + 1 // Avanca a linha de impressao                         

   dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo
             
TRB->(DbCloseArea())
//���������������������������������������������������������������������Ŀ
//� Finaliza a execucao do relatorio...                                 �
//�����������������������������������������������������������������������

SET DEVICE TO SCREEN

//���������������������������������������������������������������������Ŀ
//� Se impressao em disco, chama o gerenciador de impressao...          �
//�����������������������������������������������������������������������

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return
