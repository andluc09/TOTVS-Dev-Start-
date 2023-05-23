#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Salar04
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 04
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Salar04()

    Local cSalario  := ''
    Local cReajuste := ''
    Local nSalFinal := ''

    cSalario := FwInputBox('Digite aqui o salário mensal atual do funcionário:', cSalario)

    while NEGATIVO(VAL(cSalario))
        if !NEGATIVO(VAL(cSalario))
            while !IsDigit(cSalario)
                FwAlertError('Você não colocou um número!' , 'Error')
                cSalario := FwInputBox('Digite aqui o salário mensal atual do funcionário:', cSalario)
            enddo
        endif            
        FwAlertError('Você não colocou um número positivo!' , 'Error')
        cSalario := FwInputBox('Digite aqui o salário mensal atual do funcionário:', cSalario)
    enddo

    cReajuste := FwInputBox('Digite aqui o percentual de reajuste do salário:', cReajuste)

    while NEGATIVO(VAL(cReajuste))
        if !NEGATIVO(VAL(cReajuste))
            while !IsDigit(cReajuste)
                FwAlertError('Você não colocou um número!' , 'Error')
                cReajuste := FwInputBox('Digite aqui o percentual de reajuste do salário:', cReajuste)
            enddo
        endif
        FwAlertError('Você não colocou um número positivo!' , 'Error')
        cReajuste := FwInputBox('Digite aqui o percentual de reajuste do salário:', cReajuste)
    enddo

    nSalFinal := VAL(cSalario) + (VAL(cSalario)*(VAL(cReajuste)/100.00))

    FwAlertSuccess('O novo salário do funcionário é: R$ ' + StrTran(cVALToChar(nSalFinal),".",",") + '!')

Return 
