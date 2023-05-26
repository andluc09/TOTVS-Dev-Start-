#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MesNum09
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 09
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function MesNum09()

    Local aMes      := {'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'}
    Local aDias     := {'31','28','31','30','31','30','31','31','30','31','30','31'}
    Local nDia      := 0
    Local cRespDia  := ''
    Local cRespMes  := ''

//*Colocar validação numérica, depois

    while nDia <= 0 .or. nDia > 12//Loop que obriga o usuário a colocar um mês válido;
        nDia := Val(FwInputBox('Digite um valor de 1 a 12, veja quantos dias tem o mês: ', 'Meses'))
    enddo

    // ?Strings portaram a posição dos arrays no mês escolhido pelo usuário.
    cRespDia := aDias[nDia]
    cRespMes := aMes[nDia]

    FwAlertSuccess('O mês de ' + cRespMes + ' tem ' + cRespDia + ' dias.', "Mês " + cValToChar(nDia))

Return
