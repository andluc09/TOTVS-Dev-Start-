#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CadCsoEx
    Lista 04 - Interfaces Visuais | Exercício 19
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com.br/pages/releaseview.action?pageId=23889136
/*/

User Function CadCsoEx()

    Local cAlias     := 'ZCS'
    Local cTitulo    := 'Cadastro de Cursos'
    Local lValidExcl := 'u_ValidExcl()'

    ZCS->(DBSelectArea(cAlias))
    ZCS->(DBSetOrder(1))

    AxCadastro(cAlias, cTitulo, lValidExcl, NIL)
    //? AxCadastro( <cAlias>, <cTitulo>, <cVldExc>, <cVldAlt>)
    //*             Apelido da Tabela,
    //*                       TÍTULO da janela (tela),
    //*                                 Função responsável por validar o registro após a confirmação da sua exclusão,
    //*                                            Função responsável por validar o registro após a confirmação das alterações

    ZCS->(DBCloseArea())

Return 

User Function ValidExcl()

    Local lOk := .T.

    if FWAlertYesNo('Você pretende deletar o curso realmente?', 'CONFIRMAÇÃO')
        lOk := .T.
    else
        lOk := .F.
    endif

Return lOk
