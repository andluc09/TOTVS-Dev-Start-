#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CadCurso
    Lista 04 - Interfaces Visuais | Exerc�cio 18
    @type  Function
    @author Andr� Lucas 
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
    //*                       T�TULO da janela (tela),
    //*                                 Fun��o respons�vel por validar o registro ap�s a confirma��o da sua exclus�o,
    //*                                            Fun��o respons�vel por validar o registro ap�s a confirma��o das altera��es

    ZCS->(DBCloseArea())

Return 
