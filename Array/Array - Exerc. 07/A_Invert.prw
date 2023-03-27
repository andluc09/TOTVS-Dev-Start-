#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function A_Invert
    Lista Array - Exercício 07
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function A_Invert()

    Local aArrayA[15]
    Local aArrayB[15]
    Local nNum   := 0
    Local nCont  := 0
    Local cTexto := ""

    cTexto := " A • B " + CRLF + CRLF

    for nNum := 1 to 15
        aArrayA[nNum] := Randomize(1,100)
    next nNum

    for nCont := 1 to 15
        aArrayB[nCont] := aArrayA[16-nCont]
        cTexto += CValToChar(aArrayA[nCont]) + " • " + CValToChar(aArrayB[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTexto, 'Vetor Invertido:')

Return 
