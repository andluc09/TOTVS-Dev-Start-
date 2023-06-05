#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Cresct10
    Lista 02 - Fundamentos da Linguagem ADVPL | Exerc�cio 10
    @type  Function
    @author Andr� Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Cresct10()

    Local aVal := {0,0,0,0,0}
    Local nMenor := 0
    Local nMaior := 0
    Local nI     := 0

//*Colocar valida��o num�rica, depois

    for nI := 1 to 5
        aVal[nI] := val(FwInputBox('Digite o ' + alltrim(str(nI)) + '� valor:', 'Entrada de Dados'))
    Next

    ASORT(aVal)

    nMenor := aVal[1]
    nMaior := aVal[5]

    FwAlertSuccess('O menor valor �: ' + alltrim(str(nMenor)) + CRLF + ;
    'O maior valor �: ' + alltrim(str(nMaior)), 'Maior e menor')

Return
