#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function PosNeg09
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 09
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function PosNeg09()

    Local cValor := ''

//*Colocar valida��o num�rica, depois

    cValor := FwInputBox('Insira um n�mero: ', cValor)

    If Val(cValor) > 0
        FwAlertInfo('O valor inserido � positivo!')
    Elseif Val(cValor) < 0
        FwAlertInfo('O valor inserido � negativo!')
    Else
        FwAlertInfo('O valor inserido � zero!')
    ENDIF

Return
