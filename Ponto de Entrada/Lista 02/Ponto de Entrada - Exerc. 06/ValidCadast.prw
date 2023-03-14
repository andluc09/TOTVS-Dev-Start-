#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 2 - Lista: Pontos de Entrada
/*/

User Function ValidCadast()

    if Empty(M->A2_PAIS) 
        xRet := .F.
        Help(NIL, NIL, 'O campo Pa�s deve ser preenchido!', NIL, 'O campo Pa�s n�o foi seleciondo.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Necess�rio selecionar o Pa�s.'})
    elseif M->A2_PAIS $ '105' .AND. Empty(M->A2_CGC) //$ (contido em)
        xRet := .F.
        Help(NIL, NIL, 'O campo CNPJ deve ser preenchido!', NIL, 'O campo CNPJ n�o foi preenchido.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Necess�rio preencher o CNPJ do cliente.'}) 
    endif

Return xRet
