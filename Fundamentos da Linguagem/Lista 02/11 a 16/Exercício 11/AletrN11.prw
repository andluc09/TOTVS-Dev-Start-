#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function AletrN11
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 11
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function AletrN11()

    Local aEscolha := {'For', 'While'}

    //? O usuário poderá escolher com qual Loop
    aEscolha := Aviso('Escolha a função que o programa utilizará:', 'Faça sua escolha entre' + CRLF +'While' + CRLF + 'ou' + CRLF + 'For..', aEscolha, 1)

    If aEscolha == 1
        FunFor()
    Else
        FunWhile()
    Endif

Return 

Static Function FunFor()

    Local cNums := ''
    Local nI    := 1

    //? Estrutura de Loop de 1 a 50 utilizando For
    For nI := 1 to 50
        If nI < 50
            cNums += cValToChar(RANDOMIZE(10, 99)) + ', '
        Else 
            cNums += cValToChar(RANDOMIZE(10, 99)) + '.'
        Endif
    Next

    FwAlertSuccess('O números gerados foram: ' + CRLF + cNums, 'Laço For')
Return

Static Function FunWhile()
    Local cNums := ''
    Local nI    := 1

    //? Estrutura de Loop de 1 a 50 utilizando While
    While nI <= 50
        If nI < 50
            cNums += cValToChar(RANDOMIZE(10, 99)) + ', '
        Else 
            cNums += cValToChar(RANDOMIZE(10, 99)) + '.'
        Endif
        nI++
    End

    FwAlertSuccess('O números gerados foram: ' + CRLF + cNums, 'Laço While')

Return
