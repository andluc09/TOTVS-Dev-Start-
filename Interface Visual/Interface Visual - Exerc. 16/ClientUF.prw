#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function ClientUF
    Lista 04 - Interfaces Visuais | Exercício 16
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function ClientUF()

    Local cTitle    := 'Fornecedores'
    Local cTexto    := 'Estado'
    Local nOpcao    := 0
    Local nJanAltu  := 190
    Local nJanLarg  := 190
    Local oGrpLog   := NIL
    Private cEstado := SPACE(2)
    Private oDlg    := NIL 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO nJanAltu, nJanLarg FONT oFont := TFont():New('Arial',,-13,.T.) PIXEL

    @ 003, 003  GROUP oGrpLog TO (nJanAltu/2)-1, (nJanLarg/2)-3    PROMPT cTexto    OF oDlg PIXEL

    @ 020, 012  SAY 'Estado do Fornecedor: '   SIZE 105, 10 OF oDlg PIXEL
    @ 035, 012  MSGET cEstado                SIZE 55, 10 OF oDlg PIXEL PICTURE '@#! AA'

    @ 060, 013 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 060, 049 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED 

    if nOpcao == 1
        ValidVazio()
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif

Return

Static Function PegaEstado()
    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ''
    Local cMSG    := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA2' MODULO 'FAT'

    cQuery := "SELECT DISTINCT A2_COD, A2_NOME FROM " + RETSQLNAME("SA2") + " AS SA2 "
    cQuery += "WHERE A2_EST = '" + Upper(cEstado) + "' "
    cQuery += "AND SA2.D_E_L_E_T_ = '' "

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
        cMSG += 'Código Fornecedor: ' + &(cAlias)->(A2_COD) + CRLF
        cMSG += 'Nome Fornecedor: ' + &(cAlias)->(A2_NOME) + CRLF
        cMSG +=  '_______________________________________________________________' + CRLF + CRLF
        &(cAlias)->(DbSkip())
    enddo

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

    TScrollArea(cMSG)

    RESET ENVIRONMENT

Return 

Static Function ValidVazio()

    if(Empty(cEstado))
        FWAlertErro('Selecione um <i>estado</i>.. ', 'ERRO')
        U_ClientUF()
    else
        PegaEstado()
    endif

Return 

Static Function TScrollArea(cMSG)

    Local oDlgScroll

    DEFINE DIALOG oDlgScroll TITLE " Fornecedores encontrados: " FROM 180,180 TO 700,950 PIXEL;
    FONT oFont :=  TFont():New('Arial',,-14,.T.)

    //* Cria objeto Scroll
    oScroll := TScrollArea():New(oDlgScroll,01,01,100,100)
    oScroll:Align := CONTROL_ALIGN_ALLCLIENT

    //* Cria painel
    @ 000,000 MSPANEL oPanel OF oScroll SIZE 1000,1000 COLOR CLR_HRED

    //* Define objeto painel como filho do scroll
    oScroll:SetFrame( oPanel )

    //* Define as características de texto incluindo a sujeição como filho do painel 
    TSay():New(15,12,{||cMSG},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlgScroll CENTERED

Return
