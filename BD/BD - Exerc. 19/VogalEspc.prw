#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function VogalEspc
    Lista BD - Exercício 19
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
    @see https://tdn.engpro.totvs.com.br/pages/releaseview.action?pageId=24347107    
/*/

User Function VogalEspc()

    Local aVogal     := {"A", "E", "I", "O", "U"}
    Local cTexto     := ""
    Local cTextVogal := ""

    Local nCont      := 0
    Local nQtdEspaco := 0
    Local nContVogal := 0
    Local nQtdVogal  := 0
    Local nQtdVogalA := 0
    Local nQtdVogalE := 0
    Local nQtdVogalI := 0
    Local nQtdVogalO := 0
    Local nQtdVogalU := 0

    cTexto := FWInputBox(' Insira seu texto: ' , ' Digite aqui.. ')

    for nCont := 1 to LEN(cTexto)

        if (SUBSTR(cTexto, nCont, 1) == ' ')
            nQtdEspaco++
        endif

        for nContVogal := 1 to LEN(aVogal)
            if (UPPER(SUBSTR(cTexto, nCont, 1)) == aVogal[nContVogal])
                nQtdVogal++
            endif
        next

        if(UPPER(SUBSTR(cTexto, nCont, 1)) == aVogal[1])
            nQtdVogalA++
        elseif(UPPER(SUBSTR(cTexto, nCont, 1)) == aVogal[2])
            nQtdVogalE++
        elseif(UPPER(SUBSTR(cTexto, nCont, 1)) == aVogal[3])
            nQtdVogalI++
        elseif(UPPER(SUBSTR(cTexto, nCont, 1)) == aVogal[4])
            nQtdVogalO++                 
        elseif(UPPER(SUBSTR(cTexto, nCont, 1)) == aVogal[5])
            nQtdVogalU++
        endif        

    next

    cTextVogal += CRLF + CRLF + "A: " + CValToChar(nQtdVogalA) + " , ";
    + " E: " + CValToChar(nQtdVogalE) + " , ";
    + " I: " + CValToChar(nQtdVogalI) + " , ";
    + " O: " + CValToChar(nQtdVogalO) + " , ";
    + " U: " + CValToChar(nQtdVogalU) + "."    

    FWAlertInfo(' Espaços em branco na frase: ' + CValToChar(nQtdEspaco) , ' Quantidade de espaços __ ')

    FWAlertInfo(' Vogais presentes na frase: ' + CValToChar(nQtdVogal) , ' Quantidade de vogais (A, E, I, O, U) ')

    FWAlertInfo(' Vogais presentes na frase: ' + cTextVogal, ' Quantidade de vogais ')

Return 
