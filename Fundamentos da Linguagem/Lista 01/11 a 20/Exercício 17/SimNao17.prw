#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function SimNao17
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 17
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function SimNao17()

    Local nAva1    := 0
    Local nAva2    := 0
    Local nMedia   := 0
    Local cChoice  := "S"

//*Colocar valida��o isDigit sem NEGATIVO, depois

    while UPPER(cChoice) == 'S'
    
        nAva1 := FwInputBox('Digite a nota da primeira avalia��o: ')
            nAva1 := val(nAva1)

        while (nAva1 < 0) .OR. (nAva1 > 10)
            FwAlertError('NOTA INV�LIDA!!', 'ERRO')
            nAva1 := FwInputBox('Digite a nota da primeira avalia��o: ')
                nAva1 := val(nAva1)

        enddo 

        nAva2 := FwInputBox('Digite a nota da segunda avalia��o: ')
            nAva2 := val(nAva2)

        while (nAva2 < 0) .OR. (nAva2 > 10)
            FwAlertError('NOTA INV�LIDA!!', 'ERRO')
            nAva2 := FwInputBox('Digite a nota da segunda avalia��o: ')
                nAva2 := val(nAva2)
        enddo 

        nMedia := (nAva1 + nAva2) / 2

        FwAlertInfo('A m�dia das avalia��es �: ' + StrTran(cValToChar(nMedia),'.',','), 'VALOR M�DIA')

        cChoice := FwInputBox('NOVO C�LCULO (S/N)? ' , cChoice)

    enddo 

    FwAlertSuccess('M�dias calculadas com sucesso! ', 'CONCLU�DO')

Return
