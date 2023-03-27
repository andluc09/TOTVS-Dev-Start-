#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Array10Par
    Lista Array - Exercício 04
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function Array10Par()

    Local aArray := Array(10)
    Local nNum   := 0
    Local nCont  := 0
    Local cTexto := ""

    for nCont := 1 to 10
        nNum += 2
        aArray[nCont] := nNum
        cTexto += CValToChar(aArray[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTexto, 'Vetor Par')

Return 
