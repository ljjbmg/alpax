#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "FONT.CH"
#INCLUDE "PRINT.CH"
#include "Ap5Mail.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CRIAHTM   ºAutor  ³CHRISTIAN CARDENAS  º Data ³  25/05/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CRIACAO DE HTML PARA IMPRESSAO DE ORCAMENTO                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

USER FUNCTION CRIAHTM
LOCAL CHTML

CHTML:='<style>'
CHTML+='thead { display: table-header-group; }'
CHTML+='tfoot { display: table-footer-group; }'
CHTML+='</style>'
CHTML+='</head><body>'
CHTML+='<table align="center" border="0" width="100%">'
CHTML+='<thead>'
CHTML+='<tr>'
CHTML+='<th width="100%">'
CHTML+='</th>'
CHTML+='</tr>'
CHTML+='</thead>'
CHTML+='<tfoot><tr>'
CHTML+='<td width="100%">'
CHTML+='</td>'
CHTML+='</tr>'
CHTML+='</tfoot>'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td width="100%">'
CHTML+='<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"><title>'+acabec[1]+'</title>'
CHTML+='<table style="text-align: left; background-color: white; width: 1070px; height: 91px;" border="0" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td style="width: 339px;"><font style="font-weight: bold;" size="+2"><span style="font-family: Calibri;"><big><font size="+3"><big><img style="width: 291px; height: 94px;" alt="" src="http://www.alpax.com.br/logo_alpax/logo_alpax.JPG"></big></font></big>'
CHTML+='</span></font></td>'
CHTML+='<td style="width: 835px;"><font size="+1"><span style="font-weight: bold;">ALPAX. COM, PROD. PARA. LABS. LTDA</span></font><br>'
CHTML+='<font size="-1">RUA SERRA DA BORBOREMA,40<br>'
CHTML+=' CAMPANARIO CEP:09930-580<br>'
CHTML+='DIADEMA/SP<br>'
CHTML+='</font><font size="-1">FONE:(11)4057-9200 FAX:(11)4057-9204</font><br>
CHTML+='</font><font size="-1">CNPJ: 65.838.344/0001-10 I.E.286.100.047.111</font></td>'
CHTML+='<td style="width: 418px;"><span style="font-weight: bold;">&nbsp;<font size="+1">ORÇAMENTO&nbsp;N.&nbsp;'+acabec[1]+'</font></span></td>'
CHTML+='</tr>'
CHTML+='</tbody>'
CHTML+='</table>'
CHTML+='<BR><table style="text-align: left; background-color: white; width: 1070px; height: 91px;" border="0" cellpadding="0" cellspacing="0">'
CHTML+='<TR><TD><font size="-1">NOME DO ATENDENTE:&nbsp;'+acabec[21]+'</font></td></tr>'
CHTML+='<TR><TD><font size="-1">E-MAIL DO ATENDENTE:&nbsp;'+acabec[22]+'</font></td></tr>'
CHTML+='<TR><TD><font size="-1">NOME DO REPRESENTANTE:&nbsp;'+acabec[23]+'</font></td></tr>'
CHTML+='<TR><TD><font size="-1">E-MAIL DO REPRESENTANTE:&nbsp;'+acabec[24]+'</font></td></tr>'
CHTML+='<TR><TD><font size="-1">COND. PAGAMENTO:&nbsp;'+acabec[25]+'</font></td></tr></TABLE>'
CHTML+='<table style="text-align: left; width: 1070px; height: 20px;" border="1" cellpadding="0" cellspacing="0"><tr>' //TIAGO
CHTML+='<td COLSPAN = "15" BGCOLOR = "#238E68"><font size="3" color = "white"><span style="font-weight: bold;">DESTINATARIO</span><br>'
CHTML+='</font></td>'
//CHTML+='<table style="text-align: left; width: 1070px; height: 20px;" border="1" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td colspan = "5" style="width: 1249px;"><font size="-2"><span style="font-weight: bold;">NOME/RAZÃO SOCIAL</span><br>'
CHTML+=acabec[2]+' </font></td>'
CHTML+='<td colspan = "10" style="width: 331px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">CNPJ/CPF</span><br>'
CHTML+=acabec[3]+'</spanstyle></font></td>'
CHTML+='</tr>'
CHTML+='</tbody>'
//CHTML+='</table>'
//CHTML+='<table style="text-align: left; width: 1070px; height: 20px;" border="1" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td colspan = "4" style="width: 845px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">ENDEREÇO</span><br>'
CHTML+=acabec[4]+'</spanstyle></font></td>'
CHTML+='<td colspan = "6" style="width: 472px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">BAIRRO/DISTRITO</span><br>'
CHTML+=acabec[5]+'</spanstyle></font></td>'
CHTML+='<td colspan = "5" style="width: 272px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">CEP</span><br>'
CHTML+=acabec[6]+'</spanstyle></font></td>'
CHTML+='</tr>'
CHTML+='</tbody>'
//CHTML+='</table>'
//CHTML+='<table style="text-align: left; width: 1070px; height: 20px;" border="1" cellpadding="0" cellspacing="0">'
//CHTML+='<tbody>'
CHTML+='<tr>'        
CHTML+='<td COLSPAN = "2" style="width: 299px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">MUNICIPIO</span><br>'
CHTML+=acabec[7] +'</spanstyle></font></td>'
CHTML+='<td COLSPAN = "2" style="width: 288px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">FONE/FAX</span><br>'
CHTML+=acabec[8] +'</spanstyle></font></td>'
CHTML+='<td COLSPAN = "2" style="width: 244px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">UF</span><br>'
CHTML+=acabec[9]+'</spanstyle></font></td>'
CHTML+='<td COLSPAN = "9" style="width: 208px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">INCRIÇAO'
CHTML+='ESTADUAL</span><br>'
CHTML+=acabec[10]+ '</spanstyle></font></td>'
CHTML+='</tr>'
CHTML+='</tbody>'
//CHTML+='</table>'
CHTML+='<TR><td COLSPAN = "15" BGCOLOR = "#238E68"><font size="3" color = "white" style="font-weight: bold;">CALCULO DE IMPOSTOS</font><fontsize ="-2"><br></TD></TR>'
CHTML+='</fontsize>'
//CHTML+='<table style="text-align: left; width: 1070px; height: 20px;" border="1" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td style="width: 216px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">BASE DE CALCULOS DO ICMS</span><br>'
CHTML+=acabec[12]+'</spanstyle></font></td>'
CHTML+='<td style="width: 165px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">VALOR'
CHTML+='DO ICMS</span><br>'
CHTML+= acabec[13]+'</spanstyle></font></td>'
CHTML+='<td colspan = "4" style="width: 275px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">BASE '
CHTML+='DE CALCULO DO ICMS SUBSTITUIÇÃO</span><br>'
CHTML+=acabec[26]+'</spanstyle></font></td>'
CHTML+='<td colspan = "3" style="width: 229px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">VALOR '
CHTML+='DO ICMS DE SUBSTITUIÇAO</span><br>'
CHTML+=acabec[14]+'</spanstyle></font></td>'
CHTML+='<td colspan = "6" style="width: 226px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">VALOR '
CHTML+='TOTAL DOS PRODUTOS </span><br>'
CHTML+=acabec[11]+'</spanstyle></font></td>'
CHTML+='</tr>'
CHTML+='</tbody>'
//CHTML+='</table>'
//CHTML+='<table style="text-align: left; width: 1070px; height: 20px;" border="1" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td style="width: 286px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">VALOR DO FRETE</span><br>'
CHTML+=acabec[19]+'</spanstyle></font></td>'
CHTML+='<td style="width: 206px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">DESCONTO</span><br>'
CHTML+='&nbsp; '+acabec[15]+'</spanstyle></font></td>'
CHTML+='<td COLSPAN = "3" style="width: 311px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">OUTRAS DESPESAS ACESSÓRIAS</span><br>'
CHTML+=acabec[27]+'</spanstyle></font></td>'
CHTML+='<td COLSPAN = "3" style="width: 280px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">VALOR DO IPI</span><br>'
CHTML+=acabec[16]+'</spanstyle></font></td>'
CHTML+='<td COLSPAN = "7" style="width: 269px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">VALOR TOTAL DO ORÇAMENTO</span><br>'
CHTML+=acabec[20]+'</spanstyle></font></td>'
CHTML+='</tr>'
CHTML+='</tbody>'
//CHTML+='</table>'
CHTML+='<TR><td COLSPAN = "15" BGCOLOR = "#238E68"><font size="3" color = "white"><span style="font-weight: bold;">TRANSPORTADOR/VOLUMESTRANSPORTADOS</span><br></TD></TR>'
CHTML+='</font>'
//CHTML+='<table style="text-align: left; width: 1070px; height: 20px;" border="1" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td colspan = "4" style="width: 894px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">RAZÃO SOCIAL</span><br>'
CHTML+='TRANSPORTADORA</spanstyle></font></td>'
CHTML+='<td colspan = "11" style="width: 695px;"><font size="-2"><spanstyle ="font-weight: bold;"><span style="font-weight: bold;">FRETE POR CONTA </span><br>'
CHTML+='0-EMITENTE/1-DESTINATARIO &nbsp; &nbsp; &nbsp; &nbsp;'+acabec[17]+' </spanstyle></font></td>'
CHTML+='</tr>'
CHTML+='</tbody>'
//CHTML+='</table>'
CHTML+='<TR><td COLSPAN = "15" BGCOLOR = "#238E68"><font size="3" color = "white"><span style="font-weight: bold;">DADOS DO PRODUTO/SERVIÇO</span><br></TD></TR>'
CHTML+='</font>'
//CHTML+='<table style="text-align: left; height: 20px; width: 971px;" border="1" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td>'
//CHTML+='<table style="text-align: left; width: 1067px; height: 20px;" border="0" cellpadding="0" cellspacing="0">'
CHTML+='<tbody>'
CHTML+='<tr>'
CHTML+='<td style="font-weight: bold; width: 05px;"><font size="-2">ITEM</font></td>'
CHTML+='<td style="font-weight: bold; width: 57px;"><font size="-2">REFERENCIA</font></td>'
CHTML+='<td style="font-weight: bold; width: 525px;"><font size="-2">DESCRIÇAO DO PRODUTO</font></td>'
CHTML+='<td style="font-weight: bold; width: 54px;"><font size="-2">NCM/SH</font></td>'
CHTML+='<td style="font-weight: bold; width: 50px;"><font size="-2">MARCA</font></td>'
CHTML+='<td style="font-weight: bold; width: 24px;"><font size="-2">ENTREGA</font></td>'
CHTML+='<td style="font-weight: bold; width: 22px;"><font size="-2">UN</font></td>'
CHTML+='<td style="font-weight: bold; width: 37px; text-align: center;"><font size="-2">QUANT.</font></td>'
CHTML+='<td style="font-weight: bold; width: 42px; text-align: center;"><font size="-2">V.UNIT.</font></td>'
CHTML+='<td style="font-weight: bold; width: 66px; text-align: center;"><font size="-2">V.TOTAL</font></td>'
CHTML+='<td style="font-weight: bold; width: 46px; text-align: center;"><font size="-2">BC.ICMS</font></td>'
CHTML+='<td style="font-weight: bold; width: 42px; text-align: center;"><font size="-2">V.ICMS</font></td>'
CHTML+='<td style="font-weight: bold; width: 33px; text-align: center;"><font size="-2">V.IPI</font></td>'
CHTML+='<td style="font-weight: bold; width: 33px; text-align: center;"><font size="-2">A.ICM</font></td>'
CHTML+='<td style="font-weight: bold; width: 33px; text-align: center;"><font size="-2">A.IPI</font></td>'
CHTML+='</tr>'
FOR  X:=1 TO LEN(AITENS) 
CHTML+='<tr>'

CHTML+='<td style="width: 05px;"><font size="-2">'+AITENS[X][15]+'</font></td>'
CHTML+='<td style="width: 57px;"><font size="-2">'+AITENS[X][1]+'</font></td>'
CHTML+='<td style="width: 525px;"><font size="-2">'+AITENS[X][2]+'</font></td>'
CHTML+='<td style="width: 54px;"><font size="-2">'+AITENS[X][3]+'</font></td>'
CHTML+='<td style="width: 50px;"><font size="-2">'+AITENS[X][4]+'</font></td>'
CHTML+='<td style="width: 24px;"><font size="-2">'+AITENS[X][5]+'</font></td>'
CHTML+='<td style="width: 22px;"><font size="-2">'+AITENS[X][6]+'</font></td>'
CHTML+='<td style="width: 37px; text-align: right;"><font size="-2"> '+AITENS[X][7]+'</font></td>'
CHTML+='<td style="width: 42px; text-align: right;"><font size="-2"> '+AITENS[X][8]+'</font></td>'
CHTML+='<td style="text-align: right; width: 66px;"><font size="-2"> '+AITENS[X][9]+'</font></td>'
CHTML+='<td style="text-align: right; width: 46px;"><font size="-2"> '+AITENS[X][10]+'</font></td>'
CHTML+='<td style="text-align: right; width: 42px;"><font size="-2"> '+AITENS[X][11]+'</font></td>'
CHTML+='<td style="width: 36px; text-align: right;"><font size="-2"> '+AITENS[X][12]+'</font></td>'
CHTML+='<td style="width: 36px; text-align: right;"><font size="-2"> '+AITENS[X][13]+'</font></td>'
CHTML+='<td style="width: 33px; text-align: right;"><font size="-2"> '+AITENS[X][14]+'</font></td>'
CHTML+='</tr>'
NEXT
CHTML+='</tbody>'
//CHTML+='</table>'
CHTML+='</td>'
CHTML+='</tr>'
CHTML+='</tbody>'
//CHTML+='</table>'
//CHTML+='      <font size="-2"><br>'
//CHTML+='      <br>'
//CHTML+='      <br>'
//CHTML+='      <br>'
//CHTML+='      </font><br>'
//CHTML+='      <br>'
//CHTML+='      <br>'
//CHTML+='      <font size="-1"><br>'
//CHTML+='      <br>'
//CHTML+='      </font>
CHTML+='<font size="-1"><spanstyle'
CHTML+=' ="font-weight: normal;"></spanstyle></font><fontsize'
CHTML+=' ="-1"><br>'
CHTML+='      </fontsize></td>'
CHTML+='    </tr>'
CHTML+='  </tbody>'
CHTML+='</table>'
CHTML+='<script language="JavaScript" type="text/javascript">var impresso=false;function Imprimir(){if(impresso==true) { window.location.reload(); impresso = false; }else { window.imprimir.style.visibility = "hidden"; impresso = true; window.print(); }setTimeout("Imprimir();",3000);}</script>'
CHTML+='<center>'
CHTML+='<table border="0" cellpadding="0" cellspacing="0"'
CHTML+=' width="600">'
CHTML+='  <tbody>'
CHTML+='    <tr>'
CHTML+='      <td width="470"></td>'
CHTML+='      <td width="130">'
CHTML+='      <div id="imprimir" style="position: relative;"'
CHTML+=' align="center"> <input value="Imprimir"'
CHTML+=' onclick="javascript:Imprimir()" type="button"> <br>'
CHTML+='      </div>'
CHTML+='      </td>'
CHTML+='    </tr>'
CHTML+='  </tbody>'
CHTML+='</table>'
CHTML+='</center>'
CHTML+='</body>'
CHTML+='</html>'




if file("\spool\"+ALLTRIM(ACABEC[1])+".HTML")
	ferase("\spool\"+ALLTRIM(ACABEC[1])+".HTML")
endif
if file (alltrim(GetTempPath())+"\"+ALLTRIM(ACABEC[1])+".HTML")
	ferase (alltrim(GetTempPath())+"\"+ALLTRIM(ACABEC[1])+".HTML")
endif

MEMOWRITE("\spool\"+ALLTRIM(ACABEC[1])+".HTML",CHTML)

if msgyesno("Deseja Enviar por Email")
    TelaMail()
endif
CpyS2T("\spool\"+ALLTRIM(ACABEC[1])+".HTML",alltrim(GetTempPath()), .T. ) // COPIA PARA ESTACAO, NO DIRETORIO TEMPORARIO DO WINDOWS
SHELLEXECUTE("open",(alltrim(GetTempPath())+"\"+ALLTRIM(ACABEC[1])+".HTML"),"","",5) // MANDA ABRIR, O WINODWS TEM QUE TER CADASTRADO O OSFTWARE PADRAO DE ABERTURA DE ARQUIVOS HTML
if file("\spool\"+ALLTRIM(ACABEC[1])+".HTML")
	ferase("\spool\"+ALLTRIM(ACABEC[1])+".HTML")
endif



RETURN

STATIC Function TelaMail()
Local cArea := Alias()
Local nRec  := Recno()
Local cInd  := INdexOrd()   
Local _nX, _nCont := 0, _nPos := 2
Local oDlg
Local cSai := "N"
Private _cRemet :=  Space(50)
Private _cDestin := Space(50)
Private _cSubject00 := ""
Private _cCorpo := ""
Private _cServer := ""
Private _cConta  := ""
Private _cSenha  := ""
                     

 _cRemet := Alltrim(UsrRetMail(__cUserID))+"                                                    "
_cDestin:=ACABEC[18]+"                                                                    "
	@ 170,180  To 680,742 Dialog odlg Title "Envio de Orçamento por E-Mail"
	@ 005,010  To 255,230
	@ 030,014  Say "Email Origem  : " 
	@ 045,014  Say "Email Destino : "
	@ 060,014  Say "Titulo : "
	@ 075,014  Say "Texto  : "
	@ 160,014  Say "Observação : "

	@ 030,050  Get _cRemet    Size 160,8  //Email Origem      
	@ 045,050  Get _cDestin   Size 160,8  // Email Destino
		_cSubject00 := "ALPAX, ORÇAMENTO: "+ALLTRIM(ACABEC[1])
	
	@ 060,040  Say _cSubject00 Size 180,8 
	
		_cCorpo  := "Enviamos em anexo o Orçamento número "+ALLTRIM(ACABEC[1])+CHR(13)+CHR(10)+;
	            "Este orçamento deverá ser impresso "+CHR(13)+CHR(10)+;
	            "ALPAX COM. PROD. PARA LABS. LTDA"+CHR(13)+CHR(10)+;
	            "Atenciosamente,"+CHR(13)+CHR(10)+CHR(13)+CHR(10)+;
	            "Depto. de Vendas"+CHR(13)+CHR(10)+;
	            "ALPAX"


	oGet1:= tMultiget():New(074,040,{|u|if(Pcount()>0,_cCorpo:=u,_cCorpo)},odlg,180,80,,.T.,,,,.T.,,,,,,.T.)
	oGet1:lReadOnly :=  .T.
	oGet1:lWordWrap := .F.
	oGet1:EnableHScroll( .T. )


	_cTexto  := SPACE(400)
	oGet2:= tMultiget():New(170,040,{|u|if(Pcount()>0,_cTexto:=u,_cTexto)},odlg,180,80,,.T.,,,,.T.,,,,,,.T.)
	oGet2:lReadOnly :=  .F.
	oGet2:lWordWrap := .F.
	oGet2:EnableHScroll( .T. )


	@ 030,242  BmpButton  Type 1   Action  (ODLG:end(),EnviaOrc())                
	@ 050,242  BmpButton  Type 2   Action  (ODLG:end(),cSai := "S")                
  
	Activate dialog odlg 
	If cSai == "S"
		dbSelectArea(cArea)
     	dbSetOrder(cInd)
     	dbGoto(nRec)
     	Return
	Endif
Return
	
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ _EnvOrc  ³  Autor³                       ³ Data ³12/05/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Envia e-mail de Orçamento                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico ALPAX                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function EnviaOrc()
Private cFig := GetSrvProfString("StartPath","")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define informacoes referentes a configuracao do e-mail.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cServer   := ALLTRIM(GETMV("MV_RELSERV"))    //SERVIDOR SMTP
cAccount  := ALLTRIM(GETMV("MV_RELACNT"))    //CONTA DE EMAIL
cPassword := ALLTRIM(GETMV("MV_RELPSW"))     //SENHA DA CONTA
cEnvia    := _cRemet                         //EMAIL ORIGEM
cCopia    := ""
cRecebe   := _cDestin                        //EMAIL DESTINATARIO
cAssunto  := _cSubject00
aCRLF      := Chr(13) + Chr(10)           
cMensagem := ""
cItens    := ""                                

cMensagem := _cCorpo+aCRLF+Iif(!Empty(alltrim(_cTexto)),_cTexto,"")+aCRLF

CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lConectou

//If !MailAuth(cAccount,cPassword)
  //	MSGINFO("Falha na autenticação do Usuário!")
//	DISCONNECT SMTP SERVER RESULT lDisConectou
//Endif

	SEND MAIL 	FROM cEnvia ;
			TO 	 cRecebe ;
			SUBJECT _cSubject00 ;
			BODY cMensagem ;
		    ATTACHMENT "\spool\"+ALLTRIM(ACABEC[1])+".HTML" ;
			RESULT lEnviado

If lEnviado
   cMensagem:="" 
   cItens:= ""
   MSGBOX("E-Mail enviado com sucesso!","Enviado","Alert")
Else
	cMensagem := ""
	GET MAIL ERROR cMensagem
    MSGBOX(cMensagem,"E-mail NÃO foi enviado","Alert")
Endif
cMensagem:=""

DISCONNECT SMTP SERVER Result lDesConectou

Return