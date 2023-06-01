#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function SortNm39
    Lista 01 - Fundamentos da Linguagem ADVPL | Exerc�cio 39
    @type  Function
    @author Andr� Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function SortNm39()

    Local aNomes := {'Andr�','Tam�ris','Matheus Pintor','Edison','Daniele','Giulliana','Gabriela','Ruan','Quirino','Jo�o Pedro','Gustavo Favero',;
                        'Natan', 'Ruan', 'Stephani','Henrique','Lucas','F�bio', 'Gustavo Cabral', 'Muriel'}

    Local nSort  := 0

    nSort := RANDOMIZE(1 , LEN(aNomes))

    FwAlertSuccess('O sorteado � o(a): ' + aNomes[nSort], 'SELECIONADO')

Return
