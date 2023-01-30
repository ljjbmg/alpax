/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA416PV  ºAutor  ³Adriano Luis Brandaoº Data ³  22/10/04   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para atualizar os campos criados do orca  º±±
±±º          ³ mento para o pedido de vendas. sera acionado na confirmacaoº±±
±±º          ³ do orcamento de vendas.                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP - ALPAX                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MTA416PV()

Local _nY
_aArea 		:= GetArea()
_aAreaCK 	:= SCK->(GetArea())
_aAreaA1	:= SA1->(GetArea())
_aAreaA3	:= SA3->(GetArea())

//
//	Campos customizados atualizados
//
M->C5_VEND1 		:= M->CJ_AXVEND 
M->C5_AXATEN1		:= M->CJ_AXATEND
M->C5_AXATEND		:= USRRETNAME(M->CJ_AXATEND)                                                                                                       
M->C5_AXPEDCL		:= M->CJ_AXPEDCL
M->C5_TPFRETE		:= M->CJ_AXFRETE
M->C5_AXNOMCL		:= M->CJ_XNOME
M->C5_DESC1			:= M->CJ_AXDESC
M->C5_AXENDEN		:= M->CJ_AXENDEN
M->C5_CONDPAG		:= M->CJ_CONDPAG
M->C5_MENNOTA   	:= M->CJ_OBSERV1
M->C5_MENSERV   	:= M->CJ_OBSERV2
M->C5_INDPRES		:= "0"

// busca campo de comissao, no vendedor e se nao encontrar busca do vendedor.
SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE+SCJ->CJ_LOJA))
M->C5_COMIS1 := SA1->A1_COMIS
If Empty(M->C5_COMIS1)
	SA3->(DbSetOrder(1))
	SA3->(DbSeek(xFilial("SA3")+M->CJ_AXVEND))
	M->C5_COMIS1 := SA3->A3_COMIS
EndIf

//
//	Avaliacao de credito do total do orcamento
//

_nPosValor	:= aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_VALOR"		})	// Valor total do item
_nPosTplst	:= aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXTPLST"	})	// Tipo de lista
_nPosNOrc	:= aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_NUMORC" 	})	// Numero orcamento
_nPosPedPF	:= aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXCODPF"	})	// Codigo Policia federal
_nPosPedEX	:= aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXCODEX"	})	// Codigo Exercito
_nPosPedCL	:= aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXCALIB"	})	// Calibrado
_nPosPedLd  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXLAUDO"	})	// Laudo
_nPosPedPc  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXPTCAL"	})	// Ponto de Calibracao
_nPosPedTl  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXTOLER"	})	// Tolerancia
_nPosPedTc  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXTIPCA"	})	// Tipo de Calibracao
_nPosPedRc  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXRISCO"	})  // Classe de Risco
_nPosPeIpi  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXIPI"  	})  // Ipi do produto 
_nPosAutor  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_XAUTORI" 	})  // Numero da autorizacao especial
_nPosCodIS  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_CODISS" 	})  // Codigo do servico
_nPosCodCl  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXPEDCL"    })  // Nr.Pedido Cliente // Incluso por Julio-biale
_nPosItmCl  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXITCLI"    })  // Nr.Item Cliente   // Incluso por Julio-biale
_nPosItmPn  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXPNUMB"    })  // Part Number       // Incluso por Ocimar 10/02/14
_nPosItmMc  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXMARCA"    })  // Marca             // Incluso por Ocimar 10/02/14
_nPosItmCp  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXCAPAC"    })  // Capacidade        // Incluso por Ocimar 10/02/14
_nPosItmNo  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXNONU"     })  // N. ONU            // Incluso por Ocimar 10/12/15
_nPosItmGe  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_AXGREMB"    })  // Grupo Embalagem   // Incluso por Ocimar 10/12/15
//_nPosItmTo  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_OPER"       })  // Tipo de Operacao  // Incluso por Ocimar 09/06/16
_nPosItmOp  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_XOPER"      })  // Operacao          // Incluso por Ocimar 09/06/16
//_nPosItmUm  := aScan(_aHeader,{|x| Alltrim(x[2]) == "C6_UM"         })  // Unidade de medida // Incluso por Ocimar 07/03/17

_nTotal		:= 0
//
// Soma todos os itens do orcamento
// e tambem atualiza alguns campos dos itens do pedido a partir do orcamento. (Ocimar)
For _nY := 1 to Len(_aCols)                                    
	If ! _aCols[_nY,len(_aHeader)+1]
		_nTotal	+= _aCols[_nY,_nPosValor]
	EndIf
Next _nY                                                              
//
// atualiza campos dos itens do orcamento para os itens do pedido de venda
//
SCK->(DbSetOrder(1))
SCK->(DbSeek(xFilial("SCK")+_aCols[Len(_aCols),_nPosNOrc],.T.))
_aCols[Len(_aCols),_nPosTplst] := SCK->CK_AXTPLST
_aCols[Len(_aCols),_nPosPedPF] := SCK->CK_AXCODPF
_aCols[Len(_aCols),_nPosPedEX] := SCK->CK_AXCODEX
_aCols[Len(_aCols),_nPosPedCL] := SCK->CK_AXCALIB                               
_aCols[Len(_aCols),_nPosPedLd] := SCK->CK_AXLAUDO
_aCols[Len(_aCols),_nPosPedPc] := SCK->CK_AXPTCAL
_aCols[Len(_aCols),_nPosPedTl] := SCK->CK_AXTOLER
_aCols[Len(_aCols),_nPosPedTc] := SCK->CK_AXTIPCA
_aCols[Len(_aCols),_nPosPedRc] := SCK->CK_AXRISCO
_aCols[Len(_aCols),_nPosPeIpi] := SCK->CK_AXIPI
_aCols[Len(_aCols),_nPosAutor] := SCK->CK_XAUTORI
_aCols[Len(_aCols),_nPosCodIS] := SCK->CK_XCODISS
_aCols[Len(_aCols),_nPosCodCl] := SCK->CK_COTCLI  // Incluso por Julio-Biale 21/05/13
_aCols[Len(_aCols),_nPosItmCl] := SCK->CK_ITECLI  // Incluso por Julio-Biale 21/05/13
_aCols[Len(_aCols),_nPosItmPn] := SCK->CK_AXPNUMB // Incluso por Ocimar 10/02/14
_aCols[Len(_aCols),_nPosItmMc] := SCK->CK_AXMARCA // Incluso por Ocimar 10/02/14
_aCols[Len(_aCols),_nPosItmCp] := SCK->CK_AXCAPAC // Incluso por Ocimar 10/02/14
_aCols[Len(_aCols),_nPosItmNo] := SCK->CK_AXNONU  // Incluso por Ocimar 10/12/15
_aCols[Len(_aCols),_nPosItmGe] := SCK->CK_AXGREMB // Incluso por Ocimar 10/12/15
//_aCols[Len(_aCols),_nPosItmTo] := SCK->CK_OPER    // Incluso por Ocimar 09/06/16
_aCols[Len(_aCols),_nPosItmOp] := SCK->CK_XOPER   // Incluso por Ocimar 09/06/16
//_aCols[Len(_aCols),_nPosItmUm] := SCK->CK_UM      // Incluso por Ocimar 07/03/17

If ! Empty(SCK->CK_XAUTORI)
	SZU->(DbSetOrder(5))
	If SZU->(DbSeek(xfilial("SZU")+SCK->CK_XAUTORI+SCK->CK_CLIENTE+SCK->CK_LOJA))
		RecLock("SZU",.F.)
		SZU->ZU_PEDIDO := M->C5_NUM
		SZU->(MsUnLock())     
	EndIf
EndIf

//
// avalia o credito enviado o valor total do orcamento para a rotina.
//
_cBlqCred := ""
_lCredito := .t.

_lCredito := MaAvalCred(M->CJ_CLIENTE,M->CJ_LOJA,_nTotal,M->CJ_MOEDA,.F.,@_cBlqCred)

// se houve problema de credito da uma mensagem de alerta ao usuario.
If ! _lCredito
	ApMsgStop("Havera bloqueio de credito futuro neste cliente, verificar cadastro !!!")
EndIf           

RestArea(_aAreaA3)
RestArea(_aAreaA1)
RestArea(_aAreaCK)
RestArea(_aArea)
Return
