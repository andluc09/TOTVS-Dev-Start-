#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function OrdCre18
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 18
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function OrdCre18()

	Local nNum := 1

	while nNum <= 10
		FwAlertInfo(cValToChar(nNum), 'Número da contagem ' + cValToChar(nNum) + 'º:')
		nNum++
	enddo

    FwAlertSuccess('Contagem finalizada!')

Return
