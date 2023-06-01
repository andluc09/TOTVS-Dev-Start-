#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Repet27
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 27
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Repet27()

    Local nI      := 1
    Local nJ      := 1
    Local cResult := ''
    Local cLinha  := ''

    for nI := 1 to 10
        cLinha := ''
        cLinha += alltrim(Str(nI)) + ', '
        for nJ := 1 to 10
            if nJ < 10
                cLinha += alltrim(Str(nJ)) + ' '
            else
                cLinha += alltrim(Str(nJ)) + '. '   
            endif    
        next
        cResult += cLinha + CRLF  
    next        

    FwAlertInfo('Resultado:' + CRLF + CRLF + cResult, 'SEQUÊNCIA NUMÉRICA')

Return
