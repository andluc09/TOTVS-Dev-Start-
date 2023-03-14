#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
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
