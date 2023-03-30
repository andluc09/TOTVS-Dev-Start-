#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function ConsultaPedido
    Lista BD - Exercício 01
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function ConsultaPedido()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""
    Local nCont     := 1

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SC7, SA2" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SC7')

    DBSelectArea('SA2')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    /*SELECT DISTINCT C7_NUM, A2_NOME FROM SC7990 AS SC7
    INNER JOIN SA2990 AS SA2
    ON SC7.C7_FORNECE = SA2.A2_COD 
    AND SC7.D_E_L_E_T_ = '' AND SA2.D_E_L_E_T_ = ''
    WHERE A2_COD = 'F00004'*/

    cQuery := "SELECT DISTINCT C7_NUM, A2_NOME FROM " + RETSQLNAME("SC7") + " AS SC7 "
    cQuery += "INNER JOIN " + RETSQLNAME("SA2") + " AS SA2 "
    cQuery += "ON SC7.C7_FORNECE = SA2.A2_COD "
    cQuery += "AND SC7.D_E_L_E_T_ = '' AND SA2.D_E_L_E_T_ = '' "
    cQuery += "WHERE A2_COD = 'F00004' "

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Pedido ' + ' "n" ' + ': ' + Space(1) + 'C7_NUM' + Space(1) + ' - Fornecedor: ' + 'A2_NOME' + Space(1) + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Pedido ' + CValToChar(nCont++) + ': ' + Space(1) + &(cAlias)->(C7_NUM) + Space(1)+ ' - Fornecedor: ' + (A2_NOME) + Space(1) + CRLF + CRLF //CRLF -- pula linha      
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
