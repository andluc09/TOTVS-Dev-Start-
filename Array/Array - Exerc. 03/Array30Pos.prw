#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Array30Pos
    Lista Array - Exercício 03
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function Array30Pos()

    Local aArray[30]
    Local aCheca[30]
    Local nCont     := 0
    Local cTexto    := ""
    Local cTextoA   := ""
    Local cTextoA1   := ""

    for nCont := 1 to 30 
        aArray[nCont] := Randomize(1,30) //* Gera números aleatórios dentro de um intervalo, contudo se repetem!
        if(nCont <> 30)
            cTextoA += CValToChar(aArray[nCont]) + ', '
        else
            cTextoA += CValToChar(aArray[nCont]) + '. '
        endif
    next nCont

    FWAlertInfo(cTextoA, "<b> Vetor Resultado: </b>")

    for nCont := 1 to LEN(aArray)
        if((ASCAN(aArray, aCheca[nCont] := Randomize(1,100))) == 0) //* Gera números aleatórios dentro de um intervalo que não se repetem!
            aArray[nCont] := aCheca[nCont]
            cTexto += CValToChar(nCont) + "º :" + Space(1) + CValToChar(aArray[nCont]) + CRLF + CRLF
            if(nCont <> 30)
                cTextoA1 += CValToChar(aArray[nCont]) + ', '
            else
                cTextoA1 += CValToChar(aArray[nCont]) + '. '
            endif
        else
            nCont--
        endif

    next nCont

    FWAlertInfo(cTextoA1, "<b> Vetor Resultado: </b>")

    AVISO("<b> Vetor Resultado: </b>", cTexto, {"OK"}, 3, NIL)

Return 
