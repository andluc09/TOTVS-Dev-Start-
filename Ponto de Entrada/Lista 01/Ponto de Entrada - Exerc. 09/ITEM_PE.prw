#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function ITEM
    Lista 01: Pontos de Entrada - Exercício 09
    @type  Function
    @author André Lucas M. Santos
    @since 15/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=208345968
/*/

User Function ITEM()
    
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

    if (INCLUI .OR. ALTERA) .AND. (cIdPonto == 'MODELCOMMITTTS')
        if ExistBlock('InclAltrCadast')
            ExecBlock('InclAltrCadast', .F., .F.)
        endif
    endif

Return xRet   
