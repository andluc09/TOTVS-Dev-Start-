#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ConfExcl
    Lista 02: Pontos de Entrada - Exercício 09
    @type  Function
    @author André Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function ConfExcl()

    Local lDecisao := MsgYesNo("Confirma a exclusão deste cadastro?", "CONFIRMAÇÃO")

    if(lDecisao)
        xRet := .T.
    else
        xRet := .F.
        //Help(cHelp,nLinha,cTítulo,cNil,cMensagem,nLinMen,nColMen)
        Help(NIL, NIL, "Exclusão Cancelada", NIL, "Exclusão foi cancelada pelo usuário!", 1, 0)       
    endif

Return lDecisao
