#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function MaiorPedVd
    Lista BD - Exercício 08
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function MaiorPedVd()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SB1, SC6" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SB1')

    DBSelectArea('SC6')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    /*SELECT DISTINCT TOP 1 B1_COD, B1_DESC, C6_PRCVEN, C6_VALOR FROM SC6990 AS SC6
    INNER JOIN SB1990 AS SB1
    ON SB1.B1_COD = SC6.C6_PRODUTO
    AND SB1.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = ''
    ORDER BY SC6.C6_VALOR DESC*/

    cQuery := "SELECT DISTINCT TOP 1 B1_COD, B1_DESC, C6_PRCVEN, C6_VALOR FROM " + RETSQLNAME("SC6") + " AS SC6 "
    cQuery += "INNER JOIN " + RETSQLNAME("SB1") + " AS SB1 "
    cQuery += "ON SB1.B1_COD = SC6.C6_PRODUTO "
    cQuery += "AND SB1.D_E_L_E_T_ = '' AND SC6.D_E_L_E_T_ = '' "
    cQuery += "ORDER BY SC6.C6_VALOR DESC "  

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Pedidos de venda (maior valor) - ' + Space(1) + 'Código: ' + 'B1_COD' + Space(1) + ' - Descrição: ' + 'B1_DESC' + Space(1) + ' - Valor unitário: ' + 'C6_PRCVEN' + Space(1) + ' - Valor total: ' + 'C6_VALOR' + Space(1) + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Pedidos de venda (maior valor) - ' + Space(1)  + 'Código: ' + &(cAlias)->(B1_COD) + Space(1) + ' - Descrição: ' + (B1_DESC) + Space(1) + ' - Valor unitário: ' + CValToChar(C6_PRCVEN) + Space(1) + ' - Valor total: ' + CValToChar(C6_VALOR) + Space(1) + CRLF + CRLF //CRLF -- pula linha      
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

