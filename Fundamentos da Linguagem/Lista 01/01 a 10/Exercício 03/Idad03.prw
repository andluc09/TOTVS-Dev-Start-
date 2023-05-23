#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Idad03
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 03
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Idad03()

    Local cAnos  := ''
    Local cMeses := ''
    Local cDias  := ''
    Local nIdade := 0

    cAnos := FwInputBox('Digite aqui há quantos anos você nasceu:', cAnos)

    if !NEGATIVO(VAL(cAnos))
        while !IsDigit(cAnos)
            FwAlertError('Você não colocou um número' , 'Error')
            cAnos := FwInputBox('Digite aqui há quantos anos você nasceu:', cAnos)
        enddo
    end

    cMeses := FwInputBox('Digite aqui quantos meses fazem desde seu aniversário:', cMeses)

    if !NEGATIVO(VAL(cMeses))
        while !IsDigit(cMeses)
            FwAlertError('Você não colocou um número' , 'Error')
            cMeses := FwInputBox('Digite aqui quantos meses fazem desde seu aniversário:', cMeses)
        enddo
    end

    cDias := FwInputBox('Digite aqui quantos dias fazem desde o seu mesversário:', cDias)

    if !NEGATIVO(VAL(cDias))
        while !IsDigit(cDias)
            FwAlertError('Você não colocou um número' , 'Error')
            cDias := FwInputBox('Digite aqui quantos dias fazem desde o seu mesversário:', cDias)
        enddo
    end

    nIdade := ((VAL(cAnos) * 365)+(VAL(cMeses)*30)+VAL(cDias))

    FwAlertSuccess('Fazem ' + CVALTOCHAR(nIdade) + ' dias desde que você nasceu.')

Return
