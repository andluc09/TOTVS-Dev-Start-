#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function DuoVal04
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 04
    @type  Function
    @author Andr� Lucas M. Santos
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

//*Colocar valida��o num�rica, depois

    nNum := FwInputBox('Insira aqui o primeiro n�mero inteiro:')

    while lLoop
        if !IsDigit(nNum)
            FwAlertError('Voc� n�o inseriu um n�mero inteiro. Por favor, Preste aten��o!')
            nNum := FwInputBox('Insira aqui o primeiro n�mero inteiro:')
        else
            aNums[1] := Val(nNum)
            lLoop := .F.
        endif
    enddo

    lLoop := .T.

    nNum := FwInputBox('Insira aqui o segundo n�mero inteiro:')

    while lLoop
        if !IsDigit(nNum)
            FwAlertError('Voc� n�o inseriu um n�mero inteiro. Por favor, Preste aten��o!')
            nNum := FwInputBox('Insira aqui o segundo n�mero inteiro:')
        else
            aNums[2] := Val(nNum)
            lLoop := .F.
        endif
    enddo

        nMostraDif  := (aNums[1] - aNums[2])
        nMostraQuad := (nMostraDif)^2

    FwAlertSuccess('A diferen�a de ' + cValToChar(aNums[1]) + ' por ' + cValtoChar(aNums[2]) + ' �: ' + cValTochar(nMostraDif) + CRLF +;
    'e o quadrado desta diferen�a �: ' + cValToChar(nMostraQuad), "Resultado")

Return
