/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATA025   ºAutor  ³ Ocimar Rolli        º Data ³  20/05/14  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para verificar os orcamentos em aberto e atualiza-   ±±
±±º          ³ -los para cancelados.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                           
#Include "Topconn.ch"

User Function FATA025()     


Private cPerg 		:= "XFATA025"                                                   

PutSx1(cPerg,"01","Data de    "   ,"Data de    "   ,"Data de    "   ,"mv_ch1","D",08,0,0,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"02","Data ate   "   ,"Data ate   "   ,"Data ate   "   ,"mv_ch2","D",08,0,0,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"03","Orçamento de  ","Orçamento de  ","Orçamento de  ","mv_ch3","C",06,0,0,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",,,)
PutSx1(cPerg,"04","Orçamento ate ","Orçamento ate ","Orçamento ate ","mv_ch4","C",06,0,0,"G","",""   ,"","","mv_par04","","","","","","","","","","","","","","","","",,,)


If ! Pergunte(cPerg,.t.)
	Return
EndIf                        

If ! ApMsgYesNo("Confirma cancelamento dos orçamentos selecionados ??? ", "Confirmar")
	Return
EndIf 

If ! __cUserId $ "000016/000001/000074/000203"
	ApMsgStop("Voce nao tem acesso para cancelar orçamento....")
	Return
endif                          

MsgRun("Aguarde cancelando orçamentos !!!",,{ || fAtualiza() })

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fAtualiza ºAutor  ³ Ocimar Rolli       º Data ³  20/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao de atualizacao do cancelamento dos orçamentos.       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fAtualiza()

Local nCont := 0

_cQuery := "SELECT CJ_NUM, CJ_STATUS, R_E_C_N_O_ "
_cQuery += "FROM " + RetSqlName("SCJ") + " SCJ "
_cQuery += "WHERE CJ_FILIAL = '" + xFilial("SCJ") + "' AND D_E_L_E_T_ = ' ' AND CJ_STATUS = 'A' "
_cQuery += "      AND CJ_EMISSAO BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "' "
_cQuery += "      AND CJ_NUM BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "' "    
_cQuery += "ORDER BY CJ_NUM "

TcQuery _cQuery New Alias "QR1"

QR1->(DbGoTop())


Do While ! QR1->(Eof())
    SCJ->(DbGoTo(QR1->R_E_C_N_O_))
    RecLock("SCJ",.f.)
    SCJ->CJ_STATUS := "C"
    SCJ->(MsUnLock())
    nCont++
	QR1->(DbSkip())
EndDo           

ApMsgAlert("Foram cancelados " + Alltrim(Str(nCont)) + " orçamentos !!!","Informativo")

QR1->(DbCloseArea())

Return