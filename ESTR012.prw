/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ESTR012   �Autor  �Microsiga           � Data �  27/05/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � IMPRESSAO ETIQUETA TERMICA DE IDENTIFICACAO DE LOCAL.      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
#Include "Topconn.ch"

User Function ESTR012()

cPerg := "REST12"
// Perguntas do relatorio

_fCriaSx1()

If ! Pergunte(cPerg,.t.)
	Return
EndIf

MsgRun("Imprimindo as etiquetas, aguarde ....",,{ || _fImprime() })
ApMsgInfo("Termino da impressao")

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �_fImprime �Autor  �Microsiga           � Data �  27/05/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Funcao da impressao.                                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - alpax.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function _fImprime()

_cQuery := "SELECT B1_PNUMBER, B1_MARCA, B1_DESC,  B1_CAPACID "
_cQuery += "FROM " + RetSqlName("SB1") + " B1 "
_cQuery += "WHERE B1.D_E_L_E_T_ = ' ' AND B1_MARCA BETWEEN '" + MV_PAR01 + "' AND '" + MV_PAR02 + "' "
_cQuery += "      AND B1_PNUMBER BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "      AND B1_MSBLQL <> '1' "
_cQuery += "ORDER BY B1_PNUMBER "

_cQuery := ChangeQuery(_cQuery)
TcQuery _cQuery New Alias "QR1"

QR1->(DbGoTop())

_lPrimeiro := .t.

_nCopias := iif(MV_PAR05==0,1,MV_PAR05)

Do While ! QR1->(Eof())
	If _lPrimeiro
		cPorta := "LPT1"
		MSCBPRINTER("ZEBRA",cPorta,,,.f.,,,,,,.t.)
		_lPrimeiro := .f.
	EndIf
	
	MSCBBEGIN(_nCopias,6)
	_cColIni := 5
	MSCBSAY(_cColIni,01,QR1->B1_MARCA				,"N","0","60,50")
	MSCBSAY(_cColIni,10,QR1->B1_PNUMBER  			,"N","0","60,50")
	MSCBSAY(_cColIni,18,LEFT(QR1->B1_DESC,35)		,"N","0","30,20")
	MSCBSAY(_cColIni,22,SUBSTR(QR1->B1_DESC,36,35)	,"N","0","30,20")
	MSCBSAY(_cColIni,26,QR1->B1_CAPACID  			,"N","0","30,20")
	
	MSCBEND()
	QR1->(DbSkip())
	
EndDo

If ! _lPrimeiro
	MSCBCLOSEPRINTER()
EndIf
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �_fCriaSx1 �Autor  �Microsiga           � Data �  27/05/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � Criacao das perguntas.                                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP - ALPAX.                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function _fCriaSx1()

PutSx1(cPerg,"01","Marca de ?"          ,"Marca de ?"          ,"Marca de ?"          ,"mv_ch1","C",15,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","SZ2")
PutSx1(cPerg,"02","Marca ate ?"         ,"Marca ate ?"         ,"Marca ate ?"         ,"mv_ch2","C",15,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","SZ2")
PutSx1(cPerg,"03","Part Number de ?"    ,"Part Number de ?"    ,"Part Number de ?"    ,"mv_ch3","C",20,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","",""   )
PutSx1(cPerg,"04","Part Number ate ?"   ,"Part Number ate ?"   ,"Part Number ate ?"   ,"mv_ch4","C",20,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","",""   )
PutSx1(cPerg,"05","Qtde. Etiquetas ?"   ,"Qtde. Etiquetas ?"   ,"Qtde. Etiquetas ?"   ,"mv_ch5","N",03,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","",""   )

Return