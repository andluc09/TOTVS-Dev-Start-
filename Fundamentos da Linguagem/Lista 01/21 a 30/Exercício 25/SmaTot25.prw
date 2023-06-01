#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function SmaTot25
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 25
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function SmaTot25()

	Local nSoma  := 0
    Local cValor := ''
    Local nI     := 0

//* Tratamento numérico

	for nI := 1 to 10
		cValor := VAL(FwInputBox('Digite o ' + cValToChar(nI) + 'º valor: '))
		nSoma += cValor
	next

	FwAlertSuccess('A soma dos 10 valores digitados é: ' + cValToChar(nSoma), 'SOMA DOS VALORES')

Return
