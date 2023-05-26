#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CnvMod05
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 05
    @type  Function
    @author André Lucas M. Santos
    @since 05/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function CnvMod05()

    Local nCotacaoDolar    := '' 
    Local nQuantidadeDolar := ''
    Local nValorReal       := 0
    Local lContinuar       := .T.
    Local lNum             := .T.

//*Colocar validação numérica, depois

    while lContinuar

        while lNum
            if !IsDigit(nCotacaoDolar) .or. VAL(nCotacaoDolar) <= 0
                nCotacaoDolar := FWInputBox('Digite a cotação do dólar:', 'Cotação do dólar')
            else
                lNum := .F.
            endif
        enddo

        lNum := .T. 

        if !IsDigit(nQuantidadeDolar) .or. VAL(nCotacaoDolar) <= 0 
            nQuantidadeDolar := FWInputBox('Digite a quantidade de dólares:', 'Quantidade de dólares')
        else
            lNum := .F.
        endif

        nValorReal := VAL(nCotacaoDolar) * VAL(nQuantidadeDolar)

        FWAlertInfo('O valor em reais é de R$ ' + StrTran(Alltrim(STR(nValorReal, 15, 2)), ".", ","), 'Conversão Dólar em Real')

        lContinuar := FWAlertYesNo('Deseja realizar uma nova conversão?', 'Conversor Dólar-Real')

        nCotacaoDolar    := ''
        nQuantidadeDolar := ''

    enddo

    if VAL(SubStr(Time(), 1, 2)) > 6 .AND. VAL(SubStr(Time(), 1, 2)) < 12
        FwAlertSuccess('Muito obrigado pela preferência! Tenha um ótimo dia!', 'Obrigado!')
    elseif VAL(SubStr(Time(), 1, 2)) < 18
        FwAlertSuccess('Muito obrigado pela preferência! Tenha uma ótima tarde!', 'Obrigado!')
    else
        FwAlertSuccess('Muito obrigado pela preferência! Tenha uma ótima noite!', 'Obrigado!')
    endif

Return
