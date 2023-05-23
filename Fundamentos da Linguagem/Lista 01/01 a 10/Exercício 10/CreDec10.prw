#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CreDec10
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 10
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function CreDec10()

    Local cVal    := ''
    Local aVal    := {}
    Local nNum      := 0
    Local cResult := ''


//*Colocar validação isDigit sem NEGATIVO, depois

    for nNum := 1 to 3
        cVal := FwInputBox('Insira um número: ', cVal)
        AADD(aVal,VAL(cVal))
    next

    ASORT(aVal) //? Ordena os números

    for nNum := 1 to LEN(aVal)
        if nNum < LEN(aVal)
            cResult += AllTrim(STR(aVal[nNum])) + ', '
        elseif nNum = 3
            cResult += AllTrim(STR(aVal[nNum])) + '.'
        endif    
    next nNum

    FwAlertInfo('Os números em ordem crescente são: ' + cResult)

Return
