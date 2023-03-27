#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function A_azNoRept
    Lista Array - Exercício 14
    @type  Function
    @author André Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function A_azNoRept()

    Local aArray_az[100]
    Local aArray[12]
    Local nNum      := 0
    Local cTexto    := ""

    for nNum := 1 to LEN(aArray)
        if((ASCAN(aArray, aArray_az[nNum] := Minusculas(aArray_az)[nNum])) == 0)
            aArray[nNum] := aArray_az[nNum]
            cTexto += CValToChar(nNum) + "º " + Space(1) + CValToChar(aArray[nNum]) + CRLF + CRLF
        else
            nNum--
        endif
    next nNum 

    ExibeVet(cTexto)

Return 

Static Function Minusculas(aArray_az)
    Local nCont := 0

    for nCont := 1 to LEN(aArray_az)
        aArray_az[nCont] := CHR(Randomize(0,25)+97) // Código ASCII #122 —> z Minúsculo, logo 122-97 = 25; random(gera 0 a 25) + 97 = 97 a 122!
    next nCont

Return aArray_az

Static Function ExibeVet(cTexto)

    AVISO("<b> Vetor AZ: </b>", cTexto, {"OK"}, 3, NIL)

Return 
