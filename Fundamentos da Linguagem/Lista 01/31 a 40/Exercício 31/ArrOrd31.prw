#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ArrOrd31
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 31
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function ArrOrd31()

    Local nNumero := 0
    Local nI      := 0
    Local cMostra := ''
    Local aArray1 := {}

//* Tratamento num�rico

    for nI := 1 to 10
        nNumero := VAL(FwInputBox('Digite aqui o ' + AllTrim(STR(nI)) + '� n�mero do array: '))
        AADD(aArray1, nNumero)
    next

    ASORT(aArray1)

    for nI := 1 to 10
        if nI < 10
            cMostra += (Alltrim(STR(aArray1[nI])) + ',')
        else
            cMostra += (Alltrim(STR(aArray1[nI])) + '.')
        endif
    next

    FwAlertSuccess('Vetor resultante com os n�meros na ordem crescente �: ' + cMostra)

Return
