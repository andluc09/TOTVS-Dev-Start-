#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function ConsltPadr
    Lista BD - Exercício 06
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function ConsltPadr()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""
    Local cBusca    := ""
    Local cOk       := ""

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SB1" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SB1')

    DBSetOrder(1)

    DBGoTop()

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    cBusca := FWInputBox("Insira o código do produto a ser buscado: ", "Digite o código do produto.")

    /*SELECT DISTINCT B1_COD
    FROM SB1990 AS SB1
    WHERE 
    EXISTS(SELECT B1_COD FROM SB1990 WHERE SB1.B1_COD = '000001')*/

    cQuery := "SELECT DISTINCT B1_COD "
    cQuery += "FROM " + RETSQLNAME("SB1") + " AS SB1 "
    cQuery += "WHERE "
    cQuery += "EXISTS(SELECT B1_COD FROM SB1990 WHERE SB1.B1_COD = '" + cBusca + "') "

    TCQuery cQuery ALIAS &(cAlias) new
    
    while !(&(cAlias)->(EOF()))
        cOk += &(cAlias)->(B1_COD) 
        &(cAlias)->(DBSkip())
    enddo

    if(!Empty(cOk))

        /*SELECT DISTINCT B1_COD, B1_DESC, B1_PRV1 FROM SB1990 AS SB1
        WHERE SB1.D_E_L_E_T_ = ''*/

        cAlias := GETNEXTALIAS()

        cQuery := "SELECT DISTINCT B1_COD, B1_DESC, B1_PRV1 FROM " + RETSQLNAME("SB1") + " AS SB1 "
        cQuery += "WHERE SB1.B1_COD = '" + cBusca + "' AND SB1.D_E_L_E_T_ = '' "

        TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
        cMSG += 'Produto - Código: ' + Space(1) + 'B1_COD' + Space(1) + ' - Descrição: ' + 'B1_DESC' + Space(1) + 'Preço de Venda: ' + 'B1_PRV1' + Space(1) + CRLF + CRLF 

        while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
            cMSG += 'Produto - Código: ' + Space(1) + &(cAlias)->(B1_COD) + Space(1) + ' - Descrição: ' + (B1_DESC) + Space(1) + 'Preço de Venda: ' + CValToChar(B1_PRV1) + Space(1) + CRLF + CRLF //CRLF -- pula linha      
            &(cAlias)->(DBSkip()) //DB (Banco de Dados) SKIP (pular) pula linha até encontrar linha em branco: fim do arquivo
        end do
        &(cAlias)->(DBCloseArea()) //ENCERRA COMUNICAÇÃO COM SERVIDOR

        FWAlertInfo(cMSG, "<b> Query: </b>")

        TScrollArea(cMSG)

    else
        FWAlertWarning(" O código do produto informado não foi encontrado! ","ATENÇÃO")
    endif

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
