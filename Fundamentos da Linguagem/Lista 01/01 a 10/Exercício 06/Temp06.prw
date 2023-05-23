#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Temp06
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 06
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Temp06()

    Local cFahrenh := ''
    Local nCelsius := ''

    cFahrenh := FwInputBox('Digite a temperatura em Fahrenheit que ser� convetida em: ', cFahrenh + " Celsius ")

//*Colocar valida��o num�rica, depois

    //While !EHNUMERO(cFahrenh)
        FwAlertError('Voc� n�o colocou uma temperatura v�lida' , 'Error')
        cFahrenh := FwInputBox('Digite a temperatura em Fahrenheit ser� convetida em: ', cFahrenh + " Celsius ")
    //enddo

    nCelsius := (Val(cFahrenh) -32) * (5/9)

    FwAlertSuccess('A temperatura em Celsius �: ' + StrTran(cValToChar(nCelsius),".",",") + " �C")

Return
