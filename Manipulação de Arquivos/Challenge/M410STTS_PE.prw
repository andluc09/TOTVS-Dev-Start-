#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function M410STTS
    Lista 13 - Manipulação de Arquivos | Challenge
    @type  Function
    @author André Lucas M. Santos
    @since 30/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=6784155
/*/

User Function M410STTS()

Local nOper := PARAMIXB[1]

    if (nOper == 3 .OR. nOper == 4)  //? 3 - Inclusão, 4 - Alteração
        if ExistBlock('RelPDFDir')
            ExecBlock('RelPDFDir', .F., .F.,/**/)
        endif
    endif

Return 
