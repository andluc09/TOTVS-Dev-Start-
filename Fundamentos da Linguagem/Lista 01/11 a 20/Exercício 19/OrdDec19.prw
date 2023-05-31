#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function OrdDec19
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 19
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function OrdDec19()

	Local nNum  := 10
    Local nCont := 1

	while nNum >= 1
		FwAlertInfo(cValToChar(nNum), 'N�mero da contagem ' + cValToChar(nCont) + '�:')
		nNum--
        nCont++
	enddo

    FwAlertSuccess('Contagem finalizada!')

Return
