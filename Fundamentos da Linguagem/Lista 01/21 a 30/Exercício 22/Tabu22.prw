#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Tabu22
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 22
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Tabu22()

	Local cValor  := ''
    Local nI      := 0
    Local cResult := ''

//* Tratamento numérico

	cValor := FwInputBox('Digite um valor inteiro entre 1 e 10:')
    cValor := VAL(cValor)

	while cValor < 1 .OR. cValor > 10
		cValor := FwInputBox('Valor inválido. Digite um valor inteiro entre 1 e 10:')
        cValor := VAL(cValor)
	enddo

	for nI := 1 to 10
		cResult += Alltrim(STR(cValor)) + ' x ' + Alltrim(STR(nI)) + ' = ' + Alltrim(STR(cValor * nI)) + CRLF + CRLF
	next

	FwAlertSuccess(cResult, 'Tabuada do: ' + cValToChar(cValor))

Return
