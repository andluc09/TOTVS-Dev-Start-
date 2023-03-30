#INCLUDE 'TOTVS.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"

/*/{Protheus.doc} User Function PeriodVend
    Lista BD - Exercício 07
    @type  Function
    @author André Lucas M. Santos
    @since 21/03/2023
    @version 0.1
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=6063423
    @see https://tdn.totvs.com/display/tec/Comando+TCQUERY
/*/

User Function PeriodVend()

    Local cQuery    := "" 
    Local cAlias    := ""    
    Local cMSG      := ""
    Local cDtaIni   := ""
    Local cDtaFim   := ""    

    /* JOB */ PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "MDI" TABLES "SC5" /* Acompanha todo Ambiente Protheus: EMPRESA "_" FILIAL "_" MODULO "_" TABLES "_" */

    DBSelectArea('SC5')

    DBSetOrder(1)

    DBGoTop()

    cDtaIni := FWInputBox(' Insira um ano: ','0000')

    cDtaIni += FWInputBox(' Insira um mes: ','00')

    cDtaIni += FWInputBox(' Insira um dia: ','00')

    FWAlertInfo(CValToChar(cDtaIni), 'Data Inicial')

    cDtaFim := FWInputBox(' Insira um ano: ','0000')

    cDtaFim += FWInputBox(' Insira um mes: ','00')

    cDtaFim += FWInputBox(' Insira um dia: ','00')

    FWAlertInfo(CValToChar(cDtaFim), 'Data Final')

    cAlias := GETNEXTALIAS() //CTR+C e CTRL+V no SQL SERVER (Conexão Banco de Dados)

    /*SELECT C5_NUM, C5_TIPO, C5_CLIENTE FROM SC5990 AS SC5
    WHERE C5_EMISSAO BETWEEN '20220328' AND '20230328' -- Qual intervalo de Datas deseja filtrar? --
    AND SC5.D_E_L_E_T_ = ''*/

    cQuery := "SELECT C5_NUM, C5_TIPO, C5_CLIENTE, C5_EMISSAO FROM " + RETSQLNAME("SC5") + " AS SC5 "
    cQuery += "WHERE C5_EMISSAO BETWEEN '" + cDtaIni + "' AND '" + cDtaFim + "' "
    cQuery += "AND SC5.D_E_L_E_T_ = '' "

    TCQuery cQuery ALIAS &(cAlias) new //ESTABELECE COMUNICAÇÃO COM SERVIDOR
    cMSG += 'Pedido de Venda - Código: ' + Space(1) + 'C5_NUM' + Space(1) + ' - Tipo: ' + 'C5_TIPO' + Space(1) + ' - Cliente: ' + 'C5_CLIENTE' + Space(1) + ' - Data Emissão: ' + 'C5_EMISSAO' + Space(1) + CRLF + CRLF 

    while !(&(cAlias)->(EOF())) //EOF -- End Of File, percorre até o fim do arquivo
        cMSG += 'Pedido de Venda - Código: ' + Space(1) + &(cAlias)->(C5_NUM) + Space(1) + ' - Tipo: ' + (C5_TIPO) + Space(1) + ' - Cliente: ' + (C5_CLIENTE) + Space(1) + ' - Data Emissão: ' + (C5_EMISSAO) + Space(1) +  CRLF + CRLF //CRLF -- pula linha      
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

