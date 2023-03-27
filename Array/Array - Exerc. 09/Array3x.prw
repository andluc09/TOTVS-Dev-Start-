#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Array3x
    Lista Array - Exercício 09
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function Array3x()

    Local aArrayA[8] 
    Local aArrayB[8]
    Local nCont   := 0
    Local cTexto  := ""

    cTexto += " A • (3x) B " + CRLF + CRLF

    for nCont := 1 to 8
        aArrayA[nCont] := Randomize(1,100)
        aArrayB[nCont] := aArrayA[nCont]*3
        cTexto += CValToChar(aArrayA[nCont]) + " • (3x) " + CValToChar(aArrayB[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTexto, 'Vetor: Triplicado')

Return 
