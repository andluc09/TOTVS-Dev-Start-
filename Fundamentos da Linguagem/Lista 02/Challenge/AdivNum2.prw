#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function AdivNum2
    Lista 02 - Fundamentos da Linguagem ADVPL | Exerc�cio 17
    @type  Function
    @author Andr� Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function AdivNum2()

    Local nSort   := 0
    Local nChute  := 0
    Local lLoop   := .T.
    Local lOpcao  := 0
    Local nCont   := 0

    FwAlertInfo('Vamos jogar um jogo de adivinha��o?', 'HORA DO JOGO')

    //? O n�mero � sorteado aleatoriamente
    nSort := RANDOMIZE(0, 100)

    //? O usu�rio coloca seu chute para tentar acertar o n�mero
    nChute := VAL(FwInputBox('Coloque aqui um n�mero para ser seu chute: ', '0000'))

    while lLoop 
        if nSort > nChute
            FWAlertInfo('O n�mero sorteado � maior que seu chute :)', 'MAIOR')

        elseif nSort < nChute
            FWAlertInfo('O n�mero sorteado � menor que seu chute :)', 'MENOR')

        else
            FwAlertSuccess('Parab�ns, voc� acertou o n�mero sorteado!', 'PARAB�NS')
            Exit
        endif

        //? Ap�s cada erro o usu�rio pode escolher se deseja continuar jogando ou n�o
        lOpcao := FWAlertYesNo('Deseja tentar novamente?', 'N�o foi dessa vez')

        //? Caso o usu�rio decida n�o continuar jogando, um alerta ser� disparado informando o n�mero sorteado
        if lOpcao == .F.
            nCont := 0
            FwAlertInfo('� uma pena que voc� tenha desistido!' + CRLF + CRLF +;
            'O n�mero sorteado era: ' + cValToChar(nSort), 'QUE PENA..')
            Exit
        endif

        nChute := VAL(FwInputBox('Coloque aqui um n�mero para ser seu chute: ', '0000'))
        
        nCont++
    enddo

    if nCont <> 0 .AND. nCont < 5
        FwAlertSuccess('Voc� � muito bom, acertou em ' + cValToChar(nCont) + ' tentativa (as).', 'CLASSIFICA��O')
    elseif nCont <> 0 .AND. nCont < 9
        FwAlertSuccess('Voc� � bom, acertou em ' + cValToChar(nCont) + ' tentativas.', 'CLASSIFICA��O')
    elseif nCont <> 0 .AND. nCont < 13
        FwAlertSuccess('Voc� � mediano, acertou em ' + cValToChar(nCont) + ' tentativas.', 'CLASSIFICA��O')
    elseif nCont > 13 
        FwAlertSuccess('Voc� � fraco, acertou em' + cValToChar(nCont) + ' tentativas.', 'CLASSIFICA��O')
    endif

Return
