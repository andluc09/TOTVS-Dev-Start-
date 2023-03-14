#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 2 - Lista: Pontos de Entrada
/*/

User Function ValidCadast()

    if Empty(M->A2_PAIS) 
        xRet := .F.
        Help(NIL, NIL, 'O campo País deve ser preenchido!', NIL, 'O campo País não foi seleciondo.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Necessário selecionar o País.'})
    elseif M->A2_PAIS $ '105' .AND. Empty(M->A2_CGC) //$ (contido em)
        xRet := .F.
        Help(NIL, NIL, 'O campo CNPJ deve ser preenchido!', NIL, 'O campo CNPJ não foi preenchido.', 1, 0, NIL, NIL, NIL, NIL, NIL, {'Necessário preencher o CNPJ do cliente.'}) 
    endif

Return xRet
