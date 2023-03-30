#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Array_5
    Lista BD - Exercício 14
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function Array_5()

    Local aArray[5]
    Local aCinco   := {5, 8, 9, 2, 7}
    Local aRandom[5]
    Local nCont    := 0
    Local cTexto   := ""
    Local cTextoA  := ""
    Local cTextoB  := ""

    for nCont := 1 to LEN(aArray)
        aArray[nCont] := VAL(cNum := FWInputBox("Insira um número: ", "00"))
        cTexto += CValToChar(aArray[nCont]) + CRLF + CRLF 
    next nCont

    FWAlertInfo(cTexto, 'Array: ')

    for nCont := 1 to LEN(aCinco)
        cTextoA += CValToChar(aCinco[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTextoA, 'Array: ')

    for nCont := 1 to LEN(aRandom)
        aRandom[nCont] := Randomize(0,100)
        cTextoB += CValToChar(aRandom[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTextoB, 'Array: ')    

Return
