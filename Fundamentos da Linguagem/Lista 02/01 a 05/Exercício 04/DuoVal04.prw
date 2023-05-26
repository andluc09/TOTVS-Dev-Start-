#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function DuoVal04
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 04
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function DuoVal04()

    Local nMostraDif  := 0
    Local nMostraQuad := 0
    Local aNums       := {0, 0}
    Local nNum        := 0
    Local lLoop       := .T.

//*Colocar validação numérica, depois

    nNum := FwInputBox('Insira aqui o primeiro número inteiro:')

    while lLoop
        if !IsDigit(nNum)
            FwAlertError('Você não inseriu um número inteiro. Por favor, Preste atenção!')
            nNum := FwInputBox('Insira aqui o primeiro número inteiro:')
        else
            aNums[1] := Val(nNum)
            lLoop := .F.
        endif
    enddo

    lLoop := .T.

    nNum := FwInputBox('Insira aqui o segundo número inteiro:')

    while lLoop
        if !IsDigit(nNum)
            FwAlertError('Você não inseriu um número inteiro. Por favor, Preste atenção!')
            nNum := FwInputBox('Insira aqui o segundo número inteiro:')
        else
            aNums[2] := Val(nNum)
            lLoop := .F.
        endif
    enddo

        nMostraDif  := (aNums[1] - aNums[2])
        nMostraQuad := (nMostraDif)^2

    FwAlertSuccess('A diferença de ' + cValToChar(aNums[1]) + ' por ' + cValtoChar(aNums[2]) + ' é: ' + cValTochar(nMostraDif) + CRLF +;
    'e o quadrado desta diferença é: ' + cValToChar(nMostraQuad), "Resultado")

Return
