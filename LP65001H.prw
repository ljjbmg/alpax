/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LP65001H ºAutor  ³Ocimar              º Data ³  04/06/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para retornar historico da baixa no lançamento      º±±
±±º          ³ padrao de debito e creito 650-001.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - Alpax                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "Topconn.ch"

User function LP65001H(_cNum,_cPref,_nValor)

LOCAL _cRet := " "

_cQuery := "SELECT E1_NOMCLI AS CLIENTE, E1_HIST AS HISTORICO, E5_HISTOR AS BAIXA, E5_PREFIXO AS PREFIXO, E5_NUMERO AS NUMERO, E5_VALOR AS VALOR "
_cQuery += "FROM " + RetSqlName("SE5") + " E5 "
_cQuery += "INNER JOIN " + RetSqlName("SE1") + " E1 "
_cQuery += "ON E1_NUM = E5_NUMERO AND E1_PREFIXO = E5_PREFIXO "
_cQuery += "WHERE E1_NUM = '" + _cNum + "' AND E5_RECPAG = 'R' AND E5.D_E_L_E_T_ = ' ' "

TcQuery _cQuery New Alias "QR1"

TcSetField("QR1","CLIENTE"		,"C",30,0)
TcSetField("QR1","HISTORICO"	,"C",30,0)
TcSetField("QR1","BAIXA"		,"C",30,0)
TcSetField("QR1","PREFIXO"		,"C",03,0)
TcSetField("QR1","NUMERO"		,"C",09,0)
TcSetField("QR1","VALOR"		,"N",12,0)

Do While ! QR1->(Eof()) .And. _cNum == QR1->NUMERO .And. _cPref == Alltrim(QR1->PREFIXO) .And. _nValor == QR1->VALOR
	_cRet := ("BX C. R. : NF "+_cNum+" : "+_cPref+"-"+(Rtrim(QR1->CLIENTE))+(Rtrim(QR1->HISTORICO))+(Rtrim(QR1->BAIXA)))
	QR1->(DbSkip())
EndDo

QR1->(DbCloseArea())

Return(_cRet)                                                                                                                 
