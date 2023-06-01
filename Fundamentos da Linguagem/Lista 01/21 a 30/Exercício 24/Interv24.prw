#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Interv24
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 24
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Interv24()

	Local cValor  := 0
	Local nDentro := 0
	Local nFora   := 0
    Local cDentro := ''
    Local cFora   := ''
    Local nI      := 0

	for nI := 1 to 10
		cValor := Val(FwInputBox('Digite o ' + cValToChar(nI) + 'º valor: '))
		if cValor >= 10 .and. cValor <= 20
			nDentro++
            cDentro += Alltrim(STR(cValor)) + ','            
		else
			nFora++
            cFora += Alltrim(STR(cValor)) + ','
		endIf
	next

	FwAlertSuccess(cValToChar(nDentro) + ' valores estão dentro do intervalo [10, 20]. ' + CRLF + CRLF + cValToChar(nFora) + ' valores estão fora do intervalo.', 'QUANTIDADE')
    FwAlertSuccess('Os valores que estão dentro do intervalo [10, 20] são: ' + SUBSTR(cDentro, 1, LEN(cDentro)-1) + '.' + CRLF + CRLF + 'E os que estão fora do intervalo são: ' + SUBSTR(cFora, 1, LEN(cFora)-1) + '.', 'NÚMEROS CONTIDOS')

Return
