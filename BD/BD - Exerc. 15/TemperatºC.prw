#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function TemperatºC
    Lista BD - Exercício 15
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function TemperatºC()

    Local aTemperatura[12]
    Local aMes[12] 
    Local nMeses         := 0
    Local nSomatorioTemp := 0
    Local cTexto         := ''

    aMes := {'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'}

    for nMeses := 1 to 12
        aTemperatura[nMeses] := VAL(FWInputBox(' Temperatura de ' + CValToChar(aMes[nMeses]) + ': ', ' °C '))
        nSomatorioTemp += aTemperatura[nMeses]
    next

    nMediaTemp := (nSomatorioTemp)/LEN(aTemperatura)

    FWAlertInfo('Média Anual: ' + STRZero(nMediaTemp, 5, 2) + ' °C',' TEMPERATURA ')

    nMeses := 1

    while (nMeses != 13)
        if (nMediaTemp < aTemperatura[nMeses])
            cTexto += CValToChar(aTemperatura[nMeses]) + ' °C  –  ' + Space(1) + CValToChar(aMes[nMeses]) + CRLF + CRLF
        endif
        nMeses++
    end

    FWAlertInfo(cTexto, ' Temperaturas acima da média anual: ')

Return 
