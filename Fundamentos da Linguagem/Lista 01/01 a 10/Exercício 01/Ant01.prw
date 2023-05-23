#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Ant01
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 01
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Ant01()

    Local cNum := ''
    Local cAux := ''
    Local nNum := 0

    cNum := FwInputBox('Insira um número para saber o seu antecessor?', cNum)

    cAux := cNum  

    if NEGATIVO(VAL(cNum)) .AND. !IsAlpha(cNum)
        cNum := cValToChar((VAL(cNum) * -1))
    endif

    while !IsDigit(cNum)
        FwAlertError('Dígito inválido!' , 'ERRO')
        cNum := FwInputBox('Insira um número para saber o seu antecessor?', cNum)
    enddo

    nNum := (VAL(cAux) - 1)
    FwAlertSuccess('O antecessor ao ' + cNum + ' é: ' + cValToChar(nNum) , 'Antecessor')

Return
