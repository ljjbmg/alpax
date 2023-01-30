#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "AP5MAIL.CH"

#DEFINE ENTER CHR(13)+CHR(10)

#DEFINE VBOX      080
#DEFINE VSPACE    008
#DEFINE HSPACE    010
#DEFINE SAYVSPACE 008
#DEFINE SAYHSPACE 008

#DEFINE HMARGEM   030
#DEFINE VMARGEM   030
#DEFINE MAXITEM   022                                                // Máximo de produtos para a primeira página
#DEFINE MAXITEMP2 060                                                // Máximo de produtos para as páginas adicionais
#DEFINE MAXITEMC  030                                                // Máxima de caracteres por linha de produtos/serviços
#DEFINE MAXMENLIN 120                                                // Máximo de caracteres por linha de dados adicionais
#DEFINE MAXMSG    007     

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ FISTRFNFE ³ Autor ³ Fagner / Biale       ³ Data ³ 05/09/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Inserir Botão na      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FISTRFNFE()

aadd(aRotina,{'IMP. CC-E','U_ImpCCE' , 0 , 3,0,NIL})

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ImpCCe ³ Autor ³ Fagner / Biale          ³ Data ³ 05/09/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressão grafica da Carta de Correção customizada         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function ImpCCe()


Local     nChave := IIF (SUBSTR(MV_PAR01,1,1) == '1', SF2->F2_CHVNFE, SF1->F1_CHVNFE)
Private   cQry := ""
Private   oCCE 
Private   cLogo      := FisxLogo("1")

oCCE := TMSPrinter():New("CCe - CARTA DE CORREÇÃO ELETRÔNICA")
oCCE:SetPortrait()   //Retrato
oCCE:SetPaperSize(9) //A4     

//oCCE:Setup()


If empty(nChave)
	Alert("Nota Fiscal sem Chave de Acesso !")   
	Return
Endif

cQry := " select NFE_CHV, CORGAO, TPEVENTO, SEQEVENTO, VERSAO, CMOTEVEN, STATUS, PROTOCOLO, AMBIENTE,"  + CRLF
cQry += " ISNULL(CONVERT(VARCHAR(8000), CONVERT(BINARY(8000),XML_ERP)),'') AS XML_ERP " + CRLF
cQry += " from SPED150 " + CRLF
cQry += " WHERE NFE_CHV = '"+Alltrim(nChave)+"' " + CRLF
cQry += " AND D_E_L_E_T_ = '' AND STATUS = '6'" + CRLF
                                                                    
	
RptStatus({|lEnd| CCeProc(@lEnd)},"Imprimindo CCe...")

oCCE:Preview() 

                                            

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ CCeProc ³ Autor ³ Fagner / Biale         ³ Data ³ 05/09/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Impressão grafica da Carta de Correção customizada         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
        
Static Function CCeProc(lEnd,IdEnt)
                    
Local nIni       := 130
Local nFim       := 2400
                                                                 
Local oFont12n   := TFont():New("Times New Roman",12,12,,.T.,,,,.T.,.F.)
Local oFont10n   := TFont():New("Times New Roman",10,10,,.T.,,,,.T.,.F.)
Local oFont10    := TFont():New("Times New Roman",10,10,,.F.,,,,.T.,.F.)

MEMOWRITE("C:\ADV0018.SQL", cQry)

if SELECT("QRY") > 0  
	QRY->(DBCloseArea())
EndIf 

DbUseArea( .T., "TOPCONN", TcGenqry( , , cQry), "QRY", .F., .T. )
QRY->(dbGotoP())

IF QRY->(!EOF())

//Cabeçalho do Documento    
oCCe:line( 130,50,130,2300 )
oCCe:line( 130,50,210,50 )
oCCe:Say( 150,900,"CARTA DE CORREÇÃO ELETRÔNICA - CCe",oFont12n )
oCCe:line( 130,2300,210,2300 )
oCCe:line( 210,50,210,2300 )

//Dados da Empresa
oCCe:line( 240,50,240,2300 )
oCCe:line( 240,50,840,50 )
oCCE:SayBitmap(280,55,cLogo,350,340) // logo                     
     
oCCe:Say( 340,400,"Alpax Com. de Prod. p/ Lab. Ltda.",oFont10n )            
oCCe:Say( 400,400,"Rua Serra da Borborema, 40"       ,oFont10  )            
oCCe:Say( 460,400,"Campanário   CEP: 09930-580"      ,oFont10  )
oCCe:Say( 520,400,"Diadema / SP"                     ,oFont10  )
oCCe:Say( 640,400,"CNPJ: 65.838.344/0001-10"         ,oFont10n )

oCCe:line( 240,1280,840,1280 )            

oCCe:Say( 280,1300,"Chave de Acesso:"                         ,oFont10n  )            

MSBAR3("CODE128",3,11.7,QRY->NFE_CHV,oCCE,,,,.02960,0.9,,,"C",.F.)
oCCe:Say( 530,1420,QRY->NFE_CHV                                ,oFont10  )            
            
oCCe:line( 600,1280,600,2300 )            

oCCe:Say( 640,1300,"Protocolo:"                               ,oFont10n  )            
oCCe:Say( 730,1420,STRTRAN(cValtoChar(QRY->PROTOCOLO),".","")  ,oFont10  )            

oCCe:line( 240,2300,840,2300 )
oCCe:line( 840,50,840,2300 )


// DADOS DA CORREÇÃO 

oCCe:Say( 900,900,"CORREÇÃO A SER CONSIDERADA",oFont10n )
oCCe:line(950,50,950,2300 )
oCCe:line(950,50,2000,50 )

nIni := AT("<xCorrecao>",QRY->XML_ERP) + 11
nFim := AT("</xCorrecao>",QRY->XML_ERP) - nIni + 1       

cCorrecao := SUBSTR(QRY->XML_ERP,nIni, nFim)
//cCorrecao := "0123456789ABCDEFGHIJKLMNOPQRSTUVXWYZ-0123456789ABCDEFGHIJKLMNOPQRSTUVXWYZ-0123456789ABCDEFGHIJKLMNOPQRSTUVXWYZ-0123456789ABCDEFGHIJKLMNOPQRSTUVXWYZ"

nIni := 1                                                                                                                      
nMax := 104
nLin := 990                  
nLidos := 0

nTot := len(cCorrecao)

If nTot > nMax 
nX := int(nTot / nMax)   
	For nY := 1 to nX
		oCCe:Say( nLin,55, substr(cCorrecao, nIni, nMax)  ,oFont10  )            
		nIni:= nIni + nMax  
		nLin := nLin + 60
		nLidos := nLidos + nMax
	Next                                               
	
	If nLidos < nTot 
		oCCe:Say( nLin,58, substr(cCorrecao, nIni, nTot - nIni)  ,oFont10  )            			
	Endif
			
Else              
	oCCe:Say( nLin,58, cCorrecao                ,oFont10  )            
Endif

oCCe:line(950,2300,2000,2300 )
oCCe:line(2000,50,2000,2300 )                          
oCCe:line(2000,50,2600,50 )

oCCe:Say( 2030,65,"NF-e"                                      ,oFont10n )            
oCCe:Say( 2090,65,substr(QRY->NFE_CHV,26,9)                 ,oFont10  )            

oCCe:line(2000,350,2200,350 )

oCCe:Say( 2030,365,"Orgão"    ,oFont10n )            
oCCe:Say( 2090,365,cValtoChar(QRY->CORGAO),oFont10  )            

oCCe:line(2000,700,2200,700 )

oCCe:Say( 2030,715,"Tipo Evento"    ,oFont10n )            
oCCe:Say( 2090,715,cValtoChar(QRY->TPEVENTO),oFont10  )            

oCCe:line(2000,1050,2200,1050 )                  

oCCe:Say( 2030,1065,"Seq Evento"    ,oFont10n )            
oCCe:Say( 2090,1065,cValtoChar(QRY->SEQEVENTO),oFont10  )            

oCCe:line(2000,1400,2200,1400 )       

oCCe:Say( 2030,1415,"Versão Evento"    ,oFont10n )            
oCCe:Say( 2090,1415,TRANSFORM(QRY->VERSAO,"@E 9.99"),oFont10  )            

oCCe:line(2000,1750,2200,1750 )

oCCe:Say( 2090,1765,QRY->CMOTEVEN,oFont10  )            

DBSELECTAREA("SA1")
SA1->(DBSETORDER(1))
SA1->(DBSEEK(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA))

oCCe:Say( 2220,65,"CNPJ / CPF Destinatário:"    ,oFont10n )            

If SA1->A1_PESSOA == 'J'
	oCCe:Say( 2300,65,TRANSFORM(SA1->A1_CGC,"@R 99.999.999/9999-99"),oFont10  )            
Else                               
	oCCe:Say( 2300,65,TRANSFORM(SA1->A1_CGC,"@R 999.999.9999-99"),oFont10  )            
Endif
                  
oCCe:line(2200,1125,2400,1125)

oCCe:Say( 2220,1140,"E-Mail Destinatário:"    ,oFont10n )            
oCCe:Say( 2300,1140,alltrim(SA1->A1_EMAIL)    ,oFont10  )            
          

oCCe:line(2200,50,2200,2300 )
oCCe:line(2400,50,2400,2300 )

oCCe:Say( 2420,65,"Razão Social:"          ,oFont10n )            
oCCe:Say( 2500,65,alltrim(SA1->A1_NOME)    ,oFont10  )            

oCCe:line(2000,2300,2600,2300 )                      
oCCe:line(2600,50,2600,2300 )

//Dados Fixos 

oCCe:Say( 2650,50,"Condição de uso da Carta de Correção"          ,oFont10n )            
oCCe:Say( 2750,50,"A Carta de Correção é disciplinada pelo paragrafo 1º-A do art. 7º do convênio S/N, de 15 de dezembro de 1970 e pode ser utilizada para regularização de erro "          ,oFont10 )            
oCCe:Say( 2800,50,"ocorrido ne emissao de documento fiscal, desde que o erro não esteja relacionado com:"          ,oFont10 )            
oCCe:Say( 2850,50,"I - as variáveis que determinam o valor do imposto tais como: base de calculo, alíquota, diferença de preço, quantidade, valor da operação ou da prestação;"          ,oFont10 )            
oCCe:Say( 2900,50,"II - A correção de dados cadastrais que implique mudança do remetente ou do destinatário;"          ,oFont10 )            
oCCe:Say( 2950,50,"III - A data de emissão ou de saída."          ,oFont10 )            

oCCe:line(3150,50,3150,1100 )

oCCe:line(3150,1200,3150,2300 )
oCCe:Say( 3200,50,"                     São Paulo, "+ dtoc(ddatabase)          ,oFont10 )            
             

If QRY->AMBIENTE == 1
	cAmbiente := "PRODUÇÃO"
Else
	cAmbiente := "HOMOLOGAÇÃO"
Endif

oCCe:Say( 3300,50,"NF-e emitida em ambiente de:  "+ cAmbiente          ,oFont10n )            

	QRY->(DBCloseArea())
//	MSGSTOP("Não existem resultados para esta consulta")
ENDIF


Return          

