#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function A_InvtUnic
    Lista Array - Exercício 08
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function A_InvtUnic()

    Local aArray[8]
    Local nCont   := 0
    Local cTextoOrig := ""
    Local cTexto  := ""

    for nCont := 1 to LEN(aArray)
        aArray[nCont] := Randomize(1, 100)
        cTextoOrig += CValToChar(aArray[nCont]) + CRLF + CRLF
    next nCont

    for nCont := 1 to 4
        nNum := aArray[9 - nCont]
        aArray[9 - nCont] := aArray[nCont]
        aArray[nCont] := nNum
        cTexto += CValToChar(aArray[nCont]) + CRLF + CRLF
    next nCont

    for nCont := 1 to 4
        nNum := aArray[4 + nCont]
        aArray[4 + nCont] := aArray[nCont]
        aArray[nCont] := nNum
        cTexto += CValToChar(aArray[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTextoOrig, 'Vetor Original: único Array') 

    FWAlertInfo(cTexto, 'Vetor Invertido: único Array') 

Return 
