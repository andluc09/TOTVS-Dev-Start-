#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
/*/

User Function AcesCadast()

    FWAlertInfo("Foi adicionado um novo botão: Cad. Produtos em Outras Ações!", "INFORME")
    xRet := {{ 'Cad. Produtos', 'CAD. PRODUTOS',{| | AxCadastro('SB1', 'Cadastro de Produtos') }, 'Cadastro de Produtos' }}

Return
