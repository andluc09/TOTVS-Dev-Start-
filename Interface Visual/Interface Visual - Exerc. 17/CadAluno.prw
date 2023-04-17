#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CadAluno
    Lista 04 - Interfaces Visuais | Exerc�cio 17
    @type  Function
    @author Andr� Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com.br/pages/releaseview.action?pageId=23889136
/*/

User Function CadAluno()

    Local cAlias  := 'ZAL'
    Local cTitulo := 'Cadastro de Alunos'

    ZAL->(DBSelectArea(cAlias))
    ZAL->(DBSetOrder(1))

    AxCadastro(cAlias, cTitulo, .F., NIL)
    //? AxCadastro( <cAlias>, <cTitulo>, <cVldExc>, <cVldAlt>)
    //*             Apelido da Tabela,
    //*                       T�TULO da janela (tela),
    //*                                 Fun��o respons�vel por validar o registro ap�s a confirma��o da sua exclus�o,
    //*                                            Fun��o respons�vel por validar o registro ap�s a confirma��o das altera��es

    ZAL->(DBCloseArea())

Return 
