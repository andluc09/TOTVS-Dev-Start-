#INCLUDE 'TOTVS.CH'

/*/
    Andr� Lucas M. Santos

    Exerc�cio 1 - Lista: Pontos de Entrada
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
