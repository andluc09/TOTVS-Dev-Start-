#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Salar04
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 04
    @type  Function
    @author Andr� Lucas M. Santos
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

    cSalario := FwInputBox('Digite aqui o sal�rio mensal atual do funcion�rio:', cSalario)

    while NEGATIVO(VAL(cSalario))
        if !NEGATIVO(VAL(cSalario))
            while !IsDigit(cSalario)
                FwAlertError('Voc� n�o colocou um n�mero!' , 'Error')
                cSalario := FwInputBox('Digite aqui o sal�rio mensal atual do funcion�rio:', cSalario)
            enddo
        endif            
        FwAlertError('Voc� n�o colocou um n�mero positivo!' , 'Error')
        cSalario := FwInputBox('Digite aqui o sal�rio mensal atual do funcion�rio:', cSalario)
    enddo

    cReajuste := FwInputBox('Digite aqui o percentual de reajuste do sal�rio:', cReajuste)

    while NEGATIVO(VAL(cReajuste))
        if !NEGATIVO(VAL(cReajuste))
            while !IsDigit(cReajuste)
                FwAlertError('Voc� n�o colocou um n�mero!' , 'Error')
                cReajuste := FwInputBox('Digite aqui o percentual de reajuste do sal�rio:', cReajuste)
            enddo
        endif
        FwAlertError('Voc� n�o colocou um n�mero positivo!' , 'Error')
        cReajuste := FwInputBox('Digite aqui o percentual de reajuste do sal�rio:', cReajuste)
    enddo

    nSalFinal := VAL(cSalario) + (VAL(cSalario)*(VAL(cReajuste)/100.00))

    FwAlertSuccess('O novo sal�rio do funcion�rio �: R$ ' + StrTran(cVALToChar(nSalFinal),".",",") + '!')

Return 
