#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
/*/

User Function FISA010()
    
    Local aParam    :=  PARAMIXB
    Local oObj      := ''
    Local cIdPonto  := ''
    Local cIdModel  := ''
    
    PUBLIC xRet      := .T.

    if aParam <> NIL

        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

    endif

    if (INCLUI) .AND. (cIdPonto == 'FORMPOS')
        if ExistBlock('MsgImpede')
            ExecBlock('MsgImpede', .F., .F.)
        endif
    endif

Return xRet
