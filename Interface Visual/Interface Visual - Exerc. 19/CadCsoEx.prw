#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CadCsoEx
    Lista 04 - Interfaces Visuais | Exerc�cio 19
    @type  Function
    @author Andr� Lucas 
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
    //*                       T�TULO da janela (tela),
    //*                                 Fun��o respons�vel por validar o registro ap�s a confirma��o da sua exclus�o,
    //*                                            Fun��o respons�vel por validar o registro ap�s a confirma��o das altera��es

    ZCS->(DBCloseArea())

Return 

User Function ValidExcl()

    Local lOk := .T.

    if FWAlertYesNo('Voc� pretende deletar o curso realmente?', 'CONFIRMA��O')
        lOk := .T.
    else
        lOk := .F.
    endif

Return lOk
