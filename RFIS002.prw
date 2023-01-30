/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFIS002   บAutor  ณOcimar Rolli        บ Data ณ  07/02/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio de Emissao de selos do Ministerio do Exercito     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
#Include "Topconn.ch"
#Include "Protheus.ch"

User Function RFIS002()

_cPerg := "RFIS02"

PutSx1(_cPerg,"01","Nome do Livro" ,"Nome do Livro" ,"Nome do Livro" ,"mv_ch1","C",30,0,0,"G","","","","","mv_par01",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","",,,)
PutSx1(_cPerg,"02","Mod. do Livro" ,"Mod. do Livro" ,"Mod. do Livro" ,"mv_ch2","C",30,0,0,"G","","","","","mv_par02",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","",,,)
PutSx1(_cPerg,"03","Pagina Inicial","Pagina Inicial","Pagina Inicial","mv_ch3","N",06,0,0,"G","","","","","mv_par03",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","",,,)
PutSx1(_cPerg,"04","Pagina ate    ","Pagina ate    ","Pagina ate    ","mv_ch4","N",06,0,0,"G","","","","","mv_par04",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","",,,)
PutSx1(_cPerg,"05","Num. do Livro ","Num. do Livro ","Num. do Livro ","mv_ch5","N",03,0,0,"G","","","","","mv_par05",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","",,,)
PutSx1(_cPerg,"06","Data do livro ","Data do livro ","Data do livro ","mv_ch6","D",08,0,0,"G","","","","","mv_par06",""   ,""   ,""   ,"",""   ,""   ,""   ,"","","","","","","","","",,,)
PutSx1(_cPerg,"07","Imp. Roberval ","Imp. Roberval ","Imp. Roberval ","mv_ch7","N",01,0,2,"C","","","","","mv_par07","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",,,)
PutSx1(_cPerg,"08","Imp. Luci     ","Imp. Luci     ","Imp. Luci     ","mv_ch8","N",01,0,2,"C","","","","","mv_par08","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",,,)
PutSx1(_cPerg,"09","Imp. Cristina ","Imp. Cristina ","Imp. Cristina ","mv_ch9","N",01,0,2,"C","","","","","mv_par09","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",,,)

If Pergunte(_cPerg,.t.)
	MsgRun("Aguarde gerando relatorio",,{ || fImpr011() })
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImpr011  บAutor  ณOcimar Rolli        บ Data ณ  11/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao de processamento do relatorio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fImpr011()

Private cTipTerm 	:= " T e r m o   d e   A b e r t u r a "
Private nNumPag     := mv_par03
Private nQtdPag     := (mv_par04+1-mv_par03)
Private oPrint

// Fontes utilizadas no relatorio.

Private oFont10		:= TFont():New("MS LINE DRAW"			,08,09,.T.,.F.,5,.T.,5,.T.,.F.)
Private oFont10N	:= TFont():New("MS LINE DRAW"			,08,09,.T.,.T.,5,.T.,5,.T.,.F.)

oPrint:= TMSPrinter():New( "Termos de Livros Fiscais" )
oPrint:SetPortrait() //SetLandscape()


_aTab := {"Janeiro","Fevereiro","Mar็o","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}

_cDia := Strzero(Day(mv_par06),2)
_cMes := _aTab[Month(mv_par06)]
_cAno := Strzero(Year(mv_par06),4)

fFormCab()
fImpRod()
cTipTerm := " T e r m o   d e   E n c e r r a m e n t o "
nNumPag  := mv_par04
fFormCab()
fImpRod()

oPrint:Preview()

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfFormCab  บAutor  ณOcimar Rolli        บ Data ณ  11/07/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta formulario completo, para preencher coom os dados.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - ALPAX.                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fFormCab()

oPrint:StartPage()

// BOX CABECALHO 1

oPrint:Say(0100,0800,mv_par01				    					                                                                 ,oFont10)
oPrint:Say(0200,0900,mv_par02				    					                                                                 ,oFont10)                                                          
oPrint:Say(0200,1700,"Folha : "+Transform((nNumPag),"@e 999,999")           	        	                                         ,oFont10)
oPrint:Say(0300,0800,"Numero de Ordem : "					 		                                                                 ,oFont10)
oPrint:Say(0300,1180,Transform(Strzero((mv_par05),3),"@e 999")				    					                                 ,oFont10)
oPrint:Say(0500,0700,cTipTerm       						                                                                         ,oFont10N)
oPrint:Say(0700,0200,"Contem este livro "+Transform((nQtdPag),"@e 999,999")+" folha(s) numerada(s) sequencialmente , do N. "+Transform((mv_par03),"@e 999,999")+" ao N. "+Transform((mv_par04),"@e 999,999")  ,oFont10)
oPrint:Say(0800,0200,"e servira para o lancamento das opera็oes proprias do estabelecimento do contribuinte abaixo "                 ,oFont10)
oPrint:Say(0900,0200,"identificado : "   																							 ,oFont10)
oPrint:Say(1100,0200,"ALPAX Comercio de Produtos para Laboratorios Ltda. "                                                           ,oFont10N)
oPrint:Say(1200,0200,"Endereco da empresa : Rua Serra da borborema, 40 "     														 ,oFont10)
oPrint:Say(1300,0200,"Bairro : Campanario   CEP. : 09930-580   Cidade : Diadema - Sao Paulo " 										 ,oFont10)
oPrint:Say(1400,0200,"Numero da Inscricao Estadual : 286.100.047.111 "   															 ,oFont10)
oPrint:Say(1500,0200,"Numero do CNPJ : 65.838.344/0001-10 "         																 ,oFont10)
oPrint:Say(1600,0200,"Registro de Junta Comercial n. : 999999999 "     																 ,oFont10)
oPrint:Say(1800,0200,_cDia+" de "+_cMes+" de "+_cAno                																 ,oFont10)

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfImpRod() บAutor  ณMicrosiga           บ Data ณ  02/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Imprime assinaturas nos termos de acordo com o que foi    บฑฑ
ฑฑบ          ณ  selecionado nas perguntas                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fImpRod()

If mv_par07 == 1
	oPrint:Line(2200,0200,2200,0700)
	oPrint:Say(2300,0200,"Contador "								     																 ,oFont10N)
	oPrint:Say(2350,0200,"Roberval Pereira dos Santos "				     																 ,oFont10N)
	oPrint:Say(2400,0200,"C.P.F. 065.554.928-56 "					     																 ,oFont10N)
	oPrint:Say(2450,0200,"C.R.C. 1SP196544/O-9 "					     																 ,oFont10N)
EndIf
If mv_par08 == 1
	oPrint:Line(2200,0800,2200,1300)
	oPrint:Say(2300,0800,"Socia "									     																 ,oFont10N)
	oPrint:Say(2350,0800,"Luci Akemi Masumoto "						     																 ,oFont10N)
	oPrint:Say(2400,0800,"R.G. 7.700.270-2/SSPSP "					     																 ,oFont10N)
	oPrint:Say(2450,0800,"C.P.F. 111.805.808-93 "					     																 ,oFont10N)
EndIf
If mv_par09 == 1
	oPrint:Line(2200,1400,2200,1900)
	oPrint:Say(2300,1400,"Socia"	  						      		   																 ,oFont10N)
	oPrint:Say(2350,1400,"Tereza Cristina F. Villela "					   																 ,oFont10N)
	oPrint:Say(2400,1400,"R.G. 38.469.862-1/SSPSP "						   																 ,oFont10N)
	oPrint:Say(2450,1400,"C.P.F. 019.101.938-01 "						   																 ,oFont10N)
EndIf


oPrint:EndPage()

Return()
