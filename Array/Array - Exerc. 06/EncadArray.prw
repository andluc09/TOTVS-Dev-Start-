#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function EncadArray
    Lista Array - Exercício 06
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function EncadArray()

    Local aArrayA[10]
    Local aArrayB[10]
    Local aArrayC[20]
    Local nNum      := 0
    Local cTexto    :=""

    cTexto += "A • B • (C)" + CRLF + CRLF

    for nNum := 1 to LEN(aArrayA)
        aArrayA[nNum] := Randomize(1,100)
        aArrayB[nNum] := Randomize(1,100)
        aArrayC[(nNum*2)-1] := aArrayA[nNum]
        cTexto += CValToChar(aArrayA[nNum]) + Space(1) + " __ " + Space(1) + "•" + Space(1)  + CValToChar(aArrayC[(nNum*2)-1]) + CRLF + CRLF
        aArrayC[nNum*2] := aArrayB[nNum]
        cTexto += Space(1) + " __ " + CValToChar(aArrayB[nNum]) + Space(1) + "•" + Space(1)  + CValToChar(aArrayC[nNum*2]) + CRLF + CRLF
    next nNum

    FWAlertInfo(cTexto, 'Vetor Encadeado: ')

Return 
