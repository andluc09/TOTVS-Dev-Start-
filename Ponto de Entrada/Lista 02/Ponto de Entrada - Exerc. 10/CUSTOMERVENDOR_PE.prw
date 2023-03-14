#INCLUDE 'TOTVS.CH'

/*/
    André Lucas M. Santos

    Exercício 2 - Lista: Pontos de Entrada
/*/

User Function CUSTOMERVENDOR()
    
    Local aParam    := PARAMIXB
    Local oObj      := ''
    Local cIdPonto  := ''
    Local cIdModel  := ''
    
    Public xRet     := .T.

    if aParam <> NIL

        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

    endif

    if (cIdPonto == 'BUTTONBAR')
        if ExistBlock('AcesCadast')
            ExecBlock('AcesCadast', .F., .F.)
        endif
    endif

Return xRet
