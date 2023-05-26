#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function DivNum06
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 06
    @type  Function
    @author Andr� Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function DivNum06()

    Local aNums := {}
    Local nNum  := ''
    Local nI    := 1
    Local cNums := ''

//*Colocar valida��o num�rica, depois

    for nI := 1 to 4
        while !IsDigit(nNum)
            nNum := FWInputBox('Insira aqui o ' + cValToChar(nI) + '� n�mero inteiro:')
        enddo

        AADD(aNums, Val(nNum))
        nNum  := ''
    next

    for nI := 1 to 4
        If (aNums[nI] % 2 = 0) .AND. (aNums[nI] % 3 = 0)
                cNums += cValToChar(aNums[nI]) + CRLF
        Endif
    next

    if !Empty(cNums)
        FwAlertSuccess('Dos n�meros digitados, os que s�o divis�veis por 2 e 3 s�o: ' + CRLF + cNums, 'N�meros divis�veis')
    else
        FWAlertInfo('Nenhum n�mero � divis�vel por 2 e 3!')
    endif        

Return
