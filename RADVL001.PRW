#INCLUDE "PROTHEUS.CH"

/*
FUNCAOLIB: RADVL001
OBJETIVO : ROTINA AUTOMATICA PARA TRANSFERENCIAS
AUTOR    : FABRICA DE SOFTWARE ADVPL  (advpl@advpl.com.br)
PROJETO  : ALPAX
DATA     : 11.10.2009

-------------------------------------------------------------------------- 
PARAMETROS
01) VETOR COM CONTEUDO DOS CAMPOS A SEREM UTILIZADOS
02) OPCAO DA ROTINA

-------------------------------------------------------------------------- 
RETORNO
.T. PARA PROCESSAMENTO CONFIRMADO
.F. PARA FALHA NO PROCESSAMENTO

--------------------------------------------------------------------------
11.11.09 : IMPLEMENTADO CODIGO PADRAO
13.11.09 : TESTE EM AMBIENTE IMILAR A PRODUCAO

*/

USER FUNCTION RADVL001(aParam,lInclui)

Local aDados      := {}
Local lOper       := IIF(lInclui,.F.,.T.)   // OPERACAO, INCLUSÃO/ESTORNO
Local _lRet       := .T.                    // RETORNO

Local cCodOrig  := aParam[1] //Codigo do Produto Origem - Obrigatorio
Local cLocOrig  := aParam[2] //Almox Origem             - Obrigatorio
Local nQuant260 := aParam[3] //Quantidade 1a UM         - Obrigatorio  
Local cDocto    := aParam[4] //Documento                - Obrigatorio
Local dEmis260  := dDatabase //Data                     - Obrigatorio
Local nQuant260D:= 0         //Quantidade 2a UM
Local cNumLote  := ""        //Sub-Lote                 - Obrigatorio se Rastro "S"
Local cLoteDigi := IIF(Empty(aParam[5]),"",aParam[5]) //Lote                     - Obrigatorio se usa Rastro
Local dDtValid  := IIF(Empty(aParam[6]),"",aParam[6]) //Validade                 - Obrigatorio se usa Rastro
Local cNumSerie := aParam[7]                           //Numero de Serie
Local cLoclzOrig:= aParam[8]  //localização Origem
Local cCodDest  := aParam[9]  //Codigo do Produto Destino- Obrigatorio 
Local cLocDest  := aParam[10]  //Almox Destino            - Obrigatorio
Local cLocLzDest:= aParam[11]  //Localização Destino
Local lEstorno  := lOper   //Indica se movimento e estorno
Local nRecOrig  := 0   //Numero do registro original (utilizado estorno)
Local nRecDest  := 0   //Numero do registro destino (utilizado estorno)
Local cPrograma := "RADVL001" //Indicacao do programa que originou os lancamentos
Local cEstFis   := "" //Estrutura Fisica
Local cServico  := "" //Servico
Local cTarefa   := "" //Tarefa 
Local cAtividade:= "" //Atividade 
Local cAnomalia := "N" //Houve Anomalia? (S/N) 
Local cEstDest  := "" //Estrututa Fisica Destino 
Local cEndDest  := aParam[12] //Endereco Destino
Local cHrInicio := "" //Hora Inicio
Local cAtuEst   := "S" //Atualiza Estoque? (S/N)
Local cCarga    := "" //Numero da Carga
Local cUnitiza  := "" //Numero do Unitizador
Local cOrdTar   := "" //Ordem da Tarefa
Local cOrdAti   := "" //Ordem da Atividade 
Local cRHumano  := "" //Recurso Humano 
Local cRFisico  := "" //Recurso Fisico
Local nPotencia := aParam[3] //Potencia do Lote 
Local cLoteDest := IIF(Empty(aParam[13]),"",aParam[13]) //Lote Destino da Transferencia 

Private lMsErroAuto  := .f.             // FLAG EXECAUTO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a variavel que identifica se o calculo do custo e' :    ³
//³               O = On-Line                                    ³
//³               M = Mensal                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE cCusMed  := GetMv("MV_CUSMED")
PRIVATE cCadastro:= "Transferˆncias"	//"Transferˆncias"
PRIVATE aRegSD3  := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se o custo medio e' calculado On-Line               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If cCusMed == "O"
	PRIVATE nHdlPrv // Endereco do arquivo de contra prova dos lanctos cont.
	PRIVATE lCriaHeader := .T. // Para criar o header do arquivo Contra Prova
	PRIVATE cLoteEst 	// Numero do lote para lancamentos do estoque
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona numero do Lote para Lancamentos do Faturamento     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SX5")
	dbSeek(xFilial()+"09EST")
	cLoteEst:=IIF(Found(),Trim(X5Descri()),"EST ")
	PRIVATE nTotal := 0 	// Total dos lancamentos contabeis
	PRIVATE cArquivo	// Nome do arquivo contra prova
EndIf

Begin Transaction

a260Processa(cCodOrig,cLocOrig,nQuant260,cDocto,dEmis260,nQuant260D,cNumLote,cLoteDigi,dDtValid,cNumSerie,cLoclzOrig,cCodDest,cLocDest,cLocLzDest,lEstorno,nRecOrig,nRecDest,cPrograma,cEstFis,cServico,cTarefa,cAtividade,cAnomalia,cEstDest,cEndDest,cHrInicio,cAtuEst,cCarga,cUnitiza,cOrdTar,cOrdAti,cRHumano,cRFisico,nPotencia,cLoteDest)

If lMsErroAuto
    DisarmTransaction()
    Mostraerro()
	_lRet := .F.
	Return(_lRet)
else
	_lRet := .T.
EndIf

End Transaction

Return(_lRet)