User Function MTA930F1(cAlias)

Local lRet := .F. 
aArea := GetArea()          
cAlias := "MA930GRVQ1"
DBSELECTAREA("SD1")
//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM                                                                                                      
SD1->(DBSETORDER(1))
IF SD1->(DBSEEK( (cAlias)->F1_FILIAL+(cAlias)->F1_DOC+(cAlias)->F1_SERIE+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA))
	While SD1->(!EOF()) .AND.; 
	      (cAlias)->F1_FILIAL+(cAlias)->F1_DOC+(cAlias)->F1_SERIE+(cAlias)->F1_FORNECE+(cAlias)->F1_LOJA == ;
	      SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA
	      
	      If ALLTRIM(SD1->D1_TES) $ '052/048/195/199' 
	      	lRet := .T.
	      Endif
	      SD1->(dbskip())
	Enddo	 	

EndIf             
RestArea(aArea) 

Return lRet

