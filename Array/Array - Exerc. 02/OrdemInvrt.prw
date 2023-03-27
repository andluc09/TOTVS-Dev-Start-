#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function OrdemInvrt
    Lista Array - Exercício 02
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function OrdemInvrt()

    Local aVetor[10]
    Local cTexto    := ""
    Local cTextoA   := ""
    Local nCont     := 0
    Local nAux      := 0
    Local nFim      := 10

    for nCont := 1 to 10
        aVetor[nCont] := VAL(FWInputBox(CValToChar(nCont) + 'º número: ', 'Insira os valores que irão compor o vetor..'))
    next nCont

    ncont--

    while(nCont != 0) // Gera "apenas" a mensagem das posições invertidas do vetor!
        cTexto += STR(aVetor[nCont]) + CRLF + CRLF
        nCont--
    end while

    FWAlertInfo(cTexto, 'Texto Invertido: ')

    for nCont := 1 to 5 // Inversão do vetor real
        nAux            := aVetor[nCont]
        aVetor[nCont]   := aVetor[nFim]
        aVetor[nFim]    := nAux
        nFim--
    next nCont

    for nCont := 1 to 10 // Gerar a mensagem das posições do vetor
        cTextoA += STR(aVetor[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTextoA, 'Vetor Invertido: ')

Return 
