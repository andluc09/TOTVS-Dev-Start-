#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function M18Ida38
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 38
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function M18Ida38()

    Local nIdade := 0
    Local nMaior := 0
    Local nI     := 0

    for nI := 1 to 10
        nIdade := val(FwInputBox("Digite a idade da " + cvaltochar(nI) + "� pessoa."))

        if nIdade >= 18
            nMaior++
        endif
    next

    FwAlertSuccess('<b>' + cvaltochar(nMaior) + " pessoa (as)</b> s�o maiores de idade.", 'MAIOR DE IDADE')

Return 
