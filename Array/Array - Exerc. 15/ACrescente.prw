#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ACrescente
    Lista Array - Exerc�cio 15
    @type  Function
    @author Andr� Lucas M. Santos 
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
            if(aArray[nCont] >= aArray[nNum]) //? Enquanto a [posi��o anterior] maior ou igual [pr�xima posi��o]
                nAux := aArray[nCont] //? Guarda a [posi��o anterior] maior ou igual em vari�vel auxiliar
                aArray[nCont] := aArray[nNum] //? A vari�vel atual da [posi��o anterior] recebe a [pr�xima posi��o]
                aArray[nNum] := nAux //? A vari�vel da [pr�xima posi��o] recebe a vari�vel auxiliar contendo o n�mero maior ou igual
            endif //? Vari�vel num�rica de maior valor sempre ser� trocada pela de menor valor enquanto todos os elementos do vetor n�o estiverem ordenados em sequ�ncia crescente! 
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
