#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
/*/

User Function AcesCadast()

    FWAlertInfo("Foi adicionado um novo bot�o: Cad. Produtos em Outras A��es!", "INFORME")
    xRet := {{ 'Cad. Produtos', 'CAD. PRODUTOS',{| | AxCadastro('SB1', 'Cadastro de Produtos') }, 'Cadastro de Produtos' }}

Return
