#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function ProcGrp
    Lista BD - Exercício 04
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function ProcGrp()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SB1, SBM" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SB1')

    DBSelectArea('SBM')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    /*SELECT DISTINCT B1_DESC, B1_GRUPO, BM_GRUPO  FROM SB1990 AS SB1
    INNER JOIN SBM990 AS SBM
    ON SB1.B1_GRUPO = SBM.BM_GRUPO
    AND SB1.D_E_L_E_T_ = '' AND SBM.D_E_L_E_T_ = ''
    WHERE SBM.BM_DESC = 'PELÍCULAS'*/

    cQuery := "SELECT DISTINCT B1_DESC, B1_GRUPO, BM_GRUPO FROM " + RETSQLNAME("SB1") + " AS SB1 "
    cQuery += "INNER JOIN " + RETSQLNAME("SBM") + " AS SBM "
    cQuery += "ON SB1.B1_GRUPO = SBM.BM_GRUPO "
    cQuery += "AND SB1.D_E_L_E_T_ = '' AND SBM.D_E_L_E_T_ = '' "
    cQuery += "WHERE SBM.BM_DESC = 'PELÍCULAS' "  

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Produtos do grupo: ' + Space(1) + 'B1_DESC' + Space(1) + ' - Grupo: ' + 'B1_GRUPO' + Space(1) + ' - Grupo: ' + 'BM_GRUPO' + Space(1) + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Produtos do grupo: ' + Space(1) + &(cAlias)->(B1_DESC) + Space(1) + ' - Grupo: ' + (B1_GRUPO) + Space(1) + ' - Grupo: ' + (BM_GRUPO) + Space(1) + CRLF + CRLF //CRLF -- pula linha      
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
