#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function FotWin12
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 12
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function FotWin12()

    Local cTime1 := ''
    Local cTime2 := ''
    Local cP1    := ''
    Local cP2    := ''

    cTime1 := FwInputBox('Digite aqui o nome do primeiro time:', cTime1)
    cP1 := FwInputBox('Digite aqui os pontos do primeiro time:', cP1)

    cTime2 := FwInputBox('Digite aqui o nome do segundo time:', cTime2)
    cP2 := FwInputBox('Digite aqui os pontos do segundo time:', cP2)

    If cP1 > cP2
        FwAlertInfo('O time ' + cTime1 + ' venceu!') 
    elseif cP1 < cP2
        FwAlertInfo('O time ' + cTime2 + ' venceu!') 
    Else
        FwAlertInfo('Houve EMPATE!') 
    Endif
Return
