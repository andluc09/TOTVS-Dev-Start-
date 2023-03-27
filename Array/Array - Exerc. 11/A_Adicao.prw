#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function A_Adicao
    Lista Array - Exercício 11
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function A_Adicao()

    Local aArrayA[10]
    Local aArrayB   := {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    Local nCont     := 0
    Local nNum      := 0
    Local cTexto1   := ""
    Local cTexto2   := ""

    for nCont := 1 to LEN(aArrayA)
        aArrayA[nCont] := Randomize(1, 100)
        cTexto1 += CValToChar(aArrayA[nCont]) + CRLF + CRLF
    next nCont

    for nCont := 1 to LEN(aArrayB)
        for nNum := 1 to nCont
            aArrayB[nCont] := aArrayB[nCont] + aArrayA[nNum]
        next nNum
        cTexto2 += CValToChar(aArrayB[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTexto1, 'Vetor Aditivo: anterior')

    FWAlertInfo(cTexto2, 'Vetor Aditivo: anterior + valor atual')

Return 
