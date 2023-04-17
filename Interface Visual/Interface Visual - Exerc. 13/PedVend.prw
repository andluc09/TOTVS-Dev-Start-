#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function PedVend
    Lista 04 - Interfaces Visuais | Exercício 13
    @type  Function
    @author André Lucas 
    @since 06/04/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24346988
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=24347074
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=23889154
/*/

User Function PedVend()

    Local cTitle      := 'Pedidos de Venda'
    Local nOpcao      := 0
    Local oDlg        := NIL 
    Private cPedVenda := SPACE(6) 

    DEFINE MSDIALOG oDlg TITLE cTitle FROM 000, 000 TO 095, 320 FONT oFont := TFont():New('Arial',,-13,.T.) PIXEL 

    @ 014, 010 SAY 'Código do Produto: ' SIZE 85, 10 OF oDlg PIXEL 
    @ 014, 075 MSGET cPedVenda           SIZE 20, 10 OF oDlg PIXEL 

    @ 010, 120 BUTTON 'Ok'       SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 1, oDlg:End())
    @ 027, 120 BUTTON 'Cancelar' SIZE 35,15 PIXEL OF oDlg ACTION (nOpcao := 2, oDlg:End())

    ACTIVATE MSDIALOG oDlg CENTERED   

    if nOpcao == 1
        PVendas()
    else
        FwAlertWarning('<b>Cancelado</b> pelo usuário!', 'CANCELADO')
    endif 

Return 

Static Function PVendas()

    Local aArea   := GetArea()
    Local cAlias  := GetNextAlias()
    Local cQuery  := ''
    Local cMSG    := ''

    PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SC6' MODULO 'FAT'

    cQuery := "SELECT DISTINCT C6_NUM ,C6_PRODUTO, C6_QTDVEN, C6_PRCVEN, C6_VALOR FROM " + RETSQLNAME("SC6") + " AS SC6 "
    cQuery += "WHERE C6_PRODUTO = '" + cPedVenda + "' AND SC6.D_E_L_E_T_ = '' "

    TCQUERY cQuery ALIAS &(cAlias) NEW

    &(cAlias)->(DbGoTop())

    while &(cAlias)->(!EOF())
        cMSG += "Pedido de Venda: " + &(cAlias)->(C6_NUM) + " | Codigo do Produto: " + cValToChar(&(cAlias)->(C6_PRODUTO)) + " | Quantidade Vendida: " + cValToChar((&(cAlias)->(C6_QTDVEN))) + " | Preço Unitário: " + cValToChar((&(cAlias)->(C6_PRCVEN))) + " | Vlr. Total: " + cValToChar((&(cAlias)->(C6_VALOR))) + CRLF + CRLF
        &(cAlias)->(DbSkip())
    enddo

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

    TScrollArea(cMSG)

    RESET ENVIRONMENT

Return

Static Function TScrollArea(cMSG)

    Local oDlgScroll

    DEFINE DIALOG oDlgScroll TITLE " Pedidos de Venda encontrados: " FROM 180,180 TO 700,950 PIXEL;
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
