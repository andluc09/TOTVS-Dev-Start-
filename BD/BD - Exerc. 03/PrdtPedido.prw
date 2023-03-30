#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function PrdtPedido
    Lista BD - Exercício 03
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function PrdtPedido()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SC5, SC6" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */
    //RpcSetEnv("99","01",,,"MDI")

    DBSelectArea('SC5')

    DBSelectArea('SC6')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    /*SELECT DISTINCT C5_NUM ,C6_PRODUTO, B1_DESC, C6_QTDVEN, C6_PRCVEN, C6_VALOR FROM SC5990 AS SC5
    INNER JOIN SC6990 AS SC6 ON SC5.C5_CLIENT = SC6.C6_CLI 
    AND SC5.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = ''
    INNER JOIN SB1990 AS SB1 ON SC6.C6_PRODUTO = SB1.B1_COD
    AND SB1.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = ''
    WHERE C5_NUM = 'PV0008'*/

    cQuery := "SELECT DISTINCT C5_NUM ,C6_PRODUTO, B1_DESC, C6_QTDVEN, C6_PRCVEN, C6_VALOR FROM " + RETSQLNAME("SC5") + " AS SC5 "
    cQuery += "INNER JOIN " + RETSQLNAME("SC6") + " AS SC6 ON SC5.C5_CLIENT = SC6.C6_CLI " 
    cQuery += "AND SC5.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = '' "
    cQuery += "INNER JOIN SB1990 AS SB1 ON SC6.C6_PRODUTO = SB1.B1_COD "
    cQuery += "AND SB1.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = '' "
    cQuery += "WHERE C5_NUM = 'PV0008' "

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Produtos do Pedido: ' + Space(1) + 'C5_NUM' + Space(1) + ' - Cod. Produto: ' + 'C6_PRODUTO' + Space(1) + ' - Descrição do Produto: ' + 'B1_DESC' + Space(1) + ' - Qtd.: ' + 'C6_QTDVEN' + Space(1) + ' - Valor Unitário: ' + 'C6_PRCVEN' + Space(1) + ' - Valor Total: ' + 'C6_VALOR' + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Produtos do Pedido: ' + Space(1) + &(cAlias)->(C5_NUM) + Space(1) + ' - Cod. Produto: ' + (C6_PRODUTO) + Space(1) + ' - Descrição do Produto: ' + (B1_DESC) + Space(1) + ' - Qtd.: ' + CValToChar(C6_QTDVEN) + Space(1) + ' - Valor Unitário: ' + CValToChar(C6_PRCVEN) + Space(1) + ' - Valor Total: ' + CValToChar(C6_VALOR) + CRLF + CRLF //CRLF -- pula linha      
        &(cAlias)->(DBSkip()) //DB (Banco de Dados) SKIP (pular) pula linha até encontrar linha em branco: fim do arquivo
    end do

    &(cAlias)->(DBCloseArea()) //ENCERRA COMUNICAÇÃO COM SERVIDOR

    //AVISO("<b> Query: </b>", cMSG, {"OK"}, 3, NIL, NIL, NIL, NIL, NIL, NIL) //! Não funciona com JOB: a thread advpl fica no modo JOB, aonde ela não têm tela e a função de ALERT ou AVISO utlizada, verifica esse tipo de coisa internamente. 
    //Aviso ([ cTitulo ] [ cMsg ] [ aBotoes ] [ nSize ] [ cText ] [ nRotAutDefault ] [ cBitmap ] [lEdit] [nTimer] [nOpcPadrao]) 

    FWAlertInfo(cMSG, "<b> Query: </b>")

    TScrollArea(cMSG)

    RESET ENVIRONMENT
    //RpcClearEnv()

Return

Static Function TScrollArea(cMSG)

    DEFINE DIALOG oDlg TITLE " Query: " FROM 180,180 TO 700,950 PIXEL;
    FONT oFont :=  TFont():New('Arial',,-14,.T.)

    // Cria objeto Scroll
    oScroll := TScrollArea():New(oDlg,01,01,100,100)
    oScroll:Align := CONTROL_ALIGN_ALLCLIENT

    // Cria painel
    @ 000,000 MSPANEL oPanel OF oScroll SIZE 1000,1000 COLOR CLR_HRED

    // Define objeto painel como filho do scroll
    oScroll:SetFrame( oPanel )

    // Define as características de texto incluindo a sujeição como filho do painel 
    TSay():New(15,12,{||cMSG},oPanel,,oFont,,,,.T.,CLR_BLACK,CLR_WHITE,1000,1000)

    ACTIVATE DIALOG oDlg CENTERED

Return
