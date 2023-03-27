#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function APosNeg
    Lista Array - Exercício 12
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function APosNeg()

    Local aArrayA[5]
    Local aArrayB[5]
    Local nCont     := 0
    Local cTexto    := ""

    cTexto += " A • (B invertido) " + CRLF + CRLF

    for nCont := 1 to LEN(aArrayA)
        aArrayA[nCont] := Randomize(-100, 100)
        aArrayB[nCont] := aArrayA[nCont] * (-1)
        cTexto += CValToChar(aArrayA[nCont]) + " • " + Space(1) + CValToChar(aArrayB[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTexto, 'Vetor: inverte Positivo x Negativo')

Return 
