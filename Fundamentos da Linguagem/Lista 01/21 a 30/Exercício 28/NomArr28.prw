#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function NomArr28
    Lista 01 - Fundamentos da Linguagem ADVPL | Exercício 28
    @type  Function
    @author André Lucas M. Santos
    @since 04/04/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/AdvPL
    @see https://tdn.totvs.com/display/tec/AdvPL+-+Functions
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23888829
/*/

User Function NomArr28()

    Local aNomes := {}
    Local cNome  := ''
    Local cFind  := ''
    Local nI     := 1

    for nI := 1 to 10
        cNome := FwInputBox('Digite o nome que será armazenado: ', cNome)
        aADD(aNomes,UPPER(cNome))
        cNome := ''
    next

    cFind := FwInputBox('Digite um nome para pesquisar: ', cFind)

    if aScan(aNomes, UPPER(cFind)) != 0
        FwAlertSuccess('ACHEI!', 'RESULTADO')
    else
        FwAlertError('NÃO ACHEI..', 'RESULTADO')
    endif

Return
