#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 1 - Lista: Pontos de Entrada
/*/

User Function CRMA980()
    
    Local aParam    :=  PARAMIXB
    Local oObj      := ''
    Local cIdPonto  := ''
    Local cIdModel  := ''
    Local xRet      := .T.

    if aParam <> NIL

        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
    
    endif

    if (INCLUI) .AND. (cIdPonto == 'MODELCOMMITTTS')
        if ExistBlock('BloqCliente')
            ExecBlock('BloqCliente', .F., .F.)
        endif
    endif

Return xRet
