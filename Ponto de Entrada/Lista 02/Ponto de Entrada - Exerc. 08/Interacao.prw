#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
/*/

User Function Interacao()

    Local nOp   := PARAMIXB[4]

    if (INCLUI) 
        FWAlertInfo("Seja Bem vindo(a) ao Cadastro de Fornecedores!", "Boas-vindas")
    elseif (ALTERA) 
        FWAlertWarning("Voc� est� prestes a alterar o cadastro do fornecedor " + AllTrim(SA2->A2_NOME) + "!", "ALTERA��O")
    elseif (nOp == 5) 
        FWAlertWarning("Cuidado, voc� est� prestes a excluir o fornecedor " + AllTrim(SA2->A2_NOME) + "!", "EXCLUS�O")
    endif

Return
