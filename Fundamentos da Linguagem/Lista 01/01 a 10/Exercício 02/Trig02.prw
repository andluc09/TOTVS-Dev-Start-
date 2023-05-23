#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Trig02
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 02
    @type  Function
    @author Andr� Lucas M. Santos
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

    cBase := FwInputBox('Digite o tamanho da base do ret�ngulo em cent�metros', cBase)

    if !NEGATIVO(VAL(cBase)) 
        while !IsDigit(cBase)
            FwAlertError('Voc� n�o colocou um n�mero' , 'Error')
            cBase := FwInputBox('Digite o tamanho da base do ret�ngulo em cent�metros', cBase)
        enddo
    endif

    cAltura := FwInputBox('Digite o tamanho da altura do ret�ngulo em cent�metros', cAltura)

    if !NEGATIVO(VAL(cAltura))
        while !IsDigit(cAltura)
            FwAlertError('Voc� n�o colocou um n�mero' , 'Error')
            cAltura := FwInputBox('Digite o tamanho da altura do ret�ngulo em cent�metros', cAltura)
        enddo
    endif

    nArea := (Val(cBase) * Val(cAltura))/2

    FwAlertSuccess('A �rea do ret�ngulo �: ' + cValToChar(nArea) + 'cm�' , '�rea ret�ngulo')

Return
