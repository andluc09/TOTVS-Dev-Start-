#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function CaroBarato
    Lista BD - Exercício 12
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function CaroBarato()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SC6" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SC6')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    /*
    ?Mais caro
    SELECT DISTINCT TOP 1 C6_PRODUTO, C6_DESCRI ,C6_PRCVEN FROM SC6990 AS SC6 
    WHERE SC6.D_E_L_E_T_ = ''
    ORDER BY C6_PRCVEN DESC

    ?Mais barato
    SELECT DISTINCT TOP 1 C6_PRODUTO,C6_DESCRI ,C6_PRCVEN FROM SC6990 AS SC6 
    WHERE SC6.D_E_L_E_T_ = ''
    ORDER BY C6_PRCVEN ASC

    ?Mais caro .E. Mais barato
    SELECT DISTINCT MAX(C6_PRCVEN) AS PRECO_MAIOR, MIN(C6_PRCVEN) AS PRECO_MENOR FROM SC6990 AS SC6 
    WHERE SC6.D_E_L_E_T_ = ''*/

    cQuery := "SELECT DISTINCT TOP 1 C6_PRODUTO, C6_DESCRI ,C6_PRCVEN FROM " + RETSQLNAME("SC6") + " AS SC6 "
    cQuery += "WHERE SC6.D_E_L_E_T_ = '' "
    cQuery += "ORDER BY C6_PRCVEN DESC "

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Produto caro: ' + Space(1) + 'C6_PRODUTO' + Space(1) + ' - Descrição: ' + 'C6_DESCRI' + Space(1) + ' - Preço Unitário: ' + 'C6_PRCVEN' + CRLF + CRLF

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Produto caro: ' + Space(1) + &(cAlias)->(C6_PRODUTO) + Space(1) + ' - Descrição: ' + (C6_DESCRI) + Space(1) + ' - Preço Unitário: ' + CValToChar(C6_PRCVEN) + CRLF + CRLF + CRLF + CRLF //CRLF -- pula linha      
        &(cAlias)->(DBSkip()) //DB (Banco de Dados) SKIP (pular) pula linha até encontrar linha em branco: fim do arquivo
    end do

    cAlias := GETNEXTALIAS()

    cQuery := "SELECT DISTINCT TOP 1 C6_PRODUTO,C6_DESCRI ,C6_PRCVEN FROM " + RETSQLNAME("SC6") + " AS SC6 "
    cQuery += "WHERE SC6.D_E_L_E_T_ = '' "
    cQuery += "ORDER BY C6_PRCVEN ASC "

    cAlias := GETNEXTALIAS()

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Produto barato: ' + Space(1) + 'C6_PRODUTO' + Space(1) + ' - Descrição: ' + 'C6_DESCRI' + Space(1) + ' - Preço Unitário: ' + 'C6_PRCVEN' + CRLF + CRLF

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Produto barato: ' + Space(1) + &(cAlias)->(C6_PRODUTO) + Space(1) + ' - Descrição: ' + (C6_DESCRI) + Space(1) + ' - Preço Unitário: ' + CValToChar(C6_PRCVEN) + CRLF + CRLF + CRLF + CRLF //CRLF -- pula linha      
        &(cAlias)->(DBSkip()) //DB (Banco de Dados) SKIP (pular) pula linha até encontrar linha em branco: fim do arquivo
    end do

    cAlias := GETNEXTALIAS()

    cQuery := "SELECT DISTINCT MAX(C6_PRCVEN) AS PRECO_MAIOR, MIN(C6_PRCVEN) AS PRECO_MENOR FROM " + RETSQLNAME("SC6") + " AS SC6 "
    cQuery += "WHERE SC6.D_E_L_E_T_ = '' "    

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Produto caro: ' + Space(1) + 'PRECO_MAIOR' + Space(1) + ' - Produto barato: ' + 'PRECO_MENOR' + Space(1) + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Produto caro: ' + Space(1) + &(cAlias)->(CValToChar(PRECO_MAIOR)) + Space(1) + ' - Produto barato: ' + CValToChar(PRECO_MENOR) + Space(1) + CRLF + CRLF + CRLF + CRLF //CRLF -- pula linha      
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
