#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Oper01
    Lista 02 - Fundamentos da Linguagem ADVPL | Exercício 01
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function Oper01()

    Local aNums := {0, 0}
    Local nNum  := ''
    Local lLoop := .T.

    nNum := FwInputBox('Insira aqui o primeiro número positivo:')

    While lLoop
        If !IsDigit(nNum) .AND. Negativo(VAL(nNum))
            FwAlertError('Você não inseriu um número positivo, por favor. Preste atenção!')
            nNum := FwInputBox('Insira aqui o primeiro número positivo:')
        Else 
            aNums[1] := Val(nNum)
            lLoop := .F.
        Endif
    Enddo

    lLoop := .T.

    nNum := FwInputBox('Insira aqui o segundo número positivo:')

    While lLoop
        If !IsDigit(nNum) .AND. Negativo(VAL(nNum))
            FwAlertError('Você não inseriu um número positivo, por favor. Preste atenção!')
            nNum := FwInputBox('Insira aqui o segundo número positivo:')
        Else
            aNums[2] := Val(nNum)
            lLoop := .F.
        Endif
    Enddo

    FwAlertSuccess(cValToChar(aNums[1]) + ' + ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Adic(aNums)), ".", ",") + CRLF +;
    cValToChar(aNums[1]) + ' - ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Dif(aNums)), ".", ",") + CRLF +;
    cValToChar(aNums[1]) + ' * ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Prodt(aNums)), ".", ",") + CRLF +;
    cValToChar(aNums[1]) + ' / ' + cValToChar(aNums[2]) + ' = ' + StrTran(cValToChar(Quocte(aNums)), ".", ","), 'Operações')

    
Return

//? Adição
Static Function Adic(aNums)
    Local nSoma := 0

    nSoma := aNums[1] + aNums[2]

Return nSoma

//? Diferença
Static Function Dif(aNums)
    Local nDif := 0

    nDif := aNums[1] - aNums[2]

Return nDif

//? Produto
Static Function Prodt(aNums)
    nProduto := 0

    nProduto := (aNums[1] * aNums[2])

Return nProduto

//? Quociente
Static Function Quocte(aNums)
    nQuociente := 0

    nQuociente := (aNums[1] / aNums[2])

Return nQuociente
