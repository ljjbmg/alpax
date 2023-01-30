#INCLUDE "PROTHEUS.CH"


/*
PONTO DE ENTRADA MA650GRPV()
- CHAMADO NA GERACAO DE OP POR PEDIDO DE VENDA
- EFETUA GRAVACAO DE TABELA ACESSORIO PARA CONTROLE DO LABORATORIO
- REGISTRO PARA CADA UNIDADE DO PRODUTO (SE C6_QTDVEN FOR 10, ENTAO SERAO 10 REGISTROS)

                           
11.01.2010 - TROCADO C6_LOCAL PARA "EL" DEVIDO AO TRATAMENTO DE ESTOQUE A SER ENVIADO A TERCEIROS

*/


USER FUNCTION MT650OPPV()

PRIVATE a01 := Getarea()
Private aPVOP := ParamIXB[1]
Private bZA1  := {||XPROC()}

PROCESSA(bZA1,"Gerando controle de laboratorio...")

RETURN NIL


STATIC FUNCTION XPROC()

Local cPV := ""
procregua(0)

for x := 1 to len(aPVOP)
    INCPROC(3)         
    
    IF SELECT("OP") <> 0
    	DBSELECTAREA("OP")
        OP->(DBCLOSEAREA("OP"))
    ENDIF
    
    cPV := aPVOP[x,1]                
    
    BEGINSQL ALIAS "OP"
        
        COLUMN C6_QTDVEN AS NUMERIC(17,2)
        
        SELECT C6_NUMOP, C6_ITEMOP, (C6_QTDVEN - C6_QTDENT ) C6_QTDVEN, C6_NUM, C6_ITEM, C6_CLI, C6_LOJA
              , C6_PRODUTO, C6_NFORI, C6_SERIORI, C6_ITEMORI, C6_CLI, C6_LOJA   
              , C6_LOCAL, F4.F4_PODER3
              , B1.B1_PNUMBER, B1.B1_MARCA, B1.B1_CAPACID
        FROM %table:SC6% C6
        LEFT JOIN %table:SF4% F4 ON F4.%NOTDEL% AND F4.F4_FILIAL = %xfilial:SF4% AND F4.F4_CODIGO = C6.C6_TES
        LEFT JOIN %table:SB1% B1 ON B1.%NOTDEL% AND B1.B1_FILIAL = %xfilial:SB1% AND B1.B1_COD = C6.C6_PRODUTO
        WHERE C6.%NOTDEL%
        AND C6.C6_FILIAL = %xfilial:SC6%
        AND C6.C6_BLQ <> 'R'
        AND C6.C6_NUMOP <> '      '
        AND B1.B1_MSBLQL <> '1'
        AND C6_NUMOP+C6_ITEMOP+'001' NOT IN ( SELECT ZA1_OP FROM ZA1010 ZA1 WHERE ZA1.%NOTDEL% )  
        AND C6.C6_NUMOP = %exp:alltrim(cPV)% 
        AND (C6_QTDVEN - C6_QTDENT ) > 0
        ORDER BY C6_NUMOP, C6_ITEMOP
        
    ENDSQL
     
 
    WHILE OP->(!EOF())
        INCPROC(3)

        IF LEN(ALLTRIM(OP->C6_NFORI)) = 0
            cLocal := "01"
        else                            
            cChave := xfilial("SD1")+OP->(C6_NFORI+C6_SERIORI+C6_CLI+C6_LOJA+C6_PRODUTO+C6_ITEMORI)
            cLocal := POSICIONE("SD1",1,cChave,"D1_LOCAL")
        ENDIF 
        // CRIANDO LOCAL CASO NAO EXISTA
        DBSELECTAREA("SB2")
        aBk := Getarea()
         DBSETORDER(2)
        DBGOTOP()
        IF !DBSEEK(XFILIAL("SB2")+cLocal+OP->C6_PRODUTO)
        	Reclock("SB2",.t.)
            SB2->B2_FILIAL  := xFilial("SB2")
            SB2->B2_COD     := OP->C6_PRODUTO
            SB2->B2_LOCAL   := cLocal     
            Msunlock()
            commit
        ENDIF       
        restarea(aBk)
        SB2->(dbgotop())
        
        DBSELECTAREA("SB2")
        aBk := Getarea()
        DBSETORDER(2)
        DBGOTOP()
        
        IF !DBSEEK(XFILIAL("SB2")+"01"+OP->C6_PRODUTO)
        	Reclock("SB2",.t.)
            SB2->B2_FILIAL  := xFilial("SB2")
            SB2->B2_COD     := OP->C6_PRODUTO
            SB2->B2_LOCAL   := "01"    
            Msunlock()
            commit
        ENDIF  
        restarea(aBk)
        SB2->(dbgotop())
          
        dbselectarea("OP")                   
        //-----|\ empenhando produto
        aEmpen := {}
        AADD(aEmpen,OP->C6_PRODUTO)
        AADD(aEmpen,cLocal)
        AADD(aEmpen,OP->(C6_NUMOP+C6_ITEMOP+"001"))
        AADD(aEmpen,dDatabase)
        AADD(aEmpen,OP->C6_QTDVEN)
        AADD(aEmpen,OP->C6_QTDVEN)
        AADD(aEmpen,NIL)
        AADD(aEmpen,NIL)
        
        IF !U_RADVL002(aEmpen,.t.)
            MsgAlert("Falha no empenho!, avise o Administrador")
            restarea(a01)
            Loop
        ENDIF
        
        RECLOCK("ZA1",.T.)
        ZA1->ZA1_FILIAL := XFILIAL("ZA1")
        ZA1->ZA1_STATUS := "0"
        ZA1->ZA1_PV     := OP->C6_NUM
        ZA1->ZA1_ITEMPV := OP->C6_ITEM
        ZA1->ZA1_NREDUZ := POSICIONE("SA1",1,XFILIAL("SA1")+OP->(C6_CLI+C6_LOJA),"A1_NREDUZ")
        ZA1->ZA1_DESC   := POSICIONE("SB1",1,XFILIAL("SB1")+OP->C6_PRODUTO,"B1_DESC")
        ZA1->ZA1_COD    := OP->C6_PRODUTO
        ZA1->ZA1_QPV    := OP->C6_QTDVEN
        ZA1->ZA1_OP     := OP->(C6_NUMOP+C6_ITEMOP+"001")
        ZA1->ZA1_LOCSAI := "EL"  //OP->C6_LOCAL
        ZA1->ZA1_LOCENT := cLocal              
        ZA1->ZA1_PNUMBE := OP->B1_PNUMBER
        ZA1->ZA1_MARCA  := OP->B1_MARCA
        ZA1->ZA1_CAPACI := OP->B1_CAPACID
        MSUNLOCK()
        COMMIT

        OP->(DBSKIP())
    ENDDO                   
    
    DBSELECTAREA("OP")
    OP->(DBCLOSEAREA("OP"))
    
Next    

DBSELECTAREA("ZA1") 
DBSETORDER(1)
DBGOTOP() 


restarea(a01)
RETURN(NIL)

