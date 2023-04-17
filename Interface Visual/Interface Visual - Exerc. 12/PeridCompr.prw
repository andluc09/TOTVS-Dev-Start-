#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function PeridCompr
    Lista 04 - Interfaces Visuais | Exercício 12
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function PeridCompr()

    Local cTitle    := 'Período Compra' 
    Local nOpcao    := 0 
    Private cDtaIni := SPACE(10)
    Private cDtaFim := SPACE(10)
    Private oDlg    := NIL

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 205, 300 FONT oFont := TFont():New('Arial',,-13,.T.)  PIXEL

    @ 014, 010  SAY 'Insira as datas conforme o período desejado.' SIZE 170, 10 OF oDlg PIXEL
    @ 030, 010  SAY 'Data inicial:'                               SIZE 55, 10 OF oDlg PIXEL
    @ 029, 047  MSGET cDtaIni                                     SIZE 55, 11 OF oDlg PIXEL PICTURE '@# 99/99/9999'
    @ 050, 010  SAY 'Data final:'                                 SIZE 55, 10 OF oDlg PIXEL
    @ 049, 047  MSGET cDtaFim                                     SIZE 55, 11 OF oDlg PIXEL PICTURE '@# 99/99/9999'

    @ 085, 036 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 085, 080 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED 

    if nOpcao == 1
        RelatoData()
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif

Return

Static Function RelatoData()

    Local aArea     := GetArea()
    Local cAlias    := GetNextAlias()
    Local cQuery    := ""
    Local cMSG      := ""

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC5' MODULO 'COM'

    cDtaIni := CTOD(cDtaIni)
    cDtaFim := CTOD(cDtaFim)

    cQuery := "SELECT C5_NUM, C5_TIPO, C5_CLIENTE, C5_EMISSAO FROM " + RETSQLNAME("SC5") + " AS SC5 "
    cQuery += "WHERE C5_EMISSAO BETWEEN '" + DTOS(cDtaIni) + "' AND '" + DTOS(cDtaFim) + "' "
    cQuery += "AND SC5.D_E_L_E_T_ = '' "

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    cMSG := 'Período selecionado: ' + DTOC(cDtaIni) + ' a ' + DTOC(cDtaFim) + CRLF + CRLF + CRLF

    while !(&(cAlias)->(EOF()))
        cMSG += "Pedido: " + &(cAlias)->(C5_NUM) + " | Data de Emissão: " + cValToChar(STOD(&(cAlias)->(C5_EMISSAO))) + CRLF + CRLF
        &(cAlias)->(DBSkip())
    end do

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

    TScrollArea(cMSG)

    RESET ENVIRONMENT

Return 

Static Function TScrollArea(cMSG)

    Local oDlgScroll

    DEFINE DIALOG oDlgScroll TITLE " Pedidos de Compra: " FROM 180,180 TO 700,950 PIXEL;
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
