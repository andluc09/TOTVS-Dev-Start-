#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function AdivNum1
    Lista 02 - Fundamentos da Linguagem ADVPL | Exercício 17
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function AdivNum1()

    Local nSort   := 0
    Local nChute  := 0
    Local lLoop   := .T.
    Local lOpcao  := 0

    FwAlertInfo('Vamos jogar um jogo de adivinhação?', 'HORA DO JOGO')

    //? O número é sorteado aleatoriamente
    nSort := RANDOMIZE(0, 100)

    //? O usuário coloca seu chute para tentar acertar o número
    nChute := VAL(FwInputBox('Coloque aqui um número para ser seu chute: ', '0000'))

    while lLoop 
        if nSort > nChute
            FWAlertInfo('O número sorteado é maior que seu chute :)', 'MAIOR')

        elseif nSort < nChute
            FWAlertInfo('O número sorteado é menor que seu chute :)', 'MENOR')

        else
            FwAlertSuccess('Parabéns, você acertou o número sorteado!', 'PARABÉNS')
            Exit
        endif

        //? Após cada erro o usuário pode escolher se deseja continuar jogando ou não
        lOpcao := FWAlertYesNo('Deseja tentar novamente?', 'Não foi dessa vez')

        //? Caso o usuário decida não continuar jogando, um alerta será disparado informando o número sorteado
        if lOpcao == .F.
            FwAlertInfo('É uma pena que você tenha desistido!' + CRLF + CRLF +;
            'O número sorteado era: ' + cValToChar(nSort), 'QUE PENA..')
            Exit
        endif

        nChute := VAL(FwInputBox('Coloque aqui um número para ser seu chute: ', '0000'))
    enddo

Return
