#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Carr05
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 05
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Carr05()

    Local cCustoFab  := ''
    Local cCustFinal := ''

//*Colocar validação numérica, depois

    cCustoFab := FwInputBox('Insira aqui o custo de fábrica do carro:' , cCustoFab)

    cCustFinal := (Val(cCustoFab) + ((Val(cCustoFab)*0.28)) + (Val(cCustoFab) + ((Val(cCustoFab)*0.28)))*0.45)

    FwAlertSuccess('O custo final do carro é: R$ ' + StrTran(cValToChar(cCustFinal),".",","))

Return
