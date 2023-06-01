#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MedVal26
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 26
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function MedVal26()

	Local nSoma  := 0
	Local nQuant := 0
    Local nI     := 0

	for nI := 15 to 100
		nSoma += nI
		nQuant++
	next

	nMedia := nSoma / nQuant

	FwAlertSuccess('A média aritmética dos números entre 15 e 100 é: ' + StrTran(cValToChar(nMedia), '.', ','), 'MÉDIA ARITMÉTICA')

Return
