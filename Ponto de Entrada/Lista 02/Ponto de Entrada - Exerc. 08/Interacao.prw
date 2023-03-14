#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
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
