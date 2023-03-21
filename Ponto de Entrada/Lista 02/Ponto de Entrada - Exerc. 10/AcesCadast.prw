#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function AcesCadast
    Lista 02: Pontos de Entrada - Exercício 10
    @type  Function
    @author André Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function AcesCadast()

    FWAlertInfo("Foi adicionado um novo botão: Cad. Produtos em Outras Ações!", "INFORME")
    xRet := {{ 'Cad. Produtos', 'CAD. PRODUTOS',{| | AxCadastro('SB1', 'Cadastro de Produtos') }, 'Cadastro de Produtos' }}

Return
