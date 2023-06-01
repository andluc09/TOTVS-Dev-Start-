#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ValNeg23
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 23
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function ValNeg23()

	Local cValor     := ''
	Local nNegativos := 0
    Local nI         := 0

//* Tratamento numérico, não tratar negativo

	for nI := 1 to 10
		cValor := FwInputBox('Digite o ' + cValToChar(nI) + 'º valor: ', cValor)
		if VAL(cValor) < 0
			nNegativos++
		endif
	next

	FwAlertSuccess('Foram digitados ' + cValToChar(nNegativos) + ' valores negativos.', 'RESULTADO')

Return
