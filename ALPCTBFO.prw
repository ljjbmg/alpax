#include "topconn.ch"
#INCLUDE "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ALPCTBFO   ºAutor  ³ Fagner / Biale    º Data ³  21/10/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Auxilia no posicinamento e retorno das contas debito e      º±±
±±º          ³credito e Centro de Custo para a contabilização da Folha    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ALPCTBFO(cTipo)

Local cRet  := ''
Local aArea := GetArea()

If cTipo == 'CD'
	
	cPrioriza := Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXPRCD")
	
	iF cPrioriza == '1'
		cRet := Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXDEB")
	Else
		cCC  := ALLTRIM(Posicione("CTT",1,xFilial("CTT")+SRZ->RZ_CC,"CTT_RXDESP"))
		cRet := cCC + SUBSTR(Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXDEB"),6,10)
	Endif
	
Endif

If cTipo == 'CC'
	
	cPrioriza := Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXPRCC")
	
	iF cPrioriza == '1'
		cRet := Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXCRED")
	Else
		cCC  := Posicione("CTT",1,xFilial("CTT")+SRZ->RZ_CC,"CTT_RXDESP")
		cRet := cCC + SUBSTR(Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXCRED"),6,10)
	Endif
	
Endif

If cTipo == 'CDX'
	
	cPrioriza := Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXPRCD")
	
	iF cPrioriza == '1'
		cRet := Posicione("SRV",1,xFilial("SRV")+SRZ->RZ_PD,"RV_AXDEB")
	Else
		cCC  := ALLTRIM(Posicione("CTT",1,xFilial("CTT")+SRZ->RZ_CC,"CTT_RXDESP"))
		If SRV->RV_COD == '780'
			Do Case
				Case cCC $ '41202'
					cRet := cCC+ '0006'
				Case cCC $ '41210'
					cRet := cCC+ '0005'
				Case cCC $ '41220'
					cRet := cCC+ '0005'
				Case cCC $ '51101'
					cRet := cCC+ '0006'
				Case cCC $ '51202'
					cRet := cCC+ '0006'
			EndCase
		Else
			cRet := cCC+ '0014'
		EndIf
		
	Endif
	
Endif

If cTipo == 'CDE'       //INSS EMPRESA
	cCC  := ALLTRIM(Posicione("CTT",1,xFilial("CTT")+SRZ->RZ_CC,"CTT_RXDESP"))
	IF cCC $ '41210/41220'
		cRet := cCC + '0005'
	Else
		cRet := cCC + '0006'
	Endif
Endif

If cTipo == 'CDF'          //FGTS EMPRESA
	cCC  := ALLTRIM(Posicione("CTT",1,xFilial("CTT")+SRZ->RZ_CC,"CTT_RXDESP"))
	IF cCC $ '41210/41220'
		cRet := cCC + '0006'
	Else
		cRet := cCC + '0007'
	Endif
Endif

RestArea(aArea)

Return cRet
