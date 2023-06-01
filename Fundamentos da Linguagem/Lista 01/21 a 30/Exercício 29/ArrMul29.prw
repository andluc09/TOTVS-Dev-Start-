#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ArrMul29
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 29
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function ArrMul29()

    Local nRecebe := 0
    Local aArray1 := {}
    Local aArray2 := {}
    Local nNum    := 0
    Local cMostra := ''
    Local nI      := 0

//* Tratamento numérico

    for nI := 1 to 10
        nRecebe := VAL(FwInputBox('Digite o ' + AllTrim(Str(nI)) + 'º número do vetor: '))
        AADD(aArray1, nRecebe)
    next

    nNum := VAL(FwInputBox('Digite um número para multiplicar pelo vetor: '))

    for nI := 1 to 10
        AADD(aArray2,aArray1[nI] * nNum)
    next

    for nI := 1 to 10
        if nI < 10
            cMostra += (Alltrim(STR(aArray2[nI])) + ', ')
        else
            cMostra += (Alltrim(STR(aArray2[nI])) + '.')
        endif
    next

    FwAlertSuccess('Vetor resultado: ' + cMostra, 'VETOR MULTIPLICADO')

Return
