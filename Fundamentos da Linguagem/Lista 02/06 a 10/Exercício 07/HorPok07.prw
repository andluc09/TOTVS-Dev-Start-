#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function HorPok07
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 07
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function HorPok07()

    Local nHoraI := 0
    Local nHoraF := 0
    Local Total  := 0

//*Colocar validação numérica, depois

    nHoraI := Val(FwInputBox('Digite a hora que comecou o jogo de poker. '))
    nHoraF := Val(FwInputBox('Digite a hora que acabou o jogo de poker. '))

    Total := nHoraI - nHoraF

    if nHoraI >= nHoraF
        Total := ( nHoraF - nHoraI ) + 24 //! Caso a hora inicial seja menor que a final, adicionamos +24 horas pois, entende-se que o jogo durou mais de um dia.
        FwAlertSuccess('O jogo levou ' + alltrim(Str(ABS(Total))) + ' horas.', 'Resultado')
    else
        Total := ( nHoraF - nHoraI )
        FwAlertSuccess('O jogo levou ' + alltrim(Str(Total)) + ' horas.', 'Resultado')
    endif

Return
