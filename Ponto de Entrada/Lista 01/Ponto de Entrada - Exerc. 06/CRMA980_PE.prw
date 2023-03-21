#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CRMA980
    Lista 01: Pontos de Entrada - Exercício 06
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
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
