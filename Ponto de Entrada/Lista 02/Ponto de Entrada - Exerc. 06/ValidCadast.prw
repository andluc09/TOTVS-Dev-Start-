#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ValidCadast
    Lista 02: Pontos de Entrada - Exercício 06
    @type  Function
    @author André Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
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
