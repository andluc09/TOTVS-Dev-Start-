#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CadCurso
    Lista 04 - Interfaces Visuais | Exercício 18
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com.br/pages/releaseview.action?pageId=23889136
/*/

User Function CadCurso()

    Local cAlias  := 'ZCS'
    Local cTitulo := 'Cadastro de Cursos'

    ZCS->(DBSelectArea(cAlias))
    ZCS->(DBSetOrder(1))

    AxCadastro(cAlias, cTitulo, .F., NIL)
    //? AxCadastro( <cAlias>, <cTitulo>, <cVldExc>, <cVldAlt>)
    //*             Apelido da Tabela,
    //*                       TÍTULO da janela (tela),
    //*                                 Função responsável por validar o registro após a confirmação da sua exclusão,
    //*                                            Função responsável por validar o registro após a confirmação das alterações

    ZCS->(DBCloseArea())

Return 
