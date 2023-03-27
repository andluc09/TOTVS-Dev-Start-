#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ACrescente
    Lista Array - Exercício 15
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function ACrescente()

    Local aArray[12]
    Local nCont  := 0
    Local nNum   := 0
    Local nAux   := 0
    Local cTexto := ""

    CargaVetor(aArray, nCont)

    for nCont := 1 to LEN(aArray)-1 //? Percorre Array de 1 a 11
        for nNum := nCont + 1 to LEN(aArray) //? Percorre Array de 2 a 12
            if(aArray[nCont] >= aArray[nNum]) //? Enquanto a [posição anterior] maior ou igual [próxima posição]
                nAux := aArray[nCont] //? Guarda a [posição anterior] maior ou igual em variável auxiliar
                aArray[nCont] := aArray[nNum] //? A variável atual da [posição anterior] recebe a [próxima posição]
                aArray[nNum] := nAux //? A variável da [próxima posição] recebe a variável auxiliar contendo o número maior ou igual
            endif //? Variável numérica de maior valor sempre será trocada pela de menor valor enquanto todos os elementos do vetor não estiverem ordenados em sequência crescente! 
        next nNum
    next nCont

    ExibeArray(aArray, nCont, cTexto)

Return 

Static Function CargaVetor(aArray, nCont)

    for nCont := 1 to LEN(aArray)
        aArray[nCont] := Randomize(1,100)
    next nCont

Return aArray

Static Function ExibeArray(aArray, nCont, cTexto)

    for nCont := 1 to LEN(aArray)
        cTexto += CValToChar(aArray[nCont]) + CRLF + CRLF
    next nCont

    FWAlertInfo(cTexto, ' Vetor Crescente: ')

Return 
