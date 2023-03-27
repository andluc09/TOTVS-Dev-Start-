#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function A_AZRept
    Lista Array - Exerc�cio 13
    @type  Function
    @author Andr� Lucas M. Santos 
    @since 22/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function A_AZRept()

    Local aArrayAZ[100]
    Local aArray[50]
    Local nNum      := 0
    Local cTexto    := ""

    for nNum := 1 to LEN(aArray)
        aArray[nNum] := Maiusculas(aArrayAZ)[nNum]
        cTexto += CValToChar(nNum) + "� " + Space(1) + CValToChar(aArray[nNum]) + CRLF + CRLF
    next nNum 

    AVISO("<b> Vetor AZ: </b>", cTexto, {"OK"}, 3, NIL)

Return 

Static Function Maiusculas(aArrayAZ)

    Local nCont := 0

    for nCont := 1 to LEN(aArrayAZ)
        aArrayAZ[nCont] := CHR(Randomize(0,25)+65) // C�digo ASCII #90	�> Z Mai�sculo, logo 90-65 = 25; random(gera 0 a 25) + 65 = 65 a 90! 
    next nCont

Return aArrayAZ
