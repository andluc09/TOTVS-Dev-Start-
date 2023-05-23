#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Produt13
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 13
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Produt13()

    Local cNome  := ''
    Local cValor := ''
    Local cQuant := ''
    Local nTotal := 0

    cNome  := FwInputBox('Insira o nome do produto adquirido:', cNome)
    cValor := FwInputBox('Insira o valor unitário do produto:', cValor)
    cQuant := FwInputBox('Insira a quantidade deste produto adquirido:', cQuant)

Return
