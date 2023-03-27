#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function SomaArrays
    Lista Array - Exercício 05
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function SomaArrays()

    Local aArrayA[20]
    Local aArrayB[20]
    Local aArrayC[20]
    Local nNum      := 0
    Local cTexto    := ""

    cTexto := "A   +  B  =  C" + CRLF + CRLF

    for nNum := 1 to 20
        aArrayA[nNum] := Randomize(1,100)
        aArrayB[nNum] := Randomize(1,100)
        aArrayC[nNum] := aArrayA[nNum] + aArrayB[nNum]
        cTexto += CValToChar(aArrayA[nNum])  + " + " + CValToChar(aArrayB[nNum]) + " = " +CValToChar(aArrayC[nNum]) + CRLF + CRLF
    next nNum

    FWAlertInfo(cTexto,'Vetor C - RESULTANTE')

Return 
