#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function A_Juntar
    Lista Array - Exercício 10
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

#DEFINE nNum 10

User Function A_Juntar()

    Local aArrayA[10]
    Local aArrayB[15]
    Local aArrayC[25]
    Local nCont   := 0
    Local cTextoA := ""
    Local cTextoB := ""
    Local cTextoC := ""

    for nCont := 1 to 10
        aArrayA[nCont] := Randomize(1,100)
        cTextoA += CValToChar(aArrayA[nCont]) + CRLF + CRLF
    next nCont

    for nCont := 1 to 15
        aArrayB[nCont] := Randomize(1,100)
        cTextoB += CValToChar(aArrayB[nCont]) + CRLF + CRLF
    next

    for nCont := 1 to 25
        if(nCont <= 10)
            aArrayC[nCont] := aArrayA[nCont]
        else
            aArrayC[nCont] := aArrayB[nCont-nNum]
        endif
        cTextoC += CValToChar(aArrayC[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTextoA, "Vetor A: ")

    FWAlertInfo(cTextoB, "Vetor B: ")

    AVISO("<b> Vetor C: </b>", cTextoC, {"OK"}, 3, NIL)

Return 
