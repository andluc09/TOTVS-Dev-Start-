#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Macas07
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 07
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Macas07()

    Local cMaca  := ''
    Local nPreco := 0

    cMaca := FwInputBox('Quantas maçãs você comprou?' , cMaca)

//*Colocar validação numérica, depois

    if Val(cMaca) < 12
        nPreco := Val(cMaca) * 1.30
    else
        nPreco := Val(cMaca) * 1.00
    endif

    FwAlertInfo('O custo total da compra foi: R$' + StrTran(cValToChar(NoRound(nPreco,2)),".",","))

Return
