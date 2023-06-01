#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function IdaPes34
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 34
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function IdaPes34()

    Local nIdade     := 0
    Local nSomaIdade := 0
    Local nPeso      := 0
    Local nPeso90    := 0
    Local nMedia     := 0
    Local nI         := 0

//*Colocar validação isDigit sem NEGATIVO, depois

    for nI := 1 to 7
        nIdade := Val(FwInputBox('Digite aqui a idade da ' + AllTrim(STR(nI)) + 'ª pessoa: '))
        nSomaIdade += nIdade

        nPeso := Val(FwInputBox('Digite aqui o peso da  ' + AllTrim(STR(nI)) + 'ª pessoa: '))

        If nPeso > 90
            nPeso90++
        Endif
    next

    nMedia := nSomaIdade / 7

    FwAlertSuccess('A média da idade das pessoas é: ' + StrTran(cValToChar(nMedia), '.', ',') + CRLF + CRLF +;
                    'Pessoas com mais de 90 quilos: ' + StrTran(cValToChar(nPeso90), '.', ','), 'RESULTADO')

Return
