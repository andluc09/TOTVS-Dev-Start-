#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function CalcTinta
    Lista 04 - Interfaces Visuais | Exercício 04
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function CalcTinta()

    Local nAlt   := SPACE(3)
    Local nLarg  := SPACE(3)
    Local cTitle := ' Área '
    Local nOpcao := 0
    Private oDlg := NIL 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 220, 295 FONT oFont :=  TFont():New('Arial',,-13,.T.) PIXEL

    @ 014, 023  SAY ' Informe as informações da parede: ' SIZE 150, 10 OF oDlg PIXEL
    @ 035, 023  SAY 'Altura'                              SIZE 55, 10 OF oDlg PIXEL
    @ 035, 057  MSGET nAlt                                SIZE 55, 11 OF oDlg PIXEL PICTURE '@# 999'
    @ 050, 023  SAY 'Largura'                             SIZE 55, 10 OF oDlg PIXEL
    @ 050, 057  MSGET nLarg                               SIZE 55, 11 OF oDlg PIXEL PICTURE '@# 999'

    @ 075, 030 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 075, 079 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED     

    if nOpcao == 1
        CalcArea(Val(nAlt), Val(nLarg))
    Else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO', 'CANCELADO')
    endif

Return

Static Function CalcArea(nAlt, nLarg)
    Local nArea := 0
    
    nArea := nAlt * nLarg

    FwAlertInfo(CRLF + CRLF + 'A área da parede é de: ' + StrTran(cValToChar(nArea),".",",") + 'm².' + CRLF + CRLF;
    + 'Serão necessários <b>' + StrTran(cValToChar(nArea/2),".",",") + '</b> litros de tinta para pintá-la.', ' Informações para pintura')

Return
