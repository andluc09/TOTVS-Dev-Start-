#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Interacao
    Lista 02: Pontos de Entrada - Exercício 08
    @type  Function
    @author André Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function Interacao()

    Local nOp   := PARAMIXB[4]

    if (INCLUI) 
        FWAlertInfo("Seja Bem vindo(a) ao Cadastro de Fornecedores!", "Boas-vindas")
    elseif (ALTERA) 
        FWAlertWarning("Você está prestes a alterar o cadastro do fornecedor " + AllTrim(SA2->A2_NOME) + "!", "ALTERAÇÃO")
    elseif (nOp == 5) 
        FWAlertWarning("Cuidado, você está prestes a excluir o fornecedor " + AllTrim(SA2->A2_NOME) + "!", "EXCLUSÃO")
    endif

Return
