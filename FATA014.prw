/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA014   ºAutor  ³Adriano Luis Brandao º Data ³  29/08/09  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para verificar os clientes inativos e alterar o     º±±
±±º          ³ vendedor/representante para codigo 000032                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                           
#Include "Topconn.ch"

User Function FATA014()     


Private cPerg 		:= "XFATA014"                                                   
Private _dDataIni	:= dDataBase

PutSx1(cPerg,"01","Dias Inativos"          ,"Dias Inativos"          ,"Dias Inativos"          ,"mv_ch1","N",12,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Vendedor"               ,"Vendedor"               ,"Vendedor"               ,"mv_ch2","N",06,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",,,)

If ! Pergunte(cPerg,.t.)
	Return
EndIf                        

_dDataIni := dDataBase - MV_PAR01

If ! ApMsgYesNo("Confirma alteracao do vendedor nos clientes inativos a partir da data de " + Dtoc(_dDataIni) + " ???", "Confirmar")
	Return
EndIf                            

MsgRun("Aguarde atualizacao dos clientes inativos !!!",,{ || fAtualiza() })

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fAtualiza ºAutor  ³Microsiga           º Data ³  08/29/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de atualizacao dos representantes nos clientes.      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fAtualiza()

Local nCont := 0

_cQuery := "SELECT A1_COD, F2_DOC, A1.R_E_C_N_O_, A1_VEND "
_cQuery += "FROM " + RetSqlName("SA1") + " A1 "
_cQuery += "LEFT OUTER JOIN " + RetSqlName("SF2") + " F2 "
_cQuery += "       ON F2_FILIAL = '" + xFilial("SF2") + "' AND F2_CLIENTE = A1_COD AND F2_LOJA = A1_LOJA "
_cQuery += "          AND F2_TIPO = 'N' AND F2_VALFAT > 0 AND F2_EMISSAO >= '" + DTOS(_dDataIni) + "' AND F2.D_E_L_E_T_ = ' ' "
_cQuery += "WHERE A1_FILIAL = '" + xFilial("SA1") + "' AND A1.D_E_L_E_T_ = ' ' AND A1_VEND = '" + MV_PAR02 + "' "
_cQuery += "ORDER BY F2_DOC "                       

TcQuery _cQuery New Alias "QR1"

QR1->(DbGoTop())


Do While ! QR1->(Eof()) .And. Empty(QR1->F2_DOC)
    SA1->(DbGoTo(QR1->R_E_C_N_O_))
    RecLock("SA1",.f.)
    SA1->A1_VEND := "000032"
    SA1->(MsUnLock())
    nCont++
	QR1->(DbSkip())
EndDo           

ApMsgAlert("Foram atualizados " + Alltrim(Str(nCont)) + " clientes inativos !!!","Informativo")

QR1->(DbCloseArea())

Return