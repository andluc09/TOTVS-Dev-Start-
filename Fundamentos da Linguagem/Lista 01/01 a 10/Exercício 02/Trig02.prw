#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Trig02
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 02
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Trig02()

    local cBase     := ''
    local cAltura   := ''
    local nArea     := 0

    cBase := FwInputBox('Digite o tamanho da base do retângulo em centímetros', cBase)

    if !NEGATIVO(VAL(cBase)) 
        while !IsDigit(cBase)
            FwAlertError('Você não colocou um número' , 'Error')
            cBase := FwInputBox('Digite o tamanho da base do retângulo em centímetros', cBase)
        enddo
    endif

    cAltura := FwInputBox('Digite o tamanho da altura do retângulo em centímetros', cAltura)

    if !NEGATIVO(VAL(cAltura))
        while !IsDigit(cAltura)
            FwAlertError('Você não colocou um número' , 'Error')
            cAltura := FwInputBox('Digite o tamanho da altura do retângulo em centímetros', cAltura)
        enddo
    endif

    nArea := (Val(cBase) * Val(cAltura))/2

    FwAlertSuccess('A área do retângulo é: ' + cValToChar(nArea) + 'cm²' , 'Área retângulo')

Return
