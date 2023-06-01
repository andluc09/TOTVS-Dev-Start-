#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Fatori36
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 36
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Fatori36()

    Local nNum    := 0
    Local nI      := 0
    Local nResult := 0

//*Colocar valida��o isDigit sem NEGATIVO, depois

    nNum := Val(FwInputBox('Digite aqui um n�mero para saber seu fatorial: ')) 

    nResult := VAL(StrTran(cValToChar(nNum), ',', '.'))

    for nI := nNUm to 2 step -1
        nResult := nResult * (nI-1)
    next

    if nNum == 0
        FwAlertSuccess('O resultado de ' + StrTran(cValToChar(nNum), '.', ',') + '! �: 1', 'FATORIAL')
    else 
        FwAlertSuccess('O resultado de ' + StrTran(cValToChar(nNum), '.', ',') + '! �: ' + StrTran(cValToChar(nResult), '.', ','), 'FATORIAL')
    endif

Return
