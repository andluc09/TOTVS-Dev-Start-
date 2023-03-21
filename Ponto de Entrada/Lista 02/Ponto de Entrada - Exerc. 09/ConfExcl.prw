#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ConfExcl
    Lista 02: Pontos de Entrada - Exerc�cio 09
    @type  Function
    @author Andr� Lucas M. Santos
    @since 16/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function ConfExcl()

    Local lDecisao := MsgYesNo("Confirma a exclus�o deste cadastro?", "CONFIRMA��O")

    if(lDecisao)
        xRet := .T.
    else
        xRet := .F.
        //Help(cHelp,nLinha,cT�tulo,cNil,cMensagem,nLinMen,nColMen)
        Help(NIL, NIL, "Exclus�o Cancelada", NIL, "Exclus�o foi cancelada pelo usu�rio!", 1, 0)       
    endif

Return lDecisao
