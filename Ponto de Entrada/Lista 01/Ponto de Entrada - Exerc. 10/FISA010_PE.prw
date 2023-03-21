#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function FISA010
    Lista 01: Pontos de Entrada - Exercício 10
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
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
