#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ArrayMenu
    Lista Array - Exercício 17
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function ArrayMenu()

    Local aArray[8]
    Local oDlg 
    Local oArray
    Local oTela
    Local oBtn
    Private cTextPadrao := ''
    Private cTextoArray := ''

    DEFINE DIALOG oDlg TITLE ("Escolha uma opção: ") ; //? Tela Pricipal
    FROM 0,0 TO 550,700 ;    
    FONT oFont :=  TFont():New('Arial',,-14,.T.) ;  
    COLOR CLR_BLACK, CLR_WHITE PIXEL

    @ 03, 07 GROUP oArray TO (700/15)-1, (550/2)-3 PROMPT "Resultados: " OF oDlg COLOR 0, 17000000 PIXEL //* Subtela 1
    @ 15, 12 MSGET oArray VAR cTextoArray SIZE (550/2)-15, 20 OF oArray COLORS 0, 17000000 NO BORDER PIXEL 

    @ 47, 07 GROUP oTela TO (1360/15)-1, (550/2)-3 PROMPT "Array: " OF oDlg COLOR 0, 17000000 PIXEL //* Subtela 2
    @ 60, 12 MSGET oTela VAR cTextPadrao SIZE (550/2)-60, 20 OF oTela COLORS 0, 17000000 NO BORDER PIXEL 

    @ 99,10 BUTTON oBtn PROMPT "Carrega Array" SIZE 75,25 ACTION (CargaArray(aArray)) OF oDlg PIXEL 

    @ 99,135 BUTTON oBtn PROMPT "Exibir Array" SIZE 75,25 ACTION (ExibiArray(aArray)) OF oDlg PIXEL 

    @ 99,265 BUTTON oBtn PROMPT "Array Crescente" SIZE 75,25 ACTION (Crescente(aArray)) OF oDlg PIXEL 

    @ 141,10 BUTTON oBtn PROMPT "Array Descrescente" SIZE 75,25 ACTION (Decrescent(aArray)) OF oDlg PIXEL         

    @ 141,135 BUTTON oBtn PROMPT "Pesquisar no Array" SIZE 75,25 ACTION (Pesquisa(aArray)) OF oDlg PIXEL 

    @ 141,265 BUTTON oBtn PROMPT "Somatório Array" SIZE 75,25 ACTION (Somatorio(aArray)) OF oDlg PIXEL 

    @ 183,10 BUTTON oBtn PROMPT "Média Elementos" SIZE 75,25 ACTION (MediaArray(aArray)) OF oDlg PIXEL 

    @ 183,135 BUTTON oBtn PROMPT "Maior/Menor" SIZE 75,25 ACTION (MaiorMenor(aArray)) OF oDlg PIXEL 

    @ 183,265 BUTTON oBtn PROMPT "Embaralhar" SIZE 75,25 ACTION (AEmbaralha(aArray)) OF oDlg PIXEL 

    @ 225,73 BUTTON oBtn PROMPT "Repetição Elementos" SIZE 75,25 ACTION (RepetArray(aArray)) OF oDlg PIXEL 

    @ 225,200 BUTTON oBtn PROMPT "Sair" SIZE 75,25 ACTION oDlg:End() OF oDlg PIXEL    

    ACTIVATE DIALOG oDlg CENTER

Return 

Static Function CargaArray(aArray)

    Local nNum 

    for nNum := 1 to LEN(aArray)
        aArray[nNum] := Randomize(0,100)
    next

    cTextPadrao := "Array gerado: " + (ArrTokStr(aArray, ", ") + ".")

Return 

Static Function ExibiArray(aArray)

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        FWAlertInfo("Exibindo Array: " + CRLF + CRLF + (ArrTokStr(aArray, ", ") + "."), "INFORME")
    endif

Return 

Static Function Crescente(aArray)

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        ASORT(aArray,,, { |x, y| x < y } )

        cTextoArray := "Array crescente: " + (ArrTokStr(aArray, ", ") + ".")
    endif

Return 

Static Function Decrescent(aArray)

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        ASORT(aArray,,, { |x, y| x > y } )

        cTextoArray := "Array decrescente: " + (ArrTokStr(aArray, ", ") + ".")
    endif

Return 

Static Function Pesquisa(aArray)

    Local nNum  := 0
    Local cNum  := ""

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else

        nNum := ASCAN(aArray, VAL(cNum := FWInputBox(" Insira um número a ser pesquisado no array? ")))

        if nNum <> 0
            FWAlertSuccess("O número <b>" + cNum + "</b> foi encontrado na posição: <b>" + CValToChar(nNum) + "</b>.", "INFORME")
        else
            FWAlertError("O número não foi encontrado no array!", "INFORME")
        endif
    endif

Return 

Static Function Somatorio(aArray)

    Local nCont := 0
    Local nSoma := 0

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        for nCont := 1 to LEN(aArray)
            nSoma += aArray[nCont]
        next

        cTextoArray := "Somatório do array: " + CValToChar(nSoma)
    endif

Return 

Static Function MediaArray(aArray)

    Local nCont  := 0
    Local nSoma  := 0
    Local nMedia := 0

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        for nCont := 1 to LEN(aArray)
            nSoma += aArray[nCont]
        next

        nMedia := (nSoma)/ LEN(aArray)

        cTextoArray := "Média do array: " + CValToChar(nMedia)        

    endif

Return 

Static Function MaiorMenor(aArray)

    Local nMaior := 0
    Local nMenor := 0

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        ASORT(aArray)

        nMaior := ATAIL(aArray) // ATAIL, função de manipulação de array que retorna o último elemento de um array
        nMenor := aArray[1]

        cTextoArray := "Maior valor do array " + CValToChar(nMaior) + " e o menor valor do array " + CValToChar(nMenor) +"."

    endif

Return 

Static Function AEmbaralha(aArray)

    Local nCont := 0
    Local nNum  := 0
    Local nAux  := 0

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        for nCont := 1 to LEN(aArray)
            nNum := Randomize(1, 8)
            nAux := aArray[nCont]
            aArray[nCont] := aArray[nNum]
            aArray[nNum] := nAux
        next nCont

        cTextoArray := "Array embaralhado: " + (ArrTokStr(aArray, ", ") + ".")

    endif

Return 

Static Function RepetArray(aArray)

    Local nCont   := 0
    Local nNum    := 0
    Local nRepete := 0
    Local cTexto  := ""

    if (Empty(aArray[1] .AND. aArray[2] .AND. aArray[3] .AND. aArray[4] .AND. aArray[5] .AND. aArray[6] .AND. aArray[7] .AND. aArray[8]))
        FWAlertWarning("Array Vazio!", "ALERTA")
    else
        for nCont := 1 to LEN(aArray)-1
            for nNum := nCont + 1 to LEN(aArray)
                if(aArray[nCont]  == aArray[nNum])
                    cTexto += " O número " + CValToChar(aArray[nCont]) + " foi encontrado nas posições :" + CValToChar(nCont) + " e " + CValToChar(nNum) + "." + CRLF + CRLF
                    nRepete++
                endif
            next nNum
        next nCont

    FWAlertInfo(cTexto + CRLF + CRLF + "Quantidade de repetições: " + CValToChar(nRepete) + ".", "Elementos repetidos no Array")

    endif

Return 
