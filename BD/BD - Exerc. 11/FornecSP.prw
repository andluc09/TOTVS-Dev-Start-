#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function FornecSP
    Lista BD - Exercício 11
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function FornecSP()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SA2" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SA2')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    /*SELECT DISTINCT A2_NOME, A2_NREDUZ, A2_EST FROM SA2990 AS SA2
    WHERE A2_EST = 'SP'
    AND SA2.D_E_L_E_T_ = ''*/

    cQuery := "SELECT DISTINCT A2_NOME, A2_NREDUZ, A2_EST FROM " + RETSQLNAME("SA2") + " AS SA2 "
    cQuery += "WHERE A2_EST = 'SP' "
    cQuery += "AND SA2.D_E_L_E_T_ = '' "

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Fornecedores -' + Space(1) + " Nome: " + Space(1) + 'A2_NOME' + Space(1) + ' - Nome Fantasia: ' + 'A2_NREDUZ' + Space(1) + ' - Estado: ' + 'A2_EST' + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Fornecedores -' + Space(1) + " Nome: " + Space(1) + &(cAlias)->(A2_NOME) + Space(1) + ' - Nome Fantasia: ' + (A2_NREDUZ) + Space(1) + ' - Estado: ' + (A2_EST) + CRLF + CRLF //CRLF -- pula linha      
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
