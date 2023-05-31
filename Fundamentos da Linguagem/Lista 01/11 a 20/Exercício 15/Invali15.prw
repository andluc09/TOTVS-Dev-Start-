#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Invali15
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 15
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Invali15()

    Local cNum   := ''
    Local nNum1  := 0
    Local nNum2  := 0
    Local nDiv   := 0
    Local lLoop  := .T.

//*Colocar validação isDigit sem NEGATIVO, depois

    cNum := FwInputBox('Digite o primeiro número: ', cNum)
    nNum1 := val(cNum)

    while lLoop
        cNum := FwInputBox("Digite o segundo número: ", cNum)

        if VAL(cNum) == 0
            FWAlertError('Não é possível dividir por zero!!', 'VALOR INVÁLIDO')
        else
            nNum2 := VAL(cNum)
            lLoop := .F.
        endif
    enddo

    nDiv := nNum1 / nNum2 

    FwAlertInfo(cvaltochar(nNum1) + " / " + cvaltochar(nNum2) + " = " + StrTran(cvaltochar(nDiv), '.', ','), "Divisão, resultado:")

Return 
