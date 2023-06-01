#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function IdaDig35
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 35
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function IdaDig35()

    Local nIdade := -1
    Local nMedia := 0
    Local nSoma  := 0
    Local nI     := 0

//*Colocar validação isDigit sem NEGATIVO, depois

    while nIdade <> 0
        nIdade := VAL(FwInputBox('Digite a idade da pessoa ou 0 para finalizar: ', 'IDADES')) 
        
        if nIdade <> 0
            nSoma += nIdade
            nI++
        endif
    enddo

    nMedia := nSoma / nI

    FwAlertSuccess('A média da idade das pessoas é: ' + StrTran(cValToChar(nMedia), '.', ',') + ' anos.', 'MÉDIA')

Return
