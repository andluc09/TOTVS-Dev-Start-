#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function PedVendPrd
    Lista BD - Exercício 09
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function PedVendPrd()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""
    Local cProduto  := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SC5, SC6" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SC5')

    DBSelectArea('SC6')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    cProduto := FWInputBox("Insira um código do produto: ", "Digite aqui o código do produto")

    /*SELECT DISTINCT C5_NUM, C6_PRODUTO FROM SC5990 AS SC5
    INNER JOIN SC6990 AS SC6
    ON SC5.C5_LOJACLI = SC6.C6_LOJA
    AND SC5.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = ''
    WHERE SC6.C6_PRODUTO = '000001'*/

    cQuery := "SELECT DISTINCT C5_NUM, C6_PRODUTO FROM " + RETSQLNAME("SC5") + " AS SC5 "
    cQuery += "INNER JOIN " + RETSQLNAME("SC6") + " AS SC6 "
    cQuery += "ON SC5.C5_LOJACLI = SC6.C6_LOJA "
    cQuery += "AND SC5.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = '' "
    cQuery += "WHERE SC6.C6_PRODUTO = '" + cProduto + "' "  

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Pedidos de venda (produto selecionado) - ' + Space(1) + 'Número pedido: ' + 'C5_NUM' + Space(1) + ' - Código do produto: ' + 'C6_PRODUTO' + Space(1) + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Pedidos de venda (produto selecionado) - ' + Space(1)  + 'Número pedido: ' + &(cAlias)->(C5_NUM) + Space(1) + ' - Código do produto: ' + (C6_PRODUTO) + Space(1) + CRLF + CRLF //CRLF -- pula linha      
        &(cAlias)->(DBSkip()) //DB (Banco de Dados) SKIP (pular) pula linha até encontrar linha em branco: fim do arquivo
    end do

    &(cAlias)->(DBCloseArea()) //ENCERRA COMUNICAÇÃO COM SERVIDOR

    FWAlertInfo(cMSG, "<b> Query: </b>")

    TScrollArea(cMSG)

    RESET ENVIRONMENT

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

