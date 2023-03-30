#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function CadstPrdt
    Lista BD - Exercício 20
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
    @see https://tdn.totvs.com/display/public/framework/Posicione+-+Posiciona+tabela+em+registro
/*/

User Function CadstPrdt()

    Local cTipoNome  := " "
    Local cNomeGrupo := M->B1_ZZGRP

    cTipoNome := Posicione("SB1", 1, xFilial("SB1") + B1_COD, "M->B1_TIPO") //? Posicione: B1_FILIAL + B1_COD (chave ou índice da tabela do Protheus) | M->B1_TIPO (gatilho do campo)
    //* Posicione (Alias, Índice, Chave, Campo)

    if ((cTipoNome == "MP") .AND. INCLUI)
        cNomeGrupo := "MATERIA PRIMA PRODUÇÃO" 
    elseif ((cTipoNome == "PA") .AND. INCLUI)
        cNomeGrupo := "PRODUTO PARA COMERCIALIZAÇÃO" 
    elseif(INCLUI)
        cNomeGrupo := "OUTROS PRODUTOS"
    endif 

Return cNomeGrupo
