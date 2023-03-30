#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Dia_Semana
    Lista BD - Exercício 13
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=27677552
/*/

User Function Dia_Semana()

    Local aSemana := {'Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'}
    Local nNum    := 0

    cNum := FWInputBox("Insira um número: ", cNum)

    nNum := VAL(cNum)

    if(nNum >= 1 .AND. nNum <=7)
        FWAlertInfo(aSemana[nNum], 'Dia da semana: ')
    else
        FWAlertWarning('Valor inválido!', 'ATENÇÃO')
    endif

Return 
