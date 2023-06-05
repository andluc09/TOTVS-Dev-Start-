#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MulTre12
    Lista 02 - Fundamentos da Linguagem ADVPL | Exerc�cio 12
    @type  Function
    @author Andr� Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function MulTre12()

    Local nI      := 1
    Local cExibe  := ''

    for nI := 1 to 100
        if (nI % 3) == 0 //* Se o resultado da divis�o do n�mero de 1 at� 100 por 3 for 0, ele � divisivel por 3
            cExibe := cExibe + cValToChar(nI) + CRLF
        endif
    next

    FwAlertSuccess('Os n�meros entre 1 e 100 divis�veis por 3 s�o: ' + CRLF + CRLF + cExibe, )

Return
