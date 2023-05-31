#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MedAlu16
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 16
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function MedAlu16()

    Local nAva1    := 0
    Local nAva2    := 0
    Local nMedia   := 0

    nAva1 := FwInputBox('Digite a nota da primeira avaliação: ')
        nAva1 := val(nAva1)

    while (nAva1 < 0) .OR. (nAva1 > 10)
        FwAlertError('NOTA INVÁLIDA!!', 'ERRO')
        nAva1 := FwInputBox('Digite a nota da primeira avaliação: ')
            nAva1 := val(nAva1)

    enddo 

    nAva2 := FwInputBox('Digite a nota da segunda avaliação: ')
        nAva2 := val(nAva2)

    while (nAva2 < 0) .OR. (nAva2 > 10)
        FwAlertError('NOTA INVÁLIDA!!', 'ERRO')
        nAva2 := FwInputBox('Digite a nota da segunda avaliação: ')
            nAva2 := val(nAva2)
    enddo 

    nMedia := (nAva1 + nAva2) / 2

    FwAlertInfo('A média das avaliações é: ' + StrTran(cValToChar(nMedia),'.',','), 'VALOR MÉDIA')

Return
